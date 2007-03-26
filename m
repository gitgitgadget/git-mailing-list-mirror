From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 2/2] git-blame.el: pick a set of random colors when blaming
Date: Mon, 26 Mar 2007 23:01:54 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703262101.l2QL1sGL012549@localhost.localdomain>
Reply-To: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 00:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVxbH-0005Np-3a
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933365AbXCZWXb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933358AbXCZWXb
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:23:31 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:45670 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933365AbXCZWX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:23:29 -0400
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2482587A6
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 00:23:28 +0200 (CEST)
Received: from localhost.localdomain (IDENT:25@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l2QLKSSN013420
	for <git@vger.kernel.org>; Mon, 26 Mar 2007 23:20:28 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2QL1sGL012549;
	Mon, 26 Mar 2007 23:01:54 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43194>


I thought it would be cooler to have different set of colors each time
I blame.

* Prevent (future possible) namespace clash by renaming `color-scale'
into `git-blame-color-scale'. Definition has been changed to be more
in the "lisp" way (thanks for help goes to #emacs). Also added a small
description of what it does.

* Added docstrings at some point and instructed defvar when a variable
was candidate to customisation by users.

* Added fix to silent byte-compilers (git-blame-file,
git-blame-current)

* Do not require 'cl at startup.

* Added more informations on compatibility

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/git-blame.el |   71 +++++++++++++++++++++++++++----------------
 1 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index bd87a86..6d0c1b0 100644
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
 
 ;; This file is *NOT* part of GNU Emacs.
 ;; This file is distributed under the same terms as GNU Emacs.
@@ -61,8 +61,9 @@
 
 ;;; Compatibility:
 ;;
-;; It requires GNU Emacs 21.  If you'are using Emacs 20, try
-;; changing this:
+;; It requires GNU Emacs 21 or later and Git 1.5.0 and up
+;; 
+;; If you'are using Emacs 20, try changing this:
 ;;
 ;;            (overlay-put ovl 'face (list :background
 ;;                                         (cdr (assq 'color (cddddr info)))))
@@ -77,30 +78,43 @@
 ;;
 ;;; Code:
 
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
+a b => bbb bba bab baa abb aba aaa aab"
+  (let (result)
+    (dolist (a elements)
+      (dolist (b elements)
+        (dolist (c elements)
+          (setq result (cons (format "#%s%s%s" a b c) result)))))
+    result))
+
+;; (git-blame-color-scale "0c" "04" "24" "1c" "2c" "34" "14" "3c") =>
+;; ("#3c3c3c" "#3c3c14" "#3c3c34" "#3c3c2c" "#3c3c1c" "#3c3c24"
+;; "#3c3c04" "#3c3c0c" "#3c143c" "#3c1414" "#3c1434" "#3c142c" ...)
 
 (defvar git-blame-dark-colors
-  (color-scale '("0c" "04" "24" "1c" "2c" "34" "14" "3c")))
+  (git-blame-color-scale "0c" "04" "24" "1c" "2c" "34" "14" "3c")
+  "*List of colors (format #RGB) to use in a dark environment.
+
+To check out the list, evaluate (list-colors-display git-blame-dark-colors).")
 
 (defvar git-blame-light-colors
-  (color-scale '("c4" "d4" "cc" "dc" "f4" "e4" "fc" "ec")))
+  (git-blame-color-scale "c4" "d4" "cc" "dc" "f4" "e4" "fc" "ec")
+  "*List of colors (format #RGB) to use in a light environment.
+
+To check out the list, evaluate (list-colors-display git-blame-light-colors).")
 
-(defvar git-blame-ancient-color "dark green")
+(defvar git-blame-colors '()
+  "Colors used by git-blame. The list is built once when activating git-blame
+minor mode.")
+  
+(defvar git-blame-ancient-color "dark green"
+  "*Color to be used for ancient commit.")
 
 (defvar git-blame-autoupdate t
   "*Automatically update the blame display while editing")
@@ -125,6 +139,10 @@
   "A queue of update requests")
 (make-variable-buffer-local 'git-blame-update-queue)
 
+;; FIXME: docstrings
+(defvar git-blame-file nil)
+(defvar git-blame-current nil)
+
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
 
@@ -177,7 +195,7 @@ See also function `git-blame-mode'."
   "Recalculate all blame information in the current buffer"
   (interactive)
   (unless git-blame-mode
-    (error "git-blame is not active"))
+    (error "Git-blame is not active"))
   
   (git-blame-cleanup)
   (git-blame-run))
@@ -302,9 +320,8 @@ See also function `git-blame-mode'."
           (inhibit-point-motion-hooks t)
           (inhibit-modification-hooks t))
       (when (not info)
-        (let ((color (pop git-blame-colors)))
-          (unless color
-            (setq color git-blame-ancient-color))
+        (let ((color (or (elt git-blame-colors (random (length git-blame-colors)))
+			 git-blame-ancient-color)))
           (setq info (list hash src-line res-line num-lines
                            (git-describe-commit hash)
                            (cons 'color color))))
-- 
1.5.0.5
