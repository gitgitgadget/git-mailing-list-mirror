Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903971F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAGIhG (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:37:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:56354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726257AbfAGIhG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:37:06 -0500
Received: (qmail 1455 invoked by uid 109); 7 Jan 2019 08:37:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:37:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 761 invoked by uid 111); 7 Jan 2019 08:36:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:36:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:37:02 -0500
Date:   Mon, 7 Jan 2019 03:37:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 05/11] sha1-file: modernize loose header/stream functions
Message-ID: <20190107083702.GE29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the open/map/close functions for loose objects that were
recently converted, the functions for parsing the loose object stream
use the name "sha1" and a bare "unsigned char *". Let's fix that so that
unpack_sha1_header() becomes unpack_loose_header(), etc.

These conversions are less clear-cut than the file access functions.
You could argue that the they are parsing Git's canonical object format
(i.e., "type size\0contents", over which we compute the hash), which is
not strictly tied to loose storage. But in practice these functions are
used only for loose objects, and using the term "loose_header" (instead
of "object_header") distinguishes it from the object header found in
packfiles (which contains the same information in a different format).

Signed-off-by: Jeff King <peff@peff.net>
---
Of course "loose_object_header" would be even more exact, but is quite
long. ;)

 cache.h     |  4 +--
 sha1-file.c | 84 +++++++++++++++++++++++++++--------------------------
 streaming.c | 12 ++++----
 3 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/cache.h b/cache.h
index 587512747b..653c36d0b7 100644
--- a/cache.h
+++ b/cache.h
@@ -1269,8 +1269,8 @@ extern char *xdg_cache_home(const char *filename);
 
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
-extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
+extern int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
+extern int parse_loose_header(const char *hdr, unsigned long *sizep);
 
 extern int check_object_signature(const struct object_id *oid, void *buf, unsigned long size, const char *type);
 
diff --git a/sha1-file.c b/sha1-file.c
index cd8e5f005a..4938258ed1 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -976,9 +976,9 @@ void *map_loose_object(struct repository *r,
 	return map_loose_object_1(r, NULL, oid, size);
 }
 
-static int unpack_sha1_short_header(git_zstream *stream,
-				    unsigned char *map, unsigned long mapsize,
-				    void *buffer, unsigned long bufsiz)
+static int unpack_loose_short_header(git_zstream *stream,
+				     unsigned char *map, unsigned long mapsize,
+				     void *buffer, unsigned long bufsiz)
 {
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
@@ -991,12 +991,12 @@ static int unpack_sha1_short_header(git_zstream *stream,
 	return git_inflate(stream, 0);
 }
 
-int unpack_sha1_header(git_zstream *stream,
-		       unsigned char *map, unsigned long mapsize,
-		       void *buffer, unsigned long bufsiz)
+int unpack_loose_header(git_zstream *stream,
+			unsigned char *map, unsigned long mapsize,
+			void *buffer, unsigned long bufsiz)
 {
-	int status = unpack_sha1_short_header(stream, map, mapsize,
-					      buffer, bufsiz);
+	int status = unpack_loose_short_header(stream, map, mapsize,
+					       buffer, bufsiz);
 
 	if (status < Z_OK)
 		return status;
@@ -1007,13 +1007,13 @@ int unpack_sha1_header(git_zstream *stream,
 	return 0;
 }
 
-static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
-					unsigned long mapsize, void *buffer,
-					unsigned long bufsiz, struct strbuf *header)
+static int unpack_loose_header_to_strbuf(git_zstream *stream, unsigned char *map,
+					 unsigned long mapsize, void *buffer,
+					 unsigned long bufsiz, struct strbuf *header)
 {
 	int status;
 
-	status = unpack_sha1_short_header(stream, map, mapsize, buffer, bufsiz);
+	status = unpack_loose_short_header(stream, map, mapsize, buffer, bufsiz);
 	if (status < Z_OK)
 		return -1;
 
@@ -1043,7 +1043,9 @@ static int unpack_sha1_header_to_strbuf(git_zstream *stream, unsigned char *map,
 	return -1;
 }
 
-static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long size, const unsigned char *sha1)
+static void *unpack_loose_rest(git_zstream *stream,
+			       void *buffer, unsigned long size,
+			       const struct object_id *oid)
 {
 	int bytes = strlen(buffer) + 1;
 	unsigned char *buf = xmallocz(size);
@@ -1080,10 +1082,10 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
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
@@ -1093,8 +1095,8 @@ static void *unpack_sha1_rest(git_zstream *stream, void *buffer, unsigned long s
  * too permissive for what we want to check. So do an anal
  * object header parse by hand.
  */
-static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
-			       unsigned int flags)
+static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
+				       unsigned int flags)
 {
 	const char *type_buf = hdr;
 	unsigned long size;
@@ -1154,12 +1156,12 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 	return *hdr ? -1 : type;
 }
 
-int parse_sha1_header(const char *hdr, unsigned long *sizep)
+int parse_loose_header(const char *hdr, unsigned long *sizep)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.sizep = sizep;
-	return parse_sha1_header_extended(hdr, &oi, 0);
+	return parse_loose_header_extended(hdr, &oi, 0);
 }
 
 static int loose_object_info(struct repository *r,
@@ -1207,24 +1209,24 @@ static int loose_object_info(struct repository *r,
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
-		if (unpack_sha1_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
+		if (unpack_loose_header_to_strbuf(&stream, map, mapsize, hdr, sizeof(hdr), &hdrbuf) < 0)
 			status = error(_("unable to unpack %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
+	} else if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
 	if (status < 0)
 		; /* Do nothing */
 	else if (hdrbuf.len) {
-		if ((status = parse_sha1_header_extended(hdrbuf.buf, oi, flags)) < 0)
+		if ((status = parse_loose_header_extended(hdrbuf.buf, oi, flags)) < 0)
 			status = error(_("unable to parse %s header with --allow-unknown-type"),
 				       oid_to_hex(oid));
-	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
+	} else if ((status = parse_loose_header_extended(hdr, oi, flags)) < 0)
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
 
 	if (status >= 0 && oi->contentp) {
-		*oi->contentp = unpack_sha1_rest(&stream, hdr,
-						 *oi->sizep, oid->hash);
+		*oi->contentp = unpack_loose_rest(&stream, hdr,
+						  *oi->sizep, oid);
 		if (!*oi->contentp) {
 			git_inflate_end(&stream);
 			status = -1;
@@ -2189,14 +2191,14 @@ void odb_clear_loose_cache(struct object_directory *odb)
 	       sizeof(odb->loose_objects_subdir_seen));
 }
 
-static int check_stream_sha1(git_zstream *stream,
-			     const char *hdr,
-			     unsigned long size,
-			     const char *path,
-			     const unsigned char *expected_sha1)
+static int check_stream_oid(git_zstream *stream,
+			    const char *hdr,
+			    unsigned long size,
+			    const char *path,
+			    const struct object_id *expected_oid)
 {
 	git_hash_ctx c;
-	unsigned char real_sha1[GIT_MAX_RAWSZ];
+	struct object_id real_oid;
 	unsigned char buf[4096];
 	unsigned long total_read;
 	int status = Z_OK;
@@ -2212,7 +2214,7 @@ static int check_stream_sha1(git_zstream *stream,
 
 	/*
 	 * This size comparison must be "<=" to read the final zlib packets;
-	 * see the comment in unpack_sha1_rest for details.
+	 * see the comment in unpack_loose_rest for details.
 	 */
 	while (total_read <= size &&
 	       (status == Z_OK ||
@@ -2228,19 +2230,19 @@ static int check_stream_sha1(git_zstream *stream,
 	git_inflate_end(stream);
 
 	if (status != Z_STREAM_END) {
-		error(_("corrupt loose object '%s'"), sha1_to_hex(expected_sha1));
+		error(_("corrupt loose object '%s'"), oid_to_hex(expected_oid));
 		return -1;
 	}
 	if (stream->avail_in) {
 		error(_("garbage at end of loose object '%s'"),
-		      sha1_to_hex(expected_sha1));
+		      oid_to_hex(expected_oid));
 		return -1;
 	}
 
-	the_hash_algo->final_fn(real_sha1, &c);
-	if (!hasheq(expected_sha1, real_sha1)) {
+	the_hash_algo->final_fn(real_oid.hash, &c);
+	if (!oideq(expected_oid, &real_oid)) {
 		error(_("sha1 mismatch for %s (expected %s)"), path,
-		      sha1_to_hex(expected_sha1));
+		      oid_to_hex(expected_oid));
 		return -1;
 	}
 
@@ -2267,12 +2269,12 @@ int read_loose_object(const char *path,
 		goto out;
 	}
 
-	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
+	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0) {
 		error(_("unable to unpack header of %s"), path);
 		goto out;
 	}
 
-	*type = parse_sha1_header(hdr, size);
+	*type = parse_loose_header(hdr, size);
 	if (*type < 0) {
 		error(_("unable to parse header of %s"), path);
 		git_inflate_end(&stream);
@@ -2280,10 +2282,10 @@ int read_loose_object(const char *path,
 	}
 
 	if (*type == OBJ_BLOB && *size > big_file_threshold) {
-		if (check_stream_sha1(&stream, hdr, *size, path, expected_oid->hash) < 0)
+		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
 			goto out;
 	} else {
-		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_oid->hash);
+		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
 		if (!*contents) {
 			error(_("unable to unpack contents of %s"), path);
 			git_inflate_end(&stream);
diff --git a/streaming.c b/streaming.c
index 9049146bc1..998e6285d7 100644
--- a/streaming.c
+++ b/streaming.c
@@ -342,12 +342,12 @@ static open_method_decl(loose)
 					      oid, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
-	if ((unpack_sha1_header(&st->z,
-				st->u.loose.mapped,
-				st->u.loose.mapsize,
-				st->u.loose.hdr,
-				sizeof(st->u.loose.hdr)) < 0) ||
-	    (parse_sha1_header(st->u.loose.hdr, &st->size) < 0)) {
+	if ((unpack_loose_header(&st->z,
+				 st->u.loose.mapped,
+				 st->u.loose.mapsize,
+				 st->u.loose.hdr,
+				 sizeof(st->u.loose.hdr)) < 0) ||
+	    (parse_loose_header(st->u.loose.hdr, &st->size) < 0)) {
 		git_inflate_end(&st->z);
 		munmap(st->u.loose.mapped, st->u.loose.mapsize);
 		return -1;
-- 
2.20.1.470.g640a3e2614

