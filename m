From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Add a commit description to the reflog.
Date: Thu, 19 Apr 2007 13:16:58 +0200
Message-ID: <873b2wobpx.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 13:17:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeUdu-0008Nh-PZ
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 13:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030970AbXDSLRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 07:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031201AbXDSLRH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 07:17:07 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:60078 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030970AbXDSLRF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 07:17:05 -0400
Received: from adsl-89-217-134-76.adslplus.ch ([89.217.134.76] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HeUdL-0007Gg-Nn
	for git@vger.kernel.org; Thu, 19 Apr 2007 06:17:04 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 952704F691; Thu, 19 Apr 2007 13:16:58 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45002>

Add a description of the commit to the reflog using the first line of
the log message, the same way the git-commit script does it.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   42 ++++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 2f9995e..f600179 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -345,9 +345,15 @@ and returns the process output as a string."
   (let ((str (git-call-process-env-string nil "symbolic-ref" ref)))
     (and str (car (split-string str "\n")))))
 
-(defun git-update-ref (ref val &optional oldval)
+(defun git-update-ref (ref newval &optional oldval reason)
   "Update a reference by calling git-update-ref."
-  (apply #'git-call-process-env nil nil "update-ref" ref val (if oldval (list oldval))))
+  (let ((args (and oldval (list oldval))))
+    (push newval args)
+    (push ref args)
+    (when reason
+     (push reason args)
+     (push "-m" args))
+    (eq 0 (apply #'git-call-process-env nil nil "update-ref" args))))
 
 (defun git-read-tree (tree &optional index-file)
   "Read a tree into the index file."
@@ -364,8 +370,10 @@ and returns the process output as a string."
   "Call git-commit-tree with buffer as input and return the resulting commit SHA1."
   (let ((author-name (git-get-committer-name))
         (author-email (git-get-committer-email))
+        (subject "commit (initial): ")
         author-date log-start log-end args coding-system-for-write)
     (when head
+      (setq subject "commit: ")
       (push "-p" args)
       (push head args))
     (with-current-buffer buffer
@@ -384,22 +392,29 @@ and returns the process output as a string."
             (goto-char (point-min))
             (while (re-search-forward "^Parent: +\\([0-9a-f]+\\)" nil t)
               (unless (string-equal head (match-string 1))
+                (setq subject "commit (merge): ")
                 (push "-p" args)
                 (push (match-string 1) args))))
         (setq log-start (point-min)))
       (setq log-end (point-max))
+      (goto-char log-start)
+      (when (re-search-forward ".*$" nil t)
+        (setq subject (concat subject (match-string 0))))
       (setq coding-system-for-write buffer-file-coding-system))
-    (git-get-string-sha1
-     (with-output-to-string
-       (with-current-buffer standard-output
-         (let ((env `(("GIT_AUTHOR_NAME" . ,author-name)
-                      ("GIT_AUTHOR_EMAIL" . ,author-email)
-                      ("GIT_COMMITTER_NAME" . ,(git-get-committer-name))
-                      ("GIT_COMMITTER_EMAIL" . ,(git-get-committer-email)))))
-           (when author-date (push `("GIT_AUTHOR_DATE" . ,author-date) env))
-           (apply #'git-run-command-region
-                  buffer log-start log-end env
-                  "commit-tree" tree (nreverse args))))))))
+    (let ((commit
+           (git-get-string-sha1
+            (with-output-to-string
+              (with-current-buffer standard-output
+                (let ((env `(("GIT_AUTHOR_NAME" . ,author-name)
+                             ("GIT_AUTHOR_EMAIL" . ,author-email)
+                             ("GIT_COMMITTER_NAME" . ,(git-get-committer-name))
+                             ("GIT_COMMITTER_EMAIL" . ,(git-get-committer-email)))))
+                  (when author-date (push `("GIT_AUTHOR_DATE" . ,author-date) env))
+                  (apply #'git-run-command-region
+                         buffer log-start log-end env
+                         "commit-tree" tree (nreverse args))))))))
+      (and (git-update-ref "HEAD" commit head subject)
+           commit))))
 
 (defun git-empty-db-p ()
   "Check if the git db is empty (no commit done yet)."
@@ -662,7 +677,6 @@ and returns the process output as a string."
                       (if (or (not (string-equal tree head-tree))
                               (yes-or-no-p "The tree was not modified, do you really want to perform an empty commit? "))
                           (let ((commit (git-commit-tree buffer tree head)))
-                            (git-update-ref "HEAD" commit head)
                             (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
                             (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
                             (with-current-buffer buffer (erase-buffer))
-- 
1.5.1.1.182.g3cfa9

-- 
Alexandre Julliard
julliard@winehq.org
