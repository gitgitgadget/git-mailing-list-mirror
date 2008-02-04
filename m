From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Mon, 4 Feb 2008 12:03:42 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
References: <20080202122135.GA5783@code-monkey.de> <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:07:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM7Zg-0004Ab-J1
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358AbYBDUEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757161AbYBDUEl
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:04:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42647 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757357AbYBDUEk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Feb 2008 15:04:40 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14K3ggI024445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2008 12:03:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m14K3ggE014735;
	Mon, 4 Feb 2008 12:03:42 -0800
In-Reply-To: <7vr6fsk08w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72553>



On Mon, 4 Feb 2008, Junio C Hamano wrote:
> 
> However, I am afraid that is not quite enough.  It is not just
> "when we hit the root".

You're right. The proper test is actually "is the list of commits 
disconnected".

Which is not an entirely trivial thing to test for efficiently.

I suspect that we can solve it by not even bothering to be efficient, and 
instead just ask that question when we hit the "are all commits negative" 
query.

Gaah. This is that stupid apporach. The smarter one might be harder, 
especially for the special cases where you truly have two totally 
unconnected trees, ie:

	a -> b -> c

	d -> e -> f

and do

	git rev-list c f ^b ^e

were you actually do not _have_ a single connected graph at all, but you 
know the result should be "c" and "f" because they are *individually* 
connected to what we already know is uninteresting.

Not really tested at all, not really thought through. And that recursion 
avoidance could be smarter.

			Linus

---
 revision.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index 6e85aaa..26b2343 100644
--- a/revision.c
+++ b/revision.c
@@ -558,6 +558,41 @@ static void cherry_pick_list(struct commit_list *list, struct rev_info *revs)
 	free_patch_ids(&ids);
 }
 
+static inline int commit_is_connected(struct commit *commit)
+{
+	struct commit_list *parents;
+	for (;;) {
+		if (commit->object.flags & UNINTERESTING)
+			return 1;
+		parents = commit->parents;
+		if (!parents)
+			return 0;
+		if (parents->next)
+			break;
+		commit = parents->item;
+	}
+
+	do {
+		if (!commit_is_connected(parents->item))
+			return 0;
+		parents = parents->next;
+	} while (parents);
+	return 1;
+}
+
+/* Check that the positive list is connected to the negative one.. */
+static int is_connected(struct commit_list *list)
+{
+	while (list) {
+		struct commit *commit = list->item;
+
+		list = list->next;
+		if (!commit_is_connected(commit))
+			return 0;
+	}
+	return 1;
+}
+
 static int limit_list(struct rev_info *revs)
 {
 	struct commit_list *list = revs->commits;
@@ -579,7 +614,7 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (everybody_uninteresting(list))
+			if (everybody_uninteresting(list) && is_connected(newlist))
 				break;
 			continue;
 		}
