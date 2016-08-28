Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC342018E
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932491AbcH1X2L (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:11 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41004 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756165AbcH1X2D (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C7D2E280AC;
        Sun, 28 Aug 2016 23:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426882;
        bh=/GhMcNPPqT4Ig35HoSF0/Qt8gtTLi0TpDadKjFpUZWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4HLUvxhu+x9nFB/B98iigy9rcmfRy0NQNuK/wLmIXLewo9sTDCNAquD72zCJSpkj
         GK1YoLjV30AyoHArPGEibxi4jHk2XzKzlhAeKq2f9nYmxMy5qTDga6FQT6r7pL7CDx
         f/TCrUNTU7dHcS/hdJh1Xw9RBpy26R/5w4QNNcHEqItBxUMPwGQY568rjCQgTn7StB
         tnAtPPr7PqtlOeblGEyZmRTNkIletsiZDw4iljAkxXWBQRW3WgYW/idHVy0RAKu1BE
         lvuF2nICFsMWKK5XfwW5KkgAkaxZ18jh4BDdgPyCXMhxySxF1xw4DgopVOTlHypklM
         ystJoVbRi2azzdkVxIvbghLoSqfGzyyvkHfquYH987HtW+LEBC4dD1sGrtP3hVOzMQ
         oePdaPIqwvX/+OwuXCd6JhGnwvXtW4wkwLoUedxBfSfTbd94kozyRuj4hc1Xmk/qnV
         6R9woHLCmS/Qcq3sKyAnwPU2RjxpjCF/EauDTuUZnuzbs3wzpLO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 06/20] builtin/cat-file: convert some static functions to struct object_id
Date:   Sun, 28 Aug 2016 23:27:43 +0000
Message-Id: <20160828232757.373278-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all of the static functions that are not callbacks to use struct
object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/cat-file.c | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 16b0b8c9..8b773787 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -23,7 +23,7 @@ struct batch_options {
 static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			int unknown_type)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	enum object_type type;
 	char *buf;
 	unsigned long size;
@@ -35,14 +35,14 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= LOOKUP_UNKNOWN_OBJECT;
 
-	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
+	if (get_sha1_with_context(obj_name, 0, oid.hash, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
 	buf = NULL;
 	switch (opt) {
 	case 't':
 		oi.typename = &sb;
-		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
+		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -53,24 +53,24 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
-		if (sha1_object_info_extended(sha1, &oi, flags) < 0)
+		if (sha1_object_info_extended(oid.hash, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		printf("%lu\n", size);
 		return 0;
 
 	case 'e':
-		return !has_sha1_file(sha1);
+		return !has_object_file(&oid);
 
 	case 'c':
 		if (!obj_context.path[0])
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
 			    obj_name);
 
-		if (textconv_object(obj_context.path, obj_context.mode, sha1, 1, &buf, &size))
+		if (textconv_object(obj_context.path, obj_context.mode, oid.hash, 1, &buf, &size))
 			break;
 
 	case 'p':
-		type = sha1_object_info(sha1, NULL);
+		type = sha1_object_info(oid.hash, NULL);
 		if (type < 0)
 			die("Not a valid object name %s", obj_name);
 
@@ -83,8 +83,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		}
 
 		if (type == OBJ_BLOB)
-			return stream_blob_to_fd(1, sha1, NULL, 0);
-		buf = read_sha1_file(sha1, &type, &size);
+			return stream_blob_to_fd(1, oid.hash, NULL, 0);
+		buf = read_sha1_file(oid.hash, &type, &size);
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 
@@ -93,19 +93,19 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 0:
 		if (type_from_string(exp_type) == OBJ_BLOB) {
-			unsigned char blob_sha1[20];
-			if (sha1_object_info(sha1, NULL) == OBJ_TAG) {
-				char *buffer = read_sha1_file(sha1, &type, &size);
+			struct object_id blob_oid;
+			if (sha1_object_info(oid.hash, NULL) == OBJ_TAG) {
+				char *buffer = read_sha1_file(oid.hash, &type, &size);
 				const char *target;
 				if (!skip_prefix(buffer, "object ", &target) ||
-				    get_sha1_hex(target, blob_sha1))
-					die("%s not a valid tag", sha1_to_hex(sha1));
+				    get_oid_hex(target, &blob_oid))
+					die("%s not a valid tag", oid_to_hex(&oid));
 				free(buffer);
 			} else
-				hashcpy(blob_sha1, sha1);
+				oidcpy(&blob_oid, &oid);
 
-			if (sha1_object_info(blob_sha1, NULL) == OBJ_BLOB)
-				return stream_blob_to_fd(1, blob_sha1, NULL, 0);
+			if (sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
+				return stream_blob_to_fd(1, blob_oid.hash, NULL, 0);
 			/*
 			 * we attempted to dereference a tag to a blob
 			 * and failed; there may be new dereference
@@ -113,7 +113,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 			 * fall-back to the usual case.
 			 */
 		}
-		buf = read_object_with_reference(sha1, exp_type, &size, NULL);
+		buf = read_object_with_reference(oid.hash, exp_type, &size, NULL);
 		break;
 
 	default:
@@ -233,28 +233,28 @@ static void batch_write(struct batch_options *opt, const void *data, int len)
 
 static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
 {
-	const unsigned char *sha1 = data->oid.hash;
+	const struct object_id *oid = &data->oid;
 
 	assert(data->info.typep);
 
 	if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
-		if (stream_blob_to_fd(1, sha1, NULL, 0) < 0)
-			die("unable to stream %s to stdout", sha1_to_hex(sha1));
+		if (stream_blob_to_fd(1, oid->hash, NULL, 0) < 0)
+			die("unable to stream %s to stdout", oid_to_hex(oid));
 	}
 	else {
 		enum object_type type;
 		unsigned long size;
 		void *contents;
 
-		contents = read_sha1_file(sha1, &type, &size);
+		contents = read_sha1_file(oid->hash, &type, &size);
 		if (!contents)
-			die("object %s disappeared", sha1_to_hex(sha1));
+			die("object %s disappeared", oid_to_hex(oid));
 		if (type != data->type)
-			die("object %s changed type!?", sha1_to_hex(sha1));
+			die("object %s changed type!?", oid_to_hex(oid));
 		if (data->info.sizep && size != data->size)
-			die("object %s changed size!?", sha1_to_hex(sha1));
+			die("object %s changed size!?", oid_to_hex(oid));
 
 		batch_write(opt, contents, size);
 		free(contents);
