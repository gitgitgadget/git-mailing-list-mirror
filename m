From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] git.el: Set the default commit coding system from the repository config.
Date: Wed, 28 Feb 2007 20:59:48 +0100
Message-ID: <87bqjexdcb.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 20:59:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUxw-00079e-Te
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbXB1T7z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbXB1T7z
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:59:55 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:60786 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbXB1T7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:59:54 -0500
Received: from adsl-62-167-33-160.adslplus.ch ([62.167.33.160] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HMUxt-0005DA-5J
	for git@vger.kernel.org; Wed, 28 Feb 2007 13:59:53 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 863FA4F691; Wed, 28 Feb 2007 20:59:48 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41002>

If not otherwise specified, take the default coding system for commits
from the 'i18n.commitencoding' repository configuration value.

Also set the buffer-file-coding-system variable in the log buffer to
make the selected coding system visible on the modeline.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 24629eb..13d1982 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -75,10 +75,11 @@ then to `add-log-mailing-address' and then to `user-mail-address'."
   :type '(choice (const :tag "Default" nil)
                  (string :tag "Email")))
 
-(defcustom git-commits-coding-system 'utf-8
+(defcustom git-commits-coding-system nil
   "Default coding system for the log message of git commits."
   :group 'git
-  :type 'coding-system)
+  :type '(choice (const :tag "From repository config" nil)
+                 (coding-system)))
 
 (defcustom git-append-signed-off-by nil
   "Whether to append a Signed-off-by line to the commit message before editing."
@@ -236,6 +237,15 @@ and returns the process output as a string."
       (and (fboundp 'user-mail-address) (user-mail-address))
       (and (boundp 'user-mail-address) user-mail-address)))
 
+(defun git-get-commits-coding-system ()
+  "Return the coding system to use for commits."
+  (let ((repo-config (git-config "i18n.commitencoding")))
+    (or git-commits-coding-system
+        (and repo-config
+             (fboundp 'locale-charset-to-coding-system)
+             (locale-charset-to-coding-system repo-config))
+      'utf-8)))
+
 (defun git-escape-file-name (name)
   "Escape a file name if necessary."
   (if (string-match "[\n\t\"\\]" name)
@@ -327,7 +337,7 @@ and returns the process output as a string."
   "Call git-commit-tree with buffer as input and return the resulting commit SHA1."
   (let ((author-name (git-get-committer-name))
         (author-email (git-get-committer-email))
-        author-date log-start log-end args)
+        author-date log-start log-end args coding-system-for-write)
     (when head
       (push "-p" args)
       (push head args))
@@ -350,12 +360,12 @@ and returns the process output as a string."
                 (push "-p" args)
                 (push (match-string 1) args))))
         (setq log-start (point-min)))
-      (setq log-end (point-max)))
+      (setq log-end (point-max))
+      (setq coding-system-for-write buffer-file-coding-system))
     (git-get-string-sha1
      (with-output-to-string
        (with-current-buffer standard-output
-         (let ((coding-system-for-write git-commits-coding-system)
-               (env `(("GIT_AUTHOR_NAME" . ,author-name)
+         (let ((env `(("GIT_AUTHOR_NAME" . ,author-name)
                       ("GIT_AUTHOR_EMAIL" . ,author-email)
                       ("GIT_COMMITTER_NAME" . ,(git-get-committer-name))
                       ("GIT_COMMITTER_EMAIL" . ,(git-get-committer-email)))))
@@ -888,6 +898,7 @@ and returns the process output as a string."
   (let ((buffer (get-buffer-create "*git-commit*"))
         (merge-heads (git-get-merge-heads))
         (dir default-directory)
+        (coding-system (git-get-commits-coding-system))
         (sign-off git-append-signed-off-by))
     (with-current-buffer buffer
       (when (eq 0 (buffer-size))
@@ -912,6 +923,7 @@ and returns the process output as a string."
                                (git-get-committer-name) (git-get-committer-email)))))))
     (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
     (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
+    (setq buffer-file-coding-system coding-system)
     (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t)))
 
 (defun git-find-file ()
-- 
1.5.0.2.231.g02e3

-- 
Alexandre Julliard
julliard@winehq.org
