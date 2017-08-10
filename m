Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C98BE20899
	for <e@80x24.org>; Thu, 10 Aug 2017 07:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbdHJH2Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 03:28:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:34134 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751715AbdHJH2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 03:28:24 -0400
Received: (qmail 25497 invoked by uid 109); 10 Aug 2017 07:28:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 07:28:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2199 invoked by uid 111); 10 Aug 2017 07:28:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 03:28:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 03:28:22 -0400
Date:   Thu, 10 Aug 2017 03:28:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
Message-ID: <20170810072822.rj6y6zcqhyfz4yi7@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <xmqq60dw7j5u.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xoifkJyH34Q0NJdE_=UzWK1SA+2gwyXrHpF7Sv2PBHATQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+P7+xoifkJyH34Q0NJdE_=UzWK1SA+2gwyXrHpF7Sv2PBHATQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 12:04:49AM -0700, Jacob Keller wrote:

> >>   $ git log --format=%B -1 8d44797cc91231cd44955279040dc4a1ee0a797f |
> >>     git interpret-trailers --parse
> >>   Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
> >>   Helped-by: Stefan Beller <sbeller@google.com>
> >>   Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> >>   Acked-by: Matthias Rüster <matthias.ruester@gmail.com>
> >
> > Thank-you, thank-you, thank-you.
> >
> > The above example made me wonder if we also want a format specifier
> > to do the above without piping, but it turns out that we already
> > have "log --format=%(trailers)", so we are good ;-)
> 
> I was going to say, I thought we had a way to get trailers for a
> commit via the pretty format, since that is what i used in the past.

I do like that you could get the trailers for many commits in a single
invocation. That doesn't matter for my current use-case, but obviously
piping through O(n) interpret-trailers invocations is a bad idea.

But there are a few difficulties with using %(trailers) for this, as it
shows everything between the start/end points of the trailer block. In
particular:

  1. You don't get any kind of normalization, so you're on your own for
     parsing things like whitespace continuation, extra spaces before
     separators, etc.

  2. It prints non-trailers that fall inside the block. For instance:

       $ git commit --allow-empty -F - <<-\EOF
       subject

       body

       Signed-off-by: me
       this is not a trailer
       Signed-off-by: you
       EOF
 
       $ git log -1 --format=%B | git interpret-trailers --parse
       Signed-off-by: me
       Signed-off-by: you

       $ git log -1 --format='%(trailers)'
       Signed-off-by: me
       this is not a trailer
       Signed-off-by: you

For (1) I think many callers would prefer to see the original
formatting. Maybe we'd need a %(trailers:normalize) or something.

I'm tempted to call (2) a bug, but I guess it's unclear whether callers
would want to see the whole block, or if they really want just the
individual trailers.

-Peff
