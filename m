From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Tue, 5 Feb 2008 13:23:16 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org> <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 22:24:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMVHE-0004Ao-I3
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 22:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759750AbYBEVXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 16:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759692AbYBEVXt
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 16:23:49 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47276 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759536AbYBEVXr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2008 16:23:47 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m15LNHxs025217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Feb 2008 13:23:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m15LNGZ8008948;
	Tue, 5 Feb 2008 13:23:16 -0800
In-Reply-To: <7vir13g9hx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.214 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72700>



On Mon, 4 Feb 2008, Junio C Hamano wrote:
> 
> I tend to agree.  In a totally connected history, the upper
> bound we would need to traverse is down to the merge base of
> still positive commits in the "newlist" and negative ones still
> on the "list" when everybody on list becomes uninteresting.  And
> if there are two unrelated histories, that traversal will need
> to traverse down to respective roots.
> 
> Which sucks.

I really wonder if the right thing is not simply to admit that we consider 
the commit time meaningful (within some fudge factor!), and then do:

 - make commit warn if any parent commit date is in the future from the 
   current commit date (allow a *small* fudge factor here, say 5 minutes).

 - teach fsck to complain about parent commits being in the future from 
   their children (allow the same small fudge factor).

 - make the revision walking code realize that if times are too close to 
   each other, it should walk a bit further back...

because quite frankly, this bug only shows up when your time goes 
backwards (or stays the same, but the fudge-factor should take care of 
that too).

So the revision walking "fudge factor" could be as simple as the 
following..

		Linus

---
 revision.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 6e85aaa..e32e1e3 100644
--- a/revision.c
+++ b/revision.c
@@ -558,6 +558,8 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	free_patch_ids(&ids);
 }
 
+#define FUDGE (60*60)	/* 1 hour fudge-factor */
+
 static int limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -579,6 +581,15 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
+
+			/*
+			 * If we have commits on the newlist, we don't
+			 * want to do the "everybody_uninteresting()"
+			 * test until we've hit a negative commit that
+			 * is solidly in the past
+			 */
+			if (newlist && newlist->item->date < commit->date + FUDGE)
+				continue;
 			if (everybody_uninteresting(list))
 				break;
 			continue;
