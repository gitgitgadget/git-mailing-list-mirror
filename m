Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C47C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A37611EE
	for <git@archiver.kernel.org>; Mon, 17 May 2021 06:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhEQGdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 02:33:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:55988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhEQGdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 02:33:09 -0400
Received: (qmail 3902 invoked by uid 109); 17 May 2021 06:31:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 06:31:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25248 invoked by uid 111); 17 May 2021 06:31:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 02:31:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 02:31:50 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: "bad revision" fetch error when fetching missing objects from
 partial clones
Message-ID: <YKIN1hBR64MaC9DX@coredump.intra.peff.net>
References: <6422f505-29c4-bee9-e28c-b77dd831c246@gmail.com>
 <ba5a0574-c71c-709c-a13c-bf6d5981545c@jeffhostetler.com>
 <YJz4JTsFjTtL7mE2@coredump.intra.peff.net>
 <YJ0FL3zr/SnWN7t6@coredump.intra.peff.net>
 <YJ4mUJ+EEAnudI3G@coredump.intra.peff.net>
 <YKIHKjs7n3v4vwNt@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKIHKjs7n3v4vwNt@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 08:03:22AM +0200, Patrick Steinhardt wrote:

> > If this is supposed to work, I think we need to teach the traversal code
> > to "add back" all of the objects that were explicitly given when a
> > filter is in use (either explicitly, or perhaps just clearing or
> > avoiding the UNINTERESTING flag on user-given objects in the first
> > place). And my earlier patch does that for the bitmap side, but not the
> > regular traversal.
> 
> I think adding these objects back in after computations is the easiest
> thing we can do here. For bitmaps, it should be relatively easy to do.
> The only thing I wonder about in your patch is whether we should really
> do this in a specific filter, or if we can't just do it at the end after
> all filters have been computed.

We definitely should do it at the end for all filters; my patch was just
illustrating the fix for this specific problem. It was actually while
cleaning it up to work on all filters that I dug further and found the
non-bitmap behavior.

> For the traversal-based code, it feels like the current design with the
> `NOT_USER_GIVEN` flag is making this harder than necessary. I really
> wonder whether we should again refactor the code to use a positive
> `USER_GIVEN` flag again: it's much more explicit, there's only one site
> where we need to add it and ultimately it's a lot easier to reason
> about. Furthermore, we can easily avoid marking such an object as
> `UNINTERESTING` if we see that it was explicitly added to the set while
> still marking its referenced objects as `UNINTERESTING` if need be.

That's my gut feeling, too. But I'm a little afraid that it would be
opening up a can of worms that we attempted to fix with 99c9aa9579
(revision: mark non-user-given objects instead, 2018-10-05) in the first
place.

For the purposes of this particular fix, though, we might be able to
skip this question either way with the "add back in" strategy. The
objects found in revs->pending right before prepare_revision_walk() make
up the "user given" list, so we could possibly just make us of that
(possibly stashing it away as necessary).

Thanks for the response. I'll be curious to hear the thoughts of folks
with Jonathan Tan who were involved in the original partial-clone design
(i.e., is this behavior of filters a surprise to them, or just a subtle
corner of the initial design).

-Peff
