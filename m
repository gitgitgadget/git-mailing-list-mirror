Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91D3D5237
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979196; cv=none; b=lx2JUO623WV4jaj3BK/cSJxhpcXSFwrBWK646YWjyhJ1sgcUUmCxadmd7GA1isayUdmmxfr1uyZUiBJRplfw1rDz3KsSHzZswtvBTmXsoO2m80H9GvTIKwfs0tcyu4nVzJEvCOx60C242Y/LRgr60hgqINvfhJBB413UZ7HIgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979196; c=relaxed/simple;
	bh=5Y2JQBsdlP2UUy076EtQ/M/z/ND/OoLaxfOEbK09LqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl2uBAD7FQ1ISNAf76txOo+SwZrDTRgVz5S5F+go+dx7IvG50mXI7Wb9qBtqV/flwi30H763AH2DI884Vkog6w8QJ9RM4UXhIB3xBZ8zap/aCVZHLXRelymWDPmAbvjgfI44QqrDOpL3Kk9589VJpqKRQdP+u2EHuHEc86UptlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XQ2f4zuR; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XQ2f4zuR"
Received: (qmail 85579 invoked by uid 106); 2 Jul 2026 07:59:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5Y2JQBsdlP2UUy076EtQ/M/z/ND/OoLaxfOEbK09LqM=; b=XQ2f4zuROWjT333rnXGySaMtnBQsXmrvbBHMigKs3W2VCft1zQpu7TV7aL78JlH9jpJ68pkEO2w7aqEUIca3UNzSga3gvlUZcVEaffu9oLIiP3hKTDQ01U/q/DQJdwXnyOmMFEQE7o6oE0XGSggb+bI2kL7cEk6dmZNrDS1hapU/qoGGQgAz/NBdebmfJS7tzOSKBTWbqaZdwV2NzczqqGdiih/jv/mkhjcACO7BIJ3HawQlO1PjtE/sugv1GZN7Suqp+zc/I+Ygxsf9Kb7Q1d3k334nyM2wJwkbMv0ib5r15n91zIVKlNQrW1CoizkXqtcigAExECnQCfM7EFz0aQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 07:59:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178180 invoked by uid 111); 2 Jul 2026 07:59:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 03:59:53 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 03:59:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/9] hash: add discard primitive
Message-ID: <20260702075953.GB2029434@coredump.intra.peff.net>
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

The usual life-cycle for a git_hash_ctx is calling git_hash_init(),
adding some data, and then using git_hash_final() to get the output
digest and free any resources.

Sometimes we decide to abort the operation without the final() call
(e.g., due to errors or other reasons). In that case we just abandon the
hash_ctx completely and let it go out of scope. For most hash
implementations this is fine; they were just holding values directly in
the struct.

But some implementations do allocate memory, and in these cases we leak
the memory. Notably OpenSSL >= 3.0 requires us to allocate the digest
context on the heap with EVP_MD_CTX_new().

Let's provide a git_hash_discard() function that can be used in these
code paths to free any resources. For now we'll implement it by just
calling git_hash_final() into a dummy output, relying on its side effect
of freeing the resources. Our view of the underlying hash implementation
is abstracted behind the platform_SHA_* macros, so that's the best we
can do without widening that interface.

It's a little inefficient, but probably not noticeably so in practice,
especially as we'd usually hit this on an error code path. And by
abstracting it in this function, we can later swap it out when the
platform_SHA interface lets us do so.

Signed-off-by: Jeff King <peff@peff.net>
---
In case you're on the edge of your seat, that widening happens in patch
9. It was helpful to make sure the simple-and-stupid thing actually
fixed the leaks first, and then do the convoluted platform-macro magic
later.

 hash.c | 12 ++++++++++++
 hash.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/hash.c b/hash.c
index e925b9754e..63672a3d22 100644
--- a/hash.c
+++ b/hash.c
@@ -283,6 +283,18 @@ void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
 	ctx->algop->final_oid_fn(oid, ctx);
 }
 
+void git_hash_discard(struct git_hash_ctx *ctx)
+{
+	/*
+	 * XXX Many implementations do not need to do anything here,
+	 * and a dummy final() call is wasteful. But we can't fix
+	 * that unless our implementation API exposes a discard
+	 * primitive.
+	 */
+	unsigned char dummy[GIT_MAX_RAWSZ];
+	git_hash_final(dummy, ctx);
+}
+
 uint32_t hash_algo_by_name(const char *name)
 {
 	if (!name)
diff --git a/hash.h b/hash.h
index c082a53c9a..6b2f04e2a4 100644
--- a/hash.h
+++ b/hash.h
@@ -325,6 +325,7 @@ void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src);
 void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len);
 void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx);
 void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx);
+void git_hash_discard(struct git_hash_ctx *ctx);
 const struct git_hash_algo *hash_algo_ptr_by_number(uint32_t algo);
 struct git_hash_ctx *git_hash_alloc(void);
 void git_hash_free(struct git_hash_ctx *ctx);
-- 
2.55.0.418.g37da59dd42

