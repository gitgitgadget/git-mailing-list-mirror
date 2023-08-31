Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B5EC83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 16:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbjHaQxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbjHaQxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 12:53:46 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813C8F
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 09:53:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9E621A87CE;
        Thu, 31 Aug 2023 12:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=oCP3dNzejMTSZDymVSND40YiVhNP3V6Y8gDe+t
        vxwJo=; b=Hhyf3+6a0SBPGIqhil32I5WQ9HI0QoDPYtx5aKoKBbOZ4ieSMmkU85
        FwwO6XoZ5ga4s/yQSmdsfe/nBuSqhTObPCfU6RmY43qguDvMk5R8+o1RdHikBThZ
        34hGJp3Z6FekV5vcm1qJx4vXCIUy17JAQU9EKqFsQtm/5qlt3bCuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0CDF1A87CD;
        Thu, 31 Aug 2023 12:53:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 088691A87CC;
        Thu, 31 Aug 2023 12:53:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 5/8] merge: do not pass unused opt->value parameter
In-Reply-To: <20230831071845.GC3197751@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 03:18:45 -0400")
References: <20230831070935.GA3197495@coredump.intra.peff.net>
        <20230831071845.GC3197751@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 09:53:40 -0700
Message-ID: <xmqqedjjxiej.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0C2001E-481E-11EE-8BF7-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The option_parse_strategy() callback does not look at opt->value;
> instead it calls append_strategy(), which manipulates the global
> use_strategies array directly. But the OPT_CALLBACK declaration assigns
> "&use_strategies" to opt->value.
>
> One could argue this is good, as it tells the reader what we generally
> expect the callback to do. But it is also bad, because it can mislead
> you into thinking that swapping out "&use_strategies" there might have
> any effect. Let's switch it to pass NULL (which is what every other
> "does not bother to look at opt->value" callback does). If you want to
> know what the callback does, it's easy to read the function itself.

Good.  It is not like we have two options and each of them affect
its own list of strategies.  There is a single use_strategies list
that is populated not just by the parse options callback but by
other callers.  So I agree that the new way is less confusing.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/merge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 0436986dab..545da0c8a1 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -264,7 +264,7 @@ static struct option builtin_merge_options[] = {
>  	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
>  	OPT_BOOL(0, "verify-signatures", &verify_signatures,
>  		N_("verify that the named commit has a valid GPG signature")),
> -	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
> +	OPT_CALLBACK('s', "strategy", NULL, N_("strategy"),
>  		N_("merge strategy to use"), option_parse_strategy),
>  	OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
>  		N_("option for selected merge strategy")),
