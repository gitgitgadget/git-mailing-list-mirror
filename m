Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BA8C1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751749AbeC3NO7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:14:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:48594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751247AbeC3NO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:14:58 -0400
Received: (qmail 9300 invoked by uid 109); 30 Mar 2018 13:14:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 30 Mar 2018 13:14:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27378 invoked by uid 111); 30 Mar 2018 13:15:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 30 Mar 2018 09:15:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2018 09:14:56 -0400
Date:   Fri, 30 Mar 2018 09:14:56 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 8/9] git_config_set: use do_config_from_file() directly
Message-ID: <20180330131456.GB29568@sigill.intra.peff.net>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <e3032300946eb5962878341f7796f5872c4d138d.1522336130.git.johannes.schindelin@gmx.de>
 <20180329213823.GH2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301500560.5026@qfpub.tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803301500560.5026@qfpub.tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 03:02:00PM +0200, Johannes Schindelin wrote:

> > I'm not sure I understand that last paragraph. What does flockfile() have
> > to do with stdin/stdout?
> > 
> > The point of those calls is that we're locking the FILE handle, so that
> > it's safe for the lower-level config code to run getc_unlocked(), which
> > is faster.
> > 
> > So without those, we're calling getc_unlocked() without holding the
> > lock. I think it probably works in practice because we know that we're
> > single-threaded, but it seems a bit sketchy.
> 
> Oops. I misunderstood the purpose of flockfile(), then. I thought it was
> only about multiple users of stdin/stdout.
> 
> Will have a look whether flockfile()/funlockfile() can be moved into
> do_config_from_file() instead.

In a sense stdin/stdout are much more susceptible to this because
they're global variables, and any thread may touch them. For the config
code, we open our own handle that we don't expose elsewhere. So probably
it would be fine just to use the unlocked variants even without locking.

But IMHO it's good practice to always flockfile() before using the
unlocked variants. My reading of POSIX is that it's OK to use the
unlocked variants without holding the lock (if you know there won't be
contention), but if it's not hard to err on the side of safety, I'd
prefer it.

-Peff
