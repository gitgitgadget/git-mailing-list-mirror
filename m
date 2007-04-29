From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Mon, 30 Apr 2007 00:15:52 +0200
Message-ID: <20070429220832.5832.251.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 00:16:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiHgc-000173-Qu
	for gcvg-git@gmane.org; Mon, 30 Apr 2007 00:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161509AbXD2WP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 29 Apr 2007 18:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161510AbXD2WP4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 18:15:56 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:51853 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161509AbXD2WPy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2007 18:15:54 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:39459 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <kha@treskal.com>)
	id 1HiHgO-0008JP-3u; Mon, 30 Apr 2007 00:15:53 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HiHgO-0001ZX-6p; Mon, 30 Apr 2007 00:15:52 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HiHgO-0008JP-3u.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HiHgO-0008JP-3u 5dd57ced44986509790a1efe8c4ad229
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45844>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

It's silly to save the stack base in a ref when it can trivially be
computed from the bottommost applied patch, if any. (If there are no
applied patches, it's simply equal to HEAD.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

StGIT maintains too much metadata that can be inferred by asking git
the right questions. There are two downsides with this:

  * With more metadata, the design gets more complicated and harder to
    understand.

  * The duplicated metadata can get out of sync, and that situation
    has to be taken care of (otherwise, StGIT breaks). For example,
    there was code to set the base to HEAD whenever there were no
    patches applied and base !=3D HEAD. With this patch, the data is
    only stored in one place and can never get stale in the first
    place.

If there are no objections, I'll probably send more patches to
eliminate more redundant metadata.

 Documentation/tutorial.txt |    3 --
 stgit/commands/uncommit.py |    5 +---
 stgit/stack.py             |   53 ++++++------------------------------=
--------
 t/t1000-branch-create.sh   |   14 ------------
 t/t1200-push-modified.sh   |    7 +++---
 t/t1201-pull-trailing.sh   |    7 +++---
 t/t2200-rebase.sh          |    2 +-
 7 files changed, 17 insertions(+), 74 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 5899c38..2b8e4e7 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -387,9 +387,6 @@ Layout of the .git directory
     heads/
       master		- the master commit id
       ...
-    bases/
-      master		- the bottom id of the stack (to get a big diff)
-      ...
     tags/
       ...
     branches/
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 0ee1585..462846c 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -80,11 +80,9 @@ def func(parser, options, args):
     print 'Uncommitting %d patches...' % patch_nr,
     sys.stdout.flush()
=20
-    base_file =3D crt_series.get_base_file()
-
     for n in xrange(0, patch_nr):
         # retrieve the commit (only commits with a single parent are a=
llowed)
-        commit_id =3D read_string(base_file)
+        commit_id =3D crt_series.get_base()
         commit =3D git.Commit(commit_id)
         try:
             parent, =3D commit.get_parents()
@@ -107,6 +105,5 @@ def func(parser, options, args):
                              author_name =3D author_name,
                              author_email =3D author_email,
                              author_date =3D author_date)
-        write_string(base_file, parent)
=20
     print 'done'
diff --git a/stgit/stack.py b/stgit/stack.py
index b0a01dd..2477ac6 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -291,8 +291,6 @@ class Series(StgitObject):
         self._set_dir(os.path.join(self.__base_dir, 'patches', self.__=
name))
         self.__refs_dir =3D os.path.join(self.__base_dir, 'refs', 'pat=
ches',
                                        self.__name)
-        self.__base_file =3D os.path.join(self.__base_dir, 'refs', 'ba=
ses',
-                                        self.__name)
=20
         self.__applied_file =3D os.path.join(self._dir(), 'applied')
         self.__unapplied_file =3D os.path.join(self._dir(), 'unapplied=
')
@@ -378,12 +376,14 @@ class Series(StgitObject):
         f.close()
         return names
=20
-    def get_base_file(self):
-        self.__begin_stack_check()
-        return self.__base_file
-
     def get_base(self):
-        return read_string(self.get_base_file())
+        # Return the parent of the bottommost patch, if there is one.
+        if os.path.isfile(self.__applied_file):
+            bottommost =3D file(self.__applied_file).readline().strip(=
)
+            if bottommost:
+                return self.get_patch(bottommost).get_bottom()
+        # No bottommost patch, so just return HEAD
+        return git.get_head()
=20
     def get_head(self):
         """Return the head of the branch
@@ -482,22 +482,6 @@ class Series(StgitObject):
         otherwise."""
         return self.patch_applied(name) or self.patch_unapplied(name)
=20
-    def __begin_stack_check(self):
-        """Save the current HEAD into .git/refs/heads/base if the stac=
k
-        is empty
-        """
-        if len(self.get_applied()) =3D=3D 0:
-            head =3D git.get_head()
-            write_string(self.__base_file, head)
-
-    def __end_stack_check(self):
-        """Remove .git/refs/heads/base if the stack is empty.
-        This warning should never happen
-        """
-        if len(self.get_applied()) =3D=3D 0 \
-           and read_string(self.__base_file) !=3D git.get_head():
-            print 'Warning: stack empty but the HEAD and base are diff=
erent'
-
     def head_top_equal(self):
         """Return true if the head and the top are the same
         """
@@ -519,8 +503,6 @@ class Series(StgitObject):
             raise StackException, self.__patch_dir + ' already exists'
         if os.path.exists(self.__refs_dir):
             raise StackException, self.__refs_dir + ' already exists'
-        if os.path.exists(self.__base_file):
-            raise StackException, self.__base_file + ' already exists'
=20
         if (create_at!=3DFalse):
             git.create_branch(self.__name, create_at)
@@ -528,15 +510,12 @@ class Series(StgitObject):
         os.makedirs(self.__patch_dir)
=20
         self.set_parent(parent_remote, parent_branch)
-       =20
-        create_dirs(os.path.join(self.__base_dir, 'refs', 'bases'))
=20
         self.create_empty_field('applied')
         self.create_empty_field('unapplied')
         self.create_empty_field('description')
         os.makedirs(os.path.join(self._dir(), 'patches'))
         os.makedirs(self.__refs_dir)
-        self.__begin_stack_check()
         self._set_field('orig-base', git.get_head())
=20
     def convert(self):
@@ -582,17 +561,12 @@ class Series(StgitObject):
=20
         if to_stack.is_initialised():
             raise StackException, '"%s" already exists' % to_stack.get=
_branch()
-        if os.path.exists(to_stack.__base_file):
-            os.remove(to_stack.__base_file)
=20
         git.rename_branch(self.__name, to_name)
=20
         if os.path.isdir(self._dir()):
             rename(os.path.join(self.__base_dir, 'patches'),
                    self.__name, to_stack.__name)
-        if os.path.exists(self.__base_file):
-            rename(os.path.join(self.__base_dir, 'refs', 'bases'),
-                   self.__name, to_stack.__name)
         if os.path.exists(self.__refs_dir):
             rename(os.path.join(self.__base_dir, 'refs', 'patches'),
                    self.__name, to_stack.__name)
@@ -698,10 +672,6 @@ class Series(StgitObject):
             except OSError:
                 print 'Refs directory %s is not empty.' % self.__refs_=
dir
=20
-        if os.path.exists(self.__base_file):
-            remove_file_and_dirs(
-                os.path.join(self.__base_dir, 'refs', 'bases'), self._=
_name)
-
         # Cleanup parent informations
         # FIXME: should one day make use of git-config --section-remov=
e,
         # scheduled for 1.5.1
@@ -824,8 +794,6 @@ class Series(StgitObject):
=20
         head =3D git.get_head()
=20
-        self.__begin_stack_check()
-
         patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
         patch.create()
=20
@@ -893,8 +861,6 @@ class Series(StgitObject):
         if self.patch_hidden(name):
             self.unhide_patch(name)
=20
-        self.__begin_stack_check()
-
     def forward_patches(self, names):
         """Try to fast-forward an array of patches.
=20
@@ -902,7 +868,6 @@ class Series(StgitObject):
         stack. Apply the rest with push_patch
         """
         unapplied =3D self.get_unapplied()
-        self.__begin_stack_check()
=20
         forwarded =3D 0
         top =3D git.get_head()
@@ -1001,8 +966,6 @@ class Series(StgitObject):
         unapplied =3D self.get_unapplied()
         assert(name in unapplied)
=20
-        self.__begin_stack_check()
-
         patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
=20
         head =3D git.get_head()
@@ -1140,8 +1103,6 @@ class Series(StgitObject):
         else:
             self.__set_current(applied[-1])
=20
-        self.__end_stack_check()
-
     def empty_patch(self, name):
         """Returns True if the patch is empty
         """
diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index f0c2367..58209e7 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -39,20 +39,6 @@ test_expect_success \
 '
=20
 test_expect_failure \
-    'Try to create an stgit branch with a spurious refs/bases/ entry' =
\
-    'find .git -name foo | xargs rm -rf &&
-     touch .git/refs/bases/foo &&
-     stg branch -c foo
-'
-
-test_expect_success \
-    'Check no part of the branch was created' \
-    'test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/bas=
es/foo" &&
-     ( grep foo .git/HEAD; test $? =3D 1 )
-'
-
-
-test_expect_failure \
     'Try to create an stgit branch with an existing git branch by that=
 name' \
     'find .git -name foo | xargs rm -rf &&
      cp .git/refs/heads/master .git/refs/heads/foo &&
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index 7847a38..6769667 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -30,11 +30,12 @@ test_expect_success \
=20
 test_expect_success \
     'Port those patches to orig tree' \
-    "(cd foo &&
-      GIT_DIR=3D../bar/.git git-format-patch --stdout bases/master..HE=
AD |
+    '(cd foo &&
+      GIT_DIR=3D../bar/.git git-format-patch --stdout \
+          $(cd ../bar && stg id base@master)..HEAD |
       git-am -3 -k
      )
-"
+    '
=20
 test_expect_success \
     'Pull to sync with parent, preparing for the problem' \
diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
index 42c6619..46d9f82 100755
--- a/t/t1201-pull-trailing.sh
+++ b/t/t1201-pull-trailing.sh
@@ -28,11 +28,12 @@ test_expect_success \
=20
 test_expect_success \
     'Port those patches to orig tree' \
-    "(cd foo &&
-      GIT_DIR=3D../bar/.git git-format-patch --stdout bases/master..HE=
AD |
+    '(cd foo &&
+      GIT_DIR=3D../bar/.git git-format-patch --stdout \
+          $(cd ../bar && stg id base@master)..HEAD |
       git-am -3 -k
      )
-"
+    '
=20
 test_expect_success \
     'Pull those patches applied upstream, without pushing' \
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index e2d9d9a..52462dd 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -27,7 +27,7 @@ test_expect_success \
 	'Rebase to previous commit' \
 	'
 	stg rebase master~1 &&
-	test `git rev-parse bases/stack` =3D `git rev-parse master~1`
+	test `stg id base@stack` =3D `git rev-parse master~1`
 	'
=20
 test_done
