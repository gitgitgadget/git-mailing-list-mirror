From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/9] Add a couple of safety checks to series creation
Date: Sun, 16 Apr 2006 12:52:32 +0200
Message-ID: <20060416105232.9884.62033.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4px-0001JH-Uq
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDPKuU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDPKuS
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:18 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:18908 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750708AbWDPKuO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:14 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8150744446;
	Sun, 16 Apr 2006 12:50:13 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4ys-0004AN-Vm; Sun, 16 Apr 2006 12:59:51 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18786>


- we must check first whether the operation can complete, instead of
  bombing out halfway.  That means checking that nothing will prevent
  the creation of stgit data (note that calling is_initialised() is
  not enough, as it does not catch a bogus file), which is tested by
  the 3 first couple of testcases, and fixed in stack.py

- creating the git branch unconditionally before knowing whether
  creation of the stgit stuff can be completed is a problem as well:
  being atomic would be much much better.  To emulate atomicity (which
  comeds in the next patch), this patch does a somewhat dirty hack to
  branch.py: we first attempt to create the stgit stuff, and if that
  succeeds, we create the git branch: it is much easier to do at first
  a quick check that the latter will succeed.  Testcase 7/8 ensure
  that such a safety check has not been forgotten.

- when git already reports a problem with that head we would like to
  create, we should catch it.  Testcase 9/10 creates such a situation,
  and the fix to git.py allows to catch the error spit out by
  git-rev-parse.  I cannot tell why the stderr lines were not included
  by the Popen3 object.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/branch.py |    5 ++-
 stgit/git.py             |    4 ++
 stgit/stack.py           |    7 +++-
 t/t1000-branch-create.sh |   82 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index c4b5945..be501a8 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -126,8 +126,11 @@ def func(parser, options, args):
         if len(args) == 2:
             tree_id = git_id(args[1])
 
-        git.create_branch(args[0], tree_id)
+        if git.branch_exists(args[0]):
+            raise CmdException, 'Branch "%s" already exists' % args[0]
+        
         stack.Series(args[0]).init()
+        git.create_branch(args[0], tree_id)
 
         print 'Branch "%s" created.' % args[0]
         return
diff --git a/stgit/git.py b/stgit/git.py
index d75b54e..8523455 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -272,9 +272,11 @@ def rev_parse(git_id):
 def branch_exists(branch):
     """Existence check for the named branch
     """
-    for line in _output_lines(['git-rev-parse', '--symbolic', '--all']):
+    for line in _output_lines('git-rev-parse --symbolic --all 2>&1'):
         if line.strip() == branch:
             return True
+        if re.compile('[ |/]'+branch+' ').search(line):
+            raise GitException, 'Bogus branch: %s' % line
     return False
 
 def create_branch(new_branch, tree_id = None):
diff --git a/stgit/stack.py b/stgit/stack.py
index f4d7490..c14e029 100644
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
index 0000000..f0c2367
--- /dev/null
+++ b/t/t1000-branch-create.sh
@@ -0,0 +1,82 @@
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
+stg init
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
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/refs/patches/foo" &&
+     ( grep foo .git/HEAD; test $? = 1 )
+'
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
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/patches/foo" &&
+     ( grep foo .git/HEAD; test $? = 1 )
+'
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
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/refs/bases/foo" &&
+     ( grep foo .git/HEAD; test $? = 1 )
+'
+
+
+test_expect_failure \
+    'Try to create an stgit branch with an existing git branch by that name' \
+    'find .git -name foo | xargs rm -rf &&
+     cp .git/refs/heads/master .git/refs/heads/foo &&
+     stg branch -c foo
+'
+
+test_expect_success \
+    'Check no part of the branch was created' \
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/refs/heads/foo" &&
+     ( grep foo .git/HEAD; test $? = 1 )
+'
+
+
+test_expect_failure \
+    'Try to create an stgit branch with an invalid refs/heads/ entry' \
+    'find .git -name foo | xargs rm -rf &&
+     touch .git/refs/heads/foo &&
+     stg branch -c foo
+'
+
+test_expect_success \
+    'Check no part of the branch was created' \
+    'test "`find .git -name foo | tee /dev/stderr`" = ".git/refs/heads/foo" &&
+     ( grep foo .git/HEAD; test $? = 1 )
+'
+
+test_done
