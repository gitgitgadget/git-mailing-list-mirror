Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE9DC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B9B604D2
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhJRRDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:03:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59406 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhJRRDF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 13:03:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0F61E14C322;
        Mon, 18 Oct 2021 13:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XPEn49fPsqy+OI4gtMQ94JlrOiooFFNSHh7kih
        d0Jj8=; b=EHEMdLFJXTuq9XmoR3bTfQ5PYF0KiR5xLIoBEeFWpwm6lO00YKfHN8
        h5jptpiOinAxlK8EpIAr0Tf/xHAqcNgdJubAD+NVbT5JoAMAvEFlxVqw1JLRUr28
        qs3BMQL7UGUer/aho6UFeGEcCSIW79b5KKf5v6IvlufmFG8Srege8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0704014C321;
        Mon, 18 Oct 2021 13:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85E4E14C31E;
        Mon, 18 Oct 2021 13:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, vagabon.xyz@gmail.com,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3] archive: describe compression level option
References: <20211018123822.541406-1-bagasdotme@gmail.com>
Date:   Mon, 18 Oct 2021 10:00:49 -0700
In-Reply-To: <20211018123822.541406-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Mon, 18 Oct 2021 19:38:22 +0700")
Message-ID: <xmqq8ryqxo72.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F27224C4-3034-11EC-8757-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Describe the only extra option in `git archive`, that is the compression
> level option. Previously this option is only described for zip backend;
> add description also for tar backend.

Almost there.  

I think saying just a short "-<number>" would be more appropriate.
Both descriptions are clear that they are talking about a number
given by the user, and their purpose is to describe what the number
means.  I do not see much point in using such a long label, which
makes the leading '-' less stand out.

For an added bonus, use -<digit> for zip, and use -<number> for tar.

>  zip
>  ~~~
> +-<compression level number>::
> +	Specify compression level. Higher values enables better ratio at
> +	the expense of longer time. Supported values are from `-0`
> +	(store-only) to `-9` (best ratio). Default is `-6` if isn't
> +	specified.

I wondered how Info-zip describes what -9 is and how they say phrase
it is quite interesting.

    Regulate the speed of compression using the specified digit #,
    where -0 indicates no compression (store all files), -1
    indicates the fastest compression speed (less compression) and
    -9 indicates the slowest compression speed (optimal compression,
    ignores the suffix list). The default compression level is -6.

Notice that they do not make much promise on the resulting size;
they only talk about speed.  At the slowest speed, the tool is
allowed to spend more time to explore smaller size, but it may not
always be successful, I guess, to achieve the "best compression", so
it is a very defensive documentation, but I doubt if it is helful to
its readers.  Compared to that I think the proposed "best ratio"
much more clearly conveys the intention (i.e. "we aim for smaller
size")---it would probably be even better to say "smaller size", as
there may be many "ratios" in the world and it is not immediately
obvious that we are talking about resulting size being small if we
do not say so (also "smaller" or "smallest" is more explicit than
"best"---the readers don't have to think which between smaller and
larger is better).

> +tar
> +~~~
> +-<compression level number>::
> +	Specify compression level. The value will be passed to the
> +	compression command configured in `tar.<format>.command`. See
> +	manual page of the configured command for the list of supported
> +	levels and the default level if this option isn't specified.

OK.

Thanks.
