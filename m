Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1DD1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfHGSPk (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 14:15:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61987 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388612AbfHGSPk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 14:15:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 11EFB162848;
        Wed,  7 Aug 2019 14:15:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KgneNUGFBqaRLY2nN9Go1eSqqfc=; b=UKp5lN
        hhDgxkPpinvtwuSJBP5MJUjiGqIfpsqMOxqshTWRr1kY2Pjla5s2qGO5BsbkYomb
        LFwtpzIVIusladUuykZZpmvx3g6Xe6wZ6DSpDQ0cR0AcwxCXEJnDjWUNTI75sUN6
        Frg8lpR0B7UwnZL/oBR+ch2/sVgckuXBJhmgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=upBiybXl1iG2QQs77IQAtLC2SNLrMt5V
        DvqMm96wUALWToXtrlVjzFw+z6y3S8lqbcD+gYqrN3W1pGqTj1/MByfMmieVzE8z
        36EdOVms2siAdwFO4mEFZ3HIoMhz5Fo7HwyOaFvavooYfU2ICb5I88jD7zrPdbTx
        BVzZ6jMONQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08883162845;
        Wed,  7 Aug 2019 14:15:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B20F162844;
        Wed,  7 Aug 2019 14:15:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        johannes.schindelin@gmx.de, avarab@gmail.com,
        michal.kiedrowicz@gmail.com
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
References: <20190806085014.47776-1-carenas@gmail.com>
        <20190806163658.66932-1-carenas@gmail.com>
        <20190806163658.66932-3-carenas@gmail.com>
        <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
        <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
Date:   Wed, 07 Aug 2019 11:15:36 -0700
In-Reply-To: <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 7 Aug 2019 02:49:56 -0700")
Message-ID: <xmqq1rxwj0zb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B224004-B93F-11E9-9767-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

>> > +#ifdef USE_NED_ALLOCATOR
>> > +static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_data)
>> > +{
>> > +     return malloc(size);
>>
>> Should this be xmalloc() to get consistent out-of-memory handling?
>
> good point, note though that since it is inside a USE_NED_ALLOCATOR
> ifdef it is really
> nedalloc in disguise

It would be nedalloc() wrapped inside the "die if we cannot
allocate, possibly after releasing resources held in various caches"
xmalloc() wrapper.  So (1) either xmalloc or malloc would end up
eventually calling nedalloc that can be freed with nedfree, so from
that point of view either can be used without upsetting "free()",
and (2) we should use xmalloc() here because we care about
consistent OOM behaviour throughout the system.

Thanks.
