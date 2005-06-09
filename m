From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] read-tree.c: rename local variables used in 3-way merge
 code.
Date: Thu, 09 Jun 2005 15:45:59 -0700
Message-ID: <7vvf4n9mjc.fsf_-_@assigned-by-dhcp.cox.net>
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
X-From: git-owner@vger.kernel.org Fri Jun 10 00:42:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgVjA-0003ag-Rp
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 00:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVFIWq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 18:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFIWq2
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 18:46:28 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22441 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261374AbVFIWqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 18:46:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609224559.YYDU8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 18:45:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506091152530.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 9 Jun 2005 12:03:04 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I'd hate to do this, but every time I try to touch this code and
validate what it does against the case matrix in t1000 test I
get confused.  The variable names are renamed to match the case
matrix.  Now they are named as:

    i -- entry from the index file (formerly known as "old")
    o -- merge base (formerly known as "a")
    a -- our head (formerly known as "b")
    b -- merge head (formerly known as "c")

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Re-submit.  I've rebased the series from the last night.
*** This is the first of them.

 read-tree.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -40,9 +40,9 @@ static int same(struct cache_entry *a, s
  * This removes all trivial merges that don't change the tree
  * and collapses them to state 0.
  */
-static struct cache_entry *merge_entries(struct cache_entry *a,
-					 struct cache_entry *b,
-					 struct cache_entry *c)
+static struct cache_entry *merge_entries(struct cache_entry *o,
+					 struct cache_entry *a,
+					 struct cache_entry *b)
 {
 	/*
 	 * Ok, all three entries describe the same
@@ -58,16 +58,16 @@ static struct cache_entry *merge_entries
 	 * The "all entries exactly the same" case falls out as
 	 * a special case of any of the "two same" cases.
 	 *
-	 * Here "a" is "original", and "b" and "c" are the two
+	 * Here "o" is "original", and "a" and "b" are the two
 	 * trees we are merging.
 	 */
-	if (a && b && c) {
-		if (same(b,c))
-			return c;
+	if (o && a && b) {
 		if (same(a,b))
-			return c;
-		if (same(a,c))
 			return b;
+		if (same(o,a))
+			return b;
+		if (same(o,b))
+			return a;
 	}
 	return NULL;
 }
@@ -126,29 +126,29 @@ static int merged_entry(struct cache_ent
 
 static int threeway_merge(struct cache_entry *stages[4], struct cache_entry **dst)
 {
-	struct cache_entry *old = stages[0];
-	struct cache_entry *a = stages[1], *b = stages[2], *c = stages[3];
+	struct cache_entry *i = stages[0];
+	struct cache_entry *o = stages[1], *a = stages[2], *b = stages[3];
 	struct cache_entry *merge;
 	int count;
 
 	/*
-	 * If we have an entry in the index cache ("old"), then we want
+	 * If we have an entry in the index cache ("i"), then we want
 	 * to make sure that it matches any entries in stage 2 ("first
-	 * branch", aka "b").
+	 * branch", aka "a").
 	 */
-	if (old) {
-		if (!b || !same(old, b))
+	if (i) {
+		if (!a || !same(i, a))
 			return -1;
 	}
-	merge = merge_entries(a, b, c);
+	merge = merge_entries(o, a, b);
 	if (merge)
-		return merged_entry(merge, old, dst);
-	if (old)
-		verify_uptodate(old);
+		return merged_entry(merge, i, dst);
+	if (i)
+		verify_uptodate(i);
 	count = 0;
+	if (o) { *dst++ = o; count++; }
 	if (a) { *dst++ = a; count++; }
 	if (b) { *dst++ = b; count++; }
-	if (c) { *dst++ = c; count++; }
 	return count;
 }
 
------------

