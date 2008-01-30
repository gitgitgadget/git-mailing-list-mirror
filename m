From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Optimize rename detection for a huge diff
Date: Tue, 29 Jan 2008 20:40:21 -0800
Message-ID: <7vprvkj58q.fsf_-_@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
	<20080128055933.GA13521@coredump.intra.peff.net>
	<alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
	<20080129222007.GA3985@coredump.intra.peff.net>
	<7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
	<7vwspskynz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 05:43:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK4n3-000748-2P
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 05:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbYA3Em2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 23:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbYA3Em2
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 23:42:28 -0500
Received: from rune.pobox.com ([208.210.124.79]:42029 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbYA3Em1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 23:42:27 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 7423C18F5D0;
	Tue, 29 Jan 2008 23:42:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3242918F5C7;
	Tue, 29 Jan 2008 23:40:59 -0500 (EST)
In-Reply-To: <7vwspskynz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 29 Jan 2008 15:19:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72021>

When there are N deleted paths and M created paths, we used to
allocate (N x M) "struct diff_score" that record how similar
each of the pair is, and picked the <src,dst> pair that gives
the best match first, and then went on to process worse matches.

This sorting is done so that when two new files in the postimage
that are similar to the same file deleted from the preimage, we
can process the more similar one first, and when processing the
second one, it can notice "Ah, the source I was planning to say
I am a copy of is already taken by somebody else" and continue
on to match itself with another file in the preimage with a
lessor match.  This matters to a change introduced between
1.5.3.X series and 1.5.4-rc, that lets the code to favor unused
matches first and then falls back to using already used
matches.

This instead allocates and keeps only a handful rename source
candidates per new files in the postimage.  I.e. it makes the
memory requirement from O(N x M) to O(M).

For each dst, we compute similarlity with all sources (i.e. the
number of similarity estimate computations is still O(N x M)),
but we keep handful best src candidates for each dst.

I've run

    git diff -l0 -M --name-status v2.6.$i v2.6.$(($i+1))

with and without patch for i=15..23.  There is one pair between
v2.6.20 and v2.6.21 that gets different matching from this
version.

    R093	include/asm-arm/apm.h	include/linux/apm-emulation.h
    R093	include/asm-mips/apm.h	include/linux/apm-emulation.h

Without the patch, apm-emulation.h is found to be from asm-arm/arm.h;
with the patch, it is found to be from asm-mips/apm.h.  

But the difference between the ARM and MIPS versions is quite
small, so I do not think we need to even call this an regression:

    diff --git a/v2.6.20:include/asm-arm/apm.h b/v2.6.20:include/asm-mips/apm.h
    index d09113b..4b99ffc 100644
    --- a/v2.6.20:include/asm-arm/apm.h
    +++ b/v2.6.20:include/asm-mips/apm.h
    @@ -10,8 +10,8 @@
      *
      *
      */
    -#ifndef ARM_ASM_SA1100_APM_H
    -#define ARM_ASM_SA1100_APM_H
    +#ifndef MIPS_ASM_SA1100_APM_H
    +#define MIPS_ASM_SA1100_APM_H

     #include <linux/apm_bios.h>

And the renamed diff is like this.

    diff --git a/v2.6.20:include/asm-arm/apm.h b/v2.6.21:include/linux/apm-emulation.h
    index d09113b..e6d8003 100644
    --- a/v2.6.20:include/asm-arm/apm.h
    +++ b/v2.6.21:include/linux/apm-emulation.h
    @@ -7,11 +7,9 @@
      * based on arch/arm/kernel/apm.c
      * factor out the information needed by architectures to provide
      * apm status
    - *
    - *
      */
    -#ifndef ARM_ASM_SA1100_APM_H
    -#define ARM_ASM_SA1100_APM_H
    +#ifndef __LINUX_APM_EMULATION_H
    +#define __LINUX_APM_EMULATION_H

     #include <linux/apm_bios.h>

    @@ -61,4 +59,4 @@ extern void (*apm_get_power_status)(struct apm_power_info *);
      */
     void apm_queue_event(apm_event_t event);

    -#endif
    +#endif /* __LINUX_APM_EMULATION_H */

By looking at the above two diffs, I would say picking between
ARM and MIPS is equally good and the behaviour difference should
not matter in practice.

Rename-detecting diff without limit between v2.6.20 and v2.6.24
produces 991 renames and 57 copies, with or without the patch
(the resulting pairs are somewhat deferent, but I've looked at a
few and the differences looked fairly small, like the above
header files).  The output from /usr/bin/time are:

  (without patch)
  28.84user 0.33system 0:29.35elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (19major+90874minor)pagefaults 0swaps

  (with patch)
  24.81user 0.12system 0:24.93elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
  0inputs+0outputs (0major+36553minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---

 Junio C Hamano <gitster@pobox.com> writes:

 > How about this fairly obvious patch?

 This replaces the previous one by implementing "keep the best N
 candidates per each destination" as I hinted in my earlier
 message.  I suspect that we may want to optimize the O(N x M)
 part by stopping after finding enough number of good enough
 candidates for a given destination.

 diffcore-rename.c |   77 +++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 3d37725..90d06f0 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -223,6 +223,12 @@ static int score_compare(const void *a_, const void *b_)
 {
 	const struct diff_score *a = a_, *b = b_;
 
+	/* sink the unused ones to the bottom */
+	if (a->dst < 0)
+		return (0 <= b->dst);
+	else if (b->dst < 0)
+		return -1;
+
 	if (a->score == b->score)
 		return b->name_score - a->name_score;
 
@@ -387,6 +393,22 @@ static int find_exact_renames(void)
 	return i;
 }
 
+#define NUM_CANDIDATE_PER_DST 8
+static void record_if_better(struct diff_score m[], struct diff_score *o)
+{
+	int i, worst;
+
+	/* find the worst one */
+	worst = 0;
+	for (i = 1; i < NUM_CANDIDATE_PER_DST; i++)
+		if (score_compare(&m[i], &m[worst]) > 0)
+			worst = i;
+
+	/* is it better than the worst one? */
+	if (score_compare(&m[worst], o) > 0)
+		m[worst] = *o;
+}
+
 void diffcore_rename(struct diff_options *options)
 {
 	int detect_rename = options->detect_rename;
@@ -473,50 +495,65 @@ void diffcore_rename(struct diff_options *options)
 	if (num_create * num_src > rename_limit * rename_limit)
 		goto cleanup;
 
-	mx = xmalloc(sizeof(*mx) * num_create * num_src);
+	mx = xcalloc(num_create * NUM_CANDIDATE_PER_DST, sizeof(*mx));
 	for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
-		int base = dst_cnt * num_src;
 		struct diff_filespec *two = rename_dst[i].two;
+		struct diff_score *m;
+
 		if (rename_dst[i].pair)
 			continue; /* dealt with exact match already. */
+
+		m = &mx[dst_cnt * NUM_CANDIDATE_PER_DST];
+		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
+			m[j].dst = -1;
+
 		for (j = 0; j < rename_src_nr; j++) {
 			struct diff_filespec *one = rename_src[j].one;
-			struct diff_score *m = &mx[base+j];
-			m->src = j;
-			m->dst = i;
-			m->score = estimate_similarity(one, two,
-						       minimum_score);
-			m->name_score = basename_same(one, two);
+			struct diff_score this_src;
+			this_src.score = estimate_similarity(one, two,
+							     minimum_score);
+			this_src.name_score = basename_same(one, two);
+			this_src.dst = i;
+			this_src.src = j;
+			record_if_better(m, &this_src);
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
+	qsort(mx, dst_cnt * NUM_CANDIDATE_PER_DST, sizeof(*mx), score_compare);
+
+	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
+		struct diff_rename_dst *dst;
+
+		if ((mx[i].dst < 0) ||
+		    (mx[i].score < minimum_score))
+			break; /* there is no more usable pair. */
+		dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
-		if (mx[i].score < minimum_score)
-			break; /* there is no more usable pair. */
-		src = rename_src[mx[i].src].one;
-		if (src->rename_used)
+		if (rename_src[mx[i].src].one->rename_used)
 			continue;
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		rename_count++;
 	}
-	for (i = 0; i < num_create * num_src; i++) {
-		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
+
+	for (i = 0; i < dst_cnt * NUM_CANDIDATE_PER_DST; i++) {
+		struct diff_rename_dst *dst;
+
+		if ((mx[i].dst < 0) ||
+		    (mx[i].score < minimum_score))
+			break; /* there is no more usable pair. */
+		dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
-		if (mx[i].score < minimum_score)
-			break; /* there is no more usable pair. */
 		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
 		rename_count++;
 	}
+
 	free(mx);
 
  cleanup:
