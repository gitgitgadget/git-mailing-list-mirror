Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEC51F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 14:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbeKPBCS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 20:02:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:40632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388263AbeKPBCS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 20:02:18 -0500
Received: (qmail 4336 invoked by uid 109); 15 Nov 2018 14:54:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 14:54:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16384 invoked by uid 111); 15 Nov 2018 14:53:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 09:53:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 09:54:07 -0500
Date:   Thu, 15 Nov 2018 09:54:07 -0500
From:   Jeff King <peff@peff.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: approxidate woes
Message-ID: <20181115145407.GC16450@sigill.intra.peff.net>
References: <20181115134528.GA21242@inner.h.apk.li>
 <20181115144854.GB16450@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115144854.GB16450@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 09:48:54AM -0500, Jeff King wrote:

> I don't think "48h" does what you expect either:
> 
>   $ t/helper/test-date approxidate now
>   now -> 2018-11-15 14:43:32 +0000
> 
>   $ t/helper/test-date approxidate 48h
>   48h -> 2018-11-15 14:43:34 +0000
> 
>   $ t/helper/test-date approxidate 48.hours
>   48.hours -> 2018-11-13 14:43:38 +0000

Whoops, those should all be:

  t/helper/test-tool date approxidate ...

in recent versions of Git (I was bisecting something earlier, and has a
crufty test-date left over from an old version!).

Adding new unit aliases would be something like:

diff --git a/date.c b/date.c
index 9bc15df6f9..eb477d1601 100644
--- a/date.c
+++ b/date.c
@@ -1016,6 +1016,7 @@ static const struct typelen {
 	{ "minutes", 60 },
 	{ "hours", 60*60 },
 	{ "days", 24*60*60 },
+	{ "d", 24*60*60 },
 	{ "weeks", 7*24*60*60 },
 	{ NULL }
 };

but I suspect we need to tighten up the string matching a bit. I think
that would allow "2 dogs" to be parsed as "days".

-Peff
