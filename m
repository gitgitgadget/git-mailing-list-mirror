From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/4] git.el: Support for showing unknown/ignored directories.
Date: Thu, 07 Feb 2008 13:50:19 +0100
Message-ID: <87zludorqs.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 13:51:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6Db-0006UB-67
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbYBGMug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbYBGMuf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:50:35 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:60798 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119AbYBGMua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:50:30 -0500
Received: from adsl-84-227-175-174.adslplus.ch ([84.227.175.174] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JN6Cr-0006rp-V6
	for git@vger.kernel.org; Thu, 07 Feb 2008 06:50:28 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7ACAD1E7141; Thu,  7 Feb 2008 13:50:19 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72930>

Instead of recursing into directories that only contain unknown files,
display only the directory itself. Its contents can be expanded with
git-find-file (bound to C-m).

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   38 +++++++++++++++++++++++++++++---------
 1 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index d8a0638..58d72a5 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -558,12 +558,15 @@ and returns the process output as a string."
 		     (?\100 "   (type change file -> subproject)")
 		     (?\120 "   (type change symlink -> subproject)")
 		     (t "   (subproject)")))
+                  (?\110 nil)  ;; directory (internal, not a real git state)
 		  (?\000  ;; deleted or unknown
 		   (case old-type
 		     (?\120 "   (symlink)")
 		     (?\160 "   (subproject)")))
 		  (t (format "   (unknown type %o)" new-type)))))
-    (if str (propertize str 'face 'git-status-face) "")))
+    (cond (str (propertize str 'face 'git-status-face))
+          ((eq new-type ?\110) "/")
+          (t ""))))
 
 (defun git-rename-as-string (info)
   "Return a string describing the copy or rename associated with INFO, or an empty string if none."
@@ -666,9 +669,11 @@ Return the list of files that haven't been handled."
     (with-temp-buffer
       (apply #'git-call-process-env t nil "ls-files" "-z" (append options (list "--") files))
       (goto-char (point-min))
-      (while (re-search-forward "\\([^\0]*\\)\0" nil t 1)
+      (while (re-search-forward "\\([^\0]*?\\)\\(/?\\)\0" nil t 1)
         (let ((name (match-string 1)))
-          (push (git-create-fileinfo default-state name) infolist)
+          (push (git-create-fileinfo default-state name 0
+                                     (if (string-equal "/" (match-string 2)) (lsh ?\110 9) 0))
+                infolist)
           (setq files (delete name files)))))
     (git-insert-info-list status infolist)
     files))
@@ -713,7 +718,7 @@ Return the list of files that haven't been handled."
 (defun git-run-ls-files-with-excludes (status files default-state &rest options)
   "Run git-ls-files on FILES with appropriate --exclude-from options."
   (let ((exclude-files (git-get-exclude-files)))
-    (apply #'git-run-ls-files status files default-state
+    (apply #'git-run-ls-files status files default-state "--directory"
            (concat "--exclude-per-directory=" git-per-dir-ignore-file)
            (append options (mapcar (lambda (f) (concat "--exclude-from=" f)) exclude-files)))))
 
@@ -957,6 +962,7 @@ Return the list of files that haven't been handled."
   "Add marked file(s) to the index cache."
   (interactive)
   (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored))))
+    ;; FIXME: add support for directories
     (unless files
       (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
     (apply #'git-call-process-env nil nil "update-index" "--add" "--" files)
@@ -983,7 +989,10 @@ Return the list of files that haven't been handled."
          (format "Remove %d file%s? " (length files) (if (> (length files) 1) "s" "")))
         (progn
           (dolist (name files)
-            (when (file-exists-p name) (delete-file name)))
+            (ignore-errors
+              (if (file-directory-p name)
+                  (delete-directory name)
+                (delete-file name))))
           (apply #'git-call-process-env nil nil "update-index" "--remove" "--" files)
           (git-update-status-files files nil)
           (git-success-message "Removed" files))
@@ -992,7 +1001,7 @@ Return the list of files that haven't been handled."
 (defun git-revert-file ()
   "Revert changes to the marked file(s)."
   (interactive)
-  (let ((files (git-marked-files))
+  (let ((files (git-marked-files-state 'added 'deleted 'modified 'unmerged))
         added modified)
     (when (and files
                (yes-or-no-p
@@ -1063,6 +1072,16 @@ Return the list of files that haven't been handled."
         (message "Inserting unknown files...done"))
     (git-remove-handled)))
 
+(defun git-expand-directory (info)
+  "Expand the directory represented by INFO to list its files."
+  (when (eq (lsh (git-fileinfo->new-perm info) -9) ?\110)
+    (let ((dir (git-fileinfo->name info)))
+      (git-set-filenames-state git-status (list dir) nil)
+      (git-run-ls-files-with-excludes git-status (list (concat dir "/")) 'unknown "-o")
+      (git-refresh-files)
+      (git-refresh-ewoc-hf git-status)
+      t)))
+
 (defun git-setup-diff-buffer (buffer)
   "Setup a buffer for displaying a diff."
   (let ((dir default-directory))
@@ -1237,9 +1256,10 @@ Return the list of files that haven't been handled."
   (interactive)
   (unless git-status (error "Not in git-status buffer."))
   (let ((info (ewoc-data (ewoc-locate git-status))))
-    (find-file (git-fileinfo->name info))
-    (when (eq 'unmerged (git-fileinfo->state info))
-      (smerge-mode 1))))
+    (unless (git-expand-directory info)
+      (find-file (git-fileinfo->name info))
+      (when (eq 'unmerged (git-fileinfo->state info))
+        (smerge-mode 1)))))
 
 (defun git-find-file-other-window ()
   "Visit the current file in its own buffer in another window."
-- 
1.5.4.38.g0d380

-- 
Alexandre Julliard
julliard@winehq.org
