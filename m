From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/3] git.el: Refresh files from their real state upon commit.
Date: Tue, 08 Jan 2008 14:46:22 +0100
Message-ID: <87y7b0ig5t.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 14:47:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCEnB-0007TM-IY
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 14:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbYAHNq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 08:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYAHNq2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 08:46:28 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:38253 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbYAHNq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 08:46:28 -0500
Received: from adsl-62-167-25-224.adslplus.ch ([62.167.25.224] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JCEme-00026P-DU
	for git@vger.kernel.org; Tue, 08 Jan 2008 07:46:27 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 10E7C1E7166; Tue,  8 Jan 2008 14:46:22 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69878>

Instead of just setting the state to up-to-date, retrieve the full
state again, so that the file type can be displayed properly.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 885ad20..825b1e9 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -626,7 +626,8 @@ and returns the process output as a string."
 (defun git-run-diff-index (status files)
   "Run git-diff-index on FILES and parse the results into STATUS.
 Return the list of files that haven't been handled."
-  (let (infolist)
+  (let ((remaining (copy-sequence files))
+        infolist)
     (with-temp-buffer
       (apply #'git-call-process-env t nil "diff-index" "-z" "-M" "HEAD" "--" files)
       (goto-char (point-min))
@@ -644,10 +645,10 @@ Return the list of files that haven't been handled."
                 (push (git-create-fileinfo 'deleted name 0 0 'rename new-name) infolist)
                 (push (git-create-fileinfo 'added new-name old-perm new-perm 'rename name) infolist))
             (push (git-create-fileinfo (git-state-code state) name old-perm new-perm) infolist))
-          (setq files (delete name files))
-          (when new-name (setq files (delete new-name files))))))
+          (setq remaining (delete name remaining))
+          (when new-name (setq remaining (delete new-name remaining))))))
     (git-insert-info-list status infolist)
-    files))
+    remaining))
 
 (defun git-find-status-file (status file)
   "Find a given file in the status ewoc and return its node."
@@ -673,7 +674,8 @@ Return the list of files that haven't been handled."
 (defun git-run-ls-files-cached (status files default-state)
   "Run git-ls-files -c on FILES and parse the results into STATUS.
 Return the list of files that haven't been handled."
-  (let (infolist)
+  (let ((remaining (copy-sequence files))
+        infolist)
     (with-temp-buffer
       (apply #'git-call-process-env t nil "ls-files" "-z" "-s" "-c" "--" files)
       (goto-char (point-min))
@@ -682,9 +684,9 @@ Return the list of files that haven't been handled."
 	       (old-perm (if (eq default-state 'added) 0 new-perm))
 	       (name (match-string 2)))
 	  (push (git-create-fileinfo default-state name old-perm new-perm) infolist)
-	  (setq files (delete name files)))))
+	  (setq remaining (delete name remaining)))))
     (git-insert-info-list status infolist)
-    files))
+    remaining))
 
 (defun git-run-ls-unmerged (status files)
   "Run git-ls-files -u on FILES and parse the results into STATUS."
@@ -716,8 +718,8 @@ Return the list of files that haven't been handled."
 (defun git-update-status-files (files &optional default-state)
   "Update the status of FILES from the index."
   (unless git-status (error "Not in git-status buffer."))
-  (unless files
-    (when git-show-uptodate (git-run-ls-files-cached git-status nil 'uptodate)))
+  (when (or git-show-uptodate files)
+    (git-run-ls-files-cached git-status files 'uptodate))
   (let* ((remaining-files
           (if (git-empty-db-p) ; we need some special handling for an empty db
 	      (git-run-ls-files-cached git-status files 'added)
@@ -839,7 +841,7 @@ Return the list of files that haven't been handled."
                             (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
                             (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
                             (with-current-buffer buffer (erase-buffer))
-                            (dolist (info files) (git-set-fileinfo-state info 'uptodate))
+                            (git-update-status-files (git-get-filenames files) 'uptodate)
                             (git-call-process-env nil nil "rerere")
                             (git-call-process-env nil nil "gc" "--auto")
                             (git-refresh-files)
-- 
1.5.4.rc2.71.ge10a9

-- 
Alexandre Julliard
julliard@winehq.org
