Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7259CC4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3E46108D
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 19:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhHSTnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:43:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57239 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhHSTnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 15:43:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64131D1542;
        Thu, 19 Aug 2021 15:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w8ETh0KbuhnzOEq2XjzPQgCsIwOpAG2aJagfsE
        g2cUA=; b=IaMnjSvOo+kphkUAtSiQXkVK388ui4f9ffTxdysVBlK9lxD0O2238B
        ooMoM/mwrB9ico4ggRMpB4IaLjJWmCTx3mcsLN8vXpInQfEB2NQHx07B2PlA10ut
        ZTNKdj/r8MyhtN8VUfTFvnagaRg87BGSy6XPUeR9JSZ8koECvkmyo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C73CD1541;
        Thu, 19 Aug 2021 15:42:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E226DD1540;
        Thu, 19 Aug 2021 15:42:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] make: add install-strip target
References: <20210817110728.55842-1-bagasdotme@gmail.com>
        <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet>
        <xmqq8s0z7m9m.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2108181229320.55@tvgsbejvaqbjf.bet>
Date:   Thu, 19 Aug 2021 12:42:55 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108181229320.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 18 Aug 2021 12:30:33 +0200 (CEST)")
Message-ID: <xmqq1r6p1ark.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A66FFDDC-0125-11EC-88DC-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That would work, too. At the same time: wouldn't it be nicer to let `make
> -j15 strip install` Do The Right Thing?

Oh, absolutely.  With "make all install" and "make strip install",
building (and optional stripping) should complete before the
"install" target kicks in.

It may be a bit tricky to implement, though.  Making 'install'
depend unconditionally on 'all' is trivial, but we want it to depend
on 'strip' only when 'strip' is part of the targets requested.
