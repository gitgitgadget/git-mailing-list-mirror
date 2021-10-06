Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6E6C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1187960E08
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239230AbhJFTTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:19:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56935 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhJFTTu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 15:19:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45C5215B32F;
        Wed,  6 Oct 2021 15:17:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RPUE/q6EM74fg2URapkCysNUCPxaKAnyMyQQCj
        qwhM8=; b=tH3JkEsZwLosIVXtauPVCsnmVmWUrwju8ZtD6Xp83hcoehCeOST+zk
        aV0xh3mJN/e0Eo0x8YYe0MSVAn+6eI5g8hq0DyWxQXET5oec0B+PkVPGKoL3Z7Ke
        ozjtB7fLVp+K0NAKYABqw2mJpIl2wBdlpFnpPhvRHJ77A8P8hpFdM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E8B615B32E;
        Wed,  6 Oct 2021 15:17:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5901515B329;
        Wed,  6 Oct 2021 15:17:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] [RFC] sparse index: fix use-after-free bug in
 cache_tree_verify()
References: <pull.1053.git.1633512591608.gitgitgadget@gmail.com>
Date:   Wed, 06 Oct 2021 12:17:54 -0700
In-Reply-To: <pull.1053.git.1633512591608.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Wed, 06 Oct 2021 09:29:51 +0000")
Message-ID: <xmqq1r4yrmhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BDCA53C-26DA-11EC-B6BB-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

/*
 * Please document what the values that can be returned from
 * this function are and what they mean, just before this
 * funciton.  I am guessing that this is "all bets are off and
 * you need to redo the computation again over the full in-core
 * index"?  It is not an error and I think it makes sense to use
 * positive 1 like this patch does instead of -1.
 */
>  
> -static void verify_one(struct repository *r,
> -		       struct index_state *istate,
> -		       struct cache_tree *it,
> -		       struct strbuf *path)
> +static int verify_one(struct repository *r,
> +		      struct index_state *istate,
> +		      struct cache_tree *it,
> +		      struct strbuf *path)
>  {



> @@ -907,6 +917,9 @@ void cache_tree_verify(struct repository *r, struct index_state *istate)
>  
>  	if (!istate->cache_tree)
>  		return;
> -	verify_one(r, istate, istate->cache_tree, &path);
> +	if (verify_one(r, istate, istate->cache_tree, &path)) {
> +		strbuf_reset(&path);
> +		verify_one(r, istate, istate->cache_tree, &path);
> +	}
>  	strbuf_release(&path);
>  }

This is just a style thing, but I would find it easier to follow if
it just recursed into itself, i.e.

-	verify_one(...);
+	if (verify_one(...))
+		cache_tree_verify(r, istate);

or

-	verify_one(...);
+	again:
+	if (verify_one(...))
+		strbuf_reset(&path);
+		goto again;
}	}

On the other hand, if the new code wants to say "I would retry at
most once, otherwise there is something wrong in me", then

> -	verify_one(r, istate, istate->cache_tree, &path);
> +	if (verify_one(r, istate, istate->cache_tree, &path)) {
> +		strbuf_reset(&path);
> +		if (verify_one(r, istate, istate->cache_tree, &path))
> +			BUG("...");
> +	}

would be better.

Other than that, nicely done.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 886e78715fe..85d5279b33c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -484,7 +484,7 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
>  test_expect_success 'merge, cherry-pick, and rebase' '
>  	init_repos &&
>  
> -	for OPERATION in "merge -m merge" cherry-pick rebase
> +	for OPERATION in "merge -m merge" cherry-pick "rebase --apply" "rebase --merge"
>  	do
>  		test_all_match git checkout -B temp update-deep &&
>  		test_all_match git $OPERATION update-folder1 &&
>
> base-commit: cefe983a320c03d7843ac78e73bd513a27806845
