Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636D346AE1
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400823; cv=none; b=uhmapcsahQTJ/zrKjHdmra0MHroH0o1jheaKviHCHz/EPcihV8GgVvoBYSiIuqpP9lSxEiS0u7VfoMq7kqkqCFsZyW0KW6eCfArnppGW+6ZvfXko0UllQSPxZFC73WFWkHfr4774s0TXuL7ufAA4cmxgrJsZQTMLCW2KkCGqTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400823; c=relaxed/simple;
	bh=B/euomkkdIuHsMctxxhbFii3gEpzcaTZXtl6FavZ28k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBwtKtade8VM8bsamFCsDnmTRZ7OM6kg2gEDxRhja42saZC3n/8nIDisxqQR1gMmKfLXuP+YZNgU2rfab8tUVpQGY96WSc14ijFHr/Eeiruol85nHhMJNG0WX3r/B3ksPa1ncsxh04IDIPlhV9dcrWpb2W8u9jGz4rmntAQrV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HrL6Zy+b; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HrL6Zy+b"
Received: (qmail 17518 invoked by uid 106); 7 Jul 2026 05:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B/euomkkdIuHsMctxxhbFii3gEpzcaTZXtl6FavZ28k=; b=HrL6Zy+b2PpW0lZ99vPTQIcfUFuzcPyi/YJkl3wn0WnWDD3RjhaAJ9hs0Toz7QNKSx1FYiqW8SdyePnvb5R5VwkPXDfq/1JlscppNHLNO1WAgOFoij4oMaT68hqfNbZFinW8KcKTPVccleGuOipy1W5HRaJJgdTRdJ31PMLbjFftFt+TaoyT7NM4nIR3yuPSWCAOPQaebsDkUZimJSlO+LH+FkqcezjKpfe3X0XLvDFwtpXF/nFnYkC29/uEq02ZR6rqLsJlTlwQ6QrTr43sByiOwwst83kOS6xTwKnxhyWF0fsEQ5adygm3K4s0RwFxGEErMxzoq+2gAklGBnpucA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 05:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22468 invoked by uid 111); 7 Jul 2026 05:07:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 01:07:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 01:07:00 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 4/7] hash: make git_hash_discard() idempotent
Message-ID: <20260707050700.GD1288294@coredump.intra.peff.net>
References: <20260707045556.GA1288172@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260707045556.GA1288172@coredump.intra.peff.net>

You must always either finalize or discard a hash context to release any
resources, but you must call only one such function. This creates extra
work for some callers, since their cleanup code paths need to know
whether they got there via their happy path (and the finalization
happened) or due to an error (in which case they need to discard).

Let's add an "active" flag that turns a redundant discard into a noop.
That lets you safely do this:

    git_hash_init(&ctx, algo);
    ...
    if (some_error)
            goto out;
    ...
    git_hash_final(result, &ctx);

  out:
    git_hash_discard(&ctx);

This should avoid future errors, and will also let us simplify a few
existing callers (in future patches).

Signed-off-by: Jeff King <peff@peff.net>
---
 hash.c | 6 ++++++
 hash.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hash.c b/hash.c
index 55d1d41770..b1296f0018 100644
--- a/hash.c
+++ b/hash.c
@@ -285,6 +285,7 @@ void git_hash_free(struct git_hash_ctx *ctx)
 void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop)
 {
 	algop->init_fn(ctx);
+	ctx->active = true;
 }
 
 void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
@@ -300,16 +301,21 @@ void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
 void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
 {
 	ctx->algop->final_fn(hash, ctx);
+	ctx->active = false;
 }
 
 void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
 {
 	ctx->algop->final_oid_fn(oid, ctx);
+	ctx->active = false;
 }
 
 void git_hash_discard(struct git_hash_ctx *ctx)
 {
+	if (!ctx->active)
+		return;
 	ctx->algop->discard_fn(ctx);
+	ctx->active = false;
 }
 
 uint32_t hash_algo_by_name(const char *name)
diff --git a/hash.h b/hash.h
index 5686914b71..f97f7b9ff4 100644
--- a/hash.h
+++ b/hash.h
@@ -281,6 +281,7 @@ struct git_hash_ctx {
 		git_SHA_CTX_unsafe sha1_unsafe;
 		git_SHA256_CTX sha256;
 	} state;
+	bool active;
 };
 
 typedef void (*git_hash_init_fn)(struct git_hash_ctx *ctx);
-- 
2.55.0.459.g1b256877c9

