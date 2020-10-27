Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A12C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3D321655
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507509AbgJ0HXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:23:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:38272 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507506AbgJ0HXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:23:10 -0400
Received: (qmail 14307 invoked by uid 109); 27 Oct 2020 07:23:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:23:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15060 invoked by uid 111); 27 Oct 2020 07:23:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:23:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:23:09 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     VenomVendor <info@venomvendor.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 4/3] am, sequencer: stop parsing our own committer ident
Message-ID: <20201027072309.GE3005508@coredump.intra.peff.net>
References: <20201023070747.GA2198273@coredump.intra.peff.net>
 <20201023070939.GB2913115@coredump.intra.peff.net>
 <20201023072630.GA2918369@coredump.intra.peff.net>
 <20201023074510.GB2918369@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2010261722230.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010261722230.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 05:25:01PM +0100, Johannes Schindelin wrote:

> On Fri, 23 Oct 2020, Jeff King wrote:
> 
> > diff --git a/ident.c b/ident.c
> > index 6aba4b5cb6..7743c1ed05 100644
> > --- a/ident.c
> > +++ b/ident.c
> > @@ -384,6 +384,12 @@ const char *fmt_ident(const char *name, const char *email,
> >  	struct strbuf *ident = &ident_pool[index];
> >  	index = (index + 1) % ARRAY_SIZE(ident_pool);
> >
> > +	if (!email) {
> > +		if (whose_ident == WANT_AUTHOR_IDENT)
> > +			email = getenv("GIT_AUTHOR_EMAIL");
> > +		else if (whose_ident == WANT_COMMITTER_IDENT)
> > +			email = getenv("GIT_COMMITTER_EMAIL");
> 
> I *guess* that this is a strict improvement, calling `getenv()` much
> closer to the time the value is actually used (and hence avoiding the
> problem where pointers returned by `getenv()` get stale due to environment
> changes).

I don't think it changes much in practice. Most of the callers are
passing the values directly in to this function, and there's not much
that happens between the function starting and these calls.

The more worrisome stretch is that we likely call strbuf functions while
holding on to a getenv() pointer. And those potentially do things like
xmalloc(), which looks at GIT_ALLOC_LIMIT, etc. But though POSIX
promises only one getenv() result at a time, we definitely don't adhere
to that (after all, we routinely pass the results of three separate
getenv() calls to fmt_ident!). As you well know, because mingw_getenv()
has a circular buffer hack to deal with this. :)

So it certainly isn't making anything worse, but I'd be surprised if it
actually helped at all.

-Peff
