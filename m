Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012321F453
	for <e@80x24.org>; Wed,  6 Feb 2019 23:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfBFXIQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 18:08:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:35350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726062AbfBFXIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 18:08:16 -0500
Received: (qmail 4981 invoked by uid 109); 6 Feb 2019 23:08:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Feb 2019 23:08:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6797 invoked by uid 111); 6 Feb 2019 23:08:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Feb 2019 18:08:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2019 18:08:14 -0500
Date:   Wed, 6 Feb 2019 18:08:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        steadmon@google.com
Subject: Re: [PATCH 0/8] Resend of GIT_TEST_PROTOCOL_VERSION patches
Message-ID: <20190206230813.GC19901@sigill.intra.peff.net>
References: <cover.1549411880.git.jonathantanmy@google.com>
 <20190206213458.GC12737@sigill.intra.peff.net>
 <87ef8klh4g.fsf@evledraar.gmail.com>
 <20190206221008.GB15378@sigill.intra.peff.net>
 <87bm3olftb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm3olftb.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 11:20:32PM +0100, Ævar Arnfjörð Bjarmason wrote:

> >> So far we've had the convention that these GIT_TEST_* variables,
> >> e.g. the one for the commit graph, work the same way. Thus we guarantee
> >> that we get (in theory) 100% coverage even when running the tests in
> >> this special mode. I think it's better to keep it as-is.
> >
> > But what's the point of that? Don't you always have to run the test
> > suite _twice_, once with the special variable and once without?
> > Otherwise, you are not testing one case or the other.
> >
> > Or are you arguing that one might set many special variables in one go
> > (to prefer running the suite only twice, instead of 2^N times). In which
> > case we are better off running the test (as opposed to skipping it), as
> > it might use one of the _other_ special variables besides
> > GIT_TEST_PROTOCOL_VERSION.
> >
> > I can buy that line of reasoning. It still doesn't cover all cases that
> > a true 2^N test would, but that clearly isn't going to be practical.
> 
> Maybe I'm misunderstanding what you're proposing, but as an example,
> let's say the test suite is just these two tests:
> 
>     test_expect_success 'some unrelated thing' '...'
>     test_expect_success 'test protocol v2' 'GIT_TEST_PROTOCOL_VERSION=2 ...'
> 
> And GIT_TEST_PROTOCOL_VERSION=0 is the default, let's say I want to test
> with GIT_TEST_PROTOCOL_VERSION=1 for whatever reason,
> 
> I'd still like both tests to be run, not just 1/2 with
> GIT_TEST_PROTOCOL_VERSION=1 and 2/2 skipped because it's explicitly
> testing for the GIT_TEST_PROTOCOL_VERSION=2 case, whereas I asked for a
> GIT_TEST_PROTOCOL_VERSION=1.

But that's my "why". The second test will run identically in both runs,
regardless of your setting of GIT_TEST_PROTOCOL_VERSION. So there's
value if you're only running the suite once in getting full coverage,
but if you are literally going to run it with and without, then you're
running the exact same code twice for no reason. And you have to run it
both with and without, since otherwise all of the _other_ tests aren't
seeing both options.

> IOW the point of these tests is to piggy-back on the tests that *aren't*
> aware of the feature you're trying to test. So
> e.g. GIT_TEST_COMMIT_GRAPH=true should run our whole test suite with the
> commit graph, and *also* those tests that are explicitly aware of the
> commit graph, including those that for some reason would want to test
> for the case where it isn't enabled (to e.g. test that --contains works
> without the graph).
> 
> Otherwise I can't say "I care more about GIT_TEST_COMMIT_GRAPH=true than
> not", and run just one test run with that, because I'll have blind spots
> in the commit graph tests themselves, and would then need to do another
> run with GIT_TEST_COMMIT_GRAPH= set to make sure I have 100% coverage.

So if we are still talking about the same 2-test setup above, which only
has a GIT_TEST_PROTOCOL_VERSION override, then yeah, I get the point of
being able to run a "stock" test, and then one with _both_ of the flags
(GIT_TEST_PROTOCOL_VERSION and GIT_TEST_COMMIT_GRAPH) because you don't
quite know how each test will interact with all of the "other" flags.

So now I'm not 100% sure I understand what you're talking about, but I
think maybe we are actually in agreement. ;)

-Peff
