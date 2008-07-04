From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Remove --undo flags from stg commands and docs
Date: Fri, 04 Jul 2008 08:36:36 +0200
Message-ID: <20080704063536.9570.43526.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:38:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEevs-0000Ip-N7
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbYGDGhO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jul 2008 02:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbYGDGhO
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:37:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2088 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbYGDGhM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:37:12 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KEeuK-0000Lm-00; Fri, 04 Jul 2008 07:36:36 +0100
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87364>

Now that we have "stg undo" et.al., they aren't needed anymore.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

In this one, I've just removed the --undo flag from sync without
adding anything back. Still undetermined if that's OK.

 Documentation/tutorial.txt |    4 +++-
 TODO                       |    2 --
 stgit/commands/goto.py     |    3 +--
 stgit/commands/pop.py      |    2 +-
 stgit/commands/push.py     |   29 +++++-----------------------
 stgit/commands/rebase.py   |    2 +-
 stgit/commands/repair.py   |    9 +++++----
 stgit/commands/sync.py     |   24 +++--------------------
 stgit/stack.py             |   45 +-----------------------------------=
--------
 t/t1200-push-modified.sh   |    2 +-
 t/t1201-pull-trailing.sh   |    2 +-
 t/t1202-push-undo.sh       |    8 ++++----
 12 files changed, 26 insertions(+), 106 deletions(-)


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 6eaa623..0d862c0 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -178,7 +178,9 @@ patches in a stack.
 During a push operation, merge conflicts can occur (especially if you
 are changing the order of the patches in your stack). If the push caus=
es
 merge conflicts, they need to be fixed and 'stg resolved' run (see
-below). A 'push' operation can also be reverted with 'stg push --undo'=
=2E
+below). A 'push' operation can also be reverted with 'stg undo' (you
+will need to give it the --hard flag, since the conflicting push will
+have left your work tree dirty).
 A few more stack basics; to rename a patch:
=20
   stg rename <old-name> <new-name>
diff --git a/TODO b/TODO
index 884b831..ff52a95 100644
--- a/TODO
+++ b/TODO
@@ -8,8 +8,6 @@ The TODO list before 1.0:
 - debian package support
 - man page
 - document the workflow on the StGIT wiki
-- maybe a separate undo command rather than passing a --undo option to
-  push and refresh
 - use same configuration file as GIT
 - release 1.0
=20
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index b347920..db4a4b6 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -23,8 +23,7 @@ help =3D 'push or pop patches to the given one'
 usage =3D """%prog [options] <name>
=20
 Push/pop patches to/from the stack until the one given on the command
-line becomes current. There is no '--undo' option for 'goto'. Use the
-'push --undo' command for this."""
+line becomes current."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
 options =3D []
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index 1d8c203..c7390a1 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -33,7 +33,7 @@ not specified).
=20
 A series of pop and push operations are performed so that only the
 patches passed on the command line are popped from the stack. Some of
-the push operations may fail because of conflicts (push --undo would
+the push operations may fail because of conflicts ("stg undo" would
 revert the last push operation)."""
=20
 directory =3D DirectoryGotoToplevel(log =3D True)
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 8f1e400..fabb894 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -30,11 +30,11 @@ usage =3D """%prog [options] [<patch1>] [<patch2>] =
[<patch3>..<patch4>]
=20
 Push one or more patches (defaulting to the first unapplied one) onto
 the stack. The 'push' operation allows patch reordering by commuting
-them with the three-way merge algorithm. If the result of the 'push'
-operation is not acceptable or if there are too many conflicts, the
-'--undo' option can be used to revert the last pushed patch. Conflicts
-raised during the push operation have to be fixed and the 'resolved'
-command run.
+them with the three-way merge algorithm. If there are conflicts while
+pushing a patch, those conflicts are written to the work tree, and the
+command halts. Conflicts raised during the push operation have to be
+fixed and the 'resolved' command run (alternatively, you may undo the
+conflicting push with 'stg undo').
=20
 The command also notifies when the patch becomes empty (fully merged
 upstream) or is modified (three-way merged) by the 'push' operation.""=
"
@@ -50,9 +50,6 @@ options =3D [make_option('-a', '--all',
                        action =3D 'store_true'),
            make_option('-m', '--merged',
                        help =3D 'check for patches merged upstream',
-                       action =3D 'store_true'),
-           make_option('--undo',
-                       help =3D 'undo the last patch pushing',
                        action =3D 'store_true')]
=20
=20
@@ -60,22 +57,6 @@ def func(parser, options, args):
     """Pushes the given patch or all onto the series
     """
=20
-    # If --undo is passed, do the work and exit
-    if options.undo:
-        patch =3D crt_series.get_current()
-        if not patch:
-            raise CmdException, 'No patch to undo'
-
-        out.start('Undoing push of "%s"' % patch)
-        resolved_all()
-        if crt_series.undo_push():
-            out.done()
-        else:
-            out.done('patch unchanged')
-        print_crt_patch(crt_series)
-
-        return
-
     check_local_changes()
     check_conflicts()
     check_head_top_equal(crt_series)
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index 3867b26..c6bbbb4 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -38,7 +38,7 @@ the rebase by executing the following sequence:
=20
 Or if you want to skip that patch:
=20
-        $ stg push --undo
+        $ stg undo --hard
         $ stg push next-patch..top-patch"""
=20
 directory =3D DirectoryGotoToplevel(log =3D True)
diff --git a/stgit/commands/repair.py b/stgit/commands/repair.py
index 1993783..80a4dea 100644
--- a/stgit/commands/repair.py
+++ b/stgit/commands/repair.py
@@ -34,8 +34,9 @@ as commit, pull, merge, and rebase -- you will leave =
the StGit
 metadata in an inconsistent state. In that situation, you have two
 options:
=20
-  1. Use "git reset" or similar to undo the effect of the git
-     command(s).
+  1. Use "stg undo" to undo the effect of the git commands. (If you
+     know what you are doing and want more control, "git reset" or
+     similar will work too.)
=20
   2. Use "stg repair". This will fix up the StGit metadata to
      accomodate the modifications to the branch. Specifically, it will
@@ -48,8 +49,8 @@ options:
        * However, merge commits cannot become patches; if you have
          committed a merge on top of your stack, "repair" will simply
          mark all patches below the merge unapplied, since they are no
-         longer reachable. If this is not what you want, use "git
-         reset" to get rid of the merge and run "stg repair" again.
+         longer reachable. If this is not what you want, use "stg
+         undo" to get rid of the merge and run "stg repair" again.
=20
        * The applied patches are supposed to be precisely those that
          are reachable from the branch head. If you have used e.g.
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 5b2c65c..5424cf5 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -32,9 +32,7 @@ For each of the specified patches perform a three-way=
 merge with the
 same patch in the specified branch or series. The command can be used
 for keeping patches on several branches in sync. Note that the
 operation may fail for some patches because of conflicts. The patches
-in the series must apply cleanly.
-
-The sync operation can be reverted for individual patches with --undo.=
"""
+in the series must apply cleanly."""
=20
 directory =3D DirectoryGotoToplevel(log =3D True)
 options =3D [make_option('-a', '--all',
@@ -43,10 +41,7 @@ options =3D [make_option('-a', '--all',
            make_option('-B', '--ref-branch',
                        help =3D 'syncronise patches with BRANCH'),
            make_option('-s', '--series',
-                       help =3D 'syncronise patches with SERIES'),
-           make_option('--undo',
-                       help =3D 'undo the synchronisation of the curre=
nt patch',
-                       action =3D 'store_true')]
+                       help =3D 'syncronise patches with SERIES')]
=20
 def __check_all():
     check_local_changes()
@@ -68,18 +63,6 @@ def __series_merge_patch(base, patchdir, pname):
 def func(parser, options, args):
     """Synchronise a range of patches
     """
-    if options.undo:
-        if options.ref_branch or options.series:
-            raise CmdException, \
-                  '--undo cannot be specified with --ref-branch or --s=
eries'
-        __check_all()
-
-        out.start('Undoing the sync of "%s"' % crt_series.get_current(=
))
-        crt_series.undo_refresh()
-        git.reset()
-        out.done()
-        return
-
     if options.ref_branch:
         remote_series =3D stack.Series(options.ref_branch)
         if options.ref_branch =3D=3D crt_series.get_name():
@@ -157,8 +140,7 @@ def func(parser, options, args):
         bottom =3D patch.get_bottom()
         top =3D patch.get_top()
=20
-        # reset the patch backup information. That's needed in case we
-        # undo the sync but there were no changes made
+        # reset the patch backup information.
         patch.set_top(top, backup =3D True)
=20
         # the actual merging (either from a branch or an external file=
)
diff --git a/stgit/stack.py b/stgit/stack.py
index 74c2c10..9958e7a 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -740,26 +740,6 @@ class Series(PatchSet):
=20
         return commit_id
=20
-    def undo_refresh(self):
-        """Undo the patch boundaries changes caused by 'refresh'
-        """
-        name =3D self.get_current()
-        assert(name)
-
-        patch =3D self.get_patch(name)
-        old_bottom =3D patch.get_old_bottom()
-        old_top =3D patch.get_old_top()
-
-        # the bottom of the patch is not changed by refresh. If the
-        # old_bottom is different, there wasn't any previous 'refresh'
-        # command (probably only a 'push')
-        if old_bottom !=3D patch.get_bottom() or old_top =3D=3D patch.=
get_top():
-            raise StackException, 'No undo information available'
-
-        git.reset(tree_id =3D old_top, check_out =3D False)
-        if patch.restore_old_boundaries():
-            self.log_patch(patch, 'undo')
-
     def new_patch(self, name, message =3D None, can_edit =3D True,
                   unapplied =3D False, show_patch =3D False,
                   top =3D None, bottom =3D None, commit =3D True,
@@ -1019,7 +999,7 @@ class Series(PatchSet):
                 git.merge_recursive(bottom, head, top)
             except git.GitException, ex:
                 out.error('The merge failed during "push".',
-                          'Revert the operation with "push --undo".')
+                          'Revert the operation with "stg undo".')
=20
         append_string(self.__applied_file, name)
=20
@@ -1043,29 +1023,6 @@ class Series(PatchSet):
=20
         return modified
=20
-    def undo_push(self):
-        name =3D self.get_current()
-        assert(name)
-
-        patch =3D self.get_patch(name)
-        old_bottom =3D patch.get_old_bottom()
-        old_top =3D patch.get_old_top()
-
-        # the top of the patch is changed by a push operation only
-        # together with the bottom (otherwise the top was probably
-        # modified by 'refresh'). If they are both unchanged, there
-        # was a fast forward
-        if old_bottom =3D=3D patch.get_bottom() and old_top !=3D patch=
=2Eget_top():
-            raise StackException, 'No undo information available'
-
-        git.reset()
-        self.pop_patch(name)
-        ret =3D patch.restore_old_boundaries()
-        if ret:
-            self.log_patch(patch, 'undo')
-
-        return ret
-
     def pop_patch(self, name, keep =3D False):
         """Pops the top patch from the stack
         """
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index ba4f70c..c56e8cf 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -56,7 +56,7 @@ test_expect_success \
 test_expect_success \
     'Rollback the push' '
     (
-        cd bar && stg push --undo &&
+        cd bar && stg undo --hard &&
         [ "$(echo $(stg applied))" =3D "" ] &&
         [ "$(echo $(stg unapplied))" =3D "p1 p2" ]
     )
diff --git a/t/t1201-pull-trailing.sh b/t/t1201-pull-trailing.sh
index 9d70fe0..3d4ba14 100755
--- a/t/t1201-pull-trailing.sh
+++ b/t/t1201-pull-trailing.sh
@@ -49,7 +49,7 @@ test_expect_success \
=20
 test_expect_success \
     'Pull those patches applied upstream' \
-    "(cd bar && stg push --undo && stg push --all --merged
+    "(cd bar && stg undo && stg push --all --merged
      )
 "
=20
diff --git a/t/t1202-push-undo.sh b/t/t1202-push-undo.sh
index b602643..baa986f 100755
--- a/t/t1202-push-undo.sh
+++ b/t/t1202-push-undo.sh
@@ -3,10 +3,10 @@
 # Copyright (c) 2006 Catalin Marinas
 #
=20
-test_description=3D'Exercise push --undo with missing files.
+test_description=3D'Exercise stg undo with push of missing files.
=20
 Test the case where a patch fails to be pushed because it modifies a
-missing file. The "push --undo" command has to be able to revert it.
+missing file. The "stg undo" command has to be able to revert it.
 '
=20
 . ./test-lib.sh
@@ -49,7 +49,7 @@ test_expect_success \
 test_expect_success \
 	'Undo the previous push' \
 	'
-	stg push --undo
+	stg undo --hard
 	'
=20
 test_expect_success \
@@ -64,7 +64,7 @@ test_expect_success \
 	touch newfile &&
 	git add newfile &&
 	rm newfile &&
-	stg push --undo
+	stg undo --hard
 	'
=20
 test_done
