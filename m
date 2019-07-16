Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76481F461
	for <e@80x24.org>; Tue, 16 Jul 2019 20:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfGPUBD (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 16:01:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:37948 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728366AbfGPUBD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 16:01:03 -0400
Received: (qmail 10954 invoked by uid 109); 16 Jul 2019 20:01:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 16 Jul 2019 20:01:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2927 invoked by uid 111); 16 Jul 2019 20:02:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Jul 2019 16:02:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jul 2019 16:01:01 -0400
Date:   Tue, 16 Jul 2019 16:01:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
Message-ID: <20190716200101.GA6558@sigill.intra.peff.net>
References: <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
 <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
 <20190714005129.GA4525@sigill.intra.peff.net>
 <54c2ee44-ee99-ea4a-3154-f642e0060877@kdbg.org>
 <20190715144602.GA26636@sigill.intra.peff.net>
 <4be7a0a1-0256-40c3-4abc-d3d9302f527b@kdbg.org>
 <20190715181527.GA30747@sigill.intra.peff.net>
 <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo91t3itl.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 12:01:10PM -0700, Junio C Hamano wrote:

> And that "quiet and nice" form is a moral equivalent of
> 
> 	struct foo foo = { 0 };
> 
> that has been discussed in this thread.  I'd rather not to see it
> turned into distinct FOO_INIT, BAR_INIT, etc. to force the reader to
> think these structures all need their specific initialization and
> wonder what's the reason for each of them.

I'm on the fence for that style myself. But we've definitely been
trending in that direction. Look at `git grep _INIT *.h`, many of which
are clearly zero-initializers.

I do think it's nice to be able to modify the initializers later and
feel confident that you're catching all of the users. But even then:

  - it's not like we get any kind of static warning for a
    zero-initialized variant (be it static or with a manual {0}
    initializer)

  - I know I've run into problems where code assumed memset() worked,
    but it didn't (I think diff_options was one such case).

So at best it's "feel more confident", not "feel confident". :)

> One universal "struct foo foo = STRUCT_ZERO_INIT;" that is applied
> to all kinds of structure I could live with (but only if we have a
> good way to squelch sparse from bitching about it).  Perhaps we
> could define it as "{}" for GCC, while keeping it "{ 0 }" for
> others.  As I said, { 0 } is undefensible if we insist that a null
> pointer must be spelled NULL and not 0 (as CodingGuidelines says),
> but as long as we declare that we take "{ 0 }" as a mere convention
> (like we used to use the "int foo = foo;" convention to squelch
> "uninitialized but used" warnings) that is outside the purview of
> language-lawyers, I am perfectly fine with it, and if it is hidden
> behind a macro, that would be even better ;-)

Yeah, I am OK with that. My big question is if we use "{}" for gcc (and
compatible friends), does that squelch all of the complaints from other
compilers and tools that might see the "{0}" version? In particular,
does it work for sparse?

-Peff
