From: Junio C Hamano <junkio@cox.net>
Subject: Re: Set up for better tree diff optimizations
Date: Wed, 21 Mar 2007 09:51:47 -0700
Message-ID: <7vslby1qvw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0703181506570.6730@woody.linux-foundation.org>
	<7vircv3wfc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703210812590.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 21 17:51:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU42U-0002Yi-5T
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 17:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933059AbXCUQvt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933094AbXCUQvt
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 12:51:49 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33491 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933059AbXCUQvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 12:51:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070321165148.BZUH1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 21 Mar 2007 12:51:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dUrn1W00e1kojtg0000000; Wed, 21 Mar 2007 12:51:48 -0400
In-Reply-To: <Pine.LNX.4.64.0703210812590.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 21 Mar 2007 08:20:50 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42802>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 21 Mar 2007, Junio C Hamano wrote:
>> 
>> I've already applied the patch, but I do not know how much this
>> interface would help, as the only easy case the function
>> tree_entry_interesting() can say "no subsequent entries will be
>> either" without looking ahead is where no pathspecs match the
>> base, but that is already prevented by the way you walk the tree
>> (you do not descend into an uninteresting tree).
>
> No. You miss the important case.
>
>> If you do:
>> 
>> 	$ git log arch/i386/ include/asm-i386/
>
> Right. Forget about the paths we're *interested* in. 
>
> Look at the ones we're *not* interested in!

As always, you are right and enlightened others with your
superiour intelligence enough to produce code for you so that
you do not have to write yourself ;-).

Would something like this suit your taste?

The "rev-list org.eclipse.debug.ui/" test that took 16-17
seconds takes 9 seconds with this patch.  Running with a
diffrent pathspec "org.apache.ant/" obviously makes it go a lot
faster (15sec vs 7sec).

-- >8 --
[PATCH] Teach tree_entry_interesting() that the tree entries are sorted.

When we are looking at a tree entry with pathspecs, if all the
pathspecs sort strictly earlier than the entry we are currently
looking at, there is no way later entries in the same tree would
match out pathspecs, because the entries are sorted.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 tree-diff.c |   43 +++++++++++++++++++++++++++++++++++++------
 1 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index b2f35dc..459a0ff 100644
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
+		int m;
 
 		if (baselen >= matchlen) {
 			/* If it doesn't match, move along... */
@@ -109,6 +111,32 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 		match += baselen;
 		matchlen -= baselen;
 
+		/*
+		 * Does match sort strictly earlier than path with their
+		 * common parts?
+		 */
+		m = strncmp(match, path,
+			    (matchlen < pathlen) ? matchlen : pathlen);
+		if (m < 0)
+			continue;
+
+		/*
+		 * If we come here even once, that means there is at
+		 * least one pathspec that would sort later than the
+		 * path we are currently looking at (even though this
+		 * particular one we are currently looking at might
+		 * not match).  In other words, if we have never
+		 * reached this point after iterating all pathspecs,
+		 * it means all pathspecs are either outside of base,
+		 * or inside the base but sorts earlier than the
+		 * current one.  In either case, they will never match
+		 * the subsequent entries.  In such a case, we
+		 * initialized the variable to -1 and that is what
+		 * will be returned, allowing the caller to terminate
+		 * early.
+		 */
+		never_interesting = 0;
+
 		if (pathlen > matchlen)
 			continue;
 
@@ -119,12 +147,15 @@ static int tree_entry_interesting(struct tree_desc *desc, const char *base, int
 				continue;
 		}
 
-		if (strncmp(path, match, pathlen))
-			continue;
-
-		return 1;
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
