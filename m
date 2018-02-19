Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E34151F404
	for <e@80x24.org>; Mon, 19 Feb 2018 22:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbeBSW7z (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:59:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33392 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932285AbeBSW7x (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3118460B4B;
        Mon, 19 Feb 2018 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081192;
        bh=n2IZcDm/pK6ySmbhwIZ//+f2pjzj8mQ8448M+uA2y2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=JcSGwIMULfDR2r5UZtum0rhVTbu/C/iMxsDLmSfC1+oJwZYZZkPxXyFEZKW4Hh4I6
         Zc8Kfq9h1aXwwU+Ws8+0BzUoPHTJQXApEBd2JGkY3+1cZWxV5tDwoKlFt6uO4UERIq
         xk8R/DfvuWJWU/d9ORkrsg3crtHe5eMhmDDVWp5HW0o7cGLGwdws2+9ndub4mJQFlw
         mpMnFwXWSXPlEpzBqOunSvYsaMrthBzyTr0ZUNvUukoz1qG0fxc6BeFB2T3HHhKsPi
         yIOhbeYREor/DM4iViYFgqv74akLJXO4E7eRvDukdwEjKEuWNBOm9m495HF7MNbA6u
         jUcT1IDueO3DUvUTArAUFjhIJJ1tZPORDo5Icf3N0v/CXaRiXuW+99tByC2JXBpEXE
         cdCV0XeBnwA+1tdNCAZBvbMtR1GEgMJD1/VrMhoc2qytq6KXswqsj4ZbnCxp/m+VQH
         9ZgncpxDqDpsdiNt0g7bh1O9bQALYlzIp14Ny1wea7URJCoJURu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 18/36] sha1_file: convert read_loose_object to use struct object_id
Date:   Mon, 19 Feb 2018 22:59:09 +0000
Message-Id: <20180219225927.386065-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fsck.c |  2 +-
 cache.h        |  4 ++--
 sha1_file.c    | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9981db2263..57509a4eac 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -513,7 +513,7 @@ static struct object *parse_loose_object(const struct object_id *oid,
 	unsigned long size;
 	int eaten;
 
-	if (read_loose_object(path, oid->hash, &type, &size, &contents) < 0)
+	if (read_loose_object(path, oid, &type, &size, &contents) < 0)
 		return NULL;
 
 	if (!contents && type != OBJ_BLOB)
diff --git a/cache.h b/cache.h
index 09cd994bcc..8a9055f4e7 100644
--- a/cache.h
+++ b/cache.h
@@ -1241,14 +1241,14 @@ extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned l
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 /*
- * Open the loose object at path, check its sha1, and return the contents,
+ * Open the loose object at path, check its hash, and return the contents,
  * type, and size. If the object is a blob, then "contents" may return NULL,
  * to allow streaming of large blobs.
  *
  * Returns 0 on success, negative on error (details may be written to stderr).
  */
 int read_loose_object(const char *path,
-		      const unsigned char *expected_sha1,
+		      const struct object_id *expected_oid,
 		      enum object_type *type,
 		      unsigned long *size,
 		      void **contents);
diff --git a/sha1_file.c b/sha1_file.c
index c1d06c6109..69e8d27773 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2176,7 +2176,7 @@ static int check_stream_sha1(git_zstream *stream,
 }
 
 int read_loose_object(const char *path,
-		      const unsigned char *expected_sha1,
+		      const struct object_id *expected_oid,
 		      enum object_type *type,
 		      unsigned long *size,
 		      void **contents)
@@ -2208,19 +2208,19 @@ int read_loose_object(const char *path,
 	}
 
 	if (*type == OBJ_BLOB) {
-		if (check_stream_sha1(&stream, hdr, *size, path, expected_sha1) < 0)
+		if (check_stream_sha1(&stream, hdr, *size, path, expected_oid->hash) < 0)
 			goto out;
 	} else {
-		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_sha1);
+		*contents = unpack_sha1_rest(&stream, hdr, *size, expected_oid->hash);
 		if (!*contents) {
 			error("unable to unpack contents of %s", path);
 			git_inflate_end(&stream);
 			goto out;
 		}
-		if (check_sha1_signature(expected_sha1, *contents,
+		if (check_sha1_signature(expected_oid->hash, *contents,
 					 *size, typename(*type))) {
 			error("sha1 mismatch for %s (expected %s)", path,
-			      sha1_to_hex(expected_sha1));
+			      oid_to_hex(expected_oid));
 			free(*contents);
 			goto out;
 		}
