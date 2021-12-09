Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAA8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhLIUxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:53:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57961 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhLIUxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:53:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB620F4B9D;
        Thu,  9 Dec 2021 15:49:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zeWaixk/r1utjQwzsWtHkUpqG0WBiK1i2pGF2v
        iVjLg=; b=MtYsGtg7oiITV6CCArPy79vlhmt5Vl5P++xlbJN2reseIG5dJnODsn
        uPT2qjq9EerWgQtX6C0B+flCOD/7NB5VJjDPyoaCUpC1Jr0BHsx4ac0mWYk2Y+hz
        AUd/RhH1QoruOb/FXeLBxX0qwmExL8RPjkBSnjDChyyAPa/29zzvU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2861F4B99;
        Thu,  9 Dec 2021 15:49:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2FB63F4B98;
        Thu,  9 Dec 2021 15:49:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 12/14] rebase --apply: fix reflog
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <dc5d11291e78bddde448f6e273bc58e9f2f83c95.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 12:49:41 -0800
In-Reply-To: <dc5d11291e78bddde448f6e273bc58e9f2f83c95.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:59
        +0000")
Message-ID: <xmqq35n1qza2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8939B8E8-5931-11EC-84EB-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (opts->orig_head_msg && !update_orig_head)
> +		BUG("ORIG_HEAD reflog message given without updating ORIG_HEAD");
> +
> +	if (opts->branch_msg && !opts->branch)
> +		BUG("branch reflog message given without a branch");
> +

Looking pretty good.

> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 77a313f62eb..d17b450e811 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -105,6 +105,29 @@ test_expect_success 'GIT_REFLOG_ACTION' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'rebase --apply reflog' '
> +	git checkout -b reflog-apply start &&
> +	old_head_reflog="$(git log -g --format=%gs -1 HEAD)" &&
> +
> +	git rebase --apply Y &&
> +
> +	git log -g --format=%gs -4 HEAD >actual &&
> +	cat >expect <<-EOF &&
> +	rebase finished: returning to refs/heads/reflog-apply
> +	rebase: Z
> +	rebase: checkout Y
> +	$old_head_reflog
> +	EOF
> +	test_cmp expect actual &&
> +
> +	git log -g --format=%gs -2 reflog-apply >actual &&
> +	cat >expect <<-EOF &&
> +	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
> +	branch: Created from start
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'rebase -i onto unrelated history' '
>  	git init unrelated &&
>  	test_commit -C unrelated 1 &&
