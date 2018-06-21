Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8F1B1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 12:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeFUMCC (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 08:02:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:50528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932595AbeFUMCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 08:02:01 -0400
Received: (qmail 17835 invoked by uid 109); 21 Jun 2018 12:02:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Jun 2018 12:02:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4783 invoked by uid 111); 21 Jun 2018 12:02:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Jun 2018 08:02:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Jun 2018 08:01:59 -0400
Date:   Thu, 21 Jun 2018 08:01:59 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180621120159.GC15293@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <cover.1529524852.git.me@ttaylorr.com>
 <20180621115302.GB15293@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621115302.GB15293@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 21, 2018 at 07:53:02AM -0400, Jeff King wrote:

> > @@ -1429,7 +1447,7 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
> >  	 */
> >  	if (opt->columnnum && cno) {
> >  		char buf[32];
> > -		xsnprintf(buf, sizeof(buf), "%d", cno);
> > +		xsnprintf(buf, sizeof(buf), "%zu", cno);
> 
> Unfortunately %z isn't portable. You have to use:
> 
>   xsnprintf(buf, sizeof(buf), "%"PRIuMAX, (uintmax_t)cno);

To clarify: yes, it is in C99. But traditionally we have not required
that.

This might be a candidate for another "weather balloon" patch to see if
anybody complains, though. The last time time we dealt with this in a
major way was over 7 years ago in 28bd70d811 (unbreak and eliminate
NO_C99_FORMAT, 2011-03-16).

I know Johannes switched out some "%lu" for PRIuMAX as recently as last
August[1], but I think that is more about the Windows size_t not matching
"unsigned long", and the decision to use PRIuMAX was to match the
existing codebase. AFAIK %zu is available on Windows.

-Peff

[1] https://public-inbox.org/git/alpine.DEB.2.21.1.1708100011391.11175@virtualbox/
