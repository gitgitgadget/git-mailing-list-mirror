Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732201F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 03:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754170AbcIWDdd (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 23:33:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:46969 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757985AbcIWDbr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 23:31:47 -0400
Received: (qmail 23462 invoked by uid 109); 23 Sep 2016 03:31:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 03:31:47 +0000
Received: (qmail 14090 invoked by uid 111); 23 Sep 2016 03:31:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 23:31:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 23:31:44 -0400
Date:   Thu, 22 Sep 2016 23:31:44 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] clone: pass --progress decision to recursive submodules
Message-ID: <20160923033143.azkwbbh54oistg6u@sigill.intra.peff.net>
References: <20160922052446.iwr62hpa2meal7uj@sigill.intra.peff.net>
 <CAGZ79kbTi+5oo325v+v8GB7isKRfqys6WRGUARHiMvieDz+png@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbTi+5oo325v+v8GB7isKRfqys6WRGUARHiMvieDz+png@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 08:36:01AM -0700, Stefan Beller wrote:

> > Signed-off-by: Jeff King <peff@peff.net>
> 
> Acked and thanked by Stefan ;)

Thanks.

> > +       /*
> > +        * We want to show progress for recursive submodule clones iff
> > +        * we did so for the main clone. But only the transport knows
> > +        * the final decision for this flag, so we need to rescue the value
> > +        * before we free the transport.
> > +        */
> > +       submodule_progress = transport->progress;
> > +
> 
> Good point! I was aware of this bug (but I did not consider it to be
> impactful or as you put it "much worse"), but I anticipated we would
> need some refactoring

To be fair, "much worse" is relative; it's _just_ a disabled progress
bar. :)

I do think this counts as a real regression, though. The "do not pass
down explicit --progress" bug was something probably nobody ever cared
about. But losing progress with the default settings is a thing people
might actually notice.

> of the transport code, e.g. have the decision via isatty(2) as a
> separate outside function that we consult before we even setup the
> transport and then pass it down to the submodules as well. This seems
> to solve this bug elegantly.

Yeah, I considered passing a "no really, stderr is a tty" environment
variable down (which would have avoided all of the boilerplate
propagation of --progress through the various helpers). But when I
realized that we do not handle explicit "--progress" either, the
correct solution became more obvious.

And hopefully all that propagation boilerplate will eventually go away
(or at least be simplified) as the submodule code consolidates in C.

> >  static int clone_submodule(const char *path, const char *gitdir, const char *url,
> > -                          const char *depth, struct string_list *reference, int quiet)
> > +                          const char *depth, struct string_list *reference,
> > +                          int quiet, int progress)
> 
> I am not sure if having both quiet and progress is maintainable well,
> but it get's the job done here, specifically if we consider this patch a bug
> fix that we'd want to merge down to maint.

Yeah, I had a similar thought that we might need to combine these, or
possibly that we could even drop "quite". But I tried to err on the side
of making the minimal change, as this isn't really a code path I'm very
familiar with.

-Peff
