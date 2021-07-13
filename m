Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D001FC07E9A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A563D611CB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 00:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhGMASq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 20:18:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47292 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230099AbhGMASp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 20:18:45 -0400
Received: (qmail 25476 invoked by uid 109); 13 Jul 2021 00:15:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 00:15:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3821 invoked by uid 111); 13 Jul 2021 00:15:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 20:15:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 20:15:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
Message-ID: <YOzbO1/mfL8hKhBT@coredump.intra.peff.net>
References: <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-3-lenaic@lhuard.fr>
 <87h7h75hzz.fsf@evledraar.gmail.com>
 <xmqq5yxni2rn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5yxni2rn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 06, 2021 at 01:52:12PM -0700, Junio C Hamano wrote:

> > This sort of code is much more pleseant to read and work with if you use
> > strbuf_split_buf(). This isn't performance sensitive, so a few more
> > allocations is fine.
> 
> Please do not encourage use of strbuf_split_buf().  It is a
> misdesigned API as it rarely is justifyable to have an array, each
> element of which can be independently tweaked by being strbuf.  We
> are not implementing a text editor after all ;-)

Very much agreed on avoiding strbuf_split_buf(). My usual go-to is
string_list_split(), which I think would work here for splitting on ":".

> A helper function that takes a string and returns a strvec would be
> a good fit, though.

I was going to second that, but I see we already have one. :) Dscho
introduced it in c5aa6db64f (argv_array: offer to split a string by
whitespace, 2018-04-25), and then it later became strvec_split().

And indeed, Lénaïc's patches use it elsewhere. I think it doesn't work
in this instance because it can't take an arbitrary delimiter. But I
wouldn't at all mind seeing it grow that feature (and I suspect it could
even share some code with string_list_split(), but didn't look).

-Peff
