From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH] git-blame.el: pick a set of random colors for each git-blame turn
Date: Tue, 27 Mar 2007 23:51:52 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703272151.l2RLpqD7012317@localhost.localdomain>
References: <87bqifrs7r.fsf@morpheus.local>
Reply-To: Xavier Maillard <zedek@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, zedek@gnu.org
To: davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Wed Mar 28 00:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWKZF-0001JF-5R
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 00:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbXC0WzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 18:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933258AbXC0WzA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 18:55:00 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:50810 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933247AbXC0Wy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 18:54:59 -0400
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id DD55538234;
	Wed, 28 Mar 2007 00:54:57 +0200 (CEST)
Received: from localhost.localdomain (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l2RLpr7Y012320;
	Tue, 27 Mar 2007 23:51:58 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2RLpqD7012317;
	Tue, 27 Mar 2007 23:51:52 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
In-Reply-To: <87bqifrs7r.fsf@morpheus.local>
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43316>


I thought it would be cool to have different set of colors for each
git-blame-mode. Function `git-blame-new-commit' does this for us
picking when possible, a random colors based on the set we build on
startup. When it fails, `git-blame-ancient-color' will be used. We
also take care not to use the same color more than once (thank you
David K=C3=A5gedal).

* Prevent (future possible) namespace clash by renaming `color-scale'
into `git-blame-color-scale'. Definition has been changed to be more
in the "lisp" way (thanks for help to #emacs). Also added a small
description of what it does.

* Added docstrings at some point and instructed defvar when a variable
was candidate to customisation by users.

* Added missing defvar to silent byte-compilers (git-blame-file,
git-blame-current)

* Do not require 'cl at startup

* Added more informations on compatibility

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/git-blame.el |   82 ++++++++++++++++++++++++++++--------=
--------
 1 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index bd87a86..4703442 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -8,8 +8,8 @@
 ;; License:    GPL
 ;; Keywords:   git, version control, release management
 ;;
-;; Compatibility: Emacs21
-
+;; Compatibility: Emacs21, Emacs22 and EmacsCVS
+;;                Git 1.5 and up
=20
 ;; This file is *NOT* part of GNU Emacs.
 ;; This file is distributed under the same terms as GNU Emacs.
@@ -61,8 +61,9 @@
=20
 ;;; Compatibility:
 ;;
-;; It requires GNU Emacs 21.  If you'are using Emacs 20, try
-;; changing this:
+;; It requires GNU Emacs 21 or later and Git 1.5.0 and up
+;;=20
+;; If you'are using Emacs 20, try changing this:
 ;;
 ;;            (overlay-put ovl 'face (list :background
 ;;                                         (cdr (assq 'color (cddddr i=
nfo)))))
@@ -77,30 +78,43 @@
 ;;
 ;;; Code:
=20
-(require 'cl)			      ; to use `push', `pop'
-
-(defun color-scale (l)
-  (let* ((colors ())
-         r g b)
-    (setq r l)
-    (while r
-      (setq g l)
-      (while g
-        (setq b l)
-        (while b
-          (push (concat "#" (car r) (car g) (car b)) colors)
-          (pop b))
-        (pop g))
-      (pop r))
-    colors))
+(eval-when-compile (require 'cl))			      ; to use `push', `pop'
+
+
+(defun git-blame-color-scale (&rest elements)
+  "Given a list, returns a list of triples formed with each
+elements of the list.
+
+a b =3D> bbb bba bab baa abb aba aaa aab"
+  (let (result)
+    (dolist (a elements)
+      (dolist (b elements)
+        (dolist (c elements)
+          (setq result (cons (format "#%s%s%s" a b c) result)))))
+    result))
+
+;; (git-blame-color-scale "0c" "04" "24" "1c" "2c" "34" "14" "3c") =3D=
>
+;; ("#3c3c3c" "#3c3c14" "#3c3c34" "#3c3c2c" "#3c3c1c" "#3c3c24"
+;; "#3c3c04" "#3c3c0c" "#3c143c" "#3c1414" "#3c1434" "#3c142c" ...)
=20
 (defvar git-blame-dark-colors
-  (color-scale '("0c" "04" "24" "1c" "2c" "34" "14" "3c")))
+  (git-blame-color-scale "0c" "04" "24" "1c" "2c" "34" "14" "3c")
+  "*List of colors (format #RGB) to use in a dark environment.
+
+To check out the list, evaluate (list-colors-display git-blame-dark-co=
lors).")
=20
 (defvar git-blame-light-colors
-  (color-scale '("c4" "d4" "cc" "dc" "f4" "e4" "fc" "ec")))
+  (git-blame-color-scale "c4" "d4" "cc" "dc" "f4" "e4" "fc" "ec")
+  "*List of colors (format #RGB) to use in a light environment.
+
+To check out the list, evaluate (list-colors-display git-blame-light-c=
olors).")
=20
-(defvar git-blame-ancient-color "dark green")
+(defvar git-blame-colors '()
+  "Colors used by git-blame. The list is built once when activating gi=
t-blame
+minor mode.")
+ =20
+(defvar git-blame-ancient-color "dark green"
+  "*Color to be used for ancient commit.")
=20
 (defvar git-blame-autoupdate t
   "*Automatically update the blame display while editing")
@@ -125,6 +139,10 @@
   "A queue of update requests")
 (make-variable-buffer-local 'git-blame-update-queue)
=20
+;; FIXME: docstrings
+(defvar git-blame-file nil)
+(defvar git-blame-current nil)
+
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
=20
@@ -177,7 +195,7 @@ See also function `git-blame-mode'."
   "Recalculate all blame information in the current buffer"
   (interactive)
   (unless git-blame-mode
-    (error "git-blame is not active"))
+    (error "Git-blame is not active"))
  =20
   (git-blame-cleanup)
   (git-blame-run))
@@ -294,18 +312,22 @@ See also function `git-blame-mode'."
         (t
          nil)))
=20
-
 (defun git-blame-new-commit (hash src-line res-line num-lines)
   (save-excursion
     (set-buffer git-blame-file)
     (let ((info (gethash hash git-blame-cache))
           (inhibit-point-motion-hooks t)
-          (inhibit-modification-hooks t))
+          (inhibit-modification-hooks t)
+	  (colors git-blame-colors))
       (when (not info)
-        (let ((color (pop git-blame-colors)))
-          (unless color
-            (setq color git-blame-ancient-color))
-          (setq info (list hash src-line res-line num-lines
+	;; Assign a random color to each new commit info
+	;; Take care not to select the same color multiple times
+	(let* ((idx (random (length colors)))
+	       (color (or (elt colors idx)
+			  git-blame-ancient-color)))
+	  (and (assoc color colors)
+	       (setq colors (delete idx colors)))
+	  (setq info (list hash src-line res-line num-lines
                            (git-describe-commit hash)
                            (cons 'color color))))
         (puthash hash info git-blame-cache))
--=20
1.5.0.5
