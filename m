Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B086A1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeBYVNN (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:13 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34064 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751993AbeBYVNF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:13:05 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4067E60E50;
        Sun, 25 Feb 2018 21:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593182;
        bh=MyhnwcUaE6hp5Vlpyj+wRypD7P9JKXvISLEgwcR8i6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=MD725T/sU6n/gjg/eWGf42cMOtemrCUsy4pGWrtscV5N0H+NNFYeVGNlJHjekDPtz
         c1ANNHCtT8WaqtU0gaImmMDUtP7QFiP4gVjLrbnlMRisMVd1KmhHS/QQDEx0n1X+VP
         WvcdGyTHALmnL3qjRFoZd4hw1gva2+jAg3E/Bzs01xkWJCRnGkKuaFnQZ9Ax53FOlj
         QHdPq1FqVzOEKJpYDBKURKVjSjKIXFgU4/KoJuFJaP4TYWuTUlkRKj8v5Ea//dKWsC
         FctacSaJIciSb6gKchpi5KccdaMOi5sPuHktAvqj6IYo444FPWIQmAEnpgy2G9ZrVO
         fpnhqrVh1PSnYmEZGja0h2R/6Us5sSexZ+5SDD5Lk2GycQwLfJvm7cGVvD8NqzBzRy
         FEXYdcl7lv13F1xDqlHAKwHxG+3c33q8hEPCXJ5nIJoKZtNERC2zXweLP4CC4S5QOQ
         Mq2nW4Ko3wC0NlBCdg18Vtf6R52C6V41jQ/8fQ3ytZ1UVpFN95U
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 34/36] Convert lookup_replace_object to struct object_id
Date:   Sun, 25 Feb 2018 21:12:10 +0000
Message-Id: <20180225211212.477570-35-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert both the argument and the return value to be pointers to struct
object_id.  Update the callers and their internals to deal with the new
type.  Remove several temporaries which are no longer needed.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/mktag.c  |  7 ++-----
 cache.h          |  8 ++++----
 object.c         | 14 ++++----------
 replace_object.c | 14 +++++++-------
 sha1_file.c      | 44 ++++++++++++++++++++------------------------
 streaming.c      | 16 +++++-----------
 6 files changed, 42 insertions(+), 61 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index cfb777b3c8..9f5a50a8fd 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -24,14 +24,11 @@ static int verify_object(const struct object_id *oid, const char *expected_type)
 	enum object_type type;
 	unsigned long size;
 	void *buffer = read_object_file(oid, &type, &size);
-	const unsigned char *repl = lookup_replace_object(oid->hash);
+	const struct object_id *repl = lookup_replace_object(oid);
 
 	if (buffer) {
-		struct object_id reploid;
-		hashcpy(reploid.hash, repl);
-
 		if (type == type_from_string(expected_type))
-			ret = check_object_signature(&reploid, buffer, size, expected_type);
+			ret = check_object_signature(repl, buffer, size, expected_type);
 		free(buffer);
 	}
 	return ret;
diff --git a/cache.h b/cache.h
index 970d6edd04..a70c52b22f 100644
--- a/cache.h
+++ b/cache.h
@@ -1197,7 +1197,7 @@ static inline void *read_object_file(const struct object_id *oid, enum object_ty
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+extern const struct object_id *do_lookup_replace_object(const struct object_id *oid);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
@@ -1205,11 +1205,11 @@ extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
  * either sha1 or a pointer to a permanently-allocated value.  When
  * object replacement is suppressed, always return sha1.
  */
-static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
+static inline const struct object_id *lookup_replace_object(const struct object_id *oid)
 {
 	if (!check_replace_refs)
-		return sha1;
-	return do_lookup_replace_object(sha1);
+		return oid;
+	return do_lookup_replace_object(oid);
 }
 
 /* Read and unpack an object file into memory, write memory to an object file */
diff --git a/object.c b/object.c
index ea1a6f18e8..4e1c065d55 100644
--- a/object.c
+++ b/object.c
@@ -244,7 +244,7 @@ struct object *parse_object(const struct object_id *oid)
 	unsigned long size;
 	enum object_type type;
 	int eaten;
-	const unsigned char *repl = lookup_replace_object(oid->hash);
+	const struct object_id *repl = lookup_replace_object(oid);
 	void *buffer;
 	struct object *obj;
 
@@ -255,10 +255,7 @@ struct object *parse_object(const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
 	     oid_object_info(oid, NULL) == OBJ_BLOB)) {
-		struct object_id reploid;
-		hashcpy(reploid.hash, repl);
-
-		if (check_object_signature(&reploid, NULL, 0, NULL) < 0) {
+		if (check_object_signature(repl, NULL, 0, NULL) < 0) {
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
@@ -268,12 +265,9 @@ struct object *parse_object(const struct object_id *oid)
 
 	buffer = read_object_file(oid, &type, &size);
 	if (buffer) {
-		struct object_id reploid;
-		hashcpy(reploid.hash, repl);
-
-		if (check_object_signature(&reploid, buffer, size, typename(type)) < 0) {
+		if (check_object_signature(repl, buffer, size, typename(type)) < 0) {
 			free(buffer);
-			error("sha1 mismatch %s", sha1_to_hex(repl));
+			error("sha1 mismatch %s", oid_to_hex(repl));
 			return NULL;
 		}
 
diff --git a/replace_object.c b/replace_object.c
index 232e8b8550..336357394d 100644
--- a/replace_object.c
+++ b/replace_object.c
@@ -92,16 +92,16 @@ static void prepare_replace_object(void)
 #define MAXREPLACEDEPTH 5
 
 /*
- * If a replacement for object sha1 has been set up, return the
+ * If a replacement for object oid has been set up, return the
  * replacement object's name (replaced recursively, if necessary).
- * The return value is either sha1 or a pointer to a
+ * The return value is either oid or a pointer to a
  * permanently-allocated value.  This function always respects replace
  * references, regardless of the value of check_replace_refs.
  */
-const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
+const struct object_id *do_lookup_replace_object(const struct object_id *oid)
 {
 	int pos, depth = MAXREPLACEDEPTH;
-	const unsigned char *cur = sha1;
+	const struct object_id *cur = oid;
 
 	prepare_replace_object();
 
@@ -109,11 +109,11 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
 	do {
 		if (--depth < 0)
 			die("replace depth too high for object %s",
-			    sha1_to_hex(sha1));
+			    oid_to_hex(oid));
 
-		pos = replace_object_pos(cur);
+		pos = replace_object_pos(cur->hash);
 		if (0 <= pos)
-			cur = replace_object[pos]->replacement.hash;
+			cur = &replace_object[pos]->replacement;
 	} while (0 <= pos);
 
 	return cur;
diff --git a/sha1_file.c b/sha1_file.c
index 7493bc7f11..c41fbe2f01 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1227,22 +1227,18 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
 	int rtype;
-	const unsigned char *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
-				    lookup_replace_object(oid->hash) :
-				    oid->hash;
+	const struct object_id *real = (flags & OBJECT_INFO_LOOKUP_REPLACE) ?
+				       lookup_replace_object(oid) :
+				       oid;
 	int already_retried = 0;
-	struct object_id realoid;
-
-	hashcpy(realoid.hash, real);
-
-	if (is_null_sha1(real))
+	if (is_null_oid(real))
 		return -1;
 
 	if (!oi)
 		oi = &blank_oi;
 
 	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
-		struct cached_object *co = find_cached_object(real);
+		struct cached_object *co = find_cached_object(real->hash);
 		if (co) {
 			if (oi->typep)
 				*(oi->typep) = co->type;
@@ -1262,16 +1258,16 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 	}
 
 	while (1) {
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(real->hash, &e))
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(real->hash, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
 		reprepare_packed_git();
-		if (find_pack_entry(real, &e))
+		if (find_pack_entry(real->hash, &e))
 			break;
 
 		/* Check if it is a missing object */
@@ -1281,7 +1277,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 			 * TODO Investigate haveing fetch_object() return
 			 * TODO error/success and stopping the music here.
 			 */
-			fetch_object(repository_format_partial_clone, real);
+			fetch_object(repository_format_partial_clone, real->hash);
 			already_retried = 1;
 			continue;
 		}
@@ -1297,8 +1293,8 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 		return 0;
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
-		mark_bad_packed_object(e.p, real);
-		return oid_object_info_extended(&realoid, oi, 0);
+		mark_bad_packed_object(e.p, real->hash);
+		return oid_object_info_extended(real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1372,11 +1368,11 @@ void *read_object_file_extended(const struct object_id *oid,
 	const struct packed_git *p;
 	const char *path;
 	struct stat st;
-	const unsigned char *repl = lookup_replace ? lookup_replace_object(oid->hash)
-						   : oid->hash;
+	const struct object_id *repl = lookup_replace ? lookup_replace_object(oid)
+						      : oid;
 
 	errno = 0;
-	data = read_object(repl, type, size);
+	data = read_object(repl->hash, type, size);
 	if (data)
 		return data;
 
@@ -1384,17 +1380,17 @@ void *read_object_file_extended(const struct object_id *oid,
 		die_errno("failed to read object %s", oid_to_hex(oid));
 
 	/* die if we replaced an object with one that does not exist */
-	if (repl != oid->hash)
+	if (repl != oid)
 		die("replacement %s not found for %s",
-		    sha1_to_hex(repl), oid_to_hex(oid));
+		    oid_to_hex(repl), oid_to_hex(oid));
 
-	if (!stat_sha1_file(repl, &st, &path))
+	if (!stat_sha1_file(repl->hash, &st, &path))
 		die("loose object %s (stored in %s) is corrupt",
-		    sha1_to_hex(repl), path);
+		    oid_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(repl)) != NULL)
+	if ((p = has_packed_and_bad(repl->hash)) != NULL)
 		die("packed object %s (stored in %s) is corrupt",
-		    sha1_to_hex(repl), p->pack_name);
+		    oid_to_hex(repl), p->pack_name);
 
 	return NULL;
 }
diff --git a/streaming.c b/streaming.c
index 72a3ca8d08..46fabee3aa 100644
--- a/streaming.c
+++ b/streaming.c
@@ -105,19 +105,16 @@ ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
 	return st->vtbl->read(st, buf, sz);
 }
 
-static enum input_source istream_source(const unsigned char *sha1,
+static enum input_source istream_source(const struct object_id *oid,
 					enum object_type *type,
 					struct object_info *oi)
 {
 	unsigned long size;
 	int status;
-	struct object_id oid;
-
-	hashcpy(oid.hash, sha1);
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = oid_object_info_extended(&oid, oi, 0);
+	status = oid_object_info_extended(oid, oi, 0);
 	if (status < 0)
 		return stream_error;
 
@@ -140,18 +137,15 @@ struct git_istream *open_istream(const struct object_id *oid,
 {
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
-	const unsigned char *real = lookup_replace_object(oid->hash);
+	const struct object_id *real = lookup_replace_object(oid);
 	enum input_source src = istream_source(real, type, &oi);
-	struct object_id realoid;
-
-	hashcpy(realoid.hash, real);
 
 	if (src < 0)
 		return NULL;
 
 	st = xmalloc(sizeof(*st));
-	if (open_istream_tbl[src](st, &oi, &realoid, type)) {
-		if (open_istream_incore(st, &oi, &realoid, type)) {
+	if (open_istream_tbl[src](st, &oi, real, type)) {
+		if (open_istream_incore(st, &oi, real, type)) {
 			free(st);
 			return NULL;
 		}
