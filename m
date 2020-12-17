Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCF0C4361B
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 06:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5F12371F
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 06:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgLQGI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 01:08:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53931 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgLQGI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 01:08:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA3F681FC8;
        Thu, 17 Dec 2020 01:08:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Us5t978x+V/wZlq+pwasaYs2pHc=; b=XTK1Vb
        nUAPit92+ER3ihGscWRQBNTbGP2fHlv5tZkjFUwH2ufPuDux3kpmrYW/l2BuejKX
        J82JhX0bPb79sPEVqcMleRFI2YdaKWN9TlNwlmL+VTKDt5qnysE1vQPsTxPpxA7K
        svFGfSt5qSP905sbgblrqn5L7GQvwCtOAz0b0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aM9FhRf7hK2c2QYQBXCM9P+ZCjzYxmlS
        FJW3LXQ/UzThx/mZ9vn/5/BDbemj+N3o7bwrb3OyyCCjQET5rItZ1w4mk/Tb/7To
        +fl4tl5zzRSuB84D8ffKX226mHJtQ4yAYDp1SCl0MGZ8gFJXOERGyHVcBvUxS99j
        JaCxZvbxRRk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C004981FC7;
        Thu, 17 Dec 2020 01:08:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5034281FC4;
        Thu, 17 Dec 2020 01:08:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "Daniel C . Klauer" <daniel.c.klauer@web.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] pack-redundant: fix crash when one packfile in repo
References: <xmqqo8it4pxt.fsf@gitster.c.googlers.com>
        <20201217015709.28827-1-worldhello.net@gmail.com>
Date:   Wed, 16 Dec 2020 22:08:11 -0800
In-Reply-To: <20201217015709.28827-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Wed, 16 Dec 2020 20:57:09 -0500")
Message-ID: <xmqqczz9yng4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E56DD46-402E-11EB-97E4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> Command `git pack-redundant --all` will crash if there is only one
> packfile in the repository.  This is because, if there is only one
> packfile in local_packs, `cmp_local_packs` will do nothing and will
> leave `pl->unique_objects` as uninitialized.
>
> Also add testcases for repository with no packfile and one packfile
> in t5323.
>
> Reported-by: Daniel C. Klauer <daniel.c.klauer@web.de>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  builtin/pack-redundant.c  |  6 ++++++
>  t/t5323-pack-redundant.sh | 37 +++++++++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 4 deletions(-)

Thanks.

>
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 178e3409b7..690775fa82 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -473,6 +473,12 @@ static void cmp_local_packs(void)
>  {
>  	struct pack_list *subset, *pl = local_packs;
>  
> +	/* only one packfile */
> +	if (!pl->next) {
> +		llist_init(&pl->unique_objects);
> +		return;
> +	}
> +
>  	while ((subset = pl)) {
>  		while ((subset = subset->next))
>  			cmp_two_packs(pl, subset);
> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> index 6b4d1ca353..7e3340843f 100755
> --- a/t/t5323-pack-redundant.sh
> +++ b/t/t5323-pack-redundant.sh
> @@ -112,19 +112,28 @@ test_expect_success 'setup master repo' '
>  	create_commits_in "$master_repo" A B C D E F G H I J K L M N O P Q R
>  '
>  
> +test_expect_success 'master: pack-redundant works with no packfile' '
> +	(
> +		cd "$master_repo" &&
> +		cat >expect <<-EOF &&
> +			fatal: Zero packs found!
> +			EOF
> +		test_must_fail git pack-redundant --all >actual 2>&1 &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  #############################################################################
>  # Chart of packs and objects for this test case
>  #
>  #         | T A B C D E F G H I J K L M N O P Q R
>  #     ----+--------------------------------------
>  #     P1  | x x x x x x x                       x
> -#     P2  |     x x x x   x x x
> -#     P3  |             x     x x x x x
>  #     ----+--------------------------------------
> -#     ALL | x x x x x x x x x x x x x x         x
> +#     ALL | x x x x x x x                       x
>  #
>  #############################################################################
> -test_expect_success 'master: no redundant for pack 1, 2, 3' '
> +test_expect_success 'master: pack-redundant works with one packfile' '
>  	create_pack_in "$master_repo" P1 <<-EOF &&
>  		$T
>  		$A
> @@ -135,6 +144,26 @@ test_expect_success 'master: no redundant for pack 1, 2, 3' '
>  		$F
>  		$R
>  		EOF
> +	(
> +		cd "$master_repo" &&
> +		git pack-redundant --all >out &&
> +		test_must_be_empty out
> +	)
> +'
> +
> +#############################################################################
> +# Chart of packs and objects for this test case
> +#
> +#         | T A B C D E F G H I J K L M N O P Q R
> +#     ----+--------------------------------------
> +#     P1  | x x x x x x x                       x
> +#     P2  |     x x x x   x x x
> +#     P3  |             x     x x x x x
> +#     ----+--------------------------------------
> +#     ALL | x x x x x x x x x x x x x x         x
> +#
> +#############################################################################
> +test_expect_success 'master: no redundant for pack 1, 2, 3' '
>  	create_pack_in "$master_repo" P2 <<-EOF &&
>  		$B
>  		$C
