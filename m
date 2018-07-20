Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4738D1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbeGTUIT (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:08:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:54462 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388392AbeGTUIT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:08:19 -0400
Received: (qmail 1749 invoked by uid 109); 20 Jul 2018 19:18:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 19:18:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31364 invoked by uid 111); 20 Jul 2018 19:18:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 20 Jul 2018 15:18:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2018 15:18:40 -0400
Date:   Fri, 20 Jul 2018 15:18:40 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] fail compilation with strcpy
Message-ID: <20180720191839.GB26403@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <xmqqo9f1bupp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9f1bupp.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 11:58:10AM -0700, Junio C Hamano wrote:

> > Note that this needs to be applied on top of 022d2ac1f3 (blame: prefer
> > xsnprintf to strcpy for colors, 2018-07-13) or it will complain loudly. :)
> >
> >   [1/2]: introduce "banned function" list
> >   [2/2]: banned.h: mark strncpy as banned
> 
> Hmph, there is no use of any banned function in hex.c, but when
> this topic is merged to 'pu', I seem to get this:

Interesting. Builds fine for me even merged to the latest push-out of
pu. But...

> $ make DEVELOPER=1 hex.o
> GIT_VERSION = 2.18.0.758.g18f90b35b8
>     CC hex.o
> In file included from git-compat-util.h:1250:0,
>                  from cache.h:4,
>                  from hex.c:1:
> banned.h:14:0: error: "strncpy" redefined [-Werror]
>  #define strncpy(x,y,n) BANNED(strncpy)
>  
> In file included from /usr/include/string.h:630:0,
>                  from git-compat-util.h:165,
>                  from cache.h:4,
>                  from hex.c:1:
> /usr/include/x86_64-linux-gnu/bits/string2.h:84:0: note: this is the location of the previous definition
>  # define strncpy(dest, src, n) __builtin_strncpy (dest, src, n)

I suspect it has more to do with system/libc differences between our
machines, anyway. There was discussion elsewhere in the thread about the
need to #undef before redefining. I guess this answers that question.

I'll include that in the re-roll, and you can just ignore the v1 patches
I sent for now.

-Peff
