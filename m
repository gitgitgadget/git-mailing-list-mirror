Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AA361662
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482788; cv=none; b=IGdzSbePsXLwMSlLF3UhZFfeIpJ9rVC1BBxya5CagsKKWlHgm/uvJCvabmsRld/z1L+jM7xCn32rTNNOkZKQx/NYhqUT4S3H5YbUXVMugkEQRgvnIUfl/zqOsdpG7riUZiPfPtNR72XdBvM+qWbQYv53CvELx54OwFWTbuG8c/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482788; c=relaxed/simple;
	bh=SXM68dSUJG0eug5ECvM+ccJjjZQrgTZ7SfbNkj0OuMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L65gqpycTyimwbOMRqqEWA1znuhL4PlEZRo+Xe03FN2xf3DK7H1RGxFmdwBorvBDUyJaUBnIAd+OPezugveNJPRssqjEcxGCZ4HLMe0/uHSAeTOB4IHzg8gm98T7FtR2FNSAKGGHnz7NzfSr/5ajgilye8Y7kpTo8u7JejGWLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K8uv1d3J; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K8uv1d3J"
Received: (qmail 25478 invoked by uid 106); 8 Jul 2026 03:53:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SXM68dSUJG0eug5ECvM+ccJjjZQrgTZ7SfbNkj0OuMI=; b=K8uv1d3J4O4HhrYGfryY6oF3Ao8KHNPWQjFIBX1wcizy87fyh4M3BzifGlMWbVGXdvUciW5NBYaWQhPfpXoI5w0KqE4BUTLfrUln6yG1ABPqQmJMTCATBA7fGzg03niJeQ+V0kxIx/PC4N10iCFJ3Ugx/tsts4cH4MlOSAonld7LIRz8UG5OOZUfFSi/oFRkONUFjEdaEX7DFPI3pNN9ocubaK8RDsi7x0tCE12l41d6GaAQUKl6RM6ySu4CX7zuNe0kZpYsAyCd45a8FcScfTih2bSnJC5dULwBMe4J1umIj7CB9rA6+DslSXwbg1jEY87Kd24yRZDfo4CyN2Htng==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:53:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 41025 invoked by uid 111); 8 Jul 2026 03:53:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:53:05 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:53:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] hash: check ctx->active flag in all wrapper functions
Message-ID: <20260708035305.GG41620@coredump.intra.peff.net>
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

It only makes sense to call git_hash_update(), etc, on a hash context
that has been initialized but not yet finalized or discarded. This is an
unlikely error to make, but it's easy for us to catch it and complain.

It's especially important because it would quietly "work" for many hash
backends (like sha1dc, which is just manipulating some bytes) but would
cause undefined behavior with others (like OpenSSL, which puts the
context onto the heap). Checking the flag lets us catch problems
consistently on every build.

Note that we can't do the same for git_hash_init(). Even though it would
cause a leak to call it twice (without an intervening final/discard),
the point of the function is that the contents of the struct are
undefined before the call. But calling it twice is an even less likely
error to make, so not covering it is OK.

We leave git_hash_discard() alone, as its idempotent behavior is
convenient for callers. We _could_ try to do something similar for
git_hash_final(), allowing:

  git_hash_final(result, &ctx);
  git_hash_final(other_result, &ctx);

but it does not make much sense. After the first final() call we have
thrown away the state, so we cannot produce the same output. We could
come up with some sensible output (the null hash, or the empty hash),
but double-calls like this are more likely a bug, so our best bet is to
complain loudly (whereas the current code produces either nonsense
output or undefined behavior, depending on the backend).

Signed-off-by: Jeff King <peff@peff.net>
---
 hash.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hash.c b/hash.c
index b1296f0018..82f7e24404 100644
--- a/hash.c
+++ b/hash.c
@@ -290,22 +290,32 @@ void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop)
 
 void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
 {
+	if (!src->active)
+		BUG("attempt to copy from an inactive hash context");
+	if (!dst->active)
+		BUG("attempt to copy to an inactive hash context");
 	src->algop->clone_fn(dst, src);
 }
 
 void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
 {
+	if (!ctx->active)
+		BUG("attempt to update an inactive hash context");
 	ctx->algop->update_fn(ctx, in, len);
 }
 
 void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
 {
+	if (!ctx->active)
+		BUG("attempt to finalize an inactive hash context");
 	ctx->algop->final_fn(hash, ctx);
 	ctx->active = false;
 }
 
 void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
 {
+	if (!ctx->active)
+		BUG("attempt to finalize an inactive hash context");
 	ctx->algop->final_oid_fn(oid, ctx);
 	ctx->active = false;
 }
-- 
2.55.0.459.g1b256877c9
