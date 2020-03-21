Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C89DC4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C225C20637
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AmJMPuwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCUS5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:57:39 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50688 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgCUS5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:57:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BC89A9D52;
        Sat, 21 Mar 2020 14:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/YWbvIbx5bRhIBzlVMxM6euBdLQ=; b=AmJMPu
        wUrrT1UyGAbYaSiA87m8KihWXxlphsoja6iQGKXycPVf72+TwMevza6T9qt/ewtG
        wvydT4NvxLBbQA+MijFlPUJ51RlaZG8PknnCnyITumnLZSgCc7c997ON8i/nMOVq
        g5Z9xe1cuCejM94l+qVW1SdlXq6ISkvEbMfI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OveDTRtcmBQWnLBbnX6vh8K27qIpb6aq
        ianjjuZ4AE6HyQ/1fG2a3x6GHfPS0luNXo/kTv/WT1DuqEyRpILj7s1zvmzZEYVj
        7tRcX3A9Kpmd4ai7aw6ZUHEnyJHEg4Td+JMaqmPID8Z8FcP7itnJXCSD/u2+K2Iw
        KXIdTjWZFzY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83CF9A9D51;
        Sat, 21 Mar 2020 14:57:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5FBDA9D4E;
        Sat, 21 Mar 2020 14:57:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib: allow short options to be stacked
References: <48c28683412e3e0803d4c7189a6d66daddcdc580.1584759277.git.matheus.bernardino@usp.br>
        <20200321062611.GA1441446@coredump.intra.peff.net>
Date:   Sat, 21 Mar 2020 11:57:32 -0700
In-Reply-To: <20200321062611.GA1441446@coredump.intra.peff.net> (Jeff King's
        message of "Sat, 21 Mar 2020 02:26:11 -0400")
Message-ID: <xmqqblopa63n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2BD00EA-6BA5-11EA-8083-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered if we could do this without the extra process. This works:
>
>   opt=${opt#-}
>   while test -n "$opt"
>   do
> 	extra=${opt#?}
> 	this=${opt%$extra}
> 	opt=$extra
> 	parse_option "-$this"
>   done
>
> It's a little convoluted. I'm not sure if saving a process per unbundled
> short option is worth it.

I was wondering if I should suggest something similar to the above
when I wrote my response.  Yours actually does not look as bad as
what mine would have been ;-)

> What happens to bundled short options with arguments? I think "-r" is
> the only one. We don't allow "stuck" short options like "-r5", so we
> don't have to worry about feeding non-option bits to parse_option(). It
> looks like we'd only examine $store_arg_to outside of the short-option
> loop, so we'd treat:
>
>   ./t1234-foo.sh -vrix 5
>
> the same as:
>
>   ./t1234-foo.sh -v -r 5 -i -x
>
> which seems reasonable. But:
>
>   ./t1234-foo.sh -rr 5 6
>
> would get garbled.

And also we declare we will never add any option that takes an
argument with this patch?  ... Ah, no, it is just store_arg_to is
taking a short-cut assuming the current lack of bundled options.

OK, so yeah, I am not sure if this half-way "solution" is worth it.
It is just the test scripts, sure, that we have this strange
limitation that "-rr 5 6" is not parsed correctly (i.e. "do not use
the bundled form if -r is involved" is something developers can live
with), but then it is just the test scripts so "do not use the
bundled form at al" is not too bad, either.  It is just one less
thing for developers to remember, compared to having to remember
"you can, but except for this special case".

So, I dunno.

Thanks.
