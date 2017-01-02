Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A00A7205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 17:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933703AbdABRJL (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 12:09:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:34301 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933272AbdABRJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 12:09:10 -0500
Received: (qmail 20785 invoked by uid 109); 2 Jan 2017 17:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 17:09:04 +0000
Received: (qmail 18196 invoked by uid 111); 2 Jan 2017 17:09:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Jan 2017 12:09:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jan 2017 12:09:02 -0500
Date:   Mon, 2 Jan 2017 12:09:02 -0500
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 14/17] sha1_file: introduce an nth_packed_object_oid
 function
Message-ID: <20170102170902.6g6bxvaanewxzm2v@sigill.intra.peff.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
 <20170101191847.564741-15-sandals@crustytoothpaste.net>
 <8c205558-928d-42ac-d401-e73e19c96030@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c205558-928d-42ac-d401-e73e19c96030@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 02, 2017 at 04:30:21PM +0100, Michael Haggerty wrote:

> On 01/01/2017 08:18 PM, brian m. carlson wrote:
> > There are places in the code where we would like to provide a struct
> > object_id *, yet read the hash directly from the pack.  Provide an
> > nth_packed_object_oid function that mirrors the nth_packed_object_sha1
> > function.
> > 
> > The required cast is questionable, but should be safe on all known
> > platforms.  The alternative of allocating an object as an intermediate
> > would be too inefficient and cause memory leaks.  If necessary, an
> > intermediate union could be used; this practice is allowed by GCC and
> > explicitly sanctioned by C11.  However, such a change will likely not be
> > necessary, and can be made if and when it is.
> 
> I have the feeling that this design decision has been discussed on the
> mailing list. If so, could you include a URL here?

I don't recall an explicit discussion, but I think we already do this
for similar reasons in decode_tree_entry(), where we point to the sha1s
embedded in the tree buffer (of course, you may argue that the cast
there is gross, too :) ).

I'm actually not sure how bad this cast is by the C standard. Conversion
between a struct and its first member is pretty common, and the
alignment is guaranteed by the standard. I think it probably breaks
strict aliasing rules, but then so does "struct object". This is
slightly more exotic in that it's not a struct-to-struct cast, and I
could believe that compilers treat those specially.

> The obvious alternative to allocating a new object to return to the
> caller would be to have the caller of `nth_packed_object_oid()` pass a
> `struct object_id *` argument to be filled in (by copying the hash into
> it). Aside from being legal C, this would also be a more robust step
> towards a post-SHA-1 world, where the suggested hack wouldn't work.
> 
> Of course, the question is what the callers want to do with the
> `object_id`. Are the return values of `nth_packed_object_sha1()` stored
> to other longer-lived structures that rely on the lifetime of the
> packfile mmap to keep the value valid? If so, then keeping track of the
> lifetime of the `struct object_id` could be a big chore, not to mention
> that needing to keep a 20-byte `struct object_id` around rather than a
> 8- or 4-byte pointer would also cost more RAM.

I agree that in general, copying the values out is a safer and saner
interface. There are definitely lifetime and memory-use issues to
consider (e.g., the loop in verify_packfile()). And I'd have a slight
worry that the performance impact might be noticeable, just because this
is really quite a low-level function that gets called a lot (but of
course measuring trumps everything there).

But I think the thing that gives me the most pause is that the oid
version of the function feels bolted-on. The nth_packed_object_sha1()
function is there specifically to give access to the mmap'd pack-index
data. And at least for now, that only stores sha1s, not any kind of
struct. If and when it does learn about other hashes, I'm not sure if
we're going to want a generic nth_packed_object_oid() function, or if
the callers would need to handle the various cases specially.

Given that this patch only converts one caller, I'd be more inclined to
just have the caller do its own hashcpy. Like:

diff --git a/sha1_file.c b/sha1_file.c
index 1173071859..16345688b5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3769,12 +3769,14 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
 
 	for (i = 0; i < p->num_objects; i++) {
 		const unsigned char *sha1 = nth_packed_object_sha1(p, i);
+		struct object_id oid;
 
 		if (!sha1)
 			return error("unable to get sha1 of object %u in %s",
 				     i, p->pack_name);
 
-		r = cb(sha1, p, i, data);
+		hashcpy(oid.hash, sha1);
+		r = cb(&oid, p, i, data);
 		if (r)
 			break;
 	}

That punts on the issue for all the other callers, but like I said, I'm
not quite sure if, when, and how it would make sense to convert them to
using a "struct oid".

-Peff
