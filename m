Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9594211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 08:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeLEIPs (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 03:15:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:59520 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726924AbeLEIPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 03:15:48 -0500
Received: (qmail 7451 invoked by uid 109); 5 Dec 2018 08:15:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 08:15:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29323 invoked by uid 111); 5 Dec 2018 08:15:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 03:15:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 03:15:44 -0500
Date:   Wed, 5 Dec 2018 03:15:44 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Geert Jansen <gerardu@amazon.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 8/9] sha1-file: use loose object cache for quick
 existence check
Message-ID: <20181205081544.GA9271@sigill.intra.peff.net>
References: <20181112162150.GB7612@sigill.intra.peff.net>
 <87d0ra2b3z.fsf@evledraar.gmail.com>
 <87bm6u2akf.fsf@evledraar.gmail.com>
 <878t1x2t3e.fsf@evledraar.gmail.com>
 <221cb2e4-a024-e301-2b3f-e37dcd93795e@web.de>
 <20181203220424.GA11883@sigill.intra.peff.net>
 <fe388ba5-765e-ff83-e610-d40964a76a0c@web.de>
 <20181205044645.GA12284@sigill.intra.peff.net>
 <54e7a97d-501c-1aa7-55cd-83f070d05a8c@web.de>
 <20181205065136.GA27263@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205065136.GA27263@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 01:51:36AM -0500, Jeff King wrote:

> > This
> > function is easily converted to struct object_id, though, as its single
> > caller can pass one on -- this makes the copy unnecessary.
> 
> If you mean modifying sha1_loose_object_info() to take an oid, then
> sure, I agree that is a good step forward (and that is exactly the "punt
> until" moment I meant).

So the simple thing is to do that, and then have it pass oid->hash to
the other functions it uses. If we start to convert those, there's a
little bit of a rabbit hole, but it's actually not too bad.

Most of the spill-over is into the dumb-http code. Note that it actually
uses sha1 itself! That probably needs to be the_hash_algo (though I'm
not even sure how we'd negotiate the algorithm across a dumb fetch). At
any rate, I don't think this patch makes anything _worse_ in that
respect.

diff --git a/http-push.c b/http-push.c
index cd48590912..0141b0ad53 100644
--- a/http-push.c
+++ b/http-push.c
@@ -255,7 +255,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	struct active_request_slot *slot;
 	struct http_object_request *obj_req;
 
-	obj_req = new_http_object_request(repo->url, request->obj->oid.hash);
+	obj_req = new_http_object_request(repo->url, &request->obj->oid);
 	if (obj_req == NULL) {
 		request->state = ABORTED;
 		return;
diff --git a/http-walker.c b/http-walker.c
index 0a392c85b6..29b59e2fe0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -58,7 +58,7 @@ static void start_object_request(struct walker *walker,
 	struct active_request_slot *slot;
 	struct http_object_request *req;
 
-	req = new_http_object_request(obj_req->repo->base, obj_req->oid.hash);
+	req = new_http_object_request(obj_req->repo->base, &obj_req->oid);
 	if (req == NULL) {
 		obj_req->state = ABORTED;
 		return;
@@ -543,11 +543,11 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 	} else if (req->zret != Z_STREAM_END) {
 		walker->corrupt_object_found++;
 		ret = error("File %s (%s) corrupt", hex, req->url);
-	} else if (!hasheq(obj_req->oid.hash, req->real_sha1)) {
+	} else if (!oideq(&obj_req->oid, &req->real_oid)) {
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		loose_object_path(the_repository, &buf, req->sha1);
+		loose_object_path(the_repository, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 7cfa7a16e0..e95b5b9be0 100644
--- a/http.c
+++ b/http.c
@@ -2298,9 +2298,9 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 }
 
 struct http_object_request *new_http_object_request(const char *base_url,
-	unsigned char *sha1)
+						    const struct object_id *oid)
 {
-	char *hex = sha1_to_hex(sha1);
+	char *hex = oid_to_hex(oid);
 	struct strbuf filename = STRBUF_INIT;
 	struct strbuf prevfile = STRBUF_INIT;
 	int prevlocal;
@@ -2311,10 +2311,10 @@ struct http_object_request *new_http_object_request(const char *base_url,
 
 	freq = xcalloc(1, sizeof(*freq));
 	strbuf_init(&freq->tmpfile, 0);
-	hashcpy(freq->sha1, sha1);
+	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	loose_object_path(the_repository, &filename, sha1);
+	loose_object_path(the_repository, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2456,16 +2456,16 @@ int finish_http_object_request(struct http_object_request *freq)
 	}
 
 	git_inflate_end(&freq->stream);
-	git_SHA1_Final(freq->real_sha1, &freq->c);
+	git_SHA1_Final(freq->real_oid.hash, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	if (!hasheq(freq->sha1, freq->real_sha1)) {
+	if (!oideq(&freq->oid, &freq->real_oid)) {
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	loose_object_path(the_repository, &filename, freq->sha1);
+	loose_object_path(the_repository, &filename, &freq->oid);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/http.h b/http.h
index d305ca1dc7..66c52b2e1e 100644
--- a/http.h
+++ b/http.h
@@ -224,8 +224,8 @@ struct http_object_request {
 	CURLcode curl_result;
 	char errorstr[CURL_ERROR_SIZE];
 	long http_code;
-	unsigned char sha1[20];
-	unsigned char real_sha1[20];
+	struct object_id oid;
+	struct object_id real_oid;
 	git_SHA_CTX c;
 	git_zstream stream;
 	int zret;
@@ -234,7 +234,7 @@ struct http_object_request {
 };
 
 extern struct http_object_request *new_http_object_request(
-	const char *base_url, unsigned char *sha1);
+	const char *base_url, const struct object_id *oid);
 extern void process_http_object_request(struct http_object_request *freq);
 extern int finish_http_object_request(struct http_object_request *freq);
 extern void abort_http_object_request(struct http_object_request *freq);
diff --git a/object-store.h b/object-store.h
index fecbb7e094..265d0d8e1f 100644
--- a/object-store.h
+++ b/object-store.h
@@ -151,11 +151,13 @@ void raw_object_store_clear(struct raw_object_store *o);
 
 /*
  * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified sha1.
+ * would be used to store a loose object with the specified oid.
  */
-const char *loose_object_path(struct repository *r, struct strbuf *buf, const unsigned char *sha1);
+const char *loose_object_path(struct repository *r, struct strbuf *buf,
+			      const struct object_id *oid);
 
-void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
+void *map_loose_object(struct repository *r, const struct object_id *oid,
+		       unsigned long *size);
 
 extern void *read_object_file_extended(const struct object_id *oid,
 				       enum object_type *type,
diff --git a/sha1-file.c b/sha1-file.c
index 3ddf4c9426..0705709036 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -333,12 +333,12 @@ int raceproof_create_file(const char *path, create_file_fn fn, void *cb)
 	return ret;
 }
 
-static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
+static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 {
 	int i;
 	for (i = 0; i < the_hash_algo->rawsz; i++) {
 		static char hex[] = "0123456789abcdef";
-		unsigned int val = sha1[i];
+		unsigned int val = oid->hash[i];
 		strbuf_addch(buf, hex[val >> 4]);
 		strbuf_addch(buf, hex[val & 0xf]);
 		if (!i)
@@ -348,19 +348,19 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 
 static const char *odb_loose_path(struct object_directory *odb,
 				  struct strbuf *buf,
-				  const unsigned char *sha1)
+				  const struct object_id *oid)
 {
 	strbuf_reset(buf);
 	strbuf_addstr(buf, odb->path);
 	strbuf_addch(buf, '/');
-	fill_sha1_path(buf, sha1);
+	fill_loose_path(buf, oid);
 	return buf->buf;
 }
 
 const char *loose_object_path(struct repository *r, struct strbuf *buf,
-			      const unsigned char *sha1)
+			      const struct object_id *oid)
 {
-	return odb_loose_path(r->objects->odb, buf, sha1);
+	return odb_loose_path(r->objects->odb, buf, oid);
 }
 
 /*
@@ -721,7 +721,7 @@ static int check_and_freshen_odb(struct object_directory *odb,
 				 int freshen)
 {
 	static struct strbuf path = STRBUF_INIT;
-	odb_loose_path(odb, &path, oid->hash);
+	odb_loose_path(odb, &path, oid);
 	return check_and_freshen_file(path.buf, freshen);
 }
 
@@ -879,15 +879,15 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to stat_sha1_file().
  */
-static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
-			  struct stat *st, const char **path)
+static int stat_loose_object(struct repository *r, const struct object_id *oid,
+			     struct stat *st, const char **path)
 {
 	struct object_directory *odb;
 	static struct strbuf buf = STRBUF_INIT;
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, sha1);
+		*path = odb_loose_path(odb, &buf, oid);
 		if (!lstat(*path, st))
 			return 0;
 	}
@@ -900,7 +900,7 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
  * descriptor. See the caveats on the "path" parameter above.
  */
 static int open_sha1_file(struct repository *r,
-			  const unsigned char *sha1, const char **path)
+			  const struct object_id *oid, const char **path)
 {
 	int fd;
 	struct object_directory *odb;
@@ -909,7 +909,7 @@ static int open_sha1_file(struct repository *r,
 
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
-		*path = odb_loose_path(odb, &buf, sha1);
+		*path = odb_loose_path(odb, &buf, oid);
 		fd = git_open(*path);
 		if (fd >= 0)
 			return fd;
@@ -922,19 +922,16 @@ static int open_sha1_file(struct repository *r,
 }
 
 static int quick_has_loose(struct repository *r,
-			   const unsigned char *sha1)
+			   const struct object_id *oid)
 {
-	int subdir_nr = sha1[0];
-	struct object_id oid;
+	int subdir_nr = oid->hash[0];
 	struct object_directory *odb;
 
-	hashcpy(oid.hash, sha1);
-
 	prepare_alt_odb(r);
 	for (odb = r->objects->odb; odb; odb = odb->next) {
 		odb_load_loose_cache(odb, subdir_nr);
 		if (oid_array_lookup(&odb->loose_objects_cache[subdir_nr],
-				     &oid) >= 0)
+				     oid) >= 0)
 			return 1;
 	}
 	return 0;
@@ -944,8 +941,8 @@ static int quick_has_loose(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-static void *map_sha1_file_1(struct repository *r, const char *path,
-			     const unsigned char *sha1, unsigned long *size)
+static void *map_loose_object_1(struct repository *r, const char *path,
+			     const struct object_id *oid, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -953,7 +950,7 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(r, sha1, &path);
+		fd = open_sha1_file(r, oid, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -972,10 +969,11 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file(struct repository *r,
-		    const unsigned char *sha1, unsigned long *size)
+void *map_loose_object(struct repository *r,
+		       const struct object_id *oid,
+		       unsigned long *size)
 {
-	return map_sha1_file_1(r, NULL, sha1, size);
+	return map_loose_object_1(r, NULL, oid, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
@@ -1045,7 +1043,9 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 	return -1;
 }
 
-static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
+static void *unpack_loose_rest(git_zstream *stream,
+			       void *buffer, unsigned long size,
+			       const struct object_id *oid)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmallocz(size);
@@ -1082,10 +1082,10 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
 	}
 
 	if (status < 0)
-		error(_("corrupt loose object '%s'"), sha1_to_hex(sha1));
+		error(_("corrupt loose object '%s'"), oid_to_hex(oid));
 	else if (stream->avail_in)
 		error(_("garbage at end of loose object '%s'"),
-		      sha1_to_hex(sha1));
+		      oid_to_hex(oid));
 	free(buf);
 	return NULL;
 }
@@ -1164,9 +1164,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(struct repository *r,
-				  const unsigned char *sha1,
-				  struct object_info *oi, int flags)
+static int loose_object_info(struct repository *r,
+			     const struct object_id *oid,
+			     struct object_info *oi, int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1191,15 +1191,15 @@ static int sha1_loose_object_info(struct repository *r,
 		const char *path;
 		struct stat st;
 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(r, sha1) ? 0 : -1;
-		if (stat_sha1_file(r, sha1, &st, &path) < 0)
+			return quick_has_loose(r, oid) ? 0 : -1;
+		if (stat_loose_object(r, oid, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	map = map_sha1_file(r, sha1, &mapsize);
+	map = map_loose_object(r, oid, &mapsize);
 	if (!map)
 		return -1;
 
@@ -1211,22 +1211,22 @@ static int sha1_loose_object_info(struct repository *r,
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
 		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
 			status = error(_("unable to unpack %s header with --allow-unknown-type"),
-				       sha1_to_hex(sha1));
+				       oid_to_hex(oid));
 	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error(_("unable to unpack %s header"),
-			       sha1_to_hex(sha1));
+			       oid_to_hex(oid));
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
 		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
-				       sha1_to_hex(sha1));
+				       oid_to_hex(oid));
 	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
-		status = error(_("unable to parse %s header"), sha1_to_hex(sha1));
+		status = error(_("unable to parse %s header"), oid_to_hex(oid));
 
 	if (status >= 0 && oi->contentp) {
-		*oi->contentp = unpack_sha1_rest(&stream, hdr,
-						 *oi->sizep, sha1);
+		*oi->contentp = unpack_loose_rest(&stream, hdr,
+						  *oi->sizep, oid);
 		if (!*oi->contentp) {
 			git_inflate_end(&stream);
 			status = -1;
@@ -1292,7 +1292,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 			return -1;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(r, real->hash, oi, flags))
+		if (!loose_object_info(r, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
@@ -1420,7 +1420,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("replacement %s not found for %s"),
 		    oid_to_hex(repl), oid_to_hex(oid));
 
-	if (!stat_sha1_file(the_repository, repl->hash, &st, &path))
+	if (!stat_loose_object(the_repository, repl, &st, &path))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
@@ -1620,7 +1620,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 
-	loose_object_path(the_repository, &filename, oid->hash);
+	loose_object_path(the_repository, &filename, oid);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
@@ -2196,7 +2196,7 @@ static int check_stream_sha1(git_zstream *stream,
 
 	/*
 	 * This size comparison must be "<=" to read the final zlib packets;
-	 * see the comment in unpack_sha1_rest for details.
+	 * see the comment in unpack_loose_rest for details.
 	 */
 	while (total_read <= size &&
 	       (status == Z_OK ||
@@ -2245,7 +2245,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
+	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
 		goto out;
@@ -2267,7 +2267,7 @@ int read_loose_object(const char *path,
 		if (check_stream_sha1(&stream, hdr, *size, path, expected_oid->hash) < 0)
 			goto out;
 	} else {
-		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_oid->hash);
+		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
 		if (!*contents) {
 			error(_("unable to unpack contents of %s"), path);
 			git_inflate_end(&stream);
diff --git a/streaming.c b/streaming.c
index ac7c7a22f9..9049146bc1 100644
--- a/streaming.c
+++ b/streaming.c
@@ -338,8 +338,8 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	st->u.loose.mapped = map_sha1_file(the_repository,
-					   oid->hash, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_loose_object(the_repository,
+					      oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
