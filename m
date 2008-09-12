From: David Christensen <david@endpoint.com>
Subject: [PATCH] Teach git.el to mark/unmark files by regexp
Date: Thu, 11 Sep 2008 23:22:04 -0500
Message-ID: <1221193324-59334-2-git-send-email-david@endpoint.com>
References: <F0D63233-0302-4CF8-9CE1-FC12F2B80F91@endpoint.com>
 <1221193324-59334-1-git-send-email-david@endpoint.com>
Cc: julliard@winehq.org, gister@pobox.com,
	David Christensen <david@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 06:23:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke0C4-0000PF-MK
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 06:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbYILEWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 00:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbYILEWQ
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 00:22:16 -0400
Received: from smtp.sunflower.com ([24.124.0.128]:57591 "EHLO
	smtp.sunflower.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbYILEWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 00:22:15 -0400
Received: from localhost.localdomain (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by smtp.sunflower.com (8.13.1/8.13.1) with ESMTP id m8C4M5q2023382;
	Thu, 11 Sep 2008 23:22:05 -0500
X-Mailer: git-send-email 1.6.0.1.90.g27a6e.dirty
In-Reply-To: <1221193324-59334-1-git-send-email-david@endpoint.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95682>

Adds the functions git-mark-regexp and git-unmark-regexp to git.el.
Creates a mark-map keymap to support dired-like behavior for
marking/unmarking via regexp.  Also adds these functions to the
menubar.

Signed-off-by: David Christensen <david@endpoint.com>
---
 contrib/emacs/git.el |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 580652c..a982fbe 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -950,14 +950,18 @@ Return the list of files that haven't been handled."
   (when goal-column (move-to-column goal-column)))
 
 (defun git-mark-regexp (re)
-  "Mark all files which match a provided regexp."
-  (interactive "sMark files matching regular expression: ")
+  "Mark all files which match a provided regexp.  With prefix argument, unmark files which match."
+  (interactive
+   (list
+    (read-from-minibuffer (if current-prefix-arg "Unmark files matching regular expression: " "Mark files matching regular expression: "))))
   (unless git-status (error "Not in git-status buffer."))
-  (ewoc-map (lambda (info) (unless (git-fileinfo->marked info)
-                             (when (string-match re (git-fileinfo->name info))
-                               (setf (git-fileinfo->marked info) t)))) git-status)
-  ; move back to goal column after invalidate
-  (when goal-column (move-to-column goal-column)))
+  (if current-prefix-arg
+      (git-unmark-regexp re)
+    (ewoc-map (lambda (info) (unless (git-fileinfo->marked info)
+                               (when (string-match re (git-fileinfo->name info))
+                                 (setf (git-fileinfo->marked info) t)))) git-status)
+    ; move back to goal column after invalidate
+    (when goal-column (move-to-column goal-column))))
 
 (defun git-unmark-regexp (re)
   "Unmark all files which match a provided regexp."
@@ -1504,7 +1508,12 @@ amended version of it."
     (define-key toggle-map "m" 'git-toggle-all-marks)
     ; the mark submap
     (define-key mark-map "%" 'git-mark-regexp)
-    (define-key mark-map "\C-?" 'git-unmark-regexp)
+    (define-key mark-map "m" 'git-mark-file)
+    (define-key mark-map "u" 'git-unmark-file)
+    (define-key mark-map "t" 'git-toggle-all-marks)
+    (define-key mark-map "!" 'git-unmark-all)
+    (define-key mark-map "?" 'git-unmark-all)
+    (define-key mark-map "\C-?" 'git-unmark-file-up)
     (setq git-status-mode-map map))
   (easy-menu-define git-menu git-status-mode-map
     "Git Menu"
-- 
1.6.0.1.90.g27a6e.dirty
