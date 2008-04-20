From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 04/10] Write to a stack log when stack is modified
Date: Mon, 21 Apr 2008 00:10:44 +0200
Message-ID: <20080420221044.5837.25817.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:12:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnhlW-000853-Vn
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbYDTWK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYDTWK7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:10:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3192 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbYDTWK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:10:58 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JnhkA-00082D-00; Sun, 20 Apr 2008 23:10:42 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79994>

Create a log branch (called <branchname>.stgit) for each StGit branch,
and write to it whenever the stack is modified.

Commands using the new infrastructure write to the log when they
commit a transaction. Commands using the old infrastructure get a log
entry write written for them when they exit, unless they explicitly
ask for this not to happen.

As of yet, nothing can be done with this log.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/branch.py  |   20 +++++--
 stgit/commands/common.py  |    8 ++-
 stgit/commands/diff.py    |    2 -
 stgit/commands/export.py  |    2 -
 stgit/commands/files.py   |    2 -
 stgit/commands/id.py      |    2 -
 stgit/commands/log.py     |    2 -
 stgit/commands/mail.py    |    2 -
 stgit/commands/patches.py |    2 -
 stgit/commands/series.py  |    2 -
 stgit/commands/show.py    |    2 -
 stgit/commands/status.py  |    3 +
 stgit/commands/top.py     |    2 -
 stgit/lib/log.py          |  131 +++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/transaction.py  |    3 +
 stgit/main.py             |    2 +
 16 files changed, 168 insertions(+), 19 deletions(-)
 create mode 100644 stgit/lib/log.py


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 50684bb..241b1ef 100644
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
+        log.compat_log_entry('stg branch --create')
         return
=20
     elif options.clone:
@@ -181,6 +182,8 @@ def func(parser, options, args):
         crt_series.clone(clone)
         out.done()
=20
+        log.copy_log(log.default_repo(), crt_series.get_name(), clone,
+                     'stg branch --clone')
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
@@ -238,7 +245,8 @@ def func(parser, options, args):
         stack.Series(args[0]).rename(args[1])
=20
         out.info('Renamed branch "%s" to "%s"' % (args[0], args[1]))
-
+        log.rename_log(log.default_repo(), args[0], args[1],
+                       'stg branch --rename')
         return
=20
     elif options.unprotect:
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index d6df813..1a45d9e 100644
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
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 50f6f67..552fd44 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -49,7 +49,7 @@ file:
   %(commemail)s   - committer's e-mail
 """
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-d', '--dir',
                        help =3D 'export patches to DIR instead of the =
default'),
            make_option('-p', '--patch',
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
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index e3467cc..8d19dd7 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -34,7 +34,7 @@ range. The applied patches are prefixed with a '+', t=
he unapplied ones
 with a '-' and the hidden ones with a '!'. The current patch is
 prefixed with a '>'. Empty patches are prefixed with a '0'."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
            make_option('-a', '--all',
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
index 6da4516..37b79c0 100644
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
             git.resolved(fn for fn in args if fn in conflicts)
diff --git a/stgit/commands/top.py b/stgit/commands/top.py
index e7cb275..96d680e 100644
--- a/stgit/commands/top.py
+++ b/stgit/commands/top.py
@@ -30,7 +30,7 @@ usage =3D """%prog [options]
=20
 Print the name of the current (topmost) patch."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D DirectoryHasRepository(log =3D False)
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
new file mode 100644
index 0000000..fac050f
--- /dev/null
+++ b/stgit/lib/log.py
@@ -0,0 +1,131 @@
+from stgit.lib import git, stack
+from stgit import exception
+from stgit.out import out
+
+class LogException(exception.StgException):
+    pass
+
+_current_version =3D 1
+
+def commit_info(cd):
+    return 'Author: %s\n\n%s' % (cd.author, cd.message)
+
+def patch_tree(repository, cd):
+    return repository.commit(git.Treedata({
+                'a': cd.parent.data.tree, 'b': cd.tree,
+                'info': repository.commit(git.Blobdata(commit_info(cd)=
)) }))
+
+def order_blob(repository, stack, kind):
+    return repository.commit(git.Blobdata(''.join(
+                '%s %s\n' % (stack.patches.get(pn).commit.sha1, pn)
+                for pn in getattr(stack.patchorder, kind))))
+
+def log_entry_tree(repository, stack):
+    patches =3D repository.commit(
+        git.Treedata(dict((pn, patch_tree(repository,
+                                          stack.patches.get(pn).commit=
=2Edata))
+                          for pn in stack.patchorder.all)))
+    return repository.commit(git.Treedata({
+                'version': repository.commit(git.Blobdata(
+                        str(_current_version))),
+                'head': repository.commit(git.Blobdata(str(stack.head.=
sha1))),
+                'patches': patches,
+                'applied': order_blob(repository, stack, 'applied'),
+                'unapplied': order_blob(repository, stack, 'unapplied'=
),
+                }))
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
+    log_tree =3D log_entry_tree(stack.repository, stack)
+    stack_log =3D stack.repository.commit(
+        git.Commitdata(tree =3D log_tree, message =3D msg,
+                       parents =3D [ll.stack_log for ll in last_log]))
+    full_log =3D stack.repository.commit(
+        git.Commitdata(tree =3D log_tree, message =3D msg,
+                       parents =3D ([stack_log] + [stack.head]
+                                  + [ll.full_log for ll in last_log]))=
)
+    stack.repository.refs.set(ref, full_log, msg)
+
+def compat_log_entry(msg):
+    repo =3D default_repo()
+    stack =3D repo.get_stack(repo.current_branch)
+    log_entry(stack, msg)
+
+class Log(object):
+    """Read a log entry."""
+    def __init__(self, repo, ref, commit):
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
+            self.commit.data.tree.data.entries['head'][1].data.str)
+        if self.applied:
+            self.base =3D self.patches[self.applied[0]].data.parent
+        else:
+            self.base =3D self.head
+
+class FullLog(Log):
+    full_log =3D property(lambda self: self.commit)
+    stack_log =3D property(lambda self: self.commit.data.parents[0])
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
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 874f81b..4fb37ce 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,7 +1,7 @@
 from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
-from stgit.lib import git
+from stgit.lib import git, log
=20
 class TransactionException(exception.StgException):
     pass
@@ -131,6 +131,7 @@ class StackTransaction(object):
         _print_current_patch(self.__stack.patchorder.applied, self.__a=
pplied)
         self.__stack.patchorder.applied =3D self.__applied
         self.__stack.patchorder.unapplied =3D self.__unapplied
+        log.log_entry(self.__stack, self.__msg)
=20
         if self.__error:
             return utils.STGIT_CONFLICT
diff --git a/stgit/main.py b/stgit/main.py
index aa1f8ef..bd1a187 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -277,6 +277,7 @@ def main():
=20
         ret =3D command.func(parser, options, args)
     except (StgException, IOError, ParsingError, NoSectionError), err:
+        directory.write_log('%s %s' % (prog, cmd))
         out.error(str(err), title =3D '%s %s' % (prog, cmd))
         if debug_level > 0:
             traceback.print_exc()
@@ -292,4 +293,5 @@ def main():
         traceback.print_exc()
         sys.exit(utils.STGIT_BUG_ERROR)
=20
+    directory.write_log('%s %s' % (prog, cmd))
     sys.exit(ret or utils.STGIT_SUCCESS)
