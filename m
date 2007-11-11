From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 5/5] stg repair: Patchify non-patch commits between
	patches
Date: Sun, 11 Nov 2007 20:44:04 +0100
Message-ID: <20071111194404.18868.44443.stgit@yoghurt>
References: <20071111193545.18868.62490.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:44:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIjS-0001bT-IU
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756846AbXKKToM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 14:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756842AbXKKToL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:44:11 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3896 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832AbXKKToJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:44:09 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IrIiy-0004cc-00; Sun, 11 Nov 2007 19:44:04 +0000
In-Reply-To: <20071111193545.18868.62490.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64504>

This teaches "stg repair" to find non-patch commits that sit between
patches, and turn them into patches. This situation can happen e.g.
like this:

  stg new -m A && stg new -m B && stg new -m C
  stg pop A B C
  stg push B
  echo foo > foo && git add foo && stg refresh
  git reset --hard $(stg id C)

The old "stg repair" would at this point simply conclude that A and C
are applied, and B unapplied. However, B's old commit is still between
them even though it's not a patch, which will cause problems later --
StGit generally assumes that the applied patches are a consecutive
string of commits. The new "stg repair", on the other hand, will find
B's old commit, and create a new patch for it.

One downside of this change is that we can no longer conclude that all
is well just because head =3D=3D top, so no-op runs of "stg repair" jus=
t
got more expensive.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/repair.py |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)


diff --git a/stgit/commands/repair.py b/stgit/commands/repair.py
index f8fe624..4787f72 100644
--- a/stgit/commands/repair.py
+++ b/stgit/commands/repair.py
@@ -101,33 +101,28 @@ def read_commit_dag(branch):
 def func(parser, options, args):
     """Repair inconsistencies in StGit metadata."""
=20
-    def nothing_to_do():
-        out.info('Nothing to repair')
-
     orig_applied =3D crt_series.get_applied()
     orig_unapplied =3D crt_series.get_unapplied()
=20
-    # If head =3D=3D top, we're done.
-    head =3D git.get_commit(git.get_head()).get_id_hash()
-    top =3D crt_series.get_current_patch()
-    if top and head =3D=3D top.get_top():
-        return nothing_to_do()
-
     if crt_series.get_protected():
         raise CmdException(
             'This branch is protected. Modification is not permitted.'=
)
=20
     # Find commits that aren't patches, and applied patches.
+    head =3D git.get_commit(git.get_head()).get_id_hash()
     commits, patches =3D read_commit_dag(crt_series.get_name())
     c =3D commits[head]
-    patchify =3D []
+    patchify =3D []       # commits to definitely patchify
+    maybe_patchify =3D [] # commits to patchify if we find a patch bel=
ow them
     applied =3D []
     while len(c.parents) =3D=3D 1:
         parent, =3D c.parents
         if c.patch:
             applied.append(c)
-        elif not applied:
-            patchify.append(c)
+            patchify.extend(maybe_patchify)
+            maybe_patchify =3D []
+        else:
+            maybe_patchify.append(c)
         c =3D parent
     applied.reverse()
     patchify.reverse()
