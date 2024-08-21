function love.load()
    width, height = love.graphics.getDimensions()
    xBola, yBola, r = 100, 100, 10
    xJoy, yJoy = 0, 0
    
    xFix = width - 100
    yFix = height - 100
    xMov = width - 100
    yMov = height - 100
    raioDentro = 20.0
    raioFora = 60.0
    joyAxis = {}
    vetorDirecao = {xBola, yBola, xBola + 2, yBola + 2}
    joyAxis = {xJoy, yJoy}
end

function love.update(dt)
    
    if love.keyboard.isDown("w") then
        yBola = yBola - 200 * dt
    end
    if love.keyboard.isDown("s") then
        yBola = yBola + 200 * dt
    end
    if love.keyboard.isDown("d") then
        xBola = xBola + 200 * dt
    end
    if love.keyboard.isDown("a") then
        xBola = xBola - 200 * dt
    end

    -- Joystick
    funcionaJoystick()
end

function love.draw()
	love.graphics.line(vetorDirecao)
	
	love.graphics.setColor(0, 1, 0)
    love.graphics.circle("fill", xBola, yBola, r)
    love.graphics.circle("line", xBola, yBola, r * 3)
    
    -- debug
    love.graphics.print(string.format("x:%.1f",joyAxis[1]), 100, 100)
    love.graphics.print(string.format("y:%.1f",joyAxis[2]), 100, 130)
    love.graphics.setColor(1, 1, 1)
    -- Joystick desenho
	love.graphics.circle("fill", xMov, yMov, raioDentro)
    love.graphics.circle("line", xFix, yFix, raioFora)
end

function funcionaJoystick()
	local touches = love.touch.getTouches()
	
    for i, id in ipairs(touches) do
        local x, y = love.touch.getPosition(id)
        
        local versor = ((x - xFix)^2 + (y - yFix)^2)^0.5
        
        if (((x - xFix)^2 + (y - yFix)^2) ^ 0.5) < raioFora then
        	xMov = x
        	yMov = y
        	joyAxis[1] = (xFix - x) / -raioFora
        	joyAxis[2] = (yFix - y) / -raioFora
        else
        	joyAxis[1] = (xFix - x) / -versor
        	joyAxis[2] = (yFix - y) / -versor
        	xMov = ((xFix - x) / versor) * -raioFora + xFix
        	yMov = ((yFix - y) / versor) * -raioFora + yFix
        end
    end
    if not (#touches >= 1) then
    	xMov = xFix
    	yMov = yFix
    	joyAxis[1] = 0
    	joyAxis[2] = 0
    end
end
