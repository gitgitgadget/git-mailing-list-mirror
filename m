From: Sergei Organov <osv@javad.com>
Subject: [PATCH] git.el: automatically revert emacs buffers
Date: Mon, 21 Jan 2008 21:07:59 +0300
Message-ID: <874pcnh4ej.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Julliard <julliard@winehq.org>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 15:20:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMOey-00016t-Kq
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 15:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbYBEOTv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 09:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYBEOTu
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 09:19:50 -0500
Received: from javad.com ([216.122.176.236]:4387 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbYBEOTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 09:19:48 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m15EJhd01944;
	Tue, 5 Feb 2008 14:19:44 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JMOe4-00081q-B6; Tue, 05 Feb 2008 17:19:32 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72659>

If new custom variable git-auto-revert is 't', after git-revert-file,
revert corresponding emacs buffers from reverted files provided the
buffers were not changed. This is how pcl-cvs behaves.

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
1.5.4.18.gd0b8
