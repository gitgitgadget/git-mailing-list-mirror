Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0ABB1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeBYVNz (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:13:55 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33930 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751923AbeBYVMm (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3E94D60E54;
        Sun, 25 Feb 2018 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593160;
        bh=c0RgsoY6tSOq88ZbB6jV1r0ZIoecLC1NDplPS5VFc3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CzAz+60ktqa0Ntzkp0plHZyS+H53Ye77oTz8FOpVM8vsRUay/hsv1BvRejmTWrHhT
         QivHo+5g6h+UKv74iE44LBI18UxAi7OyA+HDiRIcngA6h6pntpi+e3fdiOG2+TXNsR
         9TTP8vV0MDEctU7YtUgRwRHEBXM7Nub+wbe40g9Q/sDOpYrgpzbpiPqLNfLVf7J4wy
         FipCMemJ0ah05OXJNuABxjQ2Xz+MwzzSb0ynPZ2/lgJbeqKX4agng+p6jDs3DI4+SN
         b0pCbJCQhfSliKtZY2pD0wz7+AVrIm8rIa5yWo0I9O014cWLl9NEl0pNYm2F83ZRbL
         UJB6JNBhHoF+qfb/45yaaZOSA3oPI21bJFtJBD4T+SLbYvbE2FmPYYcc5vWCH4cPXm
         wIP29rCDSriA9/f6WNtDAOQ3ACldRT0kDh22buShfxY2BGLTzUYMGqNO/18nJ26U9k
         EFwxWvzzsgTut4r5xEmkOI3TI6bTc3s8fdoGagdUVmR/OxojGhD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 16/36] archive: convert sha1_file_to_archive to struct object_id
Date:   Sun, 25 Feb 2018 21:11:52 +0000
Message-Id: <20180225211212.477570-17-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this function to take a pointer to struct object_id and rename
it object_file_to_archive.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-tar.c |  2 +-
 archive-zip.c |  4 ++--
 archive.c     | 10 +++++-----
 archive.h     |  8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 24b1ccef3a..fd622eacc0 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -281,7 +281,7 @@ static int write_tar_entry(struct archiver_args *args,
 		buffer = NULL;
 	else if (S_ISLNK(mode) || S_ISREG(mode)) {
 		enum object_type type;
-		buffer = sha1_file_to_archive(args, path, oid->hash, old_mode, &type, &size);
+		buffer = object_file_to_archive(args, path, oid, old_mode, &type, &size);
 		if (!buffer)
 			return error("cannot read %s", oid_to_hex(oid));
 	} else {
diff --git a/archive-zip.c b/archive-zip.c
index e2e5513c03..5841a6ceb6 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -344,8 +344,8 @@ static int write_zip_entry(struct archiver_args *args,
 			flags |= ZIP_STREAM;
 			out = buffer = NULL;
 		} else {
-			buffer = sha1_file_to_archive(args, path, oid->hash, mode,
-						      &type, &size);
+			buffer = object_file_to_archive(args, path, oid, mode,
+							&type, &size);
 			if (!buffer)
 				return error("cannot read %s",
 					     oid_to_hex(oid));
diff --git a/archive.c b/archive.c
index 4942b5632b..da62b2f541 100644
--- a/archive.c
+++ b/archive.c
@@ -63,16 +63,16 @@ static void format_subst(const struct commit *commit,
 	free(to_free);
 }
 
-void *sha1_file_to_archive(const struct archiver_args *args,
-			   const char *path, const unsigned char *sha1,
-			   unsigned int mode, enum object_type *type,
-			   unsigned long *sizep)
+void *object_file_to_archive(const struct archiver_args *args,
+			     const char *path, const struct object_id *oid,
+			     unsigned int mode, enum object_type *type,
+			     unsigned long *sizep)
 {
 	void *buffer;
 	const struct commit *commit = args->convert ? args->commit : NULL;
 
 	path += args->baselen;
-	buffer = read_sha1_file(sha1, type, sizep);
+	buffer = read_sha1_file(oid->hash, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
diff --git a/archive.h b/archive.h
index 741991bfb6..1f9954f7cd 100644
--- a/archive.h
+++ b/archive.h
@@ -39,9 +39,9 @@ extern int write_archive_entries(struct archiver_args *args, write_archive_entry
 extern int write_archive(int argc, const char **argv, const char *prefix, const char *name_hint, int remote);
 
 const char *archive_format_from_filename(const char *filename);
-extern void *sha1_file_to_archive(const struct archiver_args *args,
-				  const char *path, const unsigned char *sha1,
-				  unsigned int mode, enum object_type *type,
-				  unsigned long *sizep);
+extern void *object_file_to_archive(const struct archiver_args *args,
+				    const char *path, const struct object_id *oid,
+				    unsigned int mode, enum object_type *type,
+				    unsigned long *sizep);
 
 #endif	/* ARCHIVE_H */
