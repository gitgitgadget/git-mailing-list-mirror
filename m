From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Write to a stack log when stack is modified
Date: Thu, 14 Feb 2008 02:32:01 +0100
Message-ID: <20080214012912.22365.83207.stgit@yoghurt>
References: <20080214012119.22365.54526.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 02:33:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPSyF-0005FJ-PJ
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 02:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758668AbYBNBcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 20:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933930AbYBNBcJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 20:32:09 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4236 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758668AbYBNBcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 20:32:06 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JPSxE-0003Yp-00; Thu, 14 Feb 2008 01:32:01 +0000
In-Reply-To: <20080214012119.22365.54526.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73837>

Create a log branch (called <branchname>.stgit) for each StGit branch,
and write to it whenever the stack is modified.

As of yet, nothing can be done with this log.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Lots of noise here since all the old-infrastructure commands update
the log manually. But note how few lines it takes to actually write
the blobs, trees, and commits (in log.py, near the end).

 stgit/commands/branch.py   |   18 ++++++++++---
 stgit/commands/clone.py    |    3 +-
 stgit/commands/float.py    |    3 ++
 stgit/commands/fold.py     |    3 +-
 stgit/commands/imprt.py    |    3 +-
 stgit/commands/init.py     |    3 +-
 stgit/commands/pick.py     |    3 +-
 stgit/commands/pop.py      |    3 +-
 stgit/commands/pull.py     |    3 +-
 stgit/commands/push.py     |    6 ++--
 stgit/commands/rebase.py   |    4 +--
 stgit/commands/refresh.py  |    4 ++-
 stgit/commands/rename.py   |    3 +-
 stgit/commands/resolved.py |    4 ++-
 stgit/commands/sink.py     |    3 +-
 stgit/commands/sync.py     |    5 +++-
 stgit/lib/log.py           |   60 ++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/transaction.py   |    3 +-
 18 files changed, 111 insertions(+), 23 deletions(-)
 create mode 100644 stgit/lib/log.py


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 50684bb..131dfea 100644
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
@@ -161,6 +161,7 @@ def func(parser, options, args):
                                    parent_branch =3D parentbranch)
=20
         out.info('Branch "%s" created' % args[0])
+        log.log_entry(log.default_stack(), 'stg branch --create')
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
diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index c3b0bbe..8c3cccd 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -21,7 +21,7 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'make a local clone of a remote repository'
 usage =3D """%prog [options] <repository> <dir>
@@ -56,5 +56,6 @@ def func(parser, options, args):
     # to work on a brand new repository
     basedir.clear_cache()
     stack.Series().init()
+    log.log_entry(log.default_stack(), 'stg clone')
=20
     print 'done'
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 0ba4446..5fec87e 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -22,6 +22,7 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
+from stgit.lib import log
=20
 help =3D 'push patches to the top, even if applied'
 usage =3D """%prog [<patches> | -s [<series>] ]
@@ -89,3 +90,5 @@ def func(parser, options, args):
         if topush:
             topush.reverse()
             push_patches(crt_series, topush)
+
+    log.log_entry(log.default_stack(), 'stg float')
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 3930a1f..105f54a 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -22,7 +22,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'integrate a GNU diff patch into the current patch'
 usage =3D """%prog [options] [<file>]
@@ -80,3 +80,4 @@ def func(parser, options, args):
         git.apply_patch(filename =3D filename)
=20
     out.done()
+    log.log_entry(log.default_stack(), 'stg fold')
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 4a4b792..d90e45d 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -24,7 +24,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'import a GNU diff file as a new patch'
 usage =3D """%prog [options] [<file>|<url>]
@@ -289,3 +289,4 @@ def func(parser, options, args):
         __import_file(filename, options)
=20
     print_crt_patch(crt_series)
+    log.log_entry(log.default_stack(), 'stg import')
diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index 475a4ce..b49b7b2 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -22,7 +22,7 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'initialise the current branch for use with StGIT'
 usage =3D """%prog [options]
@@ -42,3 +42,4 @@ def func(parser, options, args):
         parser.error('incorrect number of arguments')
=20
     crt_series.init()
+    log.log_entry(log.default_stack(), 'stg init')
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index e011a84..4cc8944 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -23,7 +23,7 @@ from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git
 from stgit.stack import Series
-
+from stgit.lib import log
=20
 help =3D 'import a patch from a different branch or a commit object'
 usage =3D """%prog [options] [<patch@branch>|<commit>]
@@ -163,4 +163,5 @@ def func(parser, options, args):
         else:
             out.done()
=20
+    log.log_entry(log.default_stack(), 'stg pick')
     print_crt_patch(crt_series)
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index dedf41b..e60361e 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -22,7 +22,7 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'pop one or more patches from the stack'
 usage =3D """%prog [options] [<patch1>] [<patch2>] [<patch3>..<patch4>=
]
@@ -87,4 +87,5 @@ def func(parser, options, args):
     if topush:
         push_patches(crt_series, topush)
=20
+    log.log_entry(log.default_stack(), 'stg pop')
     print_crt_patch(crt_series)
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index bec7fd7..8be5a14 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -23,7 +23,7 @@ from stgit.utils import *
 from stgit.out import *
 from stgit.config import GitConfigException
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'pull the changes from the remote repository'
 usage =3D """%prog [options] [<repository>]
@@ -106,4 +106,5 @@ def func(parser, options, args):
     if config.get('stgit.keepoptimized') =3D=3D 'yes':
         git.repack()
=20
+    log.log_entry(log.default_stack(), 'stg pull')
     print_crt_patch(crt_series)
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 979835b..148a0b5 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -23,7 +23,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'push one or more patches onto of the stack'
 usage =3D """%prog [options] [<patch1>] [<patch2>] [<patch3>..<patch4>=
]
@@ -69,11 +69,11 @@ def func(parser, options, args):
         out.start('Undoing push of "%s"' % patch)
         resolved_all()
         if crt_series.undo_push():
+            log.log_entry(log.default_stack(), 'stg push --undo')
             out.done()
         else:
             out.done('patch unchanged')
         print_crt_patch(crt_series)
-
         return
=20
     check_local_changes()
@@ -100,5 +100,5 @@ def func(parser, options, args):
         patches.reverse()
=20
     push_patches(crt_series, patches, options.merged)
-
+    log.log_entry(log.default_stack(), 'stg push')
     print_crt_patch(crt_series)
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 12faaf8..41e93ce 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -21,7 +21,7 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'move the stack base to another point in history'
 usage =3D """%prog [options] <new-base-id>
@@ -57,5 +57,5 @@ def func(parser, options, args):
     applied =3D prepare_rebase(crt_series)
     rebase(crt_series, args[0])
     post_rebase(crt_series, applied, options.nopush, options.merged)
-
+    log.log_entry(log.default_stack(), 'stg rebase')
     print_crt_patch(crt_series)
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 4695c62..017ec5b 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -24,7 +24,7 @@ from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git
 from stgit.config import config
-
+from stgit.lib import log
=20
 help =3D 'generate a new commit for the current patch'
 usage =3D """%prog [options] [<files or dirs>]
@@ -91,6 +91,7 @@ def func(parser, options, args):
     if options.undo:
         out.start('Undoing the refresh of "%s"' % patch)
         crt_series.undo_refresh()
+        log.log_entry(log.default_stack(), 'stg refresh --undo')
         out.done()
         return
=20
@@ -131,6 +132,7 @@ def func(parser, options, args):
         if options.patch:
             between.reverse()
             push_patches(crt_series, between)
+        log.log_entry(log.default_stack(), 'stg refresh')
     elif options.annotate:
         # only annotate the top log entry as there is no need to
         # refresh the patch and generate a full commit
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index e2b0fa4..4e9aac0 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -22,7 +22,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'rename a patch in the series'
 usage =3D """%prog [options] <oldpatch> <newpatch>
@@ -42,4 +42,5 @@ def func(parser, options, args):
=20
     out.start('Renaming patch "%s" to "%s"' % (args[0], args[1]))
     crt_series.rename_patch(args[0], args[1])
+    log.log_entry(log.default_stack(), 'stg rename')
     out.done()
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index 4ee75b8..cb21d84 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -24,7 +24,7 @@ from stgit.utils import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
 from stgit.gitmergeonefile import interactive_merge
-
+from stgit.lib import log
=20
 help =3D 'mark a file conflict as solved'
 usage =3D """%prog [options] [<files...>]
@@ -55,6 +55,7 @@ def func(parser, options, args):
=20
     if options.all and not options.interactive:
         resolved_all(options.reset)
+        log.log_entry(log.default_stack(), 'stg resolved')
         return
=20
     conflicts =3D git.get_conflicts()
@@ -82,3 +83,4 @@ def func(parser, options, args):
             git.resolved([filename])
     else:
         git.resolved(files, options.reset)
+    log.log_entry(log.default_stack(), 'stg resolved')
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 2167d87..f3a9ada 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -22,7 +22,7 @@ from optparse import OptionParser, make_option
 from stgit.commands.common import *
 from stgit.utils import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'send patches deeper down the stack'
 usage =3D """%prog [-t <target patch>] [-n] [<patches>]
@@ -68,3 +68,4 @@ def func(parser, options, args):
         def not_reapplied_yet(p):
             return not p in newapplied
         push_patches(crt_series, filter(not_reapplied_yet, oldapplied)=
)
+    log.log_entry(log.default_stack(), 'stg sink')
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 99ab7de..168199d 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -23,7 +23,7 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit.out import *
 from stgit import stack, git
-
+from stgit.lib import log
=20
 help =3D 'synchronise patches with a branch or a series'
 usage =3D """%prog [options] [<patch1>] [<patch2>] [<patch3>..<patch4>=
]
@@ -77,6 +77,7 @@ def func(parser, options, args):
         out.start('Undoing the sync of "%s"' % crt_series.get_current(=
))
         crt_series.undo_refresh()
         git.reset()
+        log.log_entry(log.default_stack(), 'stg sync --undo')
         out.done()
         return
=20
@@ -166,3 +167,5 @@ def func(parser, options, args):
     # push the remaining patches
     if popped:
         push_patches(crt_series, popped)
+
+    log.log_entry(log.default_stack(), 'stg sync')
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
new file mode 100644
index 0000000..1a9a326
--- /dev/null
+++ b/stgit/lib/log.py
@@ -0,0 +1,60 @@
+from stgit.lib import git, stack
+
+def patch_tree(repository, cd):
+    return repository.commit(git.Treedata({ 'a': cd.parent.data.tree,
+                                            'b': cd.tree }))
+
+def order_blob(repository, stack, kind):
+    return repository.commit(git.Blobdata(''.join(
+                '%s\n' % pn for pn in getattr(stack.patchorder, kind))=
))
+
+def log_entry_tree(repository, stack):
+    patches =3D repository.commit(
+        git.Treedata(dict((pn, patch_tree(repository,
+                                          stack.patches.get(pn).commit=
=2Edata))
+                          for pn in stack.patchorder.all)))
+    return repository.commit(git.Treedata({
+                'version': repository.commit(git.Blobdata('0')),
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
+    ref =3D log_ref(stack.name)
+    try:
+        last =3D [stack.repository.refs.get(ref)]
+    except KeyError:
+        last =3D []
+    commit =3D stack.repository.commit(
+        git.Commitdata(tree =3D log_entry_tree(stack.repository, stack=
),
+                       parents =3D last, message =3D msg))
+    stack.repository.refs.set(ref, commit, msg)
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
+
+def default_stack(branch =3D None):
+    repo =3D default_repo()
+    return repo.get_stack(branch or repo.current_branch)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 3613b15..0b0b52d 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,6 +1,6 @@
 from stgit import exception, utils
 from stgit.out import *
-from stgit.lib import git
+from stgit.lib import git, log
=20
 class TransactionException(exception.StgException):
     pass
@@ -117,6 +117,7 @@ class StackTransaction(object):
         _print_current_patch(self.__stack.patchorder.applied, self.__a=
pplied)
         self.__stack.patchorder.applied =3D self.__applied
         self.__stack.patchorder.unapplied =3D self.__unapplied
+        log.log_entry(self.__stack, self.__msg)
=20
         if self.__error:
             return utils.STGIT_CONFLICT
