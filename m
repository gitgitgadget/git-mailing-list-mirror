Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D9A1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 21:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0V0i (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 17:26:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726384AbfF0V0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 17:26:38 -0400
Received: (qmail 11007 invoked by uid 109); 27 Jun 2019 21:26:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jun 2019 21:26:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11865 invoked by uid 111); 27 Jun 2019 21:27:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Jun 2019 17:27:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2019 17:26:36 -0400
Date:   Thu, 27 Jun 2019 17:26:36 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
Message-ID: <20190627212636.GC20250@sigill.intra.peff.net>
References: <20190627052515.GA21207@sigill.intra.peff.net>
 <20190627055739.GA9322@sigill.intra.peff.net>
 <CACsJy8Cjn2z7TrH9HLQ94Ph7qPZ0fC01J=Lq7GcrhvaCQZaSmg@mail.gmail.com>
 <8736jv8bnc.fsf@evledraar.gmail.com>
 <CACsJy8AgmM0xYMMdYvpRSs4JRbNahcQyGcMMfPmaTS4Uv=Ok6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AgmM0xYMMdYvpRSs4JRbNahcQyGcMMfPmaTS4Uv=Ok6A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 07:32:53PM +0700, Duy Nguyen wrote:

> > It's also not possible for translators to do this by mistake
> 
> This (accidentally dropping \n which sometimes is significant) is the
> part that I made me prefer *printf_ln(). I had been translating for
> years, as far back as 2003-ish, but I've stopped since the last few
> years so I'm no longer uptodate with gettext development. And my very
> old/outdated experience with gettext might make me think it's still
> the problem.
> 
> > without
> > being caught, because msgfmt will catch this (and other common issues):
> >
> >     po/de.po:23: 'msgid' and 'msgstr' entries do not both end with '\n'
> 
> Ok good. And with the downside of degraded performance, sure remove
> all the *printf_ln()

I don't have a strong opinion here. If you want to convert them all back
to embedded "\n", that's fine with me.

But I do suspect this same issue will come up in other places, too. For
instance, we already format into a buffer for error(), etc. Mostly for
atomic output as opposed to efficiency. And it's not just "\n", but
adding prefixes, etc.

It might be nice to have some generalized solution for writing to
stderr. And maybe it's even just using vreportf more widely. That also
caps the output length and munges unprintable characters, but that's
probably a good thing when we're going to stderr.

-Peff
