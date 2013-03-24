From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Sun, 24 Mar 2013 23:46:28 +0100
Message-ID: <514F8244.8070702@lsrfire.ath.cx>
References: <20130322161837.GG3083@sigill.intra.peff.net> <20130322162155.GB25857@sigill.intra.peff.net> <514DFB1A.8040102@lsrfire.ath.cx> <7vli9d4crq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 23:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJtgx-0001nX-L9
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 23:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab3CXWqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 18:46:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:50158 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932Ab3CXWqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 18:46:39 -0400
Received: from [192.168.2.105] (p579BEBCA.dip.t-dialin.net [87.155.235.202])
	by india601.server4you.de (Postfix) with ESMTPSA id 35856183;
	Sun, 24 Mar 2013 23:46:37 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vli9d4crq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219001>

Am 24.03.2013 05:55, schrieb Junio C Hamano:
> However, the same compiler still thinks {elem,path,mode}1 can be
> used uninitialized (but not {elem,path,mode}2).  The craziness I
> reported in the previous message is also the same.  With this patch
> on top to swap the side we inspect first, the compiler thinks
> {elem,path,mode}2 can be used uninitialized but not the other three
> variables X-<.
> 
> So I like your change for readability, but for GCC 4.4.5 we still
> need the unnecessary initialization.

Hrm, perhaps we can make it even simpler for the compiler.

-- >8 --
Subject: match-trees: simplify score_trees() using tree_entry()

Convert the loop in score_trees() to tree_entry().  The code becomes
shorter and simpler because the calls to update_tree_entry() are not
needed any more.

Another benefit is that we need less variables to track the current
tree entries; as a side-effect of that the compiler has an easier
job figuring out the control flow and thus can avoid false warnings
about uninitialized variables.

Using struct name_entry also allows the use of tree_entry_len() for
finding the path length instead of strlen(), which may be slightly
more efficient.

Also unify the handling of missing entries in one of the two trees
(i.e. added or removed files): Just set cmp appropriately first, no
matter if we ran off the end of a tree or if we actually have two
entries to compare, and check its value a bit later without
duplicating the handler code.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
I'm a bit uneasy about this one because we lack proper tests for
this code and I don't know how to write ones off the bat.

 match-trees.c | 68 ++++++++++++++++++++++++-----------------------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 26f7ed1..2bb734d 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -47,6 +47,13 @@ static int score_matches(unsigned mode1, unsigned mode2, const char *path)
 	return score;
 }
 
+static int base_name_entries_compare(const struct name_entry *a,
+				     const struct name_entry *b)
+{
+	return base_name_compare(a->path, tree_entry_len(a), a->mode,
+				 b->path, tree_entry_len(b), b->mode);
+}
+
 /*
  * Inspect two trees, and give a score that tells how similar they are.
  */
@@ -71,54 +78,35 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 	if (type != OBJ_TREE)
 		die("%s is not a tree", sha1_to_hex(hash2));
 	init_tree_desc(&two, two_buf, size);
-	while (one.size | two.size) {
-		const unsigned char *elem1 = elem1;
-		const unsigned char *elem2 = elem2;
-		const char *path1 = path1;
-		const char *path2 = path2;
-		unsigned mode1 = mode1;
-		unsigned mode2 = mode2;
+	for (;;) {
+		struct name_entry e1, e2;
+		int got_entry_from_one = tree_entry(&one, &e1);
+		int got_entry_from_two = tree_entry(&two, &e2);
 		int cmp;
 
-		if (one.size)
-			elem1 = tree_entry_extract(&one, &path1, &mode1);
-		if (two.size)
-			elem2 = tree_entry_extract(&two, &path2, &mode2);
-
-		if (!one.size) {
-			/* two has more entries */
-			score += score_missing(mode2, path2);
-			update_tree_entry(&two);
-			continue;
-		}
-		if (!two.size) {
+		if (got_entry_from_one && got_entry_from_two)
+			cmp = base_name_entries_compare(&e1, &e2);
+		else if (got_entry_from_one)
 			/* two lacks this entry */
-			score += score_missing(mode1, path1);
-			update_tree_entry(&one);
-			continue;
-		}
-		cmp = base_name_compare(path1, strlen(path1), mode1,
-					path2, strlen(path2), mode2);
-		if (cmp < 0) {
+			cmp = -1;
+		else if (got_entry_from_two)
+			/* two has more entries */
+			cmp = 1;
+		else
+			break;
+
+		if (cmp < 0)
 			/* path1 does not appear in two */
-			score += score_missing(mode1, path1);
-			update_tree_entry(&one);
-			continue;
-		}
-		else if (cmp > 0) {
+			score += score_missing(e1.mode, e1.path);
+		else if (cmp > 0)
 			/* path2 does not appear in one */
-			score += score_missing(mode2, path2);
-			update_tree_entry(&two);
-			continue;
-		}
-		else if (hashcmp(elem1, elem2))
+			score += score_missing(e2.mode, e2.path);
+		else if (hashcmp(e1.sha1, e2.sha1))
 			/* they are different */
-			score += score_differs(mode1, mode2, path1);
+			score += score_differs(e1.mode, e2.mode, e1.path);
 		else
 			/* same subtree or blob */
-			score += score_matches(mode1, mode2, path1);
-		update_tree_entry(&one);
-		update_tree_entry(&two);
+			score += score_matches(e1.mode, e2.mode, e1.path);
 	}
 	free(one_buf);
 	free(two_buf);
-- 
1.8.2
