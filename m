From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 2/7] Add basic support for customization (vc-git.el)
Date: Sat, 03 Mar 2007 11:18:32 +0100
Message-ID: <15277.1172917112@localhost>
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 11:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNRMp-0004Pd-4z
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbXCCKVY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbXCCKVY
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:21:24 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47341 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbXCCKVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:21:23 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 3EC2C7CD8;
	Sat,  3 Mar 2007 11:21:22 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l23AIW3c015278;
	Sat, 3 Mar 2007 11:18:32 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41280>


* vc-git, vc-git-program-name, vc-git-author-name
  vc-git-author-email : defcustom

* replace all occurences of call to git to vc-git-program-name

* add --author switch to vc-git-checkin

* add docstring to vc-git-checkin

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/vc-git.el |   56 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 3d43ca0..8ec470c 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -36,6 +36,28 @@
 ;; Add it automatically
 (add-to-list 'vc-handled-backends 'GIT)
 
+(defgroup vc-git nil
+  "*This is GIT backend for vc."
+  :prefix "vc-git-"
+  :group 'vc)
+
+(defcustom vc-git-program-name "git"
+  "*The name of the git command."
+  :type 'string
+  :group 'vc-git)
+
+(defcustom vc-git-author-name nil
+"*Author name to use in git. If nil, we check for environment variables
+GIT_AUTHOR_NAME or `user_full_name'."
+  :type '(choice string (const nil))
+  :group 'vc-git)
+
+(defcustom vc-git-author-email nil
+"*Author email to use in git. If nil, we check for environment variables
+GIT_AUTHOR_ADDRESS and if still nil, `user_mail_address'."
+  :type '(choice string (const nil))
+  :group 'vc-git)
+
 (defvar git-commits-coding-system 'utf-8
   "Default coding system for git commits.")
 
@@ -44,7 +66,7 @@
   (let* ((ok t)
          (str (with-output-to-string
                 (with-current-buffer standard-output
-                  (unless (eq 0 (apply #'call-process "git" nil '(t nil) nil
+                  (unless (eq 0 (apply #'call-process vc-git-program-name nil '(t nil) nil
                                        (append args (list (file-relative-name file)))))
                     (setq ok nil))))))
     (and ok str)))
@@ -52,7 +74,7 @@
 (defun vc-git--run-command (file &rest args)
   "Run a git command on FILE, discarding any output."
   (let ((name (file-relative-name file)))
-    (eq 0 (apply #'call-process "git" nil (get-buffer "*Messages") nil (append args (list name))))))
+    (eq 0 (apply #'call-process vc-git-program-name nil (get-buffer "*Messages") nil (append args (list name))))))
 
 (defun vc-git-registered (file)
   "Check whether FILE is registered with git."
@@ -61,7 +83,7 @@
            (name (file-relative-name file dir)))
       (and (ignore-errors
              (when dir (cd dir))
-             (eq 0 (call-process "git" nil '(t nil) nil "ls-files" "-c" "-z" "--" name)))
+             (eq 0 (call-process vc-git-program-name nil '(t nil) nil "ls-files" "-c" "-z" "--" name)))
            (let ((str (buffer-string)))
              (and (> (length str) (length name))
                   (string= (substring str 0 (1+ (length name))) (concat name "\0"))))))))
@@ -77,7 +99,7 @@
   "git-specific version of `vc-workfile-version'."
   (let ((str (with-output-to-string
                (with-current-buffer standard-output
-                 (call-process "git" nil '(t nil) nil "symbolic-ref" "HEAD")))))
+                 (call-process vc-git-program-name nil '(t nil) nil "symbolic-ref" "HEAD")))))
     (if (string-match "^\\(refs/heads/\\)?\\(.+\\)$" str)
         (match-string 2 str)
       str)))
@@ -105,20 +127,32 @@
 (defun vc-git-print-log (file &optional buffer)
   (let ((name (file-relative-name file))
         (coding-system-for-read git-commits-coding-system))
-    (vc-do-command buffer 'async "git" name "rev-list" "--pretty" "HEAD" "--")))
+    (vc-do-command buffer 'async vc-git-program-name name "rev-list" "--pretty" "HEAD" "--")))
 
 (defun vc-git-diff (file &optional rev1 rev2 buffer)
   (let ((name (file-relative-name file))
         (buf (or buffer "*vc-diff*")))
     (if (and rev1 rev2)
-        (vc-do-command buf 0 "git" name "diff-tree" "-p" rev1 rev2 "--")
-      (vc-do-command buf 0 "git" name "diff-index" "-p" (or rev1 "HEAD") "--"))
+        (vc-do-command buf 0 vc-git-program-name name "diff-tree" "-p" rev1 rev2 "--")
+      (vc-do-command buf 0 vc-git-program-name name "diff-index" "-p" (or rev1 "HEAD") "--"))
     ; git-diff-index doesn't set exit status like diff does
     (if (vc-git-workfile-unchanged-p file) 0 1)))
 
 (defun vc-git-checkin (file rev comment)
-  (let ((coding-system-for-write git-commits-coding-system))
-    (vc-git--run-command file "commit" "-m" comment "--only" "--")))
+  "Record FILE to git. REV should always be nil and is ignored,
+COMMENT is the new comment."
+  (let ((coding-system-for-write git-commits-coding-system)
+	(author-name (or vc-git-author-name
+			 (getenv "GIT_AUTHOR_NAME")
+			 user-full-name))
+	(author-email (or vc-git-author-email
+			 (getenv "GIT_AUTHOR_ADDRESS")
+			 user-mail-address)))
+    
+    (vc-git--run-command (file-name-nondirectory file) "commit" "-m" 
+			 comment 
+			 "--author" (concat author-name " <" author-email ">")
+			 "--only" "--")))
 
 (defun vc-git-checkout (file &optional editable rev destfile)
   (if destfile
@@ -128,14 +162,14 @@
             (coding-system-for-read 'no-conversion)
             (coding-system-for-write 'no-conversion))
         (with-temp-file destfile
-          (eq 0 (call-process "git" nil t nil "cat-file" "blob"
+          (eq 0 (call-process vc-git-program-name nil t nil "cat-file" "blob"
                               (concat (or rev "HEAD") ":" fullname)))))
     (vc-git--run-command file "checkout" (or rev "HEAD"))))
 
 (defun vc-git-annotate-command (file buf &optional rev)
   ; FIXME: rev is ignored
   (let ((name (file-relative-name file)))
-    (call-process "git" nil buf nil "blame" name)))
+    (call-process vc-git-program-name nil buf nil "blame" name)))
 
 (defun vc-git-annotate-time ()
   (and (re-search-forward "[0-9a-f]+ (.* \\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\) +[0-9]+)" nil t)
-- 
1.5.0
