Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB80C77B70
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 07:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDNHaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 03:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNHai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 03:30:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC78E
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 00:30:36 -0700 (PDT)
Received: (qmail 12481 invoked by uid 109); 14 Apr 2023 07:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 07:30:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25232 invoked by uid 111); 14 Apr 2023 07:30:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 03:30:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 03:30:35 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <20230414073035.GB540206@coredump.intra.peff.net>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
 <ZDIUvK/bF7BFqX5q@nand.local>
 <CAOLTT8RbU6G67BtE9fSv4gEn10dtR7cT-jf+dcEfhvNhvcwETQ@mail.gmail.com>
 <20230410201414.GC104097@coredump.intra.peff.net>
 <CAOLTT8T9pJFr94acvUo-8EYriST1gOAkXaDZBxHk54o=Zm5=Sg@mail.gmail.com>
 <20230412074309.GB1695531@coredump.intra.peff.net>
 <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8Rw796zxMYxg5+nx8+YoQVnfy=nPXH8Aq0j0Cw+GLT1rA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 05:57:02PM +0800, ZheNing Hu wrote:

> > It's not just metadata; it's actually part of what we hash to get the
> > object id (though of course it doesn't _have_ to be stored in a linear
> > buffer, as the pack storage shows).
> 
> I'm still puzzled why git calculated the object id based on {type, size, data}
>  together instead of just {data}?

You'd have to ask Linus for the original reasoning. ;)

But one nice thing about including these, especially the type, in the
hash, is that the object id gives the complete context for an object.
So if another object claims to point to a tree, say, and points to a blob
instead, we can detect that problem immediately.

Or worse, think about something like "git show 1234abcd". If the
metadata was not part of the object, then how would we know if you
wanted to show a commit, or a blob (that happens to look like a commit),
etc? That metadata could be carried outside the hash, but then it has to
be stored somewhere, and is subject to ending up mismatched to the
contents. Hashing all of it (including the size) makes consistency
checking much easier.

> > For packed object, it effectively is metadata, just stuck at the front
> > of the object contents, rather than in a separate table. That lets us
> > use the same .idx file for finding that metadata as we do for the
> > contents themselves (at the slight cost that if you're _just_ accessing
> > metadata, the results are sparser within the file, which has worse
> > behavior for cold-cache disks).
> 
> Agree. But what if there is a metadata table in the .idx file?
> We can even know the type and size of the object without accessing
> the packfile.

I'm not sure it would be any faster than accessing the packfile. If you
stick the metadata in the .idx file's oid lookup table, then lookups
perform a bit worse because you're wasting memory cache. If you make a
separate table in the .idx file that's OK, but I'm not sure it's
consistently better than finding the data in the packfile.

The oid lookup table gives you a way to index the table in
constant-time (if you store the table as fixed-size entries in sha1
order), but we can also access the packfile in constant-time (the idx
table gives us offsets). The idx metadata table would have better cache
behavior if you're only looking at metadata, and not contents. But
otherwise it's worse (since you have to hit the packfile, too). And I
cheated a bit to say "fixed-size" above; the packfile metadata is in a
variable-length encoding, so in some ways it's more efficient.

So I doubt it would make any operations appreciably faster, and even if
it did, you'd possibly be trading off versus other operations. I think
the more interesting metadata is not type/size, but properties such as
those stored by the commit graph. And there we do have separate tables
for fast access (and it's a _lot_ faster, because it's helping us avoid
inflating the object contents).

> > I'm not sure how much of a speedup it would yield in practice, though.
> > If you're printing the object contents, then the extra lookup is
> > probably not that expensive by comparison.
> >
> 
> I feel like this solution may not be feasible. After we get the type and size
> for the first time, we go through different output processes for different types
> of objects: use `stream_blob()` for blobs, and `read_object_file()` with
> `batch_write()` for other objects. If we obtain the content of a blob in one
> single read operation, then the performance optimization provided by
> `stream_blob()` would be invalidated.

Good point. So yeah, even to use it in today's code you'd need something
conditional. A few years ago I played with an option for object_info
that would let the caller say "please give me the object contents if
they are smaller than N bytes, otherwise don't".

And that would let many call-sites get type, size, and content together
most of the time (for small objects), and then stream only when
necessary. I still have the patches, and running them now it looks like
there's about a 10% speedup running:

  git cat-file --unordered --batch-all-objects --batch >/dev/null

Other code paths dealing with blobs would likewise get a small speedup,
I'd think. I don't remember why I didn't send it. I think there was some
ugly refactoring that I needed to double-check, and my attention just
got pulled elsewhere. The messy patches are at:

  https://github.com/peff/git jk/object-info-round-trip

if you're interested.

-Peff
