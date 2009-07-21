From: Junio C Hamano <gitster@pobox.com>
Subject: Re: three-way diff performance problem
Date: Tue, 21 Jul 2009 12:47:33 -0700
Message-ID: <7vd47tes2y.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain>
 <7v7hy1g7vg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:47:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLJV-0004Ld-4n
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 21:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980AbZGUTrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 15:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755967AbZGUTrk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 15:47:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63745 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951AbZGUTrk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 15:47:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DF870EE2D;
	Tue, 21 Jul 2009 15:47:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1A203EE29; Tue,
 21 Jul 2009 15:47:34 -0400 (EDT)
In-Reply-To: <7v7hy1g7vg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 21 Jul 2009 12\:21\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59281534-762F-11DE-9C14-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123688>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> In fact, on the instruction-level profile, it looks like it's all spent on 
>> four instructions:
>>
>>     3.51 :        45aec0:       4c 85 72 10             test   %r14,0x10(%rdx)
>>    86.27 :        45aec4:       48 0f 45 ca             cmovne %rdx,%rcx
>>          :              if (sline->lost_head) {
>>          :                      struct lline *last_one = NULL;
>>          :                      /* We cannot squash it with earlier one */
>>          :                      for (lline = sline->lost_head;
>>          :                           lline;
>>          :                           lline = lline->next)
>>     6.69 :        45aec8:       48 8b 12                mov    (%rdx),%rdx
>>          :
>>          :              /* Check to see if we can squash things */
>>          :              if (sline->lost_head) {
>>          :                      struct lline *last_one = NULL;
>>          :                      /* We cannot squash it with earlier one */
>>          :                      for (lline = sline->lost_head;
>>     3.51 :        45aecb:       48 85 d2                test   %rdx,%rdx
>>     0.01 :        45aece:       75 f0                   jne    45aec0 <consume_line+0xc0>
>> ...
> After feeding the first diff (forget the one with +m1,n1 example above),
> if the second diff looks like this:
>
>     @@ -l,k +m2,n2 @@
>     -another lost line
>     -lost line
>      common line
>     +added line
>
> we match "-another lost line" with the second element in lost_head list,
> and when processing the next line "-lost line", we try to avoid matching
> it with the first one in the list, by stupidly scanning from the front of
> the list.  I think we should add a member to struct sline to remember the
> last element in lost_head list for the current parent to skip that scan.
> Perhaps that scan is the one that is costing, not memcmp()?

Here is a patch to do that.  I haven't tested it yet though.

 combine-diff.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bbf74fc..8194104 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -80,6 +80,7 @@ struct lline {
 /* Lines surviving in the merge result */
 struct sline {
 	struct lline *lost_head, **lost_tail;
+	struct lline *lost_last_for_current_parent;
 	char *bol;
 	int len;
 	/* bit 0 up to (N-1) are on if the parent has this line (i.e.
@@ -121,18 +122,15 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 
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
+		if (sline->lost_last_for_current_parent)
+			lline = sline->lost_last_for_current_parent;
+		else
+			lline = sline->lost_head;
 		while (lline) {
 			if (lline->len == len &&
 			    !memcmp(lline->line, line, len)) {
 				lline->parent_map |= this_mask;
+				sline->lost_last_for_current_parent = lline;
 				return;
 			}
 			lline = lline->next;
@@ -147,6 +145,7 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 	lline->line[len] = 0;
 	*sline->lost_tail = lline;
 	sline->lost_tail = &lline->next;
+	sline->lost_last_for_current_parent = lline;
 }
 
 struct combine_diff_state {
@@ -187,6 +186,7 @@ static void consume_line(void *state_, char *line, unsigned long len)
 				xcalloc(state->num_parent,
 					sizeof(unsigned long));
 		state->sline[state->nb-1].p_lno[state->n] = state->ob;
+		state->lost_bucket->lost_last_for_current_parent = NULL;
 		return;
 	}
 	if (!state->lost_bucket)
