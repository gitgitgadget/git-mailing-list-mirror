From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 6/9] Fix a seriously bad interaction between .git caching and repo cloning
Date: Sun, 16 Apr 2006 12:52:39 +0200
Message-ID: <20060416105239.9884.5212.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4py-0001JH-HV
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWDPKu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWDPKu0
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:26 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:55232 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750711AbWDPKuV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:21 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 24A732221C;
	Sun, 16 Apr 2006 12:50:20 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4yz-0004AW-Q1; Sun, 16 Apr 2006 12:59:57 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18785>


Testcase 2 exhibits a problem with caching the location of .git while
cloning a repository.  Since basedir.get() is called before the clone is
built, a value may get stored in the cache if we are within a
git-controlled tree already.  Then when constructing the object for the
clone, a bogus .git is used, which can lead, when running tests in t/trash,
to corruption of the stgit .git repository.

Testcase 1 does not show any problem by chance, because since we have a
./.git prepared for use by the testsuite, value ".git" get cached, and it
happens that this value will be still valid after chdir'ing into the
newborn clone.

Clearing the cache at the appropriate place fixes the problem.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/basedir.py        |    6 ++++++
 stgit/commands/clone.py |    3 +++
 t/t1100-clone-under.sh  |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/stgit/basedir.py b/stgit/basedir.py
index c394572..81f2b40 100644
--- a/stgit/basedir.py
+++ b/stgit/basedir.py
@@ -42,3 +42,9 @@ def get():
             __base_dir = __output('git-rev-parse --git-dir 2> /dev/null')
 
     return __base_dir
+
+def clear_cache():
+    """Clear the cached location of .git
+    """
+    global __base_dir
+    __base_dir = None
diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index 9ad76a6..455dd6e 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -51,6 +51,9 @@ def func(parser, options, args):
     os.chdir(local_dir)
     git.checkout(tree_id = 'HEAD')
 
+    # be sure to forget any cached value for .git, since we're going
+    # to work on a brand new repository
+    basedir.clear_cache()
     stack.Series().init()
 
     print 'done'
diff --git a/t/t1100-clone-under.sh b/t/t1100-clone-under.sh
new file mode 100755
index 0000000..c86ef61
--- /dev/null
+++ b/t/t1100-clone-under.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 Yann Dirson
+#
+
+test_description='Check cloning in a repo subdir
+
+Check that "stg clone" works in a subdir of a git tree.
+This ensures (to some point) that a clone within a tree does
+not corrupt the enclosing repo.
+
+This test must be run before any tests making use of clone.
+'
+
+. ./test-lib.sh
+
+# Here we are in a repo, we have a ./.git
+# Do not get rid of it, or a bug may bite out stgit repo hard
+
+# Need a repo to clone
+test_create_repo foo
+
+test_expect_success \
+    'stg clone right inside a git tree' \
+    "stg clone foo bar"
+
+# now work in a subdir
+mkdir sub
+mv foo sub
+cd sub
+
+test_expect_success \
+    'stg clone deeper under a git tree' \
+    "stg clone foo bar"
+
+test_done
