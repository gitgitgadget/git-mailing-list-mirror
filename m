Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656411F954
	for <e@80x24.org>; Wed, 22 Aug 2018 06:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeHVJbB (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 05:31:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:51288 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726696AbeHVJbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 05:31:00 -0400
Received: (qmail 30817 invoked by uid 109); 22 Aug 2018 06:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 06:07:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29583 invoked by uid 111); 22 Aug 2018 06:07:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 02:07:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 02:07:35 -0400
Date:   Wed, 22 Aug 2018 02:07:35 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
Message-ID: <20180822060735.GA13195@sigill.intra.peff.net>
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
 <1b20b754-987c-a712-2594-235b845bc5d0@gmail.com>
 <20180821212923.GB24431@sigill.intra.peff.net>
 <20180822004815.GA535143@genre.crustytoothpaste.net>
 <20180822030344.GA14684@sigill.intra.peff.net>
 <20180822053626.GB535143@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822053626.GB535143@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 05:36:26AM +0000, brian m. carlson wrote:

> On Tue, Aug 21, 2018 at 11:03:44PM -0400, Jeff King wrote:
> > So I wonder if there's some other way to tell the compiler that we'll
> > only have a few values. An enum comes to mind, though I don't think the
> > enum rules are strict enough to make this guarantee (after all, it's OK
> > to bitwise-OR enums, so they clearly don't specify all possible values).
> 
> I was thinking about this:
> 
> diff --git a/cache.h b/cache.h
> index 1398b2a4e4..1f5c6e9319 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1033,7 +1033,14 @@ extern const struct object_id null_oid;
>  
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -	return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +	switch (the_hash_algo->rawsz) {
> +		case 20:
> +			return memcmp(sha1, sha2, 20);
> +		case 32:
> +			return memcmp(sha1, sha2, 32);
> +		default:
> +			assert(0);
> +	}
>  }

Unfortunately this version doesn't seem to be any faster than the status
quo. And looking at the generated asm, it still looks to be calling
memcpy(). Removing the "case 32" branch switches it back to fast
assembly (this is all using gcc 8.2.0, btw). So I think we're deep into
guessing what the optimizer is going to do, and there's a good chance
that other versions are going to optimize it differently.

We might be better off just writing it out manually. Unfortunately, it's
a bit hard because the neg/0/pos return is more expensive to compute
than pure equality. And only the compiler knows at each inlined site
whether we actually want equality. So now we're back to switching every
caller to use hasheq() if that's what they want.

But _if_ we're OK with that, and _if_ we don't mind some ifdefs for
portability, then this seems as fast as the original (memcmp+constant)
code on my machine:

diff --git a/cache.h b/cache.h
index b1fd3d58ab..c406105f3c 100644
--- a/cache.h
+++ b/cache.h
@@ -1023,7 +1023,16 @@ extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return memcmp(sha1, sha2, the_hash_algo->rawsz);
+	switch (the_hash_algo->rawsz) {
+	case 20:
+		if (*(uint32_t *)sha1 == *(uint32_t *)sha2 &&
+		    *(unsigned __int128 *)(sha1+4) == *(unsigned __int128 *)(sha2+4))
+			return 0;
+	case 32:
+		return memcmp(sha1, sha2, 32);
+	default:
+		assert(0);
+	}
 }
 
 static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)

Which is really no surprise, because the generated asm looks about the
same. There are obviously alignment questions there. It's possible it
could even be written portably as a simple loop. Or maybe not. We used
to do that, but modern compilers were able to optimize the memcmp
better. Maybe that's changed. Or maybe they were simply unwilling to
unroll a 20-length loop to find out that it could be turned into a few
quad-word compares.

> That would make it obvious that there are at most two options.
> Unfortunately, gcc for me determines that the buffer in walker.c is 20
> bytes in size and steadfastly refuses to compile because it doesn't know
> that the value will never be 32 in our codebase currently.  I'd need to
> send in more patches before it would compile.

Yeah, I see that warning all over the place (everywhere that calls
is_null_oid(), which is passing in a 20-byte buffer).

> I don't know if something like this is an improvement or now, but this
> seems to at least compile:
> 
> diff --git a/cache.h b/cache.h
> index 1398b2a4e4..3207f74771 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1033,7 +1033,13 @@ extern const struct object_id null_oid;
>  
>  static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  {
> -	return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +	switch (the_hash_algo->rawsz) {
> +		case 20:
> +		case 32:
> +			return memcmp(sha1, sha2, the_hash_algo->rawsz);
> +		default:
> +			assert(0);
> +	}

I think that would end up with the same slow code, as gcc would rather
call memcmp than expand out the two sets of asm.

> I won't have time to sit down and test this out until tomorrow afternoon
> at the earliest.  If you want to send in something in the mean time,
> even if that limits things to just 20 for now, that's fine.

I don't have a good option. The assert() thing works until I add in the
"32" branch, but that's just punting the issue off until you add support
for the new hash.

Hand-rolling our own asm or C is a portability headache, and we need to
change all of the callsites to use a new hasheq().

Hiding it behind a per-hash function is conceptually cleanest, but not
quite as fast. And it also requires hasheq().

So all of the solutions seem non-trivial.  Again, I'm starting to wonder
if it's worth chasing this few percent.

-Peff
