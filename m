From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/5] Expose transaction abort function
Date: Fri, 14 Dec 2007 07:32:13 +0100
Message-ID: <20071214063213.29290.54202.stgit@yoghurt>
References: <20071214062618.29290.70792.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:32:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J346E-0003fp-6k
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100AbXLNGcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375AbXLNGcQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:32:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4223 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbXLNGcP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:32:15 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J345k-0002oo-00; Fri, 14 Dec 2007 06:32:12 +0000
In-Reply-To: <20071214062618.29290.70792.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68243>

Users of stack transactions may call abort() instead of run(), if they
wish to roll back the transaction instead of committing it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/transaction.py |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 77333b3..663d393 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -77,6 +77,10 @@ class StackTransaction(object):
             return self.__patches[self.__applied[-1]]
         else:
             return self.__stack.base
+    def abort(self, iw =3D None):
+        # The only state we need to restore is index+worktree.
+        if iw:
+            self.__checkout(self.__stack.head.data.tree, iw)
     def run(self, iw =3D None):
         self.__check_consistency()
         new_head =3D self.__head
@@ -85,9 +89,8 @@ class StackTransaction(object):
         try:
             self.__checkout(new_head.data.tree, iw)
         except git.CheckoutException:
-            # We have to abort the transaction. The only state we need
-            # to restore is index+worktree.
-            self.__checkout(self.__stack.head.data.tree, iw)
+            # We have to abort the transaction.
+            self.abort(iw)
             self.__abort()
         self.__stack.set_head(new_head, self.__msg)
=20
