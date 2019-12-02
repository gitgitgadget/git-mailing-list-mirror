Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86D2C432C3
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F120718
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfLBOjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:39:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:36602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727386AbfLBOjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 09:39:45 -0500
Received: (qmail 30318 invoked by uid 109); 2 Dec 2019 14:39:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Dec 2019 14:39:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6382 invoked by uid 111); 2 Dec 2019 14:43:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2019 09:43:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Dec 2019 09:39:44 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org
Subject: Re: hashmap vs khash? Re: [PATCH] packfile.c: speed up loading lots
 of packfiles.
Message-ID: <20191202143944.GA18276@sigill.intra.peff.net>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191128004202.GA25910@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191128004202.GA25910@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 28, 2019 at 12:42:02AM +0000, Eric Wong wrote:

> > Add a hashmap containing the packfile names as we load them so that
> > the average runtime cost of checking for already-loaded packs becomes
> > constant.
> 
> Btw, would you have time to do a comparison against khash?
> 
> AFAIK hashmap predates khash in git; and hashmap was optimized
> for removal.   Removals don't seem to be a problem for pack
> loading.

Actually, they came around simultaneously. I think hashmap.[ch] was
mostly a response to our open-coded hashes, like the one in object.c
(which still uses neither of the reusable forms!). Those didn't handle
removal at all. khash does handle removal, though you pay a price in
tombstone entries until the next resize operation.

> I'm interested in exploring the removing of hashmap entirely in
> favor of khash to keep our codebase smaller and easier-to-learn.
> khash shows up more in other projects, and ought to have better
> cache-locality.

I have been tempted to push for that, too. Every timing I have ever done
shows khash as faster (though for a trivial use like this one, I would
be quite surprised if it mattered either way).

My hesitation is that khash can be harder to debug because of the macro
implementation. But I have rarely needed to look beneath its API.

-Peff
