From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/4] git.el: Try to reuse an existing buffer when running git-status.
Date: Sat, 22 Jul 2006 15:39:53 +0200
Message-ID: <87y7ulg3me.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 22 15:40:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4Hi3-0004vQ-Sk
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 15:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWGVNj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Jul 2006 09:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWGVNj5
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 09:39:57 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:30149 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751356AbWGVNj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jul 2006 09:39:56 -0400
Received: from adsl-84-227-106-91.adslplus.ch ([84.227.106.91] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G4Hhz-0003DQ-Mo
	for git@vger.kernel.org; Sat, 22 Jul 2006 08:39:56 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 970364F904; Sat, 22 Jul 2006 15:39:53 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24070>

By default, running git-status again will now reuse an existing buffer
that displays the same directory. The old behavior of always creating
a new buffer can be obtained by customizing the git-reuse-status-buffer
option.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5837471..92cb2b9 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -83,6 +83,12 @@ (defcustom git-append-signed-off-by nil
   :group 'git
   :type 'boolean)
 
+(defcustom git-reuse-status-buffer t
+  "Whether `git-status' should try to reuse an existing buffer
+if there is already one that displays the same directory."
+  :group 'git
+  :type 'boolean)
+
 (defcustom git-per-dir-ignore-file ".gitignore"
   "Name of the per-directory ignore file."
   :group 'git
@@ -1003,12 +1009,28 @@ Commands:
   (set (make-local-variable 'list-buffers-directory) default-directory)
   (run-hooks 'git-status-mode-hook)))
 
+(defun git-find-status-buffer (dir)
+  "Find the git status buffer handling a specified directory."
+  (let ((list (buffer-list))
+        (fulldir (expand-file-name dir))
+        found)
+    (while (and list (not found))
+      (let ((buffer (car list)))
+        (with-current-buffer buffer
+          (when (and list-buffers-directory
+                     (string-equal fulldir (expand-file-name list-buffers-directory))
+                     (string-match "\\*git-status\\*$" (buffer-name buffer)))
+            (setq found buffer))))
+      (setq list (cdr list)))
+    found))
+
 (defun git-status (dir)
   "Entry point into git-status mode."
   (interactive "DSelect directory: ")
   (setq dir (git-get-top-dir dir))
   (if (file-directory-p (concat (file-name-as-directory dir) ".git"))
-      (let ((buffer (create-file-buffer (expand-file-name "*git-status*" dir))))
+      (let ((buffer (or (and git-reuse-status-buffer (git-find-status-buffer dir))
+                        (create-file-buffer (expand-file-name "*git-status*" dir)))))
         (switch-to-buffer buffer)
         (cd dir)
         (git-status-mode)
-- 
1.4.2.rc1.ge7a0

-- 
Alexandre Julliard
julliard@winehq.org
