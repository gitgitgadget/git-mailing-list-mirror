From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 4/5] git.el: Added support for Signed-off-by.
Date: Sat, 04 Mar 2006 17:38:41 +0100
Message-ID: <877j7akvvy.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 04 17:38:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFZmL-0007qs-SK
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 17:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWCDQir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 11:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWCDQir
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 11:38:47 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:21196 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932112AbWCDQiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 11:38:46 -0500
Received: from adsl-84-227-8-187.adslplus.ch ([84.227.8.187] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFZmF-0000kR-O8
	for git@vger.kernel.org; Sat, 04 Mar 2006 10:38:45 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id C035E4F90E; Sat,  4 Mar 2006 17:38:41 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.8.187
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17187>

If `git-append-signed-off-by' is non-nil, automatically append a
sign-off line to the log message when editing it.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

00728d51cbda0f21be59cc56b23f4943c6657a63
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 335dcb2..0b24b4d 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -39,7 +39,6 @@
 ;;  - hook into file save (after-save-hook)
 ;;  - diff against other branch
 ;;  - renaming files from the status buffer
-;;  - support for appending signed-off-by
 ;;  - creating tags
 ;;  - fetch/pull
 ;;  - switching branches
@@ -103,6 +102,9 @@ If not set, fall back to `add-log-mailin
 (defvar git-commits-coding-system 'utf-8
   "Default coding system for git commits.")
 
+(defvar git-append-signed-off-by nil
+  "Whether to append a Signed-off-by line to the commit message.")
+
 (defconst git-log-msg-separator "--- log message follows this line ---")
 
 (defconst git-per-dir-ignore-file ".gitignore"
@@ -792,7 +794,8 @@ If not set, fall back to `add-log-mailin
   (unless git-status (error "Not in git-status buffer."))
   (let ((buffer (get-buffer-create "*git-commit*"))
         (merge-heads (git-get-merge-heads))
-        (dir default-directory))
+        (dir default-directory)
+        (sign-off git-append-signed-off-by))
     (with-current-buffer buffer
       (when (eq 0 (buffer-size))
         (cd dir)
@@ -809,10 +812,13 @@ If not set, fall back to `add-log-mailin
           'face 'git-header-face)
          (propertize git-log-msg-separator 'face 'git-separator-face)
          "\n")
-        (when (and merge-heads (file-readable-p ".git/MERGE_MSG"))
-          (insert-file-contents ".git/MERGE_MSG"))))
+        (cond ((and merge-heads (file-readable-p ".git/MERGE_MSG"))
+               (insert-file-contents ".git/MERGE_MSG"))
+              (sign-off
+               (insert (format "\n\nSigned-off-by: %s <%s>\n"
+                               (git-get-committer-name) (git-get-committer-email)))))))
     (let ((log-edit-font-lock-keywords
-           `(("^\\(Author:\\|Date:\\|Parent:\\)\\(.*\\)"
+           `(("^\\(Author:\\|Date:\\|Parent:\\|Signed-off-by:\\)\\(.*\\)"
               (1 font-lock-keyword-face)
               (2 font-lock-function-name-face))
              (,(concat "^\\(" (regexp-quote git-log-msg-separator) "\\)$")
-- 
1.2.4.g0040-dirty

-- 
Alexandre Julliard
julliard@winehq.org
