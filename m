Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0466B2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbdJCXgl (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:36:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:59764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750865AbdJCXgk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:36:40 -0400
Received: (qmail 26951 invoked by uid 109); 3 Oct 2017 23:36:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 23:36:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13010 invoked by uid 111); 3 Oct 2017 23:36:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 19:36:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 19:36:38 -0400
Date:   Tue, 3 Oct 2017 19:36:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Subject: Re: [PATCH 2/3] http-push: fix construction of hex value from path
Message-ID: <20171003233638.fq6lgls2qsucfbn3@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-3-t.gummerer@gmail.com>
 <20171003225315.GE19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003225315.GE19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 03:53:15PM -0700, Jonathan Nieder wrote:

> Thomas Gummerer wrote:
> 
> > The get_oid_hex_from_objpath takes care of creating a oid from a
> > pathname.  It does this by memcpy'ing the first two bytes of the path to
> > the "hex" string, then skipping the '/', and then copying the rest of the
> > path to the "hex" string.  Currently it fails to increase the pointer to
> > the hex string, so the second memcpy invocation just mashes over what
> > was copied in the first one, and leaves the last two bytes in the string
> > uninitialized.
> 
> Wow.  The fix is obviously correct.

Agreed. This is brown-paper-bag worthy. Thanks, Thomas, for cleaning up
my mess.

> I think the problem is that when it fails, we end up thinking that
> there are *fewer* objects than are actually present remotely so the
> only ill effect is pushing too much.  So this should be observable in
> server logs (i.e. it is testable) but it's not a catastrophic failure
> which means it's harder to test than it would be otherwise.

And thank you, Jonathan, for this analysis. I had also wondered how such
a frequently-triggered bug could have gone completely unnoticed, but
this explains it.

> Moreover, this is in the webdav-based "dumb http" push code path,
> which I do not trust much at all.  I wonder if we could retire it
> completely (or at least provide an option to turn it off).

I would really like that, too. It has been the cause of a lot of pain
when working with the smart code, and I am not at all surprised to find
a bug of this magnitude lurking in it. I'd _hoped_ this could show that
the system has been unusably broken for years, which would give us
confidence to turn it off. :) But per your paragraph above, people could
very easily still have been happily using it in the meantime.

-Peff
