Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E6C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72E9860F9B
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 16:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbhI0QcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 12:32:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63888 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhI0QcX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 12:32:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAD64167845;
        Mon, 27 Sep 2021 12:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D0US3Uv5JmM1/zNDw/hTcap8JNzVVoF7Y//C/z
        iPFpE=; b=NM3QwIjpi5IYKHrMMvn0F4mZYInzX0u+1cxmRQjKUK3Zylz0G/syPO
        1PAho23Kz3ArtFIqmr4n2qY8SlTHnnL/691xBTB041fNlMV7BDvTOp/Z7Y9TBgAK
        SlEH1vlKxazXBPO54vHID2J+Qr17Gk7qEYsH4WW5CFTniCSqSVgBE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D22EA167844;
        Mon, 27 Sep 2021 12:30:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A4F9167842;
        Mon, 27 Sep 2021 12:30:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, The Grey Wolf <greywolf@starwolf.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] config: add an includeIf.env{Exists,Bool,Is,Match}
References: <YUzvhLUmvsdF5w+r@coredump.intra.peff.net>
        <patch-1.1-1fe6f60d2bf-20210924T005553Z-avarab@gmail.com>
        <YU49+Y+nRhl1mgof@coredump.intra.peff.net>
        <xmqqa6k1slxe.fsf@gitster.g>
        <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net>
Date:   Mon, 27 Sep 2021 09:30:41 -0700
In-Reply-To: <YU5KOpGkS5sH4iFJ@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 24 Sep 2021 17:59:22 -0400")
Message-ID: <xmqqo88eq8um.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41EF5F84-1FB0-11EC-93EF-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > Should we allow whitespace around key names and values? E.g.:
>> >
>> >   [includeIf "env: FOO: bar"]
>> >
>> > is IMHO more readable (even more so if we had infix operators like
>> > "==").
>> 
>> This asserts what? FOO=" bar"?
>
> Whoops, that should have been "envIs", asserting that $FOO contains
> "bar".

Oh, "can we check with a literal with leading whitespace?" was what
my question was about ;-)

> As I said, I think it matters more with the infix operators, as:
>
>   [includeIf "env:FOO == bar"]
>
> is more readable than:
>
>   [includeIf "env:FOO==bar"]

Sure, but at that point, we'd probably want some quoting mechanism
for the literal to be compared, e.g.

	[includeIf "env:PATH ~= \"(:|^)/usr/bin(:|$)\""]

> But I do think:
>
>   [includeIf "envIs:FOO:bar"]
>
> is harder to read than even:
>
>   [includeIf "envIs:FOO: bar"]

Hmph, that's quite subjective, I am afraid.  When I see the latter
in the configuration file, "do I have to have a single space before
'bar' in the value of $FOO" would be the first question that would
come to my mind.

With an understanding that our syntax is so limited that we cannot
even write '=' and need to resort to Is: instead, I'd actually find
that the former less confusing than the latter.

Thanks.
