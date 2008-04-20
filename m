From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 05/10] Add utility function for reordering patches
Date: Mon, 21 Apr 2008 00:10:50 +0200
Message-ID: <20080420221050.5837.35826.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:11:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnhl2-0007vt-Pa
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbYDTWKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYDTWKx
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:10:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3189 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbYDTWKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:10:52 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JnhkG-00082W-00; Sun, 20 Apr 2008 23:10:48 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79993>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/transaction.py |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 4fb37ce..4c3b448 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,3 +1,5 @@
+import itertools as it
+
 from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
@@ -233,3 +235,15 @@ class StackTransaction(object):
             self.__allow_conflicts =3D lambda trans: True
=20
             self.__halt('Merge conflict')
+
+    def reorder_patches(self, applied, unapplied, iw =3D None):
+        """Push and pop patches to attain the given ordering."""
+        common =3D len(list(it.takewhile(lambda (a, b): a =3D=3D b,
+                                       zip(self.applied, applied))))
+        to_pop =3D set(self.applied[common:])
+        self.pop_patches(lambda pn: pn in to_pop)
+        for pn in applied[common:]:
+            self.push_patch(pn, iw)
+        assert self.applied =3D=3D applied
+        assert set(self.unapplied) =3D=3D set(unapplied)
+        self.unapplied =3D unapplied
