Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7326C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D7960E78
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 16:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbhH0QQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:16:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57087 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbhH0QQE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 12:16:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 370D3152651;
        Fri, 27 Aug 2021 12:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TU+IJPQfjDywtyLJ79S7Jtrrg3AaW7zzE/+lps
        nssig=; b=doSlgqeyhnu2z4DawD3whBwawn2xcerhKUBZCe9vBFCx/Pgt5HI5Nh
        g+s+sthFmgI90D2O0qusT2o2Qs3BGJ4LRcl0XZcCyKyZOsE5orfXk2KaMNYenKFf
        HGCHHwuXdBC8CJoobolOnHx9kuLiZDNoFUiO2UMZvAaLsKXTZOWwc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30230152650;
        Fri, 27 Aug 2021 12:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B76915264D;
        Fri, 27 Aug 2021 12:15:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, me@ttaylorr.com,
        git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 2/2] upload-pack: use stdio in send_ref callbacks
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
        <20210826100648.10333-1-jacob@gitlab.com>
        <20210826100648.10333-2-jacob@gitlab.com> <xmqqpmu0f9ob.fsf@gitster.g>
        <YSgiwXFnLrLy6pH3@coredump.intra.peff.net>
Date:   Fri, 27 Aug 2021 09:15:10 -0700
In-Reply-To: <YSgiwXFnLrLy6pH3@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 26 Aug 2021 19:24:49 -0400")
Message-ID: <xmqqbl5ic19t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4ECE722-0751-11EC-8635-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Aug 26, 2021 at 09:33:08AM -0700, Junio C Hamano wrote:
>
>> > +	/*
>> > +	 * Increase the stdio buffer size for stdout, for the benefit of ref
>> > +	 * advertisement writes. We are only allowed to call setvbuf(3) "after
>> > +	 * opening a stream and before any other operations have been performed
>> > +	 * on it", so let's call it before we have written anything to stdout.
>> > +	 */
>> > +	if (setvbuf(stdout, xmalloc(LARGE_PACKET_MAX), _IOFBF,
>> > +			LARGE_PACKET_MAX))
>> > +		die_errno("failed to grow stdout buffer");
>> 
>> Nice to see a comment on the tricky part.  I do not think we mind if
>> we rounded up the allocation size to the next power of two here, but
>> there probably won't be any measurable benefit for doing so.
>
> I'm a little negative on this part, actually. The commit message claims
> it's for consistency across platforms. But I would argue that if your
> libc buffer size is sub-optimal, then we shouldn't be sprinkling these
> adjustments through the code. Either:
>
>  - we should consider it a quality-of-implementation issue, and people
>    using that libc should push back on their platform to change the
>    default size; or
>
>  - we should fix it consistently and transparently throughout Git by
>    adjusting std{in,out,err} in common-main, and using fopen()/fdopen()
>    wrappers to adjust to something more sensible

I agree that it would be ideal if we didn't do setvbuf() at all, the
second best would be to do so at a central place.  My "Nice" applied
only to the comment ;-)

> I also find the use of LARGE_PACKET_MAX weird here. Is that really the
> optimal stdio buffer size? The whole point of this is coalescing _small_
> packets into a single write() syscall. So how many small packets fit
> into LARGE_PACKET_MAX is comparing apples and oranges.

The sizing is all my fault.  The original used 32k threashold and
implemented manual buffering by flushing whenever the accumulated
data exceeded the threashold, as opposed to "if we buffer this new
piece, it would exceed, so let's flush first what we got so far,
which is smaller than the threashold", which I found indefensible in
two ways.  The "flush _after_ we go over it" semantics looked iffy,
and 32k was totally out of thin air.  As LARGE_PACKET_MAX is the
hard upper limit of each packet that has been with us forever, it
was more defensible than 32k ;-)

But if we are using stdio, I agree that it is much better not to
worry about sizing at all by not doing setvbuf() and leaving it to
libc implementation.  They ought to know what works on their
platform the best.

Thanks.
