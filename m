Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CFD31F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfFSOYO (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:24:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50498 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfFSOYN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:24:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DE69015E23D;
        Wed, 19 Jun 2019 10:24:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ivPSjgOnBHCl4bqA0ZAp6rDji3Y=; b=w9P6x4
        +eCENlAYy3XYnEfvgdP7B+VZ/ntE3ZWz6XcilgDwHcgss2Sa2xgLoyTqmjoI4M80
        yhYD65S+rVqtnc6KEff9N6ncALvNoyi9NMCZCygfyeBw15VrqMAsy/t3boE1U5+h
        ktN+kXWaLEd3a7FiOX4fDGFRt1txLo4oBm0f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NBHTE/pYLpcTkOwTcLsks55W16o0hW97
        7VdzS0mrS34zg405f6U5a10rQtELSsrrz2ba2vRbsDFQFrUjx+FIlaSIJFPihNLX
        xcXuUwxjJLyQKnoIU3ARpPz8JhM/4bLPwM5+7Eg9y1mntsf8jWJKkKgWbuQk4FQw
        gCZ8RayBFeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D52E815E23C;
        Wed, 19 Jun 2019 10:24:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4369A15E23B;
        Wed, 19 Jun 2019 10:24:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        git <git@vger.kernel.org>, masahiroy@kernel.org
Subject: Re: [PATCH] interpret-trailers: load default config
References: <CAK7LNAR=KhTZRFFXTbcZwe-+65fGnVB7NbmVbQ7ymbmChDuhAg@mail.gmail.com>
        <20190614150758.GA22984@sigill.intra.peff.net>
        <CAP8UFD2dhGqOxXJMTZhNSM5G4sp6PvKF+0R5KVk6YjAQi3Sccw@mail.gmail.com>
        <20190619033728.GA29027@sigill.intra.peff.net>
Date:   Wed, 19 Jun 2019 07:24:10 -0700
In-Reply-To: <20190619033728.GA29027@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 18 Jun 2019 23:37:28 -0400")
Message-ID: <xmqqwohhr6ut.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E818030E-929D-11E9-BA65-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] interpret-trailers: load default config
>
> The interpret-trailers program does not do the usual loading of config
> via git_default_config(), and thus does not respect many of the usual
> options. In particular, we will not load core.commentChar, even though
> the underlying trailer code tries to do so.

"tries to use it"?  Eh, it does use it, so, "the underlying trailer code
uses its value", would be the correct version of the last sentence.

The underlying trailer.c has two calls to git_config() to lazy-load
its own set of config variables (which is justified, as its caller
is not necessarily the "interpret-trailers" subcommand), but their
callbacks are not good places to call git_default_config() from for
obvious reasons.  It has to be done in "interpret-trailers" (and
other callers of the machinery should already have learned what
core.commentChar is with their own configuration calls) like the
patch I am reviewing does.

Looks perfect.  Thanks.

> This can be seen in the accompanying test, where setting
> core.commentChar to anything besides "#" results in a failure to treat
> the comments correctly.
>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

>  builtin/interpret-trailers.c  |  3 ++
>  t/t7513-interpret-trailers.sh | 70 +++++++++++++++++++++--------------
>  2 files changed, 46 insertions(+), 27 deletions(-)

