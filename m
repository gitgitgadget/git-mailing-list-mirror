From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 5/7] Basic support for keeping a ref to the parent branch.
Date: Tue, 30 Jan 2007 00:05:45 +0100
Message-ID: <20070129230545.7102.92460.stgit@gandelf.nowhere.earth>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:07:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfbI-0005m9-4u
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbXA2XGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbXA2XGc
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:06:32 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:40080 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964819AbXA2XG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:06:28 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id E6D314A1F9;
	Tue, 30 Jan 2007 00:06:26 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C11711F07F;
	Tue, 30 Jan 2007 00:05:45 +0100 (CET)
In-Reply-To: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38109>


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
index 947b416..9640eb5 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -413,6 +413,26 @@ class Series(StgitObject):
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
 
@@ -466,7 +486,7 @@ class Series(StgitObject):
         """
         return os.path.isdir(self.__patch_dir)
 
-    def init(self, create_at=False):
+    def init(self, create_at=False, parent_remote=None, parent_branch=None):
         """Initialises the stgit series
         """
         bases_dir = os.path.join(self.__base_dir, 'refs', 'bases')
@@ -483,6 +503,8 @@ class Series(StgitObject):
 
         os.makedirs(self.__patch_dir)
 
+        self.set_parent(parent_remote, parent_branch)
+        
         create_dirs(bases_dir)
 
         self.create_empty_field('applied')
