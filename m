Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F417420896
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 03:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482772; cv=none; b=dNAq+Ko6t83lmfrXNW+cE2yxLve64BheO9usAN8utEjeZpZrX6yY+QsowDWWweJsuD0udNa5/IoM5n9ZaqXL0yGvSybz0b9huu1lC6oNJDMR52ZrheyUiqTiXlaz8febNbGzup/9sS+Lvnpcf6ZY1kU5Gl+JHj2eu+wu2xktrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482772; c=relaxed/simple;
	bh=kOI5cq17PIbk/K9fbRuJlmqCuVzsye3WjJYNCkFZwVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q79afJ7zw2cz4m0ym+Z6dpoS8CP0BUAyzhfsYc5hAEHUFnOeCMv+tI4TVG6gvE5i1lIPGJxI7aWMD3EeGKk1zskNQxAYZyG6ZCOMA7+vJDwYE1w8cDeXK3XUJV94P8NKL9FHqEh23DVq4JM2KohaYfpUF4kek3u/LwFETjt626Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W0Uq7ZlU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W0Uq7ZlU"
Received: (qmail 25404 invoked by uid 106); 8 Jul 2026 03:52:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kOI5cq17PIbk/K9fbRuJlmqCuVzsye3WjJYNCkFZwVY=; b=W0Uq7ZlUcflHY3bUK1P1DVqNsP51EXfFmvqwXc6oimDF1HYGGJjxwi0SuU3l9knHt7NbWcL5gFofKU/qmhfte8nRC5LKfI3RHbZDtwA2kttQhX+ZBCFSxzxIOhqjGUK8k0O9/bHxx36MZFsEsx3RzzgXqJ0LwA7ybKouzzb/Y4FhhE3vEeZW3Q2apz7IHMdTWN7p4n0fCra8C4MVGiT0eImr+jR80bsYi/hnT+WbO/7mw08O4y/kKxXx9TWAq7q+C3FqyvRkXtvN6LGb9DtKyYXuuLsEpPM0F7wMN1dp+DDIdifhoFaPtA13QUq1rdFMAq/ShXwueKzfWCJKZHRNww==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2026 03:52:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 40981 invoked by uid 111); 8 Jul 2026 03:52:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2026 23:52:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Jul 2026 23:52:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] hash: use git_hash_init() consistently
Message-ID: <20260708035249.GA41620@coredump.intra.peff.net>
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

We'd like to add more logic to git_hash_init(), but many callers skip it
and call algop->init_fn() directly. Let's make sure we're consistently
using the wrapper by adding a coccinelle rule.

Besides the coccinelle file itself, this is a purely mechanical
conversion based on the patch it generates. There should be no bare
init_fn() calls left (except for the one in the wrapper).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-import.c       |  4 ++--
 builtin/index-pack.c        |  6 +++---
 builtin/patch-id.c          |  2 +-
 builtin/receive-pack.c      |  6 +++---
 builtin/submodule--helper.c |  2 +-
 builtin/unpack-objects.c    |  4 ++--
 csum-file.c                 |  6 +++---
 diff.c                      |  4 ++--
 http-push.c                 |  2 +-
 http.c                      |  4 ++--
 object-file.c               | 14 +++++++-------
 pack-check.c                |  2 +-
 pack-write.c                |  6 +++---
 read-cache.c                |  6 +++---
 rerere.c                    |  2 +-
 t/helper/test-hash-speed.c  |  2 +-
 t/helper/test-hash.c        |  2 +-
 t/helper/test-synthesize.c  |  4 ++--
 t/unit-tests/u-hash.c       |  2 +-
 tools/coccinelle/hash.cocci |  9 +++++++++
 trace2/tr2_sid.c            |  2 +-
 21 files changed, 50 insertions(+), 41 deletions(-)
 create mode 100644 tools/coccinelle/hash.cocci

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index f6473dcc8e..6692f7cd81 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -969,7 +969,7 @@ static int store_object(
 
 	hdrlen = format_object_header((char *)hdr, sizeof(hdr), type,
 				      dat->len);
-	the_hash_algo->init_fn(&c);
+	git_hash_init(&c, the_hash_algo);
 	git_hash_update(&c, hdr, hdrlen);
 	git_hash_update(&c, dat->buf, dat->len);
 	git_hash_final_oid(&oid, &c);
@@ -1131,7 +1131,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 
 	hdrlen = format_object_header((char *)out_buf, out_sz, OBJ_BLOB, len);
 
-	the_hash_algo->init_fn(&c);
+	git_hash_init(&c, the_hash_algo);
 	git_hash_update(&c, out_buf, hdrlen);
 
 	crc32_begin(pack_file);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f396658468..53a8cb9dd7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -374,7 +374,7 @@ static const char *open_pack_file(const char *pack_name)
 		output_fd = -1;
 		nothread_data.pack_fd = input_fd;
 	}
-	the_hash_algo->init_fn(&input_ctx);
+	git_hash_init(&input_ctx, the_hash_algo);
 	return pack_name;
 }
 
@@ -481,7 +481,7 @@ static void *unpack_entry_data(off_t offset, size_t size,
 
 	if (!is_delta_type(type)) {
 		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
-		the_hash_algo->init_fn(&c);
+		git_hash_init(&c, the_hash_algo);
 		git_hash_update(&c, hdr, hdrlen);
 	} else
 		oid = NULL;
@@ -1291,7 +1291,7 @@ static void parse_pack_objects(unsigned char *hash)
 
 	/* Check pack integrity */
 	flush();
-	the_hash_algo->init_fn(&tmp_ctx);
+	git_hash_init(&tmp_ctx, the_hash_algo);
 	git_hash_clone(&tmp_ctx, &input_ctx);
 	git_hash_final(hash, &tmp_ctx);
 	if (!hasheq(fill(the_hash_algo->rawsz), hash, the_repository->hash_algo))
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 57d9bd4a65..22f36ecf80 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -73,7 +73,7 @@ static size_t get_one_patchid(struct object_id *next_oid, struct object_id *resu
 	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
 	struct git_hash_ctx ctx;
 
-	the_hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, the_hash_algo);
 	oidclr(result, the_repository->hash_algo);
 
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 19eb6a1b61..faf0f120ac 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -615,7 +615,7 @@ static void hmac_hash(unsigned char *out,
 	/* RFC 2104 2. (1) */
 	memset(key, '\0', GIT_MAX_BLKSZ);
 	if (the_hash_algo->blksz < key_len) {
-		the_hash_algo->init_fn(&ctx);
+		git_hash_init(&ctx, the_hash_algo);
 		git_hash_update(&ctx, key_in, key_len);
 		git_hash_final(key, &ctx);
 	} else {
@@ -629,13 +629,13 @@ static void hmac_hash(unsigned char *out,
 	}
 
 	/* RFC 2104 2. (3) & (4) */
-	the_hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, the_hash_algo);
 	git_hash_update(&ctx, k_ipad, sizeof(k_ipad));
 	git_hash_update(&ctx, text, text_len);
 	git_hash_final(out, &ctx);
 
 	/* RFC 2104 2. (6) & (7) */
-	the_hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, the_hash_algo);
 	git_hash_update(&ctx, k_opad, sizeof(k_opad));
 	git_hash_update(&ctx, out, the_hash_algo->rawsz);
 	git_hash_final(out, &ctx);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1cc82a134d..bf114a7856 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -550,7 +550,7 @@ static void create_default_gitdir_config(const char *submodule_name)
 
 	/* Case 2.4: If all the above failed, try a hash of the name as a last resort */
 	header_len = snprintf(header, sizeof(header), "blob %zu", strlen(submodule_name));
-	the_hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, the_hash_algo);
 	the_hash_algo->update_fn(&ctx, header, header_len);
 	the_hash_algo->update_fn(&ctx, "\0", 1);
 	the_hash_algo->update_fn(&ctx, submodule_name, strlen(submodule_name));
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f3849bb654..93a9caa582 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -670,10 +670,10 @@ int cmd_unpack_objects(int argc,
 		/* We don't take any non-flag arguments now.. Maybe some day */
 		usage(unpack_usage);
 	}
-	the_hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, the_hash_algo);
 	unpack_all();
 	git_hash_update(&ctx, buffer, offset);
-	the_hash_algo->init_fn(&tmp_ctx);
+	git_hash_init(&tmp_ctx, the_hash_algo);
 	git_hash_clone(&tmp_ctx, &ctx);
 	git_hash_final_oid(&oid, &tmp_ctx);
 	if (strict) {
diff --git a/csum-file.c b/csum-file.c
index b166f89624..7e81391524 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -175,7 +175,7 @@ struct hashfile *hashfd_ext(const struct git_hash_algo *algop,
 	f->skip_hash = 0;
 
 	f->algop = unsafe_hash_algo(algop);
-	f->algop->init_fn(&f->ctx);
+	git_hash_init(&f->ctx, f->algop);
 
 	f->buffer_len = opts->buffer_len ? opts->buffer_len : DEFAULT_IO_BUFFER_SIZE;
 	f->buffer = xmalloc(f->buffer_len);
@@ -200,7 +200,7 @@ void hashfile_checkpoint_init(struct hashfile *f,
 			      struct hashfile_checkpoint *checkpoint)
 {
 	memset(checkpoint, 0, sizeof(*checkpoint));
-	f->algop->init_fn(&checkpoint->ctx);
+	git_hash_init(&checkpoint->ctx, f->algop);
 }
 
 void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)
@@ -252,7 +252,7 @@ int hashfile_checksum_valid(const struct git_hash_algo *algop,
 	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	algop->init_fn(&ctx);
+	git_hash_init(&ctx, algop);
 	git_hash_update(&ctx, data, data_len);
 	git_hash_final(got, &ctx);
 
diff --git a/diff.c b/diff.c
index 1568f0ed9c..589c1969e4 100644
--- a/diff.c
+++ b/diff.c
@@ -6855,7 +6855,7 @@ void flush_one_hunk(struct object_id *result, struct git_hash_ctx *ctx)
 	int i;
 
 	git_hash_final(hash, ctx);
-	the_hash_algo->init_fn(ctx);
+	git_hash_init(ctx, the_hash_algo);
 	/* 20-byte sum, with carry */
 	for (i = 0; i < the_hash_algo->rawsz; ++i) {
 		carry += result->hash[i] + hash[i];
@@ -6899,7 +6899,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 	struct git_hash_ctx ctx;
 	struct patch_id_t data;
 
-	the_hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, the_hash_algo);
 	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx = &ctx;
 	oidclr(oid, the_repository->hash_algo);
diff --git a/http-push.c b/http-push.c
index 3c23cbba27..60f6f8f054 100644
--- a/http-push.c
+++ b/http-push.c
@@ -776,7 +776,7 @@ static void handle_new_lock_ctx(struct xml_ctx *ctx, int tag_closed)
 		} else if (!strcmp(ctx->name, DAV_ACTIVELOCK_TOKEN)) {
 			lock->token = xstrdup(ctx->cdata);
 
-			the_hash_algo->init_fn(&hash_ctx);
+			git_hash_init(&hash_ctx, the_hash_algo);
 			git_hash_update(&hash_ctx, lock->token, strlen(lock->token));
 			git_hash_final(lock_token_hash, &hash_ctx);
 
diff --git a/http.c b/http.c
index 63abbaae8a..0341de5031 100644
--- a/http.c
+++ b/http.c
@@ -2879,7 +2879,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 
 	git_inflate_init(&freq->stream);
 
-	the_hash_algo->init_fn(&freq->c);
+	git_hash_init(&freq->c, the_hash_algo);
 	freq->hash_ctx_valid = 1;
 
 	freq->url = get_remote_object_url(base_url, hex, 0);
@@ -2916,7 +2916,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		git_inflate_end(&freq->stream);
 		memset(&freq->stream, 0, sizeof(freq->stream));
 		git_inflate_init(&freq->stream);
-		the_hash_algo->init_fn(&freq->c);
+		git_hash_init(&freq->c, the_hash_algo);
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(freq->localfile, 0, SEEK_SET);
diff --git a/object-file.c b/object-file.c
index e3c68cfb66..93602f8c50 100644
--- a/object-file.c
+++ b/object-file.c
@@ -124,7 +124,7 @@ int stream_object_signature(struct repository *r,
 	hdrlen = format_object_header(hdr, sizeof(hdr), st->type, st->size);
 
 	/* Sha1.. */
-	r->hash_algo->init_fn(&c);
+	git_hash_init(&c, r->hash_algo);
 	git_hash_update(&c, hdr, hdrlen);
 	for (;;) {
 		char buf[1024 * 16];
@@ -320,7 +320,7 @@ static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_c
 			     struct object_id *oid,
 			     char *hdr, size_t *hdrlen)
 {
-	algo->init_fn(c);
+	git_hash_init(c, algo);
 	git_hash_update(c, hdr, *hdrlen);
 	git_hash_update(c, buf, len);
 	git_hash_final_oid(oid, c);
@@ -681,9 +681,9 @@ static int start_loose_object_common(struct odb_source_loose *loose,
 	git_deflate_init(stream, cfg->zlib_compression_level);
 	stream->next_out = buf;
 	stream->avail_out = buflen;
-	algo->init_fn(c);
+	git_hash_init(c, algo);
 	if (compat && compat_c)
-		compat->init_fn(compat_c);
+		git_hash_init(compat_c, compat);
 
 	/*  Start to feed header to zlib stream */
 	stream->next_in = (unsigned char *)hdr;
@@ -1141,7 +1141,7 @@ static int hash_blob_stream(struct odb_write_stream *stream,
 
 	header_len = format_object_header((char *)buf, sizeof(buf),
 					  OBJ_BLOB, size);
-	hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, hash_algo);
 	git_hash_update(&ctx, buf, header_len);
 
 	while (!stream->is_finished) {
@@ -1313,7 +1313,7 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 
 	header_len = format_object_header((char *)obuf, sizeof(obuf),
 					  OBJ_BLOB, size);
-	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, transaction->base.source->odb->repo->hash_algo);
 	git_hash_update(&ctx, obuf, header_len);
 
 	/*
@@ -1560,7 +1560,7 @@ static int check_stream_oid(git_zstream *stream,
 	unsigned long total_read;
 	int status = Z_OK;
 
-	algop->init_fn(&c);
+	git_hash_init(&c, algop);
 	git_hash_update(&c, hdr, stream->total_out);
 
 	/*
diff --git a/pack-check.c b/pack-check.c
index 5adfb3f272..c3b8db7c5c 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -69,7 +69,7 @@ static int verify_packfile(struct repository *r,
 	if (!is_pack_valid(p))
 		return error("packfile %s cannot be accessed", p->pack_name);
 
-	r->hash_algo->init_fn(&ctx);
+	git_hash_init(&ctx, r->hash_algo);
 	do {
 		unsigned long remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
diff --git a/pack-write.c b/pack-write.c
index 83eaf88541..24033a9101 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -402,8 +402,8 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	char *buf;
 	ssize_t read_result;
 
-	hash_algo->init_fn(&old_hash_ctx);
-	hash_algo->init_fn(&new_hash_ctx);
+	git_hash_init(&old_hash_ctx, hash_algo);
+	git_hash_init(&new_hash_ctx, hash_algo);
 
 	if (lseek(pack_fd, 0, SEEK_SET) != 0)
 		die_errno("Failed seeking to start of '%s'", pack_name);
@@ -455,7 +455,7 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 			 * pack, which also means making partial_pack_offset
 			 * big enough not to matter anymore.
 			 */
-			hash_algo->init_fn(&old_hash_ctx);
+			git_hash_init(&old_hash_ctx, hash_algo);
 			partial_pack_offset = ~partial_pack_offset;
 			partial_pack_offset -= MSB(partial_pack_offset, 1);
 		}
diff --git a/read-cache.c b/read-cache.c
index 7c1cdcf696..5fa747e6fc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1722,7 +1722,7 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	if (oideq(&oid, null_oid(the_hash_algo)))
 		return 0;
 
-	the_hash_algo->init_fn(&c);
+	git_hash_init(&c, the_hash_algo);
 	git_hash_update(&c, hdr, size - the_hash_algo->rawsz);
 	git_hash_final(hash, &c);
 	if (!hasheq(hash, start, the_repository->hash_algo))
@@ -2957,7 +2957,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	 */
 	if (offset && record_eoie()) {
 		CALLOC_ARRAY(eoie_c, 1);
-		the_hash_algo->init_fn(eoie_c);
+		git_hash_init(eoie_c, the_hash_algo);
 	}
 
 	/*
@@ -3598,7 +3598,7 @@ static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
 	 *	 "REUC" + <binary representation of M>)
 	 */
 	src_offset = offset;
-	the_hash_algo->init_fn(&c);
+	git_hash_init(&c, the_hash_algo);
 	while (src_offset < mmap_size - the_hash_algo->rawsz - EOIE_SIZE_WITH_HEADER) {
 		/* After an array of active_nr index entries,
 		 * there can be arbitrary number of extended
diff --git a/rerere.c b/rerere.c
index 8232542585..216100925a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -439,7 +439,7 @@ static int handle_path(unsigned char *hash, struct rerere_io *io, int marker_siz
 	struct strbuf buf = STRBUF_INIT, out = STRBUF_INIT;
 	int has_conflicts = 0;
 	if (hash)
-		the_hash_algo->init_fn(&ctx);
+		git_hash_init(&ctx, the_hash_algo);
 
 	while (!io->getline(&buf, io)) {
 		if (is_cmarker(buf.buf, '<', marker_size)) {
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index fbf67fe6bd..89b0268011 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -5,7 +5,7 @@
 
 static inline void compute_hash(const struct git_hash_algo *algo, struct git_hash_ctx *ctx, uint8_t *final, const void *p, size_t len)
 {
-	algo->init_fn(ctx);
+	git_hash_init(ctx, algo);
 	git_hash_update(ctx, p, len);
 	git_hash_final(final, ctx);
 }
diff --git a/t/helper/test-hash.c b/t/helper/test-hash.c
index f0ee61c8b4..1f7163695f 100644
--- a/t/helper/test-hash.c
+++ b/t/helper/test-hash.c
@@ -29,7 +29,7 @@ int cmd_hash_impl(int ac, const char **av, int algo, int unsafe)
 			die("OOPS");
 	}
 
-	algop->init_fn(&ctx);
+	git_hash_init(&ctx, algop);
 
 	while (1) {
 		ssize_t sz, this_sz;
diff --git a/t/helper/test-synthesize.c b/t/helper/test-synthesize.c
index 3fa534fbdf..7719fb3a76 100644
--- a/t/helper/test-synthesize.c
+++ b/t/helper/test-synthesize.c
@@ -97,7 +97,7 @@ static void write_pack_object(FILE *f, struct git_hash_ctx *pack_ctx,
 	/* Write the data as uncompressed zlib */
 	write_uncompressed_zlib(f, pack_ctx, data, len, algo);
 
-	algo->init_fn(&ctx);
+	git_hash_init(&ctx, algo);
 	object_header_len = format_object_header(object_header,
 						 sizeof(object_header),
 						 type, len);
@@ -430,7 +430,7 @@ static int generate_pack_with_large_object(const char *path, size_t blob_size,
 
 	f = xfopen(path, "wb");
 
-	algo->init_fn(&pack_ctx);
+	git_hash_init(&pack_ctx, algo);
 
 	/* Write pack header */
 	fwrite_or_die(f, &pack_header, sizeof(pack_header));
diff --git a/t/unit-tests/u-hash.c b/t/unit-tests/u-hash.c
index bd4ac6a6e1..19f4efd410 100644
--- a/t/unit-tests/u-hash.c
+++ b/t/unit-tests/u-hash.c
@@ -12,7 +12,7 @@ static void check_hash_data(const void *data, size_t data_length,
 		unsigned char hash[GIT_MAX_HEXSZ];
 		const struct git_hash_algo *algop = &hash_algos[i];
 
-		algop->init_fn(&ctx);
+		git_hash_init(&ctx, algop);
 		git_hash_update(&ctx, data, data_length);
 		git_hash_final(hash, &ctx);
 
diff --git a/tools/coccinelle/hash.cocci b/tools/coccinelle/hash.cocci
new file mode 100644
index 0000000000..04270ee043
--- /dev/null
+++ b/tools/coccinelle/hash.cocci
@@ -0,0 +1,9 @@
+@@
+identifier f != git_hash_init;
+expression ALGO;
+struct git_hash_ctx *CTX;
+@@
+  f(...) {<...
+- ALGO->init_fn(CTX);
++ git_hash_init(CTX, ALGO);
+  ...>}
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 1c1d27b0ee..131b4f5a62 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -45,7 +45,7 @@ static void tr2_sid_append_my_sid_component(void)
 	if (xgethostname(hostname, sizeof(hostname)))
 		strbuf_add(&tr2sid_buf, "Localhost", 9);
 	else {
-		algo->init_fn(&ctx);
+		git_hash_init(&ctx, algo);
 		git_hash_update(&ctx, hostname, strlen(hostname));
 		git_hash_final(hash, &ctx);
 		hash_to_hex_algop_r(hex, hash, algo);
-- 
2.55.0.459.g1b256877c9

