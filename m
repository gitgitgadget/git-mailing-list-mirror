From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Thu, 28 May 2009 12:12:42 +0100
Message-ID: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu May 28 13:12:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9dXd-0004nG-Ik
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 13:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbZE1LMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 07:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbZE1LMr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 07:12:47 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:64037 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752031AbZE1LMq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 07:12:46 -0400
Received: from cam-owa1.Emea.Arm.com (cam-owa1.emea.arm.com [10.1.255.62])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n4SBBLZm007797;
	Thu, 28 May 2009 12:11:21 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa1.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 28 May 2009 12:12:43 +0100
User-Agent: StGit/0.14.3.378.gafeb
X-OriginalArrivalTime: 28 May 2009 11:12:43.0137 (UTC) FILETIME=[38AE6F10:01C9DF85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120183>

The main issue with publishing StGit branches is that the Git history
represented by patches is volatile, making it difficult for people
wanting to merge such branch. One solution is for all the downstream
developers to always rebase but that's not always desirable. Another
solution is provided by tools like TopGit but the visible Git history
becomes complicated, especially with repeated reordering.

The patch proposes a new StGit command called "publish". This command
allows one to develop patches normally on a StGit branch but publish the
stack changes to a separate, merge-friendly branch whose history is not
re-writable.

More about its behaviour can be found in the command description in this
patch.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/common.py  |   26 ++++++++
 stgit/commands/new.py     |   22 -------
 stgit/commands/publish.py |  139 +++++++++++++++++++++++++++++++++++++++++++++
 stgit/lib/git.py          |    5 ++
 t/t4100-publish.sh        |  129 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 300 insertions(+), 21 deletions(-)
 create mode 100644 stgit/commands/publish.py
 create mode 100755 t/t4100-publish.sh

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index e46412e..04314f3 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -447,6 +447,32 @@ def readonly_constant_property(f):
         return getattr(self, n)
     return property(new_f)
 
+def update_commit_data(cd, options, allow_edit = False):
+    """Return a new CommitData object updated according to the command line
+    options."""
+    # Set the commit message from commandline.
+    if options.message != None:
+        cd = cd.set_message(options.message)
+
+    # Modify author data.
+    cd = cd.set_author(options.author(cd.author))
+
+    # Add Signed-off-by: or similar.
+    if options.sign_str != None:
+        sign_str = options.sign_str
+    else:
+        sign_str = config.get("stgit.autosign")
+    if sign_str != None:
+        cd = cd.set_message(
+            add_sign_line(cd.message, sign_str,
+                          cd.committer.name, cd.committer.email))
+
+    # Let user edit the commit message manually.
+    if allow_edit and not options.message:
+        cd = cd.set_message(edit_string(cd.message, '.stgit-new.txt'))
+
+    return cd
+
 class DirectoryException(StgException):
     pass
 
diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 2c98431..9fd51c3 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -67,32 +67,12 @@ def func(parser, options, args):
     cd = gitlib.CommitData(
         tree = stack.head.data.tree, parents = [stack.head], message = '',
         author = gitlib.Person.author(), committer = gitlib.Person.committer())
-
-    # Set patch commit message from commandline.
-    if options.message != None:
-        cd = cd.set_message(options.message)
-
-    # Modify author data.
-    cd = cd.set_author(options.author(cd.author))
-
-    # Add Signed-off-by: or similar.
-    if options.sign_str != None:
-        sign_str = options.sign_str
-    else:
-        sign_str = config.get("stgit.autosign")
-
-    if sign_str != None:
-        cd = cd.set_message(
-            utils.add_sign_line(cd.message, sign_str,
-                                cd.committer.name, cd.committer.email))
+    cd = common.update_commit_data(cd, options, allow_edit = True)
 
     if options.save_template:
         options.save_template(cd.message)
         return utils.STGIT_SUCCESS
 
-    # Let user edit the commit message manually.
-    if not options.message:
-        cd = cd.set_message(utils.edit_string(cd.message, '.stgit-new.txt'))
     if name == None:
         name = utils.make_patch_name(cd.message,
                                      lambda name: stack.patches.exists(name))
diff --git a/stgit/commands/publish.py b/stgit/commands/publish.py
new file mode 100644
index 0000000..06c32d0
--- /dev/null
+++ b/stgit/commands/publish.py
@@ -0,0 +1,139 @@
+__copyright__ = """
+Copyright (C) 2009, Catalin Marinas <catalin.marinas@gmail.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+from stgit import argparse
+from stgit.argparse import opt
+from stgit.commands import common
+from stgit.config import config
+from stgit.lib import git, stack
+from stgit.out import out
+
+help = 'Publish the stack changes to a merge-friendly head'
+kind = 'stack'
+usage = ['[options] [branch]']
+description = """
+This command commits a set of changes on a separate (called public) branch
+based on the modifications of the given or current stack. The history of the
+public branch is not re-written, making it merge-friendly and feasible for
+publishing. The heads of the stack and public branch may be different but the
+corresponding tree objects are always the same.
+
+If the trees of the stack and public branch are different (otherwise the
+command has no effect), StGit first checks for a rebase of the stack since the
+last publishing. If a rebase is detected, StGit creates a commit on the public
+branch corresponding to a merge between the new stack base and the latest
+public head.
+
+If no rebasing was detected, StGit checks for new patches that may have been
+created on top of the stack since the last publishing. If new patches are
+found and are not empty, they are checked into the public branch keeping the
+same commit information (e.g. log message, author, committer, date).
+
+If the above tests fail (e.g. patches modified or removed), StGit creates a
+new commit on the public branch having the same tree as the stack but the
+public head as its parent. The editor will be invoked if no "--message" option
+is given.
+
+It is recommended that stack modifications falling in different categories as
+described above are separated by a publish command in order to keep the public
+branch history cleaner (otherwise StGit would generate a big commit including
+several stack modifications).
+
+The public branch name can be set via the branch.<branch>.public configuration
+variable (defaulting to "<branch>.public").
+"""
+
+args = [argparse.all_branches]
+options = [
+    opt('-b', '--branch', args = [argparse.stg_branches],
+        short = 'Use BRANCH instead of the default branch')
+] + (argparse.author_options()
+     + argparse.message_options(save_template = False)
+     + argparse.sign_options())
+
+directory = common.DirectoryHasRepositoryLib()
+
+def __create_commit(repository, tree, parents, options):
+    """Return a new Commit object."""
+    cd = git.CommitData(
+        tree = tree, parents = parents, message = '',
+        author = git.Person.author(), committer = git.Person.committer())
+    cd = common.update_commit_data(cd, options, allow_edit = True)
+
+    return repository.commit(cd)
+
+def func(parser, options, args):
+    """Publish the stack changes."""
+    repository = directory.repository
+    stack = repository.get_stack(options.branch)
+
+    if not args:
+        public_ref = config.get('branch.%s.public' % stack.name)
+        if not public_ref:
+            public_ref = 'refs/heads/%s.public' % stack.name
+    elif len(args) == 1:
+        public_ref = args[0]
+    else:
+        parser.error('incorrect number of arguments')
+
+    # just clone the stack if the public ref does not exist
+    if not repository.refs.exists(public_ref):
+        repository.refs.set(public_ref, stack.head, 'publish')
+        out.info('Created "%s"' % public_ref)
+        return
+
+    public_head = repository.refs.get(public_ref)
+    public_tree = public_head.data.tree
+
+    # check for same tree (already up to date)
+    if public_tree.sha1 == stack.head.data.tree.sha1:
+        out.info('"%s" already up to date' % public_ref)
+        return
+
+    # check for rebased stack. In this case we emulate a merge with the stack
+    # base by setting two parents.
+    merge_base = repository.get_merge_base(public_head, stack.base)
+    if merge_base.sha1 != stack.base.sha1:
+        public_head = __create_commit(repository, stack.head.data.tree,
+                                      [public_head, stack.base], options)
+        repository.refs.set(public_ref, public_head, 'publish')
+        out.info('Merged the stack base into "%s"' % public_ref)
+        return
+
+    # check for new patches from the last publishing. This is done by checking
+    # whether the public tree is the same as the bottom of the checked patch.
+    # If older patches were modified, new patches cannot be detected. The new
+    # patches and their metadata are pushed directly to the published head.
+    for p in stack.patchorder.applied:
+        pc = stack.patches.get(p).commit
+        if public_tree.sha1 == pc.data.parent.data.tree.sha1:
+            if pc.data.is_nochange():
+                out.info('Ignored new empty patch "%s"' % p)
+                continue
+            cd = pc.data.set_parent(public_head)
+            public_head = repository.commit(cd)
+            public_tree = public_head.data.tree
+            out.start('Published new patch "%s"' % p)
+
+    # create a new commit (only happens if no new patches are detected)
+    if public_tree.sha1 != stack.head.data.tree.sha1:
+        public_head = __create_commit(repository, stack.head.data.tree,
+                                      [public_head], options)
+
+    # update the public head
+    repository.refs.set(public_ref, public_head, 'publish')
+    out.info('Updated "%s"' % public_ref)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6f2c977..4a17c8a 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -609,6 +609,11 @@ class Repository(RunWithEnv):
             raise DetachedHeadException()
     def set_head_ref(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_output()
+    def get_merge_base(self, commit1, commit2):
+        """Return the merge base of two commits."""
+        sha1 = self.run(['git', 'merge-base',
+                         commit1.sha1, commit2.sha1]).output_one_line()
+        return self.get_commit(sha1)
     def simple_merge(self, base, ours, theirs):
         index = self.temp_index()
         try:
diff --git a/t/t4100-publish.sh b/t/t4100-publish.sh
new file mode 100755
index 0000000..17e07bc
--- /dev/null
+++ b/t/t4100-publish.sh
@@ -0,0 +1,129 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Catalin Marinas
+#
+
+test_description='Exercise the publish command.
+
+Create/modify patches on the stack and publish them to a separate branch.'
+
+. ./test-lib.sh
+
+test_same_tree () {
+	stack_tree=$(git rev-parse master^{tree})
+	public_tree=$(git rev-parse master.public^{tree})
+	test "$stack_tree" = "$public_tree"
+}
+
+test_expect_success \
+	'Initialize the StGit repository' \
+	'
+	stg init
+	'
+
+test_expect_success \
+	'Create some patches' \
+	'
+	stg new p1 -m p1 &&
+	echo foo1 > foo1.txt &&
+	git add foo1.txt &&
+	stg refresh &&
+	stg new p2 -m p2 &&
+	echo foo2 > foo2.txt &&
+	git add foo2.txt &&
+	stg refresh &&
+	stg new p3 -m p3 &&
+	echo foo3 > foo3.txt &&
+	git add foo3.txt &&
+	stg refresh
+	'
+
+test_expect_success \
+	'Publish the stack for the first time' \
+	'
+	stg publish &&
+	test "$(stg id)" = "$(stg id master.public)"
+	'
+
+test_expect_success \
+	'Modify a patch and publish the changes' \
+	'
+	stg pop &&
+	echo foo2 >> foo2.txt &&
+	stg refresh &&
+	stg push &&
+	old_public=$(stg id master.public) &&
+	stg publish -m "p2 updated" &&
+	test_same_tree &&
+	new_public=$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" = "1"
+	'
+
+test_expect_success \
+	'Create new patches and publish them' \
+	'
+	stg new p4 -m p4 &&
+	echo foo4 > foo4.txt &&
+	git add foo4.txt &&
+	stg refresh &&
+	stg new p5 -m p5 &&
+	echo foo5 > foo5.txt &&
+	git add foo5.txt &&
+	stg refresh &&
+	stg new empty -m empty &&
+	old_public=$(stg id master.public) &&
+	stg publish -m "Ignored message" &&
+	test_same_tree &&
+	new_public=$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" = "2"
+	'
+
+test_expect_success \
+	'Rebase the current stack and publish a merge' \
+	'
+	stg pop -a &&
+	echo foo0 > foo0.txt &&
+	git add foo0.txt &&
+	git commit -m "foo0.txt added" &&
+	stg push -a &&
+	old_public=$(stg id master.public) &&
+	stg publish -m "Merge with base" &&
+	test_same_tree &&
+	new_public=$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" = "2" &&
+	test "$(git merge-base master.public master)" = "$(stg id {base})"
+	'
+
+test_expect_success \
+	'Re-publish without any changes' \
+	'
+	old_public=$(stg id master.public) &&
+	stg publish -m "Ignored message" &&
+	test_same_tree &&
+	new_public=$(stg id master.public) &&
+	test "$old_public" = "$new_public"
+	'
+
+test_expect_success \
+	'Reorder patches and publish the changes' \
+	'
+	stg float p5 p4 p3 p2 p1 &&
+	old_public=$(stg id master.public) &&
+	stg publish -m "Ignored message" &&
+	test_same_tree &&
+	new_public=$(stg id master.public) &&
+	test "$old_public" = "$new_public"
+	'
+
+test_expect_success \
+	'Pop a patch and publish the changes' \
+	'
+	stg pop p3 &&
+	old_public=$(stg id master.public) &&
+	stg publish -m "p3 removed" &&
+	test_same_tree &&
+	new_public=$(stg id master.public) &&
+	test "$(git rev-list $old_public..$new_public | wc -l)" = "1"
+	'
+
+test_done
