Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A632C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D846561241
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242380AbhIWRk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:40:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50422 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbhIWRk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:40:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F54ED6AF7;
        Thu, 23 Sep 2021 13:39:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2W9xhoCGWftz
        2m6vZovKwVIQlbQw1BySyCY2X5uMXm4=; b=bE76aCFqJjQ0df/8SjmETjCm6BEU
        NJf5I7Iq9BhaW5cmoQAXJMDglgODZwpOQR2Tc4XNO0ApZpPHFu108zcsS0oOHHmb
        bNk/GWFK0T77HVLXATF2C9lTnPV7mC+4OxLNaVbN0+Ks6WPrcRzJbh7Y12YeN+a1
        3GwLvG3cF4wOxBk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 041D4D6AF6;
        Thu, 23 Sep 2021 13:39:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AADBD6AF5;
        Thu, 23 Sep 2021 13:39:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
        <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
        <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net>
Date:   Thu, 23 Sep 2021 10:39:22 -0700
In-Reply-To: <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 23 Sep 2021 12:24:02 -0400")
Message-ID: <xmqqtuib199x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31126418-1C95-11EC-AF0D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 23, 2021 at 02:07:16AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> We ensure that the recursive dependencies are correct by depending on
>> the *.o file, which in turn will have correct dependencies by either
>> depending on all header files, or under
>> "COMPUTE_HEADER_DEPENDENCIES=3Dyes" the headers it needs.
>>=20
>> This means that a plain "make sparse" is much slower, as we'll now
>> need to make the *.o files just to create the *.sp files, but
>> incrementally creating the *.sp files is *much* faster and less
>> verbose, it thus becomes viable to run "sparse" along with "all" as
>> e.g. "git rebase --exec 'make all sparse'".
>
> OK. I think this solves the dependency issues sufficiently. It is a
> tradeoff that you must do the normal build in order to do the sparse
> check now. That is certainly fine for my workflow (I am building Git al=
l
> the time, and only occasionally run "make sparse"). I don't know if
> others would like it less (e.g., if Ramsay is frequently running sparse
> checks without having just built).
>
> (I'd say "I do not care that much either way", but then I do not care
> all that much either way about incremental sparse checks either, so I'm
> not sure my opinion really matters).

My build procedure runs "make sparse" before the primary build,
simply because the former tends to be much faster to fail when there
is an issue in the code.  I can understand that depending on .o is a
cheap way to piggyback on the dependencies it has, but my latency
will get much slower if this goes in _and_ I keep trying to pick up
potentially problematic patches from the list.



