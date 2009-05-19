From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH] Transaction.push_patch(): Set self.head only when we have a
	merge conflict
Date: Tue, 19 May 2009 12:07:26 +0200
Message-ID: <20090519100635.2943.31546.stgit@october.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 12:40:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6MkF-0005Y0-9l
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 12:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbZESKj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 06:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753549AbZESKj7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 06:39:59 -0400
Received: from oden.vtab.com ([62.20.90.195]:37901 "EHLO oden.vtab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470AbZESKj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 06:39:58 -0400
X-Greylist: delayed 1953 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 May 2009 06:39:58 EDT
Received: from oden.vtab.com (oden.vtab.com [127.0.0.1])
	by oden.vtab.com (Postfix) with ESMTP id D41D826EF39;
	Tue, 19 May 2009 12:07:26 +0200 (CEST)
Received: from october.hq.vtech (october.hq.vtech [10.0.0.43])
	by oden.vtab.com (Postfix) with ESMTP id BC3E626EF0E;
	Tue, 19 May 2009 12:07:26 +0200 (CEST)
User-Agent: StGit/0.14.3.379.gfc7c.dirty
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119515>

Setting self.head when we don't have a merge conflict is a harmless
no-op---as long as we set it to the commit that was going to be the
stack top anyway---so this patch should not change the behavior. But
it's not really nice to do it unconditionally, especially considering
that we want people to be able to understand what the code does ...

Also add a comment that explains why we set it, since the logic is
rather more hairy than I'd like.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

This patch came out of a discussion I just had with David regarding
his --set-tree patch.

 stgit/lib/transaction.py |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 4148ff3..5c662bb 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -342,7 +342,13 @@ class StackTransaction(object):
         if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
                ['parent', 'tree', 'author', 'message']):
             comm =3D self.__stack.repository.commit(cd)
-            self.head =3D comm
+            if merge_conflict:
+                # When we produce a conflict, we'll run the update()
+                # function defined below _after_ having done the
+                # checkout in run(). To make sure that we check out
+                # the real stack top (as it will look after update()
+                # has been run), set it hard here.
+                self.head =3D comm
         else:
             comm =3D None
             s =3D ' (unmodified)'
