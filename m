Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D92C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 17:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiHORWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHORWX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 13:22:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73951BF4C
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 10:22:22 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2BD11565E9;
        Mon, 15 Aug 2022 13:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QqtuSc+N0y8D89HLBgFzsRQmcrkfw6k3Rfv4SN
        v3NOg=; b=E3mJrnpOmdHl+zYs7weYtaSEET8ABzP4nNC/tgHTbaCRnW1cUznlyn
        PpWKXklN0wSqsRxdRZTQPK9bCdkSL8J/4V9TlzB0fcZRQZoh/eD5HOZ6j8ygYUGJ
        V/9z/a6M8gUD5iulfVccdtgjhxIcUAVSzugoxA0idDYbHRxypzmkQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A94871565E8;
        Mon, 15 Aug 2022 13:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 197391565E7;
        Mon, 15 Aug 2022 13:22:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/5] rebase: factor out merge_base calculation
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 10:22:20 -0700
In-Reply-To: <019158db9d2dbb371705ba79a96a907e4a17cdb1.1660576283.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 15 Aug 2022 15:11:21
        +0000")
Message-ID: <xmqqczd12zhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2041658-1CBE-11ED-855A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Separate out calculating the merge base between onto and head from the
> check for whether we can fast-forward or not. This means we can skip
> the fast-forward checks when the rebase is forced and avoid
> calculating the merge-base twice when --keep-base is given.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Note the unnecessary braces around "if (keep_base)" are added here
> reduce the churn on the next commit.
> ---
>  builtin/rebase.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6cf9c95f4e1..86ea731ca3a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
>  	struct commit_list *merge_bases = NULL;
>  	int res = 0;
>  
> -	merge_bases = get_merge_bases(onto, head);
> -	if (!merge_bases || merge_bases->next) {
> -		oidcpy(merge_base, null_oid());
> +	if (is_null_oid(merge_base))
>  		goto done;
> -	}
>  
> -	oidcpy(merge_base, &merge_bases->item->object.oid);
>  	if (!oideq(merge_base, &onto->object.oid))
>  		goto done;

Looking at the change in "git show -W", it seems that this function
no longer touches merge_bases at all, other than initializing it to
NULL at the beginning and then calling free_commit_list() on it at
the end.  Shouldn't it be removed?

> @@ -902,6 +898,20 @@ done:
>  	return res && is_linear_history(onto, head);
>  }
>  
> +static void fill_merge_base(struct rebase_options *options,
> +			    struct object_id *merge_base)
> +{
> +	struct commit_list *merge_bases = NULL;
> +
> +	merge_bases = get_merge_bases(options->onto, options->orig_head);
> +	if (!merge_bases || merge_bases->next)
> +		oidcpy(merge_base, null_oid());
> +	else
> +		oidcpy(merge_base, &merge_bases->item->object.oid);
> +
> +	free_commit_list(merge_bases);
> +}
> +
>  static int parse_opt_am(const struct option *opt, const char *arg, int unset)
>  {
>  	struct rebase_options *opts = opt->value;
> @@ -1668,7 +1678,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			die(_("Does not point to a valid commit '%s'"),
>  				options.onto_name);
>  	}
> -
> +	if (keep_base) {
> +		oidcpy(&merge_base, &options.onto->object.oid);
> +	} else {
> +		fill_merge_base(&options, &merge_base);
> +	}

No need for braces around single-statement block on either side.

This is not a new issue introduced by this patch per-se, but
"merge_base" is becoming less and less accurate description of what
this variable really is.  Perhaps it is a good time to rename it?

It is "the base commit to rebuild the history on top of", aka "onto
commit", isn't it?  We often use merge-base between the upstream and
our tip of the history for it, but the variable often does not even
hold the merge-base in it, not because we cannot compute a single
merge-base but because depending on the operation mode we do not
want to use merge-base for further operation using that variable.

