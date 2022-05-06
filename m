Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D7C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443895AbiEFQve (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbiEFQvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 12:51:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196D94551C
        for <git@vger.kernel.org>; Fri,  6 May 2022 09:47:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C64941182D3;
        Fri,  6 May 2022 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rMQT4uRjgXD+dOfaTwT+AH7i4TFTbG6gfwmmff
        Kdy1o=; b=vB7K8BdjrLlk/UlmMtDNWUUGC5NpOgp4Dnoy2dw88TTbzbE3d97xRr
        93CaXPTtVBjfWu8x3l5rgpfTg1upmiJA5JlBXg2UGJyVrj9QYkhHF1oAcGHUGshH
        0beRIYB+71p/oBVrujzK8XYAMQ/8vdZxNqD69Ma51uKvHRQ9XGu8Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD3511182D2;
        Fri,  6 May 2022 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E6791182C4;
        Fri,  6 May 2022 12:47:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
References: <cover.1651796862.git.chris@chrisdown.name>
        <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
Date:   Fri, 06 May 2022 09:47:43 -0700
In-Reply-To: <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
        (Chris Down's message of "Fri, 6 May 2022 01:52:54 +0100")
Message-ID: <xmqqh762obf4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40F3F25C-CD5C-11EC-A0E9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Down <chris@chrisdown.name> writes:

> This allows seeing the current intermediate status without adding a new
> good or bad commit:
>
>     $ git bisect log | tail -1
>     # status: waiting for bad commit, 1 good commit known

Clever.  As we are keeping the "log" of what we have done so far,
it is a good place to record this new piece of info, too.  I find
it much better than my earlier suggestion to add "bisect status"
subcommand.

> +__attribute__((format (printf, 1, 2)))
> +static void bisect_log_printf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	char buf[1024];
> +
> +	va_start(ap, fmt);
> +	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
> +		*buf = '\0';
> +	va_end(ap);

We probably should use strbuf_addf() or something so that we do not
even have to wonder if 1024 is large enough for everybody.  That
would be in line with what is done in other parts of the codebase,
e.g. bisect_next_all() uses xstrfmt() that is a thin wrapper around
strbuf to format the estimated steps.

Thanks.
