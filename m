From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Fri, 10 Aug 2007 05:23:18 +0200
Message-ID: <20070810032318.19791.70483.stgit@yoghurt>
References: <20070810031949.19791.54562.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 05:23:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJL62-0000zv-AS
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 05:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbXHJDX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 23:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbXHJDX2
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 23:23:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2808 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbXHJDXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 23:23:21 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IJL5r-0005Qi-00; Fri, 10 Aug 2007 04:23:19 +0100
In-Reply-To: <20070810031949.19791.54562.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55502>

Messing with files manually doesn't work if the refs are packed. The
officially preferred way is to use git-update-ref, git-show-ref,
et.al. So do that.

As a consequence of this, we have some small behavior changes:

  * We used to not leave empty directories behind in the refs tree.
    But now that's all in the hands of git-update-ref, which does
    leave them behind. Tests that assumed the old behavior have been
    fixed.

  * We (that is, git-show-ref) no longer distinguish between a ref
    that doesn't exist and a ref that contains garbage. So the tests
    that assumed we'd fail when encountering a spurious ref with
    garbage in it have had to go through attitude readjustment.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/branch.py   |    5 +--
 stgit/commands/common.py   |    4 +-
 stgit/git.py               |   79 ++++++++++++++++++++++++++----------=
--------
 stgit/stack.py             |   70 +++++++++++++++++++++---------------=
---
 t/t0001-subdir-branches.sh |    7 ++--
 t/t1000-branch-create.sh   |   30 +----------------
 t/t1001-branch-rename.sh   |    2 +
 7 files changed, 91 insertions(+), 106 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 2fb5f59..75a9046 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -208,10 +208,7 @@ def func(parser, options, args):
         if len(args) !=3D 0:
             parser.error('incorrect number of arguments')
=20
-        branches =3D []
-        basepath =3D os.path.join(basedir.get(), 'refs', 'heads')
-        for path, files, dirs in walk_tree(basepath):
-            branches +=3D [os.path.join(path, f) for f in files]
+        branches =3D git.get_heads()
         branches.sort()
=20
         if branches:
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 14dbf67..dddee85 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -42,9 +42,7 @@ def parse_rev(rev):
     """Parse a revision specification into its
     patchname@branchname//patch_id parts. If no branch name has a slas=
h
     in it, also accept / instead of //."""
-    files, dirs =3D list_files_and_dirs(os.path.join(basedir.get(),
-                                                   'refs', 'heads'))
-    if len(dirs) !=3D 0:
+    if '/' in ''.join(git.get_heads()):
         # We have branch names with / in them.
         branch_chars =3D r'[^@]'
         patch_id_mark =3D r'//'
diff --git a/stgit/git.py b/stgit/git.py
index 72bf889..832a2dc 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -270,6 +270,13 @@ def local_changes(verbose =3D True):
     """
     return len(tree_status(verbose =3D verbose)) !=3D 0
=20
+def get_heads():
+    heads =3D []
+    for line in _output_lines(['git-show-ref', '--heads']):
+        m =3D re.match('^[0-9a-f]{40} refs/heads/(.+)$', line)
+        heads.append(m.group(1))
+    return heads
+
 # HEAD value cached
 __head =3D None
=20
@@ -294,14 +301,16 @@ def set_head_file(ref):
     # head cache flushing is needed since we might have a different va=
lue
     # in the new head
     __clear_head_cache()
-    if __run('git-symbolic-ref HEAD',
-             [os.path.join('refs', 'heads', ref)]) !=3D 0:
+    if __run('git-symbolic-ref HEAD', ['refs/heads/%s' % ref]) !=3D 0:
         raise GitException, 'Could not set head to "%s"' % ref
=20
+def set_ref(ref, val):
+    """Point ref at a new commit object."""
+    if __run('git-update-ref', [ref, val]) !=3D 0:
+        raise GitException, 'Could not update %s to "%s".' % (ref, val=
)
+
 def set_branch(branch, val):
-    """Point branch at a new commit object."""
-    if __run('git-update-ref', [branch, val]) !=3D 0:
-        raise GitException, 'Could not update %s to "%s".' % (branch, =
val)
+    set_ref('refs/heads/%s' % branch, val)
=20
 def __set_head(val):
     """Sets the HEAD value
@@ -309,7 +318,7 @@ def __set_head(val):
     global __head
=20
     if not __head or __head !=3D val:
-        set_branch('HEAD', val)
+        set_ref('HEAD', val)
         __head =3D val
=20
     # only allow SHA1 hashes
@@ -335,16 +344,15 @@ def rev_parse(git_id):
     except GitException:
         raise GitException, 'Unknown revision: %s' % git_id
=20
+def ref_exists(ref):
+    try:
+        rev_parse(ref)
+        return True
+    except GitException:
+        return False
+
 def branch_exists(branch):
-    """Existence check for the named branch
-    """
-    branch =3D os.path.join('refs', 'heads', branch)
-    for line in _output_lines('git-rev-parse --symbolic --all 2>&1'):
-        if line.strip() =3D=3D branch:
-            return True
-        if re.compile('[ |/]'+branch+' ').search(line):
-            raise GitException, 'Bogus branch: %s' % line
-    return False
+    return ref_exists('refs/heads/%s' % branch)
=20
 def create_branch(new_branch, tree_id =3D None):
     """Create a new branch in the git repository
@@ -371,8 +379,7 @@ def switch_branch(new_branch):
     if not branch_exists(new_branch):
         raise GitException, 'Branch "%s" does not exist' % new_branch
=20
-    tree_id =3D rev_parse(os.path.join('refs', 'heads', new_branch)
-                        + '^{commit}')
+    tree_id =3D rev_parse('refs/heads/%s^{commit}' % new_branch)
     if tree_id !=3D get_head():
         refresh_index()
         if __run('git-read-tree -u -m', [get_head(), tree_id]) !=3D 0:
@@ -383,27 +390,33 @@ def switch_branch(new_branch):
     if os.path.isfile(os.path.join(basedir.get(), 'MERGE_HEAD')):
         os.remove(os.path.join(basedir.get(), 'MERGE_HEAD'))
=20
+def delete_ref(ref):
+    if not ref_exists(ref):
+        raise GitException, '%s does not exist' % ref
+    sha1 =3D _output_one_line(['git-show-ref', '-s', ref])
+    if __run('git-update-ref -d %s %s' % (ref, sha1)):
+        raise GitException, 'Failed to delete ref %s' % ref
+
 def delete_branch(name):
-    """Delete a git branch
-    """
-    if not branch_exists(name):
-        raise GitException, 'Branch "%s" does not exist' % name
-    remove_file_and_dirs(os.path.join(basedir.get(), 'refs', 'heads'),
-                         name)
+    delete_ref('refs/heads/%s' % name)
=20
-def rename_branch(from_name, to_name):
-    """Rename a git branch
-    """
-    if not branch_exists(from_name):
-        raise GitException, 'Branch "%s" does not exist' % from_name
-    if branch_exists(to_name):
-        raise GitException, 'Branch "%s" already exists' % to_name
+def rename_ref(from_ref, to_ref):
+    if not ref_exists(from_ref):
+        raise GitException, '"%s" does not exist' % from_ref
+    if ref_exists(to_ref):
+        raise GitException, '"%s" already exists' % to_ref
=20
+    sha1 =3D _output_one_line(['git-show-ref', '-s', from_ref])
+    if __run('git-update-ref %s %s %s' % (to_ref, sha1, '0'*40)):
+        raise GitException, 'Failed to create new ref %s' % to_ref
+    if __run('git-update-ref -d %s %s' % (from_ref, sha1)):
+        raise GitException, 'Failed to delete ref %s' % from_ref
+
+def rename_branch(from_name, to_name):
+    """Rename a git branch."""
+    rename_ref('refs/heads/%s' % from_name, 'refs/heads/%s' % to_name)
     if get_head_file() =3D=3D from_name:
         set_head_file(to_name)
-    rename(os.path.join(basedir.get(), 'refs', 'heads'),
-           from_name, to_name)
-
     reflog_dir =3D os.path.join(basedir.get(), 'logs', 'refs', 'heads'=
)
     if os.path.exists(reflog_dir) \
            and os.path.exists(os.path.join(reflog_dir, from_name)):
diff --git a/stgit/stack.py b/stgit/stack.py
index a54a3b2..3880a94 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -142,14 +142,16 @@ class StgitObject:
 class Patch(StgitObject):
     """Basic patch implementation
     """
-    def __init__(self, name, series_dir, refs_dir):
+    def __init_refs(self):
+        self.__top_ref =3D self.__refs_base + '/' + self.__name
+        self.__log_ref =3D self.__top_ref + '.log'
+
+    def __init__(self, name, series_dir, refs_base):
         self.__series_dir =3D series_dir
         self.__name =3D name
         self._set_dir(os.path.join(self.__series_dir, self.__name))
-        self.__refs_dir =3D refs_dir
-        self.__top_ref_file =3D os.path.join(self.__refs_dir, self.__n=
ame)
-        self.__log_ref_file =3D os.path.join(self.__refs_dir,
-                                           self.__name + '.log')
+        self.__refs_base =3D refs_base
+        self.__init_refs()
=20
     def create(self):
         os.mkdir(self._dir())
@@ -160,33 +162,31 @@ class Patch(StgitObject):
         for f in os.listdir(self._dir()):
             os.remove(os.path.join(self._dir(), f))
         os.rmdir(self._dir())
-        os.remove(self.__top_ref_file)
-        if os.path.exists(self.__log_ref_file):
-            os.remove(self.__log_ref_file)
+        git.delete_ref(self.__top_ref)
+        if git.ref_exists(self.__log_ref):
+            git.delete_ref(self.__log_ref)
=20
     def get_name(self):
         return self.__name
=20
     def rename(self, newname):
         olddir =3D self._dir()
-        old_top_ref_file =3D self.__top_ref_file
-        old_log_ref_file =3D self.__log_ref_file
+        old_top_ref =3D self.__top_ref
+        old_log_ref =3D self.__log_ref
         self.__name =3D newname
         self._set_dir(os.path.join(self.__series_dir, self.__name))
-        self.__top_ref_file =3D os.path.join(self.__refs_dir, self.__n=
ame)
-        self.__log_ref_file =3D os.path.join(self.__refs_dir,
-                                           self.__name + '.log')
+        self.__init_refs()
=20
+        git.rename_ref(old_top_ref, self.__top_ref)
+        if git.ref_exists(old_log_ref):
+            git.rename_ref(old_log_ref, self.__log_ref)
         os.rename(olddir, self._dir())
-        os.rename(old_top_ref_file, self.__top_ref_file)
-        if os.path.exists(old_log_ref_file):
-            os.rename(old_log_ref_file, self.__log_ref_file)
=20
     def __update_top_ref(self, ref):
-        write_string(self.__top_ref_file, ref)
+        git.set_ref(self.__top_ref, ref)
=20
     def __update_log_ref(self, ref):
-        write_string(self.__log_ref_file, ref)
+        git.set_ref(self.__log_ref, ref)
=20
     def update_top_ref(self):
         top =3D self.get_top()
@@ -358,8 +358,7 @@ class Series(PatchSet):
         # initialized, but don't touch it if it isn't.
         self.update_to_current_format_version()
=20
-        self.__refs_dir =3D os.path.join(self._basedir(), 'refs', 'pat=
ches',
-                                       self.get_name())
+        self.__refs_base =3D 'refs/patches/%s' % self.get_name()
=20
         self.__applied_file =3D os.path.join(self._dir(), 'applied')
         self.__unapplied_file =3D os.path.join(self._dir(), 'unapplied=
')
@@ -416,20 +415,22 @@ class Series(PatchSet):
         def rm(f):
             if os.path.exists(f):
                 os.remove(f)
+        def rm_ref(ref):
+            if git.ref_exists(ref):
+                git.delete_ref(ref)
=20
         # Update 0 -> 1.
         if get_format_version() =3D=3D 0:
             mkdir(os.path.join(branch_dir, 'trash'))
             patch_dir =3D os.path.join(branch_dir, 'patches')
             mkdir(patch_dir)
-            refs_dir =3D os.path.join(self._basedir(), 'refs', 'patche=
s', self.get_name())
-            mkdir(refs_dir)
+            refs_base =3D 'refs/patches/%s' % self.get_name()
             for patch in (file(os.path.join(branch_dir, 'unapplied')).=
readlines()
                           + file(os.path.join(branch_dir, 'applied')).=
readlines()):
                 patch =3D patch.strip()
                 os.rename(os.path.join(branch_dir, patch),
                           os.path.join(patch_dir, patch))
-                Patch(patch, patch_dir, refs_dir).update_top_ref()
+                Patch(patch, patch_dir, refs_base).update_top_ref()
             set_format_version(1)
=20
         # Update 1 -> 2.
@@ -441,7 +442,7 @@ class Series(PatchSet):
                     config.set('branch.%s.description' % self.get_name=
(), desc)
                 rm(desc_file)
             rm(os.path.join(branch_dir, 'current'))
-            rm(os.path.join(self._basedir(), 'refs', 'bases', self.get=
_name()))
+            rm_ref('refs/bases/%s' % self.get_name())
             set_format_version(2)
=20
         # Make sure we're at the latest version.
@@ -458,7 +459,7 @@ class Series(PatchSet):
     def get_patch(self, name):
         """Return a Patch object for the given name
         """
-        return Patch(name, self.__patch_dir, self.__refs_dir)
+        return Patch(name, self.__patch_dir, self.__refs_base)
=20
     def get_current_patch(self):
         """Return a Patch object representing the topmost patch, or
@@ -580,7 +581,7 @@ class Series(PatchSet):
         """
         if self.is_initialised():
             raise StackException, '%s already initialized' % self.get_=
name()
-        for d in [self._dir(), self.__refs_dir]:
+        for d in [self._dir()]:
             if os.path.exists(d):
                 raise StackException, '%s already exists' % d
=20
@@ -593,7 +594,6 @@ class Series(PatchSet):
=20
         self.create_empty_field('applied')
         self.create_empty_field('unapplied')
-        os.makedirs(self.__refs_dir)
         self._set_field('orig-base', git.get_head())
=20
         config.set(self.format_version_key(), str(FORMAT_VERSION))
@@ -606,14 +606,18 @@ class Series(PatchSet):
         if to_stack.is_initialised():
             raise StackException, '"%s" already exists' % to_stack.get=
_name()
=20
+        patches =3D self.get_applied() + self.get_unapplied()
+
         git.rename_branch(self.get_name(), to_name)
=20
+        for patch in patches:
+            git.rename_ref('refs/patches/%s/%s' % (self.get_name(), pa=
tch),
+                           'refs/patches/%s/%s' % (to_name, patch))
+            git.rename_ref('refs/patches/%s/%s.log' % (self.get_name()=
, patch),
+                           'refs/patches/%s/%s.log' % (to_name, patch)=
)
         if os.path.isdir(self._dir()):
             rename(os.path.join(self._basedir(), 'patches'),
                    self.get_name(), to_stack.get_name())
-        if os.path.exists(self.__refs_dir):
-            rename(os.path.join(self._basedir(), 'refs', 'patches'),
-                   self.get_name(), to_stack.get_name())
=20
         # Rename the config section
         config.rename_section("branch.%s" % self.get_name(),
@@ -715,9 +719,9 @@ class Series(PatchSet):
                                      % self._dir())
=20
             try:
-                os.removedirs(self.__refs_dir)
-            except OSError:
-                out.warn('Refs directory %s is not empty' % self.__ref=
s_dir)
+                git.delete_branch(self.get_name())
+            except GitException:
+                out.warn('Could not delete branch "%s"' % self.get_nam=
e())
=20
         # Cleanup parent informations
         # FIXME: should one day make use of git-config --section-remov=
e,
diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
index fac6339..1685233 100755
--- a/t/t0001-subdir-branches.sh
+++ b/t/t0001-subdir-branches.sh
@@ -50,10 +50,11 @@ test_expect_success 'Create patch in slashy branch'=
 \
=20
 test_expect_success 'Rename branches' \
   'stg branch --rename master goo/gaa &&
-   test ! -e .git/refs/heads/master &&
+   ! git show-ref --verify --quiet refs/heads/master &&
    stg branch --rename goo/gaa x1/x2/x3/x4 &&
-   test ! -e .git/refs/heads/goo &&
+   ! git show-ref --verify --quiet refs/heads/goo/gaa &&
    stg branch --rename x1/x2/x3/x4 servant &&
-   test ! -e .git/refs/heads/x1'
+   ! git show-ref --verify --quiet refs/heads/x1/x2/x3/x4
+'
=20
 test_done
diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index cca5504..e920e93 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -13,26 +13,9 @@ Exercises the "stg branch" commands.
 stg init
=20
 test_expect_success \
-    'Create a spurious refs/patches/ entry' '
-    find .git -name foo | xargs rm -rf &&
-    touch .git/refs/patches/foo
-'
-
-test_expect_failure \
-    'Try to create an stgit branch with a spurious refs/patches/ entry=
' '
-    stg branch -c foo
-'
-
-test_expect_success \
-    'Check that no part of the branch was created' '
-    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/patc=
hes/foo" &&
-    ( grep foo .git/HEAD; test $? =3D 1 )
-'
-
-test_expect_success \
     'Create a spurious patches/ entry' '
     find .git -name foo | xargs rm -rf &&
-    touch .git/patches/foo
+    mkdir -p .git/patches && touch .git/patches/foo
 '
=20
 test_expect_failure \
@@ -69,15 +52,4 @@ test_expect_success \
     touch .git/refs/heads/foo
 '
=20
-test_expect_failure \
-    'Try to create an stgit branch with an invalid refs/heads/ entry' =
'
-    stg branch -c foo
-'
-
-test_expect_success \
-    'Check that no part of the branch was created' '
-    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/head=
s/foo" &&
-    ( grep foo .git/HEAD; test $? =3D 1 )
-'
-
 test_done
diff --git a/t/t1001-branch-rename.sh b/t/t1001-branch-rename.sh
index 28da15c..4e1ec84 100755
--- a/t/t1001-branch-rename.sh
+++ b/t/t1001-branch-rename.sh
@@ -26,7 +26,7 @@ test_expect_success \
     'Rename an stgit branch' \
     'stg branch -c buz &&
      stg branch -r foo bar &&
-     test -z `find .git -name foo | tee /dev/stderr`
+     [ -z $(find .git -type f | grep foo | tee /dev/stderr) ]
 '
=20
 test_done
