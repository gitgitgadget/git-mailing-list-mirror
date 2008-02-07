From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 4/4] git.el: Better handling of subprocess errors.
Date: Thu, 07 Feb 2008 13:51:34 +0100
Message-ID: <87myqdorop.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 13:52:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6FE-00073P-Bo
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791AbYBGMvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYBGMvu
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:51:50 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:60871 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761340AbYBGMvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:51:48 -0500
Received: from adsl-84-227-175-174.adslplus.ch ([84.227.175.174] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JN6E4-0006tB-Pb
	for git@vger.kernel.org; Thu, 07 Feb 2008 06:51:47 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 5461B1E7141; Thu,  7 Feb 2008 13:51:34 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72931>

Where possible, capture the output of the git command and display it
if the command fails.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   88 +++++++++++++++++++++++++++++---------------------
 1 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e1058b9..a8bf0ef 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -35,7 +35,6 @@
 ;;
 ;; TODO
 ;;  - portability to XEmacs
-;;  - better handling of subprocess errors
 ;;  - diff against other branch
 ;;  - renaming files from the status buffer
 ;;  - creating tags
@@ -191,6 +190,18 @@ if there is already one that displays the same directory."
              (append (git-get-env-strings env) (list "git") args))
     (apply #'call-process "git" nil buffer nil args)))
 
+(defun git-call-process-display-error (&rest args)
+  "Wrapper for call-process that displays error messages."
+  (let* ((dir default-directory)
+         (buffer (get-buffer-create "*Git Command Output*"))
+         (ok (with-current-buffer buffer
+               (let ((default-directory dir)
+                     (buffer-read-only nil))
+                 (erase-buffer)
+                 (eq 0 (apply 'call-process "git" nil (list buffer t) nil args))))))
+    (unless ok (display-message-or-buffer buffer))
+    ok))
+
 (defun git-call-process-env-string (env &rest args)
   "Wrapper for call-process that sets environment strings,
 and returns the process output as a string."
@@ -377,7 +388,7 @@ and returns the process output as a string."
     (when reason
      (push reason args)
      (push "-m" args))
-    (eq 0 (apply #'git-call-process-env nil nil "update-ref" args))))
+    (apply 'git-call-process-display-error "update-ref" args)))
 
 (defun git-read-tree (tree &optional index-file)
   "Read a tree into the index file."
@@ -866,16 +877,17 @@ Return the list of files that haven't been handled."
                       (if (or (not (string-equal tree head-tree))
                               (yes-or-no-p "The tree was not modified, do you really want to perform an empty commit? "))
                           (let ((commit (git-commit-tree buffer tree head)))
-                            (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
-                            (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
-                            (with-current-buffer buffer (erase-buffer))
-			    (git-update-status-files (git-get-filenames files) 'uptodate)
-                            (git-call-process-env nil nil "rerere")
-                            (git-call-process-env nil nil "gc" "--auto")
-                            (git-refresh-files)
-                            (git-refresh-ewoc-hf git-status)
-                            (message "Committed %s." commit)
-                            (git-run-hook "post-commit" nil))
+                            (when commit
+                              (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
+                              (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
+                              (with-current-buffer buffer (erase-buffer))
+                              (git-update-status-files (git-get-filenames files) 'uptodate)
+                              (git-call-process-env nil nil "rerere")
+                              (git-call-process-env nil nil "gc" "--auto")
+                              (git-refresh-files)
+                              (git-refresh-ewoc-hf git-status)
+                              (message "Committed %s." commit)
+                              (git-run-hook "post-commit" nil)))
                         (message "Commit aborted."))))
                 (message "No files to commit.")))
           (delete-file index-file))))))
@@ -986,9 +998,9 @@ Return the list of files that haven't been handled."
     ;; FIXME: add support for directories
     (unless files
       (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
-    (apply #'git-call-process-env nil nil "update-index" "--add" "--" files)
-    (git-update-status-files files 'uptodate)
-    (git-success-message "Added" files)))
+    (when (apply 'git-call-process-display-error "update-index" "--add" "--" files)
+      (git-update-status-files files 'uptodate)
+      (git-success-message "Added" files))))
 
 (defun git-ignore-file ()
   "Add marked file(s) to the ignore list."
@@ -1014,9 +1026,9 @@ Return the list of files that haven't been handled."
               (if (file-directory-p name)
                   (delete-directory name)
                 (delete-file name))))
-          (apply #'git-call-process-env nil nil "update-index" "--remove" "--" files)
-          (git-update-status-files files nil)
-          (git-success-message "Removed" files))
+          (when (apply 'git-call-process-display-error "update-index" "--remove" "--" files)
+            (git-update-status-files files nil)
+            (git-success-message "Removed" files)))
       (message "Aborting"))))
 
 (defun git-revert-file ()
@@ -1034,28 +1046,30 @@ Return the list of files that haven't been handled."
           ('unmerged (push (git-fileinfo->name info) modified))
           ('modified (push (git-fileinfo->name info) modified))))
       ;; check if a buffer contains one of the files and isn't saved
-      (dolist (file (append added modified))
+      (dolist (file modified)
         (let ((buffer (get-file-buffer file)))
           (when (and buffer (buffer-modified-p buffer))
             (error "Buffer %s is modified. Please kill or save modified buffers before reverting." (buffer-name buffer)))))
-      (when added
-        (apply #'git-call-process-env nil nil "update-index" "--force-remove" "--" added))
-      (when modified
-        (apply #'git-call-process-env nil nil "checkout" "HEAD" modified))
-      (git-update-status-files (append added modified) 'uptodate)
-      (dolist (file (append added modified))
-        (let ((buffer (get-file-buffer file)))
-          (when buffer (with-current-buffer buffer (revert-buffer t t t)))))
-      (git-success-message "Reverted" (git-get-filenames files)))))
+      (let ((ok (and
+                 (or (not added)
+                     (apply 'git-call-process-display-error "update-index" "--force-remove" "--" added))
+                 (or (not modified)
+                     (apply 'git-call-process-display-error "checkout" "HEAD" modified)))))
+        (git-update-status-files (append added modified) 'uptodate)
+        (when ok
+          (dolist (file modified)
+            (let ((buffer (get-file-buffer file)))
+              (when buffer (with-current-buffer buffer (revert-buffer t t t)))))
+          (git-success-message "Reverted" (git-get-filenames files)))))))
 
 (defun git-resolve-file ()
   "Resolve conflicts in marked file(s)."
   (interactive)
   (let ((files (git-get-filenames (git-marked-files-state 'unmerged))))
     (when files
-      (apply #'git-call-process-env nil nil "update-index" "--" files)
-      (git-update-status-files files 'uptodate)
-      (git-success-message "Resolved" files))))
+      (when (apply 'git-call-process-display-error "update-index" "--" files)
+        (git-update-status-files files 'uptodate)
+        (git-success-message "Resolved" files)))))
 
 (defun git-remove-handled ()
   "Remove handled files from the status list."
@@ -1320,12 +1334,12 @@ amended version of it."
   (when (git-empty-db-p) (error "No commit to amend."))
   (let* ((commit (git-rev-parse "HEAD"))
          (files (git-get-commit-files commit)))
-    (git-call-process-env nil nil "reset" "--soft" "HEAD^")
-    (git-update-status-files (copy-sequence files) 'uptodate)
-    (git-mark-files git-status files)
-    (git-refresh-files)
-    (git-setup-commit-buffer commit)
-    (git-commit-file)))
+    (when (git-call-process-display-error "reset" "--soft" "HEAD^")
+      (git-update-status-files (copy-sequence files) 'uptodate)
+      (git-mark-files git-status files)
+      (git-refresh-files)
+      (git-setup-commit-buffer commit)
+      (git-commit-file))))
 
 (defun git-find-file ()
   "Visit the current file in its own buffer."
-- 
1.5.4.38.g0d380

-- 
Alexandre Julliard
julliard@winehq.org
