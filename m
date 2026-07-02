Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7532D394492
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980033; cv=none; b=srBPXpS5wNPh1cl4WNfKJc1SopZzFpr+wyQxRdWsYJFUrScmE4U4fnGtiWSPrCap1x29JveZxJfbc13P5+gwv6tA2GndqbuEQPUPm0JNOLqew2wLMv/X/uIJ8FMgQIiAV/67oyqO8gsVDFC5naFnQ+lkeZQuCaGYlOfowEhdm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980033; c=relaxed/simple;
	bh=bkXM0rMI6vUrEKAH0UDK3CUwbXfi1vnR8TQCPjF9Ht0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BL+TpZtdmciTRVJ+YaLaF1ceSaBBSpow29VYr/OcCkkQRleCevRwT5NC7llc8fhMkSDweNOu+h3yAJu4J7rnSJS2GYOPpmFxjyCIDNFBTbEWU5DrmfrA6SuZj6BKyNcJ1h13H6QLWHb5VkM0KPywyeXoWfbxOkD6KXBMV7KijBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GyWpcJ5k; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GyWpcJ5k"
Received: (qmail 85748 invoked by uid 106); 2 Jul 2026 08:13:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=bkXM0rMI6vUrEKAH0UDK3CUwbXfi1vnR8TQCPjF9Ht0=; b=GyWpcJ5k7tlfVPwbFXUBKuFIghq570PLiqUtO20nfrrKZVAdbPtQH+e965D0E8D6QJ8zMW+QhBGMbyFDENJdwEWXr23mUTi0nRNcuHa6J9UR3cdBL6w3GbAjLr39FJxu517L/hH4A361w+tOyPB1CeJKYNVWXZFbCfA0lOlI2yexlY63EOdR6Or5fHbcBGug/w2yUmrWCmpHH0ryDTQJCC+IFIkuD4+5mgy1jQhZOcR1Jdc43iUwCcWhAlIFsOY+BvS+V16mR7VAOeUcDBFs8sPvxlWPsm/Od0vUq2PFn9SeI9aD87pJ+hcypc4xQ9dv7CszAwg0iezBHR4qpoOdMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:13:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178358 invoked by uid 111); 2 Jul 2026 08:13:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:13:50 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:13:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 9/9] hash: add platform-specific discard functions
Message-ID: <20260702081349.GI2029434@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702075234.GA1548258@coredump.intra.peff.net>

Our git_hash_discard() is a bit hacky: it just calls git_hash_final()
into a dummy result buffer, using the side effect that each
implementation's Final() function will also free any resources.

This is probably not too terrible, since generating the final hash is
not that expensive and we'd mostly call discard on unusual or error code
paths. But we can do better by widening the platform API a bit to add an
explicit discard function.

This requires an annoying amount of boilerplate:

  - Each algorithm needs a git_$ALGO_discard() wrapper that dereferences
    the union'd git_hash_ctx into the type-safe field. So sha1 + sha256
    + sha1-unsafe, plus a BUG() for the unknown algo. And then these all
    need to be referenced in the git_hash_algo structs.

  - Platforms which don't do anything special to discard now need a
    fallback function which does nothing. And we need this for each algo
    (sha1, sha256, and sha1-unsafe).

  - Platforms which do need to discard must define their discard
    functions. This includes sha1/openssl, sha256/openssl, and
    sha256/gcrypt (no sha1-unsafe here as it sits atop the sha1/openssl
    functions).

  - Algo selection needs to point platform_*_Discard to the appropriate
    underlying macro, or indicate that the fallback should be used. We
    have a similar situation for the Clone function (where a straight
    memcpy() of the context struct is not enough for some platforms).
    I've tied Discard to the same flag used by Clone here, since they
    are basically the same problem: is the hash context a sequence of
    bytes, or does it need smart copying/discarding?

It's easy to miss a case here since we don't even compile the
implementations we aren't using. I've tested with each of:

  - no flags, which uses our internal sha1/sha256 implementations, both
    of which exercise the noop fallback function

  - OPENSSL_SHA1_UNSAFE=1, which checks that our unsafe macro
    redirections work

  - OPENSSL_SHA1=1, though you should not do that in real life!

  - OPENSSL_SHA256=1, passes tests with GIT_TEST_DEFAULT_HASH=sha256

  - GCRYPT_SHA256=1, which likewise passes

The other implementations do not set the CLONE_HELPER flag, so they
treat the context as bytes and should be fine with the fallback.

Signed-off-by: Jeff King <peff@peff.net>
---
One of the reasons I left this to the end is that I wasn't sure it would
be worth it. I think it probably is (hence posting it), but we could
live with the hacky implementation forever if we wanted. :)

It also prompted me to test with all of the backends I could build,
which is how I found the unrelated gcrypt leak fixed in patch 8.

 hash.c           | 33 +++++++++++++++++++++++++--------
 hash.h           | 21 +++++++++++++++++++++
 sha1/openssl.h   |  6 ++++++
 sha256/gcrypt.h  |  6 ++++++
 sha256/openssl.h |  6 ++++++
 5 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/hash.c b/hash.c
index 63672a3d22..55d1d41770 100644
--- a/hash.c
+++ b/hash.c
@@ -72,6 +72,11 @@ static void git_hash_sha1_final_oid(struct object_id *oid, struct git_hash_ctx *
 	oid->algo = GIT_HASH_SHA1;
 }
 
+static void git_hash_sha1_discard(struct git_hash_ctx *ctx)
+{
+	git_SHA1_Discard(&ctx->state.sha1);
+}
+
 static void git_hash_sha1_init_unsafe(struct git_hash_ctx *ctx)
 {
 	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA1]);
@@ -102,6 +107,11 @@ static void git_hash_sha1_final_oid_unsafe(struct object_id *oid, struct git_has
 	oid->algo = GIT_HASH_SHA1;
 }
 
+static void git_hash_sha1_discard_unsafe(struct git_hash_ctx *ctx)
+{
+	git_SHA1_Discard_unsafe(&ctx->state.sha1_unsafe);
+}
+
 static void git_hash_sha256_init(struct git_hash_ctx *ctx)
 {
 	ctx->algop = unsafe_hash_algo(&hash_algos[GIT_HASH_SHA256]);
@@ -135,6 +145,11 @@ static void git_hash_sha256_final_oid(struct object_id *oid, struct git_hash_ctx
 	oid->algo = GIT_HASH_SHA256;
 }
 
+static void git_hash_sha256_discard(struct git_hash_ctx *ctx)
+{
+	git_SHA256_Discard(&ctx->state.sha256);
+}
+
 static void git_hash_unknown_init(struct git_hash_ctx *ctx UNUSED)
 {
 	BUG("trying to init unknown hash");
@@ -165,6 +180,11 @@ static void git_hash_unknown_final_oid(struct object_id *oid UNUSED,
 	BUG("trying to finalize unknown hash");
 }
 
+static void git_hash_unknown_discard(struct git_hash_ctx *ctx UNUSED)
+{
+	BUG("trying to discard unknown hash");
+}
+
 static const struct git_hash_algo sha1_unsafe_algo = {
 	.name = "sha1",
 	.format_id = GIT_SHA1_FORMAT_ID,
@@ -176,6 +196,7 @@ static const struct git_hash_algo sha1_unsafe_algo = {
 	.update_fn = git_hash_sha1_update_unsafe,
 	.final_fn = git_hash_sha1_final_unsafe,
 	.final_oid_fn = git_hash_sha1_final_oid_unsafe,
+	.discard_fn = git_hash_sha1_discard_unsafe,
 	.empty_tree = &empty_tree_oid,
 	.empty_blob = &empty_blob_oid,
 	.null_oid = &null_oid_sha1,
@@ -193,6 +214,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_unknown_update,
 		.final_fn = git_hash_unknown_final,
 		.final_oid_fn = git_hash_unknown_final_oid,
+		.discard_fn = git_hash_unknown_discard,
 		.empty_tree = NULL,
 		.empty_blob = NULL,
 		.null_oid = NULL,
@@ -208,6 +230,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha1_update,
 		.final_fn = git_hash_sha1_final,
 		.final_oid_fn = git_hash_sha1_final_oid,
+		.discard_fn = git_hash_sha1_discard,
 		.unsafe = &sha1_unsafe_algo,
 		.empty_tree = &empty_tree_oid,
 		.empty_blob = &empty_blob_oid,
@@ -224,6 +247,7 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		.update_fn = git_hash_sha256_update,
 		.final_fn = git_hash_sha256_final,
 		.final_oid_fn = git_hash_sha256_final_oid,
+		.discard_fn = git_hash_sha256_discard,
 		.empty_tree = &empty_tree_oid_sha256,
 		.empty_blob = &empty_blob_oid_sha256,
 		.null_oid = &null_oid_sha256,
@@ -285,14 +309,7 @@ void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
 
 void git_hash_discard(struct git_hash_ctx *ctx)
 {
-	/*
-	 * XXX Many implementations do not need to do anything here,
-	 * and a dummy final() call is wasteful. But we can't fix
-	 * that unless our implementation API exposes a discard
-	 * primitive.
-	 */
-	unsigned char dummy[GIT_MAX_RAWSZ];
-	git_hash_final(dummy, ctx);
+	ctx->algop->discard_fn(ctx);
 }
 
 uint32_t hash_algo_by_name(const char *name)
diff --git a/hash.h b/hash.h
index 6b2f04e2a4..0a23ef4dfd 100644
--- a/hash.h
+++ b/hash.h
@@ -37,6 +37,7 @@
 #    define platform_SHA1_Clone_unsafe openssl_SHA1_Clone
 #    define platform_SHA1_Update_unsafe openssl_SHA1_Update
 #    define platform_SHA1_Final_unsafe openssl_SHA1_Final
+#    define platform_SHA1_Discard_unsafe openssl_SHA1_Discard
 #  else
 #    define platform_SHA_CTX_unsafe SHA_CTX
 #    define platform_SHA1_Init_unsafe SHA1_Init
@@ -92,6 +93,7 @@
 #  define platform_SHA1_Final_unsafe   platform_SHA1_Final
 #  ifdef platform_SHA1_Clone
 #    define platform_SHA1_Clone_unsafe platform_SHA1_Clone
+#    define platform_SHA1_Discard_unsafe platform_SHA1_Discard
 #  endif
 #  ifdef SHA1_NEEDS_CLONE_HELPER
 #    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
@@ -110,9 +112,11 @@
 
 #ifdef platform_SHA1_Clone
 #define git_SHA1_Clone	platform_SHA1_Clone
+#define git_SHA1_Discard platform_SHA1_Discard
 #endif
 #ifdef platform_SHA1_Clone_unsafe
 #  define git_SHA1_Clone_unsafe platform_SHA1_Clone_unsafe
+#  define git_SHA1_Discard_unsafe platform_SHA1_Discard_unsafe
 #endif
 
 #ifndef platform_SHA256_CTX
@@ -129,6 +133,7 @@
 
 #ifdef platform_SHA256_Clone
 #define git_SHA256_Clone	platform_SHA256_Clone
+#define git_SHA256_Discard	platform_SHA256_Discard
 #endif
 
 #ifdef SHA1_MAX_BLOCK_SIZE
@@ -142,20 +147,32 @@ static inline void git_SHA1_Clone(git_SHA_CTX *dst, const git_SHA_CTX *src)
 {
 	memcpy(dst, src, sizeof(*dst));
 }
+static inline void git_SHA1_Discard(git_SHA_CTX *ctx UNUSED)
+{
+	/* noop */
+}
 #endif
 #ifndef SHA1_NEEDS_CLONE_HELPER_UNSAFE
 static inline void git_SHA1_Clone_unsafe(git_SHA_CTX_unsafe *dst,
 				       const git_SHA_CTX_unsafe *src)
 {
 	memcpy(dst, src, sizeof(*dst));
 }
+static inline void git_SHA1_Discard_unsafe(git_SHA_CTX_unsafe *ctx UNUSED)
+{
+	/* noop */
+}
 #endif
 
 #ifndef SHA256_NEEDS_CLONE_HELPER
 static inline void git_SHA256_Clone(git_SHA256_CTX *dst, const git_SHA256_CTX *src)
 {
 	memcpy(dst, src, sizeof(*dst));
 }
+static inline void git_SHA256_Discard(git_SHA256_CTX *ctx UNUSED)
+{
+	/* noop */
+}
 #endif
 
 /*
@@ -271,6 +288,7 @@ typedef void (*git_hash_clone_fn)(struct git_hash_ctx *dst, const struct git_has
 typedef void (*git_hash_update_fn)(struct git_hash_ctx *ctx, const void *in, size_t len);
 typedef void (*git_hash_final_fn)(unsigned char *hash, struct git_hash_ctx *ctx);
 typedef void (*git_hash_final_oid_fn)(struct object_id *oid, struct git_hash_ctx *ctx);
+typedef void (*git_hash_discard_fn)(struct git_hash_ctx *ctx);
 
 struct git_hash_algo {
 	/*
@@ -306,6 +324,9 @@ struct git_hash_algo {
 	/* The hash finalization function for object IDs. */
 	git_hash_final_oid_fn final_oid_fn;
 
+	/* Discard an initialized hash without finalizing. */
+	git_hash_discard_fn discard_fn;
+
 	/* The OID of the empty tree. */
 	const struct object_id *empty_tree;
 
diff --git a/sha1/openssl.h b/sha1/openssl.h
index 1038af47da..48deeb724a 100644
--- a/sha1/openssl.h
+++ b/sha1/openssl.h
@@ -40,12 +40,18 @@ static inline void openssl_SHA1_Clone(struct openssl_SHA1_CTX *dst,
 	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
 }
 
+static inline void openssl_SHA1_Discard(struct openssl_SHA1_CTX *ctx)
+{
+	EVP_MD_CTX_free(ctx->ectx);
+}
+
 #ifndef platform_SHA_CTX
 #define platform_SHA_CTX openssl_SHA1_CTX
 #define platform_SHA1_Init openssl_SHA1_Init
 #define platform_SHA1_Clone openssl_SHA1_Clone
 #define platform_SHA1_Update openssl_SHA1_Update
 #define platform_SHA1_Final openssl_SHA1_Final
+#define platform_SHA1_Discard openssl_SHA1_Discard
 #endif
 
 #endif /* SHA1_OPENSSL_H */
diff --git a/sha256/gcrypt.h b/sha256/gcrypt.h
index 694a2b70a1..d91ffe73d3 100644
--- a/sha256/gcrypt.h
+++ b/sha256/gcrypt.h
@@ -31,10 +31,16 @@ static inline void gcrypt_SHA256_Clone(gcrypt_SHA256_CTX *dst, const gcrypt_SHA2
 	gcry_md_copy(dst, *src);
 }
 
+static inline void gcrypt_SHA256_Discard(gcrypt_SHA256_CTX *ctx)
+{
+	gcry_md_close(*ctx);
+}
+
 #define platform_SHA256_CTX gcrypt_SHA256_CTX
 #define platform_SHA256_Init gcrypt_SHA256_Init
 #define platform_SHA256_Clone gcrypt_SHA256_Clone
 #define platform_SHA256_Update gcrypt_SHA256_Update
 #define platform_SHA256_Final gcrypt_SHA256_Final
+#define platform_SHA256_Discard gcrypt_SHA256_Discard
 
 #endif
diff --git a/sha256/openssl.h b/sha256/openssl.h
index c1083d9491..3d457ca99d 100644
--- a/sha256/openssl.h
+++ b/sha256/openssl.h
@@ -40,10 +40,16 @@ static inline void openssl_SHA256_Clone(struct openssl_SHA256_CTX *dst,
 	EVP_MD_CTX_copy_ex(dst->ectx, src->ectx);
 }
 
+static inline void openssl_SHA256_Discard(struct openssl_SHA256_CTX *ctx)
+{
+	EVP_MD_CTX_free(ctx->ectx);
+}
+
 #define platform_SHA256_CTX openssl_SHA256_CTX
 #define platform_SHA256_Init openssl_SHA256_Init
 #define platform_SHA256_Clone openssl_SHA256_Clone
 #define platform_SHA256_Update openssl_SHA256_Update
 #define platform_SHA256_Final openssl_SHA256_Final
+#define platform_SHA256_Discard openssl_SHA256_Discard
 
 #endif /* SHA256_OPENSSL_H */
-- 
2.55.0.418.g37da59dd42
