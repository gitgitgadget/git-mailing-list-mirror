From: Sergei Organov <osv@javad.com>
Subject: [PATCH] git.el: automatically revert emacs buffers
Date: Mon, 21 Jan 2008 21:07:59 +0300
Message-ID: <87tzl76nfj.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 19:32:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1RC-0005nx-VK
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 19:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYAUSbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 13:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbYAUSbG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 13:31:06 -0500
Received: from javad.com ([216.122.176.236]:1425 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751839AbYAUSbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 13:31:05 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m0LIV2d13452;
	Mon, 21 Jan 2008 18:31:03 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JH1Q8-0001yi-Gv; Mon, 21 Jan 2008 21:30:56 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71305>

* git-auto-revert: new customizable variable.
* git-revert-some-buffers: new function.
* git-revert-file: call git-revert-some-buffers.

Signed-off-by: Sergei Organov <osv@javad.com>
---
 contrib/emacs/git.el |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index d8a0638..c3c0c45 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -112,6 +112,11 @@ if there is already one that displays the same directory."
   :group 'git
   :type 'boolean)
 
+(defcustom git-auto-revert t
+  "Non-nil if `git-revert-file' should automatically revert corresponding buffers."
+  :group 'git
+  :type 'boolean)
+
 
 (defface git-status-face
   '((((class color) (background light)) (:foreground "purple"))
@@ -989,6 +994,23 @@ Return the list of files that haven't been handled."
           (git-success-message "Removed" files))
       (message "Aborting"))))
 
+;; stolen from pcl-cvs's cvs-revert-if-needed
+(defun git-revert-some-buffers (fis)
+  (dolist (fileinfo fis)
+    (let* ((file (git-fileinfo->name fileinfo))
+	   (buffer (find-buffer-visiting file)))
+      ;; For a revert to happen the user must be editing the file...
+      (unless (or (null buffer)
+		  (buffer-modified-p buffer))
+	(with-current-buffer buffer
+	  (ignore-errors
+	    (revert-buffer 'ignore-auto 'dont-ask 'preserve-modes)
+	    ;; `preserve-modes' avoids changing the (minor) modes.  But we
+	    ;; do want to reset the mode for VC, so we do it explicitly.
+	    (vc-find-file-hook)
+	    (when (eq (git-fileinfo->state fileinfo) 'unmerged)
+	      (smerge-mode 1))))))))
+
 (defun git-revert-file ()
   "Revert changes to the marked file(s)."
   (interactive)
@@ -1008,6 +1030,7 @@ Return the list of files that haven't been handled."
       (when modified
         (apply #'git-call-process-env nil nil "checkout" "HEAD" modified))
       (git-update-status-files (append added modified) 'uptodate)
+      (if git-auto-revert (git-revert-some-buffers files))
       (git-success-message "Reverted" (git-get-filenames files)))))
 
 (defun git-resolve-file ()
-- 
1.5.4.rc3.30.g472ca
