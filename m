Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D681F462
	for <e@80x24.org>; Fri, 26 Jul 2019 19:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfGZT5e (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 15:57:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62398 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfGZT5e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 15:57:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71BF878DA3;
        Fri, 26 Jul 2019 15:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SNwkVMn7SBE+STR4IJvz8TejHac=; b=e4dW8p
        tCp77RtfARJc8bnAIVn4XsX1iv1/e76QmuklDufoU54TV3fV3LthXadHpA6/MwYt
        vHCAMPcxs7O/nw05XYgrRH3nIOVPME4EcGriRGj20WMVgqvoUeE4C1x0G8lgCANm
        +xVx/NFQ/+2H6KojIpqb4+e/i8x7sYv/qzn8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S99K+CKKU2nDvpr1CuqMNbJuipHHvv3y
        TgApdujtYlXWJpwwloIUgvPjYweQftai2p4Jx3zt1PTPMbWSCL9VV2ejSZ6mJkFt
        rb8DhBYn6KJvRUH5wVzLDCi7mditdswCAXH/9kVewfcUMidPn+EI97gi4Y8xlDu5
        aFxQSkFUyYs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 69FEC78DA2;
        Fri, 26 Jul 2019 15:57:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8AB6A78D9F;
        Fri, 26 Jul 2019 15:57:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 06/20] merge-recursive: don't force external callers to do our logging
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-7-newren@gmail.com>
Date:   Fri, 26 Jul 2019 12:57:24 -0700
In-Reply-To: <20190726155258.28561-7-newren@gmail.com> (Elijah Newren's
        message of "Fri, 26 Jul 2019 08:52:44 -0700")
Message-ID: <xmqq36iso9gb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97802322-AFDF-11E9-8D5F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Alternatively, you can view this as "make the merge functions behave
> more similarly."  merge-recursive has three different entry points:
> merge_trees(), merge_recursive(), and merge_recursive_generic().  Two of
> these would call diff_warn_rename_limit(), but merge_trees() didn't.
> This lead to callers of merge_trees() needing to manually call
> diff_warn_rename_limit() themselves.  Move this to the new
> merge_finalize() function to make sure that all three entry points run
> this function.

Interesting.  It seems that b520abf1c8f did a suboptimal jobs but
this step cleans it up quite nicely.

Are there callers of merge_trees() in other codepaths, and do they
want this change?

There is only one, builtin/checkout.c::merge_working_tree(), which
is used when switching to a different commit.  I think it would not
hurt to give the same warning (but I also think it would not hurt to
simply disable rename detection in that context); we should record
the whatever decision we make in the log message.


> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 7 +++----
>  sequencer.c       | 1 -
>  2 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 4a481c3929..308e350ff1 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3583,9 +3583,6 @@ static int merge_recursive_internal(struct merge_options *opt,
>  	flush_output(opt);
>  	if (!opt->call_depth && opt->buffer_output < 2)
>  		strbuf_release(&opt->obuf);
> -	if (show(opt, 2))
> -		diff_warn_rename_limit("merge.renamelimit",
> -				       opt->needed_rename_limit, 0);
>  	return clean;
>  }
>  
> @@ -3607,7 +3604,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
>  
>  static void merge_finalize(struct merge_options *opt)
>  {
> -	/* Common code for wrapping up merges will be added here later */
> +	if (show(opt, 2))
> +		diff_warn_rename_limit("merge.renamelimit",
> +				       opt->needed_rename_limit, 0);
>  }
>  
>  int merge_trees(struct merge_options *opt,
> diff --git a/sequencer.c b/sequencer.c
> index c4ed30f1b4..094a4dd03d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -617,7 +617,6 @@ static int do_recursive_merge(struct repository *r,
>  	if (is_rebase_i(opts) && clean <= 0)
>  		fputs(o.obuf.buf, stdout);
>  	strbuf_release(&o.obuf);
> -	diff_warn_rename_limit("merge.renamelimit", o.needed_rename_limit, 0);
>  	if (clean < 0) {
>  		rollback_lock_file(&index_lock);
>  		return clean;
