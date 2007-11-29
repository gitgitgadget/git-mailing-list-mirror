From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix a pathological case in git detecting proper renames
Date: Thu, 29 Nov 2007 13:30:13 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
 <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Kumar Gala <galak@kernel.crashing.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 22:31:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxqyH-0003Vb-QL
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 22:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762313AbXK2Vai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 16:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762088AbXK2Vai
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 16:30:38 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41540 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762288AbXK2Vag (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 16:30:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATLUD8p016372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 13:30:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lATLUDH3008269;
	Thu, 29 Nov 2007 13:30:13 -0800
In-Reply-To: <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org>
X-Spam-Status: No, hits=-2.427 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_46
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66564>



Kumar Gala had a case in the u-boot archive with multiple renames of files 
with identical contents, and git would turn those into multiple "copy" 
operations of one of the sources, and just deleting the other sources.

This patch makes the git exact rename detection prefer to spread out the 
renames over the multiple sources, rather than do multiple copies of one 
source.

NOTE! The changes are a bit larger than required, because I also renamed 
the variables named "one" and "two" to "target" and "source" respectively. 
That makes the logic easier to follow, especially as the "one" was 
illogically the target and not the soruce, for purely historical reasons 
(this piece of code used to traverse over sources and targets in the wrong 
order, and when we fixed that, we didn't fix the names back then. So I 
fixed them now).

The important part of this change is just the trivial score calculations 
for when files have identical contents:

	/* Give higher scores to sources that haven't been used already */
	score = !source->rename_used;
	score += basename_same(source, target);

and when we have multiple choices we'll now pick the choice that gets the 
best rename score, rather than only looking at whether the basename 
matched.

It's worth noting a few gotchas:

 - this scoring is currently only done for the "exact match" case. 

   In particular, in Kumar's example, even after this patch, the inexact
   match case is still done as a copy+delete rather than as two renames:

	 delete mode 100644 board/cds/mpc8555cds/u-boot.lds
	 copy board/{cds => freescale}/mpc8541cds/u-boot.lds (97%)
	 rename board/{cds/mpc8541cds => freescale/mpc8555cds}/u-boot.lds (97%)

   because apparently the "cds/mpc8541cds/u-boot.lds" copy looked 
   a bit more similar to both end results. That said, I *suspect* we just 
   have the exact same issue there - the similarity analysis just gave 
   identical (or at least very _close_ to identical) similarity points, 
   and we do not have any logic to prefer multiple renames over a 
   copy/delete there.

   That is a separate patch.

 - When you have identical contents and identical basenames, the actual 
   entry that is chosen is still picked fairly "at random" for the first 
   one (but the subsequent ones will prefer entries that haven't already 
   been used).

   It's not actually really random, in that it actually depends on the
   relative alphabetical order of the files (which in turn will have 
   impacted the order that the entries got hashed!), so it gives 
   consistent results that can be explained. But I wanted to point it out 
   as an issue for when anybody actually does cross-renames.

   In Kumar's case the choice is the right one (and for a single normal 
   directory rename it should always be, since the relative alphabetical 
   sorting of the files will be identical), and we now get:

	 rename board/{cds => freescale}/mpc8541cds/init.S (100%)
	 rename board/{cds => freescale}/mpc8548cds/init.S (100%)

   which is the "expected" answer. However, it might still be better to 
   change the pedantic "exact same basename" on/off choice into a more 
   graduated "how similar are the pathnames" scoring situation, in order 
   to be more likely to get the exact rename choice that people *expect* 
   to see, rather than other alternatives that may *technically* be 
   equally good, but are surprising to a human.

It's also unclear whether we should consider "basenames are equal" or 
"have already used this as a source" to be more important. This gives them 
equal weight, but I suspect we might want to just multiple the "basenames 
are equal" weight by two, or something, to prefer equal basenames even if 
that causes a copy/delete pair. I dunno.

Anyway, what I'm just saying in a really long-winded manner is that I 
think this is right as-is, but it's not the complete solution, and it may 
want some further tweaking in the future.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

On Thu, 29 Nov 2007, Kumar Gala wrote:
> 
> let me know if there is anything else you need.

No, this was all right, and I've already got a patch ready for you to try.

So this patch actually does do what you want (for the exact renames, if 
not for the u-boot.lds file), but I wanted to just point out that we will 
almost certainly at least want to extend it to the inexact rename 
detection logic too, _and_ we may well want to make the "score" 
calculation a bit more involved depending on the actual filename, rather 
than just depend on the equality of the basename.

		Linus

---
 diffcore-rename.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f9ebea5..f64294e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -244,28 +244,35 @@ static int find_identical_files(struct file_similarity *src,
 	 * Walk over all the destinations ...
 	 */
 	do {
-		struct diff_filespec *one = dst->filespec;
+		struct diff_filespec *target = dst->filespec;
 		struct file_similarity *p, *best;
-		int i = 100;
+		int i = 100, best_score = -1;
 
 		/*
 		 * .. to find the best source match
 		 */
 		best = NULL;
 		for (p = src; p; p = p->next) {
-			struct diff_filespec *two = p->filespec;
+			int score;
+			struct diff_filespec *source = p->filespec;
 
 			/* False hash collission? */
-			if (hashcmp(one->sha1, two->sha1))
+			if (hashcmp(source->sha1, target->sha1))
 				continue;
 			/* Non-regular files? If so, the modes must match! */
-			if (!S_ISREG(one->mode) || !S_ISREG(two->mode)) {
-				if (one->mode != two->mode)
+			if (!S_ISREG(source->mode) || !S_ISREG(target->mode)) {
+				if (source->mode != target->mode)
 					continue;
 			}
-			best = p;
-			if (basename_same(one, two))
-				break;
+			/* Give higher scores to sources that haven't been used already */
+			score = !source->rename_used;
+			score += basename_same(source, target);
+			if (score > best_score) {
+				best = p;
+				best_score = score;
+				if (score == 2)
+					break;
+			}
 
 			/* Too many identical alternatives? Pick one */
 			if (!--i)
