From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/9] Correctly handle refs/patches on series rename
Date: Sun, 16 Apr 2006 12:52:37 +0200
Message-ID: <20060416105237.9884.44865.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4q0-0001JH-8K
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWDPKuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWDPKuY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:24 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:14208 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750710AbWDPKuT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:19 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id ACD259A3E2;
	Sun, 16 Apr 2006 12:50:18 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4yx-0004AT-J3; Sun, 16 Apr 2006 12:59:55 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18781>


When renaming a series, the refs/patches dir was not moved, and by
chance a new one was created by the repository-upgrade code, but that
left the old one behind as cruft (which the safety checks added in a
former patch now detects).

Also adds a regression test to assert that nothing by the old name
is left behind.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py           |    2 ++
 t/t1001-branch-rename.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 19bb62a..975ac21 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -505,6 +505,8 @@ class Series:
             os.rename(self.__series_dir, to_stack.__series_dir)
         if os.path.exists(self.__base_file):
             os.rename(self.__base_file, to_stack.__base_file)
+        if os.path.exists(self.__refs_dir):
+            os.rename(self.__refs_dir, to_stack.__refs_dir)
 
         self.__init__(to_name)
 
diff --git a/t/t1001-branch-rename.sh b/t/t1001-branch-rename.sh
new file mode 100755
index 0000000..28da15c
--- /dev/null
+++ b/t/t1001-branch-rename.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='Branch renames.
+
+Exercises branch renaming commands.
+'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'Create an stgit branch from scratch' \
+    'stg init &&
+     stg branch -c foo &&
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
