Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE98C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A859423B01
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 21:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbhAVVkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 16:40:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59303 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbhAVVjR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 16:39:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF05A1101C9;
        Fri, 22 Jan 2021 16:38:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RLOHk1+X9vKYigBpWroUWvmAsPQ=; b=JOoChS
        pJi4CpZiYKPiUGkT8c8j4ZRwaNrJj7D+kZ41nX1YI4w90zf8ws4Qs3eSiBiKUuAS
        OX3HEo5H0AylPZSU2gwW5/EjIElvMtb5fQ99JWxvGPnF5t4lfZjdFg3JoRUEUORA
        wIcfLripBjAl1c6v6JDGpodtGTV12lx4h7j34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dUFA0y04TC+B0kxSYHLpTFF6Iuq/kT59
        Gflb3avmLMCW0ZbYd/A/ZLFg5bvi+0W5QF0cUUiOSLUdqCmyQsagIVrrX9iodloH
        Z1Bf6rEqgtfMa2hljHBQ9ec/FwdTfHuJd4C7f4kXlpRH/WZXsP8syRSctI3zzm+x
        HvBDmMLw46s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B7F741101C8;
        Fri, 22 Jan 2021 16:38:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0E49E1101C5;
        Fri, 22 Jan 2021 16:38:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jacob Vosmaer <jacob@gitlab.com>
Subject: Re: [PATCH] refs: switch peel_ref() to peel_iterated_oid()
References: <YAiIK+/hSRxaUx/K@coredump.intra.peff.net>
        <YAiOPzOT52v+dOgL@nand.local>
Date:   Fri, 22 Jan 2021 13:38:23 -0800
In-Reply-To: <YAiOPzOT52v+dOgL@nand.local> (Taylor Blau's message of "Wed, 20
        Jan 2021 15:10:39 -0500")
Message-ID: <xmqqk0s47iuo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28300D92-5CFA-11EB-8D21-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jan 20, 2021 at 02:44:43PM -0500, Jeff King wrote:
>> This has been bugging me for years, and came up again in:
>>
>>   https://lore.kernel.org/git/YAhXw9Gvn5Pyvacq@coredump.intra.peff.net/
>>
>> so I decided to finally do something about it. There's a minor textual
>> conflict with the caller being touched in that thread, but it's easy to
>> resolve. So I think it's OK to consider the two independent.
>>
>> The commit message turned out rather long. I hope that doesn't scare
>> anybody away, but I wanted to cover all of the bases.
>
> Thanks for all of the detail. Suffice it to say, I was not scared away,
> and am in fact quite comfortable with this direction.
>
> Sorry for sending such a short response to such a long email, but I
> agree with the discussion in the patch message, and I don't have
> anything to add other than my approval and a:
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,
> Taylor

Thanks, both.
