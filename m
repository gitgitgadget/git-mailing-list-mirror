From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/2] git.el: Avoid appending a signoff line that is already present.
Date: Sat, 10 Mar 2007 19:21:25 +0100
Message-ID: <87ps7h5596.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 10 19:21:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ6CG-0005LZ-Cq
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 19:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbXCJSV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 13:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbXCJSV3
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 13:21:29 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:39240 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbXCJSV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 13:21:28 -0500
Received: from adsl-84-227-136-250.adslplus.ch ([84.227.136.250] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HQ6C7-0003Ix-LA
	for git@vger.kernel.org; Sat, 10 Mar 2007 12:21:28 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 57766109F1C; Sat, 10 Mar 2007 19:21:25 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41873>

Also avoid inserting an extra newline if other signoff lines are
present.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 13d1982..427f89b 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -891,6 +891,18 @@ and returns the process output as a string."
   (with-current-buffer log-edit-parent-buffer
     (git-get-filenames (git-marked-files-state 'added 'deleted 'modified))))
 
+(defun git-append-sign-off (name email)
+  "Append a Signed-off-by entry to the current buffer, avoiding duplicates."
+  (let ((sign-off (format "Signed-off-by: %s <%s>" name email))
+        (case-fold-search t))
+    (goto-char (point-min))
+    (unless (re-search-forward (concat "^" (regexp-quote sign-off)) nil t)
+      (goto-char (point-min))
+      (unless (re-search-forward "^Signed-off-by: " nil t)
+        (setq sign-off (concat "\n" sign-off)))
+      (goto-char (point-max))
+      (insert sign-off "\n"))))
+
 (defun git-commit-file ()
   "Commit the marked file(s), asking for a commit message."
   (interactive)
@@ -899,6 +911,8 @@ and returns the process output as a string."
         (merge-heads (git-get-merge-heads))
         (dir default-directory)
         (coding-system (git-get-commits-coding-system))
+        (committer-name (git-get-committer-name))
+        (committer-email (git-get-committer-email))
         (sign-off git-append-signed-off-by))
     (with-current-buffer buffer
       (when (eq 0 (buffer-size))
@@ -907,7 +921,7 @@ and returns the process output as a string."
         (insert
          (propertize
           (format "Author: %s <%s>\n%s"
-                  (git-get-committer-name) (git-get-committer-email)
+                  committer-name committer-email
                   (if merge-heads
                       (format "Parent: %s\n%s\n"
                               (git-rev-parse "HEAD")
@@ -916,11 +930,9 @@ and returns the process output as a string."
           'face 'git-header-face)
          (propertize git-log-msg-separator 'face 'git-separator-face)
          "\n")
-        (cond ((file-readable-p ".git/MERGE_MSG")
-               (insert-file-contents ".git/MERGE_MSG"))
-              (sign-off
-               (insert (format "\n\nSigned-off-by: %s <%s>\n"
-                               (git-get-committer-name) (git-get-committer-email)))))))
+        (when (file-readable-p ".git/MERGE_MSG")
+          (insert-file-contents ".git/MERGE_MSG"))
+        (when sign-off (git-append-sign-off committer-name committer-email))))
     (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
     (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
     (setq buffer-file-coding-system coding-system)
-- 
1.5.0.3.321.g4253

-- 
Alexandre Julliard
julliard@winehq.org
