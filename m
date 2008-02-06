From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Wed, 6 Feb 2008 02:34:21 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802060216510.2967@woody.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org> <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org> <7vprvb6k9u.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802051648410.2967@woody.linux-foundation.org> <7vwspi4poh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:35:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhcb-0006q0-A5
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbYBFKeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbYBFKeo
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:34:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55553 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752444AbYBFKen (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 05:34:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16AYLT7020446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2008 02:34:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16AYLGZ006740;
	Wed, 6 Feb 2008 02:34:21 -0800
In-Reply-To: <7vwspi4poh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72794>



On Tue, 5 Feb 2008, Junio C Hamano wrote:
> 
> I really wish this was still May 2005.  Then I (actually, you)
> could just decree:

Yeah, we really should have done that, when this came up last.

We could still decide it's a good idea to do, and simply decide that

 - within all-new ranges (that *do* have generation numbers) we can use 
   the generation number to give certain guarantees.

 - when any commits involved don't have generation numbers, we just fall 
   back on the not-strict-guarantees-use-commit-date-heuristics.

but here's something I whipped up because I woke up at 2AM and decided 
that there is a simple heuristic that works *most* of the time.. We just 
add a bit of slop, namely:

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

 - otherwise, do the "everybody_uninteresting()" test to see whether we're 
   still interested in the source.

I dunno. It's really late (or early ;), and I'm having a headache. Maybe 
it doesn't really work. But the idea is that this should be able to handle 
the few occasional incorrect timestamps. Maybe.

		Linus

---
 revision.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 6e85aaa..a50ae02 100644
--- a/revision.c
+++ b/revision.c
@@ -558,8 +558,39 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	free_patch_ids(&ids);
 }
 
+/* How many extra uninteresting commits we want to see.. */
+#define SLOP 5
+
+static int still_interesting(struct commit_list *src, unsigned long date, int slop)
+{
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
+}
+
 static int limit_list(struct rev_info *revs)
 {
+	int slop = SLOP;
+	unsigned long date = ~0ul;
 	struct commit_list *list = revs->commits;
 	struct commit_list *newlist = NULL;
 	struct commit_list **p = &newlist;
@@ -579,12 +610,14 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list))
+			slop = still_interesting(list, date, slop);
+			if (!slop)
 				break;
 			continue;
 		}
 		if (revs->min_age != -1 && (commit->date > revs->min_age))
 			continue;
+		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
 
 		show = show_early_output;
