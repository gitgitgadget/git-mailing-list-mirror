From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] combine-diff: update --cc "uninteresting hunks" logic.
Date: Thu, 02 Feb 2006 00:18:06 -0800
Message-ID: <7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Len Brown <len.brown@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:18:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4ZfX-0006Hu-Ab
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 09:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423364AbWBBISK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 03:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423372AbWBBISK
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 03:18:10 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34435 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1423375AbWBBISI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 03:18:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202081814.CMJN25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 03:18:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602020002110.21884@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 2 Feb 2006 00:08:05 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15496>

Earlier logic was discarding hunks that has difference from only
one parent or the same difference from all but one parent.  This
changes it to check if the differences on all lines are from the
same sets of parents.  This discards more uninteresting hunks
and seems to match expectations more naturally.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Linus Torvalds <torvalds@osdl.org> writes:

 > On Wed, 1 Feb 2006, Linus Torvalds wrote:
 >> 
 >> I _think_ your version of the rule ("pluses and minuses in all the same 
 >> columns") ends up being exactly the same as my rule ("only two different 
 >> versions").
 >
 > Actually, I take that back.

 I do not do that "result to match the final" check in this
 version yet.  I'll need to revisit it before placing this in
 the master, but I am going to bed.

 combine-diff.c |  102 ++++++++++++++++++--------------------------------------
 1 files changed, 33 insertions(+), 69 deletions(-)

bcb331e2e87c2d7221751994b5ead4a79dd2a17b
diff --git a/combine-diff.c b/combine-diff.c
index 0cc18fe..44931b2 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -262,58 +262,6 @@ static int interesting(struct sline *sli
 	return ((sline->flag & all_mask) != all_mask || sline->lost_head);
 }
 
-static unsigned long line_common_diff(struct sline *sline, unsigned long all_mask)
-{
-	/*
-	 * Look at the line and see from which parents we have the
-	 * same difference.
-	 */
-
-	/* Lower bits of sline->flag records if the parent had this
-	 * line, so XOR with all_mask gives us on-bits for parents we
-	 * have differences with.
-	 */
-	unsigned long common_adds = (sline->flag ^ all_mask) & all_mask;
-	unsigned long common_removes = all_mask;
-
-	/* If all the parents have this line, that also counts as
-	 * having the same difference.
-	 */
-	if (!common_adds)
-		common_adds = all_mask;
-
-	if (sline->lost_head) {
-		/* Lost head list records the lines removed from
-		 * the parents, and parent_map records from which
-		 * parent the line was removed.
-		 */
-		struct lline *ll;
-		for (ll = sline->lost_head; ll; ll = ll->next) {
-			common_removes &= ll->parent_map;
-		}
-	}
-	return common_adds & common_removes;
-}
-
-static unsigned long line_all_diff(struct sline *sline, unsigned long all_mask)
-{
-	/*
-	 * Look at the line and see from which parents we have some difference.
-	 */
-	unsigned long different = (sline->flag ^ all_mask) & all_mask;
-	if (sline->lost_head) {
-		/* Lost head list records the lines removed from
-		 * the parents, and parent_map records from which
-		 * parent the line was removed.
-		 */
-		struct lline *ll;
-		for (ll = sline->lost_head; ll; ll = ll->next) {
-			different |= ll->parent_map;
-		}
-	}
-	return different;
-}
-
 static unsigned long adjust_hunk_tail(struct sline *sline,
 				      unsigned long all_mask,
 				      unsigned long hunk_begin,
@@ -417,8 +365,7 @@ static int make_hunks(struct sline *slin
 	i = 0;
 	while (i < cnt) {
 		unsigned long j, hunk_begin, hunk_end;
-		int same, diff;
-		unsigned long same_diff, all_diff;
+		unsigned long same_diff;
 		while (i < cnt && !(sline[i].flag & mark))
 			i++;
 		if (cnt <= i)
@@ -449,23 +396,40 @@ static int make_hunks(struct sline *slin
 		}
 		hunk_end = j;
 
-		/* [i..hunk_end) are interesting.  Now does it have
-		 * the same change with all but one parent?
+		/* [i..hunk_end) are interesting.  Now is it really
+		 * interesting?
 		 */
-		same_diff = all_mask;
-		all_diff = 0;
-		for (j = i; j < hunk_end; j++) {
-			same_diff &= line_common_diff(sline + j, all_mask);
-			all_diff |= line_all_diff(sline + j, all_mask);
-		}
-		diff = same = 0;
-		for (j = 0; j < num_parent; j++) {
-			if (same_diff & (1UL<<j))
-				same++;
-			if (all_diff & (1UL<<j))
-				diff++;
+		same_diff = 0;
+		has_interesting = 0;
+		for (j = i; j < hunk_end && !has_interesting; j++) {
+			unsigned long this_diff = ~sline[j].flag & all_mask;
+			struct lline *ll = sline[j].lost_head;
+			if (this_diff) {
+				/* This has some changes.  Is it the
+				 * same as others?
+				 */
+				if (!same_diff)
+					same_diff = this_diff;
+				else if (same_diff != this_diff) {
+					has_interesting = 1;
+					break;
+				}
+			}
+			while (ll && !has_interesting) {
+				/* Lost this line from these parents;
+				 * who are they?  Are they the same?
+				 */
+				this_diff = ll->parent_map;
+				if (!same_diff)
+					same_diff = this_diff;
+				else if (same_diff != this_diff) {
+					has_interesting = 1;
+				}
+				ll = ll->next;
+			}
 		}
-		if ((num_parent - 1 <= same) || (diff == 1)) {
+
+		if (!has_interesting) {
 			/* This hunk is not that interesting after all */
 			for (j = hunk_begin; j < hunk_end; j++)
 				sline[j].flag &= ~mark;
-- 
1.1.6.g2672
