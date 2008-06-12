From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 04/14] Add utility function for reordering patches
Date: Thu, 12 Jun 2008 07:34:32 +0200
Message-ID: <20080612053432.23549.67083.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fTP-0004xa-Pt
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbYFLFes convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbYFLFer
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:34:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2163 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbYFLFep (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:34:45 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fSD-000148-00; Thu, 12 Jun 2008 06:34:33 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84704>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/transaction.py |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 4c4da1a..16f5a4b 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,6 +1,8 @@
 """The L{StackTransaction} class makes it possible to make complex
 updates to an StGit stack in a safe and convenient way."""
=20
+import itertools as it
+
 from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
@@ -274,3 +276,15 @@ class StackTransaction(object):
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
