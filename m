From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 4/4] git.el: Reset the permission flags when changing a file state.
Date: Sat, 29 Sep 2007 11:59:32 +0200
Message-ID: <87y7epokqj.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 11:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbZ70-0001KT-R1
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 11:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbXI2J7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 05:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755564AbXI2J7n
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 05:59:43 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:53794 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408AbXI2J7m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 05:59:42 -0400
Received: from adsl-84-227-59-51.adslplus.ch ([84.227.59.51] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IbZ6l-0004mG-5t
	for git@vger.kernel.org; Sat, 29 Sep 2007 04:59:41 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 821221E7148; Sat, 29 Sep 2007 11:59:32 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59455>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   28 +++++++++++-----------------
 1 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index c2a1c3d..4286d16 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -484,14 +484,15 @@ and returns the process output as a string."
   "Remove everything from the status list."
   (ewoc-filter status (lambda (info) nil)))
 
-(defun git-set-files-state (files state)
-  "Set the state of a list of files."
-  (dolist (info files)
-    (unless (eq (git-fileinfo->state info) state)
-      (setf (git-fileinfo->state info) state)
-      (setf (git-fileinfo->rename-state info) nil)
-      (setf (git-fileinfo->orig-name info) nil)
-      (setf (git-fileinfo->needs-refresh info) t))))
+(defun git-set-fileinfo-state (info state)
+  "Set the state of a file info."
+  (unless (eq (git-fileinfo->state info) state)
+    (setf (git-fileinfo->state info) state
+          (git-fileinfo->old-perm info) 0
+          (git-fileinfo->new-perm info) 0
+          (git-fileinfo->rename-state info) nil
+          (git-fileinfo->orig-name info) nil
+          (git-fileinfo->needs-refresh info) t)))
 
 (defun git-status-filenames-map (status func files &rest args)
   "Apply FUNC to the status files names in the FILES list."
@@ -510,14 +511,7 @@ and returns the process output as a string."
 (defun git-set-filenames-state (status files state)
   "Set the state of a list of named files."
   (when files
-    (git-status-filenames-map status
-                              (lambda (info state)
-                                (unless (eq (git-fileinfo->state info) state)
-                                  (setf (git-fileinfo->state info) state)
-                                  (setf (git-fileinfo->rename-state info) nil)
-                                  (setf (git-fileinfo->orig-name info) nil)
-                                  (setf (git-fileinfo->needs-refresh info) t)))
-                              files state)
+    (git-status-filenames-map status #'git-set-fileinfo-state files state)
     (unless state  ;; delete files whose state has been set to nil
       (ewoc-filter status (lambda (info) (git-fileinfo->state info))))))
 
@@ -800,7 +794,7 @@ Return the list of files that haven't been handled."
                             (condition-case nil (delete-file ".git/MERGE_HEAD") (error nil))
                             (condition-case nil (delete-file ".git/MERGE_MSG") (error nil))
                             (with-current-buffer buffer (erase-buffer))
-                            (git-set-files-state files 'uptodate)
+                            (dolist (info files) (git-set-fileinfo-state info 'uptodate))
                             (git-call-process-env nil nil "rerere")
                             (git-refresh-files)
                             (git-refresh-ewoc-hf git-status)
-- 
1.5.3.2.121.gf7223

-- 
Alexandre Julliard
julliard@winehq.org
