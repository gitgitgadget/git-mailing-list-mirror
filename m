From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: [PATCH/RFC] git.el: show/refresh diff buffer from commit buffer
Date: Sat, 19 Apr 2008 15:53:21 +0900
Message-ID: <1f748ec60804182353q45237c8esc8d05cb49a132676@mail.gmail.com>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 17:56:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn6xd-00065V-8e
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 08:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbYDSGxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 02:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbYDSGxX
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 02:53:23 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:17509 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbYDSGxW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 02:53:22 -0400
Received: by an-out-0708.google.com with SMTP id d31so235915and.103
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 23:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=WEcge+o/t6LhG1lQYYIfJXr4VMD93sXrA3gkzdHYJ9k=;
        b=icLdDeeT8ei+TxGreszl3h5JFDFmzoAzvi+iRAyorkYz5U7XjRsIzAFw0+mDHSIPlbo5sVxtFsqJVxC8QS6Vg7O3a2A81MKkRQcmg/dHxVm9jmlvBZ4vnRKLCe8Oe/LgrXxP8MOffgyRLnihtN1mMDysxdCRaiaMRBoVGHY5J70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=Vb+klhOs3DHla2RCLQkVX4GwxXKWmhPfbF3Iaqkm+Mx+qIIpVD9mGm+Gtw7DSCxrvoKQ9DYltIbcqjQ5fHn/ccICB2ibItsySEG3/ZD5fjIoHKUHSCpgYFB/q/yJvmvpTImvZLvwzUxawZ80PQCRJoo2oIJ0QtrZ/shXLcjM1tA=
Received: by 10.100.205.9 with SMTP id c9mr6966106ang.51.1208588001786;
        Fri, 18 Apr 2008 23:53:21 -0700 (PDT)
Received: by 10.101.1.16 with HTTP; Fri, 18 Apr 2008 23:53:21 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: f3f0aff5afaa84f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79896>

This patch adds Emacs Lisp plumbing:
  run-hooks 'git-log-edit-commit-hook to git-commit-file
  run-hooks 'git-diff-setup-hook to git-setup-diff-buffer
  a commit buffer reference to the diff buffer

This allows diff buffer refreshing:

The hooks git-log-edit-commit-hook and git-diff-setup-hook are given
sample hooks that add keybindings "\C-c\C-d" and "g" to the
*git-commit* and *git-diff* buffer, respectively. These keybindings
allow refreshing the diff information shown in the *git-diff* buffer.

Signed-off-by: Clifford Caoile <piyo@users.sourceforge.net>
---
 contrib/emacs/git.el |   53 ++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 4fa853f..6b23145 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -179,6 +179,32 @@ if there is already one that displays the same directory."
     (,(concat "^\\(" (regexp-quote git-log-msg-separator) "\\)$")
      (1 font-lock-comment-face))))

+;
+
+(defvar git-log-edit-commit-hook nil
+  "Run after the log edit buffer created `git-commit-file' is setup.")
+
+(defvar git-diff-setup-hook nil
+  "Run after the diff buffer created by `git-diff-setup-buffer' is setup.")
+
+(defun git-log-edit-diff-cmd ()
+  "The interactive version of `git-log-edit-diff', designed to be
+called from define-key calls inside of `git-log-edit-commit-hook'
+and `git-diff-setup-hook'."
+  (interactive)
+  (git-log-edit-diff))
+
+(add-hook 'git-log-edit-commit-hook 'git-log-commit-sample-hook)
+(add-hook 'git-diff-setup-hook      'git-diff-setup-sample-hook)
+
+(defun git-log-commit-sample-hook ()
+  (define-key (current-local-map) "\C-c\C-d" 'git-log-edit-diff-cmd))
+
+(defun git-diff-setup-sample-hook ()
+  (define-key (current-local-map) "g"  'git-log-edit-diff-cmd))
+
+;
+
 (defun git-get-env-strings (env)
   "Build a list of NAME=VALUE strings from a list of environment strings."
   (mapcar (lambda (entry) (concat (car entry) "=" (cdr entry))) env))
@@ -1124,25 +1150,34 @@ Return the list of files that haven't been handled."
       (git-refresh-ewoc-hf git-status)
       t)))

-(defun git-setup-diff-buffer (buffer)
+(defun git-setup-diff-buffer (buffer &optional parent-buffer)
   "Setup a buffer for displaying a diff."
   (let ((dir default-directory))
     (with-current-buffer buffer
       (diff-mode)
       (goto-char (point-min))
       (setq default-directory dir)
-      (setq buffer-read-only t)))
+      (setq buffer-read-only t)
+      ;; when called by (git-diff-file) via the git's log-edit buffer,
+      ;; parent-buffer will be non-nil
+      (when parent-buffer
+        (set (make-local-variable 'log-edit-parent-buffer) parent-buffer))
+      (run-hooks 'git-diff-setup-hook)))
   (display-buffer buffer)
   ; shrink window only if it displays the status buffer
   (when (eq (window-buffer) (current-buffer))
     (shrink-window-if-larger-than-buffer)))

-(defun git-diff-file ()
-  "Diff the marked file(s) against HEAD."
+(defun git-diff-file (&optional parent-buffer)
+  "Diff the marked file(s) against HEAD.
+
+PARENT-BUFFER is usually passed by `git-log-edit-diff' to be able
+to revert the diff buffer."
   (interactive)
   (let ((files (git-marked-files)))
     (git-setup-diff-buffer
-     (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p"
"-M" "HEAD" "--" (git-get-filenames files)))))
+     (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p"
"-M" "HEAD" "--" (git-get-filenames files))
+     parent-buffer)))

 (defun git-diff-file-merge-head (arg)
   "Diff the marked file(s) against the first merge head (or the nth
one with a numeric prefix)."
@@ -1210,8 +1245,9 @@ Return the list of files that haven't been handled."

 (defun git-log-edit-diff ()
   "Run a diff of the current files being committed from a log-edit buffer."
-  (with-current-buffer log-edit-parent-buffer
-    (git-diff-file)))
+  (let ((original-buffer log-edit-parent-buffer))
+    (with-current-buffer log-edit-parent-buffer
+      (git-diff-file original-buffer))))

 (defun git-append-sign-off (name email)
   "Append a Signed-off-by entry to the current buffer, avoiding duplicates."
@@ -1292,7 +1328,8 @@ Return the list of files that haven't been handled."
 	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
       (setq font-lock-keywords (font-lock-compile-keywords
git-log-edit-font-lock-keywords))
       (setq buffer-file-coding-system coding-system)
-      (re-search-forward (regexp-quote (concat git-log-msg-separator
"\n")) nil t))))
+      (re-search-forward (regexp-quote (concat git-log-msg-separator
"\n")) nil t)
+      (run-hooks 'git-log-edit-commit-hook))))

 (defun git-setup-commit-buffer (commit)
   "Setup the commit buffer with the contents of COMMIT."
-- 
1.5.5.1015.g9d258
