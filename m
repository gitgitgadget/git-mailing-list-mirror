From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 5/5] git.el: Added customize support for all parameters.
Date: Sat, 04 Mar 2006 17:38:58 +0100
Message-ID: <873bhykvvh.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 04 17:39:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFZmf-0007t4-RI
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 17:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWCDQjG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 11:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWCDQjG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 11:39:06 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:26060 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932117AbWCDQjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 11:39:05 -0500
Received: from adsl-84-227-8-187.adslplus.ch ([84.227.8.187] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFZmW-0000l6-FL
	for git@vger.kernel.org; Sat, 04 Mar 2006 10:39:04 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 494224F90E; Sat,  4 Mar 2006 17:38:58 +0100 (CET)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17188>

Also fixed quoting of git-log-msg-separator.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |   85 ++++++++++++++++++++++++++++++++------------------
 1 files changed, 54 insertions(+), 31 deletions(-)

c41661801015e1d04d1ac3c3a3ccd2ba254bb02c
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 0b24b4d..5135e36 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -44,7 +44,6 @@
 ;;  - switching branches
 ;;  - revlist browser
 ;;  - git-show-branch browser
-;;  - customize support
 ;;  - menus
 ;;
 
@@ -52,68 +51,92 @@
 (require 'ewoc)
 
 
-;;;; Faces
+;;;; Customizations
 ;;;; ------------------------------------------------------------
 
+(defgroup git nil
+  "Git user interface")
+
+(defcustom git-committer-name nil
+  "User name to use for commits.
+The default is to fall back to `add-log-full-name' and then `user-full-name'."
+  :group 'git
+  :type '(choice (const :tag "Default" nil)
+                 (string :tag "Name")))
+
+(defcustom git-committer-email nil
+  "Email address to use for commits.
+The default is to fall back to `add-log-mailing-address' and then `user-mail-address'."
+  :group 'git
+  :type '(choice (const :tag "Default" nil)
+                 (string :tag "Email")))
+
+(defcustom git-commits-coding-system 'utf-8
+  "Default coding system for the log message of git commits."
+  :group 'git
+  :type 'coding-system)
+
+(defcustom git-append-signed-off-by nil
+  "Whether to append a Signed-off-by line to the commit message before editing."
+  :group 'git
+  :type 'boolean)
+
+(defcustom git-per-dir-ignore-file ".gitignore"
+  "Name of the per-directory ignore file."
+  :group 'git
+  :type 'string)
+
 (defface git-status-face
   '((((class color) (background light)) (:foreground "purple")))
-  "Git mode face used to highlight added and modified files.")
+  "Git mode face used to highlight added and modified files."
+  :group 'git)
 
 (defface git-unmerged-face
   '((((class color) (background light)) (:foreground "red" :bold t)))
-  "Git mode face used to highlight unmerged files.")
+  "Git mode face used to highlight unmerged files."
+  :group 'git)
 
 (defface git-unknown-face
   '((((class color) (background light)) (:foreground "goldenrod" :bold t)))
-  "Git mode face used to highlight unknown files.")
+  "Git mode face used to highlight unknown files."
+  :group 'git)
 
 (defface git-uptodate-face
   '((((class color) (background light)) (:foreground "grey60")))
-  "Git mode face used to highlight up-to-date files.")
+  "Git mode face used to highlight up-to-date files."
+  :group 'git)
 
 (defface git-ignored-face
   '((((class color) (background light)) (:foreground "grey60")))
-  "Git mode face used to highlight ignored files.")
+  "Git mode face used to highlight ignored files."
+  :group 'git)
 
 (defface git-mark-face
   '((((class color) (background light)) (:foreground "red" :bold t)))
-  "Git mode face used for the file marks.")
+  "Git mode face used for the file marks."
+  :group 'git)
 
 (defface git-header-face
   '((((class color) (background light)) (:foreground "blue")))
-  "Git mode face used for commit headers.")
+  "Git mode face used for commit headers."
+  :group 'git)
 
 (defface git-separator-face
   '((((class color) (background light)) (:foreground "brown")))
-  "Git mode face used for commit separator.")
+  "Git mode face used for commit separator."
+  :group 'git)
 
 (defface git-permission-face
   '((((class color) (background light)) (:foreground "green" :bold t)))
-  "Git mode face used for permission changes.")
-
-(defvar git-committer-name nil
-  "*User name to use for commits.
-If not set, fall back to `add-log-full-name' and then `user-full-name'.")
-
-(defvar git-committer-email nil
-  "*Email address to use for commits.
-If not set, fall back to `add-log-mailing-address' and then `user-mail-address'.")
-
-(defvar git-commits-coding-system 'utf-8
-  "Default coding system for git commits.")
-
-(defvar git-append-signed-off-by nil
-  "Whether to append a Signed-off-by line to the commit message.")
-
-(defconst git-log-msg-separator "--- log message follows this line ---")
-
-(defconst git-per-dir-ignore-file ".gitignore"
-  "Name of the per-directory ignore file.")
+  "Git mode face used for permission changes."
+  :group 'git)
 
 
 ;;;; Utilities
 ;;;; ------------------------------------------------------------
 
+(defconst git-log-msg-separator "--- log message follows this line ---")
+
 (defun git-get-env-strings (env)
   "Build a list of NAME=VALUE strings from a list of environment strings."
   (mapcar (lambda (entry) (concat (car entry) "=" (cdr entry))) env))
@@ -279,7 +302,7 @@ If not set, fall back to `add-log-mailin
     (with-current-buffer buffer
       (goto-char (point-min))
       (if
-          (setq log-start (re-search-forward (concat "^" git-log-msg-separator "\n") nil t))
+          (setq log-start (re-search-forward (concat "^" (regexp-quote git-log-msg-separator) "\n") nil t))
           (save-restriction
             (narrow-to-region (point-min) log-start)
             (goto-char (point-min))
-- 
1.2.4.g0040-dirty

-- 
Alexandre Julliard
julliard@winehq.org
