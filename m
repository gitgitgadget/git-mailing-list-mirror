Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02C9F1F45F
	for <e@80x24.org>; Tue,  7 May 2019 22:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEGW0E (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 18:26:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:50994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726236AbfEGW0D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 18:26:03 -0400
Received: (qmail 15706 invoked by uid 109); 7 May 2019 22:26:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 22:26:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17676 invoked by uid 111); 7 May 2019 22:26:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 18:26:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 18:26:01 -0400
Date:   Tue, 7 May 2019 18:26:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH] commit-graph: fix memory leak
Message-ID: <20190507222601.GA976@sigill.intra.peff.net>
References: <f4ab2a50873b2fd91926d7401f784479504d1b10.1557178485.git.steadmon@google.com>
 <87zhnyh9vu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhnyh9vu.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 11:49:41AM +0200, Ævar Arnfjörð Bjarmason wrote:

> I wonder in general if there's a more sustainable solution to these
> one-at-a-time memory leak fixes we're doing to these
> libraries. E.g. marking some tests in the test suite as passing cleanly
> with valgrind's leak checker, and adding a test mode to run those tests.

I'd recommend going with the LeakSanitizer, since the resulting tests
run a lot faster.  We made some progress a while ago, and some tests do
pass, but there's a lot of manual inspection (and either fixing leaks,
or annotating with UNLEAK as appropriate) still to do.

Running "make SANITIZE=leak test" shows our current state.

If we just want to stop the bleeding, so to speak, I suspect that rather
than marking individual tests as "clean", we'd do better to collect all
of the results, sort and remove duplicates, and then just compare the
result before and after certain branches. That would tell us the new
leaks being added.

Something like:

  export LSAN_OPTIONS=exitcode=0:log_path=/tmp/lsan
  make SANITIZE=leak test

should dump a bunch of files in /tmp. (Note that when we tried this in
late 2017, log_path did not seem to work in pure-LSan mode, but I think
this was a bug; it works fine for me now).

Collating the results is a little tricky, because the top of the stack
when the leak was allocated is usually uninteresting (it's almost always
xmalloc).

There's some discussion and some scripts in:

  https://public-inbox.org/git/20170923163817.7ltmkav2ytk7n43k@sigill.intra.peff.net/

and

  https://public-inbox.org/git/20170925160835.aoomjaqrn2o2aosi@sigill.intra.peff.net/

I think just pumping the results of the second one through "sort -u"
would get you a starting point that you could use for before/after
diffs.

-Peff
