Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 968B820248
	for <e@80x24.org>; Thu, 14 Mar 2019 18:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfCNS5O (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 14:57:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:51426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727399AbfCNS5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 14:57:14 -0400
Received: (qmail 31006 invoked by uid 109); 14 Mar 2019 18:57:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 18:57:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25522 invoked by uid 111); 14 Mar 2019 18:56:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 14:56:18 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 14:55:57 -0400
Date:   Thu, 14 Mar 2019 14:55:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] get_oid(): when an object was not found, try harder
Message-ID: <20190314185556.GA26250@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
 <xmqqa7hyckfm.fsf@gitster-ct.c.googlers.com>
 <20190314022245.GA1414@sigill.intra.peff.net>
 <20190314024023.GA3889@sigill.intra.peff.net>
 <xmqqzhpy9k40.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhpy9k40.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 01:05:03PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I'm not sure it's really worth addressing (just because I don't think
> > there's a good way to do it that isn't expensive).
> 
> I do not think so, either.  Not at this layer, anyway.
> 
> If a "-x" command newly created an object whose prefix makes it
> ambiguous against an existing object, we would not notice, unless we
> refresh the loose object cache, that we now have two objects that
> share the prefix.  And we will find an object (the older one) with
> the prefix in the stale cache without hitting "oh we do not find it,
> let's retry" codepath.  So to solve both sides of the coin, we'd
> need invalidation either way, which obviously defeats the whole
> caching concept, doesn't it?

Right, that was the conclusion I came to. You cannot solve it in all
cases without checking whether new objects have appeared for every
lookup.  I think that could be as cheap as a stat() on the pack
directory and one on the appropriate loose directory, but I suspect even
that might be measurably slower.

-Peff
