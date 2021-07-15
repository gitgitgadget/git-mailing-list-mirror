Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F3C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5DA61374
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhGOVRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:17:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:51320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGOVRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 17:17:46 -0400
Received: (qmail 12701 invoked by uid 109); 15 Jul 2021 21:14:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jul 2021 21:14:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4932 invoked by uid 111); 15 Jul 2021 21:14:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jul 2021 17:14:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Jul 2021 17:14:51 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt <andrzej@ahunt.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] tests: add a test mode for SANITIZE=leak, run it
 in CI
Message-ID: <YPClS0fj2HOJE5nH@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
 <eebb4f74-b5e3-6c11-3b84-fcee1b876992@ahunt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eebb4f74-b5e3-6c11-3b84-fcee1b876992@ahunt.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 08:42:27PM +0200, Andrzej Hunt wrote:

> My other question is: if we are adding a new job - should it really be just
> a leak checking job? Leak checking is just a subset of ASAN (Address
> Sanitizer). And as discussed at [1] it's possible to run ASAN and UBSAN
> (Undefined Behaviour Sanitizer) in the same build. I feel like it's much
> more useful to first add a combined ASAN+UBSAN job, followed by enabling
> leak-checking as part of ASAN in those jobs for known leak-free tests - as
> opposed to only adding leak checking. We currently disable Leak checking for
> ASAN here [2], but that could be made conditional on the test ID (i.e. check
> an allowlist to enable leak checking for some tests)?

I do think it's worth having an ASan+UBSan job. In the CI we use for our
custom fork of Git at GitHub, we run it for every pull request (and I do
bring upstream any applicable fixes). It's kind of expensive compared to
a regular "make test", but probably not nearly as bad as just running
the regular test suite on Windows.

And it's true that ASan can do leak-checking, too. In the long run, when
we are leak-free, I think it may make sense to combine the jobs. But in
the interim state where we can run the whole suite with ASan/UBSan, but
not with LSan, I think it's simpler to just keep them separate. That
lets us just entirely skip tests or scripts in the leak-checking run. I
haven't measured, but I also expect that LSan is not much more expensive
than a regular run, so combining the two isn't that big a win).

So I do like your suggestion, but I think it just be orthogonal further
to leak-checking.

-Peff
