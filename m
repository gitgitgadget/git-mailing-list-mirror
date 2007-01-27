From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/6] Basic support for keeping a ref to the parent branch.
Date: Sat, 27 Jan 2007 18:22:48 +0100
Message-ID: <20070127172248.27183.82154.stgit@gandelf.nowhere.earth>
References: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:24:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArHg-00039p-Dy
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbXA0RYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbXA0RYG
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:24:06 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:58446 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbXA0RYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:24:05 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 2BDC527BC4;
	Sat, 27 Jan 2007 18:24:02 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id DA6491F089;
	Sat, 27 Jan 2007 18:22:48 +0100 (CET)
In-Reply-To: <20070127172129.27183.50432.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37973>


This adds a framework to handle the parent branch of a stack, in
addition to the parent remote, and to set them when creating a stack.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 TODO           |    2 --
 stgit/stack.py |   24 +++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/TODO b/TODO
index 549bc9d..884b831 100644
--- a/TODO
+++ b/TODO
@@ -20,8 +20,6 @@ The future, when time allows or if someone else does them:
 - multiple heads in a patch - useful for forking a patch,
   synchronising with other patches (diff format or in other
   repositories)
-- "pull" argument should default to a sane value, "origin" is wrong in
-  many cases
 - commit directly to a patch which is not top
 - patch synchronisation between between branches (as some people,
   including me have the same patches based on different branches and
diff --git a/stgit/stack.py b/stgit/stack.py
index 026fc36..603c539 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -408,6 +408,26 @@ class Series(StgitObject):
     def __set_parent_remote(self, remote):
         value = config.set('branch.%s.remote' % self.__name, remote)
 
+    def get_parent_branch(self):
+        value = config.get('branch.%s.merge' % self.__name)
+        if value:
+            return value
+        elif rev_parse('heads/origin'):
+            return 'heads/origin'
+        else:
+            raise StackException, 'Cannot find a parent branch for "%s"' % self.__name
+
+    def __set_parent_branch(self, name):
+        config.set('branch.%s.merge' % self.__name, name)
+
+    def set_parent(self, remote, localbranch):
+        if localbranch:
+            self.__set_parent_branch(localbranch)
+            if remote:
+                self.__set_parent_remote(remote)
+        elif remote:
+            raise StackException, 'Remote "%s" without a branch cannot be used as parent' % remote
+
     def __patch_is_current(self, patch):
         return patch.get_name() == self.get_current()
 
@@ -456,7 +476,7 @@ class Series(StgitObject):
         """
         return os.path.isdir(self.__patch_dir)
 
-    def init(self, create_at=False):
+    def init(self, create_at=False, parent_remote=None, parent_branch=None):
         """Initialises the stgit series
         """
         bases_dir = os.path.join(self.__base_dir, 'refs', 'bases')
@@ -473,6 +493,8 @@ class Series(StgitObject):
 
         os.makedirs(self.__patch_dir)
 
+        self.set_parent(parent_remote, parent_branch)
+        
         create_dirs(bases_dir)
 
         self.create_empty_field('applied')
