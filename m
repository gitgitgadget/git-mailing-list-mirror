From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/4] git.el: Added a command to amend a commit.
Date: Thu, 07 Feb 2008 13:50:39 +0100
Message-ID: <87ve51orq8.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 13:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN6FB-00073P-2c
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 13:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432AbYBGMuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 07:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbYBGMuv
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 07:50:51 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:60813 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757991AbYBGMuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 07:50:50 -0500
Received: from adsl-84-227-175-174.adslplus.ch ([84.227.175.174] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JN6DB-0006sA-Ve
	for git@vger.kernel.org; Thu, 07 Feb 2008 06:50:48 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7AE121E7141; Thu,  7 Feb 2008 13:50:39 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72932>

It reverts the commit and sets up the status and edit log buffer to
allow making changes and recommitting it. Bound to C-c C-a.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   74 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 58d72a5..5519ed1 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -740,6 +740,27 @@ Return the list of files that haven't been handled."
     (git-refresh-files)
     (git-refresh-ewoc-hf git-status)))
 
+(defun git-mark-files (status files)
+  "Mark all the specified FILES, and unmark the others."
+  (setq files (sort files #'string-lessp))
+  (let ((file (and files (pop files)))
+        (node (ewoc-nth status 0)))
+    (while node
+      (let ((info (ewoc-data node)))
+        (if (and file (string-equal (git-fileinfo->name info) file))
+            (progn
+              (unless (git-fileinfo->marked info)
+                (setf (git-fileinfo->marked info) t)
+                (setf (git-fileinfo->needs-refresh info) t))
+              (setq file (pop files))
+              (setq node (ewoc-next status node)))
+          (when (git-fileinfo->marked info)
+            (setf (git-fileinfo->marked info) nil)
+            (setf (git-fileinfo->needs-refresh info) t))
+          (if (and file (string-lessp file (git-fileinfo->name info)))
+              (setq file (pop files))
+            (setq node (ewoc-next status node))))))))
+
 (defun git-marked-files ()
   "Return a list of all marked files, or if none a list containing just the file at cursor position."
   (unless git-status (error "Not in git-status buffer."))
@@ -1218,7 +1239,8 @@ Return the list of files that haven't been handled."
       (goto-char (point-min))
       (when (re-search-forward "\n+\\'" nil t)
         (replace-match "\n" t t))
-      (when sign-off (git-append-sign-off committer-name committer-email)))))
+      (when sign-off (git-append-sign-off committer-name committer-email)))
+    buffer))
 
 (defun git-commit-file ()
   "Commit the marked file(s), asking for a commit message."
@@ -1251,6 +1273,52 @@ Return the list of files that haven't been handled."
       (setq buffer-file-coding-system coding-system)
       (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
 
+(defun git-setup-commit-buffer (commit)
+  "Setup the commit buffer with the contents of COMMIT."
+  (let (author-name author-email subject date msg)
+    (with-temp-buffer
+      (let ((coding-system (git-get-logoutput-coding-system)))
+        (git-call-process-env t nil "log" "-1" commit)
+        (goto-char (point-min))
+        (when (re-search-forward "^Author: *\\(.*\\) <\\(.*\\)>$" nil t)
+          (setq author-name (match-string 1))
+          (setq author-email (match-string 2)))
+        (when (re-search-forward "^Date: *\\(.*\\)$" nil t)
+          (setq date (match-string 1)))
+        (while (re-search-forward "^    \\(.*\\)$" nil t)
+          (push (match-string 1) msg))
+        (setq msg (nreverse msg))
+        (setq subject (pop msg))
+        (while (and msg (zerop (length (car msg))) (pop msg)))))
+    (git-setup-log-buffer (get-buffer-create "*git-commit*")
+                          author-name author-email subject date
+                          (mapconcat #'identity msg "\n"))))
+
+(defun git-get-commit-files (commit)
+  "Retrieve the list of files modified by COMMIT."
+  (let (files)
+    (with-temp-buffer
+      (git-call-process-env t nil "diff-tree" "-r" "-z" "--name-only" "--no-commit-id" commit)
+      (goto-char (point-min))
+      (while (re-search-forward "\\([^\0]*\\)\0" nil t 1)
+        (push (match-string 1) files)))
+    files))
+
+(defun git-amend-commit ()
+  "Undo the last commit on HEAD, and set things up to commit an
+amended version of it."
+  (interactive)
+  (unless git-status (error "Not in git-status buffer."))
+  (when (git-empty-db-p) (error "No commit to amend."))
+  (let* ((commit (git-rev-parse "HEAD"))
+         (files (git-get-commit-files commit)))
+    (git-call-process-env nil nil "reset" "--soft" "HEAD^")
+    (git-update-status-files (copy-sequence files) 'uptodate)
+    (git-mark-files git-status files)
+    (git-refresh-files)
+    (git-setup-commit-buffer commit)
+    (git-commit-file)))
+
 (defun git-find-file ()
   "Visit the current file in its own buffer."
   (interactive)
@@ -1329,6 +1397,7 @@ Return the list of files that haven't been handled."
 
 (unless git-status-mode-map
   (let ((map (make-keymap))
+        (commit-map (make-sparse-keymap))
         (diff-map (make-sparse-keymap))
         (toggle-map (make-sparse-keymap)))
     (suppress-keymap map)
@@ -1337,6 +1406,7 @@ Return the list of files that haven't been handled."
     (define-key map " "   'git-next-file)
     (define-key map "a"   'git-add-file)
     (define-key map "c"   'git-commit-file)
+    (define-key map "\C-c" commit-map)
     (define-key map "d"    diff-map)
     (define-key map "="   'git-diff-file)
     (define-key map "f"   'git-find-file)
@@ -1362,6 +1432,8 @@ Return the list of files that haven't been handled."
     (define-key map "x"   'git-remove-handled)
     (define-key map "\C-?" 'git-unmark-file-up)
     (define-key map "\M-\C-?" 'git-unmark-all)
+    ; the commit submap
+    (define-key commit-map "\C-a" 'git-amend-commit)
     ; the diff submap
     (define-key diff-map "b" 'git-diff-file-base)
     (define-key diff-map "c" 'git-diff-file-combined)
-- 
1.5.4.38.g0d380

-- 
Alexandre Julliard
julliard@winehq.org
