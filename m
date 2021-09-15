Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CFDC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 19:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2D161178
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 19:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhIOTXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:23:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52185 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhIOTXf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 15:23:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E80C513DF56;
        Wed, 15 Sep 2021 15:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SB1FR65Rv3NF1iXPNCaVprTMBXqfH83GitrGX2
        h20+I=; b=kmMW7rUZo1RhhnQD+SA1ioS7P5YmW4CkHSJiH4Ej67kBUC3GFLHV9V
        wRQMVP4l8n9mj2nsAWFmEUdyNW+CEC7nigH8lNo8etRSb4MvzHBAZ7I+4rqC0Jv1
        7Vk6XTWcsl2e7y6t9TJeHm35PYAQoKlx3jBPGh8YR1OKfeDGUm7UI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E075113DF55;
        Wed, 15 Sep 2021 15:22:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B9D7213DF51;
        Wed, 15 Sep 2021 15:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v2 0/8] repack: introduce `--write-midx`
References: <cover.1631331139.git.me@ttaylorr.com>
        <cover.1631730270.git.me@ttaylorr.com>
Date:   Wed, 15 Sep 2021 12:22:08 -0700
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 15 Sep 2021 14:24:33 -0400")
Message-ID: <xmqqmtodwsnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 396A4964-165A-11EC-BA8A-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Nothing substantial has changed since last time. Mostly re-wrapping lines and
> removing braces in macro'd for_each_xyz() loops....
> Otherwise, this series is unchagned. It depends on tb/multi-pack-bitmaps, which
> has graduated to master. Range-diff below:

Despite the explanation above ...

>      @@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
>     - 
>     - 	if (ends_with(file_name, ".idx")) {
>       		display_progress(ctx->progress, ++ctx->pack_paths_checked);
>     --		if (ctx->m && midx_contains_pack(ctx->m, file_name))
>     --			return;
>     -+		if (ctx->m) {
>     -+			if (midx_contains_pack(ctx->m, file_name))
>     -+				return;
>     -+		} else if (ctx->to_include) {
>     -+			if (!string_list_has_string(ctx->to_include, file_name))
>     -+				return;
>     -+		}
>     + 		if (ctx->m && midx_contains_pack(ctx->m, file_name))
>     + 			return;
>     ++		else if (ctx->to_include &&
>     ++			 !string_list_has_string(ctx->to_include, file_name))
>     ++			return;

... this part seems to change what the code does quite a bit.

The original used to skip .to_include checks when .m is set but it
did not pass midx_contains_pack().  Now .to_include check is done
in a context with .m that does not pass midex_contains_pack() check.

I suspect that this change since v1 is a bugfix.  We make an early
return based on midx_contains_pack() but make sure .m is not NULL,
in order to be able to run the check.  There is another early return
condition that is orthogonal, and we do string_list check, but that
is only doable if the .to_include is not NULL.  The logic in v2 
clearly expresses that, but v1 was simply buggy.

But if it is the case, I'd step back a bit and further question if
"else if" is a good construct to use here.  We'd return if .m passes
midx_contains_pack() check, and another check based on .to_include
gives us an orthogonal chance to return early, so two "if" statement
that are independent sitting next to each other may have avoided
such a bug from the beginning, perhaps?

	if (ctx->m && midx_contains...)
		return;
	if (ctx->to_include && !string_list_has...)
		return;

Of course you could

	if ((ctx->m && midx_contains...) ||
	    (ctx->to_include && !string_list_has...))
		return;

but that may not scale as well as two independent if statements.

Everything else in the range-diff looked cosmetic as explained in
the cover letter.
