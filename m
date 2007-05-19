From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Refactor message printing
Date: Sat, 19 May 2007 13:54:14 +0200
Message-ID: <20070519115334.1611.17371.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 13:58:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpNZY-0005vb-FQ
	for gcvg-git@gmane.org; Sat, 19 May 2007 13:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbXESL6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 07:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757846AbXESL6B
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 07:58:01 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:57924 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754621AbXESL56 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 07:57:58 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:49926 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HpNZJ-0005qd-5j; Sat, 19 May 2007 13:57:56 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HpNVm-0000Qn-OD; Sat, 19 May 2007 13:54:14 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HpNZJ-0005qd-5j.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HpNZJ-0005qd-5j 7c99c08a6393122a7a60b8167b8053aa
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47741>

=46eed all those little progress and status messages through a central
place where such things as newlines, indentation, and suppressing
output when not on a TTY can be taken care of once and for all.

This patch takes care of almost, but not quite, all output. The most
notable leftover is the printing of help messages.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/applied.py    |    4 +-
 stgit/commands/assimilate.py |    6 +--
 stgit/commands/branch.py     |   55 +++++++++++++--------------
 stgit/commands/clean.py      |    7 +--
 stgit/commands/commit.py     |    5 +-
 stgit/commands/common.py     |   48 ++++++++++--------------
 stgit/commands/delete.py     |    2 -
 stgit/commands/diff.py       |    2 -
 stgit/commands/export.py     |    8 ++--
 stgit/commands/files.py      |    6 +--
 stgit/commands/fold.py       |    7 +--
 stgit/commands/hide.py       |    2 -
 stgit/commands/id.py         |    2 -
 stgit/commands/imprt.py      |   10 +----
 stgit/commands/log.py        |    2 -
 stgit/commands/mail.py       |   14 +++----
 stgit/commands/patches.py    |    2 -
 stgit/commands/pick.py       |   31 +++++++--------
 stgit/commands/pull.py       |    4 +-
 stgit/commands/push.py       |    7 +--
 stgit/commands/refresh.py    |   14 +++----
 stgit/commands/rename.py     |    5 +-
 stgit/commands/series.py     |    8 ++--
 stgit/commands/sync.py       |   14 ++-----
 stgit/commands/top.py        |    2 -
 stgit/commands/unapplied.py  |    4 +-
 stgit/commands/uncommit.py   |    8 +---
 stgit/commands/unhide.py     |    2 -
 stgit/git.py                 |   18 ++++-----
 stgit/gitmergeonefile.py     |   45 ++++++++++------------
 stgit/main.py                |   15 +++----
 stgit/stack.py               |   36 +++++++++---------
 stgit/utils.py               |   85 ++++++++++++++++++++++++++++++++++=
+++++++-
 33 files changed, 259 insertions(+), 221 deletions(-)

diff --git a/stgit/commands/applied.py b/stgit/commands/applied.py
index f131d62..0925de0 100644
--- a/stgit/commands/applied.py
+++ b/stgit/commands/applied.py
@@ -47,7 +47,7 @@ def func(parser, options, args):
     applied =3D crt_series.get_applied()
=20
     if options.count:
-        print len(applied)
+        out.stdout(len(applied))
     else:
         for p in applied:
-            print p
+            out.stdout(p)
diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.p=
y
index a8b3bfe..e5ebb55 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/assimilate.py
@@ -42,7 +42,7 @@ def func(parser, options, args):
     """
=20
     def nothing_to_do():
-        print 'No commits to assimilate'
+        out.info('No commits to assimilate')
=20
     top_patch =3D crt_series.get_current_patch()
     if not top_patch:
@@ -79,8 +79,8 @@ def func(parser, options, args):
=20
     victims.reverse()
     for victim in victims:
-        print ('Creating patch "%s" from commit %s'
-               % (patch2name[victim], victim))
+        out.info('Creating patch "%s" from commit %s'
+                 % (patch2name[victim], victim))
         aname, amail, adate =3D name_email_date(victim.get_author())
         cname, cmail, cdate =3D name_email_date(victim.get_committer()=
)
         crt_series.new_patch(
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 5e7b0df..07bdca8 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -83,8 +83,8 @@ def __print_branch(branch_name, length):
         current =3D '>'
     if branch.get_protected():
         protected =3D 'p'
-    print current + ' ' + initialized + protected + '\t' + \
-          branch_name.ljust(length) + '  | ' + branch.get_description(=
)
+    out.stdout(current + ' ' + initialized + protected + '\t'
+               + branch_name.ljust(length) + '  | ' + branch.get_descr=
iption())
=20
 def __delete_branch(doomed_name, force =3D False):
     doomed =3D stack.Series(doomed_name)
@@ -92,8 +92,7 @@ def __delete_branch(doomed_name, force =3D False):
     if doomed.get_protected():
         raise CmdException, 'This branch is protected. Delete is not p=
ermitted'
=20
-    print 'Deleting branch "%s"...' % doomed_name,
-    sys.stdout.flush()
+    out.start('Deleting branch "%s"' % doomed_name)
=20
     if __is_current_branch(doomed_name):
         check_local_changes()
@@ -108,7 +107,7 @@ def __delete_branch(doomed_name, force =3D False):
     if doomed_name !=3D 'master':
         git.delete_branch(doomed_name)
=20
-    print 'done'
+    out.done()
=20
 def func(parser, options, args):
=20
@@ -127,17 +126,20 @@ def func(parser, options, args):
                 if git.rev_parse(args[1]) =3D=3D git.rev_parse('refs/h=
eads/' + args[1]):
                     # we are for sure referring to a branch
                     parentbranch =3D 'refs/heads/' + args[1]
-                    print 'Recording "%s" as parent branch.' % parentb=
ranch
+                    out.info('Recording "%s" as parent branch' % paren=
tbranch)
                 elif git.rev_parse(args[1]) and re.search('/', args[1]=
):
                     # FIXME: should the test be more strict ?
                     parentbranch =3D args[1]
                 else:
                     # Note: this includes refs to StGIT patches
-                    print 'Don\'t know how to determine parent branch =
from "%s".' % args[1]
+                    out.info('Don\'t know how to determine parent bran=
ch'
+                             ' from "%s"' % args[1])
                     parentbranch =3D None
             except git.GitException:
-                # should use a more specific exception to catch only n=
on-git refs ?
-                print 'Don\'t know how to determine parent branch from=
 "%s".' % args[1]
+                # should use a more specific exception to catch only
+                # non-git refs ?
+                out.info('Don\'t know how to determine parent branch'
+                         ' from "%s"' % args[1])
                 parentbranch =3D None
=20
             tree_id =3D git_id(args[1])
@@ -148,9 +150,10 @@ def func(parser, options, args):
         if parentbranch:
             parentremote =3D git.identify_remote(parentbranch)
             if parentremote:
-                print 'Using "%s" remote to pull parent from.' % paren=
tremote
+                out.info('Using remote "%s" to pull parent from'
+                         % parentremote)
             else:
-                print 'Recording as a local branch.'
+                out.info('Recording as a local branch')
         else:
             # no known parent branch, can't guess the remote
             parentremote =3D None
@@ -159,7 +162,7 @@ def func(parser, options, args):
                                    parent_remote =3D parentremote,
                                    parent_branch =3D parentbranch)
=20
-        print 'Branch "%s" created.' % args[0]
+        out.info('Branch "%s" created' % args[0])
         return
=20
     elif options.clone:
@@ -176,10 +179,9 @@ def func(parser, options, args):
         check_conflicts()
         check_head_top_equal()
=20
-        print 'Cloning current branch to "%s"...' % clone,
-        sys.stdout.flush()
+        out.start('Cloning current branch to "%s"' % clone)
         crt_series.clone(clone)
-        print 'done'
+        out.done()
=20
         return
=20
@@ -202,12 +204,12 @@ def func(parser, options, args):
         branches.sort()
=20
         if branches:
-            print 'Available branches:'
+            out.info('Available branches:')
             max_len =3D max([len(i) for i in branches])
             for i in branches:
                 __print_branch(i, max_len)
         else:
-            print 'No branches'
+            out.info('No branches')
         return
=20
     elif options.protect:
@@ -224,10 +226,9 @@ def func(parser, options, args):
             raise CmdException, 'Branch "%s" is not controlled by StGI=
T' \
                   % branch_name
=20
-        print 'Protecting branch "%s"...' % branch_name,
-        sys.stdout.flush()
+        out.start('Protecting branch "%s"' % branch_name)
         branch.protect()
-        print 'done'
+        out.done()
=20
         return
=20
@@ -241,7 +242,7 @@ def func(parser, options, args):
=20
         stack.Series(args[0]).rename(args[1])
=20
-        print 'Renamed branch "%s" as "%s".' % (args[0], args[1])
+        out.info('Renamed branch "%s" to "%s"' % (args[0], args[1]))
=20
         return
=20
@@ -259,10 +260,9 @@ def func(parser, options, args):
             raise CmdException, 'Branch "%s" is not controlled by StGI=
T' \
                   % branch_name
=20
-        print 'Unprotecting branch "%s"...' % branch_name,
-        sys.stdout.flush()
+        out.info('Unprotecting branch "%s"' % branch_name)
         branch.unprotect()
-        print 'done'
+        out.done()
=20
         return
=20
@@ -294,12 +294,9 @@ def func(parser, options, args):
         check_conflicts()
         check_head_top_equal()
=20
-        print 'Switching to branch "%s"...' % args[0],
-        sys.stdout.flush()
-
+        out.start('Switching to branch "%s"' % args[0])
         git.switch_branch(args[0])
-
-        print 'done'
+        out.done()
         return
=20
     # default action: print the current branch
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 8f5c606..7b57526 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -43,14 +43,11 @@ def __delete_empty(patches, applied):
     """
     for p in patches:
         if crt_series.empty_patch(p):
-            print 'Deleting patch "%s"...' % p,
-            sys.stdout.flush()
-
+            out.start('Deleting patch "%s"' % p)
             if applied and crt_series.patch_applied(p):
                 crt_series.pop_patch(p)
             crt_series.delete_patch(p)
-
-            print 'done'
+            out.done()
         elif applied and crt_series.patch_unapplied(p):
             crt_series.push_patch(p)
=20
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 8af6651..2b8d7ce 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -54,8 +54,7 @@ def func(parser, options, args):
=20
     crt_head =3D git.get_head()
=20
-    print 'Committing %d patches...' % len(applied),
-    sys.stdout.flush()
+    out.start('Committing %d patches' % len(applied))
=20
     crt_series.pop_patch(applied[0])
     git.switch(crt_head)
@@ -63,4 +62,4 @@ def func(parser, options, args):
     for patch in applied:
         crt_series.delete_patch(patch)
=20
-    print 'done'
+    out.done()
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 28026da..22c78ae 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -131,9 +131,9 @@ def print_crt_patch(branch =3D None):
         patch =3D stack.Series(branch).get_current()
=20
     if patch:
-        print 'Now at patch "%s"' % patch
+        out.info('Now at patch "%s"' % patch)
     else:
-        print 'No patches applied'
+        out.info('No patches applied')
=20
 def resolved(filename, reset =3D None):
     if reset:
@@ -163,58 +163,53 @@ def push_patches(patches, check_merged =3D False)=
:
     """
     forwarded =3D crt_series.forward_patches(patches)
     if forwarded > 1:
-        print 'Fast-forwarded patches "%s" - "%s"' % (patches[0],
-                                                      patches[forwarde=
d - 1])
+        out.info('Fast-forwarded patches "%s" - "%s"'
+                 % (patches[0], patches[forwarded - 1]))
     elif forwarded =3D=3D 1:
-        print 'Fast-forwarded patch "%s"' % patches[0]
+        out.info('Fast-forwarded patch "%s"' % patches[0])
=20
     names =3D patches[forwarded:]
=20
     # check for patches merged upstream
     if names and check_merged:
-        print 'Checking for patches merged upstream...',
-        sys.stdout.flush()
+        out.start('Checking for patches merged upstream')
=20
         merged =3D crt_series.merged_patches(names)
=20
-        print 'done (%d found)' % len(merged)
+        out.done('%d found' % len(merged))
     else:
         merged =3D []
=20
     for p in names:
-        print 'Pushing patch "%s"...' % p,
-        sys.stdout.flush()
+        out.start('Pushing patch "%s"' % p)
=20
         if p in merged:
             crt_series.push_patch(p, empty =3D True)
-            print 'done (merged upstream)'
+            out.done('merged upstream')
         else:
             modified =3D crt_series.push_patch(p)
=20
             if crt_series.empty_patch(p):
-                print 'done (empty patch)'
+                out.done('empty patch')
             elif modified:
-                print 'done (modified)'
+                out.done('modified')
             else:
-                print 'done'
+                out.done()
=20
 def pop_patches(patches, keep =3D False):
     """Pop the patches in the list from the stack. It is assumed that
     the patches are listed in the stack reverse order.
     """
     if len(patches) =3D=3D 0:
-        print 'nothing to push/pop'
+        out.info('Nothing to push/pop')
     else:
         p =3D patches[-1]
         if len(patches) =3D=3D 1:
-            print 'Popping patch "%s"...' % p,
+            out.start('Popping patch "%s"' % p)
         else:
-            print 'Popping "%s" - "%s" patches...' % (patches[0], p),
-        sys.stdout.flush()
-
+            out.start('Popping patches "%s" - "%s"' % (patches[0], p))
         crt_series.pop_patch(p, keep)
-
-        print 'done'
+        out.done()
=20
 def parse_patches(patch_args, patch_list, boundary =3D 0, ordered =3D =
=46alse):
     """Parse patch_args list for patch names in patch_list and return
@@ -334,19 +329,18 @@ def prepare_rebase(real_rebase, force=3DNone):
     # pop all patches
     applied =3D crt_series.get_applied()
     if len(applied) > 0:
-        print 'Popping all applied patches...',
-        sys.stdout.flush()
+        out.start('Popping all applied patches')
         crt_series.pop_patch(applied[0])
-        print 'done'
+        out.done()
     return applied
=20
 def rebase(target):
     if target =3D=3D git.get_head():
-        print 'Already at "%s", no need for rebasing.' % target
+        out.info('Already at "%s", no need for rebasing.' % target)
         return
-   =20
-    print 'Rebasing to "%s"...' % target
+    out.start('Rebasing to "%s"' % target)
     git.reset(tree_id =3D git_id(target))
+    out.done()
=20
 def post_rebase(applied, nopush, merged):
     # memorize that we rebased to here
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index e1a70c9..a9e2744 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -74,7 +74,7 @@ def func(parser, options, args):
     # delete the patches
     for patch in applied + patches:
         crt_series.delete_patch(patch)
-        print 'Patch "%s" successfully deleted' % patch
+        out.info('Patch "%s" successfully deleted' % patch)
=20
     if not options.branch:
         print_crt_patch()
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index d3e1190..f56cbeb 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -80,7 +80,7 @@ def func(parser, options, args):
         rev2 =3D None
=20
     if options.stat:
-        print git.diffstat(args, git_id(rev1), git_id(rev2))
+        out.stdout_raw(git.diffstat(args, git_id(rev1), git_id(rev2)) =
+ '\n')
     else:
         diff_str =3D git.diff(args, git_id(rev1), git_id(rev2),
                             binary =3D options.binary)
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 20d8f67..cafcbe3 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -79,8 +79,8 @@ def func(parser, options, args):
         dirname =3D 'patches-%s' % crt_series.get_branch()
=20
     if not options.branch and git.local_changes():
-        print 'Warning: local changes in the tree. ' \
-              'You might want to commit them first'
+        out.warn('Local changes in the tree;'
+                 ' you might want to commit them first')
=20
     if not options.stdout:
         if not os.path.isdir(dirname):
@@ -166,9 +166,9 @@ def func(parser, options, args):
             f =3D open(pfile, 'w+')
=20
         if options.stdout and num > 1:
-            print '---------------------------------------------------=
----------------------------'
+            print '-'*79
             print patch.get_name()
-            print '---------------------------------------------------=
----------------------------'
+            print '-'*79
=20
         # write description
         f.write(descr)
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index b33bd2a..59893d8 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -57,8 +57,8 @@ def func(parser, options, args):
     rev2 =3D git_id('%s//top' % patch)
=20
     if options.stat:
-        print git.diffstat(rev1 =3D rev1, rev2 =3D rev2)
+        out.stdout_raw(git.diffstat(rev1 =3D rev1, rev2 =3D rev2) + '\=
n')
     elif options.bare:
-        print git.barefiles(rev1, rev2)
+        out.stdout_raw(git.barefiles(rev1, rev2) + '\n')
     else:
-        print git.files(rev1, rev2)
+        out.stdout_raw(git.files(rev1, rev2) + '\n')
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index e87ded2..297dfbf 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -61,12 +61,11 @@ def func(parser, options, args):
=20
     if filename:
         if os.path.exists(filename):
-            print 'Folding patch "%s"...' % filename,
+            out.start('Folding patch "%s"' % filename)
         else:
             raise CmdException, 'No such file: %s' % filename
     else:
-        print 'Folding patch from stdin...',
-    sys.stdout.flush()
+        out.start('Folding patch from stdin')
=20
     if options.threeway:
         crt_patch =3D crt_series.get_patch(current)
@@ -77,4 +76,4 @@ def func(parser, options, args):
     else:
         git.apply_patch(filename =3D filename)
=20
-    print 'done'
+    out.done()
diff --git a/stgit/commands/hide.py b/stgit/commands/hide.py
index 9ef948d..3cb08e8 100644
--- a/stgit/commands/hide.py
+++ b/stgit/commands/hide.py
@@ -46,4 +46,4 @@ def func(parser, options, args):
=20
     for patch in patches:
         crt_series.hide_patch(patch)
-        print 'Patch "%s" hidden' % patch
+        out.info('Patch "%s" hidden' % patch)
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 4226adf..8c717e8 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -46,4 +46,4 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
=20
-    print git_id(id_str)
+    out.stdout(git_id(id_str))
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 6fcdc62..0089a8b 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -255,7 +255,7 @@ def __create_patch(filename, message, author_name, =
author_email,
         raise CmdException, 'No diff found inside the patch'
=20
     if options.ignore and patch in crt_series.get_applied():
-        print 'Ignoring already applied patch "%s"' % patch
+        out.info('Ignoring already applied patch "%s"' % patch)
         return
     if options.replace and patch in crt_series.get_unapplied():
         crt_series.delete_patch(patch)
@@ -289,18 +289,14 @@ def __create_patch(filename, message, author_name=
, author_email,
                          committer_name =3D committer_name,
                          committer_email =3D committer_email)
=20
-    print 'Importing patch "%s"...' % patch,
-    sys.stdout.flush()
-
+    out.start('Importing patch "%s"' % patch)
     if options.base:
         git.apply_patch(diff =3D diff, base =3D git_id(options.base))
     else:
         git.apply_patch(diff =3D diff)
-
     crt_series.refresh_patch(edit =3D options.edit,
                              show_patch =3D options.showpatch)
-
-    print 'done'   =20
+    out.done()
=20
 def __import_file(filename, options, patch =3D None):
     """Import a patch from a file or standard input
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index a21789e..e3e17f9 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -70,7 +70,7 @@ def show_log(log, show_patch):
             secs, tz =3D author_date.split()
             date =3D '%s %s' % (time.ctime(int(secs)), tz)
=20
-            print descr, date
+            out.stdout('%s %s' % (descr, date))
=20
         parent =3D commit.get_parent()
         if parent:
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 2fcaa5f..1ca6ba2 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -500,13 +500,12 @@ def func(parser, options, args):
             ref_id =3D msg_id
=20
         if options.mbox:
-            print msg_string
+            out.stdout_raw(msg_string + '\n')
         else:
-            print 'Sending the cover message...',
-            sys.stdout.flush()
+            out.start('Sending the cover message')
             __send_message(smtpserver, from_addr, to_addr_list, msg_st=
ring,
                            sleep, smtpuser, smtppassword)
-            print 'done'
+            out.done()
=20
     # send the patches
     if options.template:
@@ -529,10 +528,9 @@ def func(parser, options, args):
             ref_id =3D msg_id
=20
         if options.mbox:
-            print msg_string
+            out.stdout_raw(msg_string + '\n')
         else:
-            print 'Sending patch "%s"...' % p,
-            sys.stdout.flush()
+            out.start('Sending patch "%s"' % p)
             __send_message(smtpserver, from_addr, to_addr_list, msg_st=
ring,
                            sleep, smtpuser, smtppassword)
-            print 'done'
+            out.done()
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index dcfbd98..a8fb008 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -75,7 +75,7 @@ def func(parser, options, args):
                                   git.diff(args, patch.get_bottom(),
                                            patch.get_top()))
             else:
-                print patch.get_name()
+                out.stdout(patch.get_name())
=20
     if options.diff:
         pager(diff_output)
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index ea0756b..a47b201 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -91,33 +91,30 @@ def func(parser, options, args):
         top =3D parent
=20
     if options.fold:
-        print 'Folding commit %s...' % commit_id,
-        sys.stdout.flush()
+        out.start('Folding commit %s' % commit_id)
=20
         # try a direct git-apply first
         if not git.apply_diff(bottom, top):
             git.merge(bottom, git.get_head(), top, recursive =3D True)
=20
-        print 'done'
+        out.done()
     elif options.update:
         rev1 =3D git_id('//bottom')
         rev2 =3D git_id('//top')
         files =3D git.barefiles(rev1, rev2).split('\n')
=20
-        print 'Updating with commit %s...' % commit_id,
-        sys.stdout.flush()
+        out.start('Updating with commit %s' % commit_id)
=20
         if not git.apply_diff(bottom, top, files =3D files):
             raise CmdException, 'Patch updating failed'
=20
-        print 'done'
+        out.done()
     else:
         message =3D commit.get_log()
         author_name, author_email, author_date =3D \
                      name_email_date(commit.get_author())
=20
-        print 'Importing commit %s...' % commit_id,
-        sys.stdout.flush()
+        out.start('Importing commit %s' % commit_id)
=20
         newpatch =3D crt_series.new_patch(patchname, message =3D messa=
ge, can_edit =3D False,
                                         unapplied =3D True, bottom =3D=
 bottom, top =3D top,
@@ -137,23 +134,23 @@ def func(parser, options, args):
                 refseries =3D crt_series
             patch =3D refseries.get_patch(refpatchname)
             if patch.get_log():
-                print"log was %s" % newpatch.get_log()
-                print "setting log to %s\n" %  patch.get_log()
+                out.info("Log was %s" % newpatch.get_log())
+                out.info("Setting log to %s\n" %  patch.get_log())
                 newpatch.set_log(patch.get_log())
-                print"log is now %s" % newpatch.get_log()
+                out.info("Log is now %s" % newpatch.get_log())
             else:
-                print "no log for %s\n" % patchname
-=20
+                out.info("No log for %s\n" % patchname)
+
         if not options.unapplied:
             modified =3D crt_series.push_patch(patchname)
         else:
             modified =3D False
=20
         if crt_series.empty_patch(patchname):
-            print 'done (empty patch)'
+            out.done('empty patch')
         elif modified:
-            print 'done (modified)'
+            out.done('modified')
         else:
-            print 'done'
-       =20
+            out.done()
+
     print_crt_patch()
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index f551b98..beaa7b5 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -90,10 +90,10 @@ def func(parser, options, args):
=20
     # pull the remote changes
     if policy =3D=3D 'pull':
-        print 'Pulling from "%s"...' % repository
+        out.info('Pulling from "%s"' % repository)
         git.pull(repository)
     elif policy =3D=3D 'fetch-rebase':
-        print 'Fetching from "%s"...' % repository
+        out.info('Fetching from "%s"' % repository)
         git.fetch(repository)
         rebase(git.fetch_head())
     elif policy =3D=3D 'rebase':
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index a636ad2..17b32f6 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -64,13 +64,12 @@ def func(parser, options, args):
         if not patch:
             raise CmdException, 'No patch to undo'
=20
-        print 'Undoing the "%s" push...' % patch,
-        sys.stdout.flush()
+        out.start('Undoing push of "%s"' % patch)
         resolved_all()
         if crt_series.undo_push():
-            print 'done'
+            out.done()
         else:
-            print 'done (patch unchanged)'
+            out.done('patch unchanged')
         print_crt_patch()
=20
         return
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 4cf09ae..77dcbda 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -98,10 +98,9 @@ def func(parser, options, args):
         check_head_top_equal()
=20
     if options.undo:
-        print 'Undoing the "%s" refresh...' % patch,
-        sys.stdout.flush()
+        out.start('Undoing the refresh of "%s"' % patch)
         crt_series.undo_refresh()
-        print 'done'
+        out.done()
         return
=20
     if options.author:
@@ -128,8 +127,7 @@ def func(parser, options, args):
             between =3D applied[:applied.index(patch):-1]
             pop_patches(between, keep =3D True)
=20
-        print 'Refreshing patch "%s"...' % patch,
-        sys.stdout.flush()
+        out.start('Refreshing patch "%s"' % patch)
=20
         if autoresolved =3D=3D 'yes':
             resolved_all()
@@ -145,12 +143,12 @@ def func(parser, options, args):
                                  backup =3D True, sign_str =3D sign_st=
r)
=20
         if crt_series.empty_patch(patch):
-            print 'done (empty patch)'
+            out.done('empty patch')
         else:
-            print 'done'
+            out.done()
=20
         if options.patch:
             between.reverse()
             push_patches(between)
     else:
-        print 'Patch "%s" is already up to date' % patch
+        out.info('Patch "%s" is already up to date' % patch)
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index ca799c3..d6c53be 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -38,7 +38,6 @@ def func(parser, options, args):
     if len(args) !=3D 2:
         parser.error('incorrect number of arguments')
=20
-    print 'Renaming patch "%s" -> "%s"...' % (args[0], args[1]),
-    sys.stdout.flush()
+    out.start('Renaming patch "%s" to "%s"' % (args[0], args[1]))
     crt_series.rename_patch(args[0], args[1])
-    print 'done'
+    out.done()
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 7777201..b699902 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -102,11 +102,11 @@ def __print_patch(patch, hidden, branch_str, pref=
ix, empty_prefix, length,
         patch_str =3D patch_str.ljust(length)
=20
     if options.description:
-        print prefix + patch_str + ' | ' + __get_description(patch)
+        out.stdout(prefix + patch_str + ' | ' + __get_description(patc=
h))
     elif options.author:
-        print prefix + patch_str + ' | ' + __get_author(patch)
+        out.stdout(prefix + patch_str + ' | ' + __get_author(patch))
     else:
-        print prefix + patch_str
+        out.stdout(prefix + patch_str)
=20
 def func(parser, options, args):
     """Show the patch series
@@ -157,7 +157,7 @@ def func(parser, options, args):
     patches =3D applied + unapplied
=20
     if options.count:
-        print len(patches)
+        out.stdout(len(patches))
         return
=20
     if not patches:
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index db52bcd..8359061 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -74,13 +74,10 @@ def func(parser, options, args):
                   '--undo cannot be specified with --branch or --serie=
s'
         __check_all()
=20
-        print 'Undoing the "%s" sync...' % crt_series.get_current(),
-        sys.stdout.flush()
-
+        out.start('Undoing the sync of "%s"' % crt_series.get_current(=
))
         crt_series.undo_refresh()
         git.reset()
-
-        print 'done'
+        out.done()
         return
=20
     if options.branch:
@@ -147,8 +144,7 @@ def func(parser, options, args):
             del popped[:idx]
=20
         # the actual sync
-        print 'Synchronising "%s"...' % p,
-        sys.stdout.flush()
+        out.start('Synchronising "%s"' % p)
=20
         patch =3D crt_series.get_patch(p)
         bottom =3D patch.get_bottom()
@@ -167,9 +163,9 @@ def func(parser, options, args):
             # backup information was already reset above
             crt_series.refresh_patch(cache_update =3D False, backup =3D=
 False,
                                      log =3D 'sync')
-            print 'done (updated)'
+            out.done('updated')
         else:
-            print 'done'
+            out.done()
=20
     # push the remaining patches
     if popped:
diff --git a/stgit/commands/top.py b/stgit/commands/top.py
index f36a0b0..7cc92ca 100644
--- a/stgit/commands/top.py
+++ b/stgit/commands/top.py
@@ -41,6 +41,6 @@ def func(parser, options, args):
=20
     name =3D crt_series.get_current()
     if name:
-        print name
+        out.stdout(name)
     else:
         raise CmdException, 'No patches applied'
diff --git a/stgit/commands/unapplied.py b/stgit/commands/unapplied.py
index cbac052..0d330a1 100644
--- a/stgit/commands/unapplied.py
+++ b/stgit/commands/unapplied.py
@@ -46,7 +46,7 @@ def func(parser, options, args):
     unapplied =3D crt_series.get_unapplied()
=20
     if options.count:
-        print len(unapplied)
+        out.stdout(len(unapplied))
     else:
         for p in unapplied:
-            print p
+            out.stdout(p)
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index d5f64da..f611d29 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -99,13 +99,13 @@ def func(parser, options, args):
     commits =3D []
     next_commit =3D crt_series.get_base()
     if patch_nr:
-        print 'Uncommitting %d patches...' % patch_nr,
+        out.start('Uncommitting %d patches' % patch_nr)
         for i in xrange(patch_nr):
             commit, commit_id, parent =3D get_commit(next_commit)
             commits.append((commit, commit_id, parent))
             next_commit =3D parent
     else:
-        print 'Uncommitting to %s...' % to_commit
+        out.start('Uncommitting to %s' % to_commit)
         while True:
             commit, commit_id, parent =3D get_commit(next_commit)
             commits.append((commit, commit_id, parent))
@@ -114,7 +114,6 @@ def func(parser, options, args):
             next_commit =3D parent
         patch_nr =3D len(commits)
=20
-    sys.stdout.flush()
     for (commit, commit_id, parent), patchname in \
         zip(commits, patchnames or [None for i in xrange(len(commits))=
]):
         author_name, author_email, author_date =3D \
@@ -127,5 +126,4 @@ def func(parser, options, args):
                              author_email =3D author_email,
                              author_date =3D author_date)
=20
-
-    print 'done'
+    out.done()
diff --git a/stgit/commands/unhide.py b/stgit/commands/unhide.py
index f2db05f..74e4743 100644
--- a/stgit/commands/unhide.py
+++ b/stgit/commands/unhide.py
@@ -46,4 +46,4 @@ def func(parser, options, args):
=20
     for patch in patches:
         crt_series.unhide_patch(patch)
-        print 'Patch "%s" unhidden' % patch
+        out.info('Patch "%s" unhidden' % patch)
diff --git a/stgit/git.py b/stgit/git.py
index 86630ce..845c712 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -220,9 +220,8 @@ def __tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
                   noexclude =3D True, verbose =3D False):
     """Returns a list of pairs - [status, filename]
     """
-    if verbose and sys.stdout.isatty():
-        print 'Checking for changes in the working directory...',
-        sys.stdout.flush()
+    if verbose:
+        out.start('Checking for changes in the working directory')
=20
     refresh_index()
=20
@@ -260,8 +259,8 @@ def __tree_status(files =3D None, tree_id =3D 'HEAD=
', unknown =3D False,
         if fs[1] not in conflicts:
             cache_files.append(fs)
=20
-    if verbose and sys.stdout.isatty():
-        print 'done'
+    if verbose:
+        out.done()
=20
     return cache_files
=20
@@ -449,8 +448,7 @@ def __copy_single(source, target, target2=3D''):
         for f in [f.strip() for f in realfiles]:
             m =3D prefix_regexp.match(f)
             if not m:
-                print '"%s" does not match "%s"' % (f, re_string)
-                assert(m)
+                raise Exception, '"%s" does not match "%s"' % (f, re_s=
tring)
             newname =3D target+target2+'/'+m.group(1)
             if not os.path.exists(os.path.dirname(newname)):
                 os.makedirs(os.path.dirname(newname))
@@ -767,9 +765,9 @@ def status(files =3D None, modified =3D False, new =
=3D False, deleted =3D False,
         if files and not fs[1] in files:
             continue
         if all:
-            print '%s %s' % (fs[0], fs[1])
+            out.stdout('%s %s' % (fs[0], fs[1]))
         else:
-            print '%s' % fs[1]
+            out.stdout('%s' % fs[1])
=20
 def diff(files =3D None, rev1 =3D 'HEAD', rev2 =3D None, out_fd =3D No=
ne,
          binary =3D False):
@@ -958,7 +956,7 @@ def apply_patch(filename =3D None, diff =3D None, b=
ase =3D None,
             f =3D file('.stgit-failed.patch', 'w+')
             f.write(diff)
             f.close()
-            print >> sys.stderr, 'Diff written to the .stgit-failed.pa=
tch file'
+            out.warn('Diff written to the .stgit-failed.patch file')
=20
         raise
=20
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
index 6f4c1d7..303e5f7 100644
--- a/stgit/gitmergeonefile.py
+++ b/stgit/gitmergeonefile.py
@@ -21,7 +21,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston,=
 MA 02111-1307 USA
 import sys, os
 from stgit import basedir
 from stgit.config import config, file_extensions, ConfigOption
-from stgit.utils import append_string
+from stgit.utils import append_string, out
=20
=20
 class GitMergeException(Exception):
@@ -133,8 +133,8 @@ def interactive_merge(filename):
=20
     mtime =3D os.path.getmtime(filename)
=20
-    print 'Trying the interractive %s merge' % \
-          (three_way and 'three-way' or 'two-way')
+    out.info('Trying the interactive %s merge'
+             % (three_way and 'three-way' or 'two-way'))
=20
     err =3D os.system(imerger % files_dict)
     if err !=3D 0:
@@ -165,16 +165,15 @@ def merge(orig_hash, file1_hash, file2_hash,
             if file1_hash =3D=3D file2_hash:
                 if os.system('git-update-index --cacheinfo %s %s %s'
                              % (file1_mode, file1_hash, path)) !=3D 0:
-                    print >> sys.stderr, 'Error: git-update-index fail=
ed'
+                    out.error('git-update-index failed')
                     __conflict(path)
                     return 1
                 if os.system('git-checkout-index -u -f -- %s' % path):
-                    print >> sys.stderr, 'Error: git-checkout-index fa=
iled'
+                    out.error('git-checkout-index failed')
                     __conflict(path)
                     return 1
                 if file1_mode !=3D file2_mode:
-                    print >> sys.stderr, \
-                          'Error: File added in both, permissions conf=
lict'
+                    out.error('File added in both, permissions conflic=
t')
                     __conflict(path)
                     return 1
             # 3-way merge
@@ -189,9 +188,8 @@ def merge(orig_hash, file1_hash, file2_hash,
                     __remove_files(orig_hash, file1_hash, file2_hash)
                     return 0
                 else:
-                    print >> sys.stderr, \
-                          'Error: three-way merge tool failed for file=
 "%s"' \
-                          % path
+                    out.error('Three-way merge tool failed for file "%=
s"'
+                              % path)
                     # reset the cache to the first branch
                     os.system('git-update-index --cacheinfo %s %s %s'
                               % (file1_mode, file1_hash, path))
@@ -201,7 +199,7 @@ def merge(orig_hash, file1_hash, file2_hash,
                             interactive_merge(path)
                         except GitMergeException, ex:
                             # interactive merge failed
-                            print >> sys.stderr, str(ex)
+                            out.error(ex)
                             if str(keeporig) !=3D 'yes':
                                 __remove_files(orig_hash, file1_hash,
                                                file2_hash)
@@ -260,23 +258,21 @@ def merge(orig_hash, file1_hash, file2_hash,
             if file1_hash =3D=3D file2_hash:
                 if os.system('git-update-index --add --cacheinfo %s %s=
 %s'
                              % (file1_mode, file1_hash, path)) !=3D 0:
-                    print >> sys.stderr, 'Error: git-update-index fail=
ed'
+                    out.error('git-update-index failed')
                     __conflict(path)
                     return 1
                 if os.system('git-checkout-index -u -f -- %s' % path):
-                    print >> sys.stderr, 'Error: git-checkout-index fa=
iled'
+                    out.error('git-checkout-index failed')
                     __conflict(path)
                     return 1
                 if file1_mode !=3D file2_mode:
-                    print >> sys.stderr, \
-                          'Error: File "s" added in both, ' \
-                          'permissions conflict' % path
+                    out.error('File "s" added in both, permissions con=
flict'
+                              % path)
                     __conflict(path)
                     return 1
             # files added in both but different
             else:
-                print >> sys.stderr, \
-                      'Error: File "%s" added in branches but differen=
t' % path
+                out.error('File "%s" added in branches but different' =
% path)
                 # reset the cache to the first branch
                 os.system('git-update-index --cacheinfo %s %s %s'
                           % (file1_mode, file1_hash, path))
@@ -286,7 +282,7 @@ def merge(orig_hash, file1_hash, file2_hash,
                         interactive_merge(path)
                     except GitMergeException, ex:
                         # interactive merge failed
-                        print >> sys.stderr, str(ex)
+                        out.error(ex)
                         if str(keeporig) !=3D 'yes':
                             __remove_files(orig_hash, file1_hash,
                                            file2_hash)
@@ -312,17 +308,16 @@ def merge(orig_hash, file1_hash, file2_hash,
                 obj =3D file2_hash
             if os.system('git-update-index --add --cacheinfo %s %s %s'
                          % (mode, obj, path)) !=3D 0:
-                print >> sys.stderr, 'Error: git-update-index failed'
+                out.error('git-update-index failed')
                 __conflict(path)
                 return 1
             __remove_files(orig_hash, file1_hash, file2_hash)
             return os.system('git-checkout-index -u -f -- %s' % path)
=20
     # Unhandled case
-    print >> sys.stderr, 'Error: Unhandled merge conflict: ' \
-          '"%s" "%s" "%s" "%s" "%s" "%s" "%s"' \
-          % (orig_hash, file1_hash, file2_hash,
-             path,
-             orig_mode, file1_mode, file2_mode)
+    out.error('Unhandled merge conflict: "%s" "%s" "%s" "%s" "%s" "%s"=
 "%s"'
+              % (orig_hash, file1_hash, file2_hash,
+                 path,
+                 orig_mode, file1_mode, file2_mode))
     __conflict(path)
     return 1
diff --git a/stgit/main.py b/stgit/main.py
index 1a1f534..bcadbad 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -36,14 +36,12 @@ class Commands(dict):
         candidates =3D [cmd for cmd in self.keys() if cmd.startswith(k=
ey)]
=20
         if not candidates:
-            print >> sys.stderr, 'Unknown command: %s' % key
-            print >> sys.stderr, '  Try "%s help" for a list of ' \
-                  'supported commands' % prog
+            out.error('Unknown command: %s' % key,
+                      'Try "%s help" for a list of supported commands'=
 % prog)
             sys.exit(1)
         elif len(candidates) > 1:
-            print >> sys.stderr, 'Ambiguous command: %s' % key
-            print >> sys.stderr, '  Candidates are: %s' \
-                  % ', '.join(candidates)
+            out.error('Ambiguous command: %s' % key,
+                      'Candidates are: %s' % ', '.join(candidates))
             sys.exit(1)
=20
         return candidates[0]
@@ -220,8 +218,7 @@ def main():
         if len(sys.argv) =3D=3D 3 and not sys.argv[2] in ['-h', '--hel=
p']:
             cmd =3D commands.canonical_cmd(sys.argv[2])
             if not cmd in commands:
-                print >> sys.stderr, '%s help: "%s" command unknown' \
-                      % (prog, cmd)
+                out.error('%s help: "%s" command unknown' % (prog, cmd=
))
                 sys.exit(1)
=20
             sys.argv[0] +=3D ' %s' % cmd
@@ -267,7 +264,7 @@ def main():
     except KeyError:
         debug_level =3D 0
     except ValueError:
-        print >> sys.stderr, 'Invalid STGIT_DEBUG_LEVEL environment va=
riable'
+        out.error('Invalid STGIT_DEBUG_LEVEL environment variable')
         sys.exit(1)
=20
     try:
diff --git a/stgit/stack.py b/stgit/stack.py
index 223f3ee..63076af 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -307,6 +307,7 @@ def update_to_current_format_version(branch, git_di=
r):
             # The branch doesn't seem to be initialized at all.
             return None
     def set_format_version(v):
+        out.info('Upgraded branch %s to format version %d' % (branch, =
v))
         config.set(format_version_key(branch), '%d' % v)
     def mkdir(d):
         if not os.path.isdir(d):
@@ -491,10 +492,11 @@ class Series(StgitObject):
         if value:
             return value
         elif 'origin' in git.remotes_list():
-            print 'Notice: no parent remote declared for stack "%s", '=
 \
-                  'defaulting to "origin". Consider setting "branch.%s=
=2Eremote" ' \
-                  'and "branch.%s.merge" with "git repo-config".' \
-                  % (self.__name, self.__name, self.__name)
+            out.note(('No parent remote declared for stack "%s",'
+                      ' defaulting to "origin".' % self.__name),
+                     ('Consider setting "branch.%s.remote" and'
+                      ' "branch.%s.merge" with "git repo-config".'
+                      % (self.__name, self.__name)))
             return 'origin'
         else:
             raise StackException, 'Cannot find a parent remote for "%s=
"' % self.__name
@@ -507,10 +509,10 @@ class Series(StgitObject):
         if value:
             return value
         elif git.rev_parse('heads/origin'):
-            print 'Notice: no parent branch declared for stack "%s", '=
 \
-                  'defaulting to "heads/origin". Consider setting ' \
-                  '"branch.%s.stgit.parentbranch" with "git repo-confi=
g".' \
-                  % (self.__name, self.__name)
+            out.note(('No parent branch declared for stack "%s",'
+                      ' defaulting to "heads/origin".' % self.__name),
+                     ('Consider setting "branch.%s.stgit.parentbranch"=
'
+                      ' with "git repo-config".' % self.__name))
             return 'heads/origin'
         else:
             raise StackException, 'Cannot find a parent branch for "%s=
"' % self.__name
@@ -646,10 +648,10 @@ class Series(StgitObject):
                                             author_email =3D patch.get=
_authemail(),
                                             author_date =3D patch.get_=
authdate())
             if patch.get_log():
-                print "setting log to %s" %  patch.get_log()
+                out.info('Setting log to %s' %  patch.get_log())
                 newpatch.set_log(patch.get_log())
             else:
-                print "no log for %s" % p
+                out.info('No log for %s' % p)
=20
         # fast forward the cloned series to self's top
         new_series.forward_patches(applied)
@@ -697,17 +699,18 @@ class Series(StgitObject):
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
             else:
-                print 'Patch directory %s is not empty.' % self.__patc=
h_dir
+                out.warn('Patch directory %s is not empty' % self.__pa=
tch_dir)
=20
             try:
                 os.removedirs(self._dir())
             except OSError:
-                raise StackException, 'Series directory %s is not empt=
y.' % self._dir()
+                raise StackException('Series directory %s is not empty=
'
+                                     % self._dir())
=20
             try:
                 os.removedirs(self.__refs_dir)
             except OSError:
-                print 'Refs directory %s is not empty.' % self.__refs_=
dir
+                out.warn('Refs directory %s is not empty' % self.__ref=
s_dir)
=20
         # Cleanup parent informations
         # FIXME: should one day make use of git-config --section-remov=
e,
@@ -1046,10 +1049,9 @@ class Series(StgitObject):
                 try:
                     git.merge(bottom, head, top, recursive =3D True)
                 except git.GitException, ex:
-                    print >> sys.stderr, \
-                          'The merge failed during "push". ' \
-                          'Use "refresh" after fixing the conflicts or=
 ' \
-                          'revert the operation with "push --undo".'
+                    out.error('The merge failed during "push".',
+                              'Use "refresh" after fixing the conflict=
s or'
+                              ' revert the operation with "push --undo=
".')
=20
         append_string(self.__applied_file, name)
=20
diff --git a/stgit/utils.py b/stgit/utils.py
index fbfe748..8df9103 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -21,6 +21,86 @@ along with this program; if not, write to the Free S=
oftware
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
+class MessagePrinter(object):
+    def __init__(self):
+        class Output(object):
+            def __init__(self, write, flush):
+                self.write =3D write
+                self.flush =3D flush
+                self.at_start_of_line =3D True
+                self.level =3D 0
+            def new_line(self):
+                """Ensure that we're at the beginning of a line."""
+                if not self.at_start_of_line:
+                    self.write('\n')
+                    self.at_start_of_line =3D True
+            def single_line(self, msg, print_newline =3D True,
+                            need_newline =3D True):
+                """Write a single line. Newline before and after are
+                separately configurable."""
+                if need_newline:
+                    self.new_line()
+                if self.at_start_of_line:
+                    self.write('  '*self.level)
+                self.write(msg)
+                if print_newline:
+                    self.write('\n')
+                    self.at_start_of_line =3D True
+                else:
+                    self.flush()
+                    self.at_start_of_line =3D False
+            def tagged_lines(self, tag, lines):
+                tag +=3D ': '
+                for line in lines:
+                    self.single_line(tag + line)
+                    tag =3D ' '*len(tag)
+            def write_line(self, line):
+                """Write one line of text on a lines of its own, not
+                indented."""
+                self.new_line()
+                self.write('%s\n' % line)
+                self.at_start_of_line =3D True
+            def write_raw(self, string):
+                """Write an arbitrary string, possibly containing
+                newlines."""
+                self.new_line()
+                self.write(string)
+                self.at_start_of_line =3D string.endswith('\n')
+        self.__stdout =3D Output(sys.stdout.write, sys.stdout.flush)
+        if sys.stdout.isatty():
+            self.__out =3D self.__stdout
+        else:
+            self.__out =3D Output(lambda msg: None, lambda: None)
+    def stdout(self, line):
+        """Write a line to stdout."""
+        self.__stdout.write_line(line)
+    def stdout_raw(self, string):
+        """Write a string possibly containing newlines to stdout."""
+        self.__stdout.write_raw(string)
+    def info(self, *msgs):
+        for msg in msgs:
+            self.__out.single_line(msg)
+    def note(self, *msgs):
+        self.__out.tagged_lines('Notice', msgs)
+    def warn(self, *msgs):
+        self.__out.tagged_lines('Warning', msgs)
+    def error(self, *msgs):
+        self.__out.tagged_lines('Error', msgs)
+    def start(self, msg):
+        """Start a long-running operation."""
+        self.__out.single_line('%s ... ' % msg, print_newline =3D Fals=
e)
+        self.__out.level +=3D 1
+    def done(self, extramsg =3D None):
+        """Finish long-running operation."""
+        self.__out.level -=3D 1
+        if extramsg:
+            msg =3D 'done (%s)'
+        else:
+            msg =3D 'done'
+        self.__out.single_line(msg, need_newline =3D False)
+
+out =3D MessagePrinter()
+
 def mkdir_file(filename, mode):
     """Opens filename with the given mode, creating the directory it's
     in if it doesn't already exist."""
@@ -166,12 +246,11 @@ def call_editor(filename):
         editor =3D 'vi'
     editor +=3D ' %s' % filename
=20
-    print 'Invoking the editor: "%s"...' % editor,
-    sys.stdout.flush()
+    out.start('Invoking the editor: "%s"' % editor)
     err =3D os.system(editor)
     if err:
         raise EditorException, 'editor failed, exit code: %d' % err
-    print 'done'
+    out.done()
=20
 def patch_name_from_msg(msg):
     """Return a string to be used as a patch name. This is generated
