From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Support for incremental status updates.
Date: Tue, 24 Jul 2007 12:12:47 +0200
Message-ID: <87sl7ekt40.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 12:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDHNx-00084i-5S
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 12:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761804AbXGXKMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 06:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762549AbXGXKMw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 06:12:52 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:41216 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758490AbXGXKMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 06:12:51 -0400
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Jul 2007 06:12:51 EDT
Received: from adsl-62-167-26-204.adslplus.ch ([62.167.26.204] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IDHNp-0005Vw-Kb
	for git@vger.kernel.org; Tue, 24 Jul 2007 05:12:50 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B1C5E1E7182; Tue, 24 Jul 2007 12:12:47 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53552>

When we know which files have been modified, we can now run diff-index
or ls-files with a file list to refresh only the specified files
instead of the whole project.

This also allows proper refreshing of files upon add/delete/resolve,
instead of making assumptions about the new file state.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |  224 +++++++++++++++++++++++++-------------------------
 1 files changed, 113 insertions(+), 111 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index d7f4316..53dd703 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -314,8 +314,8 @@ and returns the process output as a string."
     (sort-lines nil (point-min) (point-max))
     (save-buffer))
   (when created
-    (git-run-command nil nil "update-index" "--info-only" "--add" "--" (file-relative-name ignore-name)))
-  (git-add-status-file (if created 'added 'modified) (file-relative-name ignore-name))))
+    (git-run-command nil nil "update-index" "--add" "--" (file-relative-name ignore-name)))
+  (git-update-status-files (list (file-relative-name ignore-name)) 'unknown)))
 
 ; propertize definition for XEmacs, stolen from erc-compat
 (eval-when-compile
@@ -523,23 +523,39 @@ and returns the process output as a string."
                   "  " (git-escape-file-name (git-fileinfo->name info))
                   (git-rename-as-string info))))
 
-(defun git-parse-status (status)
-  "Parse the output of git-diff-index in the current buffer."
-  (goto-char (point-min))
-  (while (re-search-forward
-          ":\\([0-7]\\{6\\}\\) \\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} \\(\\([ADMU]\\)\0\\([^\0]+\\)\\|\\([CR]\\)[0-9]*\0\\([^\0]+\\)\0\\([^\0]+\\)\\)\0"
-          nil t 1)
-    (let ((old-perm (string-to-number (match-string 1) 8))
-          (new-perm (string-to-number (match-string 2) 8))
-          (state (or (match-string 4) (match-string 6)))
-          (name (or (match-string 5) (match-string 7)))
-          (new-name (match-string 8)))
-      (if new-name  ; copy or rename
-          (if (eq ?C (string-to-char state))
-              (ewoc-enter-last status (git-create-fileinfo 'added new-name old-perm new-perm 'copy name))
-            (ewoc-enter-last status (git-create-fileinfo 'deleted name 0 0 'rename new-name))
-            (ewoc-enter-last status (git-create-fileinfo 'added new-name old-perm new-perm 'rename name)))
-        (ewoc-enter-last status (git-create-fileinfo (git-state-code state) name old-perm new-perm))))))
+(defun git-insert-fileinfo (status info &optional refresh)
+  "Insert INFO in the status buffer, optionally refreshing an existing one."
+  (let ((node (and refresh
+                   (git-find-status-file status (git-fileinfo->name info)))))
+    (setf (git-fileinfo->needs-refresh info) t)
+    (when node   ;preserve the marked flag
+      (setf (git-fileinfo->marked info) (git-fileinfo->marked (ewoc-data node))))
+    (if node (ewoc-set-data node info) (ewoc-enter-last status info))))
+
+(defun git-run-diff-index (status files)
+  "Run git-diff-index on FILES and parse the results into STATUS.
+Return the list of files that haven't been handled."
+  (let ((refresh files))
+    (with-temp-buffer
+      (apply #'git-run-command t nil "diff-index" "-z" "-M" "HEAD" "--" files)
+      (goto-char (point-min))
+      (while (re-search-forward
+              ":\\([0-7]\\{6\\}\\) \\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-9a-f]\\{40\\} \\(\\([ADMU]\\)\0\\([^\0]+\\)\\|\\([CR]\\)[0-9]*\0\\([^\0]+\\)\0\\([^\0]+\\)\\)\0"
+              nil t 1)
+        (let ((old-perm (string-to-number (match-string 1) 8))
+              (new-perm (string-to-number (match-string 2) 8))
+              (state (or (match-string 4) (match-string 6)))
+              (name (or (match-string 5) (match-string 7)))
+              (new-name (match-string 8)))
+          (if new-name  ; copy or rename
+              (if (eq ?C (string-to-char state))
+                  (git-insert-fileinfo status (git-create-fileinfo 'added new-name old-perm new-perm 'copy name) refresh)
+                (git-insert-fileinfo status (git-create-fileinfo 'deleted name 0 0 'rename new-name) refresh)
+                (git-insert-fileinfo status (git-create-fileinfo 'added new-name old-perm new-perm 'rename name)) refresh)
+            (git-insert-fileinfo status (git-create-fileinfo (git-state-code state) name old-perm new-perm) refresh))
+          (setq files (delete name files))
+          (when new-name (setq files (delete new-name files)))))))
+  files)
 
 (defun git-find-status-file (status file)
   "Find a given file in the status ewoc and return its node."
@@ -548,32 +564,59 @@ and returns the process output as a string."
       (setq node (ewoc-next status node)))
     node))
 
-(defun git-parse-ls-files (status default-state &optional skip-existing)
-  "Parse the output of git-ls-files in the current buffer."
-  (goto-char (point-min))
-  (let (infolist)
-    (while (re-search-forward "\\([HMRCK?]\\) \\([^\0]*\\)\0" nil t 1)
-      (let ((state (match-string 1))
-            (name (match-string 2)))
-        (unless (and skip-existing (git-find-status-file status name))
-          (push (git-create-fileinfo (or (git-state-code state) default-state) name) infolist))))
-    (dolist (info (nreverse infolist))
-      (ewoc-enter-last status info))))
-
-(defun git-parse-ls-unmerged (status)
-  "Parse the output of git-ls-files -u in the current buffer."
-  (goto-char (point-min))
-  (let (files)
-    (while (re-search-forward "[0-7]\\{6\\} [0-9a-f]\\{40\\} [123]\t\\([^\0]+\\)\0" nil t)
-      (let ((node (git-find-status-file status (match-string 1))))
-        (when node (push (ewoc-data node) files))))
-    (git-set-files-state files 'unmerged)))
-
-(defun git-add-status-file (state name)
-  "Add a new file to the status list (if not existing already) and return its node."
+(defun git-run-ls-files (status files default-state &rest options)
+  "Run git-ls-files on FILES and parse the results into STATUS.
+Return the list of files that haven't been handled."
+  (let ((refresh files))
+    (with-temp-buffer
+      (apply #'git-run-command t nil "ls-files" "-z" "-t" (append options (list "--") files))
+      (goto-char (point-min))
+      (while (re-search-forward "\\([HMRCK?]\\) \\([^\0]*\\)\0" nil t 1)
+        (let ((state (match-string 1))
+              (name (match-string 2)))
+          (git-insert-fileinfo status (git-create-fileinfo (or (git-state-code state) default-state) name) refresh)
+          (setq files (delete name files))))))
+  files)
+
+(defun git-run-ls-unmerged (status files)
+  "Run git-ls-files -u on FILES and parse the results into STATUS."
+  (with-temp-buffer
+    (apply #'git-run-command t nil "ls-files" "-z" "-u" "--" files)
+    (goto-char (point-min))
+    (let (unmerged-files)
+      (while (re-search-forward "[0-7]\\{6\\} [0-9a-f]\\{40\\} [123]\t\\([^\0]+\\)\0" nil t)
+        (let ((node (git-find-status-file status (match-string 1))))
+          (when node (push (ewoc-data node) unmerged-files))))
+      (git-set-files-state unmerged-files 'unmerged))))
+
+(defun git-update-status-files (files &optional default-state)
+  "Update the status of FILES from the index."
   (unless git-status (error "Not in git-status buffer."))
-  (or (git-find-status-file git-status name)
-      (ewoc-enter-last git-status (git-create-fileinfo state name))))
+  (let* ((status git-status)
+         (remaining-files
+          (if (git-empty-db-p) ; we need some special handling for an empty db
+              (git-run-ls-files status files 'added "-c")
+            (git-run-diff-index status files))))
+    (git-run-ls-unmerged status files)
+    (when (and (or (not files) remaining-files)
+               (file-readable-p ".git/info/exclude"))
+      (setq remaining-files (git-run-ls-files status remaining-files
+                                              'unknown "-o" "--exclude-from=.git/info/exclude"
+                                              (concat "--exclude-per-directory=" git-per-dir-ignore-file))))
+    ; mark remaining files with the default state (or remove them if nil)
+    (when remaining-files
+      (if default-state
+          (ewoc-map (lambda (info)
+                      (when (member (git-fileinfo->name info) remaining-files)
+                        (git-set-files-state (list info) default-state))
+                      nil)
+                    status)
+        (ewoc-filter status
+                     (lambda (info files)
+                       (not (member (git-fileinfo->name info) files)))
+                     remaining-files)))
+    (git-refresh-files)
+    (git-refresh-ewoc-hf status)))
 
 (defun git-marked-files ()
   "Return a list of all marked files, or if none a list containing just the file at cursor position."
@@ -789,54 +832,34 @@ and returns the process output as a string."
 (defun git-add-file ()
   "Add marked file(s) to the index cache."
   (interactive)
-  (let ((files (git-marked-files-state 'unknown)))
+  (let ((files (git-get-filenames (git-marked-files-state 'unknown))))
     (unless files
-      (push (ewoc-data
-             (git-add-status-file 'added (file-relative-name
-                                          (read-file-name "File to add: " nil nil t))))
-            files))
-    (apply #'git-run-command nil nil "update-index" "--info-only" "--add" "--" (git-get-filenames files))
-    (git-set-files-state files 'added)
-    (git-refresh-files)))
+      (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
+    (apply #'git-run-command nil nil "update-index" "--add" "--" files)
+    (git-update-status-files files 'uptodate)))
 
 (defun git-ignore-file ()
   "Add marked file(s) to the ignore list."
   (interactive)
-  (let ((files (git-marked-files-state 'unknown)))
+  (let ((files (git-get-filenames (git-marked-files-state 'unknown))))
     (unless files
-      (push (ewoc-data
-             (git-add-status-file 'unknown (file-relative-name
-                                            (read-file-name "File to ignore: " nil nil t))))
-            files))
-    (dolist (info files) (git-append-to-ignore (git-fileinfo->name info)))
-    (git-set-files-state files 'ignored)
-    (git-refresh-files)))
+      (push (file-relative-name (read-file-name "File to ignore: " nil nil t)) files))
+    (dolist (f files) (git-append-to-ignore f))
+    (git-update-status-files files 'ignored)))
 
 (defun git-remove-file ()
   "Remove the marked file(s)."
   (interactive)
-  (let ((files (git-marked-files-state 'added 'modified 'unknown 'uptodate)))
+  (let ((files (git-get-filenames (git-marked-files-state 'added 'modified 'unknown 'uptodate))))
     (unless files
-      (push (ewoc-data
-             (git-add-status-file 'unknown (file-relative-name
-                                            (read-file-name "File to remove: " nil nil t))))
-            files))
+      (push (file-relative-name (read-file-name "File to remove: " nil nil t)) files))
     (if (yes-or-no-p
          (format "Remove %d file%s? " (length files) (if (> (length files) 1) "s" "")))
         (progn
-          (dolist (info files)
-            (let ((name (git-fileinfo->name info)))
-              (when (file-exists-p name) (delete-file name))))
-          (apply #'git-run-command nil nil "update-index" "--info-only" "--remove" "--" (git-get-filenames files))
-          ; remove unknown files from the list, set the others to deleted
-          (ewoc-filter git-status
-                       (lambda (info files)
-                         (not (and (memq info files) (eq (git-fileinfo->state info) 'unknown))))
-                       files)
-          (git-set-files-state files 'deleted)
-          (git-refresh-files)
-          (unless (ewoc-nth git-status 0)  ; refresh header if list is empty
-            (git-refresh-ewoc-hf git-status)))
+          (dolist (name files)
+            (when (file-exists-p name) (delete-file name)))
+          (apply #'git-run-command nil nil "update-index" "--remove" "--" files)
+          (git-update-status-files files nil))
       (message "Aborting"))))
 
 (defun git-revert-file ()
@@ -849,26 +872,23 @@ and returns the process output as a string."
                 (format "Revert %d file%s? " (length files) (if (> (length files) 1) "s" ""))))
       (dolist (info files)
         (case (git-fileinfo->state info)
-          ('added (push info added))
-          ('deleted (push info modified))
-          ('unmerged (push info modified))
-          ('modified (push info modified))))
+          ('added (push (git-fileinfo->name info) added))
+          ('deleted (push (git-fileinfo->name info) modified))
+          ('unmerged (push (git-fileinfo->name info) modified))
+          ('modified (push (git-fileinfo->name info) modified))))
       (when added
-          (apply #'git-run-command nil nil "update-index" "--force-remove" "--" (git-get-filenames added))
-          (git-set-files-state added 'unknown))
+        (apply #'git-run-command nil nil "update-index" "--force-remove" "--" added))
       (when modified
-          (apply #'git-run-command nil nil "checkout" "HEAD" (git-get-filenames modified))
-          (git-set-files-state modified 'uptodate))
-      (git-refresh-files))))
+        (apply #'git-run-command nil nil "checkout" "HEAD" modified))
+      (git-update-status-files (append added modified) 'uptodate))))
 
 (defun git-resolve-file ()
   "Resolve conflicts in marked file(s)."
   (interactive)
-  (let ((files (git-marked-files-state 'unmerged)))
+  (let ((files (git-get-filenames (git-marked-files-state 'unmerged))))
     (when files
-      (apply #'git-run-command nil nil "update-index" "--" (git-get-filenames files))
-      (git-set-files-state files 'modified)
-      (git-refresh-files))))
+      (apply #'git-run-command nil nil "update-index" "--" files)
+      (git-update-status-files files 'uptodate))))
 
 (defun git-remove-handled ()
   "Remove handled files from the status list."
@@ -1071,27 +1091,9 @@ and returns the process output as a string."
          (pos (ewoc-locate status))
          (cur-name (and pos (git-fileinfo->name (ewoc-data pos)))))
     (unless status (error "Not in git-status buffer."))
+    (git-run-command nil nil "update-index" "--refresh")
     (git-clear-status status)
-    (git-run-command nil nil "update-index" "--info-only" "--refresh")
-    (if (git-empty-db-p)
-        ; we need some special handling for an empty db
-        (with-temp-buffer
-          (git-run-command t nil "ls-files" "-z" "-t" "-c")
-          (git-parse-ls-files status 'added))
-      (with-temp-buffer
-        (git-run-command t nil "diff-index" "-z" "-M" "HEAD")
-        (git-parse-status status)))
-      (with-temp-buffer
-        (git-run-command t nil "ls-files" "-z" "-u")
-        (git-parse-ls-unmerged status))
-      (when (file-readable-p ".git/info/exclude")
-        (with-temp-buffer
-          (git-run-command t nil "ls-files" "-z" "-t" "-o"
-                           "--exclude-from=.git/info/exclude"
-                           (concat "--exclude-per-directory=" git-per-dir-ignore-file))
-          (git-parse-ls-files status 'unknown)))
-    (git-refresh-files)
-    (git-refresh-ewoc-hf status)
+    (git-update-status-files nil)
     ; move point to the current file name if any
     (let ((node (and cur-name (git-find-status-file status cur-name))))
       (when node (ewoc-goto-node status node)))))
-- 
1.5.3.rc2.39.g82303f

-- 
Alexandre Julliard
julliard@winehq.org
