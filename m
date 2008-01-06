From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/3] git.el: Support for getting diffs from inside the log-edit buffer.
Date: Sun, 06 Jan 2008 12:12:24 +0100
Message-ID: <877iin8axz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 12:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBTR4-0001NN-S8
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 12:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbYAFLMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 06:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYAFLMa
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 06:12:30 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59750 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYAFLM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 06:12:29 -0500
Received: from adsl-84-227-6-44.adslplus.ch ([84.227.6.44] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JBTQY-0004fz-Q7
	for git@vger.kernel.org; Sun, 06 Jan 2008 05:12:28 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 1F2D81E7149; Sun,  6 Jan 2008 12:12:24 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69726>

Take advantage of the new log-edit feature that allows to show a diff
with C-c C-d while editing the log message.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 28a4899..e0e6316 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1024,7 +1024,9 @@ Return the list of files that haven't been handled."
       (setq default-directory dir)
       (setq buffer-read-only t)))
   (display-buffer buffer)
-  (shrink-window-if-larger-than-buffer))
+  ; shrink window only if it displays the status buffer
+  (when (eq (window-buffer) (current-buffer))
+    (shrink-window-if-larger-than-buffer)))
 
 (defun git-diff-file ()
   "Diff the marked file(s) against HEAD."
@@ -1097,6 +1099,11 @@ Return the list of files that haven't been handled."
   (with-current-buffer log-edit-parent-buffer
     (git-get-filenames (git-marked-files-state 'added 'deleted 'modified))))
 
+(defun git-log-edit-diff ()
+  "Run a diff of the current files being committed from a log-edit buffer."
+  (with-current-buffer log-edit-parent-buffer
+    (git-diff-file)))
+
 (defun git-append-sign-off (name email)
   "Append a Signed-off-by entry to the current buffer, avoiding duplicates."
   (let ((sign-off (format "Signed-off-by: %s <%s>" name email))
@@ -1169,7 +1176,10 @@ Return the list of files that haven't been handled."
             (when (re-search-forward "^Date: \\(.*\\)$" nil t)
               (setq date (match-string 1)))))
         (git-setup-log-buffer buffer author-name author-email subject date))
-      (log-edit #'git-do-commit nil #'git-log-edit-files buffer)
+      (if (boundp 'log-edit-diff-function)
+          (log-edit 'git-do-commit nil '((log-edit-listfun . git-log-edit-files)
+                                         (log-edit-diff-function . git-log-edit-diff)) buffer)
+        (log-edit 'git-do-commit nil 'git-log-edit-files buffer))
       (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
       (setq buffer-file-coding-system coding-system)
       (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
-- 
1.5.4.rc2.53.gb6f8

-- 
Alexandre Julliard
julliard@winehq.org
