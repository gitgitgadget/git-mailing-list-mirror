From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 09/13] Clear up the semantics of Series.new_patch
Date: Sat, 15 Sep 2007 00:31:54 +0200
Message-ID: <20070914223154.7001.12254.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhz-0001Ys-JJ
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758259AbXINWcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758194AbXINWcL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:32:11 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56518 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206AbXINWcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:32:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 0123B200A1D9;
	Sat, 15 Sep 2007 00:32:06 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06982-01-8; Sat, 15 Sep 2007 00:32:03 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 83E8C200A1CE;
	Sat, 15 Sep 2007 00:32:03 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id E5C1CBFA59;
	Sat, 15 Sep 2007 00:31:54 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58204>

This patch adds a number of assertions to document and verify the
complex restrictions of the input parameters to the Series.new_patch
function. It also adds the requirement that 'before_existing' and
'commit' cannot be true at the same time when calling it, instead of
updating 'commit' inside the function.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/commands/uncommit.py |    1 +
 stgit/stack.py             |   14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 3cf2f0a..0cd0fb0 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -129,6 +129,7 @@ def func(parser, options, args):
                      name_email_date(commit.get_author())
         crt_series.new_patch(patchname,
                              can_edit =3D False, before_existing =3D T=
rue,
+                             commit =3D False,
                              top =3D commit_id, bottom =3D parent,
                              message =3D commit.get_log(),
                              author_name =3D author_name,
diff --git a/stgit/stack.py b/stgit/stack.py
index fd19a82..733a241 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -833,9 +833,16 @@ class Series(PatchSet):
                   author_name =3D None, author_email =3D None, author_=
date =3D None,
                   committer_name =3D None, committer_email =3D None,
                   before_existing =3D False):
-        """Creates a new patch
+        """Creates a new patch, either pointing to an existing commit =
object,
+        or by creating a new commit object.
         """
=20
+        assert commit or (top and bottom)
+        assert not before_existing or (top and bottom)
+        assert not (commit and before_existing)
+        assert (top and bottom) or (not top and not bottom)
+        assert not top or (bottom =3D=3D git.get_commit(top).get_paren=
t())
+
         if name !=3D None:
             self.__patch_name_valid(name)
             if self.patch_exists(name):
@@ -873,9 +880,6 @@ class Series(PatchSet):
=20
         if before_existing:
             insert_string(self.__applied_file, patch.get_name())
-            # no need to commit anything as the object is already
-            # present (mainly used by 'uncommit')
-            commit =3D False
         elif unapplied:
             patches =3D [patch.get_name()] + self.get_unapplied()
             write_strings(self.__unapplied_file, patches)
@@ -900,6 +904,8 @@ class Series(PatchSet):
                                    committer_email =3D committer_email=
)
             # set the patch top to the new commit
             patch.set_top(commit_id)
+        else:
+            assert top !=3D bottom
=20
         self.log_patch(patch, 'new')
=20
