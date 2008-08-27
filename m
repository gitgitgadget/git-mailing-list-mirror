From: David Christensen <david@endpoint.com>
Subject: [PATCH] Teach git.el to mark/unmark files by regexp
Date: Tue, 26 Aug 2008 22:24:40 -0500
Message-ID: <1219807480-57122-1-git-send-email-david@endpoint.com>
Cc: David Christensen <david@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 06:27:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYCcd-0001k4-Fo
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 06:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbYH0EYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 00:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbYH0EYi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 00:24:38 -0400
Received: from smtp.sunflower.com ([24.124.0.128]:41060 "EHLO
	smtp.sunflower.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbYH0EYi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 00:24:38 -0400
X-Greylist: delayed 3591 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Aug 2008 00:24:38 EDT
Received: from localhost.localdomain (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by smtp.sunflower.com (8.13.1/8.13.1) with ESMTP id m7R3Oep5010024;
	Tue, 26 Aug 2008 22:24:40 -0500
X-Mailer: git-send-email 1.6.0.1.90.g27a6e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93850>

Adds the functions git-mark-regexp and git-unmark-regexp to git.el.
Creates a mark-map keymap to support dired-like behavior for
marking/unmarking via regexp.  Also adds these functions to the
menubar.

Signed-off-by: David Christensen <david@endpoint.com>
---
 contrib/emacs/git.el |   30 +++++++++++++++++++++++++++++-
 1 files changed, 29 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index c1cf1cb..279610f 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -944,6 +944,27 @@ Return the list of files that haven't been handled."
   ; move back to goal column after invalidate
   (when goal-column (move-to-column goal-column)))
 
+(defun git-mark-regexp (re)
+  "Mark all files which match a provided regexp."
+  (interactive "sMark files matching regular expression: ")
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-map (lambda (info) (unless (git-fileinfo->marked info)
+                             (when (string-match re (git-fileinfo->name info))
+                               (setf (git-fileinfo->marked info) t)))) git-status)
+  ; move back to goal column after invalidate
+  (when goal-column (move-to-column goal-column)))
+
+(defun git-unmark-regexp (re)
+  "Unmark all files which match a provided regexp."
+  (interactive "sUnmark files matching regular expression: ")
+  (unless git-status (error "Not in git-status buffer."))
+  (ewoc-map (lambda (info) (when (git-fileinfo->marked info)
+                             (when (string-match re (git-fileinfo->name info))
+                               (setf (git-fileinfo->marked info) nil)) t)) git-status)
+  ; move back to goal column after invalidate
+  (when goal-column (move-to-column goal-column)))
+
+
 (defun git-toggle-all-marks ()
   "Toggle all file marks."
   (interactive)
@@ -1420,9 +1441,11 @@ amended version of it."
   (let ((map (make-keymap))
         (commit-map (make-sparse-keymap))
         (diff-map (make-sparse-keymap))
-        (toggle-map (make-sparse-keymap)))
+        (toggle-map (make-sparse-keymap))
+        (mark-map (make-sparse-keymap)))
     (suppress-keymap map)
     (define-key map "?"   'git-help)
+    (define-key map "*"    mark-map)
     (define-key map "h"   'git-help)
     (define-key map " "   'git-next-file)
     (define-key map "a"   'git-add-file)
@@ -1469,6 +1492,9 @@ amended version of it."
     (define-key toggle-map "i" 'git-toggle-show-ignored)
     (define-key toggle-map "k" 'git-toggle-show-unknown)
     (define-key toggle-map "m" 'git-toggle-all-marks)
+    ; the mark submap
+    (define-key mark-map "%" 'git-mark-regexp)
+    (define-key mark-map "\C-?" 'git-unmark-regexp)
     (setq git-status-mode-map map))
   (easy-menu-define git-menu git-status-mode-map
     "Git Menu"
@@ -1499,8 +1525,10 @@ amended version of it."
       "--------"
       ["Mark" git-mark-file t]
       ["Mark All" git-mark-all t]
+      ["Mark Regexp" git-mark-regexp t]
       ["Unmark" git-unmark-file t]
       ["Unmark All" git-unmark-all t]
+      ["Unmark Regexp" git-unmark-regexp t]
       ["Toggle All Marks" git-toggle-all-marks t]
       ["Hide Handled Files" git-remove-handled t]
       "--------"
-- 
1.6.0.1.90.g27a6e.dirty
