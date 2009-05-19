From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH v2] Add a --set-tree flag to stg push
Date: Tue, 19 May 2009 11:35:48 +0200
Message-ID: <20090519093506.22242.59442.stgit@krank>
References: <20090519072512.GA8451@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue May 19 11:37:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Lkh-0005Rr-7D
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 11:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbZESJfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 05:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbZESJfx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 05:35:53 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:59060 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbZESJfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 05:35:52 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 088254001A;
	Tue, 19 May 2009 11:35:27 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id F2421400B9; Tue, 19 May 2009 11:35:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id AF9654001A;
	Tue, 19 May 2009 11:35:22 +0200 (CEST)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 0F92FDC268;
	Tue, 19 May 2009 11:35:49 +0200 (CEST)
In-Reply-To: <20090519072512.GA8451@diana.vm.bytemark.co.uk>
User-Agent: StGit/0.14.3.371.g0119
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119509>

This flag makes the push simply restore the tree that the patch used
before, rather than doing any kind of merge.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
Here's an updated patch, based on feedback and discussion with Karl.

 stgit/commands/push.py   |   34 ++++++++++++++++++++++++----------
 stgit/lib/transaction.py |   22 ++++++++++++++++++++++
 t/t1207-push-tree.sh     |   46 ++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 92 insertions(+), 10 deletions(-)
 create mode 100755 t/t1207-push-tree.sh

diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 0d25a65..dbecf1f 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -43,7 +43,17 @@ options =3D [
     opt('-n', '--number', type =3D 'int',
         short =3D 'Push the specified number of patches'),
     opt('--reverse', action =3D 'store_true',
-        short =3D 'Push the patches in reverse order')
+        short =3D 'Push the patches in reverse order'),
+    opt('--set-tree', action =3D 'store_true',
+        short =3D 'Push the patch with the original tree', long =3D ""=
"
+        Push the patches, but don't perform a merge. Instead, the
+        resulting tree will be identical to the tree that the patch
+        previously created. This can be useful when splitting a patch
+        by first popping the patch and creating a new patch with some
+        of the changes. Pushing the original patch with --set-tree
+        will avoid conflicts and only the remaining changes will be in
+        the patch.
+        """)
     ] + argparse.keep_option() + argparse.merged_option()
=20
 directory =3D common.DirectoryHasRepositoryLib()
@@ -74,14 +84,18 @@ def func(parser, options, args):
     if options.reverse:
         patches.reverse()
=20
-    try:
-        if options.merged:
-            merged =3D set(trans.check_merged(patches))
-        else:
-            merged =3D set()
+    if options.set_tree:
         for pn in patches:
-            trans.push_patch(pn, iw, allow_interactive =3D True,
-                             already_merged =3D pn in merged)
-    except transaction.TransactionHalted:
-        pass
+            trans.push_tree(pn)
+    else:
+        try:
+            if options.merged:
+                merged =3D set(trans.check_merged(patches))
+            else:
+                merged =3D set()
+            for pn in patches:
+                trans.push_patch(pn, iw, allow_interactive =3D True,
+                                 already_merged =3D pn in merged)
+        except transaction.TransactionHalted:
+            pass
     return trans.run(iw)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 4148ff3..bce3df1 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -372,6 +372,28 @@ class StackTransaction(object):
             # Update immediately.
             update()
=20
+    def push_tree(self, pn):
+        """Push the named patch without updating its tree."""
+        orig_cd =3D self.patches[pn].data
+        cd =3D orig_cd.set_committer(None).set_parent(self.top)
+
+        s =3D ''
+        if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
+               ['parent', 'tree', 'author', 'message']):
+            self.patches[pn] =3D self.__stack.repository.commit(cd)
+        else:
+            s =3D ' (unmodified)'
+        if cd.is_nochange():
+            s =3D ' (empty)'
+        out.info('Pushed %s%s' % (pn, s))
+
+        if pn in self.hidden:
+            x =3D self.hidden
+        else:
+            x =3D self.unapplied
+        del x[x.index(pn)]
+        self.applied.append(pn)
+
     def reorder_patches(self, applied, unapplied, hidden =3D None, iw =
=3D None):
         """Push and pop patches to attain the given ordering."""
         if hidden is None:
diff --git a/t/t1207-push-tree.sh b/t/t1207-push-tree.sh
new file mode 100755
index 0000000..9d0b1cc
--- /dev/null
+++ b/t/t1207-push-tree.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 David K=C3=A5gedal
+#
+
+test_description=3D'Exercise pushing patches with --set-tree.'
+
+. ./test-lib.sh
+
+test_expect_success \
+    'Create initial patches' '
+    stg init &&
+    stg new A -m A &&
+    echo hello world > a &&
+    git add a &&
+    stg refresh
+    stg new B -m B &&
+    echo HELLO WORLD > a &&
+    stg refresh
+'
+
+test_expect_success \
+    'Back up and create a partial patch' '
+    stg pop &&
+    stg new C -m C &&
+    echo hello WORLD > a &&
+    stg refresh
+'
+
+test_expect_success \
+    'Reapply patch B' '
+    stg push --set-tree B
+'
+
+test_expect_success \
+    'Compare results' '
+    stg pop -a &&
+    stg push &&
+    test "$(echo $(cat a))" =3D "hello world" &&
+    stg push &&
+    test "$(echo $(cat a))" =3D "hello WORLD" &&
+    stg push &&
+    test "$(echo $(cat a))" =3D "HELLO WORLD"
+'
+
+test_done
