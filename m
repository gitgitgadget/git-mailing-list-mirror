Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C6BC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 03:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36F260C40
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 03:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhGMD72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 23:59:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:47414 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229571AbhGMD71 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 23:59:27 -0400
Received: (qmail 28702 invoked by uid 109); 13 Jul 2021 03:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Jul 2021 03:56:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5799 invoked by uid 111); 13 Jul 2021 03:56:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 23:56:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 23:56:36 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
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
Message-ID: <YO0O9JHtnYrk9qRm@coredump.intra.peff.net>
References: <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210702142556.99864-3-lenaic@lhuard.fr>
 <87h7h75hzz.fsf@evledraar.gmail.com>
 <xmqq5yxni2rn.fsf@gitster.g>
 <YOzbO1/mfL8hKhBT@coredump.intra.peff.net>
 <CAPig+cT-x4_YuxmmoFw62jFqKRFJrS_UkyNOkdQz9-Gwec3QCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cT-x4_YuxmmoFw62jFqKRFJrS_UkyNOkdQz9-Gwec3QCQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 10:22:22PM -0400, Eric Sunshine wrote:

> On Mon, Jul 12, 2021 at 8:16 PM Jeff King <peff@peff.net> wrote:
> > On Tue, Jul 06, 2021 at 01:52:12PM -0700, Junio C Hamano wrote:
> > > A helper function that takes a string and returns a strvec would be
> > > a good fit, though.
> >
> > I was going to second that, but I see we already have one. :) Dscho
> > introduced it in c5aa6db64f (argv_array: offer to split a string by
> > whitespace, 2018-04-25), and then it later became strvec_split().
> >
> > And indeed, Lénaïc's patches use it elsewhere. I think it doesn't work
> > in this instance because it can't take an arbitrary delimiter. But I
> > wouldn't at all mind seeing it grow that feature (and I suspect it could
> > even share some code with string_list_split(), but didn't look).
> 
> Since Lénaïc is a relative newcomer to the project, can we, as
> reviewers, be clear that we don't expect him to perform the task of
> generalizing strvec_split() just to get this series -- which is
> already at v7 -- landed?

Yeah, sorry if I was unclear on that. That is absolutely not a
requirement for this series.

(I do not have an opinion on Ævar's original question about using a
split function rather than open-coding. _If_ we were to do that,
string_list_split() would be the sensible existing mechanism. But it is
also not worth derailing the series for).

-Peff
