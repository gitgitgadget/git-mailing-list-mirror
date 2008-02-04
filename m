From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Mon, 4 Feb 2008 09:32:15 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:34:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5D0-00013y-Vg
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbYBDRdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753735AbYBDRdl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:33:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41823 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752657AbYBDRdl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 12:33:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14HWGq2017247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 09:32:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14HWFMa008777;
	Mon, 4 Feb 2008 09:32:16 -0800
In-Reply-To: <20080203043310.GA5984@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.216 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72531>



On Sat, 2 Feb 2008, Jeff King wrote:
> 
> OK, there is definitely a bug here, but I'm having some trouble figuring
> out the correct fix. It's in the revision walker, so I have cc'd those
> who are more clueful than I.

Ok, I agree that there is a bug, and your two-liner fix is a "fix" in that 
it works, but I think it's absolutely the wrogn fix because it is totally 
unacceptable from a performance angle. We obviously need to break out of 
the loop before we have walked the whole commit chain.

>  		if (obj->flags & UNINTERESTING) {
>  			mark_parents_uninteresting(commit);
> -			if (everybody_uninteresting(list))
> -				break;
>  			continue;
>  		}

So I think the real problem here is not that the logic is wrong in 
general, but that there is one *special* case where the logic to break out 
is wrong.

And that special case is when we hit the root commit which isn't negative.

That case is special because *normally*, if we have a positive commit, we 
will always continue to walk the parents of that positive commit, so the 
"everybody_interesting()" check will not trigger. BUT! If we hit a root 
commit and it is positive, that won't happen (since, by definition, it has 
no parents to keep the list populated with), and now we break out early.

So I think your fix is wrong, but it's "close" to right: I suspect that we 
can fix it by marking the "we hit the root commit" case, and just 
disabling it for that case.

This patch is untested and obviously won't even compile (I didn't actually 
add the "hit_root" bitfield to the revision struct), but shows what I 
*think* should fix this issue, without the performance problem.

But maybe I haven't thought it entirely through, and there is some other 
case that can trigger this bug.

So please somebody double-check my thinking.

			Linus

---
diff --git a/revision.c b/revision.c
index 6e85aaa..0e90988 100644
--- a/revision.c
+++ b/revision.c
@@ -456,6 +456,9 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
 
+	if (!commit->parents)
+		revs->hit_root = 1;
+
 	rest = !revs->first_parent_only;
 	for (parent = commit->parents, add = 1; parent; add = rest) {
 		struct commit *p = parent->item;
@@ -579,7 +582,7 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list))
+			if (!revs->hit_root && everybody_uninteresting(list))
 				break;
 			continue;
 		}
