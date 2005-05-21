From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Tweak diffcore-rename heuristics.
Date: Sat, 21 May 2005 15:55:18 -0700
Message-ID: <7v7jhsfauh.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 00:55:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZcrf-0001rL-4r
	for gcvg-git@gmane.org; Sun, 22 May 2005 00:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVEUWzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 18:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVEUWzf
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 18:55:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:41195 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261197AbVEUWzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 18:55:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521225518.TVCE8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 18:55:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The heuristics so far was to compare file size change and xdelta
size against the average of file size before and after the
change.  This patch uses the smaller of pre- and post- change
file size instead.

It also makes a very small performance fix.  I didn't measure
it; I do not expect it to make any practical difference, but
while scanning an already sorted list, breaking out in the
middle is the right thing.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diffcore-rename.c |   38 ++++++++++++++++++++------------------
1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -68,37 +68,39 @@ static int estimate_similarity(struct di
 	 * else.
 	 */
 	void *delta;
-	unsigned long delta_size;
+	unsigned long delta_size, base_size;
 	int score;
 
 	delta_size = ((src->size < dst->size) ?
 		      (dst->size - src->size) : (src->size - dst->size));
+	base_size = ((src->size < dst->size) ? src->size : dst->size);
 
-	/* We would not consider rename followed by more than
-	 * minimum_score/MAX_SCORE edits; that is, delta_size must be smaller
-	 * than (src->size + dst->size)/2 * minimum_score/MAX_SCORE,
-	 * which means...
+	/* We would not consider edits that change the file size so
+	 * drastically.  delta_size must be smaller than
+	 * minimum_score/MAX_SCORE * min(src->size, dst->size).
+	 * Note that base_size == 0 case is handled here already
+	 * and the final score computation below would not have a
+	 * divide-by-zero issue.
 	 */
-
-	if ((src->size+dst->size)*minimum_score < delta_size*MAX_SCORE*2)
+	if (base_size * minimum_score < delta_size * MAX_SCORE)
 		return 0;
 
 	delta = diff_delta(src->data, src->size,
 			   dst->data, dst->size,
 			   &delta_size);
+	/*
+	 * We currently punt here, but we may later end up parsing the
+	 * delta to really assess the extent of damage.  A big consecutive
+	 * remove would produce small delta_size that affects quite a
+	 * big portion of the file.
+	 */
 	free(delta);
 
-	/* This "delta" is really xdiff with adler32 and all the
-	 * overheads but it is a quick and dirty approximation.
-	 *
-	 * Now we will give some score to it.  100% edit gets
-	 * 0 points and 0% edit gets MAX_SCORE points.  That is, every
-	 * 1/MAX_SCORE edit gets 1 point penalty.  The amount of penalty is:
-	 *
-	 * (delta_size * 2 / (src->size + dst->size)) * MAX_SCORE
-	 *
+	/*
+	 * Now we will give some score to it.  100% edit gets 0 points
+	 * and 0% edit gets MAX_SCORE points.
 	 */
-	score = MAX_SCORE-(MAX_SCORE*2*delta_size/(src->size+dst->size));
+	score = MAX_SCORE - (MAX_SCORE * delta_size / base_size); 
 	if (score < 0) return 0;
 	if (MAX_SCORE < score) return MAX_SCORE;
 	return score;
@@ -314,7 +316,7 @@ void diff_detect_rename(struct diff_queu
 		if (mx[i].dst->xfrm_flags & RENAME_DST_MATCHED)
 			continue; /* alreayd done, either exact or fuzzy. */
 		if (mx[i].score < minimum_score)
-			continue;
+			break; /* there is not any more diffs applicable. */
 		record_rename_pair(&outq,
 				  mx[i].src, mx[i].dst, mx[i].rank,
 				  mx[i].score);
------------------------------------------------

