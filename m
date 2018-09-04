Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149971F404
	for <e@80x24.org>; Tue,  4 Sep 2018 20:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIEA3G (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 20:29:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:38816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726437AbeIEA3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 20:29:06 -0400
Received: (qmail 27337 invoked by uid 109); 4 Sep 2018 20:02:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Sep 2018 20:02:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9582 invoked by uid 111); 4 Sep 2018 20:02:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Sep 2018 16:02:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Sep 2018 16:02:25 -0400
Date:   Tue, 4 Sep 2018 16:02:25 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] t5310: test delta reuse with bitmaps
Message-ID: <20180904200224.GB17481@sigill.intra.peff.net>
References: <20180901074145.GA24023@sigill.intra.peff.net>
 <20180901074813.GB25461@sigill.intra.peff.net>
 <20180901080316.GA25852@sigill.intra.peff.net>
 <CAGZ79ka8e2-f4fYgy+=HUDdvugefvQ5TnDG0v8YmUn7kGhTdaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka8e2-f4fYgy+=HUDdvugefvQ5TnDG0v8YmUn7kGhTdaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 12:05:58PM -0700, Stefan Beller wrote:

> Yeah, maybe we need to ask for more tests in the 'real' test suite, and not
> just in some special corner (such as t/perf/ or any of the environment
> variable proposals nearby).
> 
> I wonder if we can make use of git.git in the test suite for similar things,
> e.g. after reading the thread about "index corruption with git commit -p" [1],
> I thought that we only have these toy examples in the test suite. Toy examples
> show that the new feature barely works, and doesn't show it is working at scale.

I think the toy examples do both. Often they drill down directly to a
useful but rare corner case that _wouldn't_ be hit during normal
operation. And being toys, they are a lot quicker to set up then trying
to work with a 50MB repository.

Take the "commit -p" one for example. It's not really about the
repository shape but about a particular set of actions. If you don't
test those actions, you won't reproduce the bug.

> > There may be a larger lesson about tracking code coverage, but I don't
> > know that most general code coverage tools would have helped (any
> > overall percentage number would be too large to move). A tool that
> > looked at the diff and said "of the N lines you added/touched, this
> > percent is exercised in the test suite" might have been useful.
> 
> From some offline discussion, maybe we want to adapt a philosophy of
> 
>   Each patch needs to add a test, that fails when the patch
>   is not applied, but succeeds when it is applied. This shows
>   that _some_ code in the patch is exercised at least.
> 
> (and automatically/strongly enforce this going forwards; however
> enforcing such a strict thing is hard, not sure how we'd do it.)

I wouldn't want a hard-and-fast rule like that. If you're fixing a bug,
sure, I think it's good to make sure it's exercised. And if you're
adding a feature, you almost always add some basic tests (and almost
certainly leave some corner without code coverage).

But if you're writing an optimization, there's often no before/after
test.  Presumably it worked before, and hopefully it still works after,
and it just got faster. You're generally relying on existing regression
tests (from when that code was introduced) to save you from bugs. You
might need to _write_ those tests if nobody did before. But it's hard to
know without digging if there are decent tests or not. That's why I
think code coverage of the lines in your diff is probably the best
measure.

-Peff
