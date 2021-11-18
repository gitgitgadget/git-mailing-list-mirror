Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47504C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC6261AA3
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 23:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhKRXyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 18:54:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57257 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKRXyB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 18:54:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55632104668;
        Thu, 18 Nov 2021 18:51:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9J57T/9WdIH2355IrTajEYqKELNf3nxliH9iMurVjMg=; b=QnhR
        y8m2rYfPPZO6nDtbJhGqZ3bnmYHj60iAqrc43vBYV+V2vSlr2qDvVLrgqN6qerbf
        n1fFTJ81YO/0lClKq+AUNDUJ2G4RJM1OwSToWHAxV5usihLN31zxFOKqZ7zaRMli
        qEVD0zS5rd+iG+6Ql51UtB0sOr+ILPo5cy8wStU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41E4B104667;
        Thu, 18 Nov 2021 18:51:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A447F104666;
        Thu, 18 Nov 2021 18:50:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Erwin Villejo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erwin Villejo <erwinvillejo@gmail.com>,
        Erwin Villejo <erwin.villejo@gmail.com>
Subject: Re: [PATCH] pull: should be noop when already-up-to-date
References: <pull.1078.git.1637135750674.gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 15:50:58 -0800
Message-ID: <xmqqbl2huiot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 616ED252-48CA-11EC-8B1C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Erwin Villejo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Erwin Villejo <erwin.villejo@gmail.com>
>
> The already-up-to-date pull bug was fixed for --ff-only but it did not
> include the case where --ff or --ff-only are not specified. This updates
> the --ff-only fix to include the case where --ff or --ff-only are not
> specified in command line flags or config.
>
> Signed-off-by: Erwin Villejo <erwin.villejo@gmail.com>
> ---

> @@ -1102,15 +1103,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	can_ff = get_can_ff(&orig_head, &merge_heads);
> +	divergent = !can_ff && !already_up_to_date(&orig_head, &merge_heads);
>  
>  	/* ff-only takes precedence over rebase */
>  	if (opt_ff && !strcmp(opt_ff, "--ff-only")) {
> -		if (!can_ff && !already_up_to_date(&orig_head, &merge_heads))
> +		if (divergent)
>  			die_ff_impossible();
>  		opt_rebase = REBASE_FALSE;
>  	}
>  	/* If no action specified and we can't fast forward, then warn. */
> -	if (!opt_ff && rebase_unspecified && !can_ff) {
> +	if (!opt_ff && rebase_unspecified && divergent) {
>  		show_advice_pull_non_ff();
>  		die(_("Need to specify how to reconcile divergent branches."));
>  	}

Looks correct.  I wonder if there is a simplify these two checks,
but let's keep the original code structure for now in this step,
which is about correctness.

Will apply.  Thanks.

> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 6275641b9c2..bd238d89b0c 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -387,6 +387,12 @@ test_expect_success 'pull prevents non-fast-forward with "only" in pull.ff' '
>  	test_must_fail git pull . c3
>  '
>  
> +test_expect_success 'already-up-to-date pull succeeds with unspecified pull.ff' '
> +	git reset --hard c1 &&
> +	git pull . c0 &&
> +	test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
> +'
> +
>  test_expect_success 'already-up-to-date pull succeeds with "only" in pull.ff' '
>  	git reset --hard c1 &&
>  	test_config pull.ff only &&
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
