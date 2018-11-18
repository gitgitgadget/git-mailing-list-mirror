Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2CF1F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 21:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeKSITx (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 03:19:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:43818 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726053AbeKSITw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 03:19:52 -0500
Received: (qmail 5418 invoked by uid 109); 18 Nov 2018 21:58:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 18 Nov 2018 21:58:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13112 invoked by uid 111); 18 Nov 2018 21:57:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 18 Nov 2018 16:57:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2018 16:58:20 -0500
Date:   Sun, 18 Nov 2018 16:58:20 -0500
From:   Jeff King <peff@peff.net>
To:     Sven Strickroth <email@cs-ware.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] msvc: Directly use MS version (_stricmp) of strcasecmp
Message-ID: <20181118215820.GA14514@sigill.intra.peff.net>
References: <ad85731f-2c47-f455-c9d3-d47a5fj1e29@cs-ware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad85731f-2c47-f455-c9d3-d47a5fj1e29@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 10:02:02PM +0100, Sven Strickroth wrote:

> This also removes an implicit conversion from size_t (unsigned) to int (signed).
> 
> _stricmp as well as _strnicmp are both available since VS2012.

Once upon a time we had problems with taking a function pointer of
strcasecmp (to use as a comparator with string_list), so I wondered if
that might be part of why it's defined the way it is.

But the current definition is already inline:

> -
> -static __inline int strcasecmp (const char *s1, const char *s2)
> -{
> -       int size1 = strlen(s1);
> -       int sisz2 = strlen(s2);
> -       return _strnicmp(s1, s2, sisz2 > size1 ? sisz2 : size1);
> -}
> +#define strcasecmp   _stricmp

And it seems we worked around this in de2f95ebed (mailmap: work around
implementations with pure inline strcasecmp, 2013-09-12). So I don't
think there is any blocker there.

(Though of course I have no idea on other portability questions around
_stricmp(); I'll leave that for Windows folks).

-Peff
