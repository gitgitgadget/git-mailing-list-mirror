From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] read-tree -m 3-way: handle more trivial merges internally.
Date: Thu, 09 Jun 2005 15:49:19 -0700
Message-ID: <7v4qc79mds.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
	<7v7jh3phkk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506091033300.2286@ppc970.osdl.org>
	<7vbr6fnzf0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506091152530.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 00:46:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgVml-00041O-93
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 00:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVFIWuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 18:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVFIWtw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 18:49:52 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50395 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261432AbVFIWtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 18:49:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609224919.ZSQS22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 18:49:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506091152530.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 9 Jun 2005 12:03:04 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch teaches "read-tree -m O A B" that some more trivial
cases can be handled internally.  This allows us to loosen
otherwise too strict index requirements in case #5ALT, where
both branches create a new file identically.  The previous
code required index to be up-to-date and aborted the merge when
it is not, but there is no reason to require it to be up-to-date
in this case; it only needs to match A.

The test vector has been updated to match the new behaviour.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** This has the "removal" fixes.

 read-tree.c                 |   16 ++++++++++++++++
 t/t1000-read-tree-m-3way.sh |   27 +++++++++------------------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -69,6 +69,12 @@ static struct cache_entry *merge_entries
 		if (same(o,b))
 			return a;
 	}
+	/* #5ALT */
+	if (!o && a && b && same(a,b)) {
+		/* Match what git-merge-one-file-script does */
+		printf("Adding %s\n", a->name);
+		return a;
+	}
 	return NULL;
 }
 
@@ -170,6 +176,16 @@ static int threeway_merge(struct cache_e
 		return merged_entry(merge, i, dst);
 	if (i)
 		verify_uptodate(i);
+
+	/* #6ALT, #8ALT, and #10ALT */
+	if ((o && !a && !b) ||
+	    (o && !a && b && same(o, b)) ||
+	    (o && a && !b && same(o, a))) {
+		/* Match what git-merge-one-file-script does */
+		printf("Removing %s\n", o->name); 
+		return deleted_entry(o, i, dst);
+	}
+
 	count = 0;
 	if (o) { *dst++ = o; count++; }
 	if (a) { *dst++ = a; count++; }
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -75,21 +75,18 @@ In addition:
 . ../lib-read-tree-m-3way.sh
 
 ################################################################
-# This is the "no trivial merge unless all three exists" table.
+# Trivial "majority when 3 stages exist" merge plus #5ALT, #6ALT,
+# #8ALT, #10ALT trivial merges.
 
 cat >expected <<\EOF
 100644 X 2	AA
 100644 X 3	AA
 100644 X 2	AN
-100644 X 1	DD
 100644 X 3	DF
 100644 X 2	DF/DF
 100644 X 1	DM
 100644 X 3	DM
-100644 X 1	DN
-100644 X 3	DN
-100644 X 2	LL
-100644 X 3	LL
+100644 X 0	LL
 100644 X 1	MD
 100644 X 2	MD
 100644 X 1	MM
@@ -97,8 +94,6 @@ cat >expected <<\EOF
 100644 X 3	MM
 100644 X 0	MN
 100644 X 3	NA
-100644 X 1	ND
-100644 X 2	ND
 100644 X 0	NM
 100644 X 0	NN
 100644 X 0	SS
@@ -108,11 +103,8 @@ cat >expected <<\EOF
 100644 X 2	Z/AA
 100644 X 3	Z/AA
 100644 X 2	Z/AN
-100644 X 1	Z/DD
 100644 X 1	Z/DM
 100644 X 3	Z/DM
-100644 X 1	Z/DN
-100644 X 3	Z/DN
 100644 X 1	Z/MD
 100644 X 2	Z/MD
 100644 X 1	Z/MM
@@ -120,8 +112,6 @@ cat >expected <<\EOF
 100644 X 3	Z/MM
 100644 X 0	Z/MN
 100644 X 3	Z/NA
-100644 X 1	Z/ND
-100644 X 2	Z/ND
 100644 X 0	Z/NM
 100644 X 0	Z/NN
 EOF
@@ -289,23 +279,24 @@ test_expect_failure \
      git-read-tree -m $tree_O $tree_A $tree_B"
 
 test_expect_success \
-    '5 - must match and be up-to-date in !O && A && B && A==B case.' \
+    '5 - must match in !O && A && B && A==B case.' \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      git-update-cache --add LL &&
      git-read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
-test_expect_failure \
-    '5 (fail) - must match and be up-to-date in !O && A && B && A==B case.' \
+test_expect_success \
+    '5 - must match in !O && A && B && A==B case.' \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      git-update-cache --add LL &&
      echo extra >>LL &&
-     git-read-tree -m $tree_O $tree_A $tree_B"
+     git-read-tree -m $tree_O $tree_A $tree_B &&
+     check_result"
 
 test_expect_failure \
-    '5 (fail) - must match and be up-to-date in !O && A && B && A==B case.' \
+    '5 (fail) - must match in !O && A && B && A==B case.' \
     "rm -f .git/index LL &&
      cp .orig-A/LL LL &&
      echo extra >>LL &&
------------

