From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 7/9] Test that pulls a patch creating a file that got modified afterwards
Date: Sun, 16 Apr 2006 12:52:41 +0200
Message-ID: <20060416105241.9884.16429.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4pz-0001JH-2q
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWDPKu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWDPKu2
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:28 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:7091 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750707AbWDPKuY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:24 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 83C7C545CB;
	Sun, 16 Apr 2006 12:50:23 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4z2-0004AZ-6m; Sun, 16 Apr 2006 13:00:00 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18784>


This demonstrates an issue wite has bitten me more than once: the stg
branch adds a file in one patch, and modifies it in a later patch; then all
patches get integrated in upstream tree, and at "stg pull" time, stgit
believes there is a conflict, even one the patches are exactly the same.

"stg push" apparently does not consider patches one by one, or it
would have noticed that the patches were "already applied".  It reports:

 Pushing patch "p1"...Error: File "file2" added in branches but different
 The merge failed during "push". Use "refresh" after fixing the conflicts
 stg push: GIT index merging failed (possible conflicts)

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t1200-push-modified.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
new file mode 100755
index 0000000..18a4df2
--- /dev/null
+++ b/t/t1200-push-modified.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='Exercise pushing patches applied upstream.
+
+Especially, consider the case of a patch that adds a file,
+while a subsequent one modifies it.
+'
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
+test_expect_success \
+    'Now attempt to push those patches applied upstream' \
+    "(cd bar && stg push --all
+     )
+"
+
+test_done
