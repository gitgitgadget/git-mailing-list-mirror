Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120CF202DD
	for <e@80x24.org>; Fri, 14 Jul 2017 08:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751056AbdGNIFz (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 04:05:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:40442 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750799AbdGNIFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 04:05:52 -0400
Received: (qmail 4965 invoked by uid 109); 14 Jul 2017 08:05:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 08:05:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8807 invoked by uid 111); 14 Jul 2017 08:06:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 04:06:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 04:05:44 -0400
Date:   Fri, 14 Jul 2017 04:05:44 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 0/4] Teach 'run' perf script to read config files
Message-ID: <20170714080544.3nzndfx3p2yaxmac@sigill.intra.peff.net>
References: <20170713065050.19215-1-chriscool@tuxfamily.org>
 <20170713165840.e5cdw7pa2m6haaen@sigill.intra.peff.net>
 <CAP8UFD3VnpMuMpcfRcTwL4nRpOF5URj6zsQqiEWYwo=1pi5Phw@mail.gmail.com>
 <20170713205535.otzi3gjd63ubb2dm@sigill.intra.peff.net>
 <CAP8UFD1FXPtzHF1J5ZfcsmMiHrfXQOd=qEghJQp3eFYsVd-nxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1FXPtzHF1J5ZfcsmMiHrfXQOd=qEghJQp3eFYsVd-nxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 14, 2017 at 08:27:53AM +0200, Christian Couder wrote:

> The whole thing seems really complex to me though. And this makes me
> think that people might want to specify different GIT-BUILD-OPTIONS
> and config.mak files to be used when running perf tests, so that the
> results from perf tests can easily be reproduced later even if they
> have changed their build options in their development Git repo in the
> meantime.

I agree with the complexity. The general idea is that your currently
built HEAD is a snapshot in time of options. But that doesn't have to be
so, and laying out the options in a config file does seem like an
improvement.

There is another implicit dependency, though: the set of (and exact
content of) the tests depends on your HEAD, too. So if I do:

  git checkout v2.5.0
  cd t/perf
  ./run v2.0.0 v2.1.0

I might get different results if I replace "v2.5.0" in the first command
with some other version, because the content of the tests will be
different. I'm not sure how to account for that in storing results. Most
of the time the version of the tests you ran is not going to be
interesting. But it can be a source of confusing discrepancies if a test
subtly changed between two runs. It probably happens infrequently enough
that it's not worth worrying about.

> So perhaps the config file should make it possible to specify a
> directory where all the build files (GIT-BUILD-OPTIONS, config.mak,
> config.mak.autogen and config.status) that should be used should be
> taken. And then it could also let people change some variables to
> override what is in those files which is needed to run perf tests with
> different parameters.

That sounds reasonable. I think you could ditch GIT-BUILD-OPTIONS
entirely. It's only needed to pull in GIT_PERF variables that would be
better served by being in the config in the first place.

-Peff
