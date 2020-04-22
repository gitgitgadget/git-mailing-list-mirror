Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FD4C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EAB20767
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgDVThA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:37:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:36340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725935AbgDVTg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:36:59 -0400
Received: (qmail 10083 invoked by uid 109); 22 Apr 2020 19:36:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 19:36:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1169 invoked by uid 111); 22 Apr 2020 19:48:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 15:48:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 15:36:58 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200422193658.GC558336@coredump.intra.peff.net>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
 <20200422154025.GA91734@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422154025.GA91734@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 08:40:25AM -0700, Jonathan Nieder wrote:

> I think this still suggests that we should go ahead and switch
> negotiation algorithms, both because it avoids this MAX_IN_VAIN and
> because it reduces the number of rounds needed to make progress.

I'd be happier about that if the other algorithm turned up the same pack
that v0 does. But it has twice as many objects.

It looks to me like v0 is just more aggressive about digging in the
history. That _does_ cost more rounds, but this example shows that
there's a benefit to doing so for real-world cases.

> I'd also be tempted to get rid of MAX_IN_VAIN.  If we're at the point
> of giving up, shouldn't we error out instead of having the server send
> a copy of the entirety of history?

How would you fetch in cases where the client and server legitimately
don't have any common commits?

You could add a flag to force it, but I don't know that you're really
making users any happier. Fetching the whole history is annoying, but
refusing to fetch at all is perhaps more so. From the user's perspective
either the full fetch is what they want, or Git is broken.

-Peff
