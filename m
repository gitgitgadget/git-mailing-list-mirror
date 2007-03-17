From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Add support for commit hooks.
Date: Sat, 17 Mar 2007 20:40:12 +0100
Message-ID: <87mz2by7z7.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 20:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSelV-0000Ac-FI
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 20:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbXCQTkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 15:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbXCQTkS
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 15:40:18 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:58789 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbXCQTkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 15:40:16 -0400
Received: from adsl-84-227-0-184.adslplus.ch ([84.227.0.184] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HSelD-0004wU-52
	for git@vger.kernel.org; Sat, 17 Mar 2007 13:40:15 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 08B59109F1C; Sat, 17 Mar 2007 20:40:13 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42447>

Run the pre-commit and post-commit hooks at appropriate places, and
display their output if any.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   81 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index db87a37..5f22dec 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1,6 +1,6 @@
 ;;; git.el --- A user interface for git
 
-;; Copyright (C) 2005, 2006 Alexandre Julliard <julliard@winehq.org>
+;; Copyright (C) 2005, 2006, 2007 Alexandre Julliard <julliard@winehq.org>
 
 ;; Version: 1.0
 
@@ -213,6 +213,23 @@ and returns the process output as a string."
     (error "Failed to run \"git %s\":\n%s" (mapconcat (lambda (x) x) args " ") (buffer-string)))
   (message "Running git %s...done" (car args)))
 
+(defun git-run-hook (hook env &rest args)
+  "Run a git hook and display its output if any."
+  (let ((dir default-directory)
+        (hook-name (expand-file-name (concat ".git/hooks/" hook))))
+    (or (not (file-executable-p hook-name))
+        (let (status (buffer (get-buffer-create "*Git Hook Output*")))
+          (with-current-buffer buffer
+            (erase-buffer)
+            (cd dir)
+            (setq status
+                  (if env
+                      (apply #'call-process "env" nil (list buffer t) nil
+                             (append (git-get-env-strings env) (list hook-name) args))
+                    (apply #'call-process hook-name nil (list buffer t) nil args))))
+          (display-message-or-buffer buffer)
+          (eq 0 status)))))
+
 (defun git-get-string-sha1 (string)
   "Read a SHA1 from the specified string."
   (and string
@@ -590,6 +607,20 @@ and returns the process output as a string."
     (when modified
       (apply #'git-run-command nil env "update-index" "--" (git-get-filenames modified)))))
 
+(defun git-run-pre-commit-hook ()
+  "Run the pre-commit hook if any."
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((files (git-marked-files-state 'added 'deleted 'modified)))
+    (or (not files)
+        (not (file-executable-p ".git/hooks/pre-commit"))
+        (let ((index-file (make-temp-file "gitidx")))
+          (unwind-protect
+            (let ((head-tree (unless (git-empty-db-p) (git-rev-parse "HEAD^{tree}"))))
+              (git-read-tree head-tree index-file)
+              (git-update-index index-file files)
+              (git-run-hook "pre-commit" `(("GIT_INDEX_FILE" . ,index-file))))
+          (delete-file index-file))))))
+
 (defun git-do-commit ()
   "Perform the actual commit using the current buffer as log message."
   (interactive)
@@ -622,7 +653,8 @@ and returns the process output as a string."
                               (git-run-command nil nil "rerere"))
                             (git-refresh-files)
                             (git-refresh-ewoc-hf git-status)
-                            (message "Committed %s." commit))
+                            (message "Committed %s." commit)
+                            (git-run-hook "post-commit" nil))
                         (message "Commit aborted."))))
                 (message "No files to commit.")))
           (delete-file index-file))))))
@@ -944,28 +976,29 @@ and returns the process output as a string."
   "Commit the marked file(s), asking for a commit message."
   (interactive)
   (unless git-status (error "Not in git-status buffer."))
-  (let ((buffer (get-buffer-create "*git-commit*"))
-        (coding-system (git-get-commits-coding-system))
-        author-name author-email subject date)
-    (when (eq 0 (buffer-size buffer))
-      (when (file-readable-p ".dotest/info")
-        (with-temp-buffer
-          (insert-file-contents ".dotest/info")
-          (goto-char (point-min))
-          (when (re-search-forward "^Author: \\(.*\\)\nEmail: \\(.*\\)$" nil t)
-            (setq author-name (match-string 1))
-            (setq author-email (match-string 2)))
-          (goto-char (point-min))
-          (when (re-search-forward "^Subject: \\(.*\\)$" nil t)
-            (setq subject (match-string 1)))
-          (goto-char (point-min))
-          (when (re-search-forward "^Date: \\(.*\\)$" nil t)
-            (setq date (match-string 1)))))
-      (git-setup-log-buffer buffer author-name author-email subject date))
-    (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
-    (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
-    (setq buffer-file-coding-system coding-system)
-    (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t)))
+  (when (git-run-pre-commit-hook)
+    (let ((buffer (get-buffer-create "*git-commit*"))
+          (coding-system (git-get-commits-coding-system))
+          author-name author-email subject date)
+      (when (eq 0 (buffer-size buffer))
+        (when (file-readable-p ".dotest/info")
+          (with-temp-buffer
+            (insert-file-contents ".dotest/info")
+            (goto-char (point-min))
+            (when (re-search-forward "^Author: \\(.*\\)\nEmail: \\(.*\\)$" nil t)
+              (setq author-name (match-string 1))
+              (setq author-email (match-string 2)))
+            (goto-char (point-min))
+            (when (re-search-forward "^Subject: \\(.*\\)$" nil t)
+              (setq subject (match-string 1)))
+            (goto-char (point-min))
+            (when (re-search-forward "^Date: \\(.*\\)$" nil t)
+              (setq date (match-string 1)))))
+        (git-setup-log-buffer buffer author-name author-email subject date))
+      (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
+      (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
+      (setq buffer-file-coding-system coding-system)
+      (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
 
 (defun git-find-file ()
   "Visit the current file in its own buffer."
-- 
1.5.0.4.408.gca3d7

-- 
Alexandre Julliard
julliard@winehq.org
