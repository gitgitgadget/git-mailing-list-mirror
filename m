From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] Make "stg commit" fancier
Date: Fri, 14 Dec 2007 07:32:36 +0100
Message-ID: <20071214063236.29290.77674.stgit@yoghurt>
References: <20071214062618.29290.70792.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:33:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J347H-0003xt-EN
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280AbXLNGcl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbXLNGck
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:32:40 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4239 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbXLNGcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:32:39 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J3467-0002pe-00; Fri, 14 Dec 2007 06:32:35 +0000
In-Reply-To: <20071214062618.29290.70792.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68247>

Allow the user to commit any patch. Changed behavior: with no
parameters, commit one applied patch, not all applied patches -- this
is what uncommit does.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/commit.py   |   87 +++++++++++++++++++++++++++++++++---=
--------
 stgit/commands/uncommit.py |    2 +
 stgit/lib/transaction.py   |    3 +-
 t/t1300-uncommit.sh        |   12 +++---
 4 files changed, 74 insertions(+), 30 deletions(-)


diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index f822181..1d741b3 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -15,39 +15,82 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
+from optparse import make_option
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit.out import *
=20
 help =3D 'permanently store the applied patches into stack base'
-usage =3D """%prog [options]
+usage =3D """%prog [<patchnames>] | -n NUM | --all
=20
-Merge the applied patches into the base of the current stack and
-remove them from the series while advancing the base.
+Merge one or more patches into the base of the current stack and
+remove them from the series while advancing the base. This is the
+opposite of 'stg uncommit'. Use this command if you no longer want to
+manage a patch with StGIT.
=20
-Use this command only if you want to permanently store the applied
-patches and no longer manage them with StGIT."""
+By default, the bottommost patch is committed. If patch names are
+given, the stack is rearranged so that those patches are at the
+bottom, and then they are committed.
=20
-directory =3D common.DirectoryHasRepositoryLib()
-options =3D []
+The -n/--number option specifies the number of applied patches to
+commit (counting from the bottom of the stack). If -a/--all is given,
+all applied patches are committed."""
=20
+directory =3D common.DirectoryHasRepositoryLib()
+options =3D [make_option('-n', '--number', type =3D 'int',
+                       help =3D 'commit the specified number of patche=
s'),
+           make_option('-a', '--all', action =3D 'store_true',
+                       help =3D 'commit all applied patches')]
=20
 def func(parser, options, args):
-    """Merge the applied patches into the base of the current stack
-       and remove them from the series while advancing the base
-    """
-    if len(args) !=3D 0:
-        parser.error('incorrect number of arguments')
-
+    """Commit a number of patches."""
     stack =3D directory.repository.current_stack
-    patches =3D stack.patchorder.applied
+    args =3D common.parse_patches(args, (list(stack.patchorder.applied=
)
+                                       + list(stack.patchorder.unappli=
ed)))
+    if len([x for x in [args, options.number !=3D None, options.all] i=
f x]) > 1:
+        parser.error('too many options')
+    if args:
+        patches =3D [pn for pn in (stack.patchorder.applied
+                                 + stack.patchorder.unapplied) if pn i=
n args]
+        bad =3D set(args) - set(patches)
+        if bad:
+            raise common.CmdException('Bad patch names: %s'
+                                      % ', '.join(sorted(bad)))
+    elif options.number !=3D None:
+        if options.number <=3D len(stack.patchorder.applied):
+            patches =3D stack.patchorder.applied[:options.number]
+        else:
+            raise common.CmdException('There are not that many applied=
 patches')
+    elif options.all:
+        patches =3D stack.patchorder.applied
+    else:
+        patches =3D stack.patchorder.applied[:1]
     if not patches:
-        raise CmdException('No patches to commit')
-    out.start('Committing %d patches' % len(patches))
+        raise common.CmdException('No patches to commit')
+
+    iw =3D stack.repository.default_iw()
     trans =3D transaction.StackTransaction(stack, 'stg commit')
-    for pn in patches:
-        trans.patches[pn] =3D None
-    trans.applied =3D []
-    trans.base =3D stack.head
-    trans.run()
-    out.done()
+    try:
+        common_prefix =3D 0
+        for i in xrange(min(len(stack.patchorder.applied), len(patches=
))):
+            if stack.patchorder.applied[i] =3D=3D patches[i]:
+                common_prefix +=3D 1
+        if common_prefix < len(patches):
+            to_push =3D trans.pop_patches(
+                lambda pn: pn in stack.patchorder.applied[common_prefi=
x:])
+            for pn in patches[common_prefix:]:
+                trans.push_patch(pn, iw)
+        else:
+            to_push =3D []
+        new_base =3D trans.patches[patches[-1]]
+        for pn in patches:
+            trans.patches[pn] =3D None
+        trans.applied =3D [pn for pn in trans.applied if pn not in pat=
ches]
+        trans.base =3D new_base
+        out.info('Committed %d patch%s' % (len(patches),
+                                           ['es', ''][len(patches) =3D=
=3D 1]))
+        for pn in to_push:
+            trans.push_patch(pn, iw)
+    except transaction.TransactionHalted:
+        pass
+    return trans.run(iw)
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 8422952..933ec60 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -28,7 +28,7 @@ usage =3D """%prog [<patchnames>] | -n NUM [<prefix>]=
] | -t <committish> [-x]
=20
 Take one or more git commits at the base of the current stack and turn
 them into StGIT patches. The new patches are created as applied patche=
s
-at the bottom of the stack. This is the exact opposite of 'stg commit'=
=2E
+at the bottom of the stack. This is the opposite of 'stg commit'.
=20
 By default, the number of patches to uncommit is determined by the
 number of patch names provided on the command line. First name is used
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index a7c4f7e..a60c5ff 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -51,7 +51,8 @@ class StackTransaction(object):
         self.__unapplied =3D list(val)
     unapplied =3D property(lambda self: self.__unapplied, __set_unappl=
ied)
     def __set_base(self, val):
-        assert not self.__applied
+        assert (not self.__applied
+                or self.patches[self.applied[0]].data.parent =3D=3D va=
l)
         self.__base =3D val
     base =3D property(lambda self: self.__base, __set_base)
     def __checkout(self, tree, iw):
diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index 85408fd..d86e579 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -35,7 +35,7 @@ test_expect_success \
 test_expect_success \
 	'Commit the patches' \
 	'
-	stg commit
+	stg commit --all
 	'
=20
 test_expect_success \
@@ -43,7 +43,7 @@ test_expect_success \
 	'
 	stg uncommit bar foo &&
 	[ "$(stg id foo//top)" =3D "$(stg id bar//bottom)" ] &&
-	stg commit
+	stg commit --all
 	'
=20
 test_expect_success \
@@ -51,7 +51,7 @@ test_expect_success \
 	'
 	stg uncommit --number=3D2 foobar &&
 	[ "$(stg id foobar1//top)" =3D "$(stg id foobar2//bottom)" ] &&
-	stg commit
+	stg commit --all
 	'
=20
 test_expect_success \
@@ -59,7 +59,7 @@ test_expect_success \
 	'
 	stg uncommit --number=3D2 &&
 	[ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &&
-	stg commit
+	stg commit --all
 	'
=20
 test_expect_success \
@@ -68,14 +68,14 @@ test_expect_success \
 	stg uncommit &&
 	stg uncommit &&
 	[ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &&
-	stg commit
+	stg commit --all
 	'
=20
 test_expect_success \
     'Uncommit the patches with --to' '
     stg uncommit --to HEAD^ &&
     [ "$(stg id foo-patch//top)" =3D "$(stg id bar-patch//bottom)" ] &=
&
-    stg commit
+    stg commit --all
 '
=20
 test_done
