Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BF378D72
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 05:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400994; cv=none; b=YyD2SFROZTNFR/BRRD1Ustn/jsTid8KGMCM5dL4o+jZEVi14jKR2He1dOOH9LN+za0/k7DHn2JxV+TYuwFi8XOIE0AXT0kUMxn6Rysh5XptiJ2qLFnZkyIvAwvlhukelKAlx3GvkXqP8N3kHW62oPZY1IqzZILwGE9L7otc/XT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400994; c=relaxed/simple;
	bh=svli7jtw4TP3xenFHyu7G41sv18HC5ShBOU3cgXbcbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eekB1IqW5tQgtqIyf946fFAPYXckiXbykgLWcsUCIGLCqavIGRuZkGWOUB4LsFxcD7V1DGoz+nuUP4Un8cOmmhFFUqiLQsvpm/9vLTN8JNiMw5Hdh77nkg6uuzb2DiQ9xtEDywJ0Ycj9BdkZ2zOEMzMk0kFQb9qXZX3BD07cFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QMdaElNs; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QMdaElNs"
Received: (qmail 17561 invoked by uid 106); 7 Jul 2026 05:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=svli7jtw4TP3xenFHyu7G41sv18HC5ShBOU3cgXbcbM=; b=QMdaElNsjKwhCqUwjpdyxuQxyuir7RvGdN4cJ4E5CNEPGYbwmpPZZSC4hh1Dbv5LKWeCSdbb0LcPYcK0QdS8llUjypszkqg/sI7Q+gnW40PB4yVI0qFOH4S8FY4E4puwR6lqwKytDzjpsWf6tJQMsDakZQ4sOmUKHF9OBk4ovUuzQUAtAEPmNqOph6sL/MKRTMRmpKjWxzSRiIGB2kufmfP+hSvJskRbAVpb9ccK1qrkfCr4ZNTBGlGYA7JQ8IXag+lh+SuPLuAPGMS2gEAbbIsksDvLXJRXGxyqEMmRvr56tDqyj2pmCBYKjZUDMCmy4HaTo2YqAazhDHCMbyWTFw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2026 05:09:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22533 invoked by uid 111); 7 Jul 2026 05:09:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 01:09:52 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 01:09:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 7/7] hash: check ctx->active flag in all wrapper functions
Message-ID: <20260707050952.GG1288294@coredump.intra.peff.net>
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

It only makes sense to call git_hash_update(), etc, on a hash context
that has been initialized but not yet finalized or discarded. This is an
unlikely error to make, but it's easy for us to catch it and complain.

It's especially important because it would quietly "work" for many hash
backends (like sha1dc, which is just manipulating some bytes) but would
cause undefined behavior with others (like OpenSSL, which puts the
context onto the heap). Checking the flag lets us catch problems
consistently on every build.

Note that we can't do the same for git_init_hash(). Even though it would
cause a leak to call it twice (without an intervening final/discard),
the point of the function is that the contents of the struct are
undefined before the call. But calling it twice is an even less likely
error to make, so not covering it is OK.

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
