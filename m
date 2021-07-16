Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE07C636CA
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB00C613F8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhGPTZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:25:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:52252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhGPTZO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:25:14 -0400
Received: (qmail 21707 invoked by uid 109); 16 Jul 2021 19:22:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jul 2021 19:22:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12122 invoked by uid 111); 16 Jul 2021 19:22:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jul 2021 15:22:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Jul 2021 15:22:18 -0400
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
Message-ID: <YPHcagVJRlN7p/8S@coredump.intra.peff.net>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
 <patch-1.4-0795436a24-20210714T172251Z-avarab@gmail.com>
 <YPCjTpumyh1P/DQj@coredump.intra.peff.net>
 <877dhqxqbt.fsf@evledraar.gmail.com>
 <YPHLUsXsWO+JYS5X@coredump.intra.peff.net>
 <87v95aw0a6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v95aw0a6.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 08:56:04PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I think you can do the same level of skipping with GIT_TEST_SKIP,
> > though. My argument was just that adding a new mechanism does not make
> > sense when we already have one. I.e., running:
> >
> >   GIT_SKIP_TESTS='
> >     t[123456789]*
> >     t0[^0]*
> >     t00[^016]*
> >     t000[469]
> >     t001[2459]
> >     t006[0248]
> >   ' make SANITIZE=leak test
> >
> > works already to do the same thing. The only thing we might want is a
> > nicer syntax (e.g., to allow positive and negative patterns, or to read
> > from a file). But that would benefit all users of GIT_SKIP_TESTS, not
> > just people interested in leaks.
> 
> A glob in this series is t13*config*, you can't do that with
> GIT_SKIP_TESTS because it only includes the numeric part of the test,
> i.e. t1300, not t1300-config, or t1306-xdg-files.

That seems like a feature that GIT_SKIP_TESTS could learn (though IMHO
just using the test number in your patterns is sufficient).

> I would like to be able to compile with it and run "make test" without a
> wall of failures by default, i.e. we should be able to tell regressions
> from known-OK to get anywhere with it, but that's orthagonal to the
> exact mechanism.

Right, I definitely agree on the goal. I just don't see the need to add
a new, very-specific mechanism. The skip-list above is gross and
obviously not something you'd want to type. Driving it from a ci script
is not too bad, but I agree people who want to leak-check locally would
want an easy way to use it, too. That's why I suggested extending it to
a file that could be easily specified (and possibly even auto-triggered
in the Makefile by SANITIZE=leak).

> > With GIT_SKIP_TESTS you obviously don't get a message saying "try
> > skipping this test" when it fails. :) But IMHO that is not that big a
> > deal. You'll get a test failure with good LSan output. If you are
> > working on expanding leak-checker coverage, you already know about your
> > options for skipping. If you're adding a new test that leaks, you might
> > consider fixing the leak (though not always, if it's far from code
> > you're touching).
> 
> I do think it makes sense as a test mode test-lib.sh is aware of,
> e.g. on obvious next step is to not fail everything right away, but just
> let the test run and log all failures to a file, then e.g. fail one test
> at the end, or if we're running in that mode collate all the callstacks
> and emit a summary for the whole test run.

That's a more compelling reason, if we did implement that feature. My
hope was that all of this would be a temporary state, though, and we'd
get to a point where you can simply run "make SANITIZE=leak test" and
actually run all of the tests. And then such a feature would not be that
interesting, because failures would be rare and cause for immediate
human attention.

-Peff
