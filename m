From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optimize rename detection for a huge diff
Date: Wed, 13 Feb 2008 01:53:55 -0800
Message-ID: <7vodalqj0s.fsf@gitster.siamese.dyndns.org>
References: <20080127172748.GD2558@does.not.exist>
 <20080128055933.GA13521@coredump.intra.peff.net>
 <alpine.LFD.1.00.0801300844170.28476@www.l.google.com>
 <20080129222007.GA3985@coredump.intra.peff.net>
 <7vfxwgmf87.fsf@gitster.siamese.dyndns.org>
 <7vwspskynz.fsf@gitster.siamese.dyndns.org>
 <7vprvkj58q.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 10:55:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPEKY-0001h2-N9
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 10:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYBMJyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 04:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbYBMJyb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 04:54:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41811 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYBMJya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 04:54:30 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E0BC2D26;
	Wed, 13 Feb 2008 04:54:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.77]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.pobox.com (Postfix) with ESMTP id DB32C2D22; Wed, 13 Feb 2008
 04:54:16 -0500 (EST)
In-Reply-To: <7vprvkj58q.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Tue, 29 Jan 2008 20:40:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73764>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 28 Jan 2008, Jeff King wrote:
>> 
>> I tried to reproduce this, but my peak heap allocation was only around
>> 20MB. Is your repository fully packed? Not packed at all? Can you use
>> valgrind/massif to figure out where the memory is going?
>
> I definitely can reproduce it, it's horrid.
>
> This is from "top" fairly late in the game, but with the thing not even 
> done yet. Current git, pretty much fully (and fairly aggressively) packed 
> current kernel repo, and using "diff.renamelmit=0".
>
> 	4751 torvalds  20   0  852m 446m  47m R   72 22.4   2:46.58 git-merge-recur
>
> It finally finished with time reporting:
>
> 	208.15user 3.50system 4:01.50elapsed 87%CPU (0avgtext+0avgdata 0maxresident)k
> 	238736inputs+4544outputs (8261major+280971minor)pagefaults 0swaps
>
> where those 280971 minor page faults are what largely indicates how much 
> memory it used (the technical term for that number is "metric buttload of 
> memory").

With a bit of tweak, now I am getting these numbers to the
rename detection that used to spend 800MB (the peak I observed
was somewhere around 430MB).

(after patch, in the kernel repository, master at 96b5a46)
$ /usr/bin/time git-diff -M -l0 --name-status d19fbe8a7 master >/var/tmp/3
157.20user 1.03system 2:38.72elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (32major+237315minor)pagefaults 0swaps

$ /usr/bin/time git-diff -M -l0 --name-status d19fbe8a7 master >/var/tmp/4
174.00user 2.73system 3:09.55elapsed 93%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (6106major+459314minor)pagefaults 0swaps

So it is not that much of an improvement, but it seems to help
somewhat.

The first hunk is about shrinking the diff_score structure;
before the patch, it was O(NxM) where N and M are number of
rename source and destination candidates, but after the patch it
is now O(M), so this shrinkage should not matter, but score is
capped to MAX_SCORE (60000) and name_score is actually 0 or 1.
We cannot make it 1-bit unsigned bitfield as there is a qsort
comparison callback that does (b->name_score - a->name_score).

We would need to see where the remaining 400MB is going and try
to shrink it, but this would be an improvement so I'll soon be
moving this to 'next'.

---

 diffcore-rename.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 90d06f0..99953e7 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -112,8 +112,8 @@ static int basename_same(struct diff_filespec *src, struct diff_filespec *dst)
 struct diff_score {
 	int src; /* index in rename_src */
 	int dst; /* index in rename_dst */
-	int score;
-	int name_score;
+	unsigned short score;
+	short name_score;
 };
 
 static int estimate_similarity(struct diff_filespec *src,
@@ -393,7 +393,7 @@ static int find_exact_renames(void)
 	return i;
 }
 
-#define NUM_CANDIDATE_PER_DST 8
+#define NUM_CANDIDATE_PER_DST 4
 static void record_if_better(struct diff_score m[], struct diff_score *o)
 {
 	int i, worst;
