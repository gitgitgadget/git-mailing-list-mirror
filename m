Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219183EC2FD
	for <git@vger.kernel.org>; Wed, 27 May 2026 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875140; cv=none; b=TlUgJ6SeJbWgE/UgmrxQHfZKblmPmEHdJzCoWfb8caOzaCjjA8mSsgMuq0jCzzAf9N94bLYnNOOVEYCD7apg1xuROwrhMyXKDdg76QfBTq6n2QdsQr0r6CAx67KeAkm8C9sY+23uxHSV/ZEBrKjmZnOGQ9Ou1fT+PQiPWLEboKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875140; c=relaxed/simple;
	bh=pAKYvLOc8uCGyKDIyY3vVquOwoBG88rqmQHVWRXsoXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCuf3IhiSxVFlxsGcsxKnJd26icgeXxRlBFmYM/gLZZagiCVVZLN5VxkD/l0lGKJzOtUZ6E8/9WgOGdowZanc90k+7aXTIdazBVtmr7u9xEDF09eGK78K9QWeWeCK7h7rrtjiXwJIZNQMLzyUA5nPZ53Mfa5MlKs+2Br7/UMLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PAJv7SQ1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PAJv7SQ1"
Received: (qmail 29083 invoked by uid 106); 27 May 2026 09:45:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pAKYvLOc8uCGyKDIyY3vVquOwoBG88rqmQHVWRXsoXE=; b=PAJv7SQ1ArZpHpU93Z5JjGw6ycLG1LdD9WCnwP8A8v3RBbW7R4qQHxYMlU7m6RRRP9BcFVQymMqKTC+Zu6oHybwjcNYXdMA/98Kjmw3VJy3YXA+jYHv2yrQQT/XXunDCj+a9e9wwN2qeAwCVoYrP4RwDF9u7Rq2mf37UkupCdwT9L+9PFbyFdXYhlkNsjXNy1DfZGL6XrGI3W+mv4N7z6Ci3urbMgXpH1EM6UIuPyWsg7czRlMzWQ02dDaFTchq96mR+k3MFe5BEa1KH0z2tQgUZ7uYk9H4lCfuziQiQTkggsYMw3eyK6BnHnBRwVyBd1twK3+R2NMMlE+k6lwfkOg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 09:45:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71792 invoked by uid 111); 27 May 2026 09:45:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 05:45:41 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 05:45:35 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 5/8] pack-bitmap: cache object positions during fill
Message-ID: <20260527094535.GF981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <e43ef6a42d13578a6b7a4a346f491e51a6edfd14.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e43ef6a42d13578a6b7a4a346f491e51a6edfd14.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:47PM -0400, Taylor Blau wrote:

> The previous commits removed some redundant work from bitmap generation
> by avoiding unnecessary tree recursion and by reusing selected bitmaps
> that have already been computed.
> 
> Even with those changes in place, there is still an extremely hot path
> from `fill_bitmap_commit()` and `fill_bitmap_tree()` to translate object
> IDs into their corresponding bit positions in order to generate their
> bitmaps.
> 
> In a small repository, this overhead is not significant. However, in a
> very large repository (e.g., the one that we have been using as a
> benchmark over the past several commits with ~57M total objects), the
> overhead of locating object bit positions (often repeatedly) adds up
> significantly.
> 
> Combat this by adding a small, direct-mapped cache to the bitmap writer
> which maps object IDs to their corresponding bit positions. Size the
> cache according to the number of objects being written, with fixed lower
> and upper bounds so small repositories do not pay for a large table and
> large repositories can avoid most repeated packlist and MIDX lookups.

Introducing another layer of data structure feels so dirty, but it's
hard to argue with the numbers. We are looking up oids in the packlist,
so it's already O(lg n). Your cache here is essentially a hash lookup,
which is O(1)-ish (with collisions causing eviction rather than growth).
And it presumably works because there's a lot of locality in lookups
(between commits X and X^1, their top-level trees will be almost
identical but we have to resolve the bits to find out which entries are
new).

It does make me wonder if we'd see similar improvements if we just
turned the packlist into a regular hash table. Or maybe not, because
then we'd have to do actual probing.

It also makes me wonder if we could use this trick elsewhere, but I
guess we usually are using "struct object" itself to find repeats in
most graph traversals. And there we're using a hash table already. So
this might save us a tiny bit of probing, but not much else.

Likewise when comparing two trees directly, we can just walk them in
parallel to find the changed parts (which doesn't work here, because
we're comparing one tree to the bitmap of all ancestors, not just X^1).

So this really is a somewhat unique situation. It _might_ be applicable
for the reading side of bitmaps, though. When we do fill-in traversal we
end up with this same "read a tree, find the bit for each entry, and 99%
of the time find that it is already in the bitmap".

> On my machine with (a somewhat outdated) GCC 15.2.0, each entry in the
> cache is 40 bytes wide:
> 
>     $ pahole -C bitmap_pos_cache_entry pack-bitmap-write.o
>     struct bitmap_pos_cache_entry {
>             struct object_id           oid;                  /*     0    36 */
>             uint32_t                   pos;                  /*    36     4 */
> 
>             /* size: 40, cachelines: 1, members: 2 */
>             /* last cacheline: 40 bytes */
>     };

I wondered about storing a pointer to an oid here, which would be
smaller but require an extra level of pointer chasing. The ones from
object structs are stable, but I guess the ones from trees are not (they
point to an entry field which will be reused). So we have to store the
oid whole.

> In our example repository from above and in earlier commits, this
> results in a ~9.4% reduction in runtime relative to the previous commit:
> 
>     +------------------+-------------+-------------+---------------------+
>     |                  | HEAD^       | HEAD        | Delta               |
>     +------------------+-------------+-------------+---------------------+
>     | elapsed          |   324.8 s   |   294.1 s   |    -30.7 s  (-9.4%) |
>     | cycles           | 1,508.6 B   | 1,365.5 B   |   -143.0 B  (-9.5%) |
>     | instructions     | 1,436.6 B   | 1,389.8 B   |    -46.9 B  (-3.3%) |
>     | CPI              |     1.050   |     0.983   |   -0.068    (-6.4%) |
>     +------------------+-------------+-------------+---------------------+

I show a 26% speed up on linux.git (1m37 down to 1m12). Very cool.

> +static uint32_t store_cached_object_pos(struct bitmap_writer *writer,
> +					const struct object_id *oid,
> +					uint32_t pos)
> +{
> +	size_t slot;
> +
> +	if (pos & BITMAP_POS_CACHE_VALID)
> +		return pos; /* too large to cache */

Cute, I wondered what would happen if we went past 2^31. I suspect there
are other parts of the code that do not behave that well around that
size, but it is good that we are not introducing any new surprises.

The whole patch looked pretty cleanly done.

-Peff
