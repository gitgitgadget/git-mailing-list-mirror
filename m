Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1149F1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 17:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbdEPRty (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 13:49:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:52852 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751645AbdEPRtx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 13:49:53 -0400
Received: (qmail 21220 invoked by uid 109); 16 May 2017 17:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 17:49:50 +0000
Received: (qmail 30680 invoked by uid 111); 16 May 2017 17:50:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 13:50:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 May 2017 13:49:48 -0400
Date:   Tue, 16 May 2017 13:49:48 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        pclouds@gmail.com, johannes.schindelin@gmx.de,
        David.Turner@twosigma.com
Subject: Re: [PATCH v1 2/5] Teach git to optionally utilize a file system
 monitor to speed up detecting new or changed files.
Message-ID: <20170516174948.arqbk533pihm6x46@sigill.intra.peff.net>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-3-benpeart@microsoft.com>
 <20170516002214.tlqkk4zrwdzcdjha@genre.crustytoothpaste.net>
 <20170516003414.yliltu5fsaudfhyu@sigill.intra.peff.net>
 <2d965a87-36da-23b4-4bc5-97de47f3d7f7@gmail.com>
 <29122818-71fb-5af9-59b1-03387f014151@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29122818-71fb-5af9-59b1-03387f014151@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 01:17:56PM -0400, Ben Peart wrote:

> > Thanks for the pointers.  I'll update this to use the existing get_be32
> > and have created a get_be64 and will use that for the last_update.
> 
> OK, now I'm confused as to the best path for adding a get_be64.  This one is
> trivial:
> 
> #define get_be64(p)	ntohll(*(uint64_t *)(p))
> 
> but should the unaligned version be:
> 
> #define get_be64(p)	( \
> 	(*((unsigned char *)(p) + 0) << 56) | \
> 	(*((unsigned char *)(p) + 1) << 48) | \
> 	(*((unsigned char *)(p) + 2) << 40) | \
> 	(*((unsigned char *)(p) + 3) << 32) | \
> 	(*((unsigned char *)(p) + 4) << 24) | \
> 	(*((unsigned char *)(p) + 5) << 16) | \
> 	(*((unsigned char *)(p) + 6) <<  8) | \
> 	(*((unsigned char *)(p) + 7) <<  0) )
> 
> or would it be better to do it like this:
> 
> #define get_be64(p)	( \
> 	((uint64_t)get_be32((unsigned char *)(p) + 0) << 32) | \
> 	((uint64_t)get_be32((unsigned char *)(p) + 4) <<  0)

I'd imagine the compiler would generate quite similar code between the
two, and the second is much shorter and easier to read, so I'd probably
prefer it.

> or with a static inline function like git_bswap64:

Try "git log -Sinline compat/bswap.h", which turns up the history of why
it went from a macro to an inline function.

The get_be macros are simple enough that they can remain as macros,
though I'd have no objection personally to them being inline functions.
I'd expect modern compilers to be able to optimize similarly, and it
removes the restriction that you can't call the macro with an argument
that has side effects.

-Peff
