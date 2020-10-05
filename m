Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79156C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4025B2078E
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJEI6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:58:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:49452 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgJEI6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:58:16 -0400
Received: (qmail 31393 invoked by uid 109); 5 Oct 2020 08:58:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 08:58:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17603 invoked by uid 111); 5 Oct 2020 08:58:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 04:58:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 04:58:14 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] forbidding symlinked .gitattributes and .gitignore
Message-ID: <20201005085814.GG2862927@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005073202.GC1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005073202.GC1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 12:32:02AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > About 2 years ago as part of a security release we made it illegal to
> > have a symlinked .gitmodules file (refusing it both in the index and via
> > fsck). At the time we discussed (on the security list) outlawing
> > symlinks for other .git files in the same way, but we decided not to do
> > so as part of the security release, as it wasn't strictly necessary.
> >
> > We publicly revisited the topic in:
> >
> >   https://lore.kernel.org/git/20190114230902.GG162110@google.com/
> >
> > but there were a few fixes needed, and it got forgotten. So here it is
> > again, with those fixes:
> 
> Oh!  I'm excited --- at $DAYJOB we've been carrying that patch since
> then; I'll be happy to drop it. :)

Part of my ulterior motive is that we've been carrying a patch at GitHub
to pass O_NOFOLLOW when opening in-tree attributes and ignore files
(which we don't normally do on our servers, but do for things like
GitHub Pages). But I think O_NOFOLLOW isn't perfectly portable (despite
being in POSIX), and the patch is rather invasive.

I also looked at one point into preventing just out-of-tree symlinks.
That helps with out-of-repo reads, but it doesn't change the fact that
in-index reads of symlinks are broken. We _could_ change that with a lot
of work, but I don't think anybody cares enough about the feature to do
so.

-Peff
