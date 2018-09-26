Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0D11F453
	for <e@80x24.org>; Wed, 26 Sep 2018 03:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeIZJo0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 05:44:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:59760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726062AbeIZJo0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 05:44:26 -0400
Received: (qmail 15332 invoked by uid 109); 26 Sep 2018 03:33:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 03:33:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14750 invoked by uid 111); 26 Sep 2018 03:33:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Sep 2018 23:33:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2018 23:33:38 -0400
Date:   Tue, 25 Sep 2018 23:33:37 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v2 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180926033337.GC32064@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1537555544.git.me@ttaylorr.com>
 <9797f525517142b3494cfbd17a10dfeb3bf586e2.1537555544.git.me@ttaylorr.com>
 <20180922180231.GD432229@genre.crustytoothpaste.net>
 <20180922195258.GA20983@sigill.intra.peff.net>
 <20180926010935.GK4364@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926010935.GK4364@syl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 06:09:35PM -0700, Taylor Blau wrote:

> > So I think this is fine (modulo that the grep and sed can be combined).
> > Yet another option would be to simply strip away everything except the
> > object id (which is all we care about), like:
> >
> >   depacketize | perl -lne '/^(\S+) \.have/ and print $1'
> 
> Thanks for this. This is the suggestion I ended up taking (modulo taking
> '-' as the first argument to 'depacketize').

I don't think depacketize takes any arguments. It always reads from
stdin directly, doesn't it? Your "-" is not hurting anything, but it is
totally ignored.

A perl tangent if you're interested:

  Normally for shell functions like this that are just wrappers around
  perl snippets, I would suggest to pass "$@" from the function's
  arguments to perl. So for example if we had:

    haves_from_packets () {
	perl -lne '/^(\S+) \.have/ and print $1' "$@"
    }

  then you could call it with a filename:

    haves_from_packets packets

  or input on stdin:

    haves_from_packets <packets

  and either works (this is magic from perl's "-p" loop, but you get the
  same if you write "while (<>)" explicitly in your program).

  But because depacketize() has to use byte-wise read() calls, it
  doesn't get that magic for free. And it did not seem worth the effort
  to implement, when shell redirections are so easy. ;)

  Just skimming through test-lib-functions.sh, though, it does seem that
  we often deviate from that pattern (e.g., all of the q_to_nul family).
  And has seemed to mind.

> The 'print $1' part of this makes things a lot nicer, actually, having
> removed the " .have" suffix. We can get rid of the expect_haves()
> function above, and instead call 'git rev-parse' inline and get the
> right results.

Yes. You can even do it all in a single rev-parse call.

-Peff
