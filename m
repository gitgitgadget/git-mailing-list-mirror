From: Nikolaj Schumacher <n_schumacher@web.de>
Subject: [PATCH] git.el: Don't reset HEAD in git-amend-file.
Date: Sun, 22 Jun 2008 00:27:04 +0200
Message-ID: <m2myle77bb.fsf@nschum.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 00:28:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KABZa-0007FR-0O
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 00:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYFUW1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYFUW1J
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 18:27:09 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46484 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbYFUW1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 18:27:08 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 1BE4CE2B4180
	for <git@vger.kernel.org>; Sun, 22 Jun 2008 00:27:05 +0200 (CEST)
Received: from [77.135.41.81] (helo=thursday)
	by smtp05.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KABY0-0007OG-00
	for git@vger.kernel.org; Sun, 22 Jun 2008 00:27:04 +0200
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2.50 (darwin)
X-Sender: n_schumacher@web.de
X-Provags-ID: V01U2FsdGVkX18Mfht5mmNYd8EHTCX4S08sLF5bLhwLwsQSfyN1
	9yws2iWeCvE8tODYjmO2X2FTgg0k4nR2gpvEyGlAEHQh1FhrrD
	kU+GXQBcYc6YgrUJH4RQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85733>

--=-=-=

Hello.

The current implementation of git-amend-file is a little dangerous.
While git --amend is atomic, git-amend-file is not.

If the user calls it, but doesn't go through with the commit (due to
error or choice), git --reset HEAD^ has been called anyway.

With this patch it doesn't reset the HEAD till the actual commit.


regards,
Nikolaj Schumacher

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=git_git.el_amend.patch
Content-Description: patch

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 4fa853f..1360cb0 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -400,16 +400,17 @@ and returns the process output as a string, or nil if the git failed."
   (git-get-string-sha1
    (git-call-process-env-string (and index-file `(("GIT_INDEX_FILE" . ,index-file))) "write-tree")))
 
-(defun git-commit-tree (buffer tree head)
+(defun git-commit-tree (buffer tree parent &optional head)
   "Call git-commit-tree with buffer as input and return the resulting commit SHA1."
+  (unless head (setq head parent))
   (let ((author-name (git-get-committer-name))
         (author-email (git-get-committer-email))
         (subject "commit (initial): ")
         author-date log-start log-end args coding-system-for-write)
-    (when head
+    (when parent
       (setq subject "commit: ")
       (push "-p" args)
-      (push head args))
+      (push parent args))
     (with-current-buffer buffer
       (goto-char (point-min))
       (if
@@ -425,7 +426,7 @@ and returns the process output as a string, or nil if the git failed."
               (setq author-date (match-string 1)))
             (goto-char (point-min))
             (while (re-search-forward "^Parent: +\\([0-9a-f]+\\)" nil t)
-              (unless (string-equal head (match-string 1))
+              (unless (string-equal parent (match-string 1))
                 (setq subject "commit (merge): ")
                 (push "-p" args)
                 (push (match-string 1) args))))
@@ -852,7 +853,7 @@ Return the list of files that haven't been handled."
               (git-run-hook "pre-commit" `(("GIT_INDEX_FILE" . ,index-file))))
           (delete-file index-file))))))
 
-(defun git-do-commit ()
+(defun git-do-commit (&optional amend)
   "Perform the actual commit using the current buffer as log message."
   (interactive)
   (let ((buffer (current-buffer))
@@ -862,10 +863,11 @@ Return the list of files that haven't been handled."
           (message "You cannot commit unmerged files, resolve them first.")
         (unwind-protect
             (let ((files (git-marked-files-state 'added 'deleted 'modified))
-                  head head-tree)
+                  head parent head-tree)
               (unless (git-empty-db-p)
                 (setq head (git-rev-parse "HEAD")
-                      head-tree (git-rev-parse "HEAD^{tree}")))
+                      parent (if amend (git-rev-parse "HEAD^") head)
+                      head-tree (git-rev-parse (concat "HEAD^{tree}"))))
               (if files
                   (progn
                     (message "Running git commit...")
@@ -875,7 +877,7 @@ Return the list of files that haven't been handled."
                     (let ((tree (git-write-tree index-file)))
                       (if (or (not (string-equal tree head-tree))
                               (yes-or-no-p "The tree was not modified, do you really want to perform an empty commit? "))
-                          (let ((commit (git-commit-tree buffer tree head)))
+                          (let ((commit (git-commit-tree buffer tree parent head)))
                             (when commit
                               (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
                               (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
@@ -1263,13 +1265,22 @@ Return the list of files that haven't been handled."
       (when sign-off (git-append-sign-off committer-name committer-email)))
     buffer))
 
-(defun git-commit-file ()
-  "Commit the marked file(s), asking for a commit message."
-  (interactive)
+(defun git-commit-file (&optional amend)
+  "Commit the marked file(s), asking for a commit message.
+With optional argument, amend HEAD."
+  (interactive "P")
   (unless git-status (error "Not in git-status buffer."))
+  (and amend (git-empty-db-p) (error "No commit to amend."))
   (when (git-run-pre-commit-hook)
     (let ((buffer (get-buffer-create "*git-commit*"))
           (coding-system (git-get-commits-coding-system))
+          (action (if amend
+                      `(lambda () (interactive) (git-do-commit t))
+                    'git-do-commit))
+          (env (if (boundp 'log-edit-diff-function)
+                   '((log-edit-listfun . git-log-edit-files)
+                     (log-edit-diff-function . git-log-edit-diff))
+                 'git-log-edit-files))
           author-name author-email subject date)
       (when (eq 0 (buffer-size buffer))
         (when (file-readable-p ".dotest/info")
@@ -1286,10 +1297,8 @@ Return the list of files that haven't been handled."
             (when (re-search-forward "^Date: \\(.*\\)$" nil t)
               (setq date (match-string 1)))))
         (git-setup-log-buffer buffer author-name author-email subject date))
-      (if (boundp 'log-edit-diff-function)
-	  (log-edit 'git-do-commit nil '((log-edit-listfun . git-log-edit-files)
-					 (log-edit-diff-function . git-log-edit-diff)) buffer)
-	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
+      (when amend (git-setup-commit-buffer "HEAD"))
+      (log-edit action nil env buffer)
       (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
       (setq buffer-file-coding-system coding-system)
       (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
@@ -1326,19 +1335,9 @@ Return the list of files that haven't been handled."
     files))
 
 (defun git-amend-commit ()
-  "Undo the last commit on HEAD, and set things up to commit an
-amended version of it."
+  "Call `git-commit-file' and have it amend HEAD."
   (interactive)
-  (unless git-status (error "Not in git-status buffer."))
-  (when (git-empty-db-p) (error "No commit to amend."))
-  (let* ((commit (git-rev-parse "HEAD"))
-         (files (git-get-commit-files commit)))
-    (when (git-call-process-display-error "reset" "--soft" "HEAD^")
-      (git-update-status-files (copy-sequence files) 'uptodate)
-      (git-mark-files git-status files)
-      (git-refresh-files)
-      (git-setup-commit-buffer commit)
-      (git-commit-file))))
+  (git-commit-file t))
 
 (defun git-find-file ()
   "Visit the current file in its own buffer."

--=-=-=--
