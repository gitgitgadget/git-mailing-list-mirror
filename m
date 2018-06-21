Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF001F516
	for <e@80x24.org>; Thu, 21 Jun 2018 11:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933170AbeFULqg (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 07:46:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:50494 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933014AbeFULqf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 07:46:35 -0400
Received: (qmail 17115 invoked by uid 109); 21 Jun 2018 11:46:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Jun 2018 11:46:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4520 invoked by uid 111); 21 Jun 2018 11:46:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Jun 2018 07:46:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2018 07:46:33 -0400
Date:   Thu, 21 Jun 2018 07:46:33 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
Message-ID: <20180621114632.GA15293@sigill.intra.peff.net>
References: <20180601200146.114919-1-sbeller@google.com>
 <20180601200146.114919-2-sbeller@google.com>
 <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com>
 <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com>
 <20180604035637.GA15408@sigill.intra.peff.net>
 <xmqqin6z5g8e.fsf@gitster-ct.c.googlers.com>
 <20180604045122.GE14451@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1806210857520.11870@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1806210857520.11870@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 09:03:05AM +0200, Johannes Schindelin wrote:

> > > And at that point, maybe
> > > 
> > > 	char *some_var = xstrdup("default");
> > > 	git_config_string(&some_var, ...);
> > > 
> > > that takes "char **" and frees the current storage before assigning to
> > > it may be simpler than the two-variable approach.
> > 
> > That _is_ much nicer, but you cannot use xstrdup() as the initializer
> > for a global "static char *some_var", which is what the majority of the
> > config variables are. It's this "static initializer sometimes, run-time
> > heap sometimes" duality to the variables that makes handling it such a
> > pain.
> 
> This makes me think of Michael's proposal to teach strbuf some sort of
> STRBUF_INIT_CONST("default") which would set the appropriate len and set
> alloc to 0.
> 
> That way, we could turn those settings into strbufs that only allocate
> memory when/if needed.

Yes! I should have thought about that as soon as I started saying "you
need two variables...". That is a good indication that you need a
struct. ;)

I think the result would be quite readable and pleasant to work with.

I tried to dig up previous conversations about this to see if there were
any patches shown, but I couldn't find any (mostly I found the
conversation about using stack buffers in strbufs, which is not quite
the same thing, since we _do_ want to write in those).

-Peff
