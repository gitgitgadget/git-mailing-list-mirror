From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 2/3] git.el: Retrieve the permissions for up-to-date files.
Date: Sun, 06 Jan 2008 12:13:01 +0100
Message-ID: <873atb8awy.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 12:13:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBTRi-0001Us-JX
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 12:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbYAFLNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753290AbYAFLNH
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 06:13:07 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:59760 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264AbYAFLNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 06:13:06 -0500
Received: from adsl-84-227-6-44.adslplus.ch ([84.227.6.44] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JBTR9-0004ho-Pi
	for git@vger.kernel.org; Sun, 06 Jan 2008 05:13:05 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 759C01E7149; Sun,  6 Jan 2008 12:13:01 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69727>

This allows displaying correctly the executable flag for the initial
commit, and will make it possible to show the file type for up-to-date
symlinks and subprojects.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e0e6316..820df11 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -642,6 +642,22 @@ Return the list of files that haven't been handled."
     (git-insert-info-list status infolist)
     files))
 
+(defun git-run-ls-files-cached (status files default-state)
+  "Run git-ls-files -c on FILES and parse the results into STATUS.
+Return the list of files that haven't been handled."
+  (let (infolist)
+    (with-temp-buffer
+      (apply #'git-call-process-env t nil "ls-files" "-z" "-s" "-c" "--" files)
+      (goto-char (point-min))
+      (while (re-search-forward "\\([0-7]\\{6\\}\\) [0-9a-f]\\{40\\} [0-3]\t\\([^\0]+\\)\0" nil t)
+        (let* ((new-perm (string-to-number (match-string 1) 8))
+               (old-perm (if (eq default-state 'added) 0 new-perm))
+               (name (match-string 2)))
+          (push (git-create-fileinfo default-state name old-perm new-perm) infolist)
+          (setq files (delete name files)))))
+    (git-insert-info-list status infolist)
+    files))
+
 (defun git-run-ls-unmerged (status files)
   "Run git-ls-files -u on FILES and parse the results into STATUS."
   (with-temp-buffer
@@ -673,10 +689,10 @@ Return the list of files that haven't been handled."
   "Update the status of FILES from the index."
   (unless git-status (error "Not in git-status buffer."))
   (unless files
-    (when git-show-uptodate (git-run-ls-files git-status nil 'uptodate "-c")))
+    (when git-show-uptodate (git-run-ls-files-cached git-status nil 'uptodate)))
   (let* ((remaining-files
           (if (git-empty-db-p) ; we need some special handling for an empty db
-              (git-run-ls-files git-status files 'added "-c")
+              (git-run-ls-files-cached git-status files 'added)
             (git-run-diff-index git-status files))))
     (git-run-ls-unmerged git-status files)
     (when (or remaining-files (and git-show-unknown (not files)))
-- 
1.5.4.rc2.53.gb6f8

-- 
Alexandre Julliard
julliard@winehq.org
