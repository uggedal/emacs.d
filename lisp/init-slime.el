(require-package 'slime)
;; package.el compiles the contrib subdir, but the compilation order
;; causes problems, so we remove the .elc files there. See
;; http://lists.common-lisp.net/pipermail/slime-devel/2012-February/018470.html
(mapc #'delete-file
      (file-expand-wildcards (concat user-emacs-directory "elpa/slime-2*/contrib/*.elc")))

(require-package 'hippie-expand-slime)


;;; Lisp buffers

(defun jcf/slime-setup ()
  "Mode setup function for slime lisp buffers."
  (set-up-slime-hippie-expand)
  (set-up-slime-ac t))

(after-load 'slime
  (setq slime-protocol-version 'ignore)
  (setq slime-net-coding-system 'utf-8-unix)
  (slime-setup '(slime-repl slime-fuzzy))
  (setq slime-complete-symbol*-fancy t)
  (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
  (add-hook 'slime-mode-hook 'jcf/slime-setup))


;;; REPL

(defun jcf/slime-repl-setup ()
  "Mode setup function for slime REPL."
  (jcf/lisp-setup)
  (set-up-slime-hippie-expand)
  (set-up-slime-ac t)
  (setq show-trailing-whitespace nil))

(after-load 'slime-repl
  ;; Bind TAB to `indent-for-tab-command', as in regular Slime buffers.
  (define-key slime-repl-mode-map (kbd "TAB") 'indent-for-tab-command)

  (add-hook 'slime-repl-mode-hook 'jcf/slime-repl-setup))


(provide 'init-slime)
