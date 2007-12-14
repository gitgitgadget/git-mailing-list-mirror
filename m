From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 16/17] Emacs mode: Add mark command
Date: Fri, 14 Dec 2007 11:59:32 +0100
Message-ID: <20071214105928.18066.94814.stgit@krank>
References: <20071214105238.18066.23281.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 12:00:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J38HC-0001xm-93
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 12:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291AbXLNK7R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 05:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757072AbXLNK7R
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 05:59:17 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:51854 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762AbXLNK7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 05:59:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 4A5A3200A217;
	Fri, 14 Dec 2007 11:59:14 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 28143-01-61; Fri, 14 Dec 2007 11:59:13 +0100 (CET)
Received: from krank (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id CB402200A1E8;
	Fri, 14 Dec 2007 11:59:13 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 415507B406D;
	Fri, 14 Dec 2007 11:59:32 +0100 (CET)
In-Reply-To: <20071214105238.18066.23281.stgit@krank>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 contrib/stgit.el |   76 +++++++++++++++++++++++++++++++++++++++++-----=
--------
 1 files changed, 57 insertions(+), 19 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 1cb4dd2..dfbf4a0 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -70,7 +70,7 @@ Argument DIR is the repository path."
     (insert "Branch: ")
     (stgit-run "branch")
     (stgit-run "series" "--description")
-    (stgit-rehighlight (point-min) (point-max))
+    (stgit-rescan)
     (if curpatch
         (stgit-goto-patch curpatch)
       (goto-line curline))))
@@ -98,23 +98,30 @@ Argument DIR is the repository path."
     (t ()))
   "The face used for unapplied patch names")
=20
-(defun stgit-rehighlight (start end)
-  "Refresh fontification of region between START and END."
+(defun stgit-rescan ()
+  "Rescan the status buffer."
   (save-excursion
-    (goto-char start)
-    (while (< (point) end)
-      (cond ((looking-at "Branch: \\(.*\\)")
-             (put-text-property (match-beginning 1) (match-end 1) 'fac=
e 'bold))
-            ((looking-at "\\([>+-]\\) \\([^ ]+\\) *| \\(.*\\)")
-             (let ((state (match-string 1)))
-               (put-text-property
-                (match-beginning 2) (match-end 2)
-                'face (cond ((string=3D state ">") 'stgit-top-patch-fa=
ce)
-                            ((string=3D state "+") 'stgit-applied-patc=
h-face)
-                            ((string=3D state "-") 'stgit-unapplied-pa=
tch-face)))
-               (put-text-property (match-beginning 3) (match-end 3)
-                                  'face 'stgit-description-face))))
-      (forward-line 1))))
+    (let ((marked ()))
+      (goto-char (point-min))
+      (while (not (eobp))
+        (cond ((looking-at "Branch: \\(.*\\)")
+               (put-text-property (match-beginning 1) (match-end 1)
+                                  'face 'bold))
+              ((looking-at "\\([>+-]\\)\\( \\)\\([^ ]+\\) *| \\(.*\\)"=
)
+               (let ((state (match-string 1))
+                     (patchsym (intern (match-string 3))))
+                 (put-text-property
+                  (match-beginning 3) (match-end 3) 'face
+                  (cond ((string=3D state ">") 'stgit-top-patch-face)
+                        ((string=3D state "+") 'stgit-applied-patch-fa=
ce)
+                        ((string=3D state "-") 'stgit-unapplied-patch-=
face)))
+                 (put-text-property (match-beginning 4) (match-end 4)
+                                    'face 'stgit-description-face)
+                 (when (memq patchsym stgit-marked-patches)
+                   (replace-match "*" nil nil nil 2)
+                   (setq marked (cons patchsym marked))))))
+        (forward-line 1))
+      (setq stgit-marked-patches (nreverse marked)))))
=20
 (defvar stgit-mode-hook nil
   "Run after `stgit-mode' is setup.")
@@ -125,6 +132,8 @@ Argument DIR is the repository path."
 (unless stgit-mode-map
   (setq stgit-mode-map (make-keymap))
   (suppress-keymap stgit-mode-map)
+  (define-key stgit-mode-map " "   'stgit-mark)
+  (define-key stgit-mode-map "\d" 'stgit-unmark)
   (define-key stgit-mode-map "?"   'stgit-help)
   (define-key stgit-mode-map "h"   'stgit-help)
   (define-key stgit-mode-map "p"   'previous-line)
@@ -153,14 +162,27 @@ Commands:
         goal-column 2)
   (use-local-map stgit-mode-map)
   (set (make-local-variable 'list-buffers-directory) default-directory=
)
+  (set (make-local-variable 'stgit-marked-patches) nil)
   (set-variable 'truncate-lines 't)
   (run-hooks 'stgit-mode-hook))
=20
+(defun stgit-add-mark (patch)
+  (let ((patchsym (intern patch)))
+    (setq stgit-marked-patches (cons patchsym stgit-marked-patches))))
+
+(defun stgit-remove-mark (patch)
+  (let ((patchsym (intern patch)))
+    (setq stgit-marked-patches (delq patchsym stgit-marked-patches))))
+
+(defun stgit-marked-patches ()
+  "Return the names of the marked patches."
+  (mapcar 'symbol-name stgit-marked-patches))
+
 (defun stgit-patch-at-point ()
   "Return the patch name on the current line"
   (save-excursion
     (beginning-of-line)
-    (if (looking-at "[>+-] \\([^ ]*\\)")
+    (if (looking-at "[>+-][ *]\\([^ ]*\\)")
         (match-string-no-properties 1)
       nil)))
=20
@@ -168,12 +190,28 @@ Commands:
   "Move point to the line containing PATCH"
   (let ((p (point)))
     (goto-char (point-min))
-    (if (re-search-forward (concat "[>+-] " (regexp-quote patch) " ") =
nil t)
+    (if (re-search-forward (concat "^[>+-][ *]" (regexp-quote patch) "=
 ") nil t)
         (progn (move-to-column goal-column)
                t)
       (goto-char p)
       nil)))
=20
+(defun stgit-mark ()
+  "Mark the patch under point"
+  (interactive)
+  (let ((patch (stgit-patch-at-point)))
+    (stgit-add-mark patch)
+    (stgit-refresh))
+  (next-line))
+
+(defun stgit-unmark ()
+  "Mark the patch on the previous line"
+  (interactive)
+  (forward-line -1)
+  (let ((patch (stgit-patch-at-point)))
+    (stgit-remove-mark patch)
+    (stgit-refresh)))
+
 (defun stgit-rename (name)
   "Rename the patch under point"
   (interactive (list (read-string "Patch name: " (stgit-patch-at-point=
))))
