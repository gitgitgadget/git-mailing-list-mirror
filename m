Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5C01F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeBYVNx (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:53 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33954 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751931AbeBYVMq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:46 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7B50A60E56;
        Sun, 25 Feb 2018 21:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593165;
        bh=kI/xvctqTHInaV+x/u5bgYuU1dy+AxA8nabk26cFRII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=d/P4+I3geR52DDBTzTUYnXPvLI+CkkSzpOH+ipK5GdFE89mxFiPbOw9aRTUFFRtq7
         reMEKpiegv5JMNLmNWlJspN28kFz5BqVOTsTyMOdgLs4k8oFNW/x1eVNvg1qF54bWO
         jQm14xV+xhGsdUHP+VJGv9+3RqbSidX/iENUZra8Es3KsyzSpn4BnTX9myF76JzzYY
         tLIW92QR2Hx0zmDHp1qQHqOg92oSVWMQK/S+zJ0GEGVvUSonmxvzE7AA7hRFTNG1Es
         zCCx0bvtBR0R4ACSrspCJN0ZZq3RZt52jI0/3aIJ4ybLpSYob2OCL0I9APi18RVvut
         2m6cMLhC2X3VUIEZ7dXXgw0BggkHK4O7b5fUi5UCkmv2aEEEBZPOESNpJb2t6FlGiK
         M1Bvt6/dgVTClLsP50dFp7PdNkJGoUvXfzE7Ts/154rxD4C+hGwxlEo9h62k2fMBWe
         OPY/a9JBnx6RqGHexQeaeS10e+Snt/UrSfXQtENnd+uIrRNVHxA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 19/36] sha1_file: convert check_sha1_signature to struct object_id
Date:   Sun, 25 Feb 2018 21:11:55 +0000
Message-Id: <20180225211212.477570-20-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this function to take a pointer to struct object_id and rename
it check_object_signature.  Introduce temporaries to convert the return
values of lookup_replace_object and lookup_replace_object_extended into
struct object_id.

The temporaries are needed because in order to convert
lookup_replace_object, open_istream needs to be converted, and
open_istream needs check_sha1_signature to be converted, causing a loop
of dependencies.  The temporaries will be removed in a future patch.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fast-export.c |  2 +-
 builtin/index-pack.c  |  2 +-
 builtin/mktag.c       |  5 ++++-
 cache.h               |  2 +-
 object.c              | 10 ++++++++--
 pack-check.c          |  4 ++--
 sha1_file.c           | 12 ++++++------
 7 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 796d0cd66c..293a6615fa 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -240,7 +240,7 @@ static void export_blob(const struct object_id *oid)
 		buf = read_sha1_file(oid->hash, &type, &size);
 		if (!buf)
 			die ("Could not read blob %s", oid_to_hex(oid));
-		if (check_sha1_signature(oid->hash, buf, size, typename(type)) < 0)
+		if (check_object_signature(oid, buf, size, typename(type)) < 0)
 			die("sha1 mismatch in blob %s", oid_to_hex(oid));
 		object = parse_object_buffer(oid, type, size, buf, &eaten);
 	}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5c7ab47c36..e0a776f1ac 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1377,7 +1377,7 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		if (!base_obj->data)
 			continue;
 
-		if (check_sha1_signature(d->oid.hash, base_obj->data,
+		if (check_object_signature(&d->oid, base_obj->data,
 				base_obj->size, typename(type)))
 			die(_("local object %s is corrupt"), oid_to_hex(&d->oid));
 		base_obj->obj = append_obj_to_pack(f, d->oid.hash,
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 65bb41e3cd..810b24bef3 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -27,8 +27,11 @@ static int verify_object(const struct object_id *oid, const char *expected_type)
 	const unsigned char *repl = lookup_replace_object(oid->hash);
 
 	if (buffer) {
+		struct object_id reploid;
+		hashcpy(reploid.hash, repl);
+
 		if (type == type_from_string(expected_type))
-			ret = check_sha1_signature(repl, buffer, size, expected_type);
+			ret = check_object_signature(&reploid, buffer, size, expected_type);
 		free(buffer);
 	}
 	return ret;
diff --git a/cache.h b/cache.h
index 8a9055f4e7..f29ff43bbd 100644
--- a/cache.h
+++ b/cache.h
@@ -1236,7 +1236,7 @@ extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
-extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
+extern int check_object_signature(const struct object_id *oid, void *buf, unsigned long size, const char *type);
 
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
diff --git a/object.c b/object.c
index 9e6f9ff20b..c63f02a40f 100644
--- a/object.c
+++ b/object.c
@@ -255,7 +255,10 @@ struct object *parse_object(const struct object_id *oid)
 	if ((obj && obj->type == OBJ_BLOB && has_object_file(oid)) ||
 	    (!obj && has_object_file(oid) &&
 	     sha1_object_info(oid->hash, NULL) == OBJ_BLOB)) {
-		if (check_sha1_signature(repl, NULL, 0, NULL) < 0) {
+		struct object_id reploid;
+		hashcpy(reploid.hash, repl);
+
+		if (check_object_signature(&reploid, NULL, 0, NULL) < 0) {
 			error("sha1 mismatch %s", oid_to_hex(oid));
 			return NULL;
 		}
@@ -265,7 +268,10 @@ struct object *parse_object(const struct object_id *oid)
 
 	buffer = read_sha1_file(oid->hash, &type, &size);
 	if (buffer) {
-		if (check_sha1_signature(repl, buffer, size, typename(type)) < 0) {
+		struct object_id reploid;
+		hashcpy(reploid.hash, repl);
+
+		if (check_object_signature(&reploid, buffer, size, typename(type)) < 0) {
 			free(buffer);
 			error("sha1 mismatch %s", sha1_to_hex(repl));
 			return NULL;
diff --git a/pack-check.c b/pack-check.c
index 403a572567..80ef7c1c63 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -126,7 +126,7 @@ static int verify_packfile(struct packed_git *p,
 
 		if (type == OBJ_BLOB && big_file_threshold <= size) {
 			/*
-			 * Let check_sha1_signature() check it with
+			 * Let check_object_signature() check it with
 			 * the streaming interface; no point slurping
 			 * the data in-core only to discard.
 			 */
@@ -141,7 +141,7 @@ static int verify_packfile(struct packed_git *p,
 			err = error("cannot unpack %s from %s at offset %"PRIuMAX"",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name,
 				    (uintmax_t)entries[i].offset);
-		else if (check_sha1_signature(entries[i].oid.hash, data, size, typename(type)))
+		else if (check_object_signature(entries[i].oid.oid, data, size, typename(type)))
 			err = error("packed %s from %s is corrupt",
 				    oid_to_hex(entries[i].oid.oid), p->pack_name);
 		else if (fn) {
diff --git a/sha1_file.c b/sha1_file.c
index 69e8d27773..64f0905799 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -784,8 +784,8 @@ void *xmmap(void *start, size_t length,
  * With "map" == NULL, try reading the object named with "sha1" using
  * the streaming interface and rehash it to do the same.
  */
-int check_sha1_signature(const unsigned char *sha1, void *map,
-			 unsigned long size, const char *type)
+int check_object_signature(const struct object_id *oid, void *map,
+			   unsigned long size, const char *type)
 {
 	struct object_id real_oid;
 	enum object_type obj_type;
@@ -796,10 +796,10 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 
 	if (map) {
 		hash_object_file(map, size, type, &real_oid);
-		return hashcmp(sha1, real_oid.hash) ? -1 : 0;
+		return oidcmp(oid, &real_oid) ? -1 : 0;
 	}
 
-	st = open_istream(sha1, &obj_type, &size, NULL);
+	st = open_istream(oid->hash, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
 
@@ -823,7 +823,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 	}
 	the_hash_algo->final_fn(real_oid.hash, &c);
 	close_istream(st);
-	return hashcmp(sha1, real_oid.hash) ? -1 : 0;
+	return oidcmp(oid, &real_oid) ? -1 : 0;
 }
 
 int git_open_cloexec(const char *name, int flags)
@@ -2217,7 +2217,7 @@ int read_loose_object(const char *path,
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (check_sha1_signature(expected_oid->hash, *contents,
+		if (check_object_signature(expected_oid, *contents,
 					 *size, typename(*type))) {
 			error("sha1 mismatch for %s (expected %s)", path,
 			      oid_to_hex(expected_oid));
