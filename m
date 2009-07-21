From: Junio C Hamano <gitster@pobox.com>
Subject: Re: three-way diff performance problem
Date: Tue, 21 Jul 2009 13:46:33 -0700
Message-ID: <7vd47tbw7q.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain>
 <7v7hy1g7vg.fsf@alter.siamese.dyndns.org>
 <7vd47tes2y.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0907211324220.19335@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTMEZ-0003H2-Gs
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410AbZGUUqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755079AbZGUUqk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:46:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943AbZGUUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:46:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B912BE314;
	Tue, 21 Jul 2009 16:46:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C2ACAE313; Tue,
 21 Jul 2009 16:46:35 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0907211324220.19335@localhost.localdomain>
 (Linus Torvalds's message of "Tue\, 21 Jul 2009 13\:34\:07 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 97115C0E-7637-11DE-9AE9-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123714>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 21 Jul 2009, Junio C Hamano wrote:
>> 
>> Here is a patch to do that.  I haven't tested it yet though.
>
> Well, it seems to work.
>
> It turned the 85+ minute thing (which I eventually just killed) into 
> something that took 1.4 _seconds_. Of course, I didn't check that the end 
> result was identical, since I never had the patience to wait for the 
> original case.
>
> Now sadly, my fixed test (which took 45 seconds before) didn't much 
> improve (it doesn't have nearly as many removed lines, since I checked in 
> the _right_ file that is a much closer version to the parent files).
>
> But what is intriguing is that it it gets different results. So I suspect 
> this one actually changed behavior some way:
>
> 	[torvalds@nehalem git-merge]$ time git show --color HEAD | wc
> 	  22671   63302  672234
> 	
> 	real	0m44.024s
> 	user	0m43.879s
> 	sys	0m0.148s
>
> 	[torvalds@nehalem git-merge]$ time ~/git/git show --color HEAD | wc
> 	  22596   63122  671076
> 	
> 	real	0m43.553s
> 	user	0m43.435s
> 	sys	0m0.128s
>
> and notice how the git version with your change gives different line 
> numbers.
>
> Now, this is a diff, and different answers are possibly _both_ valid, so 
> who knows. But I suspect that you _intended_ for the patch to be a 
> semantic no-op, and it doesn't seem to be.

I know why.  The conversion was wrong.  The original found the last_one
that was from the parent we are looking at, and when there is such, it
started the scan from the one _after that_.  Otherwise, if lost_head list
had an entry

	@@ -l,k +m,n @@
        -one
         two
         three

and the diff with the parent we are currently looking at duplicates
removal:

	@@ -l,k +m1,n1 @@
	-one
        -one
         two
         three

we will end up losing the second removal, which would be what is happening
with the patch you tried.

I actually was scratching my head wondering why it wasn't happening in the
original code after I sent that faulty patch.

Here is another attempt.

 combine-diff.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bbf74fc..2438490 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -80,6 +80,7 @@ struct lline {
 /* Lines surviving in the merge result */
 struct sline {
 	struct lline *lost_head, **lost_tail;
+	struct lline *next_lost;
 	char *bol;
 	int len;
 	/* bit 0 up to (N-1) are on if the parent has this line (i.e.
@@ -121,18 +122,12 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 
 	/* Check to see if we can squash things */
 	if (sline->lost_head) {
-		struct lline *last_one = NULL;
-		/* We cannot squash it with earlier one */
-		for (lline = sline->lost_head;
-		     lline;
-		     lline = lline->next)
-			if (lline->parent_map & this_mask)
-				last_one = lline;
-		lline = last_one ? last_one->next : sline->lost_head;
+		lline = sline->next_lost;
 		while (lline) {
 			if (lline->len == len &&
 			    !memcmp(lline->line, line, len)) {
 				lline->parent_map |= this_mask;
+				sline->next_lost = lline->next;
 				return;
 			}
 			lline = lline->next;
@@ -147,6 +142,7 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 	lline->line[len] = 0;
 	*sline->lost_tail = lline;
 	sline->lost_tail = &lline->next;
+	sline->next_lost = NULL;
 }
 
 struct combine_diff_state {
@@ -187,6 +183,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 				xcalloc(state->num_parent,
 					sizeof(unsigned long));
 		state->sline[state->nb-1].p_lno[state->n] = state->ob;
+		state->lost_bucket->next_lost = state->lost_bucket->lost_head;
 		return;
 	}
 	if (!state->lost_bucket)
