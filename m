Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D4330328
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482780; cv=none; b=RzW6vldfaXnnke5lTCb0uEyxSeUWQDc7RczQOpSacSFPbQQ7kT9bcDrELlf8a2XjHWu+LyKs910SU44ESGwNVViHZoOyVKViWJ8q/ogzklhL/Vge8GoAj74Tpwzo+I2MooFR6ShPCAYDHwcFPBjahdYl8TSmexx6M3ByesmwVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482780; c=relaxed/simple;
	bh=Hv24YiE3FlfBW7Lv9lFRmZvNQYFlqQYcBxDS1rC4Kec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDEW6xhW0QjYaYl3BKy+wB9x7QvPH1hoWM/KWIUfjRfhhv8LXhhB7a4ghc2T8uHBp56kn5m4osPg+AfXvWPZZibJtMV+iEJ1Wc7g8vBBuLWX+qV9zPmLfS+u8883lZClk2uHFufS70bKX2LNLbPcjDZm+DOrzEb/6Fy1zL1XQII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ETZNkaRo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ETZNkaRo"
Received: (qmail 25441 invoked by uid 106); 8 Jul 2026 03:52:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Hv24YiE3FlfBW7Lv9lFRmZvNQYFlqQYcBxDS1rC4Kec=; b=ETZNkaRovcmNL5xFDY1Ux95H+NYSLeUqUT1Wb8LFSuZ8MFdCVPoOEEIAdCYKXdYeHm6ziTnO3XA6hffWETL86FFdz9FBuOWf000Wwz3+k3Mc7s4VBFj+I+df1lg8XRV7gMEmC82bHlAm/jJEg2T7h7JnWhUhjQDH1Xg7WdNaZ4bBS3MiBJdOmQYdxSIoKb23vJbhvhIBBq8FvFEcEU4WWZ84yl19n6ufp9x667Nyo1860QNeVbwQd6cvnlsBo7JSX6vzBt2ok8k3xF05G3JnLOKnN8SpWaM0qC2biAj14Nixa8m3dWfpi8bhkpGz8YZ6evKFmBAu0wjAS3Sn+ckTAg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:52:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 41005 invoked by uid 111); 8 Jul 2026 03:52:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:52:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:52:57 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] hash: make git_hash_discard() idempotent
Message-ID: <20260708035257.GD41620@coredump.intra.peff.net>
References: <20260708035235.GA41491@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708035235.GA41491@coredump.intra.peff.net>

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
index 121ecf13aa..cf94ad5700 100644
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

