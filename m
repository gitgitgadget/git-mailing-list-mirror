Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B17E1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 21:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbdFMVGS (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 17:06:18 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:33248 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753518AbdFMVGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 17:06:16 -0400
Received: by mail-it0-f45.google.com with SMTP id x129so3803110ite.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=J8YoGgD+noCgSkkZqtM4uOlvarm1hvoSBQd85zd0CTs=;
        b=oUdbgltF4jDFvAYBPhjyANoPnbbNtkPqH0OwdpLlS1HvK8dXCnOtDMbWfsSjGfLAZ6
         ltMNTZc+X6iO6n+1kuEU8++Cld6dI8vkpcqtPl2AGTa1XG/0hmmspeG2IqPIN5zTIQM6
         BJfQm0J/fhh3+k+TGGVt020O9mE6EZKS/ctn2jXpTsLVgQ68pELyZ/Aff6HBWcnzDgh4
         PmNeKCYxMt0OCR5R/gHItT3Iz8vBXUpW5uHpUfxs6n2GG7CgzC148il4SX5oFC9Gzmmr
         17M2q0E10I9gudYqx1FDHLzvBUaKVwicLymFaNmPA5E+FZpA8AKj/HfSs42EQ/qyXwUs
         ZGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=J8YoGgD+noCgSkkZqtM4uOlvarm1hvoSBQd85zd0CTs=;
        b=QeF2EE9MWLU2kZuZlsiFjewMCyr/qIWbZYJIAOuy3f/wcvuVHIRNL+jF9w0RL0pk0K
         cZyoPao4szpWD36UiMsJABajFbSn/7/OtzwLg++WeYrWkO/k5ksROkX4fco1XbmDqUM6
         95gKvIrcYA5647NynfZZzrc4hjlaPQkDuQ7z2DCnRPi/SFeMhTSSLxn2bv2bxqah4A7X
         W0X3c5cdeTXmxQzm+oFSPJb/a1H9JlvyZCXTeeSZQqhSGDgNTwiSIbu+9trPpPzCa1v8
         zHoIwnZUFpo622uul3Kc+nN8mBZ5uXZJ9EaFR/RXSPax1Ma4fDr7S3TR/1Zb4l7Ru9Xh
         hJMg==
X-Gm-Message-State: AODbwcAnJQ8FWxTma1lWSg6hgpVU+EfUemQtMCXXoFRew0yCwEqP/WGd
        hMXSprXfQliNOzhRxFsxjA==
X-Received: by 10.36.192.197 with SMTP id u188mr20228112itf.39.1497387974959;
        Tue, 13 Jun 2017 14:06:14 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id d185sm6885228ioe.38.2017.06.13.14.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 14:06:13 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 3/4] sha1_file: consolidate storage-agnostic object fns
Date:   Tue, 13 Jun 2017 14:05:59 -0700
Message-Id: <33a75a60b1d4298ec0af21c0df19e12bb0e43e2d.1497387714.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <cover.1497387713.git.jonathantanmy@google.com>
References: <cover.1497387713.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497387713.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497387713.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In sha1_file.c, there are a few functions that provide information on an
object regardless of its storage (cached, loose, or packed). Looking
through all non-static functions in sha1_file.c that take in an unsigned
char * pointer, the relevant ones are:
 - sha1_object_info_extended
 - sha1_object_info (auto-fixed by sha1_object_info_extended)
 - read_sha1_file_extended (uses read_object)
 - read_object_with_reference (auto-fixed by read_sha1_file_extended)
 - has_sha1_file_with_flags
 - assert_sha1_type (auto-fixed by sha1_object_info)

Looking at the 3 primary functions (sha1_object_info_extended,
read_object, has_sha1_file_with_flags), they independently implement
mechanisms such as object replacement, retrying the packed store after
failing to find the object in the packed store then the loose store, and
being able to mark a packed object as bad and then retrying the whole
process. Consolidating these mechanisms would be a great help to
maintainability.

Therefore, consolidate all 3 functions by extending
sha1_object_info_extended() to support the functionality needed by all 3
functions, and then modifying the other 2 to use
sha1_object_info_extended().

Note that has_sha1_file_with_flags() does not try cached storage,
whereas the other 2 functions do - this functionality is preserved.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |   7 +++
 sha1_file.c | 143 +++++++++++++++++++++++++++++++-----------------------------
 2 files changed, 81 insertions(+), 69 deletions(-)

diff --git a/cache.h b/cache.h
index 4d92aae0e..3c85867c3 100644
--- a/cache.h
+++ b/cache.h
@@ -1835,6 +1835,7 @@ struct object_info {
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
+	void **contentp;
 
 	/* Response */
 	enum {
@@ -1866,6 +1867,12 @@ struct object_info {
  */
 #define OBJECT_INFO_INIT {NULL}
 
+/*
+ * sha1_object_info_extended() supports the LOOKUP_ flags and the OBJECT_INFO_
+ * flags.
+ */
+#define OBJECT_INFO_QUICK 4
+#define OBJECT_INFO_SKIP_CACHED 8
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
 
diff --git a/sha1_file.c b/sha1_file.c
index a158907d1..98086e21e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2005,19 +2005,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
 }
 
-static void *unpack_sha1_file(void *map, unsigned long mapsize, enum object_type *type, unsigned long *size, const unsigned char *sha1)
-{
-	int ret;
-	git_zstream stream;
-	char hdr[8192];
-
-	ret = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
-	if (ret < Z_OK || (*type = parse_sha1_header(hdr, size)) < 0)
-		return NULL;
-
-	return unpack_sha1_rest(&stream, hdr, *size, sha1);
-}
-
 unsigned long get_size_from_delta(struct packed_git *p,
 				  struct pack_window **w_curs,
 			          off_t curpos)
@@ -2326,8 +2313,10 @@ static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
 	if (!ent)
 		return unpack_entry(p, base_offset, type, base_size);
 
-	*type = ent->type;
-	*base_size = ent->size;
+	if (type)
+		*type = ent->type;
+	if (base_size)
+		*base_size = ent->size;
 	return xmemdupz(ent->data, ent->size);
 }
 
@@ -2388,9 +2377,16 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
 	 * We always get the representation type, but only convert it to
 	 * a "real" type later if the caller is interested.
 	 */
-	type = unpack_object_header(p, &w_curs, &curpos, &size);
+	if (oi->contentp) {
+		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
+						      &type);
+		if (!*oi->contentp)
+			type = OBJ_BAD;
+	} else {
+		type = unpack_object_header(p, &w_curs, &curpos, &size);
+	}
 
-	if (oi->sizep) {
+	if (!oi->contentp && oi->sizep) {
 		if (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 			off_t tmp_pos = curpos;
 			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
@@ -2685,8 +2681,10 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		free(external_base);
 	}
 
-	*final_type = type;
-	*final_size = size;
+	if (final_type)
+		*final_type = type;
+	if (final_size)
+		*final_size = size;
 
 	unuse_pack(&w_curs);
 
@@ -2920,6 +2918,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	git_zstream stream;
 	char hdr[32];
 	struct strbuf hdrbuf = STRBUF_INIT;
+	unsigned long size_scratch;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -2932,7 +2931,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->typename && !oi->sizep) {
+	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
 		if (stat_sha1_file(sha1, &st, &path) < 0)
@@ -2945,6 +2944,10 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return -1;
+
+	if (!oi->sizep)
+		oi->sizep = &size_scratch;
+
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 	if ((flags & LOOKUP_UNKNOWN_OBJECT)) {
@@ -2962,50 +2965,71 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 				       sha1_to_hex(sha1));
 	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
 		status = error("unable to parse %s header", sha1_to_hex(sha1));
-	git_inflate_end(&stream);
+
+	if (status >= 0 && oi->contentp)
+		*oi->contentp = unpack_sha1_rest(&stream, hdr,
+						 *oi->sizep, sha1);
+	else
+		git_inflate_end(&stream);
+
 	munmap(map, mapsize);
 	if (status && oi->typep)
 		*oi->typep = status;
+	if (oi->sizep == &size_scratch)
+		oi->sizep = NULL;
 	strbuf_release(&hdrbuf);
 	return (status < 0) ? status : 0;
 }
 
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi, unsigned flags)
 {
-	struct cached_object *co;
 	struct pack_entry e;
 	int rtype;
 	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
 
-	co = find_cached_object(real);
-	if (co) {
-		if (oi->typep)
-			*(oi->typep) = co->type;
-		if (oi->sizep)
-			*(oi->sizep) = co->size;
-		if (oi->disk_sizep)
-			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_sha1)
-			hashclr(oi->delta_base_sha1);
-		if (oi->typename)
-			strbuf_addstr(oi->typename, typename(co->type));
-		oi->whence = OI_CACHED;
-		return 0;
+	if (!(flags & OBJECT_INFO_SKIP_CACHED)) {
+		struct cached_object *co = find_cached_object(real);
+		if (co) {
+			if (!oi)
+				return 0;
+			if (oi->typep)
+				*(oi->typep) = co->type;
+			if (oi->sizep)
+				*(oi->sizep) = co->size;
+			if (oi->disk_sizep)
+				*(oi->disk_sizep) = 0;
+			if (oi->delta_base_sha1)
+				hashclr(oi->delta_base_sha1);
+			if (oi->typename)
+				strbuf_addstr(oi->typename, typename(co->type));
+			if (oi->contentp)
+				*oi->contentp = xmemdupz(co->buf, co->size);
+			oi->whence = OI_CACHED;
+			return 0;
+		}
 	}
 
 	if (!find_pack_entry(real, &e)) {
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags)) {
+		if (oi && !sha1_loose_object_info(real, oi, flags)) {
 			oi->whence = OI_LOOSE;
 			return 0;
 		}
+		if (!oi && has_loose_object(real))
+			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-		reprepare_packed_git();
-		if (!find_pack_entry(real, &e))
+		if (flags & OBJECT_INFO_QUICK) {
 			return -1;
+		} else {
+			reprepare_packed_git();
+			if (!find_pack_entry(real, &e))
+				return -1;
+		}
 	}
 
+	if (!oi)
+		return 0;
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
@@ -3081,28 +3105,15 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 static void *read_object(const unsigned char *sha1, enum object_type *type,
 			 unsigned long *size)
 {
-	unsigned long mapsize;
-	void *map, *buf;
-	struct cached_object *co;
-
-	co = find_cached_object(sha1);
-	if (co) {
-		*type = co->type;
-		*size = co->size;
-		return xmemdupz(co->buf, co->size);
-	}
+	struct object_info oi = OBJECT_INFO_INIT;
+	void *content;
+	oi.typep = type;
+	oi.sizep = size;
+	oi.contentp = &content;
 
-	buf = read_packed_sha1(sha1, type, size);
-	if (buf)
-		return buf;
-	map = map_sha1_file(sha1, &mapsize);
-	if (map) {
-		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
-		munmap(map, mapsize);
-		return buf;
-	}
-	reprepare_packed_git();
-	return read_packed_sha1(sha1, type, size);
+	if (sha1_object_info_extended(sha1, &oi, 0))
+		return NULL;
+	return content;
 }
 
 /*
@@ -3480,18 +3491,12 @@ int has_sha1_pack(const unsigned char *sha1)
 
 int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 {
-	struct pack_entry e;
+	int f = OBJECT_INFO_SKIP_CACHED |
+		((flags & HAS_SHA1_QUICK) ? OBJECT_INFO_QUICK : 0);
 
 	if (!startup_info->have_repository)
 		return 0;
-	if (find_pack_entry(sha1, &e))
-		return 1;
-	if (has_loose_object(sha1))
-		return 1;
-	if (flags & HAS_SHA1_QUICK)
-		return 0;
-	reprepare_packed_git();
-	return find_pack_entry(sha1, &e);
+	return !sha1_object_info_extended(sha1, NULL, f);
 }
 
 int has_object_file(const struct object_id *oid)
-- 
2.13.1.518.g3df882009-goog

