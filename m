From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Test that pulls a patch creating a file that got modified afterwards
Date: Sun, 16 Apr 2006 22:40:29 +0200
Message-ID: <20060416204029.10137.80865.stgit@gandelf.nowhere.earth>
References: <20060416203448.10137.69093.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 22:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVE0e-00010X-VR
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 22:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWDPUiK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 16:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWDPUiK
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 16:38:10 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:24000 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750802AbWDPUiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 16:38:09 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id ADE4E6CE46;
	Sun, 16 Apr 2006 22:38:08 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FVE9s-0005Dm-0K; Sun, 16 Apr 2006 22:47:48 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416203448.10137.69093.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18803>

From: Yann Dirson <ydirson@altern.org>

This demonstrates an issue wite has bitten me more than once: the stg
branch adds a file in one patch, and modifies it in a later patch; then all
patches get integrated in upstream tree, and at "stg pull" time, stgit
believes there is a conflict, even when the patches are exactly the same.

This is normal as it requires the --merged flag on push or pull.  So
we rollback with "push --undo" and "push --merge" to finish.
---

 t/t1200-push-modified.sh |   64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
new file mode 100755
index 0000000..7847a38
--- /dev/null
+++ b/t/t1200-push-modified.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='Exercise pushing patches applied upstream.
+
+Especially, consider the case of a patch that adds a file, while a
+subsequent one modifies it, so we have to use --merged for push to
+detect the merge.  Reproduce the common workflow where one does not
+specify --merged, then rollback and retry with the correct flag.'
+
+. ./test-lib.sh
+
+# don't need this repo, but better not drop it, see t1100
+#rm -rf .git
+
+# Need a repo to clone
+test_create_repo foo
+
+test_expect_success \
+    'Clone tree and setup changes' \
+    "stg clone foo bar &&
+     (cd bar && stg new p1 -m p1
+      printf 'a\nc\n' > file && stg add file && stg refresh &&
+      stg new p2 -m p2
+      printf 'a\nb\nc\n' > file && stg refresh
+     )
+"
+
+test_expect_success \
+    'Port those patches to orig tree' \
+    "(cd foo &&
+      GIT_DIR=../bar/.git git-format-patch --stdout bases/master..HEAD |
+      git-am -3 -k
+     )
+"
+
+test_expect_success \
+    'Pull to sync with parent, preparing for the problem' \
+    "(cd bar && stg pop --all &&
+      stg pull
+     )
+"
+
+test_expect_failure \
+    'Attempt to push the first of those patches without --merged' \
+    "(cd bar && stg push
+     )
+"
+
+test_expect_success \
+    'Rollback the push' \
+    "(cd bar && stg push --undo
+     )
+"
+
+test_expect_success \
+    'Push those patches while checking they were merged upstream' \
+    "(cd bar && stg push --merged --all
+     )
+"
+
+test_done
