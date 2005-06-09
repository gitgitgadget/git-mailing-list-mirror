From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] read-tree -m 3-way: loosen an index requirement that was
 too strict.
Date: Thu, 09 Jun 2005 15:48:19 -0700
Message-ID: <7vekbb9mfg.fsf_-_@assigned-by-dhcp.cox.net>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 00:44:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgVl7-0003oM-Aw
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 00:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVFIWs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 18:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVFIWs3
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 18:48:29 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50134 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261407AbVFIWsV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 18:48:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609224820.IPPK19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 18:48:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506091152530.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 9 Jun 2005 12:03:04 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch teaches "read-tree -m O A B" that, when only "the
other tree" changed a path, and if the work tree already has
that change, we are not in a situation that would clobber the
cache and the working tree, and lets the merge succeed; this is
case #14ALT in t1000 test.  It does not change the result of the
merge, but prevents it from failing when it should not.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Rebased one from the last night.

 read-tree.c                 |   16 ++++++++++++++++
 t/t1000-read-tree-m-3way.sh |    9 +++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -140,6 +140,22 @@ static int threeway_merge(struct cache_e
 	struct cache_entry *merge;
 	int count;
 
+	/* The case #14ALT is special in that it allows "i" to match
+	 * the "merged branch", aka "b" and even be dirty, as an
+	 * alternative to the usual 'must match "a" and be up-to-date'
+	 * rule.
+	 */
+	if (o && a && b && same(o, a) && !same(o, b)) {
+		if (i) {
+			if (same(i, b))
+				; /* case #14ALT exception */
+			else if (same(i, a))
+				verify_uptodate(i);
+			else
+				return -1;
+		}
+	}
+	else /* otherwise the original rule applies */
 	/*
 	 * If we have an entry in the index cache ("i"), then we want
 	 * to make sure that it matches any entries in stage 2 ("first
diff --git a/t/t1000-read-tree-m-3way.sh b/t/t1000-read-tree-m-3way.sh
--- a/t/t1000-read-tree-m-3way.sh
+++ b/t/t1000-read-tree-m-3way.sh
@@ -455,6 +455,15 @@ test_expect_success \
      git-read-tree -m $tree_O $tree_A $tree_B &&
      check_result"
 
+test_expect_success \
+    '14ALT - in O && A && B && O==A && O!=B case, matching B is also OK' \
+    "rm -f .git/index NM &&
+     cp .orig-B/NM NM &&
+     git-update-cache --add NM &&
+     echo extra >>NM &&
+     git-read-tree -m $tree_O $tree_A $tree_B &&
+     check_result"
+
 test_expect_failure \
     '14 (fail) - must match and be up-to-date in O && A && B && O==A && O!=B case' \
     "rm -f .git/index NM &&
------------

