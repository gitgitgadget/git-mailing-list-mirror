Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14BD1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfF0VV5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 17:21:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:53138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726384AbfF0VV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 17:21:56 -0400
Received: (qmail 10957 invoked by uid 109); 27 Jun 2019 21:21:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Jun 2019 21:21:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11760 invoked by uid 111); 27 Jun 2019 21:22:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Jun 2019 17:22:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Jun 2019 17:21:54 -0400
Date:   Thu, 27 Jun 2019 17:21:54 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: fprintf_ln() is slow
Message-ID: <20190627212154.GB20250@sigill.intra.peff.net>
References: <20190627052515.GA21207@sigill.intra.peff.net>
 <20190627055739.GA9322@sigill.intra.peff.net>
 <CACsJy8Cjn2z7TrH9HLQ94Ph7qPZ0fC01J=Lq7GcrhvaCQZaSmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Cjn2z7TrH9HLQ94Ph7qPZ0fC01J=Lq7GcrhvaCQZaSmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 04:27:07PM +0700, Duy Nguyen wrote:

> >  int fprintf_ln(FILE *fp, const char *fmt, ...)
> >  {
> > +       char buf[1024];
> >         int ret;
> >         va_list ap;
> > +
> > +       /* Fast path: format it ourselves and dump it via fwrite. */
> > +       va_start(ap, fmt);
> > +       ret = vsnprintf(buf, sizeof(buf), fmt, ap);
> > +       va_end(ap);
> > +       if (ret < sizeof(buf)) {
> > +               buf[ret++] = '\n';
> > +               if (fwrite(buf, 1, ret, fp) != ret)
> > +                       return -1;
> > +               return ret;
> > +       }
> > +
> > +       /* Slow path: a normal fprintf/putc combo */
> >         va_start(ap, fmt);
> >         ret = vfprintf(fp, fmt, ap);
> >         va_end(ap);
> [...]
> 
> How about do all the formatting in strbuf and only fwrite last minute?
> A bit more overhead with malloc(), so I don't know if it's an
> improvement or not.

We could easily do that by replacing the vfprintf() slow path there with
a strbuf, and it would be faster in the normal case for small outputs.
The question is whether a malloc() or two write()s is worse.

Probably the malloc() costs less for sane-sized inputs, but would blow
up in pathological cases as we ask for a lot of RAM.

I'm not sure it's worth caring that much about such a case. This is,
after all, designed to print a single line. I suspect we could put
BUG("woah, your line is really big") in the slow-path here and nobody
would ever notice. ;)

I'm also not entirely convinced it's worth caring about this problem at
all (whether the solution is buffering here, or just adding the "\n"
back to the original strings). It's true that p1451 shows off a
measurable improvement, but I think it's a silly, pathological case. I'd
be surprised if anybody ever noticed the difference in the real world.

The biggest benefit I see to dealing with it is not performance, but
that it makes our messages more likely to appear atomically in the
output (if multiple entities are writing to stderr).

-Peff
