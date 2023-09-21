Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF7AE7D0A7
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 19:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIUTr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjIUTrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 15:47:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF2D8D52
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 12:09:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF2381EDAC;
        Thu, 21 Sep 2023 15:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=MfFdBIU1MWVkVMJiIE9+6+ZA1CZPqbfXUc+28t
        T1s0Y=; b=o7a42S4YFcxF97zv+SOkocSllmXsTVq8TiwXms1893c3ESZ+BBvtyC
        NQkPguT5OHZ7+cN0g8Lzed0T32LyKIsd2oibG7KwWTjgqN9/T+d3+Gvuz5RhH4HN
        w0gEb1P388OHseRGFFj+1FfYxJmPbPMXsNu1vrFeiX7swAwuJcWvY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7E131EDAB;
        Thu, 21 Sep 2023 15:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5019B1EDAA;
        Thu, 21 Sep 2023 15:09:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] am: fix error message in parse_opt_show_current_patch()
In-Reply-To: <20230921110727.789156-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Thu, 21 Sep 2023 13:07:27 +0200")
References: <fff19abd-263d-48c7-81fd-35a2766b6b16@web.de>
        <20230921110727.789156-1-oswald.buddenhagen@gmx.de>
Date:   Thu, 21 Sep 2023 12:09:10 -0700
Message-ID: <xmqqh6nn5oo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5976DF28-58B2-11EE-9A12-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> The argument order was incorrect. This was introduced by 246cac8505
> (i18n: turn even more messages into "cannot be used together" ones,
> 2022-01-05).
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
>
> ---
> fwiw, this is currently the only message that actually uses the %s=%s
> format, so as of now, factoring out the argument names has only
> theoretical value.

I am not sure I follow, if you mean that the programmer needs to
pass "--show-current-patch" only once if we used something like
"%1$s=%2s and %1$s=%3s", I agree that it probably has little value.

The patch looks good.  It seems that we are seeing a crack in test
coverage, by the way?

Will queue.  Thanks.

> diff --git a/builtin/am.c b/builtin/am.c
> index 202040b62e..6655059a57 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2303,7 +2303,8 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
>  	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
>  		return error(_("options '%s=%s' and '%s=%s' "
>  					   "cannot be used together"),
> -					 "--show-current-patch", "--show-current-patch", arg, valid_modes[resume->sub_mode]);
> +			     "--show-current-patch", arg,
> +			     "--show-current-patch", valid_modes[resume->sub_mode]);
>  
>  	resume->mode = RESUME_SHOW_PATCH;
>  	resume->sub_mode = new_value;
