(module+ test
  (require rackunit)

  (let ((a 7)
        (b 13))
    (check-dual-equal? (+ a b) 20)
    (check-dual-equal? ((∇¹ +) a b) (list 1.0 1.0))
    (check-dual-equal? (* a b) 91)
    (check-dual-equal? ((∇¹ *) a b) (list 13.0 7.0))
    (check-dual-equal? (/ a b) 7/13)
    (check-dual-equal? ((∇¹ /) a b) (list 0.07692 -0.04142)))

  (let ((a (tensor 7))
        (b (tensor 13)))
    (check-dual-equal? (+ a b) (tensor 20))
    (check-dual-equal? ((∇¹ +) a b) (list (tensor 1.0) (tensor 1.0)))
    (check-dual-equal? (* a b) (tensor 91))
    (check-dual-equal? ((∇¹ *) a b) (list (tensor 13.0) (tensor 7.0)))
    (check-dual-equal? (/ a b) (tensor 7/13))
    (check-dual-equal? ((∇¹ /) a b) (list (tensor 0.07692) (tensor -0.04142))))

  (let ((a 7)
        (b (tensor 13)))
    (check-dual-equal? (+ a b) (tensor 20))
    (check-dual-equal? ((∇¹ +) a b) (list 1.0 (tensor 1.0)))
    (check-dual-equal? (* a b) (tensor 91))
    (check-dual-equal? ((∇¹ *) a b) (list 13.0 (tensor 7.0)))
    (check-dual-equal? (/ a b) (tensor 7/13))
    (check-dual-equal? ((∇¹ /) a b) (list 0.07692 (tensor -0.04142))))

  (let ((a 7)
        (b (tensor 13 15)))
    (check-dual-equal? (+ a b) (tensor 20 22))
    (check-dual-equal? ((∇¹ +) a b) (list 2.0 (tensor 1.0 1.0)))
    (check-dual-equal? (* a b) (tensor 91 105))
    (check-dual-equal? ((∇¹ *) a b) (list 28.0 (tensor 7.0 7.0)))
    (check-dual-equal? (/ a b) (tensor 7/13 7/15))
    (check-dual-equal? ((∇¹ /) a b) (list 0.14358
                                          (tensor -0.04142 -0.03111))))

  (let ((a (tensor 7 8 9)))
    (check-dual-equal? (exp a) (tensor 1096.6331 2980.9579 8103.0839))
    (check-dual-equal? ((∇¹ exp) a)
                       (list (tensor 1096.6331 2980.9579 8103.0839)))
    (check-dual-equal? (log a) (tensor 1.9459 2.0794 2.1972))
    (check-dual-equal? ((∇¹ log) a) (list (tensor 0.1428 0.125 0.1111)))
    (check-dual-equal? (sqrt a) (tensor 2.6457 2.8284 3.0))
    (check-dual-equal? ((∇¹ sqrt) a) (list (tensor 0.1889 0.1767 0.1667)))
    )

  (let ((t2 (tensor (tensor 3 4 5)
                    (tensor 7 8 9)))
        (t1 (tensor 4 5 6)))

    (check-dual-equal? (dot-product t1 t1)
                       77)

    (check-dual-equal? (*-2-1 t2 (tensor (tensor 4 5 6) (tensor 4 5 6) (tensor 4 5 6)))
                       (tensor (tensor (tensor 12 20 30)
                                       (tensor 28 40 54))
                               (tensor (tensor 12 20 30)
                                       (tensor 28 40 54))
                               (tensor (tensor 12 20 30)
                                       (tensor 28 40 54))))

    (check-dual-equal? (dot-product-2-1 t2 t1)
                       (tensor 62 122))

    (check-dual-equal? (sqr t2)
                       (tensor (tensor 9 16 25)
                               (tensor 49 64 81)))))
