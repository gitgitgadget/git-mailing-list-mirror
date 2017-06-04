Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80E71F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 08:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbdFDIVq (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 04:21:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:34506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdFDIVo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 04:21:44 -0400
Received: (qmail 15061 invoked by uid 109); 4 Jun 2017 08:21:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 08:21:43 +0000
Received: (qmail 7728 invoked by uid 111); 4 Jun 2017 08:22:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 04 Jun 2017 04:22:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Jun 2017 04:21:42 -0400
Date:   Sun, 4 Jun 2017 04:21:42 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [WIP/PATCH 7/6] perf: add a performance test for core.fsmonitor
Message-ID: <20170604082141.54wanlacy5ksaalt@sigill.intra.peff.net>
References: <4c3fed40-774b-8ae6-fa1b-50efe6ef552f@gmail.com>
 <20170602102853.23073-1-avarab@gmail.com>
 <xmqq1sr0wm0i.fsf@gitster.mtv.corp.google.com>
 <CACBZZX4XOaN8o89vetoU8NMqRH+BaqHGkxq77MpqzvAM40exEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX4XOaN8o89vetoU8NMqRH+BaqHGkxq77MpqzvAM40exEA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 04, 2017 at 09:46:19AM +0200, Ævar Arnfjörð Bjarmason wrote:

> What I'm referring to is not a limitation of git (we'll always be able
> to turn off core.fsmonitor), but a limitation of the perf framework.
> There's no way to run a test like this:
> 
>     ./run master next -- p*.sh
> 
> And have some information passed to the test to apply different
> runtime options to the test depending on master or next, or be to test
> master twice, once with the fsmonitor, once without, which this
> hypothetical feature would do:
> 
>     ./run master:"GIT_PERF_7519_NO_FSMONITOR=Y" master -- p*.sh

Yeah, the perf framework was originally designed to find regressions
between versions of Git. It's really bad at comparing results between
any other dimensions. You can test different repository sizes by
tweaking the environment, but it can't aggregate or compare results
between those runs. Likewise, you can have two tests in a script which
time Git with and without certain options set, but there's no way to
compare the results of those tests.

It would be nice if the perf framework was aware of all of
these dimensions, stored each result as a tuple of all of the properties
(rather than just the version), and then let you group the results along
any dimension (I suspect there are cases where multi-dimensional
summaries would be useful, but that could come later).

For some dimensions you'd probably want support in the perf scripts
themselves to run a test with two variants. E.g., something like:

  test_perf_group 'fsmonitor' \
	'false' 'git config core.fsmonitor false' \
	 'true' 'git config core.fsmonitor true'
  test_perf 'status' 'git status'
  test_perf_group_end

where that would run the "git status" test for each of the named setups,
and store the timing results under "($VERSION, fsmonitor=false)", and so
on.

That's less flexible than specifying it to "./run" (which would let you
run just one tuple if you chose). But it also relieves the burden from
the user of figuring out which dimensions are interesting to tweak.

-Peff
