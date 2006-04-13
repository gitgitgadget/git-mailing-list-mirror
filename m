From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/4] Add a couple of safety checks to series creation
Date: Thu, 13 Apr 2006 23:44:31 +0200
Message-ID: <20060413214431.8806.4177.stgit@gandelf.nowhere.earth>
References: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 23:42:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FU9aH-0001m1-Dv
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 23:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWDMVmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 17:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWDMVmW
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 17:42:22 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:4314 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964985AbWDMVmV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 17:42:21 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 24A2A731C3;
	Thu, 13 Apr 2006 23:42:20 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FU9j9-00004t-5Z; Thu, 13 Apr 2006 23:51:47 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060413213819.8806.53300.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18674>

From: Yann Dirson <ydirson@altern.org>

Check first whether the operation can complete, instead of
bombing out halfway.
---

 stgit/commands/branch.py |    5 +++
 stgit/stack.py           |    7 ++++-
 t/t1000-branch-create.sh |   66 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index c4b5945..c95e529 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -122,12 +122,15 @@ def func(parser, options, args):
         check_conflicts()
         check_head_top_equal()
 
+        if git.branch_exists(args[0]):
+            raise CmdException, 'Branch "%s" already exists' % args[0]
+        
         tree_id = None
         if len(args) == 2:
             tree_id = git_id(args[1])
 
-        git.create_branch(args[0], tree_id)
         stack.Series(args[0]).init()
+        git.create_branch(args[0], tree_id)
 
         print 'Branch "%s" created.' % args[0]
         return
diff --git a/stgit/stack.py b/stgit/stack.py
index 92407e7..236e67f 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -431,8 +431,13 @@ class Series:
         """
         bases_dir = os.path.join(self.__base_dir, 'refs', 'bases')
 
-        if self.is_initialised():
+        if os.path.exists(self.__patch_dir):
             raise StackException, self.__patch_dir + ' already exists'
+        if os.path.exists(self.__refs_dir):
+            raise StackException, self.__refs_dir + ' already exists'
+        if os.path.exists(self.__base_file):
+            raise StackException, self.__base_file + ' already exists'
+
         os.makedirs(self.__patch_dir)
 
         if not os.path.isdir(bases_dir):
diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
new file mode 100755
index 0000000..bee0b1c
--- /dev/null
+++ b/t/t1000-branch-create.sh
@@ -0,0 +1,66 @@
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
+test_expect_failure \
+    'Try to create an stgit branch with a spurious refs/patches/ entry' \
+    'find .git -name foo | xargs rm -rf &&
+     touch .git/refs/patches/foo &&
+     stg branch -c foo
+'
+
+test_expect_success \
+    'Check no part of the branch was created' \
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/refs/patches/foo"
+'
+
+
+test_expect_failure \
+    'Try to create an stgit branch with a spurious patches/ entry' \
+    'find .git -name foo | xargs rm -rf &&
+     touch .git/patches/foo &&
+     stg branch -c foo
+'
+
+test_expect_success \
+    'Check no part of the branch was created' \
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/patches/foo"
+'
+
+
+test_expect_failure \
+    'Try to create an stgit branch with a spurious refs/bases/ entry' \
+    'find .git -name foo | xargs rm -rf &&
+     touch .git/refs/bases/foo &&
+     stg branch -c foo
+'
+
+test_expect_success \
+    'Check no part of the branch was created' \
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/refs/bases/foo"
+'
+
+
+# test_expect_failure \
+#     'Try to create an stgit branch with a spurious refs/heads/ entry' \
+#     'find .git -name foo | xargs rm -rf &&
+#      touch .git/refs/heads/foo &&
+#      stg branch -c foo
+# '
+
+# test_expect_success \
+#     'Check no part of the branch was created' \
+#     'test "`find .git -name foo | tee /dev/stderr`" = ".git/refs/heads/foo"
+# '
+
+test_done
