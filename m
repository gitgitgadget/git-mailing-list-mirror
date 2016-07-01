Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476D220FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 08:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbcGAI0H (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 04:26:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:38873 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752505AbcGAI0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 04:26:05 -0400
Received: (qmail 29886 invoked by uid 102); 1 Jul 2016 08:19:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 04:19:25 -0400
Received: (qmail 14888 invoked by uid 107); 1 Jul 2016 08:19:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 04:19:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 04:19:20 -0400
Date:	Fri, 1 Jul 2016 04:19:20 -0400
From:	Jeff King <peff@peff.net>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] add an extra level of indirection to main()
Message-ID: <20160701081919.GA21076@sigill.intra.peff.net>
References: <20160701055532.GA4488@sigill.intra.peff.net>
 <20160701055858.GA4593@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607010953440.12947@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607010953440.12947@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 10:04:44AM +0200, Johannes Schindelin wrote:

> Hi Peff,
> 
> On Fri, 1 Jul 2016, Jeff King wrote:
> 
> > I waffled between the two mechanisms. Opinions welcome.
> 
> I am happy you took the cmd_main() approach: we do have to play some
> tricks on Windows, in particular in some upcoming changes that support
> building with MS Visual C++ (we want to ensure that `argv` is in UTF-8,
> which means that we actually have to use the UTF-16 versions and convert
> them manually lest argv has the current Windows encoding of strings).
> Which means that we still have to use that mingw_startup() trick you
> mentioned, and which would have interfered had you chosen a similar
> method.

I actually wondered if it would make sense to get rid of the
mingw_main() macro, and do it here as just:

    #ifdef MINGW
    mingw_startup();
    #endif

or something. But I didn't look deeply at it, and anyway I am afraid to
touch anything in that area because I can't even compile-test it.

> > diff --git a/common-main.c b/common-main.c
> > new file mode 100644
> > index 0000000..2b96bbf
> > --- /dev/null
> > +++ b/common-main.c
> > @@ -0,0 +1,12 @@
> > +#include "git-compat-util.h"
> > +
> > +int main(int argc, char **av)
> > +{
> > +	/*
> > +	 * This const trickery is explained in
> > +	 * 84d32bf7678259c08406571cd6ce4b7a6724dcba
> 
> This commit message says that mingw_main() is declared with char **argv,
> and that is the reason why we have to convert. Maybe spell that out here,
> and then in a subsequent commit, we can fix the mingw_main() declaration?

The description was sufficiently long that I didn't want to try
repeating it, and opted for a reference instead. If you're planning to
fix mingw_main(), I'd be happy to do that as a preparatory patch, and
then just skip this trickery entirely. :)

-Peff
