Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB111F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfAXVRR (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:17:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:48058 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725974AbfAXVRR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:17:17 -0500
Received: (qmail 15209 invoked by uid 109); 24 Jan 2019 21:17:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 21:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32598 invoked by uid 111); 24 Jan 2019 21:17:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 16:17:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 16:17:15 -0500
Date:   Thu, 24 Jan 2019 16:17:15 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH 2/6] diff: clear emitted_symbols flag after use
Message-ID: <20190124211715.GB16114@sigill.intra.peff.net>
References: <20190124122603.GA10415@sigill.intra.peff.net>
 <20190124123240.GB11354@sigill.intra.peff.net>
 <xmqqy379hkri.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZR--VN2BiG=usyy=J=u59Up3XYpK4c9pJYQkX1Gby06Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZR--VN2BiG=usyy=J=u59Up3XYpK4c9pJYQkX1Gby06Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 12:36:38PM -0800, Stefan Beller wrote:

> >  - In an if() block we enter when o->emitted_symbols is set, there
> >    is a check to see if o->color_moved is set.  This makes sense
> >    only if we are trying to be prepared to handle a case where we
> >    are not the one that assigned a non-NULL to o->emitted_symbols
> >    due to o->color_moved.  So it certainly is possible that
> >    o->emitted_symbols is set before we enter this function.
> 
> Ah I see where you are coming from, as the code was written
> I imagined:
> 
>     if (o->color_moved)
>         o->emitted_symbols = &esm;
>     if (o->distim_gostaks)
>         o->emitted_symbols = &esm;
> 
>     if (o->emitted_symbols) {
>          if (o->color_moved)
>             handle_color_moved(o);
>         if (o->distim_gostaks)
>             handle_distimming(o);
> 
>         ... flush symbols...
>         ... free &cleanup ...
>     }

Yeah, FWIW this is what I took to be the reason for the code being laid
out as it is.

> >  - But then, it means that o->emitted_symbols we may have had
> >    non-NULL when the function is called may be overwritten if
> >    o->color_moved is set.
> 
> I see. So either we'd want to have
> 
>     if (o->emitted_symbols)
>         BUG("should not be already set");
> 
> or as Peff points out, make it non-static.

Even if it's non-static, you'd still want to ensure that it's not set
coming into the function (because somebody like diff-words might have
left it set, confusing us). So I think that BUG() may be worth having
either way.

-Peff
