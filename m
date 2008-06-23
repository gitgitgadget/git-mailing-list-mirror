From: Nikolaj Schumacher <n_schumacher@web.de>
Subject: [PATCH v2/RFC] git.el: Commands for committing patches
Date: Mon, 23 Jun 2008 09:41:37 +0200
Message-ID: <m263s0vbri.fsf_-_@nschum.de>
References: <m2prq9ujpa.fsf@nschum.de> <485F0388.4080907@thewritingpot.com>
	<m2abhcvcil.fsf@nschum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 09:42:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAghB-0003UU-8T
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 09:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYFWHlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 03:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbYFWHlk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 03:41:40 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:53051 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbYFWHlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 03:41:39 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6A1A7E51F604;
	Mon, 23 Jun 2008 09:41:38 +0200 (CEST)
Received: from [93.132.129.42] (helo=thursday)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KAggE-0002Qy-00; Mon, 23 Jun 2008 09:41:38 +0200
In-Reply-To: <m2abhcvcil.fsf@nschum.de> (Nikolaj Schumacher's message of "Mon\, 23 Jun 2008 09\:25\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2.50 (darwin)
X-Sender: n_schumacher@web.de
X-Provags-ID: V01U2FsdGVkX198JeuwS863nQHgltvcuV1Tei6y0yBcA9rruM5E
	KCXv630LHKDDadJG1pX+RTJwuRY1qC9RyoxVgXOFvqDXY172SA
	s7D5uMxwzbcN91Tg19ag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85845>

>From 609f6fca6c70919036d41e1e4034b6e4de2e7ea2 Mon Sep 17 00:00:00 2001
From: Nikolaj Schumacher <git@nschum.de>
Date: Mon, 23 Jun 2008 09:34:14 +0200
Subject: [PATCH] git.el: Added command for committing patches.

This adds commands for committing patches from files, buffers and email
buffers.

In order to minimize code duplication, git-start-log-edit and
git-prepare-log-buffer have been extracted from git-commit-file.

Signed-off-by: Nikolaj Schumacher <git@nschum.de>
---
 contrib/emacs/git.el |  200 +++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 175 insertions(+), 25 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 4fa853f..a6c776d 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -189,6 +189,13 @@ if there is already one that displays the same directory."
                                      process-environment)))
     (apply #'call-process "git" nil buffer nil args)))
 
+(defun git-call-process-env-on-region (buffer env beg end &rest args)
+  "Wrapper for `call-process-region' that sets environment strings."
+  (let ((process-environment (append (git-get-env-strings env)
+                                     process-environment)))
+    (buffer-string)
+    (apply #'call-process-region beg end "git" nil buffer nil args)))
+
 (defun git-call-process-display-error (&rest args)
   "Wrapper for call-process that displays error messages."
   (let* ((dir default-directory)
@@ -315,6 +322,42 @@ and returns the process output as a string, or nil if the git failed."
               "\"")
     name))
 
+(defun git-parse-email-address (email-address)
+  "Split the EMAIL-ADDRESS string into a cons of address and name."
+  (if (string-match "\\`\"?\\([^\n<,\"]+\\)\"?[ \t]<\\([^ @]+@[^ \n\t]+\\)>\\'"
+                    email-address)
+      (cons (match-string-no-properties 2 email-address)
+            (match-string-no-properties 1 email-address))
+    (when (string-match
+           "\\`\\([^ \t\n@]+@[^ \t\n,]+\\)\\([ \t](\\([^)]*\\))\\)?"
+           email-address)
+      (cons (match-string-no-properties 1 email-address)
+            (match-string-no-properties 3 email-address)))))
+
+(defun git-find-patch (&optional start)
+  "Find the patch start in the current buffer."
+  (save-excursion
+    (goto-char (or start (point-min)))
+    (when (re-search-forward "^\\(---$\\|diff -\\|Index: \\)" nil t)
+      (match-beginning 0))))
+
+(defun git-find-message ()
+  "Find the start of the commit message in an email buffer."
+  (require 'message)
+  (save-excursion
+    (message-goto-body)
+    (search-forward-regexp "[^:]+:\\([^\n]\\|\n[ \t]\\)+\n\n" nil t)
+    (point)))
+
+(defun git-fetch-header (header limit)
+  (save-excursion
+    (goto-char limit)
+    (let ((case-fold-search t))
+      (when (re-search-backward (concat "^" (regexp-quote header)
+                                        "[ \t]*:[ \t]*")
+                                nil t)
+        (buffer-substring-no-properties (match-end 0) (point-at-eol))))))
+
 (defun git-success-message (text files)
   "Print a success message after having handled FILES."
   (let ((n (length files)))
@@ -891,6 +934,58 @@ Return the list of files that haven't been handled."
                 (message "No files to commit.")))
           (delete-file index-file))))))
 
+(defun git-apply-patch-to-index (index-file patch &optional beg end)
+  "Run git-apply on a patch."
+  (with-temp-buffer
+    (let ((env (and index-file `(("GIT_INDEX_FILE" . ,index-file))))
+          (temp-buffer (current-buffer))
+          res)
+      (if (stringp patch)
+          (if (file-exists-p patch)
+              (setq res (git-call-process-env temp-buffer env "apply"
+                                              "--cached"
+                                              (expand-file-name patch)))
+            (error "Patch file disappeared"))
+        (if (buffer-live-p patch)
+            (setq res (with-current-buffer patch
+                        (git-call-process-env-on-region
+                         temp-buffer env (or beg (point-min))
+                         (or end (point-max)) "apply" "--cached" "-")))
+          (error "Patch buffer disappeared")))
+      (unless (= 0 res)
+        (error "Applying patch failed:\n%s" (buffer-string))))))
+
+(defun git-do-commit-patch (patch &optional beg end)
+  "Actually commit the patch using the current buffer as log message."
+  (interactive)
+  (let ((buffer (current-buffer))
+        (index-file (make-temp-file "gitidx")))
+    (with-current-buffer log-edit-parent-buffer
+      (unwind-protect
+          (let (head parent head-tree)
+            (unless (git-empty-db-p)
+              (setq head (git-rev-parse "HEAD")
+                    head-tree (git-rev-parse "HEAD^{tree}")))
+            (message "Running git commit...")
+            (git-read-tree head-tree index-file)
+            ;; Update both the default index and the temporary one.
+            (git-apply-patch-to-index index-file patch beg end)
+            (git-apply-patch-to-index nil patch beg end)
+            (let* ((tree (git-write-tree index-file))
+                   (commit (git-commit-tree buffer tree head)))
+              (when commit
+                (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil)
+                (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
+                (with-current-buffer buffer (erase-buffer))
+                (git-call-process-env nil nil "rerere")
+                (git-call-process-env nil nil "gc" "--auto")
+                (git-refresh-status)
+                (git-refresh-ewoc-hf git-status)
+                (message "Committed %s." commit)
+                (git-run-hook "post-commit" nil)))
+            t)
+        (delete-file index-file)
+        nil)))))
 
 ;;;; Interactive functions
 ;;;; ------------------------------------------------------------
@@ -1263,36 +1358,41 @@ Return the list of files that haven't been handled."
       (when sign-off (git-append-sign-off committer-name committer-email)))
     buffer))
 
+(defun git-start-log-edit (buffer action)
+  (if (boundp 'log-edit-diff-function)
+      (log-edit action nil '((log-edit-listfun . git-log-edit-files)
+                             (log-edit-diff-function . git-log-edit-diff)) buffer)
+    (log-edit action nil 'git-log-edit-files buffer))
+  (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
+  (setq buffer-file-coding-system (git-get-commits-coding-system))
+  (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))
+
+(defun git-prepare-log-buffer ()
+  (let ((buffer (get-buffer-create "*git-commit*"))
+        author-name author-email subject date)
+    (when (eq 0 (buffer-size buffer))
+      (when (file-readable-p ".dotest/info")
+        (with-temp-buffer
+          (insert-file-contents ".dotest/info")
+          (goto-char (point-min))
+          (when (re-search-forward "^Author: \\(.*\\)\nEmail: \\(.*\\)$" nil t)
+            (setq author-name (match-string 1))
+            (setq author-email (match-string 2)))
+          (goto-char (point-min))
+          (when (re-search-forward "^Subject: \\(.*\\)$" nil t)
+            (setq subject (match-string 1)))
+          (goto-char (point-min))
+          (when (re-search-forward "^Date: \\(.*\\)$" nil t)
+            (setq date (match-string 1)))))
+      (git-setup-log-buffer buffer author-name author-email subject date))
+    buffer))
+
 (defun git-commit-file ()
   "Commit the marked file(s), asking for a commit message."
   (interactive)
   (unless git-status (error "Not in git-status buffer."))
   (when (git-run-pre-commit-hook)
-    (let ((buffer (get-buffer-create "*git-commit*"))
-          (coding-system (git-get-commits-coding-system))
-          author-name author-email subject date)
-      (when (eq 0 (buffer-size buffer))
-        (when (file-readable-p ".dotest/info")
-          (with-temp-buffer
-            (insert-file-contents ".dotest/info")
-            (goto-char (point-min))
-            (when (re-search-forward "^Author: \\(.*\\)\nEmail: \\(.*\\)$" nil t)
-              (setq author-name (match-string 1))
-              (setq author-email (match-string 2)))
-            (goto-char (point-min))
-            (when (re-search-forward "^Subject: \\(.*\\)$" nil t)
-              (setq subject (match-string 1)))
-            (goto-char (point-min))
-            (when (re-search-forward "^Date: \\(.*\\)$" nil t)
-              (setq date (match-string 1)))))
-        (git-setup-log-buffer buffer author-name author-email subject date))
-      (if (boundp 'log-edit-diff-function)
-	  (log-edit 'git-do-commit nil '((log-edit-listfun . git-log-edit-files)
-					 (log-edit-diff-function . git-log-edit-diff)) buffer)
-	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
-      (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
-      (setq buffer-file-coding-system coding-system)
-      (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
+    (git-start-log-edit (git-prepare-log-buffer) 'git-do-commit)))
 
 (defun git-setup-commit-buffer (commit)
   "Setup the commit buffer with the contents of COMMIT."
@@ -1340,6 +1440,56 @@ amended version of it."
       (git-setup-commit-buffer commit)
       (git-commit-file))))
 
+(defun git-commit-patch (patch)
+  "Commit the patch in file PATCH, asking for a commit message."
+  (interactive "fPatch file: ")
+  (unless git-status (error "Not in git-status buffer."))
+  (when (git-run-pre-commit-hook)
+    (git-start-log-edit (git-prepare-log-buffer)
+                        `(lambda ()
+                           (interactive)
+                           (git-do-commit-patch ,patch)))))
+
+(defun git-commit-patch-buffer (patch)
+  "Commit the patch in buffer PATCH, asking for a commit message."
+  (interactive "bPatch buffer")
+  (when (stringp patch)
+    (setq patch (get-buffer patch)))
+  (unless git-status (error "Not in git-status buffer."))
+  (when (git-run-pre-commit-hook)
+    (git-start-log-edit (git-prepare-log-buffer)
+                        `(lambda ()
+                           (interactive)
+                           (git-do-commit-patch ,patch)))))
+
+(defun git-commit-email-patch (email)
+  "Commit the patch in the email in buffer EMAIL."
+  (interactive "bEmail buffer")
+  (when (stringp email)
+    (setq email (get-buffer email)))
+  (let ((buffer (get-buffer-create "*git-commit-patch*"))
+        author-name author-email email-subject subject date
+        body-start patch-start)
+    (with-current-buffer email
+      (setq body-start (git-find-message)
+            patch-start (git-find-patch body-start))
+      (let ((address (git-parse-email-address
+                      (git-fetch-header "From" patch-start)))
+            (email-subject (git-fetch-header "Subject" patch-start)))
+        (setq author-name (car address)
+              author-email (cdr address)
+              subject (when (string-match "\\`\\[PATCH[^]]*\\]\s *"
+                                          email-subject)
+                        (substring email-subject (match-end 0)))
+              date (git-fetch-header "Date" patch-start)
+              msg (buffer-substring body-start patch-start))))
+    (when (git-run-pre-commit-hook)
+      (git-setup-log-buffer buffer author-name author-email subject date msg)
+      (git-start-log-edit buffer
+                          `(lambda ()
+                             (interactive)
+                             (git-do-commit-patch ,email ,patch-start))))))
+
 (defun git-find-file ()
   "Visit the current file in its own buffer."
   (interactive)
-- 
1.5.5.3
