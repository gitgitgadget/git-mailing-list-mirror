From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 11/13] Check bottom and invariants
Date: Sat, 15 Sep 2007 00:32:05 +0200
Message-ID: <20070914223205.7001.63810.stgit@morpheus.local>
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
	id 1IWJi0-0001Ys-5q
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758283AbXINWcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758273AbXINWcN
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:32:13 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56523 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392AbXINWcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:32:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 08719200A1D3;
	Sat, 15 Sep 2007 00:32:08 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06982-01-9; Sat, 15 Sep 2007 00:32:06 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 7B5E9200A1D8;
	Sat, 15 Sep 2007 00:32:05 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 186CFBFA59;
	Sat, 15 Sep 2007 00:32:05 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58203>

This code adds some checks that the bottom is actually always the
parent of top.

It also checks that the top is the same as what the patch ref points
to.

This is only do to ensure that the next patches are correct.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/stack.py |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index fdff5a4..d9a2e56 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -197,9 +197,15 @@ class Patch(StgitObject):
             self.__update_top_ref(top)
=20
     def get_old_bottom(self):
-        return self._get_field('bottom.old')
+        old_bottom =3D self._get_field('bottom.old')
+        old_top =3D self.get_old_top()
+        assert old_bottom =3D=3D git.get_commit(old_top).get_parent()
+        return old_bottom
=20
     def get_bottom(self):
+        bottom =3D self._get_field('bottom')
+        top =3D self.get_top()
+        assert bottom =3D=3D git.get_commit(top).get_parent()
         return self._get_field('bottom')
=20
     def set_bottom(self, value, backup =3D False):
@@ -212,7 +218,13 @@ class Patch(StgitObject):
         return self._get_field('top.old')
=20
     def get_top(self):
-        return self._get_field('top')
+        top =3D self._get_field('top')
+        try:
+            ref =3D git.rev_parse(self.__top_ref)
+        except:
+            ref =3D None
+        assert not ref or top =3D=3D ref
+        return top
=20
     def set_top(self, value, backup =3D False):
         if backup:
@@ -220,6 +232,7 @@ class Patch(StgitObject):
             self._set_field('top.old', curr)
         self._set_field('top', value)
         self.__update_top_ref(value)
+        self.get_bottom() # check the assert
=20
     def restore_old_boundaries(self):
         bottom =3D self._get_field('bottom.old')
