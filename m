Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F72FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 08:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKAI3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 04:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKAI2r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 04:28:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C211461
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 01:28:27 -0700 (PDT)
Received: (qmail 5300 invoked by uid 109); 1 Nov 2022 08:28:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 08:28:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20799 invoked by uid 111); 1 Nov 2022 08:28:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 04:28:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 04:28:25 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2DYqZRlO7emYu8/@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <Y17L0IjELU5QlOPL@nand.local>
 <Y1/fm1prlAs3U1NE@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1/fm1prlAs3U1NE@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 03:45:47PM +0100, Patrick Steinhardt wrote:

> Indeed, I'm not trying to say that this can lead to repository
> corruption. If at all you can argue that this is more security-related.
> Suppose an object is not reachable from any public reference and that
> `allowAnySHA1InWant=false`. Then you could make these hidden objects
> reachable by sending a packfile with an object that references the
> hidden object. It naturally requires you to somehow know about the
> object ID, so I don't think this is a critical issue.

I'd have to double check, but isn't this all moot with the v2 protocol
anyway? I didn't think it even respected allowAnySHA1InWant.

Even that aside, there are other tricks you can do. E.g., pushing up an
object which claims to be a delta of X (though you have the trick then
of figuring out how to reference it), or pushing up a test object then
fetching it back while claiming to have X, treating the server as an
oracle which may give you a delta against X.

In short, I don't think it's worth considering unreachable objects in a
repository to be considered secret.

> > Why do we see a slowdown when there there aren't any hidden references?
> > Or am I misunderstanding your patch message which instead means "we see
> > a slow-down when there are no hidden references [since we still must
> > store and enumerate all advertised references]"?
> 
> I have tried to dig down into the code of `revision.c` but ultimately
> returned empty-handed. I _think_ that this is because of the different
> paths we use when reading revisions from stdin as we have to resolve the
> revision to an OID first, which is more involved than taking the OIDs as
> returned by the reference backend. I have tried to short-circuit this
> logic in case the revision read from stdin is exactly `hash_algo->hexsz`
> long so that we try to parse it as an OID directly instead of trying to
> do any of the magic that is required to resolve a revision. But this
> only speed things up by a small margin.
> 
> Another assumption was that this is overhead caused by using stdin
> instead of reading data from a file, but flame graphs didn't support
> this theory, either.

Certainly read_revisions_from_stdin() will allocate a bunch of extra
data per item it reads (via add_rev_cmdline() and add_pending), which is
going to be way more than parsing or stdin overhead.

Much worse is that it will call get_reference(), which is very keen to
actually open and parse the object (as you know, since you added
commit-graph handling there). That might have gotten a bit better in
v2.38.0 if you have any references to blobs (as we'd now skip the extra
hash check).

Of course the original "rev-list --not --all" would suffer from the same
thing, so some of that may not explain any difference between the two.

-Peff
