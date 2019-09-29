Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B221F463
	for <e@80x24.org>; Sun, 29 Sep 2019 09:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfI2Jov (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 05:44:51 -0400
Received: from avasout01.plus.net ([84.93.230.227]:44401 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfI2Jov (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 05:44:51 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Sep 2019 05:44:50 EDT
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id EVdaiZZrEbMsOEVdciNOKh; Sun, 29 Sep 2019 10:37:19 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=C5WXNjH+ c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
 a=pGLkceISAAAA:8 a=sjrD_wRZ2CGyWiRuDEgA:9 a=CjuIK1q_8ugA:10
Received: from seabee by hashpling.plus.com with local (Exim 4.89)
        (envelope-from <seabee@hashpling.org>)
        id 1iEVda-0003Z4-Ni; Sun, 29 Sep 2019 10:37:06 +0100
Date:   Sun, 29 Sep 2019 10:37:06 +0100
From:   CB Bailey <cb@hashpling.org>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] diffcore-break: use a goto instead of a redundant if
 statement
Message-ID: <20190929093706.ylm5dsftwl2y2nnz@hashpling.org>
References: <20190929005646.734046-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929005646.734046-1-alexhenrie24@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfISM68L56IKW0iToOeVwFu9e4EWx43Q5cDc+Jvxn5jpOAOfrcKziOfqjw/xEYIK0y+Nh4zDWZgeCjkcxvK3Rdb4O9HIOWvkAjglbG6WOwvgSrfHSzBcr
 DPDULB9m6orG+jekv91RGMmO9LzgAiOPfz5vlYTQ+17tgFKAzCAwLqfAnmFwC8jvtYWRe8ZLHqhAoQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 28, 2019 at 06:56:46PM -0600, Alex Henrie wrote:
> The condition "if (q->nr <= j)" checks whether the loop exited normally
> or via a break statement. This check can be avoided by replacing the
> jump to the end of the loop with a jump to the end of the function.
> 
> With the break replaced by a goto, the two diff_q calls then can be
> replaced with a single diff_q call outside of the outer if statement.
> 
> Reviewed-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  diffcore-break.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

For easier discussion, I've snipped the original patch and replaced with
one with enough context to show the entire function.

I was reviewing this patch and it appeared to introduce a change in
behaviour.

> diff --git a/diffcore-break.c b/diffcore-break.c
> index 875aefd3fe..f6ab74141b 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -262,44 +262,43 @@ static void merge_broken(struct diff_filepair *p,
> 
>  void diffcore_merge_broken(void)
>  {
>  	struct diff_queue_struct *q = &diff_queued_diff;
>  	struct diff_queue_struct outq;
>  	int i, j;
> 
>  	DIFF_QUEUE_CLEAR(&outq);
> 
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filepair *p = q->queue[i];
>  		if (!p)
>  			/* we already merged this with its peer */
>  			continue;
>  		else if (p->broken_pair &&
>  			 !strcmp(p->one->path, p->two->path)) {
>  			/* If the peer also survived rename/copy, then
>  			 * we merge them back together.
>  			 */
>  			for (j = i + 1; j < q->nr; j++) {
>  				struct diff_filepair *pp = q->queue[j];
>  				if (pp->broken_pair &&
>  				    !strcmp(pp->one->path, pp->two->path) &&
>  				    !strcmp(p->one->path, pp->two->path)) {
>  					/* Peer survived.  Merge them */
>  					merge_broken(p, pp, &outq);
>  					q->queue[j] = NULL;
> -					break;
> +					goto done;

Previously, if the condition matched in the inner loop, the function
would null out the entry in the queue that that inner loop had reached
(q->queue[j] = NULL) and then break out of the inner loop. This meant
that the outer loop would skip over this entry (if (!p)).

The change introduced seems to break out of both loops as soon as we
reach one match, whereas before other subsequent matches would be
considered and merged. Not only this, but the outer 'else' case for all
subsequent entries is skipped so the rest of the entries the original
queue are missing from 'outq'.

>  				}
>  			}
> -			if (q->nr <= j)
> -				/* The peer did not survive, so we keep
> -				 * it in the output.
> -				 */
> -				diff_q(&outq, p);
> +			/* The peer did not survive, so we keep
> +			 * it in the output.
> +			 */
>  		}
> -		else
> -			diff_q(&outq, p);
> +		diff_q(&outq, p);
>  	}
> +
> +done:
>  	free(q->queue);
>  	*q = outq;
> 
>  	return;
>  }

I spent a bit of time trying to see if this change was user visible
which turned out to be unneeded as t4008-diff-break-rewrite.sh already
fails with this change for me in my environment, initially with this
test but also 3 other tests in this file.

> expecting success of 4008.6 'run diff with -B (#3)':
> 	git diff-index -B reference >current &&
> 	cat >expect <<-EOF &&
> 	:100644 100644 $blob0_id $blob1_id M100	file0
> 	:100644 100644 $blob1_id $blob0_id M100	file1
> 	EOF
> 	compare_diff_raw expect current
> 
> --- .tmp-1	2019-09-29 09:21:07.089070076 +0000
> +++ .tmp-2	2019-09-29 09:21:07.093070086 +0000
> @@ -1,2 +1 @@
>  :100644 100644 548142c327a6790ff8821d67c2ee1eff7a656b52 6ff87c4664981e4397625791c8ea3bbb5f2279a3 M#	file0
> -:100644 100644 6ff87c4664981e4397625791c8ea3bbb5f2279a3 548142c327a6790ff8821d67c2ee1eff7a656b52 M#	file1
> not ok 6 - run diff with -B (#3)
