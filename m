Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C9D2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbcIOSrn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:47:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:43829 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751098AbcIOSrm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:47:42 -0400
Received: (qmail 21802 invoked by uid 109); 15 Sep 2016 18:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 18:47:41 +0000
Received: (qmail 11087 invoked by uid 111); 15 Sep 2016 18:47:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 14:47:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 11:47:38 -0700
Date:   Thu, 15 Sep 2016 11:47:38 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] object: measure time needed for resolving hash collisions
Message-ID: <20160915184737.2vcarwyhdp7xl3mg@sigill.intra.peff.net>
References: <20160915020141.32000-1-sbeller@google.com>
 <20160915064701.c4ishixuynbzpgwx@sigill.intra.peff.net>
 <xmqq60pxoy4h.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60pxoy4h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 10:45:34AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Measuring _just_ the collisions is more like the patch below. In my
> > measurements it's more like 30ms, compared to 10s for all of the
> > hashcmps.
> >
> > So we really aren't dealing with collisions, but rather just verifying
> > that our hash landed at the right spot. And _any_ data structure is
> > going to have to do that.
> 
> The reverse side of the coin may be if we can shrink the hashtable
> smaller and load it more heavily without sacrificing performance by
> making the necessary "have we landed at the right spot" check cheap
> enough, I guess.

I think that's where things like cuckoo hashing come into play. They
didn't have any effect for us because we already keep the table very
unloaded. But you could _probably_ increase the load factor without
sacrificing performance using a more clever scheme.

It's not clear to me that the current table size is a big problem,
though. It might be hurting us with cache effects, but I think the only
way we'd know is to measure.

-Peff
