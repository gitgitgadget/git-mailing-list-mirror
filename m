Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFF8C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D266127A
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 18:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhIVSaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 14:30:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61336 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhIVSaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 14:30:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76291159CD7;
        Wed, 22 Sep 2021 14:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H8RH9w/lLii7p1whsfzR474F1jRsPPA1ddmLL9
        R6UoY=; b=LPQqck57Rrccz4NfKmC1M7RbysgeYkZlNIoFYHi3hcVHycIjAK84Ej
        GhtjVWKTdolGjOmJC/clXvT/5Lbo+K73zhcsOr1kt7l26HehlISFP0I5eATpmRiM
        V5qVRtItRU2oz/fXGf7aGyZ8zf6pZmdyjDhi2lSAQT4/ZUV6C5Csk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A6BA159CD6;
        Wed, 22 Sep 2021 14:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8658159CD3;
        Wed, 22 Sep 2021 14:28:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: make COMPUTE_HEADER_DEPENDENCIES=auto work
 with DEVOPTS=pedantic
References: <patch-1.1-6b2e9af5e67-20210922T103749Z-avarab@gmail.com>
        <xmqqmto48ufz.fsf@gitster.g>
        <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 11:28:38 -0700
In-Reply-To: <YUtiNuUiBU4Xg4gw@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 22 Sep 2021 13:04:54 -0400")
Message-ID: <xmqqzgs479d5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8660A48-1BD2-11EC-B378-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I wonder if the attached (with clean-up to remove the tracing cruft)
>> would show us a better direction.  It feeds a single line
>> 
>> 	int dummy_for_dep_check;
>> 
>> C "program" from the standard input of the compiler to tackle the
>> "you are not supposed to be compiling an empty compilation unit"
>> problem in a more direct way.
>
> That feels a bit like we're playing a game of chicken with the compiler
> in terms of what it may complain about. For example, sparse will
> complain:
>
>   foo.c:1:5: warning: symbol 'dummy_for_dep_check' was not declared. Should it be static?
>
> Might compilers ever learn to warn of the same thing?

Certainly.  That is the reason why I said "direction", not
"solution", and I do not think it is beyond our capability to come
up with a minimal "C program" that would be lint clean to make it
as a part of the "solution".

For example, would sparse or compilers complain about this?

    extern int incr(int); int incr(int i) { return i + 1; }

> So I'd argue we should go even simpler, like:
>
> diff --git a/Makefile b/Makefile
> index 3628d14f16..4597a126d0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1277,7 +1277,7 @@ COMPUTE_HEADER_DEPENDENCIES = auto
>  endif
>  
>  ifeq ($(COMPUTE_HEADER_DEPENDENCIES),auto)
> -dep_check = $(shell $(CC) $(ALL_CFLAGS) \
> +dep_check = $(shell $(CC) \
>  	-c -MF /dev/null -MQ /dev/null -MMD -MP \
>  	-x c /dev/null -o /dev/null 2>&1; \
>  	echo $$?)

I am all for this simplification.  It takes us back to the state
before 1816bf26 (Makefile: Improve compiler header dependency check,
2011-08-30).  But I think that is more or less orthogonal to the
"you are not supposed to feed an empty compilation unit" issue.

> I'm also tempted by a hunk like this. Then we can set the REQUIRE flag
> in a CI job (or locally for git devs who know they have gcc) and notice
> an unexpected breakage in the auto test.
>
> @@ -1295,6 +1295,9 @@ ifneq ($(COMPUTE_HEADER_DEPENDENCIES),no)
>  $(error please set COMPUTE_HEADER_DEPENDENCIES to yes, no, or auto \
>  (not "$(COMPUTE_HEADER_DEPENDENCIES)"))
>  endif
> +ifdef REQUIRE_COMPUTE_HEADER_DEPENDENCIES
> +$(error computed header dependencies required, but auto-check did not find them)
> +endif
>  endif

Yup, I like that, too.
