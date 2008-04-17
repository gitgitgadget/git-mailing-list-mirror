From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/5] If a patch is not changed when pushing,
	reuse the same commit object
Date: Thu, 17 Apr 2008 23:12:47 +0200
Message-ID: <20080417211247.12809.90469.stgit@yoghurt>
References: <20080417210137.12809.88457.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:30:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmbQY-00054T-Br
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 23:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbYDQVNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 17:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbYDQVNB
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 17:13:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4506 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbYDQVNA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 17:13:00 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JmbPS-0003dE-00; Thu, 17 Apr 2008 22:12:46 +0100
In-Reply-To: <20080417210137.12809.88457.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79829>

It should be marginally faster since we don't have to create a new
commit object, but mostly it's a cleanliness issue: rewriting history
when we don't have to is bad.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/transaction.py |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)


diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 2946a67..1ece01e 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,4 +1,5 @@
 from stgit import exception, utils
+from stgit.utils import any, all
 from stgit.out import *
 from stgit.lib import git
=20
@@ -175,8 +176,8 @@ class StackTransaction(object):
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
@@ -204,7 +205,11 @@ class StackTransaction(object):
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
