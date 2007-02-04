From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (take 2)] git-blame.el --- Minor mode for incremental blame for Git
Date: Sun, 4 Feb 2007 21:14:33 +0100
Message-ID: <200702042114.34922.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kagedal <davidk@lysator.liu.se>,
	Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 21:13:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDnjw-0004iz-HR
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 21:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbXBDUNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 15:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXBDUNN
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 15:13:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:44607 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbXBDUNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 15:13:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1144976uga
        for <git@vger.kernel.org>; Sun, 04 Feb 2007 12:13:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ed7kCjGeqjAZ3JsRYVJhZsoqy0MTmWr3+gm6MSX7LH89OZVLxtWKaQs2kL3y1VJvaexfyhOeC9Q03j6Joh6XvlkuYJqKj1Ks9Ohkrvg1dFNdCKzjYAf/wpFLNnhM6EnClj5vem4NMGnqs+nXlv8weqhFw7E+zIOvZ/+thM0b6r0=
Received: by 10.67.119.9 with SMTP id w9mr7786294ugm.1170619990123;
        Sun, 04 Feb 2007 12:13:10 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id o24sm9214640ugd.2007.02.04.12.13.08;
        Sun, 04 Feb 2007 12:13:09 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38706>

Here is an Emacs implementation of incremental git-blame.  When you
turn it on while viewing a file, the editor buffer will be updated by
setting the background of individual lines to a color that reflects
which commit it comes from.  And when you move around the buffer, a
one-line summary will be shown in the echo area.

Created by David K=C3=A5gedal, header and comments added by Jakub Nar=C4=
=99bski.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
This time I hope in proper utf-8 encoding.

Here it is as a proper git patch, and with some headers and comments
added. As compared to latest version sent by David K=C3=A5gedal,
  Message-ID: <87iren2vqx.fsf@morpheus.local>
  http://permalink.gmane.org/gmane.comp.version-control.git/38246
it has elisp header and description by David K=C3=A5gedal, has (require=
 'cl)
with explanation added, and (provide 'git-blame) at the end; no other
changes (as of now).

David, is it released as GPL? If it is, GPL boilerplate (as in git.el)
could be added to the header.

 contrib/emacs/git-blame.el |  222 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 222 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
new file mode 100644
index 0000000..fa89889
--- /dev/null
+++ b/contrib/emacs/git-blame.el
@@ -0,0 +1,222 @@
+;;; git-blame.el --- Minor mode for incremental blame for Git  -*- cod=
ing: utf-8 -*-
+;;
+;; Copyright (C) 2007 by David K=C3=A5gedal
+;;
+;; Authors:    David K=C3=A5gedal <davidk@lysator.liu.se>
+;; Created:    31 Jan 2007
+;; Keywords:   git, version control, release management
+;;
+;; Compatibility: Emacs21
+
+;;; Commentary:
+;;
+;; Here is an Emacs implementation of incremental git-blame.  When you
+;; turn it on while viewing a file, the editor buffer will be updated =
by
+;; setting the background of individual lines to a color that reflects
+;; which commit it comes from.  And when you move around the buffer, a
+;; one-line summary will be shown in the echo area.
+
+;;; Installation:
+;;
+;;  1) Load into emacs: M-x load-file RET git-blame.el RET
+;;  2) Open a git-controlled file
+;;  3) Blame: M-x git-blame-mode
+
+;;; Compatibility:
+;;
+;; It requires GNU Emacs 21.  If you'are using Emacs 20, try
+;; changing this:
+;;
+;;            (overlay-put ovl 'face (list :background
+;;                                         (cdr (assq 'color (cddddr i=
nfo)))))
+;;
+;; to
+;;
+;;            (overlay-put ovl 'face (cons 'background-color
+;;                                         (cdr (assq 'color (cddddr i=
nfo)))))
+
+
+;;; Code:
+
+(require 'cl)			      ; to use `cddddr', `push', `pop'
+
+(defun color-scale (l)
+  (let* ((colors ())
+         r g b)
+    (setq r l)
+    (while r
+      (setq g l)
+      (while g
+        (setq b l)
+        (while b
+          (push (concat "#" (car r) (car g) (car b)) colors)
+          (pop b))
+        (pop g))
+      (pop r))
+    colors))
+
+(defvar git-blame-dark-colors
+  (color-scale '("00" "04" "08" "0c"
+                 "10" "14" "18" "1c"
+                 "20" "24" "28" "2c"
+                 "30" "34" "38" "3c")))
+
+(defvar git-blame-light-colors
+  (color-scale '("c0" "c4" "c8" "cc"
+                 "d0" "d4" "d8" "dc"
+                 "e0" "e4" "e8" "ec"
+                 "f0" "f4" "f8" "fc")))
+
+(defvar git-blame-ancient-color "dark green")
+
+(defvar git-blame-overlays nil)
+(defvar git-blame-cache nil)
+
+(defvar git-blame-mode nil)
+(make-variable-buffer-local 'git-blame-mode)
+(push (list 'git-blame-mode " blame") minor-mode-alist)
+
+(defun git-blame-mode (&optional arg)
+  (interactive "P")
+  (if arg
+      (setq git-blame-mode (eq arg 1))
+    (setq git-blame-mode (not git-blame-mode)))
+  (make-local-variable 'git-blame-overlays)
+  (make-local-variable 'git-blame-colors)
+  (make-local-variable 'git-blame-cache)
+   (let ((bgmode (cdr (assoc 'background-mode (frame-parameters)))))
+    (if (eq bgmode 'dark)
+        (setq git-blame-colors git-blame-dark-colors)
+      (setq git-blame-colors git-blame-light-colors)))
+  (if git-blame-mode
+      (git-blame-run)
+    (git-blame-cleanup)))
+
+(defun git-blame-run ()
+  (let* ((display-buf (current-buffer))
+         (blame-buf (get-buffer-create
+                     (concat " git blame for " (buffer-name))))
+         (proc (start-process "git-blame" blame-buf
+                             "git" "blame" "--incremental"
+                             (file-name-nondirectory buffer-file-name)=
)))
+    (mapcar 'delete-overlay git-blame-overlays)
+    (setq git-blame-overlays nil)
+    (setq git-blame-cache (make-hash-table :test 'equal))
+    (with-current-buffer blame-buf
+      (erase-buffer)
+      (make-local-variable 'git-blame-file)
+      (make-local-variable 'git-blame-current)
+      (setq git-blame-file display-buf)
+      (setq git-blame-current nil))
+    (set-process-filter proc 'git-blame-filter)
+    (set-process-sentinel proc 'git-blame-sentinel)))
+
+(defun git-blame-cleanup ()
+  "Remove all blame properties"
+    (mapcar 'delete-overlay git-blame-overlays)
+    (setq git-blame-overlays nil)
+    (let ((modified (buffer-modified-p)))
+      (remove-text-properties (point-min) (point-max) '(point-entered =
nil))
+      (set-buffer-modified-p modified)))
+
+
+(defun git-blame-sentinel (proc status)
+  ;;(kill-buffer (process-buffer proc))
+  (message "git blame finished"))
+
+(defvar in-blame-filter nil)
+
+(defun git-blame-filter (proc str)
+  (save-excursion
+    (set-buffer (process-buffer proc))
+    (goto-char (process-mark proc))
+    (insert-before-markers str)
+    (goto-char 0)
+    (unless in-blame-filter
+      (let ((more t)
+            (in-blame-filter t))
+        (while more
+          (setq more (git-blame-parse)))))))
+
+(defun git-blame-parse ()
+  (cond ((looking-at "\\([0-9a-f]\\{40\\}\\) \\([0-9]+\\) \\([0-9]+\\)=
 \\([0-9]+\\)\n")
+         (let ((hash (match-string 1))
+               (src-line (string-to-number (match-string 2)))
+               (res-line (string-to-number (match-string 3)))
+               (num-lines (string-to-number (match-string 4))))
+           (setq git-blame-current
+                 (git-blame-new-commit
+                  hash src-line res-line num-lines)))
+         (delete-region (point) (match-end 0))
+         t)
+        ((looking-at "filename \\(.+\\)\n")
+         (let ((filename (match-string 1)))
+           (git-blame-add-info "filename" filename))
+         (delete-region (point) (match-end 0))
+         t)
+        ((looking-at "\\([a-z-]+\\) \\(.+\\)\n")
+         (let ((key (match-string 1))
+               (value (match-string 2)))
+           (git-blame-add-info key value))
+         (delete-region (point) (match-end 0))
+         t)
+        ((looking-at "boundary\n")
+         (setq git-blame-current nil)
+         (delete-region (point) (match-end 0))
+         t)
+        (t
+         nil)))
+
+
+(defun git-blame-new-commit (hash src-line res-line num-lines)
+  (save-excursion
+    (set-buffer git-blame-file)
+    (let ((info (gethash hash git-blame-cache))
+          (inhibit-point-motion-hooks t))
+      (when (not info)
+        (let ((color (pop git-blame-colors)))
+          (unless color
+            (setq color git-blame-ancient-color))
+          (setq info (list hash src-line res-line num-lines
+                           (cons 'color color))))
+        (puthash hash info git-blame-cache))
+      (goto-line res-line)
+      (while (> num-lines 0)
+        (if (get-text-property (point) 'git-blame)
+            (forward-line)
+          (let* ((start (point))
+                 (end (progn (forward-line 1) (point)))
+                 (ovl (make-overlay start end)))
+            (push ovl git-blame-overlays)
+            (overlay-put ovl 'git-blame info)
+            (overlay-put ovl 'help-echo hash)
+            (overlay-put ovl 'face (list :background
+                                         (cdr (assq 'color (cddddr inf=
o)))))
+            ;;(overlay-put ovl 'point-entered
+            ;;             `(lambda (x y) (git-blame-identify ,hash)))
+            (let ((modified (buffer-modified-p)))
+              (put-text-property (if (=3D start 1) start (1- start)) (=
1- end)
+                                 'point-entered
+                                 `(lambda (x y) (git-blame-identify ,h=
ash)))
+              (set-buffer-modified-p modified))))
+        (setq num-lines (1- num-lines))))))
+
+(defun git-blame-add-info (key value)
+  (if git-blame-current
+      (nconc git-blame-current (list (cons (intern key) value)))))
+
+(defun git-blame-current-commit ()
+  (let ((info (get-char-property (point) 'git-blame)))
+    (if info
+        (car info)
+      (error "No commit info"))))
+
+(defun git-blame-identify (&optional hash)
+  (interactive)
+  (shell-command
+   (format "git log -1 --pretty=3Doneline %s" (or hash
+                                                (git-blame-current-com=
mit)))))
+
+(provide 'git-blame)
+
+;;; git-blame.el ends here
--=20
1.4.4.4
