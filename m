Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B0C18E5B
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460EB20674
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 17:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbgCPR1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:27:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:41054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731809AbgCPR1b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 13:27:31 -0400
Received: (qmail 22856 invoked by uid 109); 16 Mar 2020 17:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Mar 2020 17:27:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31968 invoked by uid 111); 16 Mar 2020 17:37:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Mar 2020 13:37:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Mar 2020 13:27:29 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Andreas Krey <a.krey@gmx.de>, git@vger.kernel.org
Subject: Re: Avoid race condition between fetch and repack/gc?
Message-ID: <20200316172729.GA1072073@coredump.intra.peff.net>
References: <20200316082348.GA26581@inner.h.apk.li>
 <759f4b3b-28a7-c002-ae51-5991bf9ad211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <759f4b3b-28a7-c002-ae51-5991bf9ad211@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 16, 2020 at 08:10:56AM -0400, Derrick Stolee wrote:

> > | error: git upload-pack: git-pack-objects died with error.
> > | fatal: git upload-pack: aborting due to possible repository corruption on the remote side.
> > | remote: aborting due to possible repository corruption on the remote side.
> > | fatal: protocol error: bad pack header
> > 
> > and when you look in the server repository there is a new packfile dated just around
> > that time. It looks like the fetch tries to access a packfile that it assumes to exist,
> > but the GC on the server throws it away just in that moment, and thus upload-pack fails.
> 
> ...your intuition about repacking seems accurate. The important part of the
> race condition is likely that the server process read and holds a read handle
> on the .idx file, but when looking for the object contents it tries to open
> the .pack file which was deleted.
>
> This error is emitted by use_pack() in packfile.c. I'm surprised there is no
> fallback here, and we simply die().

Yes, you're correct this is what's going on, but there's some more
subtlety (see below).

The issue is that by the time we get to use_pack(), it's generally too
late; we've committed to use this particular packed representation of
the object, and it would be very hard to back out of it.

There are really two cases worth considering independently: normal
access of objects via read_object_file(), oid_object_info(), etc versus
pack-objects.

In the normal code paths, contrary to what you wrote here:

> The race condition seems to be related to the loop in do_oid_object_info_extended()
> in sha1-file.c looping through packs until finding the object in question: it does
> not verify that the .pack file is open with a valid handle before terminating the
> loop and calling packed_object_info().
>
> Perhaps the fix is to update do_oid_object_info_extended() to "accept" a pack as
> the home of the object only after verifying the pack is either open or can be
> opened. That seems like the least-invasive fix to me.

we do make sure we have an open handle to the pack. This happens in
fill_pack_entry(), which does:

          /*
           * We are about to tell the caller where they can locate the
           * requested object.  We better make sure the packfile is
           * still here and can be accessed before supplying that
           * answer, as it may have been deleted since the index was
           * loaded!
           */
          if (!is_pack_valid(p))
                  return 0;

And is_pack_valid() not only checks the pack, but leaves open either the
descriptor or our mmap'd handle.

So in do_oid_object_info_extended(), we call fill_pack_entry() and we
won't consider the object available unless we have a handle open to the
pack. And since nobody else is manipulating the handles in between
(because any multi-threaded locking is much coarser than this), it
should be race-proof.

But pack-objects is not so lucky. Because it wants to look at intimate
details of the packed objects (e.g., reusing on-disk deltas or
zlib-deflated contents), it stores away the packfile/offset pair for
objects during the "Counting" phase and then uses it much later in the
"Writing" phase.

So it's possible for other lookups in the meantime to cause us to drop
our descriptor or mmap handle, and then later we find we can't re-open
it. But in practice, this shouldn't happen as long as:

  - you have a reasonable number of packs compared to your file
    descriptor limit

  - you don't use config like core.packedGitLimit that encourages Git to
    drop mmap'd windows. On 64-bit systems, this doesn't help at all (we
    have plenty of address space, and since the maps are read-only, the
    OS is free to drop the clean pages if there's memory pressure). On
    32-bit systems, it's a necessity (and I'd expect a 32-bit server to
    run into this issue a lot for large repositories).

We used to see this quite a lot at GitHub, but hardly at all since
4c08018204 (pack-objects: protect against disappearing packs,
2011-10-14), which made sure that pack-objects does the same
is_pack_valid() check. The only time we see it now are degenerate pack
cases (e.g., we accidentally hit a state with 20,000 packs or
something). It's possible there's been a regression recently, though.
Our version right now is based on v2.24.1.

> The "git multi-pack-index (expire|repack)" cycle is built to prevent this sort
> of issue, but is not yet integrated well with reachability bitmaps. You likely
> require the bitmaps to keep your server performance, so that may not be a way
> forward for you.

I wondered if the midx code might suffer from a race by missing out on
the is_pack_valid() check that fill_pack_entry() does. But it's right
there (including the copied comment!) in nth_midxed_pack_entry(). So
they should behave the same.

-Peff
