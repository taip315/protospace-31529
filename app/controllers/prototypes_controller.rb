class PrototypesController < ApplicationController
  before_action :get_prototype, only:[:edit,:show]
  before_action :authenticate_user!, only:[:new,:edit]
  before_action :redirect_root, only: :edit

  def index
    @prototypes =Prototype. includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    prototype = Prototype.new(prototype_params)
    if prototype.save
     redirect_to root_path
    else
      render "new"
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit

  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      redirect_to prototype_path(prototype.id)
    else
      render "edit"
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept ,:image).merge(user_id: current_user.id)
  end

  def get_prototype
    @prototype = Prototype.find(params[:id])
  end

  def redirect_root
    unless user_signed_in? && (current_user.id == @prototype.user.id)
      redirect_to root_path 
    end
  end

end
