From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-revert is a memory hog
Date: Tue, 29 Jan 2008 15:19:28 -0800
Message-ID: <7vwspskynz.fsf@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
	<20080128055933.GA13521@coredump.intra.peff.net>
	<alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
	<20080129222007.GA3985@coredump.intra.peff.net>
	<7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adrian Bunk <bunk@kernel.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 00:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJzkW-0006Gs-EL
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 00:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYA2XTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYA2XTn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 18:19:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYA2XTm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 18:19:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03C43212F;
	Tue, 29 Jan 2008 18:19:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1AD3212E;
	Tue, 29 Jan 2008 18:19:34 -0500 (EST)
In-Reply-To: <7vfxwgmf87.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 29 Jan 2008 14:36:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72015>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Jan 30, 2008 at 08:51:09AM +1100, Linus Torvalds wrote:
>>
>>> I definitely can reproduce it, it's horrid.
>>> 
>>> This is from "top" fairly late in the game, but with the thing not even 
>>> done yet. Current git, pretty much fully (and fairly aggressively) packed 
>>> current kernel repo, and using "diff.renamelmit=0".
>>
>> Hrm, setting diff.renamelimit to 0 lets me reproduce (I thought I tried
>> it before, but clearly not...).

How about this fairly obvious patch?

We used to record, for N=src deleted paths and M=dst created
paths, (N x M) "struct diff_score" that records how similar each
of the pair is, and picked the <src,dst> pairs that gives the
best match first, and then went on to worse matches.  This
sorting is so that two destinations are both found to be similar
to a single source, we can process the more similar one first,
and when processing the second one, it can notice "Ah, the
source I was planning to say I am a copy of is already taken by
somebody else" and continue on to match himself with another
source with a lessor match (this matters to a change introduced
between 1.5.3.X series and 1.5.4-rc, that lets the code to favor
unused matches first and then falls back to using already used
matches).

This instead allocates and keeps only M records in core.  For
each dst, we compute similarlity with all sources (so the number
of similarity estimate computations we do is still N x M), but
we keep the best src for each dst.  This is essentially to save
memory drastically by giving up to come up with better pairing.

I guess we could keep a handful best candidates per dst, instead
of just one, to further improve on this approach, and such a
change should be fairly straightforward.

---
 diffcore-rename.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d37725..7e8fdcd 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -473,42 +473,42 @@ void diffcore_rename(struct diff_options *options)
 	if (num_create * num_src > rename_limit * rename_limit)
 		goto cleanup;
 
-	mx = xmalloc(sizeof(*mx) * num_create * num_src);
+
+	mx = xmalloc(sizeof(*mx) * num_create);
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
-		int base = dst_cnt * num_src;
 		struct diff_filespec *two = rename_dst[i].two;
+		struct diff_score *m;
+
 		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
+
+		m = &mx[dst_cnt];
+		m->dst = -1;
 		for (j = 0; j < rename_src_nr; j++) {
 			struct diff_filespec *one = rename_src[j].one;
-			struct diff_score *m = &mx[base+j];
-			m->src = j;
-			m->dst = i;
-			m->score = estimate_similarity(one, two,
-						       minimum_score);
-			m->name_score = basename_same(one, two);
+			int score, name_score;
+			score = estimate_similarity(one, two,
+						    minimum_score);
+			name_score = basename_same(one, two);
+			if (m->dst < 0 ||
+			    score > m->score ||
+			    (score == m->score &&
+			     name_score > m->name_score)) {
+				m->score = score;
+				m->name_score = name_score;
+				m->src = j;
+				m->dst = i;
+			}
 			diff_free_filespec_blob(one);
 		}
 		/* We do not need the text anymore */
 		diff_free_filespec_blob(two);
 		dst_cnt++;
 	}
+
 	/* cost matrix sorted by most to least similar pair */
-	qsort(mx, num_create * num_src, sizeof(*mx), score_compare);
-	for (i = 0; i < num_create * num_src; i++) {
-		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
-		struct diff_filespec *src;
-		if (dst->pair)
-			continue; /* already done, either exact or fuzzy. */
-		if (mx[i].score < minimum_score)
-			break; /* there is no more usable pair. */
-		src = rename_src[mx[i].src].one;
-		if (src->rename_used)
-			continue;
-		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
-		rename_count++;
-	}
-	for (i = 0; i < num_create * num_src; i++) {
+	qsort(mx, num_create, sizeof(*mx), score_compare);
+	for (i = 0; i < num_create; i++) {
 		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
