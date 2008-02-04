From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Mon, 4 Feb 2008 09:37:32 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802040936080.3034@hp.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5HF-0002XK-Nn
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754490AbYBDRiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbYBDRiH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:38:07 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34543 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754490AbYBDRiG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 12:38:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14HbX95017382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 09:37:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14HbW4Z008949;
	Mon, 4 Feb 2008 09:37:32 -0800
In-Reply-To: <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.216 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72532>



On Mon, 4 Feb 2008, Linus Torvalds wrote:
>
> This patch is untested and obviously won't even compile (I didn't actually 
> add the "hit_root" bitfield to the revision struct), but shows what I 
> *think* should fix this issue, without the performance problem.

Ok, so I was lazy. Here's the updated patch that actually compiles and is 
also now verified to fix Junio's test-case.

(Same patch, just the added bitfield declaration, and the testing ;)

		Linus
---
 revision.c |    5 ++++-
 revision.h |    3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

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
diff --git a/revision.h b/revision.h
index 8572315..5188a2f 100644
--- a/revision.h
+++ b/revision.h
@@ -48,7 +48,8 @@ struct rev_info {
 			parents:1,
 			reverse:1,
 			cherry_pick:1,
-			first_parent_only:1;
+			first_parent_only:1,
+			hit_root:1;
 
 	/* Diff flags */
 	unsigned int	diff:1,
