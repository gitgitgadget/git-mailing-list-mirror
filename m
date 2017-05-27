Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3273F20D09
	for <e@80x24.org>; Sat, 27 May 2017 21:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbdE0VqR (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 17:46:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:58882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbdE0VqR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 17:46:17 -0400
Received: (qmail 30952 invoked by uid 109); 27 May 2017 21:46:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 May 2017 21:46:13 +0000
Received: (qmail 5898 invoked by uid 111); 27 May 2017 21:46:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 May 2017 17:46:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 May 2017 17:46:11 -0400
Date:   Sat, 27 May 2017 17:46:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
Message-ID: <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
 <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 27, 2017 at 06:57:08PM +0200, Ævar Arnfjörð Bjarmason wrote:

> There's another test which breaks if we just s/gmtime/localtime/g. As
> far as I can tell to make the non-local case work we'd need to do a
> whole dance where we set the TZ variable to e.g. UTC$offset, then call
> strftime(), then call it again. Maybe there's some way to just specify
> the tz offset, but I didn't find any in a quick skimming of time.h.

There isn't. At least on _some_ platforms, the zone information is
embedded in "struct tm" and stored by gmtime() and localtime(), but the
fields aren't publicly accessible. Which is why your patch worked for
format-local (it swaps out gmtime() for localtime() which sets those
fields behind the scenes). But:

  - I'm not sure that's guaranteed by the standard; strftime() might get
    its zone information elsewhere (if it needs to reliably distinguish
    between gmtime() and localtime() results it has to at least set a
    bit in the "struct tm", but that bit may not be the full zone info).

  - Even if it does work, you're stuck with only the local timezone. In
    theory you could temporarily tweak the process's timezone, call
    localtime(), and then tweak it back. I was never able to get that to
    work (links below).

On glibc, at least, you can access the zone fields in "struct tm" by
compiling with _DEFAULT_SOURCE.

So I think the best we could do is probably to have a feature macro like
TM_HAS_GMTOFF, and set tm->tm_gmtoff and tm->tm_zone on platforms that
support it. I'm not sure what we'd put in the latter, though; we don't
actually have the timezone name at all (we just have "+0200" or whatever
we parsed from the git object, but that would be better than nothing).

That leaves other platforms still broken, but like I said, I don't think
there's a portable solution.

Here are some links to past explorations:

  http://public-inbox.org/git/20160208152858.GA17226@sigill.intra.peff.net/

  http://public-inbox.org/git/87vb2d37ea.fsf@web.de/

-Peff
