From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 06/10] New command: stg reset
Date: Mon, 21 Apr 2008 00:10:55 +0200
Message-ID: <20080420221055.5837.81513.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:12:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnhlY-000853-8U
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbYDTWLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbYDTWLD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:11:03 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3194 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbYDTWK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:10:59 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JnhkL-00082l-00; Sun, 20 Apr 2008 23:10:53 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79996>

Given a commit object from the log, resets the stack (or just the
named patches) to the state given by that log entry.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/reset.py |  114 +++++++++++++++++++++++++++++++++++
 stgit/main.py           |    2 +
 t/t3100-reset.sh        |  151 +++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 267 insertions(+), 0 deletions(-)
 create mode 100644 stgit/commands/reset.py
 create mode 100755 t/t3100-reset.sh


diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
new file mode 100644
index 0000000..e27f440
--- /dev/null
+++ b/stgit/commands/reset.py
@@ -0,0 +1,114 @@
+# -*- coding: utf-8 -*-
+
+__copyright__ =3D """
+Copyright (C) 2008, Karl Hasselstr=C3=B6m <kha@treskal.com>
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
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
+"""
+
+from stgit.commands import common
+from stgit.lib import git, log, transaction
+from stgit.out import out
+
+help =3D 'reset the patch stack to an earlier state'
+usage =3D """%prog <state> [<patchnames>]
+
+Reset the patch stack to an earlier state. The state is specified with
+a commit from a stack log; for a branch foo, StGit stores the stack
+log in foo.stgit^. So to undo the last N StGit commands, you would say
+
+  stg reset foo.stgit^~N
+
+or, if you are not sure how many steps to undo, you can view the log
+with "git log" or gitk
+
+  gitk foo.stgit^
+
+and then reset to any sha1 you see in the log.
+
+If one or more patch names are given, reset only those patches, and
+leave the rest alone."""
+
+directory =3D common.DirectoryHasRepositoryLib()
+options =3D []
+
+def reset_stack(stack, iw, state, only_patches):
+    only_patches =3D set(only_patches)
+    def mask(s):
+        if only_patches:
+            return s & only_patches
+        else:
+            return s
+    patches_to_reset =3D mask(set(state.applied + state.unapplied))
+    existing_patches =3D set(stack.patchorder.all)
+    to_delete =3D mask(existing_patches - patches_to_reset)
+    trans =3D transaction.StackTransaction(stack, 'stg reset')
+
+    # If we have to change the stack base, we need to pop all patches
+    # first.
+    if not only_patches and trans.base !=3D state.base:
+        trans.pop_patches(lambda pn: True)
+        out.info('Setting stack base to %s' % state.base.sha1)
+        trans.base =3D state.base
+
+    # In one go, do all the popping we have to in order to pop the
+    # patches we're going to delete or modify.
+    def mod(pn):
+        if only_patches and not pn in only_patches:
+            return False
+        if pn in to_delete:
+            return True
+        if stack.patches.get(pn).commit !=3D state.patches.get(pn, Non=
e):
+            return True
+        return False
+    trans.pop_patches(mod)
+
+    # Delete and modify/create patches. We've previously popped all
+    # patches that we touch in this step.
+    trans.delete_patches(lambda pn: pn in to_delete)
+    for pn in patches_to_reset:
+        if pn in existing_patches:
+            if trans.patches[pn] =3D=3D state.patches[pn]:
+                continue
+            else:
+                out.info('Resetting %s' % pn)
+        else:
+            trans.unapplied.append(pn)
+            out.info('Resurrecting %s' % pn)
+        trans.patches[pn] =3D state.patches[pn]
+
+    # Push/pop patches as necessary.
+    try:
+        if only_patches:
+            # Push all the patches that we've popped, if they still
+            # exist.
+            pushable =3D set(trans.unapplied)
+            for pn in stack.patchorder.applied:
+                if pn in pushable:
+                    trans.push_patch(pn, iw)
+        else:
+            # Recreate the exact order specified by the goal state.
+            trans.reorder_patches(state.applied, state.unapplied, iw)
+    except transaction.TransactionHalted:
+        pass
+    return trans.run(iw)
+
+def func(parser, options, args):
+    stack =3D directory.repository.current_stack
+    if len(args) >=3D 1:
+        ref, patches =3D args[0], args[1:]
+        state =3D log.Log(stack.repository, ref, stack.repository.rev_=
parse(ref))
+    else:
+        raise common.CmdException('Wrong number of arguments')
+    return reset_stack(stack, stack.repository.default_iw, state, patc=
hes)
diff --git a/stgit/main.py b/stgit/main.py
index bd1a187..948f923 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -89,6 +89,7 @@ commands =3D Commands({
     'refresh':          'refresh',
     'rename':           'rename',
     'repair':           'repair',
+    'reset':            'reset',
     'resolved':         'resolved',
     'series':           'series',
     'show':             'show',
@@ -122,6 +123,7 @@ stackcommands =3D (
     'push',
     'rebase',
     'repair',
+    'reset',
     'series',
     'sink',
     'top',
diff --git a/t/t3100-reset.sh b/t/t3100-reset.sh
new file mode 100755
index 0000000..1805091
--- /dev/null
+++ b/t/t3100-reset.sh
@@ -0,0 +1,151 @@
+#!/bin/sh
+
+test_description=3D'Simple test cases for "stg reset"'
+
+. ./test-lib.sh
+
+# Ignore our own output files.
+cat > .git/info/exclude <<EOF
+/expected.txt
+EOF
+
+test_expect_success 'Initialize StGit stack with three patches' '
+    stg init &&
+    echo 000 >> a &&
+    git add a &&
+    git commit -m a &&
+    echo 111 >> a &&
+    git commit -a -m p1 &&
+    echo 222 >> a &&
+    git commit -a -m p2 &&
+    echo 333 >> a &&
+    git commit -a -m p3 &&
+    stg uncommit -n 3 &&
+    stg pop
+'
+
+cat > expected.txt <<EOF
+000
+111
+EOF
+test_expect_success 'Pop one patch ...' '
+    stg pop &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "p2 p3" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success '... and undo it' '
+    stg reset master.stgit^~1 &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+333
+EOF
+test_expect_success 'Push one patch ...' '
+    stg push &&
+    test "$(echo $(stg applied))" =3D "p1 p2 p3" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success '... and undo it' '
+    stg reset master.stgit^~1 &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3" &&
+    test_cmp expected.txt a
+'
+
+test_expect_success 'Commit one patch ...' '
+    stg commit &&
+    test "$(echo $(stg applied))" =3D "p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3"
+'
+
+test_expect_success '... and undo it' '
+    stg reset master.stgit^~1 &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3"
+'
+
+cat > expected.txt <<EOF
+000
+111
+EOF
+test_expect_success 'Delete two patches ...' '
+    stg delete p2 p3 &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+test_expect_success '... and undo one of the deletions ...' '
+    stg reset master.stgit^~1 p3 &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "p3" &&
+    test_cmp expected.txt a
+'
+
+test_expect_success '... then undo the first undo ...' '
+    stg reset master.stgit^~1 &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success '... and undo the other deletion' '
+    stg reset master.stgit^~3 p2 &&
+    stg push p2 &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+ggg
+EOF
+test_expect_success 'Refresh a patch ...' '
+    echo ggg >> a &&
+    stg refresh &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success '... and undo the refresh' '
+    stg reset master.stgit^~1 &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+test_done
