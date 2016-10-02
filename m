Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A27FB1F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 16:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbcJBQ7R (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 12:59:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51071 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbcJBQ7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2016 12:59:17 -0400
Received: (qmail 6462 invoked by uid 109); 2 Oct 2016 16:59:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 16:59:16 +0000
Received: (qmail 23426 invoked by uid 111); 2 Oct 2016 16:59:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 02 Oct 2016 12:59:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Oct 2016 12:59:14 -0400
Date:   Sun, 2 Oct 2016 12:59:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 2/6] sha1_file: always allow relative paths to alternates
Message-ID: <20161002165913.txqotwtwulphja67@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193604.hqspizasfpqa6bez@sigill.intra.peff.net>
 <c27dc1a4-3c7a-2866-d9d8-f5d3eb161650@web.de>
 <20161002153856.sqdw26mtldhvue2r@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161002153856.sqdw26mtldhvue2r@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 02, 2016 at 11:38:56AM -0400, Jeff King wrote:

> On Sun, Oct 02, 2016 at 11:07:39AM +0200, René Scharfe wrote:
> 
> > diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> > index ba92919..b2afe36 100644
> > --- a/builtin/count-objects.c
> > +++ b/builtin/count-objects.c
> > @@ -73,6 +73,12 @@ static int count_cruft(const char *basename, const char *path, void *data)
> >  	return 0;
> >  }
> >  
> > +static int print_alt_odb(struct alternate_object_database *alt, void *data)
> > +{
> > +	puts(alt->base);
> > +	return 0;
> > +}
> 
> This turns out to be wrong, because alt->base _isn't_ just the base;
> it's also the scratch buffer we write into to form pathnames. So if
> we've used the buffer to look up an object, we'll get that object name
> here, not just the base.
> 
> It tends to work for your command because we do nothing except list the
> alternates and exit, but I'm not sure if there are code paths which
> might access an object.
> 
> I think giving a known state to the callback should be the
> responsibility of foreach_alt_odb(), though.

Actually, it looks like there are a lot of opportunities for cleanups in
that area, and maybe some bugfixes (e.g., we should consistently be
using fspathcmp and not memcmp to check for duplicate paths). I started
on a series, but don't have anything to show yet (just FYI in case you
were thinking about doing the same).

-Peff
