Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616DCC433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 19:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4731960FBF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 19:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhI0Tv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 15:51:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:55624 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235209AbhI0Tv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 15:51:26 -0400
Received: (qmail 7273 invoked by uid 109); 27 Sep 2021 19:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Sep 2021 19:49:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19171 invoked by uid 111); 27 Sep 2021 19:49:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Sep 2021 15:49:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Sep 2021 15:49:46 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 01/16] t7900: clean up some more broken refs
Message-ID: <YVIgWnsApPs35YUd@coredump.intra.peff.net>
References: <YU4Zse+dAeDg8RqV@coredump.intra.peff.net>
 <20210927173818.528679-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210927173818.528679-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 27, 2021 at 10:38:18AM -0700, Jonathan Tan wrote:

> > @@ -277,7 +277,7 @@ test_expect_success 'incremental-repack task' '
> >  
> >  	# Delete refs that have not been repacked in these packs.
> >  	git for-each-ref --format="delete %(refname)" \
> > -		refs/prefetch refs/tags >refs &&
> > +		refs/prefetch refs/tags refs/remotes >refs &&
> >  	git update-ref --stdin <refs &&
> >  
> >  	# Replace the object directory with this pack layout.
> > @@ -286,6 +286,10 @@ test_expect_success 'incremental-repack task' '
> >  	ls $packDir/*.pack >packs-before &&
> >  	test_line_count = 3 packs-before &&
> >  
> > +	# make sure we do not have any broken refs that were
> > +	# missed in the deletion above
> > +	git for-each-ref &&
> 
> For what it's worth, I verified that a fatal error is indeed caused in
> "git for-each-ref" if refs/remotes was not deleted. This patch looks
> good.

Me too. :) It works because for-each-ref's default format will try to
show the type of the object, so it complains when the object is missing.

We could make this "git fsck" if that's less subtle, but this is a bit
cheaper.

-Peff
