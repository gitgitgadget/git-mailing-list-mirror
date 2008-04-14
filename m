From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] If a patch is not changed when pushing,
	reuse the same commit object
Date: Mon, 14 Apr 2008 23:21:50 +0200
Message-ID: <20080414212150.7334.92647.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 23:22:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlW8Q-0006GV-2P
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 23:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583AbYDNVV4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 17:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757497AbYDNVV4
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 17:21:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1655 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330AbYDNVV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 17:21:56 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JlW7b-0005l0-00; Mon, 14 Apr 2008 22:21:51 +0100
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79534>

It should be marginally faster since we don't have to create a new
commit object, but mostly it's a cleanliness issue: rewriting history
when we don't have to is bad.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/transaction.py |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 2946a67..9a23c01 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -175,8 +175,8 @@ class StackTransaction(object):
         """Attempt to push the named patch. If this results in conflic=
ts,
         halts the transaction. If index+worktree are given, spill any
         conflicts to them."""
-        cd =3D self.patches[pn].data
-        cd =3D cd.set_committer(None)
+        orig_cd =3D self.patches[pn].data
+        cd =3D orig_cd.set_committer(None)
         s =3D ['', ' (empty)'][cd.is_nochange()]
         oldparent =3D cd.parent
         cd =3D cd.set_parent(self.__head)
@@ -204,7 +204,11 @@ class StackTransaction(object):
             except git.MergeException, e:
                 self.__halt(str(e))
         cd =3D cd.set_tree(tree)
-        self.patches[pn] =3D self.__stack.repository.commit(cd)
+        if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
+               ['parent', 'tree', 'author', 'message']):
+            self.patches[pn] =3D self.__stack.repository.commit(cd)
+        else:
+            s =3D ' (unmodified)'
         del self.unapplied[self.unapplied.index(pn)]
         self.applied.append(pn)
         out.info('Pushed %s%s' % (pn, s))
