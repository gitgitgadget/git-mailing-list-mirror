From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Unresolved issues
Date: Mon, 17 Mar 2008 18:56:33 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803171853180.3020@woody.linux-foundation.org>
References: <7v7ig096ot.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 02:57:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbR50-00023W-KD
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 02:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYCRB4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 21:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYCRB4n
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 21:56:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49246 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751717AbYCRB4m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2008 21:56:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2I1vjJd001972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2008 18:57:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2I1uXGQ009028;
	Mon, 17 Mar 2008 18:56:34 -0700
In-Reply-To: <7v7ig096ot.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-103.315 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77478>


On Mon, 17 Mar 2008, Junio C Hamano wrote:
> 
> * revision.c::limit_list() breakage
>   $gmane/72324
>   t/t6009
> 
>   When you run "git rev-list A..B C", and there is a commit in the chain
>   between A and B whose timestamp is much older than its parent, sometimes
>   we fail to mark C as reachable from A (hence not interesting) even when
>   it actualy is.  This is very expensive to solve in general, and we are
>   not going to introduce "generation number" field to the commit objects,
>   so we may have to settle with a heuristic.

Here is the already posted heuristic that fixes both t/t6009 and the 
real-world case that triggered the whole discussion.

It's certainly not perfect, but I think it's likely an improvement on what 
we have now, and it should be robust in the face of the _occasional_ wrong 
date.

Now, if there are consistently totally bogus dates, the SLOP thing won't 
help, but ...

		Linus
---
From: Linus Torvalds <torvalds@woody.linux-foundation.org>

Make revision limiting more robust against occasional bad commit dates

The revision limiter uses the commit date to decide when it has seen
enough commits to finalize the revision list, but that can get confused
if there are incorrect dates far in the past on some commits.

This makes the logic a bit more robust by

 - we always walk an extra SLOP commits from the source list even if we
   decide that the source list is probably all done (unless the source is
   entirely empty, of course, because then we really can't do anything at
   all)

 - we keep track of the date of the last commit we added to the
   destination list (this will *generally* be the oldest entry we've seen
   so far)

 - we compare that with the youngest entry (the first one) of the source
   list, and if the destination is older than the source, we know we want
   to look at the source.

which causes occasional date mishaps to be handled cleanly.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 revision.c |   46 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 63bf2c5..196fedc 100644
--- a/revision.c
+++ b/revision.c
@@ -564,14 +564,39 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	free_patch_ids(&ids);
 }
 
-static void add_to_list(struct commit_list **p, struct commit *commit, struct commit_list *n)
+/* How many extra uninteresting commits we want to see.. */
+#define SLOP 5
+
+static int still_interesting(struct commit_list *src, unsigned long date, int slop)
 {
-	p = &commit_list_insert(commit, p)->next;
-	*p = n;
+	/*
+	 * No source list at all? We're definitely done..
+	 */
+	if (!src)
+		return 0;
+
+	/*
+	 * Does the destination list contain entries with a date
+	 * before the source list? Definitely _not_ done.
+	 */
+	if (date < src->item->date)
+		return SLOP;
+
+	/*
+	 * Does the source list still have interesting commits in
+	 * it? Definitely not done..
+	 */
+	if (!everybody_uninteresting(src))
+		return SLOP;
+
+	/* Ok, we're closing in.. */
+	return slop-1;
 }
 
 static int limit_list(struct rev_info *revs)
 {
+	int slop = SLOP;
+	unsigned long date = ~0ul;
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
@@ -591,16 +616,19 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list)) {
-				if (revs->show_all)
-					add_to_list(p, commit, list);
-				break;
-			}
-			if (!revs->show_all)
-				continue;
+			if (revs->show_all)
+				p = &commit_list_insert(commit, p)->next;
+			slop = still_interesting(list, date, slop);
+			if (slop)
+				continue;
+			/* If showing all, add the whole pending list to the end */
+			if (revs->show_all)
+				*p = list;
+			break;
 		}
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
+		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
 
 		show = show_early_output;
