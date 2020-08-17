Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E103C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6847C20772
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IvJ8ouhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgHQWx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:53:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62804 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgHQWx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:53:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 69B5FDCE25;
        Mon, 17 Aug 2020 18:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SrmZ5qoNJ580
        frJSI1ll0Gb1VdQ=; b=IvJ8ouhI8HQY3jSdlRf/MMpyPlT0GVFvXoKiEsKh7/kY
        trXRUWyv1j9eWvurzIqhgnGBilovtdTMMXNmrKikC2aTTa4ompFyKz6Pe/l0qEi/
        5hAiO4eYbq1PshLBA/zTeWSidbP2/ynRT93pELZCytsy3ljqb4tcFTiPrBxz9wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qGu2g1
        S3cf5lwuDWzwiMbeCLVrsZcJ84Z1FtemsZokRg5/WrjGSQtjsEbSpvxHy3lePbYa
        N5AOYCso/S955ECuGkUquZbTI5C/YKKvTt7S8JrPFzoktOHKSMsWFvCCWBUCjVIy
        DuYi7c8rMmPso43mx8lNgc6gY4bZluqUvBHBc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FF3DDCE23;
        Mon, 17 Aug 2020 18:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BCAFDCE22;
        Mon, 17 Aug 2020 18:53:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fast-export: factor out print_oid()
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
        <20200813151856.GE2244@syl.lan>
        <3ddf0a14-77ac-7546-e03a-704432305bdb@web.de>
        <20200813172545.GB1597339@coredump.intra.peff.net>
        <d25987e5-df7e-d153-bbe4-a4e391ed4454@web.de>
        <20200817220843.GA1858228@coredump.intra.peff.net>
Date:   Mon, 17 Aug 2020 15:53:21 -0700
In-Reply-To: <20200817220843.GA1858228@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 17 Aug 2020 18:08:43 -0400")
Message-ID: <xmqqd03ozxy6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 743D9F78-E0DC-11EA-BAEF-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Aug 15, 2020 at 09:14:49AM +0200, Ren=C3=A9 Scharfe wrote:
>
>> > I think this is a bad direction unless you're going to do it for all=
 of
>> > the other anonymize_*() functions, as well, for consistency. And the=
re
>> > it gets tricky because the caller is able to use the anonymizing
>> > knowledge in more places.
>> >
>> > I actually liked your original version better.
>>=20
>> OK, how about embracing the static and do something like this?
>>=20
>> -- >8 --
>> Subject: [PATCH] fast-export: add format_oid() and format_path()
>
> TBH, I don't find it an improvement because of the extra buffer
> handling. But I admit that I don't really care between any of the
> solutions posted here. They all appear to be correct, and just trading
> off various properties so that none is definitively better than the
> other. (And none of them is so bad that I feel compelled to avoid it).
>
> So I'd be OK with any of them (or leaving it as-is).
>
> -Peff

I've marked it as "retracted" per
https://lore.kernel.org/git/6e2d4472-8293-4f10-0ba6-82ae83f7a465@web.de/

Thanks.
