Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33D9C4332F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F25610A0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhJ0UY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:24:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60991 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbhJ0UY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:24:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D678A15A441;
        Wed, 27 Oct 2021 16:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=ZUTvz+W7wn5cXUJZow4n6t/aox0rmzg9NSdHbA
        z6IyY=; b=ij3AVxl6RUCKfCHRHUwdnQJ4UtxQkcUjVlgv0xfhDKUtIg1RojMDCp
        w1/NEKPFSRmokyLasQUfKXiYnh9RYn7UOGojNBn8yGQGaKTw35DcGZRK1rwUzv2W
        UraUcOJwhRZJpvklU7MtOS59SKcvnKsfhm/U+tTYKpu9rIJXvvGL0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CE6D715A440;
        Wed, 27 Oct 2021 16:21:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C11015A43F;
        Wed, 27 Oct 2021 16:21:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] leak tests: add an interface to the LSAN_OPTIONS
 "suppressions"
In-Reply-To: <YXkWhFGS/uTAnsI1@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 27 Oct 2021 05:06:12 -0400")
References: <211022.86sfwtl6uj.gmgdl@evledraar.gmail.com>
        <patch-1.1-9190f3c128f-20211022T102725Z-avarab@gmail.com>
        <YXhjstW2XAnixEqh@nand.local>
        <YXhvAQgxKpq65qcg@coredump.intra.peff.net>
        <211027.86v91iyis4.gmgdl@evledraar.gmail.com>
        <YXkWhFGS/uTAnsI1@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 27 Oct 2021 13:21:56 -0700
Message-ID: <xmqqy26euskb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 887A01B4-3763-11EC-AB64-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think that's true at all. The annotations you showed in that
> message, for example, are pointing at add_rev_cmdline(). But that is
> _not_ the source of the leak, nor where it should be fixed. It is a
> necessary part of how rev_info works. The leak is when the rev_info goes
> out of scope without anybody cleaning it up.

True.

>> Hrm, now that I think about it I think that the cases where I had to
>> resort to valgrind to get around such crappy stacktraces (when that was
>> all I got, even without suppressions) were probably all because there
>> was an UNLEAK() in play...
>
> I don't see how UNLEAK() would impact stack traces. It should either
> make something not-leaked-at-all (in which case LSan will no longer
> mention it), or it does nothing (it throws some wasted memory into a
> structure which is itself not leaked).

I'd prefer to see judicious use of UNLEAK() over LSAN suppressions
that lists things that are not the source of the problem.  The list
being kept in the tests that are far away from the actual source
does not help, either.

Thanks.
