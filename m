From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 8/9] Add a constructor to PatchSet.
Date: Sun, 17 Jun 2007 00:01:10 +0200
Message-ID: <20070616220110.14941.24888.stgit@gandelf.nowhere.earth>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgKv-0000H7-Uw
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbXFPWBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756395AbXFPWBG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:01:06 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45583 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189AbXFPWBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:01:03 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5DDC27491;
	Sun, 17 Jun 2007 00:01:01 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id B7D081F08A;
	Sun, 17 Jun 2007 00:01:10 +0200 (CEST)
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50318>

Move __base_dir up into PatchSet as well, and add an accessor.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 634588d..e33fe62 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -277,11 +277,26 @@ class Patch(StgitObject):
 FORMAT_VERSION = 2
 
 class PatchSet(StgitObject):
+    def __init__(self, name = None):
+        try:
+            if name:
+                self.set_name (name)
+            else:
+                self.set_name (git.get_head_file())
+            self.__base_dir = basedir.get()
+        except git.GitException, ex:
+            raise StackException, 'GIT tree not initialised: %s' % ex
+
+        self._set_dir(os.path.join(self.__base_dir, 'patches', self.get_name()))
+
     def get_name(self):
         return self.__name
     def set_name(self, name):
         self.__name = name
 
+    def _basedir(self):
+        return self.__base_dir
+
     def get_head(self):
         """Return the head of the branch
         """
@@ -337,22 +352,13 @@ class Series(PatchSet):
     def __init__(self, name = None):
         """Takes a series name as the parameter.
         """
-        try:
-            if name:
-                self.set_name (name)
-            else:
-                self.set_name (git.get_head_file())
-            self.__base_dir = basedir.get()
-        except git.GitException, ex:
-            raise StackException, 'GIT tree not initialised: %s' % ex
-
-        self._set_dir(os.path.join(self.__base_dir, 'patches', self.get_name()))
+        PatchSet.__init__(self, name)
 
         # Update the branch to the latest format version if it is
         # initialized, but don't touch it if it isn't.
         self.update_to_current_format_version()
 
-        self.__refs_dir = os.path.join(self.__base_dir, 'refs', 'patches',
+        self.__refs_dir = os.path.join(self._basedir(), 'refs', 'patches',
                                        self.get_name())
 
         self.__applied_file = os.path.join(self._dir(), 'applied')
@@ -374,7 +380,7 @@ class Series(PatchSet):
         possible on external functions that may change during a format
         version bump, since it must remain able to process older formats."""
 
-        branch_dir = os.path.join(self.__base_dir, 'patches', self.get_name())
+        branch_dir = os.path.join(self._basedir(), 'patches', self.get_name())
         def get_format_version():
             """Return the integer format version number, or None if the
             branch doesn't have any StGIT metadata at all, of any version."""
@@ -416,7 +422,7 @@ class Series(PatchSet):
             mkdir(os.path.join(branch_dir, 'trash'))
             patch_dir = os.path.join(branch_dir, 'patches')
             mkdir(patch_dir)
-            refs_dir = os.path.join(self.__base_dir, 'refs', 'patches', self.get_name())
+            refs_dir = os.path.join(self._basedir(), 'refs', 'patches', self.get_name())
             mkdir(refs_dir)
             for patch in (file(os.path.join(branch_dir, 'unapplied')).readlines()
                           + file(os.path.join(branch_dir, 'applied')).readlines()):
@@ -435,7 +441,7 @@ class Series(PatchSet):
                     config.set('branch.%s.description' % self.get_name(), desc)
                 rm(desc_file)
             rm(os.path.join(branch_dir, 'current'))
-            rm(os.path.join(self.__base_dir, 'refs', 'bases', self.get_name()))
+            rm(os.path.join(self._basedir(), 'refs', 'bases', self.get_name()))
             set_format_version(2)
 
         # Make sure we're at the latest version.
@@ -603,10 +609,10 @@ class Series(PatchSet):
         git.rename_branch(self.get_name(), to_name)
 
         if os.path.isdir(self._dir()):
-            rename(os.path.join(self.__base_dir, 'patches'),
+            rename(os.path.join(self._basedir(), 'patches'),
                    self.get_name(), to_stack.get_name())
         if os.path.exists(self.__refs_dir):
-            rename(os.path.join(self.__base_dir, 'refs', 'patches'),
+            rename(os.path.join(self._basedir(), 'refs', 'patches'),
                    self.get_name(), to_stack.get_name())
 
         # Rename the config section
