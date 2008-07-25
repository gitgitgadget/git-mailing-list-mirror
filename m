From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 3/3] Make sure that stg uncommit doesn't touch the
	branch head
Date: Fri, 25 Jul 2008 02:53:06 +0200
Message-ID: <20080725005306.13006.51259.stgit@yoghurt>
References: <20080725005154.13006.8908.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 02:54:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMBZc-0006Ka-4v
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 02:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbYGYAxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 20:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbYGYAxM
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 20:53:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3157 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbYGYAxK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 20:53:10 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KMBtx-0005WG-00; Fri, 25 Jul 2008 02:15:22 +0100
In-Reply-To: <20080725005154.13006.8908.stgit@yoghurt>
User-Agent: StGIT/0.14.3.197.gba718
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89990>

Even if top !=3D head. It used to set head to top; but with this patch,
it doesn't anymore.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/uncommit.py |    2 +-
 stgit/lib/transaction.py   |   19 ++++++++++---------
 t/t1300-uncommit.sh        |    2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index eb39fcc..9d2dba9 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -136,5 +136,5 @@ def func(parser, options, args):
     for commit, pn in zip(commits, patchnames):
         trans.patches[pn] =3D commit
     trans.applied =3D list(reversed(patchnames)) + trans.applied
-    trans.run()
+    trans.run(set_head =3D False)
     out.done()
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index e47997e..23321c7 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -138,21 +138,22 @@ class StackTransaction(object):
         # The only state we need to restore is index+worktree.
         if iw:
             self.__checkout(self.__stack.head.data.tree, iw)
-    def run(self, iw =3D None):
+    def run(self, iw =3D None, set_head =3D True):
         """Execute the transaction. Will either succeed, or fail (with=
 an
         exception) and do nothing."""
         self.__check_consistency()
         new_head =3D self.__head
=20
         # Set branch head.
-        if iw:
-            try:
-                self.__checkout(new_head.data.tree, iw)
-            except git.CheckoutException:
-                # We have to abort the transaction.
-                self.abort(iw)
-                self.__abort()
-        self.__stack.set_head(new_head, self.__msg)
+        if set_head:
+            if iw:
+                try:
+                    self.__checkout(new_head.data.tree, iw)
+                except git.CheckoutException:
+                    # We have to abort the transaction.
+                    self.abort(iw)
+                    self.__abort()
+            self.__stack.set_head(new_head, self.__msg)
=20
         if self.__error:
             out.error(self.__error)
diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index d01eaaa..4a955f6 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -85,7 +85,7 @@ test_expect_success 'Uncommit a commit with not preci=
sely one parent' '
=20
 # stg uncommit should work even when top !=3D head, and should not tou=
ch
 # the head.
-test_expect_failure 'Uncommit when top !=3D head' '
+test_expect_success 'Uncommit when top !=3D head' '
     stg new -m foo &&
     git reset --hard HEAD^ &&
     h=3D$(git rev-parse HEAD)
