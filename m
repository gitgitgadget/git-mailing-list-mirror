Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F33B1F461
	for <e@80x24.org>; Fri, 28 Jun 2019 10:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfF1KY3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 06:24:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:53812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726524AbfF1KY3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 06:24:29 -0400
Received: (qmail 14594 invoked by uid 109); 28 Jun 2019 10:24:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 10:24:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16629 invoked by uid 111); 28 Jun 2019 10:25:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 06:25:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 06:24:27 -0400
Date:   Fri, 28 Jun 2019 06:24:27 -0400
From:   Jeff King <peff@peff.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
Message-ID: <20190628102427.GB23052@sigill.intra.peff.net>
References: <20190627052515.GA21207@sigill.intra.peff.net>
 <20190627055739.GA9322@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906271358260.44@tvgsbejvaqbjf.bet>
 <20190627210959.GA20250@sigill.intra.peff.net>
 <374b237e-a29f-5983-0932-63f1c2ebcbbe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <374b237e-a29f-5983-0932-63f1c2ebcbbe@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 11:03:27AM +0100, Phillip Wood wrote:

> > I considered that, too, but I think it is safe. stdio has its own
> > locking, so every individual call is atomic. The potentially problematic
> > case would be where we switch back from line buffering to no-buffering,
> > and somebody else has written some content into our stack-based buffer
> > (that is about to go out of scope!). But I'd assume that as part of the
> > switch to no-buffering that any stdio implementation would flush out the
> > buffer that it's detaching from (while under lock). Nothing else makes
> > sense.
> 
> The C standard section 7.19.5.6 says that
>   The setvbuf function may be used only after the stream pointed to by
>   a stream has been associated with an open file and before any other
>   operation (other than an unsuccessful call to setvbuf) is performed
>   on the stream.
> 
> The is a note about the buffer that says
>   The buffer has to have a lifetime at least as great as the open
>   stream, so the stream should be closed before a buffer that has
>   automatic storage duration is deallocated upon block exit.
> 
> So changing the buffer in the way that has been proposed is undefined
> behavior on two counts I think.

Oof, thanks for the reference. That is much less safe than I had
imagined. We used to do this kind of setvbuf() munging in vreportf.
Interestingly, it was in released versions for about 2 years, but I
don't recall anybody complaining (we eventually reverted it to have more
flexibility in sanitizing the results before writing them out).

Anyway, I think we're all agreed that's the wrong approach here.

-Peff
