From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/9] Make branch creation atomic
Date: Sun, 16 Apr 2006 12:52:35 +0200
Message-ID: <20060416105234.9884.38492.stgit@gandelf.nowhere.earth>
References: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 12:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV4pz-0001JH-Lk
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 12:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWDPKuW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 06:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWDPKuW
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 06:50:22 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:12928 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750705AbWDPKuQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 06:50:16 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 96EA59A4BA;
	Sun, 16 Apr 2006 12:50:15 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by nan92-1-81-57-214-146 with esmtp (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1FV4yv-0004AQ-8W; Sun, 16 Apr 2006 12:59:53 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060416104144.9884.28167.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18782>


This patch adds an optional create_at parameter to Series.init(), to
pass a git.branch_create() parameter if we want it to be called.  This
parameter can be None, so the test for False has to be explicit.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/branch.py |    6 +-----
 stgit/stack.py           |    8 +++++---
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index be501a8..c7561a8 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -125,12 +125,8 @@ def func(parser, options, args):
         tree_id = None
         if len(args) == 2:
             tree_id = git_id(args[1])
-
-        if git.branch_exists(args[0]):
-            raise CmdException, 'Branch "%s" already exists' % args[0]
         
-        stack.Series(args[0]).init()
-        git.create_branch(args[0], tree_id)
+        stack.Series(args[0]).init(create_at = tree_id)
 
         print 'Branch "%s" created.' % args[0]
         return
diff --git a/stgit/stack.py b/stgit/stack.py
index c14e029..19bb62a 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -426,7 +426,7 @@ class Series:
         """
         return os.path.isdir(self.__patch_dir)
 
-    def init(self):
+    def init(self, create_at=False):
         """Initialises the stgit series
         """
         bases_dir = os.path.join(self.__base_dir, 'refs', 'bases')
@@ -438,6 +438,9 @@ class Series:
         if os.path.exists(self.__base_file):
             raise StackException, self.__base_file + ' already exists'
 
+        if (create_at!=False):
+            git.create_branch(self.__name, create_at)
+
         os.makedirs(self.__patch_dir)
 
         if not os.path.isdir(bases_dir):
@@ -509,8 +512,7 @@ class Series:
         """Clones a series
         """
         base = read_string(self.get_base_file())
-        git.create_branch(target_series, tree_id = base)
-        Series(target_series).init()
+        Series(target_series).init(create_at = base)
         new_series = Series(target_series)
 
         # generate an artificial description file
