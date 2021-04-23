Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178DDC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1024608FE
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241926AbhDWKCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:02:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:33176 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241890AbhDWKCn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 06:02:43 -0400
Received: (qmail 6163 invoked by uid 109); 23 Apr 2021 10:02:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 10:02:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6683 invoked by uid 111); 23 Apr 2021 10:02:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 06:02:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 06:02:05 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: Strategy to deal with slow cloners
Message-ID: <YIKbHWzxB5Q0Pe0E@coredump.intra.peff.net>
References: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419124623.wwps2s35x2mrrhi6@nitro.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 08:46:23AM -0400, Konstantin Ryabitsev wrote:

> I try to keep repositories routinely repacked and optimized for clones, in
> hopes that most operations needing lots of objects would be sending packs
> straight from disk. However, every now and again a client from a slow
> connection requests a large clone and then takes half a day downloading it,
> resulting in gigabytes of RAM being occupied by a temporary pack.
> 
> Are there any strategies to reduce RAM usage in such cases, other than
> vm.swappiness (which I'm not sure would work, since it's not a sleeping
> process)?


Do you know where the RAM is going? I.e., heap or mmap'd files in block
cache? Do you have recent reachability bitmaps built?

Traditionally, most of the heap usage in pack-objects went to:

  - the set of object structs used for traversal; likewise, internal
    caches like the delta-base cache that get filled during the
    traversal

  - the big book-keeping array of all of the objects we are planning to
    send (and all their metadata)

  - the reverse index we load in memory to find object offsets and
    sizes within the packfile

But with bitmaps, we can skip most of the traversal entirely. And
there's a "pack reuse" mechanism that tries to avoid even adding objects
to the book-keeping array when we are just sending the first chunk of
the pack verbatim anyway.

E.g., on a clone of torvalds/linux, running:

  git for-each-ref --format='%(objectname)' refs/heads/ refs/tags/ |
  valgrind --tool=massif git pack-objects --revs --delta-base-offset --stdout |
  wc -c

hits a peak heap of 1.9GB without bitmaps enabled but only 326MB with.

On top of that, if you have Git v2.31, try enabling pack.writeReverseIndex
and repacking. That drops the heap to just 23MB! (though note there's
some cheating here; we're mmap-ing 31MB of .rev file plus 47MB of
.bitmap file).

From previous conversations, I expect you're already using bitmaps, but
you might double-check that things are kicking in as you'd expect (you
can get a rough read on heap of running processes by subtracting shared
memory from rss). And probably you aren't using on-disk revindexes yet,
because they're not enabled by default.

If your problem is block cache (i.e., it's the total rss that's the
problem, not just the heap parts), that's harder. If you have a lot of
related repositories (say, forks of the kernel), your best bet is to use
alternates to share the storage. That opens up a whole other can of
complexity worms that I won't get into here.

Getting back to your other question:

> Is there a way to write large temporary packs somewhere to disk
> before sendfile'ing them?

The uploadpack.packObjectsHook config would let you wrap pack-objects
with a script that writes to a temporary file, and then just uses
something simple like "cat" to feed it back to upload-pack. You can't
use sendfile(), because there's some protocol framing that happens in
upload-pack, but its memory use is relatively low.

If block cache is your problem (and not heap), this _could_ make things
slightly worse, as now you're writing the same pack data out to an extra
file which isn't shared by multiple processes. So if you have multiple
clients hitting the same repository, you may increase your working set
size. The OS may be able to handle it better, though (e.g., the linear
read through the file by cat makes it obvious that it can drop pages
from earlier parts of the file under memory pressure).

Your wrapper of course can get more clever about such things, too. E.g.,
you can coalesce identical requests to use the same cached copy,
skipping even the extra call to pack-objects in the first place. We do
something like that at GitHub (unfortunately not with an open tool that
I can share at this point).

-Peff
