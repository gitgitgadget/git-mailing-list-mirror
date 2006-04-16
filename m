From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 8/9] Exercise "stg pull" on patches just appending lines.
Date: Sun, 16 Apr 2006 12:52:44 +0200
Message-ID: <20060416105244.9884.26316.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4q1-0001JH-CY
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDPKua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWDPKu3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:29 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:57792 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750708AbWDPKu0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:26 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 2B62122114;
	Sun, 16 Apr 2006 12:50:25 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4z4-0004As-In; Sun, 16 Apr 2006 13:00:02 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18783>


It indeed reveals a problem in "push": appended lines are appended
again, as the already-applied patch is not detected.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t1201-pull-trailing.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
new file mode 100755
index 0000000..142f894
--- /dev/null
+++ b/t/t1201-pull-trailing.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='test
+
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
+    'Setup and clone tree, and setup changes' \
+    "(cd foo &&
+      printf 'a\nb\n' > file && git add file && git commit -m .
+     ) &&
+     stg clone foo bar &&
+     (cd bar && stg new p1 -m p1
+      printf 'c\n' >> file && stg refresh
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
+    'Pull those patches applied upstream' \
+    "(cd bar && stg pull
+     )
+"
+
+test_expect_success \
+    'Check that all went well' \
+    "diff -u foo/file bar/file
+"
+
+test_done
