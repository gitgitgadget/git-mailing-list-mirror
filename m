From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/2] git.el: Retrieve commit log information from .dotest directory.
Date: Sat, 10 Mar 2007 19:22:26 +0100
Message-ID: <87lki5557h.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 19:22:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ6DK-0005rI-0L
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 19:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbXCJSWb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 13:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbXCJSWb
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 13:22:31 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:39301 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbXCJSWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 13:22:30 -0500
Received: from adsl-84-227-136-250.adslplus.ch ([84.227.136.250] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HQ6D6-0003K6-Jj
	for git@vger.kernel.org; Sat, 10 Mar 2007 12:22:29 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7AB26109F1C; Sat, 10 Mar 2007 19:22:26 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41874>

If a git-am or git-rebase is in progress, fill the commit log buffer
from the commit information found in the various files in the .dotest
directory.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   77 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 53 insertions(+), 24 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 427f89b..db87a37 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -903,36 +903,65 @@ and returns the process output as a string."
       (goto-char (point-max))
       (insert sign-off "\n"))))
 
-(defun git-commit-file ()
-  "Commit the marked file(s), asking for a commit message."
-  (interactive)
+(defun git-setup-log-buffer (buffer &optional author-name author-email subject date msg)
+  "Setup the log buffer for a commit."
   (unless git-status (error "Not in git-status buffer."))
-  (let ((buffer (get-buffer-create "*git-commit*"))
-        (merge-heads (git-get-merge-heads))
+  (let ((merge-heads (git-get-merge-heads))
         (dir default-directory)
-        (coding-system (git-get-commits-coding-system))
         (committer-name (git-get-committer-name))
         (committer-email (git-get-committer-email))
         (sign-off git-append-signed-off-by))
     (with-current-buffer buffer
-      (when (eq 0 (buffer-size))
-        (cd dir)
-        (erase-buffer)
-        (insert
-         (propertize
-          (format "Author: %s <%s>\n%s"
-                  committer-name committer-email
-                  (if merge-heads
-                      (format "Parent: %s\n%s\n"
-                              (git-rev-parse "HEAD")
-                              (mapconcat (lambda (str) (concat "Parent: " str)) merge-heads "\n"))
-                    ""))
-          'face 'git-header-face)
-         (propertize git-log-msg-separator 'face 'git-separator-face)
-         "\n")
-        (when (file-readable-p ".git/MERGE_MSG")
-          (insert-file-contents ".git/MERGE_MSG"))
-        (when sign-off (git-append-sign-off committer-name committer-email))))
+      (cd dir)
+      (erase-buffer)
+      (insert
+       (propertize
+        (format "Author: %s <%s>\n%s%s"
+                (or author-name committer-name)
+                (or author-email committer-email)
+                (if date (format "Date: %s\n" date) "")
+                (if merge-heads
+                    (format "Parent: %s\n%s\n"
+                            (git-rev-parse "HEAD")
+                            (mapconcat (lambda (str) (concat "Parent: " str)) merge-heads "\n"))
+                  ""))
+        'face 'git-header-face)
+       (propertize git-log-msg-separator 'face 'git-separator-face)
+       "\n")
+      (when subject (insert subject "\n\n"))
+      (cond (msg (insert msg "\n"))
+            ((file-readable-p ".dotest/msg")
+             (insert-file-contents ".dotest/msg"))
+            ((file-readable-p ".git/MERGE_MSG")
+             (insert-file-contents ".git/MERGE_MSG")))
+      ; delete empty lines at end
+      (goto-char (point-min))
+      (when (re-search-forward "\n+\\'" nil t)
+        (replace-match "\n" t t))
+      (when sign-off (git-append-sign-off committer-name committer-email)))))
+
+(defun git-commit-file ()
+  "Commit the marked file(s), asking for a commit message."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (let ((buffer (get-buffer-create "*git-commit*"))
+        (coding-system (git-get-commits-coding-system))
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
     (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
     (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
     (setq buffer-file-coding-system coding-system)
-- 
1.5.0.3.321.g4253

-- 
Alexandre Julliard
julliard@winehq.org
