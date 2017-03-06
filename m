Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633721FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbdCFJKt (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:10:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:39013 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752751AbdCFJKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:10:46 -0500
Received: (qmail 23283 invoked by uid 109); 6 Mar 2017 08:43:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 08:43:55 +0000
Received: (qmail 14928 invoked by uid 111); 6 Mar 2017 08:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 03:44:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Mar 2017 03:43:53 -0500
Date:   Mon, 6 Mar 2017 03:43:53 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bmwill@google.com,
        jonathantanmy@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: Another proposed hash function transition plan
Message-ID: <20170306084353.nrns455dvkdsfgo5@sigill.intra.peff.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304011251.GA26789@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 05:12:51PM -0800, Jonathan Nieder wrote:

> This past week we came up with this idea for what a transition to a new
> hash function for Git would look like.  I'd be interested in your
> thoughts (especially if you can make them as comments on the document,
> which makes it easier to address them and update the document).

Overall it's an interesting idea. I thought at first that you were
suggesting servers do on-the-fly conversion, but after a more careful
reading that isn't the case. And I don't think that would work, because
the conversion is expensive.

So this pushes the conversion cost onto the clients who decide to move
to SHA-256. That may be a problem for sites which have a lot of clients
(like CI hosts). But I guess they would just stick with SHA-1 as long as
possible, until the upstream repo switches (and that _is_ a per-repo
flag day, because the upstream host isn't going to convert back to SHA-1
on the fly to serve the old clients).

> You can use the doc URL
> 
>  https://goo.gl/gh2Mzc

I'd encourage anybody following along to follow that link. I almost
didn't, but there are a ton of comments there (I'm not sure how I feel
about splitting the discussion off the list, though).

> Goals
> -----
> 1. The transition to SHA256 can be done one local repository at a time.
>    a. Requiring no action by any other party.
>    b. A SHA256 repository can communicate with SHA-1 Git servers and
>       clients (push/fetch).
>    c. Users can use SHA-1 and SHA256 identifiers for objects
>       interchangeably.
>    d. New signed objects make use of a stronger hash function than
>       SHA-1 for their security guarantees.
> 2. Allow a complete transition away from SHA-1.
>    a. Local metadata for SHA-1 compatibility can be dropped in a
>       repository if compatibility with SHA-1 is no longer needed.

I suspect we'll never get away from keeping the mapping table. You'll
need at least the sha1->sha256 table if you want to look up names found
in historic commit messages, mailing list posts, etc.

And you'll need the sha256->sha1 table if you want to verify the gpg
signatures on old tags and commits. That might be something people are
willing to drop, though.

> After negotiation, the server sends a packfile containing the
> requested objects. We convert the packfile to SHA-256 format using the
> following steps:
> 
> 1. index-pack: inflate each object in the packfile and compute its
>    SHA-1. Objects can contain deltas in OBJ_REF_DELTA format against
>    objects the client has locally. These objects can be looked up using
>    the translation table and their sha1-content read as described above
>    to resolve the deltas.
> 2. topological sort: starting at the "want"s from the negotiation
>    phase, walk through objects in the pack and emit a list of them in
>    topologically sorted order. (This list only contains objects
>    reachable from the "wants". If the pack from the server contained
>    additional extraneous objects, then they will be discarded.)

I don't think we do this right now, but you can actually find the entry
(and exit) points of a pack during the index-pack step. Basically:

  1. Keep a hashmap of objects mentioned in the pack.

  2. When we process an object's content (i.e., compute its hash), also
     parse it for any object references. Add entries in the hashmap for
     any object mentioned this way. Mark the entry for the object we
     processed with a "HAVE" bit, and mark any referenced object with a
     "REF" bit.

  3. After processing all objects, anything with a "HAVE" but no "REF"
     is an entry point to the pack (i.e., something that we should have
     asked for with a want). Anything with a "REF" but not a "HAVE" is
     an exit point (i.e., an object that we are expected to already have
     in our repo).

     (I've thought about this before because we could possibly shortcut
     the connectivity check using the exit points. It's complicated by
     the fact that we don't assume the transitive presence of objects
     unless they are reachable).

I don't think using the "want"s as the entry points is unreasonable,
though. The server _shouldn't_ generally be sending us other cruft.

I do wonder if you might be able to omit the extra object-graph walk
from your step 2, if you could assign "depths" to each object during
step 1 instead of HAVE/REF bits. The trouble, of course, is that you're
not visiting the nodes in the right order (so given two trees, you're
not sure if one might eventually be a child of the other; how do you
assign their depths?). I have a feeling there's a proof that it's
impossible, but I might just not be clever enough.


Overall the basics of the conversion seem sound to me. The "nohash"
things seems more complicated than I think it ought to be, which
probably just means I'm missing something.  I left a few related
comments on the google doc, so I won't repeat them here.

-Peff
