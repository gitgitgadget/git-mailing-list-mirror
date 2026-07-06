Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A3E2F84F
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 00:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783296469; cv=none; b=KNSahbzYz/EAmW6unYyzqbvh3XLtEHwjOnitDkNqwg4kPRTmY7KP/hrWhaOWciI8NRIyL64YsRKIPfhjvGFkbsanRBGlGOymKK5I5A8tznXVUIuM0NB9F3qz++hU+UZrezcq4GdbevrcRB1HyJ9IZl/361C/IAZtTh2nuS3pILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783296469; c=relaxed/simple;
	bh=EvJ09Y12fjttWHufatCKk9EpW+XuNvB5cAOndu7YBRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaWmdmmDpaBY5Tkv/0dA4Xpa74NAD0vk8gdjCy1WTtMw6QNgjdGhI5/qrKOoVcYKvjkzafBjEvbRh9sDBCKYGVxTC8OkHazXE2Pjj83Iig0y4R2JcLhrzCb63s6Wi9rI8qVKkwkfGcnXu5O//9viGRdRGTob202VnaS/DfgOH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BlWHHbBJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BlWHHbBJ"
Received: (qmail 2333 invoked by uid 106); 6 Jul 2026 00:01:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EvJ09Y12fjttWHufatCKk9EpW+XuNvB5cAOndu7YBRI=; b=BlWHHbBJ3UDG49WQ6IqNPEmiQT1WP4OXtRk9vRCkxk7l94n6FHf3e3kcpZnRPsN5hl/20q+sUVAkMtGqLCH3o+QV2PR1UdOcdZBnp8ZkqjAsgRJJ8bl2yh1mijY/Z0dgbD9zc6AS0FomeStv3ucNuv05riqbLWQJTI6eMsGB79/u8Vv9R2g9hLwvA5q3ZklUY2kppPOdwuROTk00JuU4bPCeaX0Dybf8qIwK/vS7FoewXxU69qdqydxGuRBblspFP38cQox5jOC1/0GRLQr2O5TzyoOFvkpcjvPt5ealZJZITGxt4b5zvvn72+q9psx8CDv2pgFvdrDvzKcpEzJl2Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Jul 2026 00:01:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3579 invoked by uid 111); 6 Jul 2026 00:01:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Jul 2026 20:01:05 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 5 Jul 2026 20:01:05 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 7/9] http: discard hash in dumb-http http_object_request
Message-ID: <20260706000105.GA2301945@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
 <20260702080707.GG2029434@coredump.intra.peff.net>
 <akecqPq4F702E8Cq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akecqPq4F702E8Cq@pks.im>

On Fri, Jul 03, 2026 at 01:27:36PM +0200, Patrick Steinhardt wrote:

> On Thu, Jul 02, 2026 at 04:07:07AM -0400, Jeff King wrote:
> > The flag handling could be removed if the hash-discard function were
> > idempotent. This could be done easily-ish by having the underlying
> > hash functions (like the ones in sha256/openssl.h) set the context
> > pointer to NULL after free-ing. But it's something that every platform
> > implementation would have to remember to do, and the benefit for the
> > callers is not that huge (it would let us shave a few lines here and
> > probably in a few other spots).
> 
> This answers an earlier question of mine. It would indeed be great if it
> was idempotent -- I've been bitten by interfaces like this once too
> much, where you have to be very careful to manage the lifetime of a
> specific object. The prime example of this are (were? I don't quite
> recall whether we fixed that interface) reference transactions, and that
> caused a bunch of bugs in the past.

There are three tricky points I found while thinking about this.

First: how and when do we decide to skip a discard? For most
implementations (like sha1dc), it's always a noop, and we can ignore it.
For OpenSSL, we could be setting ctx->ectx to NULL. But for gcrypt we
typedef their opaque structure directly. So we'd have to push that down
into its own struct and add an "active" flag.

That's not too bad, but it does put the burden on each backend. Instead,
we could keep a flag in the top-level ctx like this:

diff --git a/hash.c b/hash.c
index 55d1d41770..f4c451b20a 100644
--- a/hash.c
+++ b/hash.c
@@ -285,6 +285,7 @@ void git_hash_free(struct git_hash_ctx *ctx)
 void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop)
 {
 	algop->init_fn(ctx);
+	ctx->active = 1;
 }
 
 void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
@@ -300,16 +301,19 @@ void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
 void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
 {
 	ctx->algop->final_fn(hash, ctx);
+	ctx->active = 0;
 }
 
 void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
 {
 	ctx->algop->final_oid_fn(oid, ctx);
+	ctx->active = 0;
 }
 
 void git_hash_discard(struct git_hash_ctx *ctx)
 {
-	ctx->algop->discard_fn(ctx);
+	if (ctx->active)
+		ctx->algop->discard_fn(ctx);
 }
 
 uint32_t hash_algo_by_name(const char *name)
diff --git a/hash.h b/hash.h
index 0a23ef4dfd..2840f20793 100644
--- a/hash.h
+++ b/hash.h
@@ -281,6 +281,7 @@ struct git_hash_ctx {
 		git_SHA_CTX_unsafe sha1_unsafe;
 		git_SHA256_CTX sha256;
 	} state;
+	bool active;
 };
 
 typedef void (*git_hash_init_fn)(struct git_hash_ctx *ctx);


That nicely puts the responsibility in a single place, but now we have
the opposite problem: what if somebody calls algop->final_fn() directly?
Then the flag gets out of sync with the underlying state. There are two
such calls currently, in submodule--helper.c and test-synthesize.c.
AFAICT there is no reason they could not just use git_hash_final().
Maybe it would be enough to fix that spot and comment the algo function
pointers to warn people away from using them directly.

That by itself is enough to make:

  algo->init_fn(&ctx);
  git_hash_update(&ctx, ...);
  git_hash_final(out, &ctx);
  ...
  git_hash_discard(&ctx);

safe.


The second issue is related: what should we do in other functions when
the active flag is not set? For example, what should this do:

  algo->init_fn(&ctx);

  git_hash_update(&ctx, ...);
  git_hash_final(out, &ctx);

  git_hash_update(&ctx, ...);
  git_hash_final(out, &ctx);

In the second git_hash_update() call, there are two obvious options:

  1. It should do nothing; there is no active context to add to.

  2. It should automatically re-init the context (using the algo from
     the previous init) and add the data.

The second final() call has the added bonus that it returns data, but I
think there are two matching options:

  1. It should do nothing, and hashclr() the output (leaving it
     uninitialized just seems insane).

  2. It should automatically re-init the context (assuming there was not
     already an update() call that did so). And then I guess return
     whatever hash that particular algo generates for the empty string?

Those all seem reasonable-ish to me and give a defined output at every
moment (which is better than crashing). But it kind of feels like they'd
be papering over potential bugs. Maybe crashing _is_ better (we don't do
so reliably now, but a BUG() could make sense).


And the third is related: do we check the active flag when initializing?
Right now the answer must be "no", because the point of the init
function is that the input is potentially garbage. But that means
something like:

  struct git_hash_ctx ctx;
  algo->init_fn(&ctx);
  algo->init_fn(&ctx);

leaks. That's maybe OK in practice. We could do something more like:

  struct git_hash_ctx = HASH_CTX_INIT;
  git_hash_start(&ctx, algo);

where the INIT step doesn't actually allocate anything, and start() is
the moment where you must promise to call final() or discard(). And then
it would be OK for start() to BUG() when the active flag is already set.


That was maybe more than you wanted to read about the topic. But if the
request is for safer object lifetimes in general, then I think there are
a lot of details about what that means.

If we are going to do anything, I'd be inclined to stop mostly after the
diff I showed above. That's the only thing I've seen that would simplify
existing code. The rest are mostly hypotheticals, but since Rust was
mentioned, I wondered if you're trying to shoot for something safer.

At any rate, I would prefer to do any of this on top of the series I
posted. I took care there to avoid double-calling final()/discard(),
which could now be simplified away. But I think I'd rather see that
simplification its own step.

-Peff
