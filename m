Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5D91F404
	for <e@80x24.org>; Wed, 24 Jan 2018 15:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934179AbeAXP4Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 10:56:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:55624 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933953AbeAXP4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 10:56:25 -0500
Received: (qmail 8612 invoked by uid 109); 24 Jan 2018 15:56:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 15:56:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25720 invoked by uid 111); 24 Jan 2018 15:57:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 10:57:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 10:56:23 -0500
Date:   Wed, 24 Jan 2018 10:56:23 -0500
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
Message-ID: <20180124155622.GB15803@sigill.intra.peff.net>
References: <CAM0VKjmAjw0a2JzsY1BaAwZcCp8ge+jQaGN6L_nKTLugHeWyvQ@mail.gmail.com>
 <20180122133220.18587-1-szeder.dev@gmail.com>
 <20180122133220.18587-5-szeder.dev@gmail.com>
 <20180123164340.GG13068@sigill.intra.peff.net>
 <CAM0VKjkRGxAjjibHbJPmC6KZDFL67WEhN1VFqEjbsQAZbgCB8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkRGxAjjibHbJPmC6KZDFL67WEhN1VFqEjbsQAZbgCB8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 02:45:18PM +0100, SZEDER Gábor wrote:

> I think the key is the handling of verbose logs of failed test(s).  The
> original motivation for matching the user IDs was, I suppose, that we
> wanted to dump the verbose log of the failed test(s) to the trace log on
> the host, because this way it's fairly consistent with how other build
> job do the same: it uses the same 'after_failure' script to dump the
> verbose logs, it relies on Travis CI to automatically run that script if
> something goes wrong, and those logs end up in the 'after_failure'
> fold.

That makes sense, I guess. In the CI system I'm using there's no such
distinction, and I just do:

    tar -x && make -j64 test && exit 0
    echo "Failing tests:"
    echo "--------------"
    grep -l '[^0]' t/test-results/*.exit |
    while read failed; do
      base=${failed%.exit}
      name=${base#t/test-results/}
      echo "==> $name"
      cat "$base.out"
    done
    exit 1

There's no folds there at all, but we could of course do our own. It may
not be worth messing with, though, if you've shaken all the problems out
of the existing setup.

> > (As an aside, I'm not sure the prove cache is doing much. Running in
> > slow-to-fast order helps if you are trying to run massively in parallel,
> > but we only use -j3 for our Travis builds).
> 
> It saves about a minute / 10% of runtime; it's mentioned in 7e72cfcee
> (travis-ci: save prove state for the 32 bit Linux build, 2017-12-27).

I'm surprised we get that much benefit out of a 3-way parallel run, but
I'll believe you if you measured it. I guess it's because a lot of the
really long tests are right at the end, numerically (especially if svn
tests are enabled). I wonder if "--shuffle" would yield similar
benefits.

-Peff
