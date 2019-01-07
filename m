Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B36D1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfAGIfq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:35:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:56344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725550AbfAGIfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:35:46 -0500
Received: (qmail 1327 invoked by uid 109); 7 Jan 2019 08:35:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:35:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 742 invoked by uid 111); 7 Jan 2019 08:35:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:35:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:35:43 -0500
Date:   Mon, 7 Jan 2019 03:35:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 04/11] sha1-file: modernize loose object file functions
Message-ID: <20190107083542.GD29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The loose object access code in sha1-file.c is some of the oldest in
Git, and could use some modernizing. It mostly uses "unsigned char *"
for object ids, which these days should be "struct object_id".

It also uses the term "sha1_file" in many functions, which is confusing.
The term "loose_objects" is much better. It clearly distinguishes
them from packed objects (which didn't even exist back when the name
"sha1_file" came into being). And it also distinguishes it from the
checksummed-file concept in csum-file.c (which until recently was
actually called "struct sha1file"!).

This patch converts the functions {open,close,map,stat}_sha1_file() into
open_loose_object(), etc, and switches their sha1 arguments for
object_id structs. Similarly, path functions like fill_sha1_path()
become fill_loose_path() and use object_ids.

The function sha1_loose_object_info() already says "loose", so we can
just drop the "sha1" (and teach it to use object_id).

Signed-off-by: Jeff King <peff@peff.net>
---
 http-walker.c  |  2 +-
 http.c         |  4 +--
 object-store.h |  8 +++--
 sha1-file.c    | 81 +++++++++++++++++++++++++-------------------------
 streaming.c    |  4 +--
 5 files changed, 51 insertions(+), 48 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 856716c63d..29b59e2fe0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -547,7 +547,7 @@ static int fetch_object(struct walker *walker, unsigned char *sha1)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		loose_object_path(the_repository, &buf, req->oid.hash);
+		loose_object_path(the_repository, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 8d42154792..43d06dd074 100644
--- a/http.c
+++ b/http.c
@@ -2353,7 +2353,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	loose_object_path(the_repository, &filename, oid->hash);
+	loose_object_path(the_repository, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2504,7 +2504,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	loose_object_path(the_repository, &filename, freq->oid.hash);
+	loose_object_path(the_repository, &filename, &freq->oid);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-store.h b/object-store.h
index 2fb6c0e4db..6b1c408753 100644
--- a/object-store.h
+++ b/object-store.h
@@ -161,11 +161,13 @@ void raw_object_store_clear(struct raw_object_store *o);
 
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
index e86bb28320..cd8e5f005a 100644
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
 
@@ -872,22 +872,22 @@ int git_open_cloexec(const char *name, int flags)
 }
 
 /*
- * Find "sha1" as a loose object in the local repository or in an alternate.
+ * Find "oid" as a loose object in the local repository or in an alternate.
  * Returns 0 on success, negative on failure.
  *
  * The "path" out-parameter will give the path of the object we found (if any).
  * Note that it may point to static storage and is only valid until another
- * call to stat_sha1_file().
+ * call to stat_loose_object().
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
@@ -896,11 +896,11 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
 }
 
 /*
- * Like stat_sha1_file(), but actually open the object and return the
+ * Like stat_loose_object(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(struct repository *r,
-			  const unsigned char *sha1, const char **path)
+static int open_loose_object(struct repository *r,
+			     const struct object_id *oid, const char **path)
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
@@ -939,10 +939,10 @@ static int quick_has_loose(struct repository *r,
 
 /*
  * Map the loose object at "path" if it is not NULL, or the path found by
- * searching for a loose object named "sha1".
+ * searching for a loose object named "oid".
  */
-static void *map_sha1_file_1(struct repository *r, const char *path,
-			     const unsigned char *sha1, unsigned long *size)
+static void *map_loose_object_1(struct repository *r, const char *path,
+			     const struct object_id *oid, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -950,7 +950,7 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(r, sha1, &path);
+		fd = open_loose_object(r, oid, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
@@ -969,10 +969,11 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
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
@@ -1161,9 +1162,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
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
@@ -1188,15 +1189,15 @@ static int sha1_loose_object_info(struct repository *r,
 		const char *path;
 		struct stat st;
 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(r, sha1) ? 0 : -1;
-		if (stat_sha1_file(r, sha1, &st, &path) < 0)
+			return quick_has_loose(r, oid->hash) ? 0 : -1;
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
 
@@ -1208,22 +1209,22 @@ static int sha1_loose_object_info(struct repository *r,
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
 		*oi->contentp = unpack_sha1_rest(&stream, hdr,
-						 *oi->sizep, sha1);
+						 *oi->sizep, oid->hash);
 		if (!*oi->contentp) {
 			git_inflate_end(&stream);
 			status = -1;
@@ -1289,7 +1290,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
 			return -1;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(r, real->hash, oi, flags))
+		if (!loose_object_info(r, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
@@ -1417,7 +1418,7 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("replacement %s not found for %s"),
 		    oid_to_hex(repl), oid_to_hex(oid));
 
-	if (!stat_sha1_file(the_repository, repl->hash, &st, &path))
+	if (!stat_loose_object(the_repository, repl, &st, &path))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
@@ -1552,7 +1553,7 @@ int hash_object_file(const void *buf, unsigned long len, const char *type,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_sha1_file(int fd)
+static void close_loose_object(int fd)
 {
 	if (fsync_object_files)
 		fsync_or_die(fd, "sha1 file");
@@ -1617,7 +1618,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 
-	loose_object_path(the_repository, &filename, oid->hash);
+	loose_object_path(the_repository, &filename, oid);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
@@ -1665,7 +1666,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_sha1_file(fd);
+	close_loose_object(fd);
 
 	if (mtime) {
 		struct utimbuf utb;
@@ -2260,7 +2261,7 @@ int read_loose_object(const char *path,
 
 	*contents = NULL;
 
-	map = map_sha1_file_1(the_repository, path, NULL, &mapsize);
+	map = map_loose_object_1(the_repository, path, NULL, &mapsize);
 	if (!map) {
 		error_errno(_("unable to mmap %s"), path);
 		goto out;
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
-- 
2.20.1.470.g640a3e2614

