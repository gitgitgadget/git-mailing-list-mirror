Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7371F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964986AbeAXSBu (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:01:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:55744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964826AbeAXSBu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:01:50 -0500
Received: (qmail 17464 invoked by uid 109); 24 Jan 2018 18:01:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 18:01:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26563 invoked by uid 111); 24 Jan 2018 18:02:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 13:02:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 13:01:42 -0500
Date:   Wed, 24 Jan 2018 13:01:42 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] travis-ci: don't run the test suite as root in the
 32 bit Linux build
Message-ID: <20180124180142.GA26290@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-5-szeder.dev@gmail.com>
 <20180123164340.GG13068@sigill.intra.peff.net>
 <CAM0VKjkRGxAjjibHbJPmC6KZDFL67WEhN1VFqEjbsQAZbgCB8A@mail.gmail.com>
 <20180124155622.GB15803@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180124155622.GB15803@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 10:56:22AM -0500, Jeff King wrote:

> > > (As an aside, I'm not sure the prove cache is doing much. Running in
> > > slow-to-fast order helps if you are trying to run massively in parallel,
> > > but we only use -j3 for our Travis builds).
> > 
> > It saves about a minute / 10% of runtime; it's mentioned in 7e72cfcee
> > (travis-ci: save prove state for the 32 bit Linux build, 2017-12-27).
> 
> I'm surprised we get that much benefit out of a 3-way parallel run, but
> I'll believe you if you measured it. I guess it's because a lot of the
> really long tests are right at the end, numerically (especially if svn
> tests are enabled). I wonder if "--shuffle" would yield similar
> benefits.

Just for fun, I tried running:

  cd t
  best-of-five make GIT_PROVE_OPTS='-j3'
  best-of-five make GIT_PROVE_OPTS='-j3 --state=slow,save'
  best-of-five make GIT_PROVE_OPTS='-j3 --shuffle'

and got:

  stock
  Attempt 1: 137.057
  Attempt 2: 137.635
  Attempt 3: 138.925
  Attempt 4: 134.693
  Attempt 5: 139.581

  slow,save
  Attempt 1: 133.157
  Attempt 2: 135.602
  Attempt 3: 133.225
  Attempt 4: 136.278
  Attempt 5: 133.382

  shuffle
  Attempt 1: 136.717
  Attempt 2: 138.805
  Attempt 3: 145.734
  Attempt 4: 145.226
  Attempt 5: 145.889

I had expected the shuffle to be sometimes-fast and sometimes-slow, but
it seems like it is just-slow. So that's probably not a big win. It also
doesn't look like state-saving gets us much.

Those runs don't have cvs/svn installed. I repeated with those
installed. The whole run is much slower then (about 230s), but the
relative timings are the same.

I wonder what is different between my setup and Travis. I guess one
is that I use a tmpfs for the test-root. I wonder if that could throw
off the relative timings, or the importance of parallelization.

-Peff
