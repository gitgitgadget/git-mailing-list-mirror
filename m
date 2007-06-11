From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 2/4] Abstract a PatchSet object out of Series.
Date: Mon, 11 Jun 2007 02:33:30 +0200
Message-ID: <20070611003330.4736.69293.stgit@gandelf.nowhere.earth>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXqb-0004M4-2o
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763180AbXFKAd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763197AbXFKAd1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:33:27 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46280 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761092AbXFKAd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 20:33:26 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7253A8175;
	Mon, 11 Jun 2007 02:33:25 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id EC8621F08A;
	Mon, 11 Jun 2007 02:33:30 +0200 (CEST)
In-Reply-To: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49802>

The goal is to move into PatchSet all functionnality that is not
dependant of Series being a real stack, paving the way for handling
parallel (hydra) stacks, or any other way to organize patches.
---

 stgit/stack.py |  110 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 0d475da..35840e2 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -348,7 +348,62 @@ def update_to_current_format_version(branch, git_dir):
         raise StackException('Branch %s is at format version %d, expected %d'
                              % (branch, get_format_version(), FORMAT_VERSION))
 
-class Series(StgitObject):
+class PatchSet(StgitObject):
+    def get_name(self):
+        return self.__name
+    def set_name(self, name):
+        self.__name = name
+
+    def get_head(self):
+        """Return the head of the branch
+        """
+        crt = self.get_current_patch()
+        if crt:
+            return crt.get_top()
+        else:
+            return self.get_base()
+
+    def get_protected(self):
+        return os.path.isfile(os.path.join(self._dir(), 'protected'))
+
+    def protect(self):
+        protect_file = os.path.join(self._dir(), 'protected')
+        if not os.path.isfile(protect_file):
+            create_empty_file(protect_file)
+
+    def unprotect(self):
+        protect_file = os.path.join(self._dir(), 'protected')
+        if os.path.isfile(protect_file):
+            os.remove(protect_file)
+
+    def __branch_descr(self):
+        return 'branch.%s.description' % self.get_name()
+
+    def get_description(self):
+        return config.get(self.__branch_descr()) or ''
+
+    def set_description(self, line):
+        if line:
+            config.set(self.__branch_descr(), line)
+        else:
+            config.unset(self.__branch_descr())
+
+    def head_top_equal(self):
+        """Return true if the head and the top are the same
+        """
+        crt = self.get_current_patch()
+        if not crt:
+            # we don't care, no patches applied
+            return True
+        return git.get_head() == crt.get_top()
+
+    def is_initialised(self):
+        """Checks if series is already initialised
+        """
+        return bool(config.get(format_version_key(self.get_name())))
+
+
+class Series(PatchSet):
     """Class including the operations on series
     """
     def __init__(self, name = None):
@@ -388,11 +443,6 @@ class Series(StgitObject):
         if not name or re.search('[^\w.-]', name):
             raise StackException, 'Invalid patch name: "%s"' % name
 
-    def get_name(self):
-        return self.__name
-    def set_name(self, name):
-        self.__name = name
-        
     def get_patch(self, name):
         """Return a Patch object for the given name
         """
@@ -444,40 +494,6 @@ class Series(StgitObject):
         # No bottommost patch, so just return HEAD
         return git.get_head()
 
-    def get_head(self):
-        """Return the head of the branch
-        """
-        crt = self.get_current_patch()
-        if crt:
-            return crt.get_top()
-        else:
-            return self.get_base()
-
-    def get_protected(self):
-        return os.path.isfile(os.path.join(self._dir(), 'protected'))
-
-    def protect(self):
-        protect_file = os.path.join(self._dir(), 'protected')
-        if not os.path.isfile(protect_file):
-            create_empty_file(protect_file)
-
-    def unprotect(self):
-        protect_file = os.path.join(self._dir(), 'protected')
-        if os.path.isfile(protect_file):
-            os.remove(protect_file)
-
-    def __branch_descr(self):
-        return 'branch.%s.description' % self.get_name()
-
-    def get_description(self):
-        return config.get(self.__branch_descr()) or ''
-
-    def set_description(self, line):
-        if line:
-            config.set(self.__branch_descr(), line)
-        else:
-            config.unset(self.__branch_descr())
-
     def get_parent_remote(self):
         value = config.get('branch.%s.remote' % self.get_name())
         if value:
@@ -547,20 +563,6 @@ class Series(StgitObject):
         return self.patch_applied(name) or self.patch_unapplied(name) \
                or self.patch_hidden(name)
 
-    def head_top_equal(self):
-        """Return true if the head and the top are the same
-        """
-        crt = self.get_current_patch()
-        if not crt:
-            # we don't care, no patches applied
-            return True
-        return git.get_head() == crt.get_top()
-
-    def is_initialised(self):
-        """Checks if series is already initialised
-        """
-        return bool(config.get(format_version_key(self.get_name())))
-
     def init(self, create_at=False, parent_remote=None, parent_branch=None):
         """Initialises the stgit series
         """
