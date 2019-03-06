Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB1E20248
	for <e@80x24.org>; Wed,  6 Mar 2019 21:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCFV5y (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 16:57:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:41550 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725790AbfCFV5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 16:57:54 -0500
Received: (qmail 1192 invoked by uid 109); 6 Mar 2019 21:57:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 21:57:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17985 invoked by uid 111); 6 Mar 2019 21:58:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 16:58:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 16:57:52 -0500
Date:   Wed, 6 Mar 2019 16:57:52 -0500
From:   Jeff King <peff@peff.net>
To:     Fabio Aiuto <polinice83@libero.it>
Cc:     git@vger.kernel.org
Subject: Re: Can't build first git commit
Message-ID: <20190306215752.GC32630@sigill.intra.peff.net>
References: <1551729517.4092.1.camel@libero.it>
 <20190304204007.GA32691@sigill.intra.peff.net>
 <20190305191519.GA12791@sigill.intra.peff.net>
 <1551902320.1727.1.camel@libero.it>
 <20190306200356.GB23315@sigill.intra.peff.net>
 <1551905579.1727.8.camel@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551905579.1727.8.camel@libero.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 09:52:59PM +0100, Fabio Aiuto wrote:

> Found this error
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x00401628 in verify_hdr (hdr=0x0, size=32) at read-cache.c:192
> 192		if (hdr->signature != CACHE_SIGNATURE)
> 
> when tracing on line
> 
> static int verify_hdr(struct cache_header *hdr, unsigned long size)
> {
> 	SHA_CTX c;
> 	unsigned char sha1[20];
> 
> 	if (hdr->signature != CACHE_SIGNATURE)<--- this line
> 
> inside file read-cache.c
> What's going on?

Well, hdr is NULL, so you can't dereference it. Without knowing more
about how you called it, it's hard to say. But do note that the index
format has been updated once or twice (as well as the pack format). You
probably can't just chdir into a clone made by a recent Git and expect
ancient versions to read it.

You'll have to start a repo from scratch, or clone an existing with the
old version (which will be tricky; you might have to use a modern
upload-pack to represent the server side, but I think that first version
doesn't even have any fetch capabilities at all).

It might also be possible to convince modern Git to write out in old
formats that ancient Git will understand, but I don't know the right
config knobs to tweak offhand.

-Peff
