From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH] Add a --tree flag to stg push
Date: Mon, 18 May 2009 16:50:18 +0200
Message-ID: <20090518144754.30487.84132.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Mon May 18 17:16:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M64aA-00087R-5i
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 17:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbZERPQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 11:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbZERPQb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 11:16:31 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:53817 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZERPQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 11:16:30 -0400
X-Greylist: delayed 1570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2009 11:16:29 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id D4A0F40021;
	Mon, 18 May 2009 16:49:53 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id C842D40047; Mon, 18 May 2009 16:49:53 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4941440021;
	Mon, 18 May 2009 16:49:53 +0200 (CEST)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 334BEDC26A;
	Mon, 18 May 2009 16:50:19 +0200 (CEST)
User-Agent: StGit/0.14.3.376.gb91d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119450>

This flag makes the push simply restore the tree that the patch used
before, rather than doing any kind of merge.
---

This scratches a long-time itch for me. The typical use case is when
you want to break up a larg patch inte smaller ones. You back out the
orignal patch, apply a small set of changes from it and then push the
patch back again. But then you don't want to do a merge, with the
possibility of conflict. You simply want to restore to the tree that
the patch had before so you can see what's left to create cleaned-up
patches of.  The command "stg push --tree" does just that.

The naming of flags and functions isn't very obvious, and suggestions
for improvements are welcome.

 stgit/commands/push.py   |   26 ++++++++++++-------
 stgit/lib/transaction.py |   28 ++++++++++++++++++++
 t/t1207-push-tree.sh     |   64 ++++++++++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 108 insertions(+), 10 deletions(-)
 create mode 100755 t/t1207-push-tree.sh

diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 0d25a65..8d4d3fc 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -43,7 +43,9 @@ options =3D [
     opt('-n', '--number', type =3D 'int',
         short =3D 'Push the specified number of patches'),
     opt('--reverse', action =3D 'store_true',
-        short =3D 'Push the patches in reverse order')
+        short =3D 'Push the patches in reverse order'),
+    opt('--tree', action =3D 'store_true',
+        short =3D 'Push the patch with the original tree')
     ] + argparse.keep_option() + argparse.merged_option()
=20
 directory =3D common.DirectoryHasRepositoryLib()
@@ -74,14 +76,18 @@ def func(parser, options, args):
     if options.reverse:
         patches.reverse()
=20
-    try:
-        if options.merged:
-            merged =3D set(trans.check_merged(patches))
-        else:
-            merged =3D set()
+    if options.tree:
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
index 4148ff3..1c21938 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -372,6 +372,34 @@ class StackTransaction(object):
             # Update immediately.
             update()
=20
+    def push_tree(self, pn):
+        """Push the named patch without updating its tree."""
+        orig_cd =3D self.patches[pn].data
+        cd =3D orig_cd.set_committer(None)
+        oldparent =3D cd.parent
+        cd =3D cd.set_parent(self.top)
+
+        s =3D ''
+        if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
+               ['parent', 'tree', 'author', 'message']):
+            comm =3D self.__stack.repository.commit(cd)
+            self.head =3D comm
+        else:
+            comm =3D None
+            s =3D ' (unmodified)'
+        if cd.is_nochange():
+            s =3D ' (empty)'
+        out.info('Pushed %s%s' % (pn, s))
+
+        if comm:
+            self.patches[pn] =3D comm
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
index 0000000..83f5cbf
--- /dev/null
+++ b/t/t1207-push-tree.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2006 David K=C3=A5gedal
+#
+
+test_description=3D'Exercise pushing patches with --tree.'
+
+. ./test-lib.sh
+
+# don't need this repo, but better not drop it, see t1100
+#rm -rf .git
+
+# Need a repo to clone
+test_create_repo foo
+
+test_expect_success \
+    'Create initial patches' '
+    (
+        cd foo &&
+        stg init &&
+        stg new A -m A &&
+        echo hello world > a &&
+        git add a &&
+        stg refresh
+        stg new B -m B &&
+        echo HELLO WORLD > a &&
+        stg refresh
+    )
+'
+
+test_expect_success \
+    'Back up and create a partial patch' '
+    (
+        cd foo &&
+        stg pop &&
+        stg new C -m C &&
+        echo hello WORLD > a &&
+        stg refresh
+    )
+'
+
+test_expect_success \
+    'Reapply patch B' '
+    (
+        cd foo &&
+        stg push --tree B
+    )
+'
+
+test_expect_success \
+    'Compare results' '
+    (
+        cd foo &&
+        stg pop -a &&
+        stg push &&
+        test "$(echo $(cat a))" =3D "hello world" &&
+        stg push &&
+        test "$(echo $(cat a))" =3D "hello WORLD" &&
+        stg push &&
+        test "$(echo $(cat a))" =3D "HELLO WORLD"
+    )
+'
+
+test_done
