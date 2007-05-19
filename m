From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/5] Upgrade old StGIT branches to new-format metadata
Date: Sat, 19 May 2007 02:10:02 +0200
Message-ID: <20070519001001.4906.11625.stgit@yoghurt>
References: <20070519000451.4906.87089.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:10:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCWU-0002HT-C7
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbXESAKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 20:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbXESAKJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:10:09 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51697 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754653AbXESAKH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 20:10:07 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:54511 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HpCWL-0006hf-3V; Sat, 19 May 2007 02:10:05 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HpCWI-0001KO-3T; Sat, 19 May 2007 02:10:02 +0200
In-Reply-To: <20070519000451.4906.87089.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HpCWL-0006hf-3V.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HpCWL-0006hf-3V 76e6c3741cc7e7183648a51d40eaa35c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47688>

There used to be a "stg branch --convert" command that switched
between "old" and "new" format metadata. But my recent metadata
cleanup patches introduced a "new new" format, and more are hopefully
on the way, so it was time to start versioning the metadata format
explicitly in order to avoid future headaches.

This patch removes the "stg branch --convert" command, and makes StGIT
automatically upgrade older formats to the latest format. It stores
the format (as an integer) in the config file. The current metadata
format version number is 2 (the "old" format is 0, and the "new"
format is 1).

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 Documentation/stg-branch.txt |    4 -
 stgit/commands/branch.py     |   11 ---
 stgit/stack.py               |  153 ++++++++++++++++++++++++----------=
--------
 3 files changed, 86 insertions(+), 82 deletions(-)

diff --git a/Documentation/stg-branch.txt b/Documentation/stg-branch.tx=
t
index 25c9c19..25ca951 100644
--- a/Documentation/stg-branch.txt
+++ b/Documentation/stg-branch.txt
@@ -20,7 +20,6 @@ SYNOPSIS
 'stg' branch --protect [<branch>]
 'stg' branch --unprotect [<branch>]
 'stg' branch --delete [--force] <branch>
-'stg' branch --convert
=20
 DESCRIPTION
 -----------
@@ -91,9 +90,6 @@ the "master" branch if it exists.
 Branch "master" is treated specially (see bug #8732), in that only the
 StGIT metadata are removed, the GIT branch itself is not destroyed.
=20
-'stg' branch --convert::
-	Switch current stack between old and new format.
-
 OPTIONS
 -------
=20
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index b043c69..5e7b0df 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -45,9 +45,6 @@ options =3D [make_option('-c', '--create',
            make_option('--clone',
                        help =3D 'clone the contents of the current bra=
nch',
                        action =3D 'store_true'),
-           make_option('--convert',
-                       help =3D 'switch between old and new format bra=
nches',
-                       action =3D 'store_true'),
            make_option('--delete',
                        help =3D 'delete an existing development branch=
',
                        action =3D 'store_true'),
@@ -186,14 +183,6 @@ def func(parser, options, args):
=20
         return
=20
-    elif options.convert:
-
-        if len(args) !=3D 0:
-            parser.error('incorrect number of arguments')
-
-        crt_series.convert()
-        return
-
     elif options.delete:
=20
         if len(args) !=3D 1:
diff --git a/stgit/stack.py b/stgit/stack.py
index d9c4b99..223f3ee 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -273,6 +273,79 @@ class Patch(StgitObject):
         self._set_field('log', value)
         self.__update_log_ref(value)
=20
+# The current StGIT metadata format version.
+FORMAT_VERSION =3D 2
+
+def format_version_key(branch):
+    return 'branch.%s.stgitformatversion' % branch
+
+def update_to_current_format_version(branch, git_dir):
+    """Update a potentially older StGIT directory structure to the
+    latest version. Note: This function should depend as little as
+    possible on external functions that may change during a format
+    version bump, since it must remain able to process older formats."=
""
+
+    branch_dir =3D os.path.join(git_dir, 'patches', branch)
+    def get_format_version():
+        """Return the integer format version number, or None if the
+        branch doesn't have any StGIT metadata at all, of any version.=
"""
+        fv =3D config.get(format_version_key(branch))
+        if fv:
+            # Great, there's an explicitly recorded format version
+            # number, which means that the branch is initialized and
+            # of that exact version.
+            return int(fv)
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
+        config.set(format_version_key(branch), '%d' % v)
+    def mkdir(d):
+        if not os.path.isdir(d):
+            os.makedirs(d)
+    def rm(f):
+        if os.path.exists(f):
+            os.remove(f)
+
+    # Update 0 -> 1.
+    if get_format_version() =3D=3D 0:
+        mkdir(os.path.join(branch_dir, 'trash'))
+        patch_dir =3D os.path.join(branch_dir, 'patches')
+        mkdir(patch_dir)
+        refs_dir =3D os.path.join(git_dir, 'refs', 'patches', branch)
+        mkdir(refs_dir)
+        for patch in (file(os.path.join(branch_dir, 'unapplied')).read=
lines()
+                      + file(os.path.join(branch_dir, 'applied')).read=
lines()):
+            patch =3D patch.strip()
+            os.rename(os.path.join(branch_dir, patch),
+                      os.path.join(patch_dir, patch))
+            Patch(patch, patch_dir, refs_dir).update_top_ref()
+        set_format_version(1)
+
+    # Update 1 -> 2.
+    if get_format_version() =3D=3D 1:
+        desc_file =3D os.path.join(branch_dir, 'description')
+        if os.path.isfile(desc_file):
+            desc =3D read_string(desc_file)
+            if desc:
+                config.set('branch.%s.description' % branch, desc)
+            rm(desc_file)
+        rm(os.path.join(branch_dir, 'current'))
+        rm(os.path.join(git_dir, 'refs', 'bases', branch))
+        set_format_version(2)
+
+    # Make sure we're at the latest version.
+    if not get_format_version() in [None, FORMAT_VERSION]:
+        raise StackException('Branch %s is at format version %d, expec=
ted %d'
+                             % (branch, get_format_version(), FORMAT_V=
ERSION))
=20
 class Series(StgitObject):
     """Class including the operations on series
@@ -290,6 +363,11 @@ class Series(StgitObject):
             raise StackException, 'GIT tree not initialised: %s' % ex
=20
         self._set_dir(os.path.join(self.__base_dir, 'patches', self.__=
name))
+
+        # Update the branch to the latest format version if it is
+        # initialized, but don't touch it if it isn't.
+        update_to_current_format_version(self.__name, self.__base_dir)
+
         self.__refs_dir =3D os.path.join(self.__base_dir, 'refs', 'pat=
ches',
                                        self.__name)
=20
@@ -299,19 +377,9 @@ class Series(StgitObject):
=20
         # where this series keeps its patches
         self.__patch_dir =3D os.path.join(self._dir(), 'patches')
-        if not os.path.isdir(self.__patch_dir):
-            self.__patch_dir =3D self._dir()
-
-        # if no __refs_dir, create and populate it (upgrade old reposi=
tories)
-        if self.is_initialised() and not os.path.isdir(self.__refs_dir=
):
-            os.makedirs(self.__refs_dir)
-            for patch in self.get_applied() + self.get_unapplied():
-                self.get_patch(patch).update_top_ref()
=20
         # trash directory
         self.__trash_dir =3D os.path.join(self._dir(), 'trash')
-        if self.is_initialised() and not os.path.isdir(self.__trash_di=
r):
-            os.makedirs(self.__trash_dir)
=20
     def __patch_name_valid(self, name):
         """Raise an exception if the patch name is not valid.
@@ -410,19 +478,13 @@ class Series(StgitObject):
         return 'branch.%s.description' % self.get_branch()
=20
     def get_description(self):
-        # Fall back to the .git/patches/<branch>/description file if
-        # the config variable is unset.
-        return (config.get(self.__branch_descr())
-                or self._get_field('description') or '')
+        return config.get(self.__branch_descr())
=20
     def set_description(self, line):
         if line:
             config.set(self.__branch_descr(), line)
         else:
             config.unset(self.__branch_descr())
-        # Delete the old .git/patches/<branch>/description file if it
-        # exists.
-        self._set_field('description', None)
=20
     def get_parent_remote(self):
         value =3D config.get('branch.%s.remote' % self.__name)
@@ -503,15 +565,16 @@ class Series(StgitObject):
     def is_initialised(self):
         """Checks if series is already initialised
         """
-        return os.path.isdir(self.__patch_dir)
+        return bool(config.get(format_version_key(self.get_branch())))
=20
     def init(self, create_at=3DFalse, parent_remote=3DNone, parent_bra=
nch=3DNone):
         """Initialises the stgit series
         """
-        if os.path.exists(self.__patch_dir):
-            raise StackException, self.__patch_dir + ' already exists'
-        if os.path.exists(self.__refs_dir):
-            raise StackException, self.__refs_dir + ' already exists'
+        if self.is_initialised():
+            raise StackException, '%s already initialized' % self.get_=
branch()
+        for d in [self._dir(), self.__refs_dir]:
+            if os.path.exists(d):
+                raise StackException, '%s already exists' % d
=20
         if (create_at!=3DFalse):
             git.create_branch(self.__name, create_at)
@@ -522,45 +585,10 @@ class Series(StgitObject):
=20
         self.create_empty_field('applied')
         self.create_empty_field('unapplied')
-        os.makedirs(os.path.join(self._dir(), 'patches'))
         os.makedirs(self.__refs_dir)
         self._set_field('orig-base', git.get_head())
=20
-    def convert(self):
-        """Either convert to use a separate patch directory, or
-        unconvert to place the patches in the same directory with
-        series control files
-        """
-        if self.__patch_dir =3D=3D self._dir():
-            print 'Converting old-style to new-style...',
-            sys.stdout.flush()
-
-            self.__patch_dir =3D os.path.join(self._dir(), 'patches')
-            os.makedirs(self.__patch_dir)
-
-            for p in self.get_applied() + self.get_unapplied():
-                src =3D os.path.join(self._dir(), p)
-                dest =3D os.path.join(self.__patch_dir, p)
-                os.rename(src, dest)
-
-            print 'done'
-
-        else:
-            print 'Converting new-style to old-style...',
-            sys.stdout.flush()
-
-            for p in self.get_applied() + self.get_unapplied():
-                src =3D os.path.join(self.__patch_dir, p)
-                dest =3D os.path.join(self._dir(), p)
-                os.rename(src, dest)
-
-            if not os.listdir(self.__patch_dir):
-                os.rmdir(self.__patch_dir)
-                print 'done'
-            else:
-                print 'Patch directory %s is not empty.' % self.__patc=
h_dir
-
-            self.__patch_dir =3D self._dir()
+        config.set(format_version_key(self.get_branch()), str(FORMAT_V=
ERSION))
=20
     def rename(self, to_name):
         """Renames a series
@@ -666,15 +694,6 @@ class Series(StgitObject):
             if os.path.exists(self._dir()+'/orig-base'):
                 os.remove(self._dir()+'/orig-base')
=20
-            # Remove obsolete files that StGIT no longer uses, but
-            # that might still be around if this is an old repository.
-            for obsolete in ([os.path.join(self._dir(), fn)
-                              for fn in ['current', 'description']]
-                             + [os.path.join(self.__base_dir,
-                                             'refs', 'bases', self.__n=
ame)]):
-                if os.path.exists(obsolete):
-                    os.remove(obsolete)
-
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
             else:
