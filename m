From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Emacs mode: automatically cd up to root of worktree
Date: Wed, 14 May 2008 03:49:09 +0200
Message-ID: <20080514014820.7140.28591.stgit@yoghurt>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 03:50:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw68F-00056d-8H
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbYENBtQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 21:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYENBtP
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:49:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4091 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823AbYENBtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 21:49:14 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jw67B-0004j0-00; Wed, 14 May 2008 02:49:09 +0100
In-Reply-To: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.2.152.g77bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82064>

git's emacs mode automatically finds the root of the worktree, so that
the user doesn't have to. Teach StGit's emacs mode the same trick by
borrowing the git-get-top-dir function from git.

The borrowed code was written by Alexandre Julliard <julliard@winehq.or=
g>.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

David, would you sanity check this for me?

 contrib/stgit.el |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)


diff --git a/contrib/stgit.el b/contrib/stgit.el
index 339ef13..2a6fee3 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -12,9 +12,20 @@
 (defun stgit (dir)
   "Manage stgit patches"
   (interactive "DDirectory: \n")
-  (switch-to-stgit-buffer dir)
+  (switch-to-stgit-buffer (git-get-top-dir dir))
   (stgit-refresh))
=20
+(defun git-get-top-dir (dir)
+  "Retrieve the top-level directory of a git tree."
+  (let ((cdup (with-output-to-string
+                (with-current-buffer standard-output
+                  (cd dir)
+                  (unless (eq 0 (call-process "git" nil t nil
+                                              "rev-parse" "--show-cdup=
"))
+                    (error "cannot find top-level git tree for %s." di=
r))))))
+    (expand-file-name (concat (file-name-as-directory dir)
+                              (car (split-string cdup "\n"))))))
+
 (defun switch-to-stgit-buffer (dir)
   "Switch to a (possibly new) buffer displaying StGit patches for DIR"
   (setq dir (file-name-as-directory dir))
