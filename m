Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8801F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBFStF (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:49:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:34864 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726558AbfBFStF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:05 -0500
Received: (qmail 10383 invoked by uid 109); 6 Feb 2019 18:49:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 18:49:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4288 invoked by uid 111); 6 Feb 2019 18:49:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 13:49:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 13:49:03 -0500
Date:   Wed, 6 Feb 2019 13:49:03 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
Message-ID: <20190206184903.GC10231@sigill.intra.peff.net>
References: <20190203230152.GA25608@sigill.intra.peff.net>
 <20190204205037.32143-1-martin.agren@gmail.com>
 <20190204233444.GC2366@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 05, 2019 at 11:34:54AM +0100, Johannes Schindelin wrote:

> Peff, you asked at the Contributors' Summit for a way to get notified when
> CI fails for your patch, and I was hesitant to add it (even if it would be
> straight-forward, really) because of the false positives.
> 
> This is one such example, as the test fails:
> 
> 	https://dev.azure.com/gitgitgadget/git/_build/results?buildId=944
> 
> In particular, the tests t2024 and t5552 are broken for
> ma/doc-diff-usage-fix on Windows. The reason seems to be that those are
> already broken for the base commit that Junio picked:
> jk/diff-rendered-docs (actually, not the tip of it, but the commit fixed
> by Martin's patch).
> 
> Of course, I understand why Junio picks base commits that are far, far in
> the past (and have regressions that current `master` does not have), it
> makes sense from the point of view where the fixes should be as close to
> the commits they fix.  The downside is that we cannot automate regression
> testing more than we do now, with e.g. myself acting as curator of test
> failures.

Thanks for this real-world example; it's definitely something I hadn't
thought too hard about.

I think this is a specific case of more general problems with testing.
We strive to have every commit pass all of the tests, so that people
building on top have a known-good base. But there are many reasons that
may fail in practice (not exhaustive, but just things I've personally
seen):

  - some tests are flaky, and will fail intermittently

  - some tests _used_ to pass, but no longer do if the environment has
    changed (e.g., relying on behavior of system tools that change)

  - historical mistakes, where "all tests pass" was only true on one
    platform but not others (which I think is what's going on here)

And these are a problem not just for automated CI, but for running "make
test" locally. I don't think we'll ever get 100% accuracy, so at some
point we have to accept some annoying false positives. The question is
how often they come up, and whether they drown out real problems.
Testing under Linux, my experience with the first two is that they're
uncommon enough not to be a huge burden.

The third class seems like it is likely to be a lot more common for
Windows builds, since we haven't historically run tests on them. But it
would also in theory be a thing that would get better going forward, as
we fix all of those test failures (and new commits are less likely to be
built on truly ancient history).

So IMHO this isn't really a show-stopper problem, so much as something
that is a sign of the maturing test/CI setup (I say "maturing", not
"mature", as it seems we've probably still got a ways to go). As far as
notifications go, it probably makes sense for them to be something that
requires the user to sign up for anyway, so at that point they're making
their own choice about whether the signal to noise ratio is acceptable.

I also think there are ways to automate away some of these problems
(e.g., flake detection by repeating test failures, re-running failures
on parent commits to check whether a patch actually introduced the
problem). But implementing those is non-trivial work, so I am certainly
not asking you to do it.

-Peff
