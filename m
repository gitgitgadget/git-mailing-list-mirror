Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7972E1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 00:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfF2AqB (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 20:46:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:54768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726643AbfF2AqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 20:46:01 -0400
Received: (qmail 16151 invoked by uid 109); 29 Jun 2019 00:46:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Jun 2019 00:46:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22200 invoked by uid 111); 29 Jun 2019 00:46:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 20:46:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 20:45:59 -0400
Date:   Fri, 28 Jun 2019 20:45:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/6] easy bulk commit creation in tests
Message-ID: <20190629004559.GC3094@sigill.intra.peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064103.GA19777@sigill.intra.peff.net>
 <20190628093751.GA3569@sigill.intra.peff.net>
 <87v9wp7dfp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9wp7dfp.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 08:49:30PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > So here's a patch to do that. Writing the bulk commit function was a fun
> > exercise, and I found a couple other places to apply it, too, shaving
> > off ~7.5 seconds from my test runs. Not ground-breaking, but I think
> > it's nice to have a solution where we don't have to be afraid to
> > generate a bunch of commits.
> 
> Nice.
> 
> Just a side-note: I've wondered how much we could speed up the tests in
> other places if rather than doing setup all over the place we simply
> created a few "template" repository shapes, and the common case for
> tests would be to simply cp(1) those over.

That thought also occurred to me while writing this. I've worked with
test suites that have those kind of "fixtures" before, and I generally
like it less, for two reasons:

  - it's much harder to understand what's important about the fixture,
    because you're seeing the end result of running a bunch of commands.
    Whereas the individual commands that show you _how_ it was derived
    are generally instructive; they give you the steps that the author
    was thinking about.

  - it's more annoying to update them because you don't just change the
    instructions. You have to extract the fixture into a real repo,
    manipulate it, then convert it back into whatever storage format we
    use (which can't just be a real repo, because we don't allow
    embedding repos).

But what I think _would_ be cool is to treat the command instructions as
the source of truth, but allow caching of the on-disk state at certain
points in a test script. I.e., imagine that we annotate some test
snippets to say "I am setup, and it's OK if you don't run me every
time". Like:

  test_expect_success SETUP 'a really slow setup step' '
	for i in $(test_seq 1000)
	do
		test_commit horribly-slow-$i
	done
  '

and then the test harness would recognize the SETUP prereq as magical,
and:

  - look for t/cache/t1234.42.tar; if it exists, then replace the whole
    trash-dir state with it and skip the test

  - otherwise run the snippet and create t1234.42.tar for next time

Bonus points if you could specifically ask to cache t1234.57, even if it
_isn't_ marked as SETUP, and then restart the script from that point,
skipping over the intermediate tests (whether they were cached or not).
That would let you then run subsequent tests from a known point
instantly (e.g., if you're debugging some later test in the script and
want to run it over and over).

The downsides I see are:

  1. It doesn't exercise the setup snippets as much. The idea is that
     this shouldn't matter if it's just setup code, but I'm sure we do
     get some extra coverage from it. But any fixture-based scheme
     suffers from this.

  2. Cache invalidation (isn't it always?). If you changed the setup
     test or even fixed a bug elsewhere in Git, you'd want to re-run the
     setup steps. It's always OK to blow away the cache and get a fresh
     run, but sometimes it's easy to forget to do so (and the results
     can be confusing).

-Peff
