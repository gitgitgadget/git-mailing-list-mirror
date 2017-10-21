Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EFC202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 03:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752824AbdJUDXD (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 23:23:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:59652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752701AbdJUDXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 23:23:02 -0400
Received: (qmail 3849 invoked by uid 109); 21 Oct 2017 03:23:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 21 Oct 2017 03:23:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21763 invoked by uid 111); 21 Oct 2017 03:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Oct 2017 23:23:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Oct 2017 23:23:00 -0400
Date:   Fri, 20 Oct 2017 23:23:00 -0400
From:   Jeff King <peff@peff.net>
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/3] t5615: avoid re-using descriptor 4
Message-ID: <20171021032300.fnbp55ruzak43dzh@sigill.intra.peff.net>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
 <20171019210730.sgm4g4tmor2dgjv7@sigill.intra.peff.net>
 <CAGZ79kYTmUnM+fcf222-cvwB3Fg4+J_xy28E7A3AYryx4qDf_w@mail.gmail.com>
 <20171019232337.zfd7occtjboem7f4@sigill.intra.peff.net>
 <20171020055058.s5dgxyfjnqtlxv4d@sigill.intra.peff.net>
 <CAGZ79kaSu+nHHntFPWbkXk1TC4ys9htesRg9HHXcpK+Y6MwZeg@mail.gmail.com>
 <20171020224608.3ataitvdq5r33iih@sigill.intra.peff.net>
 <20171021001916.bohcqjuxcufxvpam@ruderich.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171021001916.bohcqjuxcufxvpam@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 21, 2017 at 02:19:16AM +0200, Simon Ruderich wrote:

> On Fri, Oct 20, 2017 at 06:46:08PM -0400, Jeff King wrote:
> >> I agree. Maybe just stick with the original patch?
> >
> > OK. Why don't we live with that for now, then. The only advantage of the
> > "999" trickery is that it's less likely to come up again. If it doesn't,
> > then we're happy. If it does, then we can always switch then.
> 
> I think switching the 4 to 9 (which you already brought up in
> this thread) is a good idea. It makes accidental conflicts less
> likely (it's rare to use so many file descriptors) and is easy to
> implement.

I'm not sure it does make accidental conflicts less likely. Grepping for
'9>' shows a problematic one in t0008, and one in t9300. That's two
versus the one for "4". :)

We often use descriptors 8 or 9 as "high and not taken for any specific
use" in our tests, and do things like:

  mkfifo foo
  exec 9>foo
  ...
  exec 9>&-

This is unlike a redirection in a sub-command (like "foo 9>bar") because
it effects the whole test suite's state. So it would break the test
under "-x" (because we'd get random cruft sent to the fifo), as well as
breaking the "-x" output itself (because we close the descriptor).

I actually think "7" is the safest descriptor right now. It's not used
for anything, and it's not high enough for tests to think "this probably
isn't used for anything".

-Peff
