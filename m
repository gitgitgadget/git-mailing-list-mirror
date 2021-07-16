Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8028AC636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6252A610C7
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhGPSMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:12:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52124 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230415AbhGPSMU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:12:20 -0400
Received: (qmail 21433 invoked by uid 109); 16 Jul 2021 18:09:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 18:09:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11488 invoked by uid 111); 16 Jul 2021 18:09:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 14:09:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 14:09:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] tests: add a test mode for SANITIZE=leak, run it
 in CI
Message-ID: <YPHLUsXsWO+JYS5X@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
 <YPCjTpumyh1P/DQj@coredump.intra.peff.net>
 <877dhqxqbt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dhqxqbt.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 04:46:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > and so on. That requires two new features in test-lib.sh:
> >
> >   - making a GIT_TEST_RUN variable that is the opposite of GIT_TEST_SKIP
> >     (instead of just the command-line --run).
> >
> >   - adding GIT_TEST_{RUN,SKIP}_FROM variables to read the values from a
> >     file rather than the environment (I suppose the caller could just
> >     stuff the contents into the variable, but I expect that test-lib.sh
> >     may want to pare down the entries that do not even apply to the
> >     current script for the sake of efficiency in checking each test).
> >
> > That infrastructure would then be applicable to other cases, too. Or
> > even just useful for using another list (or no list at all) when you
> > are looking at whether other tests are leak-free or not.
> 
> I've included a mechanism for whitelisting specific globs, the idea was
> not to have that be too detailed, but we'd e.g. get to the point of t00*
> or whatever passing.
> 
> Anything that's a lot more granular than that is doing to suck,
> e.g. exposing teh GIT_TEST_SKIP and --run features. of specific test
> numbers, now you need to count your tests if you add one in the middle
> of one of those, and more likely you won't test under the mode and just
> see it in CI.

I think you can do the same level of skipping with GIT_TEST_SKIP,
though. My argument was just that adding a new mechanism does not make
sense when we already have one. I.e., running:

  GIT_SKIP_TESTS='
    t[123456789]*
    t0[^0]*
    t00[^016]*
    t000[469]
    t001[2459]
    t006[0248]
  ' make SANITIZE=leak test

works already to do the same thing. The only thing we might want is a
nicer syntax (e.g., to allow positive and negative patterns, or to read
from a file). But that would benefit all users of GIT_SKIP_TESTS, not
just people interested in leaks.

> It also means everything works by default, you get an appropriate notice
> from prove(1), and even if you run one test manually it'll skip, but
> emit a message saying you can set the env var to force its run.

With GIT_SKIP_TESTS you obviously don't get a message saying "try
skipping this test" when it fails. :) But IMHO that is not that big a
deal. You'll get a test failure with good LSan output. If you are
working on expanding leak-checker coverage, you already know about your
options for skipping. If you're adding a new test that leaks, you might
consider fixing the leak (though not always, if it's far from code
you're touching).

-Peff
