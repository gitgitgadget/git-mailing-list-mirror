Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92082C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 04:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiI1ESQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 00:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI1ESP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 00:18:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432671ED6F3
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 21:18:14 -0700 (PDT)
Received: (qmail 3188 invoked by uid 109); 28 Sep 2022 04:18:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Sep 2022 04:18:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25709 invoked by uid 111); 28 Sep 2022 04:18:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Sep 2022 00:18:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 28 Sep 2022 00:18:12 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: vd/fix-unaligned-read-index-v4, was Re: What's cooking in git.git
 (Sep 2022, #08; Tue, 27)
Message-ID: <YzPLBN09zzlTdNgc@coredump.intra.peff.net>
References: <xmqqtu4s1q1m.fsf@gitster.g>
 <be8f11f2-c4ad-0542-066b-3bbc99a16dae@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be8f11f2-c4ad-0542-066b-3bbc99a16dae@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 06:52:02PM -0700, Victoria Dye wrote:

> Junio C Hamano wrote:
> > * vd/fix-unaligned-read-index-v4 (2022-09-23) 1 commit
> >  - read-cache: avoid misaligned reads in index v4
> > 
> >  The codepath that reads from the index v4 had unaligned memory
> >  accesses, which has been corrected.
> > 
> >  Expecting a reroll.
> >  cf. <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
> >  cf. <bb3a2470-7ff5-e4a6-040a-96e0e3833978@gmail.com>
> >  source: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
> > 
> 
> How drastic an update were you expecting for this re-roll? To keep the fix
> minimal (that is, focused on 'create_from_disk()'), I was planning to just
> add some comments explaining the implementation (in response to [1]). If the
> goal is to get this merged quickly, I'd want to avoid a larger refactor
> (suggested in [2] & [3]), since doing so would either make the
> implementations of "read from disk" ('create_from_disk()') and "write to
> disk" ('copy_cache_entry_to_ondisk()') different/difficult to compare, or
> would involve a more invasive refactor to update both functions [4].

The first "cf" there is my initial request for a v2, but I since
retracted that. I have no objection to adding more comments, but I am
happy enough without them (like Junio, it may be that I'm overly
familiar with how I expect our get_be() functions to handle alignment).

I think even if we want to go further in the near term, it is still best
to build it on top of your basic fix. And we can take that fix and make
further refactoring (if any) its own topic.

I don't think even that basic fix needs to happen before the release,
though.  While it is a slight regression that SANITIZE=undefined does
not pass in the 2.38 release candidates:

  - the bug really was there all along. It's just that a new test
    triggers it.

  - I don't think it's a sign of actual problems; we are forming an
    unaligned pointer via a funny cast, which is technically UB, but I
    don't think any real-world platforms actually care, since we
    dereference it only via get_be16().

So it's mostly just a minor annoyance for running the tests; we're
probably better not to change any code, even trivially, this late in the
release cycle.

I was going to point to my branch with commits that are slightly less
rough than what I posted, for somebody to work on it later if
interested. But after applying a minimal amount of polish, I think they
are pretty reasonable, so I'll actually share them here.

IMHO it would be OK to proceed with them even if we don't redo the
writing side. But I can see the argument that they should come together.

I'm also OK if we just drop it. It was a fun puzzle to make it all work,
and I do like the result. But arguably it's just churn, and in
particular I haven't measured the re-ordering patch to see if it
produces a performance difference. I doubt it does, but it's important
enough that we should get a clear answer.

So here are my refactoring patches for the read side, built on top of
your earlier patch. They resolve the "yuck" comment by storing and
copying individual fields (which is much less verbose than you'd think
because of struct assignment). I left the pointer type as signed; there
are still come casts, but the same ones that were necessary before my
series.

  [1/3]: pack-bitmap: make read_be32() public
  [2/3]: read-cache: read on-disk entries in byte order
  [3/3]: read-cache: use read_be32() in create_from_disk()

 compat/bswap.h | 22 ++++++++++++++++++
 pack-bitmap.c  | 12 ----------
 read-cache.c   | 60 +++++++++++++++++++++++++-------------------------
 3 files changed, 52 insertions(+), 42 deletions(-)

-Peff
