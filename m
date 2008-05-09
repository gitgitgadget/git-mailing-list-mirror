From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] New command: stg undo
Date: Fri, 09 May 2008 02:44:35 +0200
Message-ID: <20080509004434.20312.14243.stgit@yoghurt>
References: <20080509003824.20312.17819.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 02:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuGk3-0003IH-I0
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 02:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143AbYEIAo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 20:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755071AbYEIAo4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 20:44:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1856 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbYEIAoj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 20:44:39 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JuGiv-0004a3-00; Fri, 09 May 2008 01:44:34 +0100
In-Reply-To: <20080509003824.20312.17819.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81579>

Basically, this is just a user-friendly way to access a subset of the
functionality of "stg reset".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/undo.py  |   38 +++++++--------------
 stgit/lib/log.py        |   19 ++++++++++
 stgit/main.py           |    2 +
 t/t3102-undo.sh         |   86 +++++++++++++++++++++++++++++++++++++++=
++++++++
 t/t3103-undo-hard.sh    |   10 +++--
 5 files changed, 125 insertions(+), 30 deletions(-)
 copy stgit/commands/{reset.py =3D> undo.py} (58%)
 create mode 100755 t/t3102-undo.sh
 copy t/{t3101-reset-hard.sh =3D> t3103-undo-hard.sh} (82%)


diff --git a/stgit/commands/reset.py b/stgit/commands/undo.py
similarity index 58%
copy from stgit/commands/reset.py
copy to stgit/commands/undo.py
index 2bbac8b..b1d7de9 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/undo.py
@@ -22,40 +22,28 @@ from stgit.commands import common
 from stgit.lib import git, log, transaction
 from stgit.out import out
=20
-help =3D 'reset the patch stack to an earlier state'
-usage =3D """%prog [options] <state> [<patchnames>]
+help =3D 'undo the last operation'
+usage =3D """%prog [options]
=20
-Reset the patch stack to an earlier state. The state is specified with
-a commit from a stack log; for a branch foo, StGit stores the stack
-log in foo.stgit^. So to undo the last N StGit commands, you would say
-
-  stg reset foo.stgit^~N
-
-or, if you are not sure how many steps to undo, you can view the log
-with "git log" or gitk
-
-  gitk foo.stgit^
-
-and then reset to any sha1 you see in the log.
-
-If one or more patch names are given, reset only those patches, and
-leave the rest alone."""
+Reset the patch stack to the previous state. Consecutive invocations
+of "stg undo" will take you ever further into the past."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
-options =3D [make_option('--hard', action =3D 'store_true',
+options =3D [make_option('-n', '--number', type =3D 'int', metavar =3D=
 'N',
+                       default =3D 1,
+                       help =3D 'undo the last N commands'),
+           make_option('--hard', action =3D 'store_true',
                        help =3D 'discard changes in your index/worktre=
e')]
=20
 def func(parser, options, args):
     stack =3D directory.repository.current_stack
-    if len(args) >=3D 1:
-        ref, patches =3D args[0], args[1:]
-        state =3D log.Log(stack.repository, ref, stack.repository.rev_=
parse(ref))
-    else:
-        raise common.CmdException('Wrong number of arguments')
-    trans =3D transaction.StackTransaction(stack, 'reset',
+    if options.number < 1:
+        raise common.CmdException('Bad number of commands to undo')
+    state =3D log.undo_state(stack, options.number)
+    trans =3D transaction.StackTransaction(stack, 'undo %d' % options.=
number,
                                          discard_changes =3D options.h=
ard)
     try:
-        log.reset_stack(trans, stack.repository.default_iw, state, pat=
ches)
+        log.reset_stack(trans, stack.repository.default_iw, state, [])
     except transaction.TransactionHalted:
         pass
     return trans.run(stack.repository.default_iw)
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index dfc2b9f..6d9fc6e 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -1,3 +1,4 @@
+import re
 from stgit.lib import git, stack
 from stgit import exception
 from stgit.out import out
@@ -155,6 +156,9 @@ class Log(object):
             self.base =3D self.patches[self.applied[0]].data.parent
         else:
             self.base =3D self.head
+    @property
+    def parents(self):
+        return self.commit.data.parents[2:]
=20
 class FullLog(Log):
     full_log =3D property(lambda self: self.commit)
@@ -237,3 +241,18 @@ def reset_stack(trans, iw, state, only_patches):
     else:
         # Recreate the exact order specified by the goal state.
         trans.reorder_patches(state.applied, state.unapplied, iw)
+
+def undo_state(stack, undo_steps):
+    ref =3D log_ref(stack.name)
+    log =3D Log(stack.repository, ref, stack.repository.refs.get(ref))
+    while undo_steps > 0:
+        msg =3D log.commit.data.message.strip()
+        m =3D re.match(r'^undo\s+(\d+)$', msg)
+        if m:
+            undo_steps +=3D int(m.group(1))
+        else:
+            undo_steps -=3D 1
+        if not log.parents:
+            raise LogException('Not enough undo information available'=
)
+        log =3D Log(stack.repository, log.parents[0].sha1, log.parents=
[0])
+    return log
diff --git a/stgit/main.py b/stgit/main.py
index 83e6b08..cf7b404 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -99,6 +99,7 @@ commands =3D Commands({
     'top':              'top',
     'unapplied':        'unapplied',
     'uncommit':         'uncommit',
+    'undo':             'undo',
     'unhide':           'unhide'
     })
=20
@@ -129,6 +130,7 @@ stackcommands =3D (
     'top',
     'unapplied',
     'uncommit',
+    'undo',
     'unhide',
     )
 patchcommands =3D (
diff --git a/t/t3102-undo.sh b/t/t3102-undo.sh
new file mode 100755
index 0000000..1093f70
--- /dev/null
+++ b/t/t3102-undo.sh
@@ -0,0 +1,86 @@
+#!/bin/sh
+
+test_description=3D'Simple test cases for "stg undo"'
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
+    stg undo &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+EOF
+test_expect_success 'Pop two patches ...' '
+    stg pop &&
+    stg pop &&
+    test "$(echo $(stg applied))" =3D "" &&
+    test "$(echo $(stg unapplied))" =3D "p1 p2 p3" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success '... and undo it' '
+    stg undo &&
+    stg undo &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success 'Undo past end of history' '
+    ! stg undo -n 100 &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3" &&
+    test_cmp expected.txt a
+'
+
+test_done
diff --git a/t/t3101-reset-hard.sh b/t/t3103-undo-hard.sh
similarity index 82%
copy from t/t3101-reset-hard.sh
copy to t/t3103-undo-hard.sh
index 1e02805..21412f7 100755
--- a/t/t3101-reset-hard.sh
+++ b/t/t3103-undo-hard.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-test_description=3D'Simple test cases for "stg reset"'
+test_description=3D'Simple test cases for "stg undo"'
=20
 . ./test-lib.sh
=20
@@ -35,8 +35,8 @@ test_expect_success 'Pop middle patch, creating a con=
flict' '
     test "$(echo $(stg unapplied))" =3D "p2"
 '
=20
-test_expect_success 'Try to reset without --hard' '
-    ! stg reset master.stgit^~1 &&
+test_expect_success 'Try to undo without --hard' '
+    ! stg undo &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
     test "$(echo $(stg applied))" =3D "p1 p3" &&
@@ -45,8 +45,8 @@ test_expect_success 'Try to reset without --hard' '
=20
 cat > expected.txt <<EOF
 EOF
-test_expect_success 'Try to reset with --hard' '
-    stg reset --hard master.stgit^~1 &&
+test_expect_success 'Try to undo with --hard' '
+    stg undo --hard &&
     stg status a > actual.txt &&
     test_cmp expected.txt actual.txt &&
     test "$(echo $(stg applied))" =3D "p1" &&
