Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F90C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 07:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjDLHnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLHnM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 03:43:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC9FE
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 00:43:11 -0700 (PDT)
Received: (qmail 18478 invoked by uid 109); 12 Apr 2023 07:43:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 07:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17567 invoked by uid 111); 12 Apr 2023 07:43:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 03:43:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 03:43:09 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <20230412074309.GB1695531@coredump.intra.peff.net>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
 <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net>
 <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 10:09:33PM +0800, ZheNing Hu wrote:

> > So reducing the size of the actual --batch printing may make the
> > relative cost of using multiple processes much higher (I didn't apply
> > your --type-filter patches to test myself).
> >
> 
> You are right. Adding the --unordered option can avoid the
> time-consuming sorting process from affecting the test results.

Just to be clear: it's not the cost of sorting, but rather that
accessing the object contents in a sub-optimal order is much worse (and
that sub-optimal order happens to be "sorted by sha1", since that is
effectively random with respect to the contents).

> time git cat-file --unordered --batch-all-objects \
> --batch-check="%(objectname) %(objecttype)" | \
> awk '{ if ($2 == "blob") print $1 }' | git cat-file --batch > /dev/null
> 
> 4.17s user 0.23s system 109% cpu 4.025 total
> 
> time git cat-file --unordered --batch-all-objects --batch
> --type-filter=blob >/dev/null
> 
> 3.84s user 0.17s system 97% cpu 4.099 total
> 
> It looks like the difference is not significant either.

OK, good, that means we can probably not worry about it. :)

> > In general, I do think having a processing pipeline like this is OK, as
> > it's pretty flexible. But especially for smaller queries (even ones that
> > don't ask for the whole object contents), the per-object lookup costs
> > can start to dominate (especially in a repository that hasn't been
> > recently packed). Right now, even your "--batch --type-filter" example
> > is probably making at least two lookups per object, because we don't
> > have a way to open a "handle" to an object to check its type, and then
> > extract the contents conditionally. And of course with multiple
> > processes, we're naturally doing a separate lookup in each one.
> >
> 
> Yes, the type of the object is encapsulated in the header of the loose
> object file or the object entry header of the pack file. We have to read
> it to get the object type. This may be a lingering question I have had:
> why does git put the type/size in the file data instead of storing it as some
> kind of metadata elsewhere?

It's not just metadata; it's actually part of what we hash to get the
object id (though of course it doesn't _have_ to be stored in a linear
buffer, as the pack storage shows). But for loose objects, where would
such metadata be? And accessing it isn't too expensive; we only zlib
inflate the first few bytes (the main cost is in the syscalls to find
and open the file).

For packed object, it effectively is metadata, just stuck at the front
of the object contents, rather than in a separate table. That lets us
use the same .idx file for finding that metadata as we do for the
contents themselves (at the slight cost that if you're _just_ accessing
metadata, the results are sparser within the file, which has worse
behavior for cold-cache disks).

But when I say that lookup costs dominate, what I mean is that we'd
spend a lot of our time binary searching within the pack .idx file, or
falling back to syscalls to look for loose objects.

> > So a nice thing about being able to do the filtering in one process is
> > that we could _eventually_ do it all with one object lookup. But I'd
> > probably wait on adding something like --type-filter until we have an
> > internal single-lookup API, and then we could time it to see how much
> > speedup we can get.
> 
> I am highly skeptical of this "internal single-lookup API". Do we really
> need an extra metadata table to record all objects?
> Something like: metadata: {oid: type, size}?

No, I don't mean changing the storage at all. I mean that rather than
doing this:

  /* get type, size, etc, for --batch format */
  type = oid_object_info(&oid, &size);

  /* now get the contents for --batch to write them itself; but note
   * that this searches for the entry again within all packs, etc */
  contents = read_object_file(oid, &type, &size);

as the cat-file code now does (because the first call is in
batch_object_write(), and the latter in print_object_or_die()), they
could be a single call that does the lookup once.

We could actually do that today, since the object contents are
eventually fed from oid_object_info_extended(), and we know ahead of
time that we want both the metadata and the contents. But that wouldn't
work if we filtered by type, etc.

I'm not sure how much of a speedup it would yield in practice, though.
If you're printing the object contents, then the extra lookup is
probably not that expensive by comparison.

-Peff
