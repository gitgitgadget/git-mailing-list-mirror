Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA601F453
	for <e@80x24.org>; Tue, 29 Jan 2019 16:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfA2Qq5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 11:46:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:53398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726420AbfA2Qq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 11:46:57 -0500
Received: (qmail 3230 invoked by uid 109); 29 Jan 2019 16:46:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 16:46:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8456 invoked by uid 111); 29 Jan 2019 16:47:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 11:47:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 11:46:54 -0500
Date:   Tue, 29 Jan 2019 11:46:54 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Message-ID: <20190129164654.GA6991@sigill.intra.peff.net>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129160030.GA7083@sigill.intra.peff.net>
 <bb17112d-2869-741f-de13-3971a995032e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb17112d-2869-741f-de13-3971a995032e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 11:35:41AM -0500, Derrick Stolee wrote:

> > For people who don't have "prove" available, I think they could just do
> > "make -k test" to make sure the full suite runs. Should we perhaps be
> > doing that automatically in the sub-make run by coverage-test?
> 
> I wanted to avoid changing the existing behavior, if I could. But, if
> we can reasonably assume that anyone running 'make coverage-test' wants
> to run the full suite even with failures, then that's fine by me.

Another option would be to relay "-k" from the caller. I think it's not
enough to just use $(MAKE), but if you use $(MAKE) $(MAKEFLAGS), then
running "make -k coverage-test" from your coverage script would (I
think) do what you want.

> I see from the make docs that '-k' will still result in an error code
> at the end of the command, so no automation would result in an incorrect
> response to a failed test. Am I correct?

Yeah, that matches my understanding. I don't think you'd have to deal
with that failure code manually for coverage-report because it does not
depend on coverage-test (but obviously if you did "make coverage-test &&
make coverage-report", the "&&" needs to become a semicolon).

> >> +coverage-prove: coverage-clean-results coverage-compile
> >> +	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
> >> +		DEFAULT_TEST_TARGET=prove -j1 prove
> >> +
> > 
> > You probably don't need to override DEFAULT_TEST_TARGET here, since the
> > "prove" target doesn't look at it. Likewise, "-j1" probably does nothing
> > here, since prove itself is a single target.
> 
> As Szeder mentioned, I can probably just drop the 'prove' target and use
> DEFAULT_TEST_TARGET instead. Or do we think anyone will want to use
> 'make prove' from root?

Yeah, that works. I typically do run prove, and I do run the tests from
the root, but DEFAULT_TEST_TARGET already makes it all work for me. So
yeah, I think it's fine to leave off the prove target until somebody
actually wants it.

> > I'm not sure why we want to enforce -j1 for these targets, but if it's
> > important to do so for the prove case, as well, you'd need to add it to
> > GIT_PROVE_OPTS.
> 
> The '-j1' is necessary because the coverage data is collected in a way that
> is not thread-safe. Our compile options also force single-threaded behavior.

Ah, right, I vaguely recall that now.

> I'll specifically override GIT_PROVE_OPTS here to force -j1, but also send
> -j1 to the 'make' command, too.

Makes sense.

-Peff
