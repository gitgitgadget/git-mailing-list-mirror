Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F5C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D81E060E09
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 18:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhJ2SOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:14:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60551 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhJ2SOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 14:14:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3FE2616A2B2;
        Fri, 29 Oct 2021 14:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nPrYfrVlGDZxR6mJGvsWReW94Xzix7rWlOfF+7
        0WS0Q=; b=YYLu8rrRe+/GWUT2sgxdV6+CcRpzUYUmqTynQPYsjcGP7HYjjV8pM+
        CuIC6zVldwyP6iTABqSVSwMfklcvpdCA/TzxX9nOjHsoBLcfhRdAA36ozh5flF3L
        mIIK/P/zj9y/SpJpaAyWaFJCEqSPruZ3typWkjGo8bITWVzISQd9g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37E7516A2B1;
        Fri, 29 Oct 2021 14:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF2AF16A2B0;
        Fri, 29 Oct 2021 14:12:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
References: <20211028002102.19384-1-e@80x24.org>
        <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
        <20211028182824.GA1307@dcvr> <xmqqilxhq774.fsf@gitster.g>
        <20211029001552.GA29647@dcvr> <xmqqr1c4mmsf.fsf@gitster.g>
        <20211029075640.M183252@dcvr>
Date:   Fri, 29 Oct 2021 11:12:06 -0700
In-Reply-To: <20211029075640.M183252@dcvr> (Eric Wong's message of "Fri, 29
        Oct 2021 07:56:40 +0000")
Message-ID: <xmqqpmrnlmyx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA7FB682-38E3-11EC-B206-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Wong <e@80x24.org> writes:
>> > +# n.b. consider using Git.pm
>> > +sub use_fsync {
>> > +    if (!defined($_use_fsync)) {
>> > +        my $x = $ENV{GIT_TEST_FSYNC};
>> > +        if (defined $x) {
>> 
>> I would have expected to see "exists $ENV{GIT_TEST_FSYNC}", but I
>> guess there is no way to place in %ENV anyway, so it would be OK.
>
> Was that meant to say: "no way to place `undef' in %ENV anyway"?

Yes.  Nothing the external callers of a Perl script does by futzing
the environment with setenv(3) and unsetenv(3) can make undef appear
as a value in $ENV{SomeKey}, so defined $ENV{V} and exists $ENV{V}
are equivalent.

I still prefer "exists $ENV{V}", which I think conveys the intent of
the check better, i.e. "we do this iff the environment variable X is
there".

> If so, `undef' can actually be in Perl's %ENV, though it appears
> to get coerced into "" (empty string) when spawning processes.

Yes, but you are talking about the opposite direction, what Perl can
do to %ENV to affect processes it spawns, which is not what I meant.

> Leaving GIT_CONFIG set was actually causing "git config" to
> exit(1) since git-cvsserver sets GIT_CONFIG and the GIT_CONFIG
> file doesn't have a test.fsync setting.  This is the current
> behavior, I think it's a weird quirk, but intended behavior of
> git-config.

Ah, sorry, I misread the variable.  GIT_CONFIG was the thing that
says "read from this file and nowhere else"; we do want to disable
it locally for "-c var=val" to take effect.

> # this assumes you don't have foo.bar set in your ~/.gitconfig :>
> $ GIT_CONFIG=$HOME/.gitconfig git -c foo.bar=0 config --type=bool foo.bar
> $ echo $?
> 1
>
>> > +            my $v = ::safe_pipe_capture('git', '-c', "test.fsync=$x",
>> > +                                        qw(config --type=bool test.fsync));
>> 
>> THis is an interesting idiom.
>
> Heh, I just thought of it before sending my original.  I was
> going to use a regexp originally (in git-svn, too), but didn't
> want to get into corner cases such as hex and +/- prefixes).

And this I think is the best way to do so ;-)
