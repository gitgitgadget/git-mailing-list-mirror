Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFE91F42B
	for <e@80x24.org>; Fri,  5 Jan 2018 20:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeAEUaW (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:30:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65030 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeAEUaU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:30:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2640AC7B1E;
        Fri,  5 Jan 2018 15:30:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SncJPcsuAvAV4qtkrBFF4/yyH1M=; b=tXtM3m
        IGzIxwhNCFYXnoYYWBPO+hBH3d7+956HWxaj2bQwqqnmEwgbH5RMU/u9xpYxnHnO
        NH0607E8taU434+cEd88/oBnrVGwYfRi5JOu+c5i6Gto4BWQPCkDyCmb8b98CerZ
        KdXokhURcCq+0PqEugl5NlfelG0tAKME1jKac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cCEwv94IJKisUm9p/3n0HGRtFPVZXSp5
        7SNqe8Tzrzyr9zFTh/IQIJLAXYUlhGtNo5Cq/lJhZPkMXMNKv5YExtUBVCF4d9UJ
        tmdtXCwBJOgTdLxXI6pseHgwcv7CrsY+46VcbHHJ7MzBCEF321tCk3kS/pyxh0mx
        FeLRE4M1lT0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EB6EC7B1D;
        Fri,  5 Jan 2018 15:30:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93BC1C7B1C;
        Fri,  5 Jan 2018 15:30:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kim Gybels <kgybels@infogroep.be>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: [PATCH] rebase -p: fix quoting when calling `git merge`
References: <8cafe900ce97d885c58f4a7f02e748d2ae3b02a2.1515101305.git.johannes.schindelin@gmx.de>
Date:   Fri, 05 Jan 2018 12:30:18 -0800
In-Reply-To: <8cafe900ce97d885c58f4a7f02e748d2ae3b02a2.1515101305.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 4 Jan 2018 22:31:52 +0100
        (STD)")
Message-ID: <xmqqvaggaw11.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F4D92D0-F257-11E7-98F6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>  git-rebase--interactive.sh |  9 ++++++---
>  t/t3418-rebase-continue.sh | 14 ++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index e3f5a0abf3c..085aa068cbb 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -392,9 +392,12 @@ pick_one_preserving_merges () {
>  			new_parents=${new_parents# $first_parent}
>  			merge_args="--no-log --no-ff"
>  			if ! do_with_author output eval \
> -			'git merge ${gpg_sign_opt:+"$gpg_sign_opt"} \
> -				$allow_rerere_autoupdate $merge_args \
> -				$strategy_args -m "$msg_content" $new_parents'
> +				git merge ${gpg_sign_opt:+$(git rev-parse \
> +					--sq-quote "$gpg_sign_opt")} \
> +				$allow_rerere_autoupdate "$merge_args" \
> +				"$strategy_args" \
> +				-m $(git rev-parse --sq-quote "$msg_content") \
> +				"$new_parents"

Makes sense.  I should have been more careful when reviewing
db2b3b820e2.

Thanks.
