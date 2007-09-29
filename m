From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/4] git.el: Preserve file marks when doing a full refresh.
Date: Sat, 29 Sep 2007 11:58:08 +0200
Message-ID: <87bqblpzdb.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 11:58:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbZ5i-0000xS-I0
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 11:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428AbXI2J6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 05:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755526AbXI2J6V
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 05:58:21 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:57832 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755249AbXI2J6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 05:58:20 -0400
Received: from adsl-84-227-59-51.adslplus.ch ([84.227.59.51] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IbZ5P-0004kr-Kc
	for git@vger.kernel.org; Sat, 29 Sep 2007 04:58:19 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 130C51E7148; Sat, 29 Sep 2007 11:58:08 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59452>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   40 ++++++++++++++++++++++++++++------------
 1 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 2d77fd4..7b4a0d3 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -494,24 +494,31 @@ and returns the process output as a string."
       (setf (git-fileinfo->orig-name info) nil)
       (setf (git-fileinfo->needs-refresh info) t))))
 
-(defun git-set-filenames-state (status files state)
-  "Set the state of a list of named files."
+(defun git-status-filenames-map (status func files &rest args)
+  "Apply FUNC to the status files names in the FILES list."
   (when files
     (setq files (sort files #'string-lessp))
     (let ((file (pop files))
           (node (ewoc-nth status 0)))
       (while (and file node)
         (let ((info (ewoc-data node)))
-          (cond ((string-lessp (git-fileinfo->name info) file)
-                 (setq node (ewoc-next status node)))
-                ((string-equal (git-fileinfo->name info) file)
-                 (unless (eq (git-fileinfo->state info) state)
-                   (setf (git-fileinfo->state info) state)
-                   (setf (git-fileinfo->rename-state info) nil)
-                   (setf (git-fileinfo->orig-name info) nil)
-                   (setf (git-fileinfo->needs-refresh info) t))
-                 (setq file (pop files)))
-                (t (setq file (pop files)))))))
+          (if (string-lessp (git-fileinfo->name info) file)
+              (setq node (ewoc-next status node))
+            (if (string-equal (git-fileinfo->name info) file)
+                (apply func info args))
+            (setq file (pop files))))))))
+
+(defun git-set-filenames-state (status files state)
+  "Set the state of a list of named files."
+  (when files
+    (git-status-filenames-map status
+                              (lambda (info state)
+                                (unless (eq (git-fileinfo->state info) state)
+                                  (setf (git-fileinfo->state info) state)
+                                  (setf (git-fileinfo->rename-state info) nil)
+                                  (setf (git-fileinfo->orig-name info) nil)
+                                  (setf (git-fileinfo->needs-refresh info) t)))
+                              files state)
     (unless state  ;; delete files whose state has been set to nil
       (ewoc-filter status (lambda (info) (git-fileinfo->state info))))))
 
@@ -1197,11 +1204,20 @@ Return the list of files that haven't been handled."
   (interactive)
   (let* ((status git-status)
          (pos (ewoc-locate status))
+         (marked-files (git-get-filenames (ewoc-collect status (lambda (info) (git-fileinfo->marked info)))))
          (cur-name (and pos (git-fileinfo->name (ewoc-data pos)))))
     (unless status (error "Not in git-status buffer."))
     (git-run-command nil nil "update-index" "--refresh")
     (git-clear-status status)
     (git-update-status-files nil)
+    ; restore file marks
+    (when marked-files
+      (git-status-filenames-map status
+                                (lambda (info)
+                                        (setf (git-fileinfo->marked info) t)
+                                        (setf (git-fileinfo->needs-refresh info) t))
+                                marked-files)
+      (git-refresh-files))
     ; move point to the current file name if any
     (let ((node (and cur-name (git-find-status-file status cur-name))))
       (when node (ewoc-goto-node status node)))))
-- 
1.5.3.2.121.gf7223

-- 
Alexandre Julliard
julliard@winehq.org
