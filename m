Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8629E1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfI3Bgq (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:36:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50643 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfI3Bgq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:36:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 724188E0A5;
        Sun, 29 Sep 2019 21:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yHkYvtGjaQiv3dodh+Yhn0L10TE=; b=ONe71p
        7n6lmSpKgpFTtjM5NfDk+F/vLhHp2NvEMJl4jiZW/c9OWZG67CCA4e7jjSUd7Idz
        ZxhXCxCHiI1rCPVOh28vA/VbRCkWe0qIe0URylGvs1Dt57IQuh9MD+4loVaDrlfW
        1UFyn3oBW3QRd/xoVCuoABhi+PhtaDlhe+FRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cq3n0g/9nek+4TYHFypx4PGkPKBxhH65
        firG3q/B+pwFqFPXo906U3AI+2zuCtDHSRzh28IjRj4Rvzis8xynnuNsCYNB3ux5
        67KH0OXWgzue8lD95543abkReoGGZ+6YAfSB0qEdbs84xQk1CbbKJOMjLqkdUaU7
        8AeZcYr7Yak=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D4538E0A3;
        Sun, 29 Sep 2019 21:36:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 773AD8E0A2;
        Sun, 29 Sep 2019 21:36:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, cb@hashpling.org, dstolee@microsoft.com
Subject: Re: [PATCH v4] diffcore-break: use a goto instead of a redundant if statement
References: <20190929204322.1244907-1-alexhenrie24@gmail.com>
Date:   Mon, 30 Sep 2019 10:36:39 +0900
In-Reply-To: <20190929204322.1244907-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sun, 29 Sep 2019 14:43:22 -0600")
Message-ID: <xmqqa7amimzc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0D470F4-E322-11E9-B69A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> The condition "if (q->nr <= j)" checks whether the loop exited normally
> or via a break statement. This check can be avoided by replacing the
> jump out of the inner loop with a jump to the end of the outer loop.
>
> With the break replaced by a goto, the two diff_q calls then can be
> replaced with a single diff_q call outside of the outer if statement.

I doubt that it is a good idea to do these two things.  Especially I
do not see why the latter makes the resulting code better.

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  diffcore-break.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/diffcore-break.c b/diffcore-break.c
> index 875aefd3fe..ee7519d959 100644
> --- a/diffcore-break.c
> +++ b/diffcore-break.c
> @@ -286,17 +286,15 @@ void diffcore_merge_broken(void)
>  					/* Peer survived.  Merge them */
>  					merge_broken(p, pp, &outq);
>  					q->queue[j] = NULL;
> -					break;
> +					goto next;
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
> +next:;
>  	}
>  	free(q->queue);
>  	*q = outq;
