Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEB2C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiJUXm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJUXm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:42:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361372ADD2E
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:42:27 -0700 (PDT)
Received: (qmail 15029 invoked by uid 109); 21 Oct 2022 23:42:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 23:42:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18316 invoked by uid 111); 21 Oct 2022 23:42:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 19:42:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 19:42:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 2/4] repack: populate extension bits incrementally
Message-ID: <Y1MuYQSo7rb6WCE8@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MSkubbDBh0Ma1G@coredump.intra.peff.net>
 <Y1MpUHBQtq8uP5Uy@nand.local>
 <Y1MsdAgL8fdIRtxH@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1MsdAgL8fdIRtxH@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:34:13PM -0400, Jeff King wrote:

> On Fri, Oct 21, 2022 at 07:20:48PM -0400, Taylor Blau wrote:
> 
> > On Fri, Oct 21, 2022 at 05:43:46PM -0400, Jeff King wrote:
> > > There are two small problems with this:
> > >
> > >   - repack_promisor_objects() may have added entries to "names", and
> > >     already called populate_pack_exts() for them. This is mostly just
> > >     wasteful, as we'll stat() the filename with each possible extension,
> > >     get the same result, and just overwrite our bits. But it makes the
> > >     code flow confusing, and it will become a problem if we try to make
> > >     populate_pack_exts() do more things.
> > 
> > Hmm. I agree with you that repack_promisor_objects() calling
> > populate_pack_exts() itself is at best weird, and at worst wasteful.
> 
> I don't think it's weird, really. It is setting up the entries in the
> string-list completely when we add them, rather than annotating later.
> If there were some performance gain from doing them all at once, I could
> see it, but otherwise I like that it means the entries are always in a
> consistent state.

I think my original didn't explain my thinking very well. And its "two
small problems" is really a bit of a lie. It is really one small
problem, and a tweak I want in order to make a future patch work. :)

So here's what I wrote instead:

-- >8 --
There's one small problem with this. In repack_promisor_objects(), we
may add entries to "names" and call populate_pack_exts() for them.
Calling it again is mostly just wasteful, as we'll stat() the filename
with each possible extension, get the same result, and just overwrite
our bits.

So we could drop the call there, and leave the final loop to populate
all of the bits. But instead, this patch does the reverse: drops the
final loop, and teaches the other two sites to populate the bits as they
add entries.

This makes the code easier to reason about, as you never have to worry
about when the util field is valid; it is always valid for each entry.

It also serves my ulterior purpose: recording the generated filenames as
soon as possible will make it easier for a future patch to use them for
cleaning up from a failed operation.
-- >8 --

-Peff
