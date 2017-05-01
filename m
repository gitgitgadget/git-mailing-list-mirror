Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D6C1F829
	for <e@80x24.org>; Mon,  1 May 2017 02:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422977AbdEACbr (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:31:47 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36060 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642386AbdEACax (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:53 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 13613280AD;
        Mon,  1 May 2017 02:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605810;
        bh=HjklwKLzgc3zcL2tHq0cQ0H4JHE7HMzGukhXU4jtvAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BLzqgli0ILQ7nspdflkTnlOFGDlLyea8Cm8/pgTjHWEqw7QS+Y6Piny9C63pZP7PN
         RHKqlhpVaISG6RzM8waikp88CWir7lDAseJ+DjaRsMzWOZwgvn2FXcgfHjT+bOUdKA
         h327V/hrhFpoQTRVOdQofRTVVLpSOYQaP1mLvD7lbRPt88aYTJt7bfwWXNOZnyuD5k
         WTGJe+up2zcP0eHx7+4YAY/FKxIVfRlMfEESvjnn0zKA2Qe/xeaVF4pksgkht6S1K5
         T+fMWS5R4dPWu2VpOZaEFhaiJrFLp9G2ixjt9c/uVmtuwAqO2ofeIQSMXyOQjEa4Yz
         5ctcl6vlUhNAW9b7tPg+0CktWpS2jdMYMiwhnFwUNMtuf72NkNk0SuCg0gh0etwMSi
         hUxYXsnqepH0ypkw2YtS+zFWvF47HK45p6uhVN3GcEjUtV7FQ9KvoQcuqiuvr4RP99
         jhhYwpmGpdO1+Mey1rHFZrj7zLx7kDnEeIB3WIB4nmPujHLMMES
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 27/53] builtin/unpack-objects: convert to struct object_id
Date:   Mon,  1 May 2017 02:29:20 +0000
Message-Id: <20170501022946.258735-28-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert struct delta_info and struct object_info, as well as the various
functions, to use struct object_id.  Convert several hard-coded 20
values to GIT_SHA1_RAWSZ.  Among the functions converted is a caller of
lookup_blob, which we will convert shortly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/unpack-objects.c | 64 ++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4532aa083..3dc5e5691 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -127,7 +127,7 @@ static void *get_data(unsigned long size)
 }
 
 struct delta_info {
-	unsigned char base_sha1[20];
+	struct object_id base_oid;
 	unsigned nr;
 	off_t base_offset;
 	unsigned long size;
@@ -137,13 +137,13 @@ struct delta_info {
 
 static struct delta_info *delta_list;
 
-static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
+static void add_delta_to_list(unsigned nr, const struct object_id *base_oid,
 			      off_t base_offset,
 			      void *delta, unsigned long size)
 {
 	struct delta_info *info = xmalloc(sizeof(*info));
 
-	hashcpy(info->base_sha1, base_sha1);
+	oidcpy(&info->base_oid, base_oid);
 	info->base_offset = base_offset;
 	info->size = size;
 	info->delta = delta;
@@ -154,7 +154,7 @@ static void add_delta_to_list(unsigned nr, unsigned const char *base_sha1,
 
 struct obj_info {
 	off_t offset;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct object *obj;
 };
 
@@ -170,9 +170,9 @@ static unsigned nr_objects;
  */
 static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 
-	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), sha1) < 0)
+	if (write_sha1_file(obj_buf->buffer, obj_buf->size, typename(obj->type), oid.hash) < 0)
 		die("failed to write object %s", oid_to_hex(&obj->oid));
 	obj->flags |= FLAG_WRITTEN;
 }
@@ -237,19 +237,19 @@ static void write_object(unsigned nr, enum object_type type,
 			 void *buf, unsigned long size)
 {
 	if (!strict) {
-		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
+		if (write_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
 		obj_list[nr].obj = NULL;
 	} else if (type == OBJ_BLOB) {
 		struct blob *blob;
-		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
+		if (write_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash) < 0)
 			die("failed to write object");
 		added_object(nr, type, buf, size);
 		free(buf);
 
-		blob = lookup_blob(obj_list[nr].sha1);
+		blob = lookup_blob(obj_list[nr].oid.hash);
 		if (blob)
 			blob->object.flags |= FLAG_WRITTEN;
 		else
@@ -258,9 +258,9 @@ static void write_object(unsigned nr, enum object_type type,
 	} else {
 		struct object *obj;
 		int eaten;
-		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
+		hash_sha1_file(buf, size, typename(type), obj_list[nr].oid.hash);
 		added_object(nr, type, buf, size);
-		obj = parse_object_buffer(obj_list[nr].sha1, type, size, buf, &eaten);
+		obj = parse_object_buffer(obj_list[nr].oid.hash, type, size, buf, &eaten);
 		if (!obj)
 			die("invalid %s", typename(type));
 		add_object_buffer(obj, buf, size);
@@ -296,7 +296,7 @@ static void added_object(unsigned nr, enum object_type type,
 	struct delta_info *info;
 
 	while ((info = *p) != NULL) {
-		if (!hashcmp(info->base_sha1, obj_list[nr].sha1) ||
+		if (!oidcmp(&info->base_oid, &obj_list[nr].oid) ||
 		    info->base_offset == obj_list[nr].offset) {
 			*p = info->next;
 			p = &delta_list;
@@ -320,12 +320,12 @@ static void unpack_non_delta_entry(enum object_type type, unsigned long size,
 		free(buf);
 }
 
-static int resolve_against_held(unsigned nr, const unsigned char *base,
+static int resolve_against_held(unsigned nr, const struct object_id *base,
 				void *delta_data, unsigned long delta_size)
 {
 	struct object *obj;
 	struct obj_buffer *obj_buffer;
-	obj = lookup_object(base);
+	obj = lookup_object(base->hash);
 	if (!obj)
 		return 0;
 	obj_buffer = lookup_object_buffer(obj);
@@ -341,25 +341,25 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 {
 	void *delta_data, *base;
 	unsigned long base_size;
-	unsigned char base_sha1[20];
+	struct object_id base_oid;
 
 	if (type == OBJ_REF_DELTA) {
-		hashcpy(base_sha1, fill(20));
-		use(20);
+		hashcpy(base_oid.hash, fill(GIT_SHA1_RAWSZ));
+		use(GIT_SHA1_RAWSZ);
 		delta_data = get_data(delta_size);
 		if (dry_run || !delta_data) {
 			free(delta_data);
 			return;
 		}
-		if (has_sha1_file(base_sha1))
+		if (has_object_file(&base_oid))
 			; /* Ok we have this one */
-		else if (resolve_against_held(nr, base_sha1,
+		else if (resolve_against_held(nr, &base_oid,
 					      delta_data, delta_size))
 			return; /* we are done */
 		else {
 			/* cannot resolve yet --- queue it */
-			hashclr(obj_list[nr].sha1);
-			add_delta_to_list(nr, base_sha1, 0, delta_data, delta_size);
+			oidclr(&obj_list[nr].oid);
+			add_delta_to_list(nr, &base_oid, 0, delta_data, delta_size);
 			return;
 		}
 	} else {
@@ -399,8 +399,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			} else if (base_offset > obj_list[mid].offset) {
 				lo = mid + 1;
 			} else {
-				hashcpy(base_sha1, obj_list[mid].sha1);
-				base_found = !is_null_sha1(base_sha1);
+				oidcpy(&base_oid, &obj_list[mid].oid);
+				base_found = !is_null_oid(&base_oid);
 				break;
 			}
 		}
@@ -409,19 +409,19 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 			 * The delta base object is itself a delta that
 			 * has not been resolved yet.
 			 */
-			hashclr(obj_list[nr].sha1);
-			add_delta_to_list(nr, null_sha1, base_offset, delta_data, delta_size);
+			oidclr(&obj_list[nr].oid);
+			add_delta_to_list(nr, &null_oid, base_offset, delta_data, delta_size);
 			return;
 		}
 	}
 
-	if (resolve_against_held(nr, base_sha1, delta_data, delta_size))
+	if (resolve_against_held(nr, &base_oid, delta_data, delta_size))
 		return;
 
-	base = read_sha1_file(base_sha1, &type, &base_size);
+	base = read_sha1_file(base_oid.hash, &type, &base_size);
 	if (!base) {
 		error("failed to read delta-pack base object %s",
-		      sha1_to_hex(base_sha1));
+		      oid_to_hex(&base_oid));
 		if (!recover)
 			exit(1);
 		has_errors = 1;
@@ -505,7 +505,7 @@ static void unpack_all(void)
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	unsigned char sha1[20];
+	struct object_id oid;
 
 	check_replace_refs = 0;
 
@@ -566,12 +566,12 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 	git_SHA1_Init(&ctx);
 	unpack_all();
 	git_SHA1_Update(&ctx, buffer, offset);
-	git_SHA1_Final(sha1, &ctx);
+	git_SHA1_Final(oid.hash, &ctx);
 	if (strict)
 		write_rest();
-	if (hashcmp(fill(20), sha1))
+	if (hashcmp(fill(GIT_SHA1_RAWSZ), oid.hash))
 		die("final sha1 did not match");
-	use(20);
+	use(GIT_SHA1_RAWSZ);
 
 	/* Write the last part of the buffer to stdout */
 	while (len) {
