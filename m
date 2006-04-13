From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/4] Correctly handle refs/patches on series rename
Date: Thu, 13 Apr 2006 23:44:28 +0200
Message-ID: <20060413214428.8806.38365.stgit@gandelf.nowhere.earth>
References: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 23:42:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU9aH-0001m1-V6
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 23:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWDMVmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 17:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWDMVmU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 17:42:20 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:3290 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964984AbWDMVmT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 17:42:19 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 89278731E4;
	Thu, 13 Apr 2006 23:42:18 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FU9j6-00004q-Oo; Thu, 13 Apr 2006 23:51:44 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18673>

From: Yann Dirson <ydirson@altern.org>

When renaming a series, the refs/patches dir was not moved, and
by chance a new one was created by the repository-upgrade code, but
that left the old one behind as cruft.

Also added a regression test to assert that nothing by the old name
is left behind.
---

 stgit/stack.py           |    2 ++
 t/t1001-branch-rename.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index f4d7490..92407e7 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -497,6 +497,8 @@ class Series:
             os.rename(self.__series_dir, to_stack.__series_dir)
         if os.path.exists(self.__base_file):
             os.rename(self.__base_file, to_stack.__base_file)
+        if os.path.exists(self.__refs_dir):
+            os.rename(self.__refs_dir, to_stack.__refs_dir)
 
         self.__init__(to_name)
 
diff --git a/t/t1001-branch-rename.sh b/t/t1001-branch-rename.sh
new file mode 100755
index 0000000..65a5280
--- /dev/null
+++ b/t/t1001-branch-rename.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='Branch operations.
+
+Exercises the "stg branch" commands.
+'
+
+. ./test-lib.sh
+
+test_stg_init
+
+test_expect_success \
+    'Create an stgit branch from scratch' \
+    'stg branch -c foo &&
+     stg new p1 -m "p1"
+'
+
+test_expect_failure \
+    'Rename the current stgit branch' \
+    'stg branch -r foo bar
+'
+
+test_expect_success \
+    'Rename an stgit branch' \
+    'stg branch -c buz &&
+     stg branch -r foo bar &&
+     test -z `find .git -name foo | tee /dev/stderr`
+'
+
+test_done
