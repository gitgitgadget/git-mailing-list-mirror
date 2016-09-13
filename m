Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CED6207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 00:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbcIMAFs (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 20:05:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61001 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbcIMAFr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 20:05:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 112D53D420;
        Mon, 12 Sep 2016 20:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+RRmQQq+aBP+3CZIrK8G6USDqWQ=; b=CKqcWg
        HXLNlYQe+gdMdJcuMdx6cSM8jxvr9054dBw8cs+HTldQBl+oKTbBshvHnoHLxvFc
        an0eDt34gguQbppLKZATustDRSaen8pW+G0XtdIrJuvHTzK35StaOjGhHGBn6nin
        rgrYE0MB6tTd4ADlrzK5qMGXBtBmIVP1eajAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iNzvyFG9SzzK2/zqthsnACty7k8bR2B5
        /gTy4TLSeAOe9oowqBsUit26rVIthLhjFH6ul1KxQLy9CWt2kM76x9BwpxnD7qXc
        wyEGZf6wCKpWad3FzoSPI11h5LpF8aA9XGT6f6ItbZ+IArbnSKz6XG+7ef7ebu/h
        d49eMqcXbOw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 083333D41E;
        Mon, 12 Sep 2016 20:05:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 837E43D41B;
        Mon, 12 Sep 2016 20:05:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <stefanbeller@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 05/10] diff.c: reintroduce diff_flush_patch for all files
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
        <1473572530-25764-6-git-send-email-stefanbeller@gmail.com>
Date:   Mon, 12 Sep 2016 17:05:43 -0700
In-Reply-To: <1473572530-25764-6-git-send-email-stefanbeller@gmail.com>
        (Stefan Beller's message of "Sat, 10 Sep 2016 22:42:05 -0700")
Message-ID: <xmqqsht4wtns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D179EC08-7945-11E6-92BA-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <stefanbeller@gmail.com> writes:

> From: Stefan Beller <sbeller@google.com>
>
> ---

This shows why 04/10 should have had the overall plan for these two
steps.  We want a short-and-sweet name "diff-flush-patch" to mean
"flush all the queued diff elements" so rename the singleton one
from diff-flush-patch to diff-flush-patch-filepair to make room in
04/10 and then introduce the "diff-flush-patch-all" in 05/10.

I just said with the above explanation the changes in 04/10 and
05/10 become undertandable, which is a bit different from being
justifiable.  "diff_flush_raw()", "diff_flush_stat()", etc. are
_all_ about a single filepair.  I'd rather see diff_flush_patch()
to be also about a single filepair.

It may be helpful to have a helper that calls diff_flush_patch() for
all filepairs in the queue, but can't that function get a new name
instead?  By definition, it will be called much less often than a
pair-wise one, so it can afford to have a longer name.

diff_flush_patch_queue() or something, perhaps?  I am not sure if it
should be diff_flush_queue_patch(), or even

    diff_flush_queue(struct diff_options *o, diff_flush_fn fn);

where diff_flush_fn is 

    typedef void (*diff_flush_fn)(struct diff_filepair *p,
    			struct diff_options *o, void *other_data)

that can be used to flush the queue by calling any of these
filepair-wise flush functions like diff_flush_{raw,stat,checkdiff,patch}.

This last approach might be overkill, but if you want to try it,
you'd need a preparatory step to give an unused "void *other" to
diff_flush_{raw,patch,checkdiff} as diff_flush_stat() is an oddball
that needs an extra "accumulator" pointer.  I actually wonder if
that "diffstat" pointer should become part of "struct diff_options",
though.  Anyway.

>  diff.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 85fb887..87b1bb2 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4608,6 +4608,17 @@ void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc)
>  		warning(rename_limit_advice, varname, needed);
>  }
>  
> +static void diff_flush_patch(struct diff_options *o)
> +{
> +	int i;
> +	struct diff_queue_struct *q = &diff_queued_diff;
> +	for (i = 0; i < q->nr; i++) {
> +		struct diff_filepair *p = q->queue[i];
> +		if (check_pair_status(p))
> +			diff_flush_patch_filepair(p, o);
> +	}
> +}
> +
>  void diff_flush(struct diff_options *options)
>  {
>  	struct diff_queue_struct *q = &diff_queued_diff;
> @@ -4702,11 +4713,7 @@ void diff_flush(struct diff_options *options)
>  			}
>  		}
>  
> -		for (i = 0; i < q->nr; i++) {
> -			struct diff_filepair *p = q->queue[i];
> -			if (check_pair_status(p))
> -				diff_flush_patch_filepair(p, options);
> -		}
> +		diff_flush_patch(options);
>  	}
>  
>  	if (output_format & DIFF_FORMAT_CALLBACK)
