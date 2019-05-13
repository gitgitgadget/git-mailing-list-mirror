Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C0F11F461
	for <e@80x24.org>; Mon, 13 May 2019 23:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfEMX3N (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 19:29:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63930 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEMX3N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 19:29:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71ABC15CA08;
        Mon, 13 May 2019 19:29:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sg1kRNTidVVnR3Ben9Ue1GdpSc8=; b=Cbgu+F
        7DPwx7hlYSDQm77fZYworhPZszpvS+7cavtlYvX39p9hHEsDwgbzk5AxCaVC/8el
        DlfB2+sw4424Tn8DCackEvhmQw8X6ZTOKHEx2FjsLSRKYR4W0aZhKK7GRuZ8ejYz
        NYsj/PnVpnNixVj6h4lJ4kO/QKAshlIKZofKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nhX5b6vZfBIqyst2t2/y0t0YroxJcjE6
        +YF4w2krSfg3yrRJmsFm/AYdjaa9PNJfbzKwqWTQ8Yrjofv7AW1ctkuSK16TyUsM
        TBiK/5P6Kra1Di3bWTMG2O+UnvIWP4dwsh6S1A/f2D3yx28E/j175G/kYdofVooz
        uBHrF/aZ9lY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68CD015CA07;
        Mon, 13 May 2019 19:29:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CBABB15CA05;
        Mon, 13 May 2019 19:29:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] parse-options: adjust `parse_opt_unknown_cb()`s declared return type
References: <pull.192.git.gitgitgadget@gmail.com>
        <dd283736b72d3e52bd298b0360ab66ffd15c1cf9.1557787395.git.gitgitgadget@gmail.com>
Date:   Tue, 14 May 2019 08:29:08 +0900
In-Reply-To: <dd283736b72d3e52bd298b0360ab66ffd15c1cf9.1557787395.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 13 May 2019
        15:43:17 -0700 (PDT)")
Message-ID: <xmqqk1eu9bnf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8AB7852-75D6-11E9-AD2E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In f41179f16ba2 (parse-options: avoid magic return codes, 2019-01-27),
> the signature of the low-level parse-opt callback function was changed
> to return an `enum`.
>
> And while the implementations were changed, one declaration was left
> unchanged, still claiming to return `int`.
>
> This can potentially lead to problems, as compilers are free to choose
> any integral type for an `enum` as long as it can represent all declared
> values.

The enum is meant to represent "these magic negative numbers", and
if the compiler chose "long" for it and the implementation of the
function returned a "long", while the caller thought it would yield
an "int", things will break.

Looks good to make callers' expectation and what callee does
consistent.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  parse-options.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index bd00cf0049..cd756833a9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -286,7 +286,9 @@ int parse_opt_commit(const struct option *, const char *, int);
>  int parse_opt_tertiary(const struct option *, const char *, int);
>  int parse_opt_string_list(const struct option *, const char *, int);
>  int parse_opt_noop_cb(const struct option *, const char *, int);
> -int parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx, const struct option *, const char *, int);
> +enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
> +					   const struct option *,
> +					   const char *, int);
>  int parse_opt_passthru(const struct option *, const char *, int);
>  int parse_opt_passthru_argv(const struct option *, const char *, int);
