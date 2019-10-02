Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E211F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 16:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfJBQDx (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 12:03:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:38100 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725799AbfJBQDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 12:03:53 -0400
Received: (qmail 25169 invoked by uid 109); 2 Oct 2019 16:03:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Oct 2019 16:03:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23038 invoked by uid 111); 2 Oct 2019 16:06:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2019 12:06:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Oct 2019 12:03:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
Message-ID: <20191002160351.GE6116@sigill.intra.peff.net>
References: <20190905070153.GE21450@sigill.intra.peff.net>
 <20190905183926.137490-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905183926.137490-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 11:39:26AM -0700, Jonathan Tan wrote:

> > I'm not really opposed to what you're doing here, but I did recently
> > think of another possible use for .promisor files. So it seems like a
> > good time to bring it up, since presumably we'd have to choose one or
> > the other.
> 
> Thanks for bringing it up - yes, we should discuss this.

Sorry for starting a discussion and then abandoning it. :)

> > I know one of the original design features of the promisor pack was that
> > the client would _not_ keep a list of all of the objects it didn't have.
> > But I wonder if it would make sense to keep a cache of these "cut
> > points" in the partial clone. That's potentially smaller than the
> > complete set of objects (especially for tree-based partial cloning), and
> > it seems clear we're willing to store it in memory anyway.
> 
> Well, before the current design was implemented, I had a design that had
> such a list of missing objects. :-) I couldn't find a writeup, but here
> is some preliminary code [1]. In that code, as far as I can tell, the
> server gives us the list directly during fetch and the client merges it
> with a repository-wide file called $GIT_DIR/objects/promisedblob, but we
> don't have to follow the design (we could lazily generate the file, have
> per-packfile promisedblob files, etc.).
> 
> [1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

This was also a feature of my very old "external odb" patches. In fact,
there the server told the client the type and size, which let us easily
know that many objects weren't worth fetching (e.g., a large blob would
be marked as binary and skipped for diffing, without the diff code even
having to care about "is it a promisor object that we don't have?").

For just omitting some blobs, I think that carrying extra information
(either just the set of blobs, or even some basic meta-information) is
valuable. But for "narrow" or "cone" clones, the current system of
implied promisors is pretty nice, because then the client effort
literally does (or could) scale with the size of their cone, independent
of the number of objects outside their cone.

> > And if we do that, would the .promisor file for a pack be a good place
> > to store it?
> 
> After looking at [1], it might be better in another place. If we want to
> preserve fast fetches, we still need another file to indicate that the
> pack is a promisor, so ".promisor" seems good for that. The presence or
> absence of the cutoff points is a separate issue and could go into a
> separate file, and it might be worth putting all cutoff points into a
> single per-repository file too.

OK, that makes sense. Thanks for giving it some thought.

-Peff
