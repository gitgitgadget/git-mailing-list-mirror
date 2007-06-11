From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 3/4] Move stack format-version checks into Stack class.
Date: Mon, 11 Jun 2007 02:33:36 +0200
Message-ID: <20070611003336.4736.95971.stgit@gandelf.nowhere.earth>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 02:33:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxXqt-0004P8-HQ
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 02:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763232AbXFKAdc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 20:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763244AbXFKAdc
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 20:33:32 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:46283 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763215AbXFKAdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 20:33:31 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 8E55F389D;
	Mon, 11 Jun 2007 02:33:30 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3AD901F08A;
	Mon, 11 Jun 2007 02:33:36 +0200 (CEST)
In-Reply-To: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49805>

This defines an interface which is called from PatchSet, and can
(must) be implemented in classes inheriting PatchSet.
---

 stgit/stack.py |  150 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 35840e2..89b5a55 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -276,78 +276,6 @@ class Patch(StgitObject):
 # The current StGIT metadata format version.
 FORMAT_VERSION = 2
 
-def format_version_key(branch):
-    return 'branch.%s.stgitformatversion' % branch
-
-def update_to_current_format_version(branch, git_dir):
-    """Update a potentially older StGIT directory structure to the
-    latest version. Note: This function should depend as little as
-    possible on external functions that may change during a format
-    version bump, since it must remain able to process older formats."""
-
-    branch_dir = os.path.join(git_dir, 'patches', branch)
-    def get_format_version():
-        """Return the integer format version number, or None if the
-        branch doesn't have any StGIT metadata at all, of any version."""
-        fv = config.get(format_version_key(branch))
-        if fv:
-            # Great, there's an explicitly recorded format version
-            # number, which means that the branch is initialized and
-            # of that exact version.
-            return int(fv)
-        elif os.path.isdir(os.path.join(branch_dir, 'patches')):
-            # There's a .git/patches/<branch>/patches dirctory, which
-            # means this is an initialized version 1 branch.
-            return 1
-        elif os.path.isdir(branch_dir):
-            # There's a .git/patches/<branch> directory, which means
-            # this is an initialized version 0 branch.
-            return 0
-        else:
-            # The branch doesn't seem to be initialized at all.
-            return None
-    def set_format_version(v):
-        out.info('Upgraded branch %s to format version %d' % (branch, v))
-        config.set(format_version_key(branch), '%d' % v)
-    def mkdir(d):
-        if not os.path.isdir(d):
-            os.makedirs(d)
-    def rm(f):
-        if os.path.exists(f):
-            os.remove(f)
-
-    # Update 0 -> 1.
-    if get_format_version() == 0:
-        mkdir(os.path.join(branch_dir, 'trash'))
-        patch_dir = os.path.join(branch_dir, 'patches')
-        mkdir(patch_dir)
-        refs_dir = os.path.join(git_dir, 'refs', 'patches', branch)
-        mkdir(refs_dir)
-        for patch in (file(os.path.join(branch_dir, 'unapplied')).readlines()
-                      + file(os.path.join(branch_dir, 'applied')).readlines()):
-            patch = patch.strip()
-            os.rename(os.path.join(branch_dir, patch),
-                      os.path.join(patch_dir, patch))
-            Patch(patch, patch_dir, refs_dir).update_top_ref()
-        set_format_version(1)
-
-    # Update 1 -> 2.
-    if get_format_version() == 1:
-        desc_file = os.path.join(branch_dir, 'description')
-        if os.path.isfile(desc_file):
-            desc = read_string(desc_file)
-            if desc:
-                config.set('branch.%s.description' % branch, desc)
-            rm(desc_file)
-        rm(os.path.join(branch_dir, 'current'))
-        rm(os.path.join(git_dir, 'refs', 'bases', branch))
-        set_format_version(2)
-
-    # Make sure we're at the latest version.
-    if not get_format_version() in [None, FORMAT_VERSION]:
-        raise StackException('Branch %s is at format version %d, expected %d'
-                             % (branch, get_format_version(), FORMAT_VERSION))
-
 class PatchSet(StgitObject):
     def get_name(self):
         return self.__name
@@ -400,7 +328,7 @@ class PatchSet(StgitObject):
     def is_initialised(self):
         """Checks if series is already initialised
         """
-        return bool(config.get(format_version_key(self.get_name())))
+        return bool(config.get(self.format_version_key()))
 
 
 class Series(PatchSet):
@@ -422,7 +350,7 @@ class Series(PatchSet):
 
         # Update the branch to the latest format version if it is
         # initialized, but don't touch it if it isn't.
-        update_to_current_format_version(self.get_name(), self.__base_dir)
+        self.update_to_current_format_version()
 
         self.__refs_dir = os.path.join(self.__base_dir, 'refs', 'patches',
                                        self.get_name())
@@ -437,6 +365,78 @@ class Series(PatchSet):
         # trash directory
         self.__trash_dir = os.path.join(self._dir(), 'trash')
 
+    def format_version_key(self):
+        return 'branch.%s.stgitformatversion' % self.get_name()
+
+    def update_to_current_format_version(self):
+        """Update a potentially older StGIT directory structure to the
+        latest version. Note: This function should depend as little as
+        possible on external functions that may change during a format
+        version bump, since it must remain able to process older formats."""
+
+        branch_dir = os.path.join(self.__base_dir, 'patches', self.get_name())
+        def get_format_version():
+            """Return the integer format version number, or None if the
+            branch doesn't have any StGIT metadata at all, of any version."""
+            fv = config.get(self.format_version_key())
+            if fv:
+                # Great, there's an explicitly recorded format version
+                # number, which means that the branch is initialized and
+                # of that exact version.
+                return int(fv)
+            elif os.path.isdir(os.path.join(branch_dir, 'patches')):
+                # There's a .git/patches/<branch>/patches dirctory, which
+                # means this is an initialized version 1 branch.
+                return 1
+            elif os.path.isdir(branch_dir):
+                # There's a .git/patches/<branch> directory, which means
+                # this is an initialized version 0 branch.
+                return 0
+            else:
+                # The branch doesn't seem to be initialized at all.
+                return None
+        def set_format_version(v):
+            out.info('Upgraded branch %s to format version %d' % (self.get_name(), v))
+            config.set(self.format_version_key(), '%d' % v)
+        def mkdir(d):
+            if not os.path.isdir(d):
+                os.makedirs(d)
+        def rm(f):
+            if os.path.exists(f):
+                os.remove(f)
+
+        # Update 0 -> 1.
+        if get_format_version() == 0:
+            mkdir(os.path.join(branch_dir, 'trash'))
+            patch_dir = os.path.join(branch_dir, 'patches')
+            mkdir(patch_dir)
+            refs_dir = os.path.join(self.__base_dir, 'refs', 'patches', self.get_name())
+            mkdir(refs_dir)
+            for patch in (file(os.path.join(branch_dir, 'unapplied')).readlines()
+                          + file(os.path.join(branch_dir, 'applied')).readlines()):
+                patch = patch.strip()
+                os.rename(os.path.join(branch_dir, patch),
+                          os.path.join(patch_dir, patch))
+                Patch(patch, patch_dir, refs_dir).update_top_ref()
+            set_format_version(1)
+
+        # Update 1 -> 2.
+        if get_format_version() == 1:
+            desc_file = os.path.join(branch_dir, 'description')
+            if os.path.isfile(desc_file):
+                desc = read_string(desc_file)
+                if desc:
+                    config.set('branch.%s.description' % self.get_name(), desc)
+                rm(desc_file)
+            rm(os.path.join(branch_dir, 'current'))
+            rm(os.path.join(self.__base_dir, 'refs', 'bases', self.get_name()))
+            set_format_version(2)
+
+        # Make sure we're at the latest version.
+        if not get_format_version() in [None, FORMAT_VERSION]:
+            raise StackException('Branch %s is at format version %d, expected %d'
+                                 % (self.get_name(), get_format_version(), FORMAT_VERSION))
+
     def __patch_name_valid(self, name):
         """Raise an exception if the patch name is not valid.
         """
@@ -584,7 +584,7 @@ class Series(PatchSet):
         os.makedirs(self.__refs_dir)
         self._set_field('orig-base', git.get_head())
 
-        config.set(format_version_key(self.get_name()), str(FORMAT_VERSION))
+        config.set(self.format_version_key(), str(FORMAT_VERSION))
 
     def rename(self, to_name):
         """Renames a series
