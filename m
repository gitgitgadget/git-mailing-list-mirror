Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553621F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbfFMQOG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:14:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57612 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbfFMQOG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:14:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FA037FD26;
        Thu, 13 Jun 2019 12:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0wP1E5ga6qix8+cO6hL9vLPeaxk=; b=cLWeAC
        cJqps5iEzZFsfv3voDBL93kA6GoA84gNWnw1XPYe+HPNKUWac9nzmGroOPWePtgd
        WLuYJhGdFBZajXDIfmJSxC/p7MLYoBq0qlmXJZU8+f7+zh3c7aCB6HeLhBGL+Rl6
        AOs5shClmQRhTcM+exKTT53V5nKYol0c2hDEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HllW1OTkW8P1K/GB3WaZA/oZIb3DumXZ
        +ycMH1wahx18UWFc4ouRHUaUeDCPdwx3l8dcXZuEpE5BbIeTLMl1Dkz3FPb+q8Ms
        2ieCENIEec5NcumQOB+KtIeZq4ZMLxBjPyG5nUJvvMt3B13uXgg6HhZPRMR8uNBc
        7olKKPfr7Ao=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 082927FD25;
        Thu, 13 Jun 2019 12:14:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69FBF7FD22;
        Thu, 13 Jun 2019 12:13:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] config: avoid calling `labs()` on too-large data type
References: <pull.265.git.gitgitgadget@gmail.com>
        <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Jun 2019 09:13:57 -0700
In-Reply-To: <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 13 Jun 2019
        04:49:47 -0700 (PDT)")
Message-ID: <xmqqimt9wji2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4076D9C8-8DF6-11E9-99DD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `labs()` function operates, as the initial `l` suggests, on `long`
> parameters. However, in `config.c` we tried to use it on values of type
> `intmax_t`.
>
> This problem was found by GCC v9.x.
>
> To fix it, let's just "unroll" the function (i.e. negate the value if it
> is negative).

Thanks.  Obviously correct.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index 296a6d9cc4..01c6e9df23 100644
> --- a/config.c
> +++ b/config.c
> @@ -869,9 +869,9 @@ static int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
>  			errno = EINVAL;
>  			return 0;
>  		}
> -		uval = labs(val);
> +		uval = val < 0 ? -val : val;
>  		uval *= factor;
> -		if (uval > max || labs(val) > uval) {
> +		if (uval > max || (val < 0 ? -val : val) > uval) {
>  			errno = ERANGE;
>  			return 0;
>  		}
