From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/3] git.el: Make status refresh faster.
Date: Tue, 08 Jan 2008 14:49:09 +0100
Message-ID: <87r6gsig16.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 14:49:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCEpq-0008FJ-8U
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 14:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYAHNtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 08:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYAHNtP
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 08:49:15 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:38273 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbYAHNtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 08:49:14 -0500
Received: from adsl-62-167-25-224.adslplus.ch ([62.167.25.224] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1JCEpL-0002FL-W0
	for git@vger.kernel.org; Tue, 08 Jan 2008 07:49:14 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 7988E1E7166; Tue,  8 Jan 2008 14:49:09 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -2.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69879>

Don't set the needs-refresh flag when inserting a new file info, since
ewoc refreshes it upon insert already; this makes a full refresh twice
as fast.

Also make git-fileinfo-prettyprint a little faster by not retrieving
permission values twice.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 825b1e9..8f39ebe 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -538,10 +538,10 @@ and returns the process output as a string."
     ('ignored  (propertize "Ignored " 'face 'git-ignored-face))
     (t "?       ")))
 
-(defun git-file-type-as-string (info)
-  "Return a string describing the file type of INFO."
-  (let* ((old-type (lsh (or (git-fileinfo->old-perm info) 0) -9))
-	 (new-type (lsh (or (git-fileinfo->new-perm info) 0) -9))
+(defun git-file-type-as-string (old-perm new-perm)
+  "Return a string describing the file type based on its permissions."
+  (let* ((old-type (lsh (or old-perm 0) -9))
+         (new-type (lsh (or new-perm 0) -9))
 	 (str (case new-type
 		(?\100  ;; file
 		 (case old-type
@@ -590,12 +590,14 @@ and returns the process output as a string."
 
 (defun git-fileinfo-prettyprint (info)
   "Pretty-printer for the git-fileinfo structure."
-  (insert (concat "   " (if (git-fileinfo->marked info) (propertize "*" 'face 'git-mark-face) " ")
-                  " " (git-status-code-as-string (git-fileinfo->state info))
-                  " " (git-permissions-as-string (git-fileinfo->old-perm info) (git-fileinfo->new-perm info))
-                  "  " (git-escape-file-name (git-fileinfo->name info))
-		  (git-file-type-as-string info)
-                  (git-rename-as-string info))))
+  (let ((old-perm (git-fileinfo->old-perm info))
+        (new-perm (git-fileinfo->new-perm info)))
+    (insert (concat "   " (if (git-fileinfo->marked info) (propertize "*" 'face 'git-mark-face) " ")
+                    " " (git-status-code-as-string (git-fileinfo->state info))
+                    " " (git-permissions-as-string old-perm new-perm)
+                    "  " (git-escape-file-name (git-fileinfo->name info))
+                    (git-file-type-as-string old-perm new-perm)
+                    (git-rename-as-string info)))))
 
 (defun git-insert-info-list (status infolist)
   "Insert a list of file infos in the status buffer, replacing existing ones if any."
@@ -606,7 +608,6 @@ and returns the process output as a string."
   (let ((info (pop infolist))
         (node (ewoc-nth status 0)))
     (while info
-      (setf (git-fileinfo->needs-refresh info) t)
       (cond ((not node)
              (setq node (ewoc-enter-last status info))
              (setq info (pop infolist)))
@@ -617,6 +618,7 @@ and returns the process output as a string."
                            (git-fileinfo->name info))
               ;; preserve the marked flag
               (setf (git-fileinfo->marked info) (git-fileinfo->marked (ewoc-data node)))
+              (setf (git-fileinfo->needs-refresh info) t)
               (setf (ewoc-data node) info)
               (setq info (pop infolist)))
             (t
-- 
1.5.4.rc2.71.ge10a9

-- 
Alexandre Julliard
julliard@winehq.org
