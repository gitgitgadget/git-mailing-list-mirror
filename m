Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB5C43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 02:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2685120796
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 02:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIGCXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 22:23:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:50180 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgIGCXl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 22:23:41 -0400
Received: (qmail 10253 invoked by uid 109); 7 Sep 2020 02:23:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Sep 2020 02:23:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12989 invoked by uid 111); 7 Sep 2020 02:23:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 06 Sep 2020 22:23:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 6 Sep 2020 22:23:40 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-bitmap-write: use hashwrite_be32() in
 write_hash_cache()
Message-ID: <20200907022340.GA1208024@coredump.intra.peff.net>
References: <1143b9e0-3adf-095f-78cf-2f8d8c2bd368@web.de>
 <20200906190235.GA6146@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200906190235.GA6146@nand.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 06, 2020 at 03:02:35PM -0400, Taylor Blau wrote:

> On Sun, Sep 06, 2020 at 10:59:06AM +0200, René Scharfe wrote:
> > -		uint32_t hash_value = htonl(entry->hash);
> > -		hashwrite(f, &hash_value, sizeof(hash_value));
> > +		hashwrite_be32(f, entry->hash);
> 
> This is an obviously correct translation of what's already written, and
> indeed it is shorter and easier to read.
> 
> Unfortunately, I think there is some more subtlety here since the hash
> cache isn't guarenteed to be aligned, and so blindly calling htonl()
> (either directly in write_hash_cache(), or indirectly in
> hashwrite_be32()) might cause tools like ASan to complain when loading
> data on architectures that don't support fast unaligned reads.

I think the alignment here is fine. We're just writing out an individual
value. So in the original entry->hash and our local hash_value are both
properly aligned, since they're declared as uint32_t. We pass the
pointer to hashwrite(), but it doesn't expect any particular alignment.
After the patch, the situation is the same, except that we're working
with the uint32_t parameter to hashwrite_be32(), which is also properly
aligned.

> So, I think that we could do one of three things, depending on how much
> you care about improving this case ;-).
> 
>   - leave your patch alone, accepting that this case which was broken
>     before will remain broken, and leave it as #leftoverbits

So I think this is what we should do. :)

>   - discard your patch as-is, and replace the 'htonl' with 'get_be32()'
>     before handing it off to 'hashwrite()', or

No need here; get_be32() is for when we're reading in from an unaligned
mmap.

>   - change the 'hashwrite_beXX()' implementations to use the correct
>     'get_beXX' wrappers which behave like htonl() on architectures with
>     fast unaligned loads, and fall back to byte reads and shifts on
>     architectures that don't.

Likewise, I don't think there's any reason to do this. hashwrite_be32()
gets its parameter as a value, not a pointer. So even if it were coming
from an unaligned mmap, it's actually the _caller_ who would have to
use get_be32() when passing it.

> Credit goes to Peff for finding this issue in GitHub's fork. For what
> it's worth, we were planning on sending those patches to the list soon,
> but they are tied up with a longer series in the meantime.

There is a bug in our fork, but I don't think it's upstream. The
relevant spot for the name-hash cache is in show_objects_for_type(),
which reads from the bitmap->hashes pointer (that points into our
unaligned mmap). But it does:

        if (bitmap_git->hashes)
                hash = get_be32(bitmap_git->hashes + entry->nr);

which is correct (using htonl() would not be). The bug is that in our
fork, we have a custom bit-cache extension[1] which does use htonl(),
and should be get_be32(). That's something we'll need to clean up when
we send those patches upstream.

-Peff

[1] For the curious, the point is it keep a cache of the bit position of
    each object, which lets us ask "is this object's bit set" without
    having to load the revindex. It's helpful for bitmap-optimizing some
    algorithms like "branch --contains", though I think we should
    re-evaluate how much it helps now that we have commit-graphs with
    generation numbers.
