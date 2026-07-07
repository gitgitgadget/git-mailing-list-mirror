Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D722EEE61
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400760; cv=none; b=hnem1aDXDmnTb1LaEV/kuZTIvOE3BeefdJFvkJlKxmEwSKqyzbc36urTsok2efMyeqxME2wEh7CZUmkTpbzBmvk13sXMFJ1ZoL9Pa8p8kZOGFbv52TWsZU0VCmetdHdeuhubwmPsskSs6ryC2GFEG+u5xJMt2ytSG97vWF5S3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400760; c=relaxed/simple;
	bh=WAduhzgj84U77y6DPRWvYUjGGH31bsPDgqgF1jaU8I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgMogqj/GuvVJZ7PYchCFlRLSFiczPfgWk2AtDFyS97kwldF9rPaSI2paXGUNqDWZRKvQAvYRfOV0kBKvw3P8TvcVChnesWyJQmQYuo8b7rsa5qbptWXRaSUyNouaKDEyGhq0cO50E0mXV4WmyHP42oBG5ZnG+kukKzmJHY4AHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JoddVAAA; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JoddVAAA"
Received: (qmail 17504 invoked by uid 106); 7 Jul 2026 05:05:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WAduhzgj84U77y6DPRWvYUjGGH31bsPDgqgF1jaU8I4=; b=JoddVAAAsWSK2OQuR4VDsew2J92B8RHpEWUJx4Rh7bfS+dY0OzaWmToeTnPepWdoVsxwkO2pCSmthabq3rhttrwKKSejEYW7JiK7am+WXeXTDrETydwKrc4oemvj8Tabi97n6I4HmTD5MyNohosWtaG31i2YiEefR1fGBlJ90TsaKpUhn/Y1FAt/XrMk2Zl3JZzierNDoCOGzGlSB+ROXwoKMhhzprCQ87UuHtzyMfjHGat3SB8mCx7I2D1t+Xk5+XpfM0MqNIMpmyWOwsq2zRGowJviyTpvm6YLBvbUJs/kFpiXTMllt1JQqgRYSda9Zm3qVba5mx2EtIjZhlQYTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 05:05:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22459 invoked by uid 111); 7 Jul 2026 05:05:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 01:05:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 01:05:57 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/7] hash: document function pointers and wrappers
Message-ID: <20260707050557.GC1288294@coredump.intra.peff.net>
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

We want people to use the git_hash_*() wrappers rather than the bare
function pointers in the git_hash_algo struct. Let's document them
rather than the bare pointers, and warn people away from the pointers.
Coccinelle will eventually force the use of the wrappers, but it's
helpful to lead readers in the right direction from the start.

While we're here we can document a few other bits of wisdom I've turned
up while working in this area:

  - You have to initialize the destination of a git_hash_clone(). This
    is something we may eventually change for efficiency, but we should
    definitely document the requirement for now.

  - You must eventually finalize or discard a hash, since some backends
    may allocate resources during initialization.

Signed-off-by: Jeff King <peff@peff.net>
---
 hash.h | 43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/hash.h b/hash.h
index 0a23ef4dfd..5686914b71 100644
--- a/hash.h
+++ b/hash.h
@@ -309,22 +309,15 @@ struct git_hash_algo {
 	/* The block size of the hash. */
 	size_t blksz;
 
-	/* The hash initialization function. */
+	/*
+	 * Low-level implementation hooks. Callers should use the git_hash_*
+	 * wrappers below rather than invoking these directly.
+	 */
 	git_hash_init_fn init_fn;
-
-	/* The hash context cloning function. */
 	git_hash_clone_fn clone_fn;
-
-	/* The hash update function. */
 	git_hash_update_fn update_fn;
-
-	/* The hash finalization function. */
 	git_hash_final_fn final_fn;
-
-	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
-
-	/* Discard an initialized hash without finalizing. */
 	git_hash_discard_fn discard_fn;
 
 	/* The OID of the empty tree. */
@@ -341,12 +334,40 @@ struct git_hash_algo {
 };
 extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
 
+/*
+ * Prepare an uninitialized hash context for use. You must eventually release
+ * the context with with git_hash_final() (or final_oid()) or by calling
+ * git_hash_discard().
+ */
 void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop);
+
+/*
+ * Clone the state of a hash. Both src and dst must have been initialized with
+ * git_hash_init().
+ */
 void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src);
+
+/*
+ * Add more data to an initialized hash context.
+ */
 void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len);
+
+/*
+ * Retrieve the final hash value from a context, releasing any resources.
+ */
 void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx);
+
+/*
+ * Like git_hash_final(), but write the result into an object_id.
+ */
 void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx);
+
+/*
+ * Discard a hash context without computing the final value, but still
+ * releasing any resources.
+ */
 void git_hash_discard(struct git_hash_ctx *ctx);
+
 const struct git_hash_algo *hash_algo_ptr_by_number(uint32_t algo);
 struct git_hash_ctx *git_hash_alloc(void);
 void git_hash_free(struct git_hash_ctx *ctx);
-- 
2.55.0.459.g1b256877c9

