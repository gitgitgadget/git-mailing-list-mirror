From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: git-blame.el
Date: Wed, 31 Jan 2007 14:04:06 +0100
Message-ID: <87iren2vqx.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 14:05:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCF9S-0000QB-Ly
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 14:05:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232AbXAaNFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 08:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933235AbXAaNFX
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 08:05:23 -0500
Received: from main.gmane.org ([80.91.229.2]:42286 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933232AbXAaNFW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 08:05:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCF8y-0005ua-9Z
	for git@vger.kernel.org; Wed, 31 Jan 2007 14:04:56 +0100
Received: from oden.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 14:04:56 +0100
Received: from davidk by oden.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 14:04:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oden.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:fBoguP8f5KKj2/dzR6WQ8zkHfiQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38246>

Here's another version of git-blame.el that automatically tries to
create a sensible list of colors to use for both light and dark
backgrounds.  Plus a few minor fixes.

To use:

  1) Load into emacs: M-x load-file RET git-blame.el RET
  2) Open a git-controlled file
  3) Blame: M-x git-blame-mode

;;; git-blame.el
;; David K=C3=A5gedal

(defun color-scale (l)
  (let* ((colors ())
         r g b)
    (setq r l)
    (while r
      (setq g l)
      (while g
        (setq b l)
        (while b
          (push (concat "#" (car r) (car g) (car b)) colors)
          (pop b))
        (pop g))
      (pop r))
    colors))

(defvar git-blame-dark-colors
  (color-scale '("00" "04" "08" "0c"
                 "10" "14" "18" "1c"
                 "20" "24" "28" "2c"
                 "30" "34" "38" "3c")))

(defvar git-blame-light-colors
  (color-scale '("c0" "c4" "c8" "cc"
                 "d0" "d4" "d8" "dc"
                 "e0" "e4" "e8" "ec"
                 "f0" "f4" "f8" "fc")))

(defvar git-blame-ancient-color "dark green")

(defvar git-blame-overlays nil)
(defvar git-blame-cache nil)

(defvar git-blame-mode nil)
(make-variable-buffer-local 'git-blame-mode)
(push (list 'git-blame-mode " blame") minor-mode-alist)

(defun git-blame-mode (&optional arg)
  (interactive "P")
  (if arg
      (setq git-blame-mode (eq arg 1))
    (setq git-blame-mode (not git-blame-mode)))
  (make-local-variable 'git-blame-overlays)
  (make-local-variable 'git-blame-colors)
  (make-local-variable 'git-blame-cache)
  (let ((bgmode (cdr (assoc 'background-mode (frame-parameters)))))
    (if (eq bgmode 'dark)
        (setq git-blame-colors git-blame-dark-colors)
      (setq git-blame-colors git-blame-light-colors)))
  (if git-blame-mode
      (git-blame-run)
    (git-blame-cleanup)))

(defun git-blame-run ()
  (let* ((display-buf (current-buffer))
         (blame-buf (get-buffer-create
                     (concat " git blame for " (buffer-name))))
         (proc (start-process "git-blame" blame-buf
                             "git" "blame" "--incremental"
                             (file-name-nondirectory buffer-file-name))=
))
    (mapcar 'delete-overlay git-blame-overlays)
    (setq git-blame-overlays nil)
    (setq git-blame-cache (make-hash-table :test 'equal))
    (with-current-buffer blame-buf
      (erase-buffer)
      (make-local-variable 'git-blame-file)
      (make-local-variable 'git-blame-current)
      (setq git-blame-file display-buf)
      (setq git-blame-current nil))
    (set-process-filter proc 'git-blame-filter)
    (set-process-sentinel proc 'git-blame-sentinel)))

(defun git-blame-cleanup ()
  "Remove all blame properties"
    (mapcar 'delete-overlay git-blame-overlays)
    (setq git-blame-overlays nil)
    (let ((modified (buffer-modified-p)))
      (remove-text-properties (point-min) (point-max) '(point-entered n=
il))
      (set-buffer-modified-p modified)))
   =20

(defun git-blame-sentinel (proc status)
  ;;(kill-buffer (process-buffer proc))
  (message "git blame finished"))

(defvar in-blame-filter nil)

(defun git-blame-filter (proc str)
  (save-excursion
    (set-buffer (process-buffer proc))
    (goto-char (process-mark proc))
    (insert-before-markers str)
    (goto-char 0)
    (unless in-blame-filter
      (let ((more t)
            (in-blame-filter t))
        (while more
          (setq more (git-blame-parse)))))))

(defun git-blame-parse ()
  (cond ((looking-at "\\([0-9a-f]\\{40\\}\\) \\([0-9]+\\) \\([0-9]+\\) =
\\([0-9]+\\)\n")
         (let ((hash (match-string 1))
               (src-line (string-to-number (match-string 2)))
               (res-line (string-to-number (match-string 3)))
               (num-lines (string-to-number (match-string 4))))
           (setq git-blame-current
                 (git-blame-new-commit
                  hash src-line res-line num-lines)))
         (delete-region (point) (match-end 0))
         t)
        ((looking-at "filename \\(.+\\)\n")
         (let ((filename (match-string 1)))
           (git-blame-add-info "filename" filename))
         (delete-region (point) (match-end 0))
         t)
        ((looking-at "\\([a-z-]+\\) \\(.+\\)\n")
         (let ((key (match-string 1))
               (value (match-string 2)))
           (git-blame-add-info key value))
         (delete-region (point) (match-end 0))
         t)
        ((looking-at "boundary\n")
         (setq git-blame-current nil)
         (delete-region (point) (match-end 0))
         t)
        (t
         nil)))


(defun git-blame-new-commit (hash src-line res-line num-lines)
  (save-excursion
    (set-buffer git-blame-file)
    (let ((info (gethash hash git-blame-cache))
          (inhibit-point-motion-hooks t))
      (when (not info)
        (let ((color (pop git-blame-colors)))
          (unless color
            (setq color git-blame-ancient-color))
          (setq info (list hash src-line res-line num-lines
                           (cons 'color color))))
        (puthash hash info git-blame-cache))
      (goto-line res-line)
      (while (> num-lines 0)
        (if (get-text-property (point) 'git-blame)
            (forward-line)
          (let* ((start (point))
                 (end (progn (forward-line 1) (point)))
                 (ovl (make-overlay start end)))
            (push ovl git-blame-overlays)
            (overlay-put ovl 'git-blame info)
            (overlay-put ovl 'help-echo hash)
            (overlay-put ovl 'face (list :background
                                         (cdr (assq 'color (cddddr info=
)))))
            ;;(overlay-put ovl 'point-entered
            ;;             `(lambda (x y) (git-blame-identify ,hash)))
            (let ((modified (buffer-modified-p)))
              (put-text-property (if (=3D start 1) start (1- start)) (1=
- end)
                                 'point-entered
                                 `(lambda (x y) (git-blame-identify ,ha=
sh)))
              (set-buffer-modified-p modified))))
        (setq num-lines (1- num-lines))))))

(defun git-blame-add-info (key value)
  (if git-blame-current
      (nconc git-blame-current (list (cons (intern key) value)))))

(defun git-blame-current-commit ()
  (let ((info (get-char-property (point) 'git-blame)))
    (if info
        (car info)
      (error "No commit info"))))

(defun git-blame-identify (&optional hash)
  (interactive)
  (shell-command
   (format "git log -1 --pretty=3Doneline %s" (or hash
                                                (git-blame-current-comm=
it)))))

--=20
David K=C3=A5gedal
