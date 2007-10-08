From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/6] Don't have a global crt_series in
	stgit.commans.common
Date: Mon, 08 Oct 2007 10:55:35 +0200
Message-ID: <20071008085535.9734.21876.stgit@yoghurt>
References: <20071008085430.9734.75797.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 10:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeoQ8-0003VA-B8
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 10:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbXJHIzo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 04:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753128AbXJHIzn
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 04:55:43 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2229 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbXJHIzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 04:55:41 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IeoOl-00025e-00; Mon, 08 Oct 2007 09:55:35 +0100
In-Reply-To: <20071008085430.9734.75797.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60303>

Global variables baaad. Instead, pass it as a parameter to the
functions that need it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/branch.py   |    8 ++++----
 stgit/commands/clean.py    |    4 ++--
 stgit/commands/commit.py   |    2 +-
 stgit/commands/common.py   |   22 ++++++++++------------
 stgit/commands/delete.py   |    4 ++--
 stgit/commands/diff.py     |    7 ++++---
 stgit/commands/edit.py     |    6 +++---
 stgit/commands/files.py    |    4 ++--
 stgit/commands/float.py    |    6 +++---
 stgit/commands/fold.py     |    5 +++--
 stgit/commands/goto.py     |    8 ++++----
 stgit/commands/id.py       |    2 +-
 stgit/commands/imprt.py    |    7 ++++---
 stgit/commands/mail.py     |   16 +++++++++-------
 stgit/commands/new.py      |    2 +-
 stgit/commands/pick.py     |   12 ++++++------
 stgit/commands/pop.py      |    8 ++++----
 stgit/commands/pull.py     |   14 +++++++-------
 stgit/commands/push.py     |    8 ++++----
 stgit/commands/rebase.py   |   12 ++++++------
 stgit/commands/refresh.py  |   10 +++++-----
 stgit/commands/series.py   |    5 +++--
 stgit/commands/show.py     |    2 +-
 stgit/commands/sink.py     |    6 +++---
 stgit/commands/sync.py     |    8 ++++----
 stgit/commands/uncommit.py |    2 +-
 stgit/main.py              |    1 -
 27 files changed, 97 insertions(+), 94 deletions(-)


diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 6e0a6d8..cbb97f6 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -112,7 +112,7 @@ def func(parser, options, args):
=20
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        check_head_top_equal(crt_series)
=20
         tree_id =3D None
         if len(args) >=3D 2:
@@ -141,7 +141,7 @@ def func(parser, options, args):
                 # exception in branch =3D rev_parse() leaves branchpoi=
nt unbound
                 branchpoint =3D None
=20
-            tree_id =3D branchpoint or git_id(args[1])
+            tree_id =3D branchpoint or git_id(crt_series, args[1])
=20
             if parentbranch:
                 out.info('Recording "%s" as parent branch' % parentbra=
nch)
@@ -182,7 +182,7 @@ def func(parser, options, args):
=20
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        check_head_top_equal(crt_series)
=20
         out.start('Cloning current branch to "%s"' % clone)
         crt_series.clone(clone)
@@ -294,7 +294,7 @@ def func(parser, options, args):
=20
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        check_head_top_equal(crt_series)
=20
         out.start('Switching to branch "%s"' % args[0])
         git.switch_branch(args[0])
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index d8bbe71..4484ecd 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -61,7 +61,7 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if not (options.applied or options.unapplied):
         options.applied =3D options.unapplied =3D True
@@ -74,4 +74,4 @@ def func(parser, options, args):
         unapplied =3D crt_series.get_unapplied()
         __delete_empty(unapplied, False)
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 2b45c0d..23b4dc1 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -45,7 +45,7 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     applied =3D crt_series.get_applied()
     if not applied:
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 652039f..2a80e8c 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -28,8 +28,6 @@ from stgit.run import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
=20
-crt_series =3D None
-
=20
 # Command exception class
 class CmdException(StgException):
@@ -74,7 +72,7 @@ def parse_rev(rev):
     # No, we can't parse that.
     raise RevParseException
=20
-def git_id(rev):
+def git_id(crt_series, rev):
     """Return the GIT id
     """
     if not rev:
@@ -112,7 +110,7 @@ def check_local_changes():
         raise CmdException, \
               'local changes in the tree. Use "refresh" or "status --r=
eset"'
=20
-def check_head_top_equal():
+def check_head_top_equal(crt_series):
     if not crt_series.head_top_equal():
         raise CmdException(
 """HEAD and top are not the same. This can happen if you
@@ -125,7 +123,7 @@ def check_conflicts():
               'Unsolved conflicts. Please resolve them first or\n' \
               '  revert the changes with "status --reset"'
=20
-def print_crt_patch(branch =3D None):
+def print_crt_patch(crt_series, branch =3D None):
     if not branch:
         patch =3D crt_series.get_current()
     else:
@@ -158,7 +156,7 @@ def resolved_all(reset =3D None):
             resolved(filename, reset)
         os.remove(os.path.join(basedir.get(), 'conflicts'))
=20
-def push_patches(patches, check_merged =3D False):
+def push_patches(crt_series, patches, check_merged =3D False):
     """Push multiple patches onto the stack. This function is shared
     between the push and pull commands
     """
@@ -197,7 +195,7 @@ def push_patches(patches, check_merged =3D False):
             else:
                 out.done()
=20
-def pop_patches(patches, keep =3D False):
+def pop_patches(crt_series, patches, keep =3D False):
     """Pop the patches in the list from the stack. It is assumed that
     the patches are listed in the stack reverse order.
     """
@@ -319,7 +317,7 @@ def address_or_alias(addr_str):
                  for addr in addr_str.split(',')]
     return ', '.join([addr for addr in addr_list if addr])
=20
-def prepare_rebase():
+def prepare_rebase(crt_series):
     # pop all patches
     applied =3D crt_series.get_applied()
     if len(applied) > 0:
@@ -328,9 +326,9 @@ def prepare_rebase():
         out.done()
     return applied
=20
-def rebase(target):
+def rebase(crt_series, target):
     try:
-        tree_id =3D git_id(target)
+        tree_id =3D git_id(crt_series, target)
     except:
         # it might be that we use a custom rebase command with its own
         # target type
@@ -345,12 +343,12 @@ def rebase(target):
     git.rebase(tree_id =3D tree_id)
     out.done()
=20
-def post_rebase(applied, nopush, merged):
+def post_rebase(crt_series, applied, nopush, merged):
     # memorize that we rebased to here
     crt_series._set_field('orig-base', git.get_head())
     # push the patches back
     if not nopush:
-        push_patches(applied, merged)
+        push_patches(crt_series, applied, merged)
=20
 #
 # Patch description/e-mail/diff parsing
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 8462857..fdb254e 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -71,7 +71,7 @@ def func(parser, options, args):
     if applied and not options.branch:
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        check_head_top_equal(crt_series)
=20
     # delete the patches
     for patch in applied + patches:
@@ -79,4 +79,4 @@ def func(parser, options, args):
         out.info('Patch "%s" successfully deleted' % patch)
=20
     if not options.branch:
-        print_crt_patch()
+        print_crt_patch(crt_series)
diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index f3b0ea2..42e8367 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -86,9 +86,10 @@ def func(parser, options, args):
         diff_flags =3D []
=20
     if options.stat:
-        out.stdout_raw(git.diffstat(args, git_id(rev1), git_id(rev2)) =
+ '\n')
+        out.stdout_raw(git.diffstat(args, git_id(crt_series, rev1),
+                                    git_id(crt_series, rev2)) + '\n')
     else:
-        diff_str =3D git.diff(args, git_id(rev1), git_id(rev2),
-                            diff_flags =3D diff_flags )
+        diff_str =3D git.diff(args, git_id(crt_series, rev1),
+                            git_id(crt_series, rev2), diff_flags =3D d=
iff_flags )
         if diff_str:
             pager(diff_str)
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 02970bc..89d534a 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -203,13 +203,13 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if pname !=3D crt_pname:
         # Go to the patch to be edited
         applied =3D crt_series.get_applied()
         between =3D applied[:applied.index(pname):-1]
-        pop_patches(between)
+        pop_patches(crt_series, between)
=20
     if options.author:
         options.authname, options.authemail =3D name_email(options.aut=
hor)
@@ -241,4 +241,4 @@ def func(parser, options, args):
     if pname !=3D crt_pname:
         # Push the patches back
         between.reverse()
-        push_patches(between)
+        push_patches(crt_series, between)
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index 07cc955..4550251 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -57,8 +57,8 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
=20
-    rev1 =3D git_id('%s//bottom' % patch)
-    rev2 =3D git_id('%s//top' % patch)
+    rev1 =3D git_id(crt_series, '%s//bottom' % patch)
+    rev2 =3D git_id(crt_series, '%s//top' % patch)
=20
     if options.stat:
         out.stdout_raw(git.diffstat(rev1 =3D rev1, rev2 =3D rev2) + '\=
n')
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index d5299fb..6c07136 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -46,7 +46,7 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     unapplied =3D crt_series.get_unapplied()
     applied =3D crt_series.get_applied()
@@ -85,7 +85,7 @@ def func(parser, options, args):
     # check whether the operation is really needed
     if topop !=3D topush:
         if topop:
-            pop_patches(topop)
+            pop_patches(crt_series, topop)
         if topush:
             topush.reverse()
-            push_patches(topush)
+            push_patches(crt_series, topush)
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 6e43101..3930a1f 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -50,7 +50,7 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if len(args) =3D=3D 1:
         filename =3D args[0]
@@ -74,7 +74,8 @@ def func(parser, options, args):
         bottom =3D crt_patch.get_bottom()
         git.apply_patch(filename =3D filename, base =3D bottom)
     elif options.base:
-        git.apply_patch(filename =3D filename, base =3D git_id(options=
=2Ebase))
+        git.apply_patch(filename =3D filename,
+                        base =3D git_id(crt_series, options.base))
     else:
         git.apply_patch(filename =3D filename)
=20
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 9e008a9..e7aa588 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -44,7 +44,7 @@ def func(parser, options, args):
         parser.error('incorrect number of arguments')
=20
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if not options.keep:
         check_local_changes()
@@ -56,13 +56,13 @@ def func(parser, options, args):
     if patch in applied:
         applied.reverse()
         patches =3D applied[:applied.index(patch)]
-        pop_patches(patches, options.keep)
+        pop_patches(crt_series, patches, options.keep)
     elif patch in unapplied:
         if options.keep:
             raise CmdException, 'Cannot use --keep with patch pushing'
         patches =3D unapplied[:unapplied.index(patch)+1]
-        push_patches(patches)
+        push_patches(crt_series, patches)
     else:
         raise CmdException, 'Patch "%s" does not exist' % patch
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 3e28f2f..94b0229 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -48,4 +48,4 @@ def func(parser, options, args):
     else:
         parser.error('incorrect number of arguments')
=20
-    out.stdout(git_id(id_str))
+    out.stdout(git_id(crt_series, id_str))
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 045f185..d6e950c 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -165,7 +165,8 @@ def __create_patch(filename, message, author_name, =
author_email,
     else:
         out.start('Importing patch "%s"' % patch)
         if options.base:
-            git.apply_patch(diff =3D diff, base =3D git_id(options.bas=
e))
+            git.apply_patch(diff =3D diff,
+                            base =3D git_id(crt_series, options.base))
         else:
             git.apply_patch(diff =3D diff)
         crt_series.refresh_patch(edit =3D options.edit,
@@ -270,7 +271,7 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if len(args) =3D=3D 1:
         filename =3D args[0]
@@ -286,4 +287,4 @@ def func(parser, options, args):
     else:
         __import_file(filename, options)
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 4a4158a..883a4f3 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -350,8 +350,8 @@ def __build_cover(tmpl, patches, msg_id, options):
                  'shortlog':     stack.shortlog(crt_series.get_patch(p=
)
                                                 for p in patches),
                  'diffstat':     git.diffstat(
-                                     rev1 =3D git_id('%s//bottom' % pa=
tches[0]),
-                                     rev2 =3D git_id('%s//top' % patch=
es[-1]))}
+                     rev1 =3D git_id(crt_series, '%s//bottom' % patche=
s[0]),
+                     rev2 =3D git_id(crt_series, '%s//top' % patches[-=
1]))}
=20
     try:
         msg_string =3D tmpl % tmpl_dict
@@ -435,11 +435,13 @@ def __build_message(tmpl, patch, patch_nr, total_=
nr, msg_id, ref_id, options):
                  'longdescr':    long_descr,
                  # for backward template compatibility
                  'endofheaders': '',
-                 'diff':         git.diff(rev1 =3D git_id('%s//bottom'=
 % patch),
-                                          rev2 =3D git_id('%s//top' % =
patch),
-                                          diff_flags =3D diff_flags ),
-                 'diffstat':     git.diffstat(rev1 =3D git_id('%s//bot=
tom'%patch),
-                                              rev2 =3D git_id('%s//top=
' % patch)),
+                 'diff':         git.diff(
+                     rev1 =3D git_id(crt_series, '%s//bottom' % patch)=
,
+                     rev2 =3D git_id(crt_series, '%s//top' % patch),
+                     diff_flags =3D diff_flags),
+                 'diffstat':     git.diffstat(
+                     rev1 =3D git_id(crt_series, '%s//bottom'%patch),
+                     rev2 =3D git_id(crt_series, '%s//top' % patch)),
                  # for backward template compatibility
                  'date':         '',
                  'version':      version_str,
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index ccc8141..b0a57d1 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -70,7 +70,7 @@ def func(parser, options, args):
         parser.error('incorrect number of arguments')
=20
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if options.author:
         options.authname, options.authemail =3D name_email(options.aut=
hor)
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 3acec32..1fcc2e2 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -65,10 +65,10 @@ def func(parser, options, args):
     if not options.unapplied:
         check_local_changes()
         check_conflicts()
-        check_head_top_equal()
+        check_head_top_equal(crt_series)
=20
     commit_str =3D args[0]
-    commit_id =3D git_id(commit_str)
+    commit_id =3D git_id(crt_series, commit_str)
     commit =3D git.Commit(commit_id)
=20
     if options.fold or options.update:
@@ -84,7 +84,7 @@ def func(parser, options, args):
             patchname =3D None
=20
     if options.parent:
-        parent =3D git_id(options.parent)
+        parent =3D git_id(crt_series, options.parent)
     else:
         parent =3D commit.get_parent()
=20
@@ -104,8 +104,8 @@ def func(parser, options, args):
=20
         out.done()
     elif options.update:
-        rev1 =3D git_id('//bottom')
-        rev2 =3D git_id('//top')
+        rev1 =3D git_id(crt_series, '//bottom')
+        rev2 =3D git_id(crt_series, '//top')
         files =3D git.barefiles(rev1, rev2).split('\n')
=20
         out.start('Updating with commit %s' % commit_id)
@@ -163,4 +163,4 @@ def func(parser, options, args):
         else:
             out.done()
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index a1d73e4..246cc34 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -51,7 +51,7 @@ def func(parser, options, args):
     """Pop the topmost patch from the stack
     """
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if not options.keep:
         check_local_changes()
@@ -83,8 +83,8 @@ def func(parser, options, args):
         raise CmdException, 'Cannot pop arbitrary patches with --keep'
=20
     topop.reverse()
-    pop_patches(topop, options.keep)
+    pop_patches(crt_series, topop, options.keep)
     if topush:
-        push_patches(topush)
+        push_patches(crt_series, topush)
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 5fcf2cc..e5ee17d 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -74,12 +74,12 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     if policy not in ['pull', 'fetch-rebase', 'rebase']:
         raise GitConfigException, 'Unsupported pull-policy "%s"' % pol=
icy
=20
-    applied =3D prepare_rebase()
+    applied =3D prepare_rebase(crt_series)
=20
     # pull the remote changes
     if policy =3D=3D 'pull':
@@ -92,17 +92,17 @@ def func(parser, options, args):
             target =3D git.fetch_head()
         except git.GitException:
             out.error('Could not find the remote head to rebase onto, =
pushing any patches back...')
-            post_rebase(applied, False, False)
+            post_rebase(crt_series, applied, False, False)
             raise CmdException, 'Could not find the remote head to reb=
ase onto - fix branch.%s.merge in .git/config' % crt_series.get_name()
=20
-        rebase(target)
+        rebase(crt_series, target)
     elif policy =3D=3D 'rebase':
-        rebase(crt_series.get_parent_branch())
+        rebase(crt_series, crt_series.get_parent_branch())
=20
-    post_rebase(applied, options.nopush, options.merged)
+    post_rebase(crt_series, applied, options.nopush, options.merged)
=20
     # maybe tidy up
     if config.get('stgit.keepoptimized') =3D=3D 'yes':
         git.repack()
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 4d5de26..979835b 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -72,13 +72,13 @@ def func(parser, options, args):
             out.done()
         else:
             out.done('patch unchanged')
-        print_crt_patch()
+        print_crt_patch(crt_series)
=20
         return
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     unapplied =3D crt_series.get_unapplied()
     if not unapplied:
@@ -99,6 +99,6 @@ def func(parser, options, args):
     if options.reverse:
         patches.reverse()
=20
-    push_patches(patches, options.merged)
+    push_patches(crt_series, patches, options.merged)
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index bbb3e12..c4d74b7 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -48,14 +48,14 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     # ensure an exception is raised before popping on non-existent tar=
get
-    if git_id(args[0]) =3D=3D None:
+    if git_id(crt_series, args[0]) =3D=3D None:
         raise GitException, 'Unknown revision: %s' % args[0]
        =20
-    applied =3D prepare_rebase()
-    rebase(args[0])
-    post_rebase(applied, options.nopush, options.merged)
+    applied =3D prepare_rebase(crt_series)
+    rebase(crt_series, args[0])
+    post_rebase(crt_series, applied, options.nopush, options.merged)
=20
-    print_crt_patch()
+    print_crt_patch(crt_series)
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index f032375..7cde392 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -73,7 +73,7 @@ def func(parser, options, args):
             raise CmdException, 'No patches applied'
=20
     if not options.force:
-        check_head_top_equal()
+        check_head_top_equal(crt_series)
=20
     if options.undo:
         out.start('Undoing the refresh of "%s"' % patch)
@@ -89,10 +89,10 @@ def func(parser, options, args):
         if options.patch:
             applied =3D crt_series.get_applied()
             between =3D applied[:applied.index(patch):-1]
-            pop_patches(between, keep =3D True)
+            pop_patches(crt_series, between, keep =3D True)
         elif options.update:
-            rev1 =3D git_id('//bottom')
-            rev2 =3D git_id('//top')
+            rev1 =3D git_id(crt_series, '//bottom')
+            rev2 =3D git_id(crt_series, '//top')
             patch_files =3D git.barefiles(rev1, rev2).split('\n')
             files =3D [f for f in files if f in patch_files]
             if not files:
@@ -113,7 +113,7 @@ def func(parser, options, args):
=20
         if options.patch:
             between.reverse()
-            push_patches(between)
+            push_patches(crt_series, between)
     elif options.annotate:
         # only annotate the top log entry as there is no need to
         # refresh the patch and generate a full commit
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 2c75876..4c6d07e 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -195,12 +195,13 @@ def func(parser, options, args):
             raise CmdException, '--graphical not supported with --miss=
ing'
=20
         if applied:
-            gitk_args =3D ' %s^..%s' % (git_id(applied[0]), git_id(app=
lied[-1]))
+            gitk_args =3D ' %s^..%s' % (git_id(crt_series, applied[0])=
,
+                                      git_id(crt_series, applied[-1]))
         else:
             gitk_args =3D ''
=20
         for p in unapplied:
-            patch_id =3D git_id(p)
+            patch_id =3D git_id(crt_series, p)
             gitk_args +=3D ' %s^..%s' % (patch_id, patch_id)
=20
         if os.system('gitk%s' % gitk_args) !=3D 0:
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index 7efb4e1..e4e70a5 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -69,7 +69,7 @@ def func(parser, options, args):
     else:
         diff_flags =3D []
=20
-    commit_ids =3D [git_id(patch) for patch in patches]
+    commit_ids =3D [git_id(crt_series, patch) for patch in patches]
     commit_str =3D '\n'.join([git.pretty_commit(commit_id, diff_flags=3D=
diff_flags)
                             for commit_id in commit_ids])
     if commit_str:
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 737dde0..b177337 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -45,7 +45,7 @@ def func(parser, options, args):
=20
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
     oldapplied =3D crt_series.get_applied()
     unapplied =3D crt_series.get_unapplied()
@@ -61,10 +61,10 @@ def func(parser, options, args):
         patches =3D [ crt_series.get_current() ]
=20
     crt_series.pop_patch(options.to or oldapplied[0])
-    push_patches(patches)
+    push_patches(crt_series, patches)
=20
     if not options.nopush:
         newapplied =3D crt_series.get_applied()
         def not_reapplied_yet(p):
             return not p in newapplied
-        push_patches(filter(not_reapplied_yet, oldapplied))
+        push_patches(crt_series, filter(not_reapplied_yet, oldapplied)=
)
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 8a31c29..6066f82 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -51,7 +51,7 @@ options =3D [make_option('-a', '--all',
 def __check_all():
     check_local_changes()
     check_conflicts()
-    check_head_top_equal()
+    check_head_top_equal(crt_series)
=20
 def __branch_merge_patch(remote_series, pname):
     """Merge a patch from a remote branch into the current tree.
@@ -131,13 +131,13 @@ def func(parser, options, args):
     # pop to the one before the first patch to be synchronised
     popped =3D applied[applied.index(sync_patches[0]) + 1:]
     if popped:
-        pop_patches(popped[::-1])
+        pop_patches(crt_series, popped[::-1])
=20
     for p in sync_patches:
         if p in popped:
             # push to this patch
             idx =3D popped.index(p) + 1
-            push_patches(popped[:idx])
+            push_patches(crt_series, popped[:idx])
             del popped[:idx]
=20
         # the actual sync
@@ -166,4 +166,4 @@ def func(parser, options, args):
=20
     # push the remaining patches
     if popped:
-        push_patches(popped)
+        push_patches(crt_series, popped)
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index a23ae20..8e62d23 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -66,7 +66,7 @@ def func(parser, options, args):
         if len(args) !=3D 0:
             parser.error('cannot specify patch name with --to')
         patch_nr =3D patchnames =3D None
-        to_commit =3D git_id(options.to)
+        to_commit =3D git_id(crt_series, options.to)
     elif options.number:
         if options.number <=3D 0:
             parser.error('invalid value passed to --number')
diff --git a/stgit/main.py b/stgit/main.py
index db327f1..e8242c2 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -277,7 +277,6 @@ def main():
                 command.crt_series =3D Series(options.branch)
             else:
                 command.crt_series =3D Series()
-            stgit.commands.common.crt_series =3D command.crt_series
=20
         command.func(parser, options, args)
     except (StgException, IOError, ParsingError, NoSectionError), err:
