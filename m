Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEFE1FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 19:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbdJXTEP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 15:04:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:34566 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751354AbdJXTEO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 15:04:14 -0400
Received: (qmail 28264 invoked by uid 109); 24 Oct 2017 19:04:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 19:04:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14555 invoked by uid 111); 24 Oct 2017 19:04:20 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Oct 2017 15:04:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Oct 2017 12:04:11 -0700
Date:   Tue, 24 Oct 2017 12:04:11 -0700
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: v2.15.0-rc2 ref deletion bug
Message-ID: <20171024190411.dvv7zsq6ax4nndti@sigill.intra.peff.net>
References: <20171024082409.smwsd6pla64jjlua@sigill.intra.peff.net>
 <ea715dae-b410-d4fb-77c7-2e61b764a343@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea715dae-b410-d4fb-77c7-2e61b764a343@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 01:05:00PM +0200, Michael Haggerty wrote:

> > I'd expect one of:
> > 
> >   1. We delete "foo" before updating "foo/bar", and we end up with a
> >      single ref.
> 
> I don't think that this is possible in the general case in a single
> transaction. The problem is that the code would need to take locks
> 
>     refs/tags/foo.lock
>     refs/tags/foo/bar.lock
> 
> But the latter couldn't coexist with the loose reference file
> 
>     refs/tags/foo
> 
> , which might already exist.

Yeah, you're right. I was thinking of the opposite case (where you
could create "foo.lock" even though "foo/bar" exists), but this one is
impossible with filesystem semantics.

> It is only imaginable to do this in a single transaction if you pack and
> prune `refs/tags/foo` first, to get the loose reference out of the way,
> before executing the transaction. Even then, you would have to beware of
> a race where another process writes a loose version of `refs/tags/foo`
> between the time that `pack-refs` prunes it and the time that the
> transaction obtains the lock again.

Yeah, it's probably better to avoid playing games here. Moving to a
non-filesystem storage backend would just make the problem go away.

-Peff
