From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 03/10] Upgrade older stacks to newest version
Date: Sun, 25 Nov 2007 21:51:13 +0100
Message-ID: <20071125205112.7823.54437.stgit@yoghurt>
References: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:52:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOSO-0003hQ-KP
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596AbXKYUvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756591AbXKYUvU
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4118 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756462AbXKYUvT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:19 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwORd-0007Zp-00; Sun, 25 Nov 2007 20:51:13 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65995>

This is of course needed by the new infrastructure as well. So break
it out into its own file, where it can be used by both new and old
infrastructure. This has the added benefit of making it easy to see
that the upgrade code doesn't depend on anything it shouldn't.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py          |    7 +++
 stgit/lib/stack.py        |    3 +
 stgit/lib/stackupgrade.py |   96 +++++++++++++++++++++++++++++++++++++=
++++++
 stgit/stack.py            |  100 +++----------------------------------=
--------
 4 files changed, 112 insertions(+), 94 deletions(-)
 create mode 100644 stgit/lib/stackupgrade.py


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 120ea35..c4011f9 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -160,6 +160,13 @@ class Refs(object):
         if self.__refs =3D=3D None:
             self.__cache_refs()
         return self.__repository.get_commit(self.__refs[ref])
+    def exists(self, ref):
+        try:
+            self.get(ref)
+        except KeyError:
+            return False
+        else:
+            return True
     def set(self, ref, commit, msg):
         if self.__refs =3D=3D None:
             self.__cache_refs()
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 5a34592..8fc8b08 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -1,6 +1,6 @@
 import os.path
 from stgit import exception, utils
-from stgit.lib import git
+from stgit.lib import git, stackupgrade
=20
 class Patch(object):
     def __init__(self, stack, name):
@@ -128,6 +128,7 @@ class Stack(object):
             raise exception.StgException('%s: no such branch' % name)
         self.__patchorder =3D PatchOrder(self)
         self.__patches =3D Patches(self)
+        stackupgrade.update_to_current_format_version(repository, name=
)
     name =3D property(lambda self: self.__name)
     repository =3D property(lambda self: self.__repository)
     patchorder =3D property(lambda self: self.__patchorder)
diff --git a/stgit/lib/stackupgrade.py b/stgit/lib/stackupgrade.py
new file mode 100644
index 0000000..00bfdf0
--- /dev/null
+++ b/stgit/lib/stackupgrade.py
@@ -0,0 +1,96 @@
+import os.path
+from stgit import utils
+from stgit.out import out
+from stgit.config import config
+
+# The current StGit metadata format version.
+FORMAT_VERSION =3D 2
+
+def format_version_key(branch):
+    return 'branch.%s.stgit.stackformatversion' % branch
+
+def update_to_current_format_version(repository, branch):
+    """Update a potentially older StGit directory structure to the lat=
est
+    version. Note: This function should depend as little as possible
+    on external functions that may change during a format version
+    bump, since it must remain able to process older formats."""
+
+    branch_dir =3D os.path.join(repository.directory, 'patches', branc=
h)
+    key =3D format_version_key(branch)
+    old_key =3D 'branch.%s.stgitformatversion' % branch
+    def get_format_version():
+        """Return the integer format version number, or None if the
+        branch doesn't have any StGit metadata at all, of any version.=
"""
+        fv =3D config.get(key)
+        ofv =3D config.get(old_key)
+        if fv:
+            # Great, there's an explicitly recorded format version
+            # number, which means that the branch is initialized and
+            # of that exact version.
+            return int(fv)
+        elif ofv:
+            # Old name for the version info: upgrade it.
+            config.set(key, ofv)
+            config.unset(old_key)
+            return int(ofv)
+        elif os.path.isdir(os.path.join(branch_dir, 'patches')):
+            # There's a .git/patches/<branch>/patches dirctory, which
+            # means this is an initialized version 1 branch.
+            return 1
+        elif os.path.isdir(branch_dir):
+            # There's a .git/patches/<branch> directory, which means
+            # this is an initialized version 0 branch.
+            return 0
+        else:
+            # The branch doesn't seem to be initialized at all.
+            return None
+    def set_format_version(v):
+        out.info('Upgraded branch %s to format version %d' % (branch, =
v))
+        config.set(key, '%d' % v)
+    def mkdir(d):
+        if not os.path.isdir(d):
+            os.makedirs(d)
+    def rm(f):
+        if os.path.exists(f):
+            os.remove(f)
+    def rm_ref(ref):
+        if repository.refs.exists(ref):
+            repository.refs.delete(ref)
+
+    # Update 0 -> 1.
+    if get_format_version() =3D=3D 0:
+        mkdir(os.path.join(branch_dir, 'trash'))
+        patch_dir =3D os.path.join(branch_dir, 'patches')
+        mkdir(patch_dir)
+        refs_base =3D 'refs/patches/%s' % branch
+        for patch in (file(os.path.join(branch_dir, 'unapplied')).read=
lines()
+                      + file(os.path.join(branch_dir, 'applied')).read=
lines()):
+            patch =3D patch.strip()
+            os.rename(os.path.join(branch_dir, patch),
+                      os.path.join(patch_dir, patch))
+            topfield =3D os.path.join(patch_dir, patch, 'top')
+            if os.path.isfile(topfield):
+                top =3D utils.read_string(topfield, False)
+            else:
+                top =3D None
+            if top:
+                repository.refs.set(refs_base + '/' + patch,
+                                    repository.get_commit(top), 'StGit=
 upgrade')
+        set_format_version(1)
+
+    # Update 1 -> 2.
+    if get_format_version() =3D=3D 1:
+        desc_file =3D os.path.join(branch_dir, 'description')
+        if os.path.isfile(desc_file):
+            desc =3D utils.read_string(desc_file)
+            if desc:
+                config.set('branch.%s.description' % branch, desc)
+            rm(desc_file)
+        rm(os.path.join(branch_dir, 'current'))
+        rm_ref('refs/bases/%s' % branch)
+        set_format_version(2)
+
+    # Make sure we're at the latest version.
+    if not get_format_version() in [None, FORMAT_VERSION]:
+        raise StackException('Branch %s is at format version %d, expec=
ted %d'
+                             % (branch, get_format_version(), FORMAT_V=
ERSION))
diff --git a/stgit/stack.py b/stgit/stack.py
index f93d842..29e92c9 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -28,7 +28,7 @@ from stgit.run import *
 from stgit import git, basedir, templates
 from stgit.config import config
 from shutil import copyfile
-
+from stgit.lib import git as libgit, stackupgrade
=20
 # stack exception class
 class StackException(StgException):
@@ -279,9 +279,6 @@ class Patch(StgitObject):
         self._set_field('log', value)
         self.__update_log_ref(value)
=20
-# The current StGIT metadata format version.
-FORMAT_VERSION =3D 2
-
 class PatchSet(StgitObject):
     def __init__(self, name =3D None):
         try:
@@ -349,7 +346,8 @@ class PatchSet(StgitObject):
     def is_initialised(self):
         """Checks if series is already initialised
         """
-        return bool(config.get(self.format_version_key()))
+        return config.get(stackupgrade.format_version_key(self.get_nam=
e())
+                          ) !=3D None
=20
=20
 def shortlog(patches):
@@ -368,7 +366,8 @@ class Series(PatchSet):
=20
         # Update the branch to the latest format version if it is
         # initialized, but don't touch it if it isn't.
-        self.update_to_current_format_version()
+        stackupgrade.update_to_current_format_version(
+            libgit.Repository.default(), self.get_name())
=20
         self.__refs_base =3D 'refs/patches/%s' % self.get_name()
=20
@@ -382,92 +381,6 @@ class Series(PatchSet):
         # trash directory
         self.__trash_dir =3D os.path.join(self._dir(), 'trash')
=20
-    def format_version_key(self):
-        return 'branch.%s.stgit.stackformatversion' % self.get_name()
-
-    def update_to_current_format_version(self):
-        """Update a potentially older StGIT directory structure to the
-        latest version. Note: This function should depend as little as
-        possible on external functions that may change during a format
-        version bump, since it must remain able to process older forma=
ts."""
-
-        branch_dir =3D os.path.join(self._basedir(), 'patches', self.g=
et_name())
-        def get_format_version():
-            """Return the integer format version number, or None if th=
e
-            branch doesn't have any StGIT metadata at all, of any vers=
ion."""
-            fv =3D config.get(self.format_version_key())
-            ofv =3D config.get('branch.%s.stgitformatversion' % self.g=
et_name())
-            if fv:
-                # Great, there's an explicitly recorded format version
-                # number, which means that the branch is initialized a=
nd
-                # of that exact version.
-                return int(fv)
-            elif ofv:
-                # Old name for the version info, upgrade it
-                config.set(self.format_version_key(), ofv)
-                config.unset('branch.%s.stgitformatversion' % self.get=
_name())
-                return int(ofv)
-            elif os.path.isdir(os.path.join(branch_dir, 'patches')):
-                # There's a .git/patches/<branch>/patches dirctory, wh=
ich
-                # means this is an initialized version 1 branch.
-                return 1
-            elif os.path.isdir(branch_dir):
-                # There's a .git/patches/<branch> directory, which mea=
ns
-                # this is an initialized version 0 branch.
-                return 0
-            else:
-                # The branch doesn't seem to be initialized at all.
-                return None
-        def set_format_version(v):
-            out.info('Upgraded branch %s to format version %d' % (self=
=2Eget_name(), v))
-            config.set(self.format_version_key(), '%d' % v)
-        def mkdir(d):
-            if not os.path.isdir(d):
-                os.makedirs(d)
-        def rm(f):
-            if os.path.exists(f):
-                os.remove(f)
-        def rm_ref(ref):
-            if git.ref_exists(ref):
-                git.delete_ref(ref)
-
-        # Update 0 -> 1.
-        if get_format_version() =3D=3D 0:
-            mkdir(os.path.join(branch_dir, 'trash'))
-            patch_dir =3D os.path.join(branch_dir, 'patches')
-            mkdir(patch_dir)
-            refs_base =3D 'refs/patches/%s' % self.get_name()
-            for patch in (file(os.path.join(branch_dir, 'unapplied')).=
readlines()
-                          + file(os.path.join(branch_dir, 'applied')).=
readlines()):
-                patch =3D patch.strip()
-                os.rename(os.path.join(branch_dir, patch),
-                          os.path.join(patch_dir, patch))
-                topfield =3D os.path.join(patch_dir, patch, 'top')
-                if os.path.isfile(topfield):
-                    top =3D read_string(topfield, False)
-                else:
-                    top =3D None
-                if top:
-                    git.set_ref(refs_base + '/' + patch, top)
-            set_format_version(1)
-
-        # Update 1 -> 2.
-        if get_format_version() =3D=3D 1:
-            desc_file =3D os.path.join(branch_dir, 'description')
-            if os.path.isfile(desc_file):
-                desc =3D read_string(desc_file)
-                if desc:
-                    config.set('branch.%s.description' % self.get_name=
(), desc)
-                rm(desc_file)
-            rm(os.path.join(branch_dir, 'current'))
-            rm_ref('refs/bases/%s' % self.get_name())
-            set_format_version(2)
-
-        # Make sure we're at the latest version.
-        if not get_format_version() in [None, FORMAT_VERSION]:
-            raise StackException('Branch %s is at format version %d, e=
xpected %d'
-                                 % (self.get_name(), get_format_versio=
n(), FORMAT_VERSION))
-
     def __patch_name_valid(self, name):
         """Raise an exception if the patch name is not valid.
         """
@@ -620,7 +533,8 @@ class Series(PatchSet):
         self.create_empty_field('applied')
         self.create_empty_field('unapplied')
=20
-        config.set(self.format_version_key(), str(FORMAT_VERSION))
+        config.set(stackupgrade.format_version_key(self.get_name()),
+                   str(stackupgrade.FORMAT_VERSION))
=20
     def rename(self, to_name):
         """Renames a series
