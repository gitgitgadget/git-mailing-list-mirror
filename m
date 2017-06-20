Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737B91FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 01:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdFTBDc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 21:03:32 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34004 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752774AbdFTBDa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 21:03:30 -0400
Received: by mail-pg0-f43.google.com with SMTP id e187so3194761pgc.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 18:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=fe4c8TIJkA+ELLJwv74/Uz1A23jTFP8WwAqnbEfd8i0=;
        b=TMhhldSdiwBkFRQWZm4xP78BYVItksEMjiTQeci5AUdobGto9ExS9IGF1Ex7sI08ax
         cuMgL7buywoThpJsXb0UVTY34CXNRVRbi+nPFjXWYvdQf+gnYf92B+B8oUfD2pk90Byn
         UPP1WJILliEGE/wdQtsGU/DpAQibkywHd4SbCjjkDzDlv5v8vSaaoyfb0NfhhXIqsKO1
         hz9z634k+ssNjpgZqU7CIqorCGGwaS2HfrxbrPSOR92xA6IsWqgkpLH8fQJgjPJdt3DO
         vkYoXL1sOFFXb1N+SwyKrE+36bU+mKLPMJC/8RYutiYTs5yhNGtOxXBTyw9NDz3HGCes
         eFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=fe4c8TIJkA+ELLJwv74/Uz1A23jTFP8WwAqnbEfd8i0=;
        b=VfXD3/oc/0RyNmNByJbtU5og34frTHBgQ6VvXT76JXaTUvQBj78cvrRTwDGNsSOaet
         J6hk6gg8j+mM+JtCZA0SCQIeBqx/YNeFuBBh1w0wd/rV335tnivgrrMrX8j3hJ6GejcG
         BiDd2mQ5hRUTVLwu8OBrQCW4dCdAjWpkKoXxXz5cXp8yMoEtMJy6MJZrmHFknp6g+bjz
         EVMmVUuVhpYCNdsAKV0HUkHop4afFbIGUtaWhEjeWDC9Vdqf5qhHOuCS6tj8HngayHiG
         7HXe8EVP43DAF4Kc4+WaRe+gOl7/dyg984wc9Ix9fv3ULvuRzIKnNuViLYwPm7DeAAAG
         TV2w==
X-Gm-Message-State: AKS2vOzZQiznoIKCfv34wrbSIYyKPgn5h+kniSUEXAV+ZrZbxJsUyqKK
        fp1SzKOQcBH+bnA58+CnZw==
X-Received: by 10.84.140.133 with SMTP id 5mr33154372plt.224.1497920609220;
        Mon, 19 Jun 2017 18:03:29 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id l63sm22249819pfc.132.2017.06.19.18.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 18:03:28 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v4 5/8] sha1_file: refactor read_object
Date:   Mon, 19 Jun 2017 18:03:12 -0700
Message-Id: <73d085b6fad9316c5a500341db2dd6451700656e.1497920092.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1-goog
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497920092.git.jonathantanmy@google.com>
In-Reply-To: <cover.1497920092.git.jonathantanmy@google.com>
References: <cover.1497035376.git.jonathantanmy@google.com> <cover.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_object() and sha1_object_info_extended() both implement mechanisms
such as object replacement, retrying the packed store after failing to
find the object in the packed store then the loose store, and being able
to mark a packed object as bad and then retrying the whole process.
Consolidating these mechanisms would be a great help to maintainability.

Therefore, consolidate them by extending sha1_object_info_extended() to
support the functionality needed, and then modifying read_object() to
use sha1_object_info_extended().

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 cache.h     |  1 +
 sha1_file.c | 84 ++++++++++++++++++++++++++++++-------------------------------
 2 files changed, 43 insertions(+), 42 deletions(-)

diff --git a/cache.h b/cache.h
index a3631b237..48aea923b 100644
--- a/cache.h
+++ b/cache.h
@@ -1827,6 +1827,7 @@ struct object_info {
 	off_t *disk_sizep;
 	unsigned char *delta_base_sha1;
 	struct strbuf *typename;
+	void **contentp;
 
 	/* Response */
 	enum {
diff --git a/sha1_file.c b/sha1_file.c
index a7be45efe..4d5033c48 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2005,19 +2005,6 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
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
@@ -2679,8 +2675,10 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
 		free(external_base);
 	}
 
-	*final_type = type;
-	*final_size = size;
+	if (final_type)
+		*final_type = type;
+	if (final_size)
+		*final_size = size;
 
 	unuse_pack(&w_curs);
 
@@ -2914,6 +2912,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	git_zstream stream;
 	char hdr[32];
 	struct strbuf hdrbuf = STRBUF_INIT;
+	unsigned long size_scratch;
 
 	if (oi->delta_base_sha1)
 		hashclr(oi->delta_base_sha1);
@@ -2926,7 +2925,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	 * return value implicitly indicates whether the
 	 * object even exists.
 	 */
-	if (!oi->typep && !oi->typename && !oi->sizep) {
+	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
 		const char *path;
 		struct stat st;
 		if (stat_sha1_file(sha1, &st, &path) < 0)
@@ -2939,6 +2938,10 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	map = map_sha1_file(sha1, &mapsize);
 	if (!map)
 		return -1;
+
+	if (!oi->sizep)
+		oi->sizep = &size_scratch;
+
 	if (oi->disk_sizep)
 		*oi->disk_sizep = mapsize;
 	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
@@ -2956,10 +2959,18 @@ static int sha1_loose_object_info(const unsigned char *sha1,
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
@@ -2985,6 +2996,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			hashclr(oi->delta_base_sha1);
 		if (oi->typename)
 			strbuf_addstr(oi->typename, typename(co->type));
+		if (oi->contentp)
+			*oi->contentp = xmemdupz(co->buf, co->size);
 		oi->whence = OI_CACHED;
 		return 0;
 	}
@@ -3077,28 +3090,15 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
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
-- 
2.13.1.611.g7e3b11ae1-goog

