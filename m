Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC952C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 16:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbiHHQHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiHHQG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 12:06:59 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5283A26E2
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 09:06:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85E4F1B2701;
        Mon,  8 Aug 2022 12:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KYf9KQS4hnGcyaXsmrMUaSzSgc7GzxT4NO7RFm
        d07uM=; b=AdUgV/ewacoLrOhuA7nf0LSlhdszVIUC611wXt57UiZrEgYpVNy6Sb
        wakOqAr4aHvovV1aytytw4ehsOW/XhN3wNljhdbKJAI14G3TWHL/HoB8WYPQe3Uu
        v5o8YdNylAsD9dSUEy8nwJjJwVDwFRdFyPeTiBcydEEPoFhoUrgIU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7DD111B26F9;
        Mon,  8 Aug 2022 12:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 21A0D1B26F7;
        Mon,  8 Aug 2022 12:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous branch"
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com>
        <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr>
Date:   Mon, 08 Aug 2022 09:06:52 -0700
In-Reply-To: <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr> (Johannes
        Schindelin's message of "Mon, 8 Aug 2022 15:26:19 +0200 (CEST)")
Message-ID: <xmqqk07iu3c3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ED79D00-1734-11ED-A094-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> @@ -1420,6 +1420,12 @@ static int interpret_nth_prior_checkout(struct repository *r,
>  	const char *brace;
>  	char *num_end;
>
> +	if (namelen == 1 && *name == '-') {
> +		brace = name;
> +		nth = 1;
> +		goto find_nth_checkout;
> +	}
> +
>  	if (namelen < 4)
>  		return -1;
>  	if (name[0] != '@' || name[1] != '{' || name[2] != '-')

If a solution along this line works, it would be far cleaner design
than the various hacks we have done in the past, noticing "-" and
replacing with "@{-1}".  For one thing, we wouldn't be receiving a
"-" from the end user on the command line and in response say @{-1}
does not make sense in the context in an error message.  That alone
makes the above approach to deal with it at the lowest level quite
attractive.

In the list archive, however, you may be able to find a few past
discussions on why this is not a good idea (some of which I may no
longer agree with).  One thing that still worries me a bit is that
we often disambiguate the command line arguments by seeing "is this
(still) a rev, or is this a file, or can it be interpreted as both?"
and "-" is not judged to be a "rev", IIRC.

Luckily, not many commands we have take "-" as if it were a file and
make it read from the standard input stream, but if there were (or
if we were to add a command to behave like so), treating "-" to mean
the same thing as "@{-1}" everywhere may require the "does this look
like a rev?"  heuristics (which is used by the "earlier ones must be
rev and not file, later ones must be file and cannot be interpreted
as rev, for you to omit '--' from the command line" logic) to be
taught that a lone "-" can be a rev.

So it is quite a lot of thing that the new code needs to get right
before getting there.
