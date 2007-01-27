From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/5] Basic support for keeping a ref to the parent branch.
Date: Sat, 27 Jan 2007 12:21:27 +0100
Message-ID: <20070127112127.16475.31003.stgit@gandelf.nowhere.earth>
References: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 12:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAle6-00059K-Ob
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 12:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbXA0LWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 06:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbXA0LWm
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 06:22:42 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:50596 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbXA0LWl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 06:22:41 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 09D4C4A1FC;
	Sat, 27 Jan 2007 12:22:40 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1HAle6-0003ZO-Id; Sat, 27 Jan 2007 12:22:58 +0100
In-Reply-To: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37943>


This adds a framework to handle the parent branch of a stack, in
addition to the parent remote, and to set them when creating a stack.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 TODO           |    2 --
 stgit/stack.py |   27 ++++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

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
index e801f42..9d4f881 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -410,6 +410,29 @@ class Series(StgitObject):
             config.add_section(section)
         config.set(section, 'remote', remote)
 
+    def get_parent_branch(self):
+        section = 'branch "%s"' % self.__name
+        if config.has_option(section, 'merge'):
+            return config.get(section, 'merge')
+        elif rev_parse('heads/origin'):
+            return 'heads/origin'
+        else:
+            raise StackException, 'Cannot find a parent branch for "%s"' % self.__name
+
+    def __set_parent_branch(self, name):
+        section = 'branch "%s"' % self.__name
+        if not config.has_section(section):
+            config.add_section(section)
+        config.set(section, 'merge', name)
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
 
@@ -458,7 +481,7 @@ class Series(StgitObject):
         """
         return os.path.isdir(self.__patch_dir)
 
-    def init(self, create_at=False):
+    def init(self, create_at=False, parent_remote=None, parent_branch=None):
         """Initialises the stgit series
         """
         bases_dir = os.path.join(self.__base_dir, 'refs', 'bases')
@@ -475,6 +498,8 @@ class Series(StgitObject):
 
         os.makedirs(self.__patch_dir)
 
+        self.set_parent(parent_remote, parent_branch)
+        
         create_dirs(bases_dir)
 
         self.create_empty_field('applied')
