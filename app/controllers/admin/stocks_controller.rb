class Admin::StocksController < AdminController
  before_action :set_admin_stock, only: %i[ show edit update destroy ]

  def index
    @product = Product.find(params[:product_id])
    @admin_stocks = @product.stocks
  end

  def show
  end

  def new
    @product = Product.find(params[:product_id])
    @admin_stock = Stock.new
  end

  def edit
    @product = Product.find(params[:product_id])
    @admin_stock = Stock.find(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    @admin_stock = Stock.new(admin_stock_params)

    @admin_stock.product = @product

    respond_to do |format|
      if @admin_stock.save
        format.html { redirect_to [ :admin, @product, @admin_stock ], notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @admin_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_stock.update(admin_stock_params)
        format.html { redirect_to [ :admin, :product, @admin_stock ], notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_stock.destroy!

    respond_to do |format|
      format.html { redirect_to admin_stocks_path, status: :see_other, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_stock
      @admin_stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_stock_params
      params.require(:stock).permit(:amount, :size)
    end
end
