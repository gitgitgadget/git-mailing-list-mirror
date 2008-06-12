From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Thu, 12 Jun 2008 07:34:25 +0200
Message-ID: <20080612053424.23549.64457.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fTO-0004xa-5i
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbYFLFem convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYFLFem
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:34:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2158 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbYFLFek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:34:40 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fS5-00013z-00; Thu, 12 Jun 2008 06:34:25 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84705>

Create a log branch (called <branchname>.stgit) for each StGit branch,
and write to it whenever the stack is modified.

Commands using the new infrastructure write to the log when they
commit a transaction. Commands using the old infrastructure get a log
entry write written for them when they exit, unless they explicitly
ask for this not to happen.

The only thing you can do with this log at the moment is look at it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/branch.py  |   19 ++-
 stgit/commands/common.py  |    8 +
 stgit/commands/diff.py    |    2=20
 stgit/commands/files.py   |    2=20
 stgit/commands/id.py      |    2=20
 stgit/commands/log.py     |    2=20
 stgit/commands/mail.py    |    2=20
 stgit/commands/patches.py |    2=20
 stgit/commands/show.py    |    2=20
 stgit/commands/status.py  |    3 -
 stgit/lib/git.py          |    3 -
 stgit/lib/log.py          |  254 +++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py        |    9 ++
 stgit/lib/transaction.py  |    3 -
 stgit/main.py             |    2=20
 15 files changed, 298 insertions(+), 17 deletions(-)
 create mode 100644 stgit/lib/log.py


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 50684bb..edbb01c 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -25,7 +25,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git, basedir
-
+from stgit.lib import log
=20
 help =3D 'manage patch stacks'
 usage =3D """%prog [options] branch-name [commit-id]
@@ -40,7 +40,7 @@ When displaying the branches, the names can be prefix=
ed with
=20
 If not given any options, switch to the named branch."""
=20
-directory =3D DirectoryGotoToplevel()
+directory =3D DirectoryGotoToplevel(log =3D False)
 options =3D [make_option('-c', '--create',
                        help =3D 'create a new development branch',
                        action =3D 'store_true'),
@@ -161,6 +161,7 @@ def func(parser, options, args):
                                    parent_branch =3D parentbranch)
=20
         out.info('Branch "%s" created' % args[0])
+        log.compat_log_entry('branch --create')
         return
=20
     elif options.clone:
@@ -181,6 +182,8 @@ def func(parser, options, args):
         crt_series.clone(clone)
         out.done()
=20
+        log.copy_log(log.default_repo(), crt_series.get_name(), clone,
+                     'branch --clone')
         return
=20
     elif options.delete:
@@ -188,6 +191,7 @@ def func(parser, options, args):
         if len(args) !=3D 1:
             parser.error('incorrect number of arguments')
         __delete_branch(args[0], options.force)
+        log.delete_log(log.default_repo(), args[0])
         return
=20
     elif options.list:
@@ -195,13 +199,16 @@ def func(parser, options, args):
         if len(args) !=3D 0:
             parser.error('incorrect number of arguments')
=20
-        branches =3D git.get_heads()
-        branches.sort()
+        branches =3D set(git.get_heads())
+        for br in set(branches):
+            m =3D re.match(r'^(.*)\.stgit$', br)
+            if m and m.group(1) in branches:
+                branches.remove(br)
=20
         if branches:
             out.info('Available branches:')
             max_len =3D max([len(i) for i in branches])
-            for i in branches:
+            for i in sorted(branches):
                 __print_branch(i, max_len)
         else:
             out.info('No branches')
@@ -238,7 +245,7 @@ def func(parser, options, args):
         stack.Series(args[0]).rename(args[1])
=20
         out.info('Renamed branch "%s" to "%s"' % (args[0], args[1]))
-
+        log.rename_log(log.default_repo(), args[0], args[1], 'branch -=
-rename')
         return
=20
     elif options.unprotect:
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 029ec65..fd02398 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -28,6 +28,7 @@ from stgit.run import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
 from stgit.lib import stack as libstack
+from stgit.lib import log
=20
 # Command exception class
 class CmdException(StgException):
@@ -478,8 +479,9 @@ class DirectoryException(StgException):
     pass
=20
 class _Directory(object):
-    def __init__(self, needs_current_series =3D True):
+    def __init__(self, needs_current_series =3D True, log =3D True):
         self.needs_current_series =3D  needs_current_series
+        self.log =3D log
     @readonly_constant_property
     def git_dir(self):
         try:
@@ -512,6 +514,9 @@ class _Directory(object):
                        ).output_one_line()]
     def cd_to_topdir(self):
         os.chdir(self.__topdir_path)
+    def write_log(self, msg):
+        if self.log:
+            log.compat_log_entry(msg)
=20
 class DirectoryAnywhere(_Directory):
     def setup(self):
@@ -536,6 +541,7 @@ class DirectoryHasRepositoryLib(_Directory):
     """For commands that use the new infrastructure in stgit.lib.*."""
     def __init__(self):
         self.needs_current_series =3D False
+        self.log =3D False # stgit.lib.transaction handles logging
     def setup(self):
         # This will throw an exception if we don't have a repository.
         self.repository =3D libstack.Repository.default()
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index fd6be34..8966642 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -42,7 +42,7 @@ rev =3D '([patch][//[bottom | top]]) | <tree-ish> | b=
ase'
 If neither bottom nor top are given but a '//' is present, the command
 shows the specified patch (defaulting to the current one)."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-r', '--range',
                        metavar =3D 'rev1[..[rev2]]', dest =3D 'revs',
                        help =3D 'show the diff between revisions'),
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index b43b12f..7844f8d 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -34,7 +34,7 @@ given patch. Note that this command doesn't show the =
files modified in
 the working tree and not yet included in the patch by a 'refresh'
 command. Use the 'diff' or 'status' commands for these files."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-s', '--stat',
                        help =3D 'show the diff stat',
                        action =3D 'store_true'),
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 94b0229..5bb1ad2 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -33,7 +33,7 @@ the standard GIT id's like heads and tags, this comma=
nd also accepts
 'top' or 'bottom' are passed and <patch> is a valid patch name, 'top'
 will be used by default."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index 52d55a5..13e0baa 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -44,7 +44,7 @@ represent the changes to the entire base of the curre=
nt
 patch. Conflicts reset the patch content and a subsequent 'refresh'
 will show the entire patch."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-p', '--patch',
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index b4d4e18..4027170 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -90,7 +90,7 @@ the following:
   %(prefix)s       - 'prefix ' string passed on the command line
   %(shortdescr)s   - the first line of the patch description"""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-a', '--all',
                        help =3D 'e-mail all the applied patches',
                        action =3D 'store_true'),
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index 140699d..c95c40f 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -33,7 +33,7 @@ it shows the patches affected by the local tree modif=
ications. The
 '--diff' option also lists the patch log and the diff for the given
 files."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-d', '--diff',
                        help =3D 'show the diff for the given files',
                        action =3D 'store_true'),
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index b77a9c8..dd2a3a3 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -30,7 +30,7 @@ Show the commit log and the diff corresponding to the=
 given
 patches. The output is similar to that generated by the 'git show'
 command."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-a', '--applied',
diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index a5b2f88..4d13112 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -40,7 +40,7 @@ under revision control. The files are prefixed as fol=
lows:
 A 'refresh' command clears the status of the modified, new and deleted
 files."""
=20
-directory =3D DirectoryHasRepository(needs_current_series =3D False)
+directory =3D DirectoryHasRepository(needs_current_series =3D False, l=
og =3D False)
 options =3D [make_option('-m', '--modified',
                        help =3D 'show modified files only',
                        action =3D 'store_true'),
@@ -106,6 +106,7 @@ def func(parser, options, args):
     directory.cd_to_topdir()
=20
     if options.reset:
+        directory.log =3D True
         if args:
             conflicts =3D git.get_conflicts()
             git.resolved([fn for fn in args if fn in conflicts])
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index a8881f4..35e03d2 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -139,6 +139,7 @@ class Person(Immutable, Repr):
         assert isinstance(self.__date, Date) or self.__date in [None, =
NoValue]
     name =3D property(lambda self: self.__name)
     email =3D property(lambda self: self.__email)
+    name_email =3D property(lambda self: '%s <%s>' % (self.name, self.=
email))
     date =3D property(lambda self: self.__date)
     def set_name(self, name):
         return type(self)(name =3D name, defaults =3D self)
@@ -147,7 +148,7 @@ class Person(Immutable, Repr):
     def set_date(self, date):
         return type(self)(date =3D date, defaults =3D self)
     def __str__(self):
-        return '%s <%s> %s' % (self.name, self.email, self.date)
+        return '%s %s' % (self.name_email, self.date)
     @classmethod
     def parse(cls, s):
         m =3D re.match(r'^([^<]*)<([^>]*)>\s+(\d+\s+[+-]\d{4})$', s)
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
new file mode 100644
index 0000000..8646e08
--- /dev/null
+++ b/stgit/lib/log.py
@@ -0,0 +1,254 @@
+r"""This module contains functions and classes for manipulating
+I{patch stack logs} (or just I{stack logs}).
+
+A stack log is a git branch. Each commit contains the complete state
+of the stack at the moment it was written; the most recent commit has
+the most recent state.
+
+For a branch C{I{foo}}, the stack log is stored in C{I{foo}.stgit}.
+
+Stack log format (version 4)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+I{This describes version 4 of the stack log format. Versions 0 throgh
+3 were earlier development versions that are no longer supported.}
+
+Commit message
+--------------
+
+The commit message is meant for human consumption; in most cases it is
+just a subject line: the stg subcommand name and possibly some
+important command-line flag.
+
+The exception is log commits for undo and redo. Their subject line is
+"C{undo I{n}}" and "C{redo I{n}}"; the positive integer I{n} says how
+many steps were undone or redone.
+
+Tree
+----
+
+The top-level tree object has the following entries:
+
+  - C{version}: a blob containing the string "C{5\n}".
+
+  - C{head}: a blob containing the ASCII hex sha1 of the current HEAD,
+    followed by a newline.
+
+  - C{applied}, C{unapplied}: blobs containing one line for each
+    applied or unapplied patch, in order. Each line consists of
+
+      - the ASCII hex sha1 of the patch's commit object,
+
+      - a space, and
+
+      - the patch's name.
+
+  - C{patches}: a tree containing one subtree for each patch, named
+    after that patch. Each such subtree contains:
+
+      - C{a}, C{b}: the patch's I{bottom} and I{top} trees.
+
+      - C{info}: a blob containing::
+
+          Author: <author name and e-mail>
+          Date: <patch timestamp>
+
+          <commit message>
+
+Parents
+-------
+
+  - The first parent is the I{simplified log}, described below.
+
+  - The second and third parents are the branch head and the stack
+    top, in any order; if they are identical (which is always the case
+    unless StGit's metadata is messed up by use of a non-StGit tool),
+    just one of them is listed.
+
+  - The last parent is the previous log entry. (If there is no
+    previous log entry, it is omitted.) This log entry must be version
+    E{4}.
+
+Simplified log
+--------------
+
+The simplified log looks exactly like the normal, or I{full}, log,
+except for the following:
+
+  - Instead of having a tree per patch in the C{patches} subtree, it
+    has a blob per patch. This blob contains::
+
+      Bottom: <sha1 of patch's bottom tree>
+      Top:    <sha1 of patch's top tree>
+      Author: <author name and e-mail>
+      Date:   <patch timestamp>
+
+      <commit message>
+
+      ---
+
+      <patch's diff>
+
+  - Its only parent is the simplified version of the previous log
+    entry.
+
+The simplified log contains no information not in the full log; its
+purpose is ease of visualization."""
+
+from stgit.lib import git, stack
+from stgit import exception
+from stgit.out import out
+
+class LogException(exception.StgException):
+    pass
+
+_current_version =3D 4
+
+def commit_info(cd):
+    return 'Author: %s\nDate: %s\n\n%s' % (cd.author.name_email,
+                                           cd.author.date, cd.message)
+
+def patch_tree(repository, cd):
+    return repository.commit(git.TreeData({
+                'a': cd.parent.data.tree, 'b': cd.tree,
+                'info': repository.commit(git.BlobData(commit_info(cd)=
)) }))
+
+def patch_file(repository, cd):
+    return repository.commit(git.BlobData(''.join(s + '\n' for s in [
+                    'Bottom: %s' % cd.parent.data.tree.sha1,
+                    'Top:    %s' % cd.tree.sha1,
+                    'Author: %s' % cd.author.name_email,
+                    'Date:   %s' % cd.author.date,
+                    '',
+                    cd.message,
+                    '',
+                    '---',
+                    '',
+                    repository.diff_tree(cd.parent.data.tree, cd.tree,=
 ['-M']
+                                         ).strip()])))
+
+def order_blob(repository, stack, kind):
+    return repository.commit(git.BlobData(''.join(
+                '%s %s\n' % (stack.patches.get(pn).commit.sha1, pn)
+                for pn in getattr(stack.patchorder, kind))))
+
+def log_entry_trees(repository, stack):
+    full_patches, short_patches =3D [repository.commit(git.TreeData(di=
ct(
+                    (pn, x(repository, stack.patches.get(pn).commit.da=
ta))
+                    for pn in stack.patchorder.all)))
+                                   for x in [patch_tree, patch_file]]
+    version =3D repository.commit(git.BlobData('%d\n' % _current_versi=
on))
+    head =3D repository.commit(git.BlobData('%s\n' % stack.head.sha1))
+    applied =3D order_blob(repository, stack, 'applied')
+    unapplied =3D order_blob(repository, stack, 'unapplied')
+    return [repository.commit(git.TreeData({
+                    'version': version,
+                    'head': head,
+                    'patches': patches,
+                    'applied': applied,
+                    'unapplied': unapplied,
+                    })) for patches in [full_patches, short_patches]]
+
+def log_ref(branch):
+    return 'refs/heads/%s.stgit' % branch
+
+def log_entry(stack, msg):
+    """Write a new log entry for the stack."""
+    ref =3D log_ref(stack.name)
+    try:
+        last_log =3D [FullLog(stack.repository, ref,
+                            stack.repository.refs.get(ref))]
+    except KeyError:
+        last_log =3D []
+    except LogException, e:
+        out.warn(str(e), 'No log entry written.')
+        return
+    full_log_tree, short_log_tree =3D log_entry_trees(stack.repository=
, stack)
+    stack_log =3D stack.repository.commit(
+        git.CommitData(tree =3D short_log_tree, message =3D msg,
+                       parents =3D [ll.stack_log for ll in last_log]))
+    refs =3D list(set([stack.head, stack.top]))
+    full_log =3D stack.repository.commit(
+        git.CommitData(tree =3D full_log_tree, message =3D msg,
+                       parents =3D ([stack_log] + refs
+                                  + [ll.full_log for ll in last_log]))=
)
+    stack.repository.refs.set(ref, full_log, msg)
+
+def compat_log_entry(msg):
+    """Write a new log entry. (Convenience function intended for use b=
y
+    code not yet converted to the new infrastructure.)"""
+    repo =3D default_repo()
+    stack =3D repo.get_stack(repo.current_branch_name)
+    log_entry(stack, msg)
+
+class Log(object):
+    """Class used to read the stack log. Each instance represents one =
log
+    entry."""
+    def __init__(self, repo, ref, commit):
+        """Create a L{Log} object representing the log entry C{commit}=
=2E In any
+        error messages, say C{ref} when we mean C{commit}."""
+        self.commit =3D commit
+        mode, vblob =3D self.commit.data.tree.data.entries.get(
+            'version', (None, None))
+        if not isinstance(vblob, git.Blob):
+            raise LogException('%s does not contain a valid log' % ref=
)
+        try:
+            version =3D int(vblob.data.str)
+        except ValueError:
+            raise LogException('"%s": invalid version number' % vblob.=
data.str)
+        if version < _current_version:
+            raise LogException(
+                '%s contains a stack log older than version %d;'
+                ' please delete it' % (ref, _current_version))
+        elif version > _current_version:
+            raise LogException(
+                'Log contains a stack log newer than version %d;'
+                ' this version of StGit cannot read it' % _current_ver=
sion)
+
+        # TODO: read the rest of the log lazily.
+
+        def pl(name):
+            patches =3D [x.split() for x in
+                       self.commit.data.tree.data.entries[name][1]
+                       .data.str.strip().split('\n') if x]
+            # TODO: handle case where we don't have the commit object.
+            return ([pn for sha1, pn in patches],
+                    dict((pn, repo.get_commit(sha1)) for sha1, pn in p=
atches))
+        self.patches =3D {}
+        self.applied, patches =3D pl('applied')
+        self.patches.update(patches)
+        self.unapplied, patches =3D pl('unapplied')
+        self.patches.update(patches)
+        self.head =3D repo.get_commit(
+            self.commit.data.tree.data.entries['head'][1].data.str.str=
ip())
+        if self.applied:
+            self.base =3D self.patches[self.applied[0]].data.parent
+        else:
+            self.base =3D self.head
+
+class FullLog(Log):
+    full_log =3D property(lambda self: self.commit)
+    """Commit of the full log."""
+    stack_log =3D property(lambda self: self.commit.data.parents[0])
+    """Commit of the simplified log."""
+
+def delete_log(repo, branch):
+    ref =3D log_ref(branch)
+    if repo.refs.exists(ref):
+        repo.refs.delete(ref)
+
+def rename_log(repo, old_branch, new_branch, msg):
+    old_ref =3D log_ref(old_branch)
+    new_ref =3D log_ref(new_branch)
+    if repo.refs.exists(old_ref):
+        repo.refs.set(new_ref, repo.refs.get(old_ref), msg)
+        repo.refs.delete(old_ref)
+
+def copy_log(repo, src_branch, dst_branch, msg):
+    src_ref =3D log_ref(src_branch)
+    dst_ref =3D log_ref(dst_branch)
+    if repo.refs.exists(src_ref):
+        repo.refs.set(dst_ref, repo.refs.get(src_ref), msg)
+
+def default_repo():
+    return stack.Repository.default()
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 9cb3967..62a1ec2 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -165,6 +165,15 @@ class Stack(git.Branch):
                                     ).commit.data.parent
         else:
             return self.head
+    @property
+    def top(self):
+        """Commit of the topmost patch, or the stack base if no patche=
s are
+        applied."""
+        if self.patchorder.applied:
+            return self.patches.get(self.patchorder.applied[-1]).commi=
t
+        else:
+            # When no patches are applied, base =3D=3D head.
+            return self.head
     def head_top_equal(self):
         if not self.patchorder.applied:
             return True
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index e47997e..4c4da1a 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -4,7 +4,7 @@ updates to an StGit stack in a safe and convenient way.=
"""
 from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
-from stgit.lib import git
+from stgit.lib import git, log
=20
 class TransactionException(exception.StgException):
     """Exception raised when something goes wrong with a
@@ -170,6 +170,7 @@ class StackTransaction(object):
         _print_current_patch(self.__stack.patchorder.applied, self.__a=
pplied)
         self.__stack.patchorder.applied =3D self.__applied
         self.__stack.patchorder.unapplied =3D self.__unapplied
+        log.log_entry(self.__stack, self.__msg)
=20
         if self.__error:
             return utils.STGIT_CONFLICT
diff --git a/stgit/main.py b/stgit/main.py
index aa1f8ef..ec0e840 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -277,6 +277,7 @@ def main():
=20
         ret =3D command.func(parser, options, args)
     except (StgException, IOError, ParsingError, NoSectionError), err:
+        directory.write_log(cmd)
         out.error(str(err), title =3D '%s %s' % (prog, cmd))
         if debug_level > 0:
             traceback.print_exc()
@@ -292,4 +293,5 @@ def main():
         traceback.print_exc()
         sys.exit(utils.STGIT_BUG_ERROR)
=20
+    directory.write_log(cmd)
     sys.exit(ret or utils.STGIT_SUCCESS)
