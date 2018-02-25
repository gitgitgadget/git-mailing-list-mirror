Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404F11F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBYVMz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33944 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751924AbeBYVMp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1EE3F60E53;
        Sun, 25 Feb 2018 21:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593163;
        bh=n2IZcDm/pK6ySmbhwIZ//+f2pjzj8mQ8448M+uA2y2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=b12TbMVIyje1EsbUo7Qm/D1HycrmiibHd+PLF1Q1ftXwgmeX/tG2xZE67NWYr4bDN
         SoNxYubzIoF8ZS34hLHeOZDXirb+ftoFb/g31Yw8fLsB144emqY5IrGesVxj5+eRbW
         zj5HALmxUNllkez6v+OLQoOJ/kDsGymwvB/KOWrvnuFuCI2OsNWcOIO5YYcwEJsIug
         bNnyX3EbRz2vF55/rVBYybFbkA4WNQDoyGNPcEQ4vMWcbfzETzdyE87sgi7py/sbql
         Qc1H97GqZvnYgSw8C/x38wwMTMK8qVs4QSCzURw2zJc5xzgM6R8IkygkeGUibOJnaa
         Dfb/DFCoBg/0tQJib/3Y5kI1NPqwmLkKibWxJNouIPIkBpQtTjryOwJp1DwxGkz9et
         4H7GLMDOXolAtbNr9y7N1+aVwOWpD+0t6GQPXnFkh0yxILOzEBVaZezdZsnI0kalpY
         RdPk+c3M813/mNrvW4usEELsziiwQ5iqilmjCq1gI2vQWBWHme/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/36] sha1_file: convert read_loose_object to use struct object_id
Date:   Sun, 25 Feb 2018 21:11:54 +0000
Message-Id: <20180225211212.477570-19-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
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
