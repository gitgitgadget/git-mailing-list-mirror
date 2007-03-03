From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 5/7] Try to do things in the right order
Date: Sat, 03 Mar 2007 11:19:52 +0100
Message-ID: <15303.1172917192@localhost>
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 11:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNRO4-0004xR-Ij
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbXCCKWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbXCCKWp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:22:45 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:47809 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbXCCKWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:22:44 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2F1727D23;
	Sat,  3 Mar 2007 11:22:43 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l23AJqpX015304;
	Sat, 3 Mar 2007 11:19:52 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41283>


* emacs/vc-git.el: Added an ugly hack to properly reload vc-git. Only
  add GIT to vc-backends list after loading vc. Do not walk .git
  directory (add it to the exclusion-list).

  Changed installation instructions as discussed on Git mailing list

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/vc-git.el |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
index 748cb60..3f37e6d 100644
--- a/contrib/emacs/vc-git.el
+++ b/contrib/emacs/vc-git.el
@@ -22,7 +22,8 @@
 ;; This file contains a VC backend for the git version control
 ;; system.
 ;;
-;; To install: put this file on the load-path.
+;; To install: put this file on the load-path then add this line into
+;;   your .emacs: (require 'vc-git)
 ;;
 ;; TODO
 ;;  - changelog generation
@@ -35,8 +36,14 @@
   (require 'vc)
   (require 'cl))
 
-;; Add it automatically
-(add-to-list 'vc-handled-backends 'GIT)
+;; HACK: clear up the cache to force vc-call to check again and
+;; discover new functions when we reload this file.
+(put 'GIT 'vc-functions nil)
+
+;; Add it automatically when loading vc
+;; FIXME: should be directly put into vc.el
+(eval-after-load "vc"
+  '(add-to-list 'vc-handled-backends 'GIT))
 
 (defgroup vc-git nil
   "*This is GIT backend for vc."
@@ -188,4 +195,8 @@ COMMENT is the new comment."
 ;;;###autoload
 (add-to-list 'completion-ignored-extensions ".git/")
 
+(eval-after-load "vc" 
+    '(add-to-list 'vc-directory-exclusion-list ".git" t))
+
 (provide 'vc-git)
+;;; vc-git.el ends here
\ No newline at end of file
-- 
1.5.0
