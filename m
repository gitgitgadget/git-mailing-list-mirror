From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 7/9] Replace crt_series uses with a method call.
Date: Sun, 17 Jun 2007 00:01:05 +0200
Message-ID: <20070616220105.14941.41947.stgit@gandelf.nowhere.earth>
References: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 00:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzgKv-0000H7-1Q
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 00:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbXFPWBC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 18:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbXFPWBA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 18:01:00 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:45573 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189AbXFPWA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 18:00:58 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 31C485A121;
	Sun, 17 Jun 2007 00:00:56 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 9030C1F08A;
	Sun, 17 Jun 2007 00:01:05 +0200 (CEST)
In-Reply-To: <20070616213615.14941.31187.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50319>

This is a first step towards use of a factory method.

It also allows to get on-demand instantiation of the "current series"
object, and we can avoid calling a Series constructor when only the
current head's name is needed.

At the same time, cleaned up how "series --missing" was implemented.

Note: current_head() is actually slightly misnamed: it is expected to
be the Series/PatchSet object on which the command operates, but for
some commands (notably stg-branch and stg-clone) the semantics are a
bit different.  Thus there is probably some more refactoring to do
here, and I'm keeping this name as a reminder.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/add.py        |    2 +-
 stgit/commands/applied.py    |    2 +-
 stgit/commands/assimilate.py |    8 ++++----
 stgit/commands/branch.py     |   14 +++++++-------
 stgit/commands/clean.py      |   16 ++++++++--------
 stgit/commands/commit.py     |    8 ++++----
 stgit/commands/common.py     |   36 ++++++++++++++++++------------------
 stgit/commands/copy.py       |    2 +-
 stgit/commands/delete.py     |    6 +++---
 stgit/commands/export.py     |    8 ++++----
 stgit/commands/float.py      |    4 ++--
 stgit/commands/fold.py       |    4 ++--
 stgit/commands/goto.py       |    4 ++--
 stgit/commands/hide.py       |    6 +++---
 stgit/commands/imprt.py      |   26 +++++++++++++-------------
 stgit/commands/init.py       |    2 +-
 stgit/commands/log.py        |    6 +++---
 stgit/commands/mail.py       |    6 +++---
 stgit/commands/new.py        |   14 +++++++-------
 stgit/commands/patches.py    |    8 ++++----
 stgit/commands/pick.py       |   18 +++++++++---------
 stgit/commands/pop.py        |    2 +-
 stgit/commands/pull.py       |    8 ++++----
 stgit/commands/push.py       |    6 +++---
 stgit/commands/rebase.py     |    2 +-
 stgit/commands/refresh.py    |   34 +++++++++++++++++-----------------
 stgit/commands/rename.py     |    2 +-
 stgit/commands/rm.py         |    2 +-
 stgit/commands/series.py     |   37 +++++++++++++++++--------------------
 stgit/commands/show.py       |    6 +++---
 stgit/commands/sink.py       |   10 +++++-----
 stgit/commands/sync.py       |   17 ++++++++---------
 stgit/commands/top.py        |    2 +-
 stgit/commands/unapplied.py  |    2 +-
 stgit/commands/uncommit.py   |   18 +++++++++---------
 stgit/commands/unhide.py     |    6 +++---
 stgit/main.py                |    7 -------
 37 files changed, 175 insertions(+), 186 deletions(-)

diff --git a/stgit/commands/add.py b/stgit/commands/add.py
index cc9dab0..48fb78a 100644
--- a/stgit/commands/add.py
+++ b/stgit/commands/add.py
@@ -39,7 +39,7 @@ class concreteCommand(Command):
         if len(self.args) < 1:
             self.parser.error('incorrect number of arguments')
 
-        if not crt_series.get_current():
+        if not self.current_head().get_current():
             raise CmdException, 'No patches applied'
 
         git.add(self.args)
diff --git a/stgit/commands/applied.py b/stgit/commands/applied.py
index a30a0e0..27077d9 100644
--- a/stgit/commands/applied.py
+++ b/stgit/commands/applied.py
@@ -45,7 +45,7 @@ class concreteCommand(Command):
         if len(self.args) != 0:
             self.parser.error('incorrect number of arguments')
 
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
 
         if self.flags.count:
             out.stdout(len(applied))
diff --git a/stgit/commands/assimilate.py b/stgit/commands/assimilate.py
index c85ae6e..b79358a 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/assimilate.py
@@ -43,7 +43,7 @@ class concreteCommand(Command):
         def nothing_to_do():
             out.info('No commits to assimilate')
 
-        top_patch = crt_series.get_current_patch()
+        top_patch = self.current_head().get_current_patch()
         if not top_patch:
             return nothing_to_do()
 
@@ -61,7 +61,7 @@ class concreteCommand(Command):
         if not victims:
             return nothing_to_do()
 
-        if crt_series.get_protected():
+        if self.current_head().get_protected():
             raise CmdException(
                 'This branch is protected. Modification is not permitted')
 
@@ -69,7 +69,7 @@ class concreteCommand(Command):
         name2patch = {}
 
         def name_taken(name):
-            return name in name2patch or crt_series.patch_exists(name)
+            return name in name2patch or self.current_head().patch_exists(name)
 
         for victim in victims:
             patchname = make_patch_name(victim.get_log(), name_taken)
@@ -82,7 +82,7 @@ class concreteCommand(Command):
                      % (patch2name[victim], victim))
             aname, amail, adate = name_email_date(victim.get_author())
             cname, cmail, cdate = name_email_date(victim.get_committer())
-            crt_series.new_patch(
+            self.current_head().new_patch(
                 patch2name[victim],
                 can_edit = False, before_existing = False, refresh = False,
                 top = victim.get_id_hash(), bottom = victim.get_parent(),
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index e243830..ca4f98c 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -69,7 +69,7 @@ class concreteCommand(Command):
 
 
     def __is_current_branch(self, branch_name):
-        return crt_series.get_name() == branch_name
+        return self.current_head_name() == branch_name
 
     def __print_branch(self, branch_name, length):
         initialized = ' '
@@ -169,7 +169,7 @@ class concreteCommand(Command):
         elif self.flags.clone:
 
             if len(self.args) == 0:
-                clone = crt_series.get_name() + \
+                clone = self.current_head_name() + \
                         time.strftime('-%C%y%m%d-%H%M%S')
             elif len(self.args) == 1:
                 clone = self.args[0]
@@ -181,7 +181,7 @@ class concreteCommand(Command):
             self.check_head_top_equal()
 
             out.start('Cloning current branch to "%s"' % clone)
-            crt_series.clone(clone)
+            self.current_head().clone(clone)
             out.done()
 
             return
@@ -216,7 +216,7 @@ class concreteCommand(Command):
         elif self.flags.protect:
 
             if len(self.args) == 0:
-                branch_name = crt_series.get_name()
+                branch_name = self.current_head_name()
             elif len(self.args) == 1:
                 branch_name = self.args[0]
             else:
@@ -250,7 +250,7 @@ class concreteCommand(Command):
         elif self.flags.unprotect:
 
             if len(self.args) == 0:
-                branch_name = crt_series.get_name()
+                branch_name = self.current_head_name()
             elif len(self.args) == 1:
                 branch_name = self.args[0]
             else:
@@ -270,7 +270,7 @@ class concreteCommand(Command):
         elif self.flags.description is not None:
 
             if len(self.args) == 0:
-                branch_name = crt_series.get_name()
+                branch_name = self.current_head_name()
             elif len(self.args) == 1:
                 branch_name = self.args[0]
             else:
@@ -304,4 +304,4 @@ class concreteCommand(Command):
         if len(self.args) != 0:
             self.parser.error('incorrect number of arguments')
 
-        print crt_series.get_name()
+        print self.current_head_name()
diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 3e9d829..74f5cf7 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -43,14 +43,14 @@ class concreteCommand(Command):
         """Delete the empty patches
         """
         for p in patches:
-            if crt_series.empty_patch(p):
+            if self.current_head().empty_patch(p):
                 out.start('Deleting patch "%s"' % p)
-                if applied and crt_series.patch_applied(p):
-                    crt_series.pop_patch(p)
-                crt_series.delete_patch(p)
+                if applied and self.current_head().patch_applied(p):
+                    self.current_head().pop_patch(p)
+                self.current_head().delete_patch(p)
                 out.done()
-            elif applied and crt_series.patch_unapplied(p):
-                crt_series.push_patch(p)
+            elif applied and self.current_head().patch_unapplied(p):
+                self.current_head().push_patch(p)
 
     def func(self):
         """Delete the empty patches in the series
@@ -66,11 +66,11 @@ class concreteCommand(Command):
             self.flags.applied = self.flags.unapplied = True
 
         if self.flags.applied:
-            applied = crt_series.get_applied()
+            applied = self.current_head().get_applied()
             self.__delete_empty(applied, True)
 
         if self.flags.unapplied:
-            unapplied = crt_series.get_unapplied()
+            unapplied = self.current_head().get_unapplied()
             self.__delete_empty(unapplied, False)
 
         self.print_crt_patch()
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 56f3943..decba21 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -44,21 +44,21 @@ class concreteCommand(Command):
         check_conflicts()
         self.check_head_top_equal()
 
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
         if not applied:
             raise CmdException, 'No patches applied'
 
-        if crt_series.get_protected():
+        if self.current_head().get_protected():
             raise CmdException, 'This branch is protected.  Commit is not permitted'
 
         crt_head = git.get_head()
 
         out.start('Committing %d patches' % len(applied))
 
-        crt_series.pop_patch(applied[0])
+        self.current_head().pop_patch(applied[0])
         git.switch(crt_head)
 
         for patch in applied:
-            crt_series.delete_patch(patch)
+            self.current_head().delete_patch(patch)
 
         out.done()
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 1ed5086..12487a5 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -25,9 +25,6 @@ from stgit.utils import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
 
-crt_series = None
-
-
 # Command exception class
 class CmdException(Exception):
     pass
@@ -48,6 +45,7 @@ class Command:
     This command is undocumented."""
     options = []
     __head_name = None
+    __head = None
 
     def __init__(self, name):
         self.__name = name
@@ -61,7 +59,9 @@ class Command:
         return self.__head_name
 
     def current_head(self):
-        return stack.Series(self.current_head_name())
+        if not self.__head:
+            self.__head = stack.Series(self.current_head_name())
+        return self.__head
 
     def func(self):
         raise CmdException, 'Unimplemented command'
@@ -79,7 +79,7 @@ class Command:
         try:
             patch, branch, patch_id = parse_rev(rev)
             if branch == None:
-                series = crt_series
+                series = self.current_head()
             else:
                 series = stack.Series(branch)
             if patch == None:
@@ -104,7 +104,7 @@ class Command:
         return git.rev_parse(rev + '^{commit}')
 
     def check_head_top_equal(self):
-        if not crt_series.head_top_equal():
+        if not self.current_head().head_top_equal():
             raise CmdException(
                 'HEAD and top are not the same. You probably committed\n'
                 '  changes to the tree outside of StGIT. To bring them\n'
@@ -112,7 +112,7 @@ class Command:
 
     def print_crt_patch(self, branch = None):
         if not branch:
-            patch = crt_series.get_current()
+            patch = self.current_head().get_current()
         else:
             patch = stack.Series(branch).get_current()
 
@@ -125,7 +125,7 @@ class Command:
         """Push multiple patches onto the stack. This function is shared
         between the push and pull commands
         """
-        forwarded = crt_series.forward_patches(patches)
+        forwarded = self.current_head().forward_patches(patches)
         if forwarded > 1:
             out.info('Fast-forwarded patches "%s" - "%s"'
                      % (patches[0], patches[forwarded - 1]))
@@ -138,7 +138,7 @@ class Command:
         if names and check_merged:
             out.start('Checking for patches merged upstream')
 
-            merged = crt_series.merged_patches(names)
+            merged = self.current_head().merged_patches(names)
 
             out.done('%d found' % len(merged))
         else:
@@ -148,12 +148,12 @@ class Command:
             out.start('Pushing patch "%s"' % p)
 
             if p in merged:
-                crt_series.push_patch(p, empty = True)
+                self.current_head().push_patch(p, empty = True)
                 out.done('merged upstream')
             else:
-                modified = crt_series.push_patch(p)
+                modified = self.current_head().push_patch(p)
 
-                if crt_series.empty_patch(p):
+                if self.current_head().empty_patch(p):
                     out.done('empty patch')
                 elif modified:
                     out.done('modified')
@@ -172,22 +172,22 @@ class Command:
                 out.start('Popping patch "%s"' % p)
             else:
                 out.start('Popping patches "%s" - "%s"' % (patches[0], p))
-            crt_series.pop_patch(p, keep)
+            self.current_head().pop_patch(p, keep)
             out.done()
 
     def prepare_rebase(self, force=None):
         if not force:
             # Be sure we won't loose results of stg-(un)commit by error.
             # Do not require an existing orig-base for compatibility with 0.12 and earlier.
-            origbase = crt_series._get_field('orig-base')
-            if origbase and crt_series.get_base() != origbase:
+            origbase = self.current_head()._get_field('orig-base')
+            if origbase and self.current_head().get_base() != origbase:
                 raise CmdException, 'Rebasing would possibly lose data'
 
         # pop all patches
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
         if len(applied) > 0:
             out.start('Popping all applied patches')
-            crt_series.pop_patch(applied[0])
+            self.current_head().pop_patch(applied[0])
             out.done()
         return applied
 
@@ -201,7 +201,7 @@ class Command:
 
     def post_rebase(self, applied, nopush, merged):
         # memorize that we rebased to here
-        crt_series._set_field('orig-base', git.get_head())
+        self.current_head()._set_field('orig-base', git.get_head())
         # push the patches back
         if not nopush:
             self.push_patches(applied, merged)
diff --git a/stgit/commands/copy.py b/stgit/commands/copy.py
index 393d509..3eb267e 100644
--- a/stgit/commands/copy.py
+++ b/stgit/commands/copy.py
@@ -37,7 +37,7 @@ class concreteCommand(Command):
         if len(self.args) < 1:
             self.parser.error('incorrect number of arguments')
 
-        if not crt_series.get_current():
+        if not self.current_head().get_current():
             raise CmdException, 'No patches applied'
 
         git.copy(self.args[0:-1], self.args[-1])
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 6d10895..b87d13d 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -42,8 +42,8 @@ class concreteCommand(Command):
     def func(self):
         """Deletes one or more patches.
         """
-        applied_patches = crt_series.get_applied()
-        unapplied_patches = crt_series.get_unapplied()
+        applied_patches = self.current_head().get_applied()
+        unapplied_patches = self.current_head().get_unapplied()
         all_patches = applied_patches + unapplied_patches
 
         if self.args:
@@ -74,7 +74,7 @@ class concreteCommand(Command):
 
         # delete the patches
         for patch in applied + patches:
-            crt_series.delete_patch(patch)
+            self.current_head().delete_patch(patch)
             out.info('Patch "%s" successfully deleted' % patch)
 
         if not self.flags.branch:
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index fb5e87b..f1c1920 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -76,7 +76,7 @@ class concreteCommand(Command):
         if self.flags.dir:
             dirname = self.flags.dir
         else:
-            dirname = 'patches-%s' % crt_series.get_name()
+            dirname = 'patches-%s' % self.current_head_name()
 
         if not self.flags.branch and git.local_changes():
             out.warn('Local changes in the tree;'
@@ -92,7 +92,7 @@ class concreteCommand(Command):
         else:
             diff_flags = []
 
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
         if len(self.args) != 0:
             patches = parse_patches(self.args, applied)
         else:
@@ -116,7 +116,7 @@ class concreteCommand(Command):
 
         # note the base commit for this series
         if not self.flags.stdout:
-            base_commit = crt_series.get_patch(patches[0]).get_bottom()
+            base_commit = self.current_head().get_patch(patches[0]).get_bottom()
             print >> series, '# This series applies on GIT commit %s' % base_commit
 
         patch_no = 1;
@@ -133,7 +133,7 @@ class concreteCommand(Command):
                 print >> series, pname
 
             # get the patch description
-            patch = crt_series.get_patch(p)
+            patch = self.current_head().get_patch(p)
 
             descr = patch.get_description().strip()
             descr_lines = descr.split('\n')
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index ea82ea5..b3b9acb 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -48,8 +48,8 @@ class concreteCommand(Command):
         check_conflicts()
         self.check_head_top_equal()
 
-        unapplied = crt_series.get_unapplied()
-        applied = crt_series.get_applied()
+        unapplied = self.current_head().get_unapplied()
+        applied = self.current_head().get_applied()
         all = unapplied + applied
 
         if self.flags.series:
diff --git a/stgit/commands/fold.py b/stgit/commands/fold.py
index 6d75df5..734db43 100644
--- a/stgit/commands/fold.py
+++ b/stgit/commands/fold.py
@@ -56,7 +56,7 @@ class concreteCommand(Command):
         else:
             filename = None
 
-        current = crt_series.get_current()
+        current = self.current_head().get_current()
         if not current:
             raise CmdException, 'No patches applied'
 
@@ -69,7 +69,7 @@ class concreteCommand(Command):
             out.start('Folding patch from stdin')
 
         if self.flags.threeway:
-            crt_patch = crt_series.get_patch(current)
+            crt_patch = self.current_head().get_patch(current)
             bottom = crt_patch.get_bottom()
             git.apply_patch(filename = filename, base = bottom)
         elif self.flags.base:
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index ceec9ea..dc862ef 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -45,8 +45,8 @@ class concreteCommand(Command):
         check_conflicts()
         self.check_head_top_equal()
 
-        applied = crt_series.get_applied()
-        unapplied = crt_series.get_unapplied()
+        applied = self.current_head().get_applied()
+        unapplied = self.current_head().get_unapplied()
         patch = self.args[0]
 
         if patch in applied:
diff --git a/stgit/commands/hide.py b/stgit/commands/hide.py
index 4259fdf..ef17592 100644
--- a/stgit/commands/hide.py
+++ b/stgit/commands/hide.py
@@ -38,12 +38,12 @@ class concreteCommand(Command):
         """
         if self.args:
             # parsing all the patches for a more meaningful error reporting
-            all_patches = crt_series.get_applied() + crt_series.get_unapplied() \
-                          + crt_series.get_hidden()
+            all_patches = self.current_head().get_applied() + self.current_head().get_unapplied() \
+                          + self.current_head().get_hidden()
             patches = parse_patches(self.args, all_patches)
         else:
             self.parser.error('No patches specified')
 
         for patch in patches:
-            crt_series.hide_patch(patch)
+            self.current_head().hide_patch(patch)
             out.info('Patch "%s" hidden' % patch)
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 2401c4a..b45ec29 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -246,7 +246,7 @@ class concreteCommand(Command):
             if self.flags.ignore or self.flags.replace:
                 unacceptable_name = lambda name: False
             else:
-                unacceptable_name = crt_series.patch_exists
+                unacceptable_name = self.current_head().patch_exists
             patch = make_patch_name(message, unacceptable_name)
         else:
             # fix possible invalid characters in the patch name
@@ -255,11 +255,11 @@ class concreteCommand(Command):
         if not diff:
             raise CmdException, 'No diff found inside the patch'
 
-        if self.flags.ignore and patch in crt_series.get_applied():
+        if self.flags.ignore and patch in self.current_head().get_applied():
             out.info('Ignoring already applied patch "%s"' % patch)
             return
-        if self.flags.replace and patch in crt_series.get_unapplied():
-            crt_series.delete_patch(patch)
+        if self.flags.replace and patch in self.current_head().get_unapplied():
+            self.current_head().delete_patch(patch)
 
         # refresh_patch() will invoke the editor in this case, with correct
         # patch content
@@ -283,20 +283,20 @@ class concreteCommand(Command):
         if self.flags.commemail:
             committer_email = self.flags.commemail
 
-        crt_series.new_patch(patch, message = message, can_edit = False,
-                             author_name = author_name,
-                             author_email = author_email,
-                             author_date = author_date,
-                             committer_name = committer_name,
-                             committer_email = committer_email)
+        self.current_head().new_patch(patch, message = message, can_edit = False,
+                                      author_name = author_name,
+                                      author_email = author_email,
+                                      author_date = author_date,
+                                      committer_name = committer_name,
+                                      committer_email = committer_email)
 
         out.start('Importing patch "%s"' % patch)
         if self.flags.base:
             git.apply_patch(diff = diff, base = self.git_id(self.flags.base))
         else:
             git.apply_patch(diff = diff)
-        crt_series.refresh_patch(edit = self.flags.edit,
-                                 show_patch = self.flags.showpatch)
+        self.current_head().refresh_patch(edit = self.flags.edit,
+                                          show_patch = self.flags.showpatch)
         out.done()
 
     def __import_file(self, filename, patch = None):
@@ -332,7 +332,7 @@ class concreteCommand(Command):
     def __import_series(self, filename):
         """Import a series of patches
         """
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
 
         if filename:
             f = file(filename)
diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index 9ffcaaa..bdccacd 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -37,4 +37,4 @@ class concreteCommand(Command):
         if len(self.args) != 0:
             self.parser.error('incorrect number of arguments')
 
-        crt_series.init()
+        self.current_head().init()
diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index 6b85975..d314c9a 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -86,17 +86,17 @@ class concreteCommand(Command):
         """Show the patch changelog
         """
         if len(self.args) == 0:
-            name = crt_series.get_current()
+            name = self.current_head().get_current()
             if not name:
                 raise CmdException, 'No patches applied'
         elif len(self.args) == 1:
             name = self.args[0]
-            if not name in crt_series.get_applied() + crt_series.get_unapplied():
+            if not name in self.current_head().get_applied() + self.current_head().get_unapplied():
                 raise CmdException, 'Unknown patch "%s"' % name
         else:
             self.parser.error('incorrect number of arguments')
 
-        patch = crt_series.get_patch(name)
+        patch = self.current_head().get_patch(name)
 
         log = patch.get_log()
         if not log:
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index cdc0e2a..258cc7f 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -350,7 +350,7 @@ class concreteCommand(Command):
     def __build_message(self, tmpl, patch, patch_nr, total_nr, msg_id, ref_id):
         """Build the message to be sent via SMTP
         """
-        p = crt_series.get_patch(patch)
+        p = self.current_head().get_patch(patch)
 
         descr = p.get_description().strip()
         descr_lines = descr.split('\n')
@@ -463,12 +463,12 @@ class concreteCommand(Command):
         """
         smtpserver = config.get('stgit.smtpserver')
 
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
 
         if self.flags.all:
             patches = applied
         elif len(self.args) >= 1:
-            unapplied = crt_series.get_unapplied()
+            unapplied = self.current_head().get_unapplied()
             patches = parse_patches(self.args, applied + unapplied, len(applied))
         else:
             raise CmdException, 'Incorrect options. Unknown patches to send'
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 87f3874..4149c58 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -74,10 +74,10 @@ class concreteCommand(Command):
         if self.flags.author:
             self.flags.authname, self.flags.authemail = name_email(self.flags.author)
 
-        crt_series.new_patch(name, message = self.flags.message,
-                             show_patch = self.flags.showpatch,
-                             author_name = self.flags.authname,
-                             author_email = self.flags.authemail,
-                             author_date = self.flags.authdate,
-                             committer_name = self.flags.commname,
-                             committer_email = self.flags.commemail)
+        self.current_head().new_patch(name, message = self.flags.message,
+                                      show_patch = self.flags.showpatch,
+                                      author_name = self.flags.authname,
+                                      author_email = self.flags.authemail,
+                                      author_date = self.flags.authdate,
+                                      committer_name = self.flags.commname,
+                                      committer_email = self.flags.commemail)
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index 7bf8920..f4abea6 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -51,18 +51,18 @@ class concreteCommand(Command):
         if len(self.args) < 1:
             self.parser.error('incorrect number of arguments')
 
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
         if not applied:
             raise CmdException, 'No patches applied'
 
-        revs = git.modifying_revs(self.args, crt_series.get_base(),
-                                  crt_series.get_head())
+        revs = git.modifying_revs(self.args, self.current_head().get_base(),
+                                  self.current_head().get_head())
         revs.reverse()
 
         # build the patch/revision mapping
         rev_patch = dict()
         for name in applied:
-            patch = crt_series.get_patch(name)
+            patch = self.current_head().get_patch(name)
             rev_patch[patch.get_top()] = patch
 
         # print the patch names
diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 6ec8be3..0fb7282 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -68,7 +68,7 @@ class concreteCommand(Command):
         commit = git.Commit(commit_id)
 
         if self.flags.fold or self.flags.update:
-            if not crt_series.get_current():
+            if not self.current_head().get_current():
                 raise CmdException, 'No patches applied'
         else:
             patch_branch = commit_str.split('@')
@@ -117,11 +117,11 @@ class concreteCommand(Command):
 
             out.start('Importing commit %s' % commit_id)
 
-            newpatch = crt_series.new_patch(patchname, message = message, can_edit = False,
-                                            unapplied = True, bottom = bottom, top = top,
-                                            author_name = author_name,
-                                            author_email = author_email,
-                                            author_date = author_date)
+            newpatch = self.current_head().new_patch(patchname, message = message, can_edit = False,
+                                                     unapplied = True, bottom = bottom, top = top,
+                                                     author_name = author_name,
+                                                     author_email = author_email,
+                                                     author_date = author_date)
             # in case the patch name was automatically generated
             patchname = newpatch.get_name()
 
@@ -135,7 +135,7 @@ class concreteCommand(Command):
                     # commit_str to a git_id
                     refseries = Series(refbranchname)
                 else:
-                    refseries = crt_series
+                    refseries = self.current_head()
                 patch = refseries.get_patch(refpatchname)
                 if patch.get_log():
                     out.info("Log was %s" % newpatch.get_log())
@@ -146,11 +146,11 @@ class concreteCommand(Command):
                     out.info("No log for %s\n" % patchname)
 
             if not self.flags.unapplied:
-                modified = crt_series.push_patch(patchname)
+                modified = self.current_head().push_patch(patchname)
             else:
                 modified = False
 
-            if crt_series.empty_patch(patchname):
+            if self.current_head().empty_patch(patchname):
                 out.done('empty patch')
             elif modified:
                 out.done('modified')
diff --git a/stgit/commands/pop.py b/stgit/commands/pop.py
index 3b8b536..9a81c8a 100644
--- a/stgit/commands/pop.py
+++ b/stgit/commands/pop.py
@@ -56,7 +56,7 @@ class concreteCommand(Command):
         if not self.flags.keep:
             check_local_changes()
 
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
         if not applied:
             raise CmdException, 'No patches applied'
 
diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 06d9aa9..0824443 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -51,7 +51,7 @@ class concreteCommand(Command):
     def func(self):
         """Pull the changes from a remote repository
         """
-        policy = config.get('branch.%s.stgit.pull-policy' % crt_series.get_name()) or \
+        policy = config.get('branch.%s.stgit.pull-policy' % self.current_head_name()) or \
                  config.get('stgit.pull-policy')
 
         if policy == 'rebase':
@@ -69,9 +69,9 @@ class concreteCommand(Command):
             if len(self.args) >= 1:
                 repository = self.args[0]
             else:
-                repository = crt_series.get_parent_remote()
+                repository = self.current_head().get_parent_remote()
 
-        if crt_series.get_protected():
+        if self.current_head().get_protected():
             raise CmdException, 'This branch is protected. Pulls are not permitted'
 
         check_local_changes()
@@ -98,7 +98,7 @@ class concreteCommand(Command):
             git.fetch(repository)
             self.rebase(git.fetch_head())
         elif policy == 'rebase':
-            self.rebase(crt_series.get_parent_branch())
+            self.rebase(self.current_head().get_parent_branch())
 
         self.post_rebase(applied, self.flags.nopush, self.flags.merged)
 
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 0d41cad..10acbff 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -61,13 +61,13 @@ class concreteCommand(Command):
 
         # If --undo is passed, do the work and exit
         if self.flags.undo:
-            patch = crt_series.get_current()
+            patch = self.current_head().get_current()
             if not patch:
                 raise CmdException, 'No patch to undo'
 
             out.start('Undoing push of "%s"' % patch)
             resolved_all()
-            if crt_series.undo_push():
+            if self.current_head().undo_push():
                 out.done()
             else:
                 out.done('patch unchanged')
@@ -79,7 +79,7 @@ class concreteCommand(Command):
         check_conflicts()
         self.check_head_top_equal()
 
-        unapplied = crt_series.get_unapplied()
+        unapplied = self.current_head().get_unapplied()
         if not unapplied:
             raise CmdException, 'No more patches to push'
 
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index f953d6b..f14f244 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -46,7 +46,7 @@ class concreteCommand(Command):
         if len(self.args) != 1:
             self.parser.error('incorrect number of arguments')
 
-        if crt_series.get_protected():
+        if self.current_head().get_protected():
             raise CmdException, 'This branch is protected. Rebase is not permitted'
 
         check_local_changes()
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 90eb26b..4d6eac8 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -88,10 +88,10 @@ class concreteCommand(Command):
                 raise CmdException, \
                       'Only full refresh is available with the --patch option'
             patch = self.flags.patch
-            if not crt_series.patch_applied(patch):
+            if not self.current_head().patch_applied(patch):
                 raise CmdException, 'Patches "%s" not applied' % patch
         else:
-            patch = crt_series.get_current()
+            patch = self.current_head().get_current()
             if not patch:
                 raise CmdException, 'No patches applied'
 
@@ -100,7 +100,7 @@ class concreteCommand(Command):
 
         if self.flags.undo:
             out.start('Undoing the refresh of "%s"' % patch)
-            crt_series.undo_refresh()
+            self.current_head().undo_refresh()
             out.done()
             return
 
@@ -117,14 +117,14 @@ class concreteCommand(Command):
             sign_str = None
 
         if git.local_changes() \
-               or not crt_series.head_top_equal() \
+               or not self.current_head().head_top_equal() \
                or self.flags.edit or self.flags.message \
                or self.flags.authname or self.flags.authemail or self.flags.authdate \
                or self.flags.commname or self.flags.commemail \
                or self.flags.sign or self.flags.ack:
 
             if self.flags.patch:
-                applied = crt_series.get_applied()
+                applied = self.current_head().get_applied()
                 between = applied[:applied.index(patch):-1]
                 self.pop_patches(between, keep = True)
 
@@ -132,18 +132,18 @@ class concreteCommand(Command):
 
             if autoresolved == 'yes':
                 resolved_all()
-            crt_series.refresh_patch(files = self.args,
-                                     message = self.flags.message,
-                                     edit = self.flags.edit,
-                                     show_patch = self.flags.showpatch,
-                                     author_name = self.flags.authname,
-                                     author_email = self.flags.authemail,
-                                     author_date = self.flags.authdate,
-                                     committer_name = self.flags.commname,
-                                     committer_email = self.flags.commemail,
-                                     backup = True, sign_str = sign_str)
-
-            if crt_series.empty_patch(patch):
+            self.current_head().refresh_patch(files = self.args,
+                                              message = self.flags.message,
+                                              edit = self.flags.edit,
+                                              show_patch = self.flags.showpatch,
+                                              author_name = self.flags.authname,
+                                              author_email = self.flags.authemail,
+                                              author_date = self.flags.authdate,
+                                              committer_name = self.flags.commname,
+                                              committer_email = self.flags.commemail,
+                                              backup = True, sign_str = sign_str)
+
+            if self.current_head().empty_patch(patch):
                 out.done('empty patch')
             else:
                 out.done()
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index 5199a4a..8cf6cab 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -40,5 +40,5 @@ class concreteCommand(Command):
             self.parser.error('incorrect number of arguments')
 
         out.start('Renaming patch "%s" to "%s"' % (self.args[0], self.args[1]))
-        crt_series.rename_patch(self.args[0], self.args[1])
+        self.current_head().rename_patch(self.args[0], self.args[1])
         out.done()
diff --git a/stgit/commands/rm.py b/stgit/commands/rm.py
index 68714d0..35ca151 100644
--- a/stgit/commands/rm.py
+++ b/stgit/commands/rm.py
@@ -42,7 +42,7 @@ class concreteCommand(Command):
         if len(self.args) < 1:
             self.parser.error('incorrect number of arguments')
 
-        if not crt_series.get_current():
+        if not self.current_head().get_current():
             raise CmdException, 'No patches applied'
 
         git.rm(self.args, self.flags.force)
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index 2afa013..c9f0efc 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -74,7 +74,7 @@ class concreteCommand(Command):
     def __get_description(self, patch):
         """Extract and return a patch's short description
         """
-        p = crt_series.get_patch(patch)
+        p = self.current_head().get_patch(patch)
         descr = (p.get_description() or '').strip()
         descr_lines = descr.split('\n')
         return descr_lines[0].rstrip()
@@ -82,7 +82,7 @@ class concreteCommand(Command):
     def __get_author(self, patch):
         """Extract and return a patch's short description
         """
-        p = crt_series.get_patch(patch)
+        p = self.current_head().get_patch(patch)
         return p.get_authname();
 
     def __print_patch(self, patch, branch_str, prefix, empty_prefix, length):
@@ -90,7 +90,7 @@ class concreteCommand(Command):
         """
         if self.flags.noprefix:
             prefix = ''
-        elif self.flags.empty and crt_series.empty_patch(patch):
+        elif self.flags.empty and self.current_head().empty_patch(patch):
             prefix = empty_prefix
 
         patch_str = patch + branch_str
@@ -108,41 +108,38 @@ class concreteCommand(Command):
     def func(self):
         """Show the patch series
         """
-        global crt_series
 
         # current series patches
         if self.flags.invisible:
             applied = unapplied = []
-            hidden = crt_series.get_hidden()
+            hidden = self.current_head().get_hidden()
         elif self.flags.all:
-            applied = crt_series.get_applied()
-            unapplied = crt_series.get_unapplied()
-            hidden = crt_series.get_hidden()
+            applied = self.current_head().get_applied()
+            unapplied = self.current_head().get_unapplied()
+            hidden = self.current_head().get_hidden()
         else:
-            applied = crt_series.get_applied()
-            unapplied = crt_series.get_unapplied()
+            applied = self.current_head().get_applied()
+            unapplied = self.current_head().get_unapplied()
             hidden = []
 
         if self.flags.missing:
             # switch the series, the one specified with --missing should
             # become the current
-            cmp_series = crt_series
-            crt_series = stack.Series(self.flags.missing)
-            stgit.commands.common.crt_series = crt_series
+            miss_series = stack.Series(self.flags.missing)
 
             cmp_patches = applied + unapplied + hidden
 
             # new current series patches
             if self.flags.invisible:
                 applied = unapplied = []
-                hidden = crt_series.get_hidden()
+                hidden = miss_series.get_hidden()
             elif self.flags.all:
-                applied = crt_series.get_applied()
-                unapplied = crt_series.get_unapplied()
-                hidden = crt_series.get_hidden()
+                applied = miss_series.get_applied()
+                unapplied = miss_series.get_unapplied()
+                hidden = miss_series.get_hidden()
             else:
-                applied = crt_series.get_applied()
-                unapplied = crt_series.get_unapplied()
+                applied = miss_series.get_applied()
+                unapplied = miss_series.get_unapplied()
                 hidden = []
         else:
             cmp_patches = []
@@ -182,7 +179,7 @@ class concreteCommand(Command):
             return
 
         if self.flags.showbranch:
-            branch_str = '@' + crt_series.get_name()
+            branch_str = '@' + self.current_head_name()
         else:
             branch_str = ''
 
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index 5ff772f..4540f58 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -44,8 +44,8 @@ class concreteCommand(Command):
     def func(self):
         """Show commit log and diff
         """
-        applied = crt_series.get_applied()
-        unapplied = crt_series.get_unapplied()
+        applied = self.current_head().get_applied()
+        unapplied = self.current_head().get_unapplied()
 
         if self.flags.applied:
             patches = applied
@@ -55,7 +55,7 @@ class concreteCommand(Command):
             patches = ['HEAD']
         else:
             if len(self.args) == 1 and self.args[0].find('..') == -1 \
-                   and not crt_series.patch_exists(self.args[0]):
+                   and not self.current_head().patch_exists(self.args[0]):
                 # it might be just a commit id
                 patches = self.args
             else:
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index c3ef4d5..84d6bac 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -47,20 +47,20 @@ class concreteCommand(Command):
         check_conflicts()
         self.check_head_top_equal()
 
-        oldapplied = crt_series.get_applied()
-        unapplied = crt_series.get_unapplied()
+        oldapplied = self.current_head().get_applied()
+        unapplied = self.current_head().get_unapplied()
         all = unapplied + oldapplied
 
         if len(self.args) > 0:
             patches = parse_patches(self.args, all)
         else:
-            patches = [ crt_series.get_current() ]
+            patches = [ self.current_head().get_current() ]
 
-        crt_series.pop_patch(self.flags.to or oldapplied[0])
+        self.current_head().pop_patch(self.flags.to or oldapplied[0])
         self.push_patches(patches)
 
         if not self.flags.nopush:
-            newapplied = crt_series.get_applied()
+            newapplied = self.current_head().get_applied()
             def not_reapplied_yet(p):
                 return not p in newapplied
             self.push_patches(filter(not_reapplied_yet, oldapplied))
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 2882391..18d7394 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -67,7 +67,6 @@ class concreteCommand(Command):
     def func(self):
         """Synchronise a range of patches
         """
-        global crt_series
 
         if self.flags.undo:
             if self.flags.ref_branch or self.flags.series:
@@ -75,15 +74,15 @@ class concreteCommand(Command):
                       '--undo cannot be specified with --ref-branch or --series'
             self.__check_all()
 
-            out.start('Undoing the sync of "%s"' % crt_series.get_current())
-            crt_series.undo_refresh()
+            out.start('Undoing the sync of "%s"' % self.current_head().get_current())
+            self.current_head().undo_refresh()
             git.reset()
             out.done()
             return
 
         if self.flags.ref_branch:
             remote_series = stack.Series(self.flags.ref_branch)
-            if self.flags.ref_branch == crt_series.get_name():
+            if self.flags.ref_branch == self.current_head_name():
                 raise CmdException, 'Cannot synchronise with the current branch'
             remote_patches = remote_series.get_applied()
 
@@ -108,14 +107,14 @@ class concreteCommand(Command):
         else:
             raise CmdException, 'No remote branch or series specified'
 
-        applied = crt_series.get_applied()
+        applied = self.current_head().get_applied()
 
         if self.flags.all:
             patches = applied
         elif len(self.args) != 0:
             patches = parse_patches(self.args, applied, ordered = True)
         elif applied:
-            patches = [crt_series.get_current()]
+            patches = [self.current_head().get_current()]
         else:
             self.parser.error('no patches applied')
 
@@ -144,7 +143,7 @@ class concreteCommand(Command):
             # the actual sync
             out.start('Synchronising "%s"' % p)
 
-            patch = crt_series.get_patch(p)
+            patch = self.current_head().get_patch(p)
             bottom = patch.get_bottom()
             top = patch.get_top()
 
@@ -159,8 +158,8 @@ class concreteCommand(Command):
             if git.local_changes(verbose = False):
                 # index (cache) already updated by the git merge. The
                 # backup information was already reset above
-                crt_series.refresh_patch(cache_update = False, backup = False,
-                                         log = 'sync')
+                self.current_head().refresh_patch(cache_update = False, backup = False,
+                                                  log = 'sync')
                 out.done('updated')
             else:
                 out.done()
diff --git a/stgit/commands/top.py b/stgit/commands/top.py
index 88c03e2..ae57387 100644
--- a/stgit/commands/top.py
+++ b/stgit/commands/top.py
@@ -40,7 +40,7 @@ class concreteCommand(Command):
         if len(self.args) != 0:
             self.parser.error('incorrect number of arguments')
 
-        name = crt_series.get_current()
+        name = self.current_head().get_current()
         if name:
             out.stdout(name)
         else:
diff --git a/stgit/commands/unapplied.py b/stgit/commands/unapplied.py
index 083ed07..a5aaddc 100644
--- a/stgit/commands/unapplied.py
+++ b/stgit/commands/unapplied.py
@@ -44,7 +44,7 @@ class concreteCommand(Command):
         if len(self.args) != 0:
             self.parser.error('incorrect number of arguments')
 
-        unapplied = crt_series.get_unapplied()
+        unapplied = self.current_head().get_unapplied()
 
         if self.flags.count:
             out.stdout(len(unapplied))
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index ee2342f..48fda15 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -84,7 +84,7 @@ class concreteCommand(Command):
             patchnames = self.args
             patch_nr = len(patchnames)
 
-        if crt_series.get_protected():
+        if self.current_head().get_protected():
             raise CmdException, \
                   'This branch is protected. Uncommit is not permitted'
 
@@ -98,7 +98,7 @@ class concreteCommand(Command):
             return (commit, commit_id, parent)
 
         commits = []
-        next_commit = crt_series.get_base()
+        next_commit = self.current_head().get_base()
         if patch_nr:
             out.start('Uncommitting %d patches' % patch_nr)
             for i in xrange(patch_nr):
@@ -119,12 +119,12 @@ class concreteCommand(Command):
             zip(commits, patchnames or [None for i in xrange(len(commits))]):
             author_name, author_email, author_date = \
                          name_email_date(commit.get_author())
-            crt_series.new_patch(patchname,
-                                 can_edit = False, before_existing = True,
-                                 top = commit_id, bottom = parent,
-                                 message = commit.get_log(),
-                                 author_name = author_name,
-                                 author_email = author_email,
-                                 author_date = author_date)
+            self.current_head().new_patch(patchname,
+                                          can_edit = False, before_existing = True,
+                                          top = commit_id, bottom = parent,
+                                          message = commit.get_log(),
+                                          author_name = author_name,
+                                          author_email = author_email,
+                                          author_date = author_date)
 
         out.done()
diff --git a/stgit/commands/unhide.py b/stgit/commands/unhide.py
index 01d4b18..f9817c3 100644
--- a/stgit/commands/unhide.py
+++ b/stgit/commands/unhide.py
@@ -38,12 +38,12 @@ class concreteCommand(Command):
         """
         if self.args:
             # parsing all the patches for a more meaningful error reporting
-            all_patches = crt_series.get_applied() + crt_series.get_unapplied() \
-                          + crt_series.get_hidden()
+            all_patches = self.current_head().get_applied() + self.current_head().get_unapplied() \
+                          + self.current_head().get_hidden()
             patches = parse_patches(self.args, all_patches)
         else:
             self.parser.error('No patches specified')
 
         for patch in patches:
-            crt_series.unhide_patch(patch)
+            self.current_head().unhide_patch(patch)
             out.info('Patch "%s" unhidden' % patch)
diff --git a/stgit/main.py b/stgit/main.py
index 1fd5df9..1871cd3 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -271,13 +271,6 @@ def main():
 
     try:
         config_setup()
-
-        # 'clone' doesn't expect an already initialised GIT tree. A Series
-        # object will be created after the GIT tree is cloned
-        if cmd != 'clone':
-            command_module.crt_series = command.current_head()
-            stgit.commands.common.crt_series = command_module.crt_series
-
         command.func()
     except (IOError, ParsingError, NoSectionError, CmdException,
             StackException, GitException, GitMergeException,
