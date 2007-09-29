From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/4] git.el: Do not print a status message on every git command.
Date: Sat, 29 Sep 2007 11:58:39 +0200
Message-ID: <877im9pzcg.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 11:59:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbZ6B-00016K-Jp
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 11:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526AbXI2J6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 05:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbXI2J6w
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 05:58:52 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:57836 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755306AbXI2J6v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 05:58:51 -0400
Received: from adsl-84-227-59-51.adslplus.ch ([84.227.59.51] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IbZ5t-0004lK-Oa
	for git@vger.kernel.org; Sat, 29 Sep 2007 04:58:50 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 1F94D1E7148; Sat, 29 Sep 2007 11:58:39 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59453>

Instead print a single message around sequences of commands that can
potentially take some time.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   70 +++++++++++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 7b4a0d3..ec2e699 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -220,22 +220,15 @@ and returns the process output as a string."
     (message "Running git %s...done" (car args))
     buffer))
 
-(defun git-run-command (buffer env &rest args)
-  (message "Running git %s..." (car args))
-  (apply #'git-call-process-env buffer env args)
-  (message "Running git %s...done" (car args)))
-
 (defun git-run-command-region (buffer start end env &rest args)
   "Run a git command with specified buffer region as input."
-  (message "Running git %s..." (car args))
   (unless (eq 0 (if env
                     (git-run-process-region
                      buffer start end "env"
                      (append (git-get-env-strings env) (list "git") args))
                   (git-run-process-region
                    buffer start end "git" args)))
-    (error "Failed to run \"git %s\":\n%s" (mapconcat (lambda (x) x) args " ") (buffer-string)))
-  (message "Running git %s...done" (car args)))
+    (error "Failed to run \"git %s\":\n%s" (mapconcat (lambda (x) x) args " ") (buffer-string))))
 
 (defun git-run-hook (hook env &rest args)
   "Run a git hook and display its output if any."
@@ -312,6 +305,13 @@ and returns the process output as a string."
               "\"")
     name))
 
+(defun git-success-message (text files)
+  "Print a success message after having handled FILES."
+  (let ((n (length files)))
+    (if (equal n 1)
+        (message "%s %s" text (car files))
+      (message "%s %d files" text n))))
+
 (defun git-get-top-dir (dir)
   "Retrieve the top-level directory of a git tree."
   (let ((cdup (with-output-to-string
@@ -338,7 +338,7 @@ and returns the process output as a string."
     (sort-lines nil (point-min) (point-max))
     (save-buffer))
   (when created
-    (git-run-command nil nil "update-index" "--add" "--" (file-relative-name ignore-name)))
+    (git-call-process-env nil nil "update-index" "--add" "--" (file-relative-name ignore-name)))
   (git-update-status-files (list (file-relative-name ignore-name)) 'unknown)))
 
 ; propertize definition for XEmacs, stolen from erc-compat
@@ -606,7 +606,7 @@ and returns the process output as a string."
 Return the list of files that haven't been handled."
   (let (infolist)
     (with-temp-buffer
-      (apply #'git-run-command t nil "diff-index" "-z" "-M" "HEAD" "--" files)
+      (apply #'git-call-process-env t nil "diff-index" "-z" "-M" "HEAD" "--" files)
       (goto-char (point-min))
       (while (re-search-forward
               ":\\([0-7]\\{6\\}\\) \\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} \\(\\([ADMU]\\)\0\\([^\0]+\\)\\|\\([CR]\\)[0-9]*\0\\([^\0]+\\)\0\\([^\0]+\\)\\)\0"
@@ -639,7 +639,7 @@ Return the list of files that haven't been handled."
 Return the list of files that haven't been handled."
   (let (infolist)
     (with-temp-buffer
-      (apply #'git-run-command t nil "ls-files" "-z" (append options (list "--") files))
+      (apply #'git-call-process-env t nil "ls-files" "-z" (append options (list "--") files))
       (goto-char (point-min))
       (while (re-search-forward "\\([^\0]*\\)\0" nil t 1)
         (let ((name (match-string 1)))
@@ -651,7 +651,7 @@ Return the list of files that haven't been handled."
 (defun git-run-ls-unmerged (status files)
   "Run git-ls-files -u on FILES and parse the results into STATUS."
   (with-temp-buffer
-    (apply #'git-run-command t nil "ls-files" "-z" "-u" "--" files)
+    (apply #'git-call-process-env t nil "ls-files" "-z" "-u" "--" files)
     (goto-char (point-min))
     (let (unmerged-files)
       (while (re-search-forward "[0-7]\\{6\\} [0-9a-f]\\{40\\} [123]\t\\([^\0]+\\)\0" nil t)
@@ -754,11 +754,11 @@ Return the list of files that haven't been handled."
         ('deleted (push info deleted))
         ('modified (push info modified))))
     (when added
-      (apply #'git-run-command nil env "update-index" "--add" "--" (git-get-filenames added)))
+      (apply #'git-call-process-env nil env "update-index" "--add" "--" (git-get-filenames added)))
     (when deleted
-      (apply #'git-run-command nil env "update-index" "--remove" "--" (git-get-filenames deleted)))
+      (apply #'git-call-process-env nil env "update-index" "--remove" "--" (git-get-filenames deleted)))
     (when modified
-      (apply #'git-run-command nil env "update-index" "--" (git-get-filenames modified)))))
+      (apply #'git-call-process-env nil env "update-index" "--" (git-get-filenames modified)))))
 
 (defun git-run-pre-commit-hook ()
   "Run the pre-commit hook if any."
@@ -790,6 +790,7 @@ Return the list of files that haven't been handled."
                       head-tree (git-rev-parse "HEAD^{tree}")))
               (if files
                   (progn
+                    (message "Running git commit...")
                     (git-read-tree head-tree index-file)
                     (git-update-index nil files)         ;update both the default index
                     (git-update-index index-file files)  ;and the temporary one
@@ -801,7 +802,7 @@ Return the list of files that haven't been handled."
                             (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
                             (with-current-buffer buffer (erase-buffer))
                             (git-set-files-state files 'uptodate)
-                            (git-run-command nil nil "rerere")
+                            (git-call-process-env nil nil "rerere")
                             (git-refresh-files)
                             (git-refresh-ewoc-hf git-status)
                             (message "Committed %s." commit)
@@ -912,8 +913,9 @@ Return the list of files that haven't been handled."
   (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored))))
     (unless files
       (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
-    (apply #'git-run-command nil nil "update-index" "--add" "--" files)
-    (git-update-status-files files 'uptodate)))
+    (apply #'git-call-process-env nil nil "update-index" "--add" "--" files)
+    (git-update-status-files files 'uptodate)
+    (git-success-message "Added" files)))
 
 (defun git-ignore-file ()
   "Add marked file(s) to the ignore list."
@@ -922,7 +924,8 @@ Return the list of files that haven't been handled."
     (unless files
       (push (file-relative-name (read-file-name "File to ignore: " nil nil t)) files))
     (dolist (f files) (git-append-to-ignore f))
-    (git-update-status-files files 'ignored)))
+    (git-update-status-files files 'ignored)
+    (git-success-message "Ignored" files)))
 
 (defun git-remove-file ()
   "Remove the marked file(s)."
@@ -935,8 +938,9 @@ Return the list of files that haven't been handled."
         (progn
           (dolist (name files)
             (when (file-exists-p name) (delete-file name)))
-          (apply #'git-run-command nil nil "update-index" "--remove" "--" files)
-          (git-update-status-files files nil))
+          (apply #'git-call-process-env nil nil "update-index" "--remove" "--" files)
+          (git-update-status-files files nil)
+          (git-success-message "Removed" files))
       (message "Aborting"))))
 
 (defun git-revert-file ()
@@ -954,18 +958,20 @@ Return the list of files that haven't been handled."
           ('unmerged (push (git-fileinfo->name info) modified))
           ('modified (push (git-fileinfo->name info) modified))))
       (when added
-        (apply #'git-run-command nil nil "update-index" "--force-remove" "--" added))
+        (apply #'git-call-process-env nil nil "update-index" "--force-remove" "--" added))
       (when modified
-        (apply #'git-run-command nil nil "checkout" "HEAD" modified))
-      (git-update-status-files (append added modified) 'uptodate))))
+        (apply #'git-call-process-env nil nil "checkout" "HEAD" modified))
+      (git-update-status-files (append added modified) 'uptodate)
+      (git-success-message "Reverted" files))))
 
 (defun git-resolve-file ()
   "Resolve conflicts in marked file(s)."
   (interactive)
   (let ((files (git-get-filenames (git-marked-files-state 'unmerged))))
     (when files
-      (apply #'git-run-command nil nil "update-index" "--" files)
-      (git-update-status-files files 'uptodate))))
+      (apply #'git-call-process-env nil nil "update-index" "--" files)
+      (git-update-status-files files 'uptodate)
+      (git-success-message "Resolved" files))))
 
 (defun git-remove-handled ()
   "Remove handled files from the status list."
@@ -992,9 +998,11 @@ Return the list of files that haven't been handled."
   (interactive)
   (if (setq git-show-ignored (not git-show-ignored))
       (progn
+        (message "Inserting ignored files...")
         (git-run-ls-files-with-excludes git-status nil 'ignored "-o" "-i")
         (git-refresh-files)
-        (git-refresh-ewoc-hf git-status))
+        (git-refresh-ewoc-hf git-status)
+        (message "Inserting ignored files...done"))
     (git-remove-handled)))
 
 (defun git-toggle-show-unknown ()
@@ -1002,9 +1010,11 @@ Return the list of files that haven't been handled."
   (interactive)
   (if (setq git-show-unknown (not git-show-unknown))
       (progn
+        (message "Inserting unknown files...")
         (git-run-ls-files-with-excludes git-status nil 'unknown "-o")
         (git-refresh-files)
-        (git-refresh-ewoc-hf git-status))
+        (git-refresh-ewoc-hf git-status)
+        (message "Inserting unknown files...done"))
     (git-remove-handled)))
 
 (defun git-setup-diff-buffer (buffer)
@@ -1207,7 +1217,8 @@ Return the list of files that haven't been handled."
          (marked-files (git-get-filenames (ewoc-collect status (lambda (info) (git-fileinfo->marked info)))))
          (cur-name (and pos (git-fileinfo->name (ewoc-data pos)))))
     (unless status (error "Not in git-status buffer."))
-    (git-run-command nil nil "update-index" "--refresh")
+    (message "Refreshing git status...")
+    (git-call-process-env nil nil "update-index" "--refresh")
     (git-clear-status status)
     (git-update-status-files nil)
     ; restore file marks
@@ -1219,6 +1230,7 @@ Return the list of files that haven't been handled."
                                 marked-files)
       (git-refresh-files))
     ; move point to the current file name if any
+    (message "Refreshing git status...done")
     (let ((node (and cur-name (git-find-status-file status cur-name))))
       (when node (ewoc-goto-node status node)))))
 
-- 
1.5.3.2.121.gf7223

-- 
Alexandre Julliard
julliard@winehq.org
