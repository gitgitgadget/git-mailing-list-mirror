From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] New command: stg redo
Date: Wed, 14 May 2008 03:49:34 +0200
Message-ID: <20080514014934.7235.19766.stgit@yoghurt>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 03:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw68V-0005BM-IH
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 03:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756987AbYENBtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2008 21:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757181AbYENBtl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 21:49:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4095 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121AbYENBtk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 21:49:40 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jw67a-0004jD-00; Wed, 14 May 2008 02:49:35 +0100
In-Reply-To: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.2.152.g77bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82065>

Command for undoing an undo.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/redo.py |   21 +++++++++------
 stgit/lib/log.py       |   19 ++++++++++----
 stgit/main.py          |    2 +
 t/t3104-redo.sh        |   66 +++++++++++++++++++++++++++++++++++++---=
--------
 4 files changed, 79 insertions(+), 29 deletions(-)
 copy stgit/commands/{undo.py =3D> redo.py} (71%)
 copy t/{t3102-undo.sh =3D> t3104-redo.sh} (53%)


diff --git a/stgit/commands/undo.py b/stgit/commands/redo.py
similarity index 71%
copy from stgit/commands/undo.py
copy to stgit/commands/redo.py
index b1d7de9..47221a5 100644
--- a/stgit/commands/undo.py
+++ b/stgit/commands/redo.py
@@ -19,28 +19,31 @@ Foundation, Inc., 59 Temple Place, Suite 330, Bosto=
n, MA 02111-1307 USA
=20
 from optparse import make_option
 from stgit.commands import common
-from stgit.lib import git, log, transaction
-from stgit.out import out
+from stgit.lib import log, transaction
=20
-help =3D 'undo the last operation'
+help =3D 'undo the last undo operation'
 usage =3D """%prog [options]
=20
-Reset the patch stack to the previous state. Consecutive invocations
-of "stg undo" will take you ever further into the past."""
+If the last command was an undo, reset the patch stack to the state it
+had before the undo. Consecutive invocations of "stg redo" will undo
+the effects of consecutive invocations of "stg undo".
+
+It is an error to run "stg redo" if the last command was not an
+undo."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-n', '--number', type =3D 'int', metavar =3D=
 'N',
                        default =3D 1,
-                       help =3D 'undo the last N commands'),
+                       help =3D 'undo the last N undos'),
            make_option('--hard', action =3D 'store_true',
                        help =3D 'discard changes in your index/worktre=
e')]
=20
 def func(parser, options, args):
     stack =3D directory.repository.current_stack
     if options.number < 1:
-        raise common.CmdException('Bad number of commands to undo')
-    state =3D log.undo_state(stack, options.number)
-    trans =3D transaction.StackTransaction(stack, 'undo %d' % options.=
number,
+        raise common.CmdException('Bad number of undos to redo')
+    state =3D log.undo_state(stack, -options.number)
+    trans =3D transaction.StackTransaction(stack, 'redo %d' % options.=
number,
                                          discard_changes =3D options.h=
ard)
     try:
         log.reset_stack(trans, stack.repository.default_iw, state, [])
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index a82d4bc..d2a2ba7 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -243,13 +243,22 @@ def reset_stack(trans, iw, state, only_patches):
 def undo_state(stack, undo_steps):
     ref =3D log_ref(stack.name)
     log =3D Log(stack.repository, ref, stack.repository.refs.get(ref))
-    while undo_steps > 0:
+    while undo_steps !=3D 0:
         msg =3D log.commit.data.message.strip()
-        m =3D re.match(r'^undo\s+(\d+)$', msg)
-        if m:
-            undo_steps +=3D int(m.group(1))
+        um =3D re.match(r'^undo\s+(\d+)$', msg)
+        if undo_steps > 0:
+            if um:
+                undo_steps +=3D int(um.group(1))
+            else:
+                undo_steps -=3D 1
         else:
-            undo_steps -=3D 1
+            rm =3D re.match(r'^redo\s+(\d+)$', msg)
+            if um:
+                undo_steps +=3D 1
+            elif rm:
+                undo_steps -=3D int(rm.group(1))
+            else:
+                raise LogException('No more redo information available=
')
         if not log.parents:
             raise LogException('Not enough undo information available'=
)
         log =3D Log(stack.repository, log.parents[0].sha1, log.parents=
[0])
diff --git a/stgit/main.py b/stgit/main.py
index cf7b404..c53abf7 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -86,6 +86,7 @@ commands =3D Commands({
     'pull':             'pull',
     'push':             'push',
     'rebase':           'rebase',
+    'redo':             'redo',
     'refresh':          'refresh',
     'rename':           'rename',
     'repair':           'repair',
@@ -123,6 +124,7 @@ stackcommands =3D (
     'pull',
     'push',
     'rebase',
+    'redo',
     'repair',
     'reset',
     'series',
diff --git a/t/t3102-undo.sh b/t/t3104-redo.sh
similarity index 53%
copy from t/t3102-undo.sh
copy to t/t3104-redo.sh
index 1093f70..290fc6f 100755
--- a/t/t3102-undo.sh
+++ b/t/t3104-redo.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
=20
-test_description=3D'Simple test cases for "stg undo"'
+test_description=3D'Simple test cases for "stg redo"'
=20
 . ./test-lib.sh
=20
@@ -20,18 +20,18 @@ test_expect_success 'Initialize StGit stack with th=
ree patches' '
     git commit -a -m p2 &&
     echo 333 >> a &&
     git commit -a -m p3 &&
-    stg uncommit -n 3 &&
-    stg pop
+    stg uncommit -n 3
 '
=20
 cat > expected.txt <<EOF
 000
 111
+222
 EOF
 test_expect_success 'Pop one patch ...' '
     stg pop &&
-    test "$(echo $(stg applied))" =3D "p1" &&
-    test "$(echo $(stg unapplied))" =3D "p2 p3" &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "p3" &&
     test_cmp expected.txt a
 '
=20
@@ -39,9 +39,22 @@ cat > expected.txt <<EOF
 000
 111
 222
+333
 EOF
-test_expect_success '... and undo it' '
+test_expect_success '... undo it ...' '
     stg undo &&
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
+test_expect_success '... and redo' '
+    stg redo &&
     test "$(echo $(stg applied))" =3D "p1 p2" &&
     test "$(echo $(stg unapplied))" =3D "p3" &&
     test_cmp expected.txt a
@@ -50,7 +63,9 @@ test_expect_success '... and undo it' '
 cat > expected.txt <<EOF
 000
 EOF
-test_expect_success 'Pop two patches ...' '
+test_expect_success 'Pop three patches ...' '
+    stg push &&
+    stg pop &&
     stg pop &&
     stg pop &&
     test "$(echo $(stg applied))" =3D "" &&
@@ -62,24 +77,45 @@ cat > expected.txt <<EOF
 000
 111
 222
+333
 EOF
-test_expect_success '... and undo it' '
+test_expect_success '... undo it ...' '
     stg undo &&
     stg undo &&
-    test "$(echo $(stg applied))" =3D "p1 p2" &&
-    test "$(echo $(stg unapplied))" =3D "p3" &&
+    stg undo &&
+    test "$(echo $(stg applied))" =3D "p1 p2 p3" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
     test_cmp expected.txt a
 '
=20
 cat > expected.txt <<EOF
 000
 111
-222
 EOF
-test_expect_success 'Undo past end of history' '
-    ! stg undo -n 100 &&
-    test "$(echo $(stg applied))" =3D "p1 p2" &&
-    test "$(echo $(stg unapplied))" =3D "p3" &&
+test_expect_success '... redo the first two pops ...' '
+    stg redo -n 2 &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "p2 p3" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+EOF
+test_expect_success '... and the remaining one' '
+    stg redo &&
+    test "$(echo $(stg applied))" =3D "" &&
+    test "$(echo $(stg unapplied))" =3D "p1 p2 p3" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+EOF
+test_expect_success 'Redo past end of history' '
+    ! stg redo &&
+    test "$(echo $(stg applied))" =3D "" &&
+    test "$(echo $(stg unapplied))" =3D "p1 p2 p3" &&
     test_cmp expected.txt a
 '
=20
