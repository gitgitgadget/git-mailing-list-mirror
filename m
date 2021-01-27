Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53F3C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9020620715
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbhA0GPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:15:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57128 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbhA0GH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 01:07:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3E5EAFF9B;
        Wed, 27 Jan 2021 01:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hjxz4dYlwPgRc15AsJS9DJHc5OI=; b=lKv2zC
        wUhiDN4AoMg02peM9EcpygcvzAnyOXyhvRAWr3V5bX2/+HIKIy27tk3oobQlnmsA
        0MyunJYp1J444pWfwAb0lCClEHJBYSjvJAuUcr+YHGYKfaR0AQyuF2Csew87V/KR
        tBOP19WS4cXZOBdwDJ1UWDygauwpudvlXbLx4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VSHkdJclW+LzbS83zCbgBUX4/hFYpwi6
        Almr5Ex13MYbIgC7t1FDirQOtscK4/8V2mLaIeBwjnNIVrvt6w9lm27L/6lZsO/y
        TKhU8BZi3M8hPBv/5KHnN3qJWcGmcKwlv5tofRcI489XmDfKavw+bG20Q8Cnz9yf
        Nvn9ibSQloU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 943E4AFF9A;
        Wed, 27 Jan 2021 01:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54277AFF99;
        Wed, 27 Jan 2021 01:07:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] Makefile: micro-optimize light non-test builds
References: <20210126160708.20903-1-avarab@gmail.com>
        <YBCGtd9if0qtuQxx@coredump.intra.peff.net>
        <xmqq5z3jyxa7.fsf@gitster.c.googlers.com>
        <YBDtO82x5sBAs/6L@coredump.intra.peff.net>
Date:   Tue, 26 Jan 2021 22:07:07 -0800
In-Reply-To: <YBDtO82x5sBAs/6L@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Jan 2021 23:34:03 -0500")
Message-ID: <xmqq1re6zzec.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E323C0F8-6065-11EB-919C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 26, 2021 at 05:38:08PM -0800, Junio C Hamano wrote:
>
>> The steps 2/4 and 3/4 did look like a useful feature, but I wonder
>> why we even need to introduce NO_TEST_TOOLS in the first place.
>> Wouldn't it be more natural to arrange them to be built by making
>> "test::" target depend on them?  IOW, why do we need to have "all::"
>> (our default) target depend on them?
>
> Hmm. That is definitely more logical, and giving "make" more information
> to make a good decision about what is needed. I do wonder if it would be
> annoying in two cases, though:
>
>   - people trigger the tests in other ways besides "make test". For
>     instance, "make && cd t && make" works, as does just
>     "make && cd t && ./t1234". With a more clever Makefile, those would
>     fail (or worse, run out-of-date versions of the helpers, producing
>     confusing results).
>
>   - during refactoring, I often compile-test as I go (i.e., run "make"
>     to see which callers still need changed, then fix them, repeat).
>     If that didn't catch test helpers, then I'd think I was done and get
>     bit later by "make test" trying to build more code. Not the end of
>     the world, but a minor annoyance.
>
> So I think even though I'd argue that giving "make" that extra
> dependency information is "more correct", we are fighting uphill against
> existing behavior, as well as things that make doesn't know (like that I
> expect to be ready to run tests as long as "make all" has finished).

Hmph, true, but as "make test" at the top-level merely redirects to
"make -C t", I imagined that the default target in the t/Makefile
would depend on doing "make -C .. test-programs" before running
tests.

The recursive dependencies end somewhere, though ;-)

 
