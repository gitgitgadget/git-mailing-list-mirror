From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 10/13] Refactor Series.new_patch
Date: Sat, 15 Sep 2007 00:32:00 +0200
Message-ID: <20070914223159.7001.30016.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhz-0001Ys-0Q
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214AbXINWcK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758194AbXINWcJ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:32:09 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56521 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758213AbXINWcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:32:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id C874A200A1CE;
	Sat, 15 Sep 2007 00:32:06 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05544-01-42; Sat, 15 Sep 2007 00:32:03 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id BFC76200A1D3;
	Sat, 15 Sep 2007 00:32:03 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 096F4BFA5F;
	Sat, 15 Sep 2007 00:32:00 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58202>

This shuffles some code so that the top and bottom never need to be
set to anything other than a valid commit and its parent.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/stack.py |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index 733a241..fdff5a4 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -864,13 +864,6 @@ class Series(PatchSet):
         patch =3D self.get_patch(name)
         patch.create()
=20
-        if not bottom:
-            bottom =3D head
-        if not top:
-            top =3D head
-
-        patch.set_bottom(bottom)
-        patch.set_top(top)
         patch.set_description(descr)
         patch.set_authname(author_name)
         patch.set_authemail(author_email)
@@ -889,10 +882,15 @@ class Series(PatchSet):
             set_head =3D True
=20
         if commit:
+            if top:
+                top_commit =3D git.get_commit(top)
+            else:
+                bottom =3D head
+                top_commit =3D git.get_commit(head)
+
             # create a commit for the patch (may be empty if top =3D=3D=
 bottom);
             # only commit on top of the current branch
             assert(unapplied or bottom =3D=3D head)
-            top_commit =3D git.get_commit(top)
             commit_id =3D git.commit(message =3D descr, parents =3D [b=
ottom],
                                    cache_update =3D False,
                                    tree_id =3D top_commit.get_tree(),
@@ -903,9 +901,12 @@ class Series(PatchSet):
                                    committer_name =3D committer_name,
                                    committer_email =3D committer_email=
)
             # set the patch top to the new commit
+            patch.set_bottom(bottom)
             patch.set_top(commit_id)
         else:
             assert top !=3D bottom
+            patch.set_bottom(bottom)
+            patch.set_top(top)
=20
         self.log_patch(patch, 'new')
=20
