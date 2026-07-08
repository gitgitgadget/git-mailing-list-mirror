Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD4420896
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482776; cv=none; b=tKiOVNFwt5E1JIlycblR21y1py5/nyn9TM3ITE+owSa7i13UWx/MWgA+L6KEGETO/4gNJ1vEP8sFdkUC+a0CMaWHFpNBko+mzlxuVi8seT+qGi/5GDLooi0yRKIbYhLtpa88wOz3rd1rOxh1l7JTLAkZVxFXxU+EZjNVpN91JeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482776; c=relaxed/simple;
	bh=nEZEN6vRHT78SspKQGenWXgi16YEbuotJ25WLqdk9II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuVhtuZVmcnVIgxRTsS4MKgipwOtUS5ZWg/wHIk+f68M7ZBm73y/Ujm3FO7A+yqCilVnPm4ncPqbQpyacy1Pj75pcbX8BjIF1Nvcl7odgXSL7RFx9oB3+sPej4wu5iwE7bvjGbwk+SqHJUrdItq/xVzp3BB9wiwCnVEVXL1p37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IpFs9bDw; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IpFs9bDw"
Received: (qmail 25416 invoked by uid 106); 8 Jul 2026 03:52:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nEZEN6vRHT78SspKQGenWXgi16YEbuotJ25WLqdk9II=; b=IpFs9bDw43sDY0pktW1sfGV9Y1ebfAYMC1jaH8DRXpQwF+jzhO2g9L+VTvTQUEQmM0Th0OV+Zs1e6znsw594TB0Rfw1jdYLqL30l3DW6XtbNTBb9MzJYtUKZgFbvvVTGXraWznpVEJvFkZQfAr7+6NI19LY1s3vGYhnB+5di655inyxckYJ8RnUJFWqdfPlCEAjgHVydSWYTCXAHbbQDq6BKUTrfiVegsa9JpnmcJS2PVqDgIbzG1AklR3e8ke9uNfalMR8QaGMAIs4ecPCgjKtiMxaksHwucPzj3mEmiIGl6AtGKM4LqCFG8AO7UmQvaNqpTRFyv1vlaW2p1lgddw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:52:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 40991 invoked by uid 111); 8 Jul 2026 03:52:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:52:53 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:52:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/7] hash: convert remaining direct function calls
Message-ID: <20260708035253.GB41620@coredump.intra.peff.net>
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

The previous patch added a coccinelle rule to make sure callers always
use git_hash_init() rather than direct function pointers from the algo
struct.

Let's do the same for the rest of the git_hash_*() wrappers. I split
these out because they're a bit different: they implicitly use the algop
pointer in the git_hash_ctx. So when we convert:

  -algo->update_fn(&ctx, buf, len);
  +git_hash_update(&ctx, buf, len);

we drop the reference to algo entirely! But this is always going to be
the right thing. If "algo" does not match what is in ctx.algop, then
we'd already be invoking undefined behavior.

So in addition to making it possible to add more logic to the
git_hash_*() functions, we're avoiding the need to pass around the extra
algo pointer and make sure that it matches what's in "ctx".

The rest of the patch is the mechanical application of that coccinelle
patch, plus a minor cleanup in test-synthesize.c to drop a now-unused
function parameter (since we don't have to pass around the algo
separately anymore).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c |  8 +++---
 t/helper/test-synthesize.c  | 29 ++++++++++----------
 tools/coccinelle/hash.cocci | 54 +++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bf114a7856..510f193a15 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -551,10 +551,10 @@ static void create_default_gitdir_config(const char *submodule_name)
 	/* Case 2.4: If all the above failed, try a hash of the name as a last resort */
 	header_len = snprintf(header, sizeof(header), "blob %zu", strlen(submodule_name));
 	git_hash_init(&ctx, the_hash_algo);
-	the_hash_algo->update_fn(&ctx, header, header_len);
-	the_hash_algo->update_fn(&ctx, "\0", 1);
-	the_hash_algo->update_fn(&ctx, submodule_name, strlen(submodule_name));
-	the_hash_algo->final_fn(raw_name_hash, &ctx);
+	git_hash_update(&ctx, header, header_len);
+	git_hash_update(&ctx, "\0", 1);
+	git_hash_update(&ctx, submodule_name, strlen(submodule_name));
+	git_hash_final(raw_name_hash, &ctx);
 	hash_to_hex_algop_r(hex_name_hash, raw_name_hash, the_hash_algo);
 	strbuf_reset(&gitdir_path);
 	repo_git_path_append(the_repository, &gitdir_path, "modules/%s", hex_name_hash);
diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index 7719fb3a76..fd116c87ba 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -25,8 +25,7 @@ static const unsigned char zeros[BLOCK_SIZE];
  * Updates the pack checksum context.
  */
 static void write_uncompressed_zlib(FILE *f, struct git_hash_ctx *pack_ctx,
-				    const void *data, size_t len,
-				    const struct git_hash_algo *algo)
+				    const void *data, size_t len)
 {
 	unsigned char zlib_header[2] = { 0x78, 0x01 }; /* CMF, FLG */
 	unsigned char block_header[5];
@@ -37,7 +36,7 @@ static void write_uncompressed_zlib(FILE *f, struct git_hash_ctx *pack_ctx,
 
 	/* Write zlib header */
 	fwrite_or_die(f, zlib_header, sizeof(zlib_header));
-	algo->update_fn(pack_ctx, zlib_header, 2);
+	git_hash_update(pack_ctx, zlib_header, 2);
 
 	/* Write uncompressed blocks (max 64KB each) */
 	do {
@@ -52,11 +51,11 @@ static void write_uncompressed_zlib(FILE *f, struct git_hash_ctx *pack_ctx,
 		block_header[4] = block_header[2] ^ 0xff;
 
 		fwrite_or_die(f, block_header, sizeof(block_header));
-		algo->update_fn(pack_ctx, block_header, 5);
+		git_hash_update(pack_ctx, block_header, 5);
 
 		if (block_len) {
 			fwrite_or_die(f, block_data, block_len);
-			algo->update_fn(pack_ctx, block_data, block_len);
+			git_hash_update(pack_ctx, block_data, block_len);
 			adler = adler32(adler, block_data, block_len);
 		}
 
@@ -68,7 +67,7 @@ static void write_uncompressed_zlib(FILE *f, struct git_hash_ctx *pack_ctx,
 	/* Write adler32 checksum */
 	put_be32(adler_buf, adler);
 	fwrite_or_die(f, adler_buf, sizeof(adler_buf));
-	algo->update_fn(pack_ctx, adler_buf, 4);
+	git_hash_update(pack_ctx, adler_buf, 4);
 }
 
 /*
@@ -92,24 +91,24 @@ static void write_pack_object(FILE *f, struct git_hash_ctx *pack_ctx,
 						       sizeof(pack_header),
 						       type, len);
 	fwrite_or_die(f, pack_header, pack_header_len);
-	algo->update_fn(pack_ctx, pack_header, pack_header_len);
+	git_hash_update(pack_ctx, pack_header, pack_header_len);
 
 	/* Write the data as uncompressed zlib */
-	write_uncompressed_zlib(f, pack_ctx, data, len, algo);
+	write_uncompressed_zlib(f, pack_ctx, data, len);
 
 	git_hash_init(&ctx, algo);
 	object_header_len = format_object_header(object_header,
 						 sizeof(object_header),
 						 type, len);
-	algo->update_fn(&ctx, object_header, object_header_len);
+	git_hash_update(&ctx, object_header, object_header_len);
 	if (data)
-		algo->update_fn(&ctx, data, len);
+		git_hash_update(&ctx, data, len);
 	else {
 		for (size_t i = len / BLOCK_SIZE; i; i--)
-			algo->update_fn(&ctx, zeros, BLOCK_SIZE);
-		algo->update_fn(&ctx, zeros, len % BLOCK_SIZE);
+			git_hash_update(&ctx, zeros, BLOCK_SIZE);
+		git_hash_update(&ctx, zeros, len % BLOCK_SIZE);
 	}
-	algo->final_oid_fn(oid, &ctx);
+	git_hash_final_oid(oid, &ctx);
 }
 
 /*
@@ -434,7 +433,7 @@ static int generate_pack_with_large_object(const char *path, size_t blob_size,
 
 	/* Write pack header */
 	fwrite_or_die(f, &pack_header, sizeof(pack_header));
-	algo->update_fn(&pack_ctx, &pack_header, sizeof(pack_header));
+	git_hash_update(&pack_ctx, &pack_header, sizeof(pack_header));
 
 	/* 1. Write the large blob */
 	write_pack_object(f, &pack_ctx, OBJ_BLOB, NULL, blob_size, &blob_oid, algo);
@@ -472,7 +471,7 @@ static int generate_pack_with_large_object(const char *path, size_t blob_size,
 	write_pack_object(f, &pack_ctx, OBJ_COMMIT, buf.buf, buf.len, &final_commit_oid, algo);
 
 	/* Write pack trailer (checksum) */
-	algo->final_fn(pack_hash, &pack_ctx);
+	git_hash_final(pack_hash, &pack_ctx);
 	fwrite_or_die(f, pack_hash, algo->rawsz);
 	if (fclose(f))
 		die_errno(_("could not close '%s'"), path);
diff --git a/tools/coccinelle/hash.cocci b/tools/coccinelle/hash.cocci
index 04270ee043..d0e2e5f4b1 100644
--- a/tools/coccinelle/hash.cocci
+++ b/tools/coccinelle/hash.cocci
@@ -7,3 +7,57 @@ struct git_hash_ctx *CTX;
 - ALGO->init_fn(CTX);
 + git_hash_init(CTX, ALGO);
   ...>}
+
+@@
+identifier f != git_hash_clone;
+expression ALGO;
+struct git_hash_ctx *SRC;
+struct git_hash_ctx *DST;
+@@
+  f(...) {<...
+- ALGO->clone_fn(DST, SRC);
++ git_hash_clone(DST, SRC);
+  ...>}
+
+@@
+identifier f != git_hash_update;
+expression ALGO;
+struct git_hash_ctx *CTX;
+expression list ARGS;
+@@
+  f(...) {<...
+- ALGO->update_fn(CTX, ARGS);
++ git_hash_update(CTX, ARGS);
+  ...>}
+
+@@
+identifier f != git_hash_final;
+expression ALGO;
+struct git_hash_ctx *CTX;
+expression list ARGS;
+@@
+  f(...) {<...
+- ALGO->final_fn(ARGS, CTX);
++ git_hash_final(ARGS, CTX);
+  ...>}
+
+@@
+identifier f != git_hash_final_oid;
+expression ALGO;
+struct git_hash_ctx *CTX;
+expression list ARGS;
+@@
+  f(...) {<...
+- ALGO->final_oid_fn(ARGS, CTX);
++ git_hash_final_oid(ARGS, CTX);
+  ...>}
+
+@@
+identifier f != git_hash_discard;
+expression ALGO;
+struct git_hash_ctx *CTX;
+@@
+  f(...) {<...
+- ALGO->discard_fn(CTX);
++ git_hash_discard(CTX);
+  ...>}
-- 
2.55.0.459.g1b256877c9

