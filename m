From: Junio C Hamano <junkio@cox.net>
Subject: Re: Set up for better tree diff optimizations
Date: Wed, 21 Mar 2007 12:54:56 -0700
Message-ID: <7vslbyz81b.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
	<7vircv3wfc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703210812590.6730@woody.linux-foundation.org>
	<7vslby1qvw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703211110050.6730@woody.linux-foundation.org>
	<7vhcse1kpu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 20:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU6tk-0001IU-Hg
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 20:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933957AbXCUTy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 15:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933948AbXCUTy7
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 15:54:59 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52400 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933957AbXCUTy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 15:54:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321195458.UQWK1312.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 15:54:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dXuw1W00l1kojtg0000000; Wed, 21 Mar 2007 15:54:57 -0400
In-Reply-To: <7vhcse1kpu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 21 Mar 2007 12:05:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42815>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Wed, 21 Mar 2007, Junio C Hamano wrote:
>> ...
>>> Would something like this suit your taste?
>>
>> This looks fine, although the reason I didn't get it done myself is that I 
>> have this nagging feeling that there must be some clever way to make it 
>> even faster. I hated having to do the "strncmp()" early, when it's not 
>> always needed. 
> ...
> We _could_ check never_interesting first and if it is already
> dropped then defer strncmp() and check the pathlen > matchlen
> comparison first.

So this is the round #2, as a replacement patch of what I sent
earlier.  Once we know that there are pathspecs that sort later
than the current path, we can defer doing strncmp() and skip
that pathspec early by comparing length.  If the path is longer
than the spec, we can tell that it would never match without
comparing.

Best time for "git-rev-list HEAD -- arch/i386/ include/asm-i386/"
are (ten runs each):

without any patch:	1.17user
with the previous:	1.13user
with this patch:	1.11user

-- >8 --
Teach tree_entry_interesting() that the tree entries are sorted.

When we are looking at a tree entry with pathspecs, if all the
pathspecs sort strictly earlier than the entry we are currently
looking at, there is no way later entries in the same tree would
match out pathspecs, because the entries are sorted.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 tree-diff.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 3678805..15fd665 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -81,6 +81,7 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 	unsigned mode;
 	int i;
 	int pathlen;
+	int never_interesting = -1;
 
 	if (!opt->nr_paths)
 		return 1;
@@ -89,9 +90,10 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 
 	pathlen = tree_entry_len(path, sha1);
 
-	for (i=0; i < opt->nr_paths; i++) {
+	for (i = 0; i < opt->nr_paths; i++) {
 		const char *match = opt->paths[i];
 		int matchlen = opt->pathlens[i];
+		int m = -1; /* signals that we haven't called strncmp() */
 
 		if (baselen >= matchlen) {
 			/* If it doesn't match, move along... */
@@ -109,6 +111,37 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 		match += baselen;
 		matchlen -= baselen;
 
+		if (never_interesting) {
+			/*
+			 * We have not seen any match that sorts later
+			 * than the current path.
+			 */
+
+			/*
+			 * Does match sort strictly earlier than path
+			 * with their common parts?
+			 */
+			m = strncmp(match, path,
+				    (matchlen < pathlen) ? matchlen : pathlen);
+			if (m < 0)
+				continue;
+
+			/*
+			 * If we come here even once, that means there is at
+			 * least one pathspec that would sort equal to or
+			 * later than the path we are currently looking at.
+			 * In other words, if we have never reached this point
+			 * after iterating all pathspecs, it means all
+			 * pathspecs are either outside of base, or inside the
+			 * base but sorts strictly earlier than the current
+			 * one.  In either case, they will never match the
+			 * subsequent entries.  In such a case, we initialized
+			 * the variable to -1 and that is what will be
+			 * returned, allowing the caller to terminate early.
+			 */
+			never_interesting = 0;
+		}
+
 		if (pathlen > matchlen)
 			continue;
 
@@ -119,12 +152,22 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 				continue;
 		}
 
-		if (strncmp(path, match, pathlen))
-			continue;
-
-		return 1;
+		if (m == -1)
+			/*
+			 * we cheated and did not do strncmp(), so we do
+			 * that here.
+			 */
+			m = strncmp(match, path, pathlen);
+
+		/*
+		 * If common part matched earlier then it is a hit,
+		 * because we rejected the case where path is not a
+		 * leading directory and is shorter than match.
+		 */
+		if (!m)
+			return 1;
 	}
-	return 0; /* No matches */
+	return never_interesting; /* No matches */
 }
 
 /* A whole sub-tree went away or appeared */
