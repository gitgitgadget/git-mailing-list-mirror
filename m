From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/4] git.el: Update a file status in the git buffer upon save.
Date: Sat, 29 Sep 2007 11:59:07 +0200
Message-ID: <873awxpzbo.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 11:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbZ6b-0001DL-Lo
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 11:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbXI2J7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 05:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755408AbXI2J7S
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 05:59:18 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:53781 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbXI2J7R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 05:59:17 -0400
Received: from adsl-84-227-59-51.adslplus.ch ([84.227.59.51] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IbZ6M-0004ll-3T
	for git@vger.kernel.org; Sat, 29 Sep 2007 04:59:16 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 86FF61E7148; Sat, 29 Sep 2007 11:59:07 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59454>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index ec2e699..c2a1c3d 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -36,7 +36,6 @@
 ;; TODO
 ;;  - portability to XEmacs
 ;;  - better handling of subprocess errors
-;;  - hook into file save (after-save-hook)
 ;;  - diff against other branch
 ;;  - renaming files from the status buffer
 ;;  - creating tags
@@ -1352,9 +1351,24 @@ Commands:
         (cd dir)
         (git-status-mode)
         (git-refresh-status)
-        (goto-char (point-min)))
+        (goto-char (point-min))
+        (add-hook 'after-save-hook 'git-update-saved-file))
     (message "%s is not a git working tree." dir)))
 
+(defun git-update-saved-file ()
+  "Update the corresponding git-status buffer when a file is saved.
+Meant to be used in `after-save-hook'."
+  (let* ((file (expand-file-name buffer-file-name))
+         (dir (condition-case nil (git-get-top-dir (file-name-directory file))))
+         (buffer (and dir (git-find-status-buffer dir))))
+    (when buffer
+      (with-current-buffer buffer
+        (let ((filename (file-relative-name file dir)))
+          ; skip files located inside the .git directory
+          (unless (string-match "^\\.git/" filename)
+            (git-call-process-env nil nil "add" "--refresh" "--" filename)
+            (git-update-status-files (list filename) 'uptodate)))))))
+
 (defun git-help ()
   "Display help for Git mode."
   (interactive)
-- 
1.5.3.2.121.gf7223

-- 
Alexandre Julliard
julliard@winehq.org
