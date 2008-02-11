From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH v2 2/2] Emacs mode: delete patches
Date: Mon, 11 Feb 2008 23:26:24 +0100
Message-ID: <20080211222537.15978.91287.stgit@yoghurt>
References: <87tzkfssxv.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOh7D-0007vM-CU
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758373AbYBKW0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 17:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375AbYBKW0b
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:26:31 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4405 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758261AbYBKW0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 17:26:30 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOh6W-0001dh-00; Mon, 11 Feb 2008 22:26:24 +0000
In-Reply-To: <87tzkfssxv.fsf@lysator.liu.se>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73598>

Teach the emacs mode to delete patches. It will delete the selected
patches, or, if no patches are selected, the patch at point (and if
there is no patch at point, complain). Before deleting, it will ask
for confirmation.

Thanks to David K=C3=A5gedal <davidk@lysator.liu.se> for lots of elisp
help.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 contrib/stgit.el |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 386d46e..1036cf9 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -150,7 +150,8 @@ Argument DIR is the repository path."
   (define-key stgit-mode-map "<"   'stgit-pop-next)
   (define-key stgit-mode-map "P"   'stgit-push-or-pop)
   (define-key stgit-mode-map "G"   'stgit-goto)
-  (define-key stgit-mode-map "=3D"   'stgit-show))
+  (define-key stgit-mode-map "=3D"   'stgit-show)
+  (define-key stgit-mode-map "D"   'stgit-delete))
=20
 (defun stgit-mode ()
   "Major mode for interacting with StGit.
@@ -187,6 +188,15 @@ Commands:
         (match-string-no-properties 1)
       nil)))
=20
+(defun stgit-patches-marked-or-at-point ()
+  "Return the names of the marked patches, or the patch on the current=
 line."
+  (if stgit-marked-patches
+      (stgit-marked-patches)
+    (let ((patch (stgit-patch-at-point)))
+      (if patch
+          (list patch)
+        '()))))
+
 (defun stgit-goto-patch (patch)
   "Move point to the line containing PATCH"
   (let ((p (point)))
@@ -341,6 +351,17 @@ Commands:
            (substring patch 0 20))
           (t patch))))
=20
+(defun stgit-delete (patch-names)
+  "Delete the named patches"
+  (interactive (list (stgit-patches-marked-or-at-point)))
+  (if (zerop (length patch-names))
+      (error "No patches to delete")
+    (when (yes-or-no-p (format "Really delete %d patches? "
+                               (length patch-names)))
+      (stgit-capture-output nil
+        (apply 'stgit-run "delete" patch-names))
+      (stgit-refresh))))
+
 (defun stgit-coalesce (patch-names)
   "Run stg coalesce on the named patches"
   (interactive (list (stgit-marked-patches)))
