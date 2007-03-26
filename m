From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 1/2] git-blame.el: separate git-blame-mode to ease maintenance
Date: Mon, 26 Mar 2007 23:00:54 +0200
Organization: GNU's Not UNIX!
Message-ID: <200703262100.l2QL0svB012536@localhost.localdomain>
Reply-To: Xavier Maillard <zedek@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 00:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVxbH-0005Np-KT
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 00:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933372AbXCZWXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 18:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933358AbXCZWXc
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 18:23:32 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:45669 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933372AbXCZWX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 18:23:29 -0400
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 247E57DAA
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 00:23:28 +0200 (CEST)
Received: from localhost.localdomain (IDENT:25@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l2QLKSSL013420
	for <git@vger.kernel.org>; Mon, 26 Mar 2007 23:20:28 +0200
Received: (from zedek@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l2QL0svB012536;
	Mon, 26 Mar 2007 23:00:54 +0200
X-Authentication-Warning: localhost.localdomain: zedek set sender to zedek@gnu.org using -f
User-Agent: Rmail in GNU Emacs 23.0.51.1 on GNU/Linux
Jabber-ID: zedek@im.lolica.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43195>


git-blame-mode has been splitted into git-blame-mode-on and
git-blame-mode-off; it now conditionnaly calls one of them depending
of how we call it. Code is now easier to maintain and to understand.

Fixed `git-reblame' function: interactive form was at the wrong
place.

String displayed on the mode line is now configurable through
`git-blame-mode-line-string` (default to " blame").

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/git-blame.el |   55 +++++++++++++++++++++++++++++--------------
 1 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 64ad50b..bd87a86 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -127,39 +127,58 @@
 
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
-(unless (assq 'git-blame-mode minor-mode-alist)
-  (setq minor-mode-alist
-	(cons (list 'git-blame-mode " blame")
-	      minor-mode-alist)))
+
+(defvar git-blame-mode-line-string " blame"
+  "String to display on the mode line when git-blame is active.")
+
+(or (assq 'git-blame-mode minor-mode-alist)
+    (setq minor-mode-alist
+	  (cons '(git-blame-mode git-blame-mode-line-string) minor-mode-alist)))
 
 ;;;###autoload
 (defun git-blame-mode (&optional arg)
-  "Minor mode for displaying Git blame"
+  "Toggle minor mode for displaying Git blame
+
+With prefix ARG, turn the mode on if ARG is positive."
   (interactive "P")
-  (if arg
-      (setq git-blame-mode (eq arg 1))
-    (setq git-blame-mode (not git-blame-mode)))
+  (cond
+   ((null arg)
+    (if git-blame-mode (git-blame-mode-off) (git-blame-mode-on)))
+   ((> (prefix-numeric-value arg) 0) (git-blame-mode-on))
+   (t (git-blame-mode-off))))
+
+(defun git-blame-mode-on ()
+  "Turn on git-blame mode.
+
+See also function `git-blame-mode'."
   (make-local-variable 'git-blame-colors)
   (if git-blame-autoupdate
       (add-hook 'after-change-functions 'git-blame-after-change nil t)
     (remove-hook 'after-change-functions 'git-blame-after-change t))
   (git-blame-cleanup)
-  (if git-blame-mode
-      (progn
-        (let ((bgmode (cdr (assoc 'background-mode (frame-parameters)))))
-          (if (eq bgmode 'dark)
-              (setq git-blame-colors git-blame-dark-colors)
-            (setq git-blame-colors git-blame-light-colors)))
-        (setq git-blame-cache (make-hash-table :test 'equal))
-        (git-blame-run))
-    (cancel-timer git-blame-idle-timer)))
+  (let ((bgmode (cdr (assoc 'background-mode (frame-parameters)))))
+    (if (eq bgmode 'dark)
+	(setq git-blame-colors git-blame-dark-colors)
+      (setq git-blame-colors git-blame-light-colors)))
+  (setq git-blame-cache (make-hash-table :test 'equal))
+  (setq git-blame-mode t)
+  (git-blame-run))
+
+(defun git-blame-mode-off ()
+  "Turn off git-blame mode.
+
+See also function `git-blame-mode'."
+  (git-blame-cleanup)
+  (if git-blame-idle-timer (cancel-timer git-blame-idle-timer))
+  (setq git-blame-mode nil))
 
 ;;;###autoload
 (defun git-reblame ()
   "Recalculate all blame information in the current buffer"
+  (interactive)
   (unless git-blame-mode
     (error "git-blame is not active"))
-  (interactive)
+  
   (git-blame-cleanup)
   (git-blame-run))
 
-- 
1.5.0.5
