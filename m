From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 02/10] Add property with a list of all patch names
Date: Mon, 21 Apr 2008 00:10:33 +0200
Message-ID: <20080420221033.5837.39163.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:11:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnhkt-0007tG-8w
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYDTWKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbYDTWKg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:10:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3180 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYDTWKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:10:35 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jnhjz-00081e-00; Sun, 20 Apr 2008 23:10:31 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79990>

This simplifies the code in a number of places.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/coalesce.py |    3 +--
 stgit/commands/commit.py   |    6 ++----
 stgit/commands/delete.py   |    4 +---
 stgit/commands/uncommit.py |    2 +-
 stgit/lib/stack.py         |    1 +
 5 files changed, 6 insertions(+), 10 deletions(-)


diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index bf40427..9a46097 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -115,8 +115,7 @@ def _coalesce(stack, iw, name, msg, save_template, =
patches):
=20
 def func(parser, options, args):
     stack =3D directory.repository.current_stack
-    patches =3D common.parse_patches(args, (list(stack.patchorder.appl=
ied)
-                                          + list(stack.patchorder.unap=
plied)))
+    patches =3D common.parse_patches(args, list(stack.patchorder.all))
     if len(patches) < 2:
         raise common.CmdException('Need at least two patches')
     return _coalesce(stack, stack.repository.default_iw, options.name,
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index ee95836..ab89590 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -45,13 +45,11 @@ options =3D [make_option('-n', '--number', type =3D=
 'int',
 def func(parser, options, args):
     """Commit a number of patches."""
     stack =3D directory.repository.current_stack
-    args =3D common.parse_patches(args, (list(stack.patchorder.applied=
)
-                                       + list(stack.patchorder.unappli=
ed)))
+    args =3D common.parse_patches(args, list(stack.patchorder.all))
     if len([x for x in [args, options.number !=3D None, options.all] i=
f x]) > 1:
         parser.error('too many options')
     if args:
-        patches =3D [pn for pn in (stack.patchorder.applied
-                                 + stack.patchorder.unapplied) if pn i=
n args]
+        patches =3D [pn for pn in stack.patchorder.all if pn in args]
         bad =3D set(args) - set(patches)
         if bad:
             raise common.CmdException('Bad patch names: %s'
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 14bf442..872ed77 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -41,9 +41,7 @@ def func(parser, options, args):
         stack =3D directory.repository.current_stack
         iw =3D stack.repository.default_iw
     if args:
-        patches =3D set(common.parse_patches(
-                args, (list(stack.patchorder.applied)
-                       + list(stack.patchorder.unapplied))))
+        patches =3D set(common.parse_patches(args, list(stack.patchord=
er.all)))
     else:
         parser.error('No patches specified')
     def allow_conflicts(trans):
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index b6765bc..9ab178c 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -116,7 +116,7 @@ def func(parser, options, args):
             next_commit =3D get_parent(next_commit)
         patch_nr =3D len(commits)
=20
-    taken_names =3D set(stack.patchorder.applied + stack.patchorder.un=
applied)
+    taken_names =3D set(stack.patchorder.all)
     if patchnames:
         for pn in patchnames:
             if pn in taken_names:
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 3de3776..af1c994 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -96,6 +96,7 @@ class PatchOrder(object):
                        lambda self, val: self.__set_list('applied', va=
l))
     unapplied =3D property(lambda self: self.__get_list('unapplied'),
                          lambda self, val: self.__set_list('unapplied'=
, val))
+    all =3D property(lambda self: self.applied + self.unapplied)
=20
 class Patches(object):
     """Creates Patch objects."""
