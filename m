Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D75C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8A420767
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDVTks (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:40:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:36352 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725961AbgDVTks (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:40:48 -0400
Received: (qmail 10129 invoked by uid 109); 22 Apr 2020 19:40:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 19:40:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1202 invoked by uid 111); 22 Apr 2020 19:51:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 15:51:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 15:40:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "fetch: default to protocol version 2"
Message-ID: <20200422194047.GD558336@coredump.intra.peff.net>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
 <20200422155047.GB91734@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422155047.GB91734@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 08:50:47AM -0700, Jonathan Nieder wrote:

> This reverts commit 684ceae32dae726c6a5c693b257b156926aba8b7.
> 
> Users fetching from linux-next and other kernel remotes are reporting
> that the limited ref advertisement causes negotiation to reach
> MAX_IN_VAIN, resulting in too-large fetches.

OK, now that we have data I think this strategy is reasonable.

That said, it will take a while to make it to a release, so we very well
may have brought v2 and v0 to parity in the meantime.

> > To get you unstuck, the immediate workaround is to drop back to the
> > older protocol, like:
> >
> >   git -c protocol.version=0 fetch --all
> 
> By the way, I'd recommend the immediate workaround of
> 
> 	git fetch --negotiation-tip=refs/remotes/xo/* xo
> 
> instead.  But that's a separate subject.

It seems like if we are fetching with refspec X/*:Y/* that we should
perhaps automatically select our local Y/* negotiation tips.

That said, neither it (nor the manual version above) would help the case
I've been testing with. It's a first fetch from "xo", which can reuse
history we already have from other remotes.

I agree it's a good workaround for folks doing their daily fetches,
though.

-Peff
