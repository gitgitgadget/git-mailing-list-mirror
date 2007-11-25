From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 05/10] Add "stg coalesce"
Date: Sun, 25 Nov 2007 21:51:25 +0100
Message-ID: <20071125205125.7823.47538.stgit@yoghurt>
References: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOSw-0003t1-Kv
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756690AbXKYUvu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbXKYUvu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:50 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3579 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756645AbXKYUvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:48 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwORp-0007aL-00; Sun, 25 Nov 2007 20:51:25 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66002>

It coalesces two or more consecutive applied patches, with no need to
touch index/worktree, and no possibiliy of conflicts.

=46uture improvements could relax the "consecutive" and "applied"
restrictions, by building a new chain of commits just like "stg push"
will do once it's been converted to the new infrastructure.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 contrib/stgit-completion.bash |    2 +
 stgit/commands/coalesce.py    |   84 +++++++++++++++++++++++++++++++++=
++++++++
 stgit/main.py                 |    2 +
 stgit/utils.py                |   11 +++++
 t/t2600-coalesce.sh           |   31 +++++++++++++++
 5 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 stgit/commands/coalesce.py
 create mode 100755 t/t2600-coalesce.sh


diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.b=
ash
index b3b23d4..b02eb64 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -18,6 +18,7 @@ _stg_commands=3D"
     diff
     clean
     clone
+    coalesce
     commit
     cp
     edit
@@ -238,6 +239,7 @@ _stg ()
         # repository commands
         id)     _stg_patches $command _all_patches ;;
         # stack commands
+        coalesce) _stg_patches $command _applied_patches ;;
         float)  _stg_patches $command _all_patches ;;
         goto)   _stg_patches $command _all_other_patches ;;
         hide)   _stg_patches $command _unapplied_patches ;;
diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
new file mode 100644
index 0000000..c4c1cf8
--- /dev/null
+++ b/stgit/commands/coalesce.py
@@ -0,0 +1,84 @@
+# -*- coding: utf-8 -*-
+
+__copyright__ =3D """
+Copyright (C) 2007, Karl Hasselstr=C3=B6m <kha@treskal.com>
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
+from optparse import make_option
+from stgit.out import *
+from stgit import utils
+from stgit.commands import common
+from stgit.lib import git, transaction
+
+help =3D 'coalesce two or more patches into one'
+usage =3D """%prog [options] <patches>
+
+Coalesce two or more patches, creating one big patch that contains all
+their changes. The patches must all be applied, and must be
+consecutive."""
+
+directory =3D common.DirectoryHasRepositoryLib()
+options =3D [make_option('-n', '--name', help =3D 'name of coalesced p=
atch'),
+           make_option('-m', '--message',
+                       help =3D 'commit message of coalesced patch')]
+
+def _coalesce(stack, name, msg, patches):
+    applied =3D stack.patchorder.applied
+
+    # Make sure the patches are consecutive.
+    applied_ix =3D dict((applied[i], i) for i in xrange(len(applied)))
+    ixes =3D list(sorted(applied_ix[p] for p in patches))
+    i0, i1 =3D ixes[0], ixes[-1]
+    if i1 - i0 + 1 !=3D len(patches):
+        raise common.CmdException('The patches must be consecutive')
+
+    # Make a commit for the coalesced patch.
+    def bad_name(pn):
+        return pn not in patches and stack.patches.exists(pn)
+    if name and bad_name(name):
+        raise common.CmdException('Patch name "%s" already taken')
+    ps =3D [stack.patches.get(pn) for pn in applied[i0:i1+1]]
+    if msg =3D=3D None:
+        msg =3D '\n\n'.join('%s\n\n%s' % (p.name.ljust(70, '-'),
+                                        p.commit.data.message)
+                          for p in ps)
+        msg =3D utils.edit_string(msg, '.stgit-coalesce.txt').strip()
+    if not name:
+        name =3D utils.make_patch_name(msg, bad_name)
+    cd =3D git.Commitdata(tree =3D ps[-1].commit.data.tree,
+                        parents =3D ps[0].commit.data.parents, message=
 =3D msg)
+
+    # Rewrite refs.
+    trans =3D transaction.StackTransaction(stack, 'stg coalesce')
+    for pn in applied[i0:i1+1]:
+        trans.patches[pn] =3D None
+    parent =3D trans.patches[name] =3D stack.repository.commit(cd)
+    trans.applied =3D applied[:i0]
+    trans.applied.append(name)
+    for pn in applied[i1+1:]:
+        p =3D stack.patches.get(pn)
+        parent =3D trans.patches[pn] =3D stack.repository.commit(
+            p.commit.data.set_parent(parent))
+        trans.applied.append(pn)
+    trans.run()
+
+def func(parser, options, args):
+    stack =3D directory.repository.current_stack
+    applied =3D set(stack.patchorder.applied)
+    patches =3D set(common.parse_patches(args, list(stack.patchorder.a=
pplied)))
+    if len(patches) < 2:
+        raise common.CmdException('Need at least two patches')
+    _coalesce(stack, options.name, options.message, patches)
diff --git a/stgit/main.py b/stgit/main.py
index deaac91..384803b 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -64,6 +64,7 @@ commands =3D Commands({
     'diff':             'diff',
     'clean':            'clean',
     'clone':            'clone',
+    'coalesce':         'coalesce',
     'commit':           'commit',
     'edit':             'edit',
     'export':           'export',
@@ -108,6 +109,7 @@ stackcommands =3D (
     'applied',
     'branch',
     'clean',
+    'coalesce',
     'commit',
     'float',
     'goto',
diff --git a/stgit/utils.py b/stgit/utils.py
index b3f6232..688276c 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -189,6 +189,17 @@ def call_editor(filename):
         raise EditorException, 'editor failed, exit code: %d' % err
     out.done()
=20
+def edit_string(s, filename):
+    f =3D file(filename, 'w')
+    f.write(s)
+    f.close()
+    call_editor(filename)
+    f =3D file(filename)
+    s =3D f.read()
+    f.close()
+    os.remove(filename)
+    return s
+
 def patch_name_from_msg(msg):
     """Return a string to be used as a patch name. This is generated
     from the top line of the string passed as argument."""
diff --git a/t/t2600-coalesce.sh b/t/t2600-coalesce.sh
new file mode 100755
index 0000000..f13a309
--- /dev/null
+++ b/t/t2600-coalesce.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+
+test_description=3D'Run "stg coalesce"'
+
+. ./test-lib.sh
+
+test_expect_success 'Initialize StGit stack' '
+    stg init &&
+    for i in 0 1 2 3; do
+        stg new p$i -m "foo $i" &&
+        echo "foo $i" >> foo.txt &&
+        git add foo.txt &&
+        stg refresh
+    done
+'
+
+test_expect_success 'Coalesce some patches' '
+    [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ] &&
+    stg coalesce --name=3Dq0 --message=3D"wee woo" p1 p2 &&
+    [ "$(echo $(stg applied))" =3D "p0 q0 p3" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_expect_success 'Coalesce at stack top' '
+    stg coalesce --name=3Dq1 --message=3D"wee woo wham" q0 p3 &&
+    [ "$(echo $(stg applied))" =3D "p0 q1" ] &&
+    [ "$(echo $(stg unapplied))" =3D "" ]
+'
+
+test_done
