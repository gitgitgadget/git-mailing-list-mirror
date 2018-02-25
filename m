Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523CA1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 21:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeBYVMu (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 16:12:50 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751926AbeBYVMk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 25 Feb 2018 16:12:40 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1FBCF60E53;
        Sun, 25 Feb 2018 21:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519593159;
        bh=J+XoN/fd19x19dZ2+lsmSJJOuE0yra2npyO0zF4/Tb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0abOvtRWOifX157LZ6UOHcP6127n3JV3nQlaVPMGCYIFl4rT7Ysnx+X464JtAhGP2
         j9nebGhqreXCcNHIzeT+L38JptgASoMBrr0a9Yz9P6XxJcYy5d+ABVUOxTIryUgSAy
         oujEA6YQxMw/wPQQ3hT9x6KucaUQ1ulzRWWDoPWcgMaGz5mFE2R2NwPd7DTHJNmbZ6
         /hnzhXc1drCehp1wFG+Fw7R6syu5Fz0azYGejzeTzmYDjimgE0pussUnUu5KTXgXaT
         uo0wciejGG6mKpFviG97kxkKd7MclelUXTejZKp0edVZnT2EhAZzaoFfQEws8cs8NP
         g9gptLpoRTV3krPKsS4Fts0+PlLunkTQ2EIcBeKsTLPjw2EePxypilDahEHHWqmwRp
         A2KONGsyUo/1MDBSs4VavTb2LVpYbTaS9KiU5BK4K/S/hDdCFhghDpkGrBZhGQPWf/
         l2UODJjQwUNYqtpcFvd6WZ3Mb07Zr5uir1HlgzE7PTAQeHzanS9
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 15/36] archive: convert write_archive_entry_fn_t to object_id
Date:   Sun, 25 Feb 2018 21:11:51 +0000
Message-Id: <20180225211212.477570-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd
In-Reply-To: <20180225211212.477570-1-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the write_archive_entry_fn_t type to use a pointer to struct
object_id.  Convert various static functions in the tar and zip
archivers also.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-tar.c | 28 ++++++++++++++--------------
 archive-zip.c | 16 ++++++++--------
 archive.c     | 12 ++++++------
 archive.h     |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index c6ed96ee74..24b1ccef3a 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -111,7 +111,7 @@ static void write_trailer(void)
  * queues up writes, so that all our write(2) calls write exactly one
  * full block; pads writes to RECORDSIZE
  */
-static int stream_blocked(const unsigned char *sha1)
+static int stream_blocked(const struct object_id *oid)
 {
 	struct git_istream *st;
 	enum object_type type;
@@ -119,9 +119,9 @@ static int stream_blocked(const unsigned char *sha1)
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
-	st = open_istream(sha1, &type, &sz, NULL);
+	st = open_istream(oid->hash, &type, &sz, NULL);
 	if (!st)
-		return error("cannot stream blob %s", sha1_to_hex(sha1));
+		return error("cannot stream blob %s", oid_to_hex(oid));
 	for (;;) {
 		readlen = read_istream(st, buf, sizeof(buf));
 		if (readlen <= 0)
@@ -218,7 +218,7 @@ static void prepare_header(struct archiver_args *args,
 }
 
 static void write_extended_header(struct archiver_args *args,
-				  const unsigned char *sha1,
+				  const struct object_id *oid,
 				  const void *buffer, unsigned long size)
 {
 	struct ustar_header header;
@@ -226,14 +226,14 @@ static void write_extended_header(struct archiver_args *args,
 	memset(&header, 0, sizeof(header));
 	*header.typeflag = TYPEFLAG_EXT_HEADER;
 	mode = 0100666;
-	xsnprintf(header.name, sizeof(header.name), "%s.paxheader", sha1_to_hex(sha1));
+	xsnprintf(header.name, sizeof(header.name), "%s.paxheader", oid_to_hex(oid));
 	prepare_header(args, &header, mode, size);
 	write_blocked(&header, sizeof(header));
 	write_blocked(buffer, size);
 }
 
 static int write_tar_entry(struct archiver_args *args,
-			   const unsigned char *sha1,
+			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode)
 {
@@ -257,7 +257,7 @@ static int write_tar_entry(struct archiver_args *args,
 		mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)",
-			     mode, sha1_to_hex(sha1));
+			     mode, oid_to_hex(oid));
 	}
 	if (pathlen > sizeof(header.name)) {
 		size_t plen = get_path_prefix(path, pathlen,
@@ -268,7 +268,7 @@ static int write_tar_entry(struct archiver_args *args,
 			memcpy(header.name, path + plen + 1, rest);
 		} else {
 			xsnprintf(header.name, sizeof(header.name), "%s.data",
-				  sha1_to_hex(sha1));
+				  oid_to_hex(oid));
 			strbuf_append_ext_header(&ext_header, "path",
 						 path, pathlen);
 		}
@@ -276,14 +276,14 @@ static int write_tar_entry(struct archiver_args *args,
 		memcpy(header.name, path, pathlen);
 
 	if (S_ISREG(mode) && !args->convert &&
-	    sha1_object_info(sha1, &size) == OBJ_BLOB &&
+	    sha1_object_info(oid->hash, &size) == OBJ_BLOB &&
 	    size > big_file_threshold)
 		buffer = NULL;
 	else if (S_ISLNK(mode) || S_ISREG(mode)) {
 		enum object_type type;
-		buffer = sha1_file_to_archive(args, path, sha1, old_mode, &type, &size);
+		buffer = sha1_file_to_archive(args, path, oid->hash, old_mode, &type, &size);
 		if (!buffer)
-			return error("cannot read %s", sha1_to_hex(sha1));
+			return error("cannot read %s", oid_to_hex(oid));
 	} else {
 		buffer = NULL;
 		size = 0;
@@ -292,7 +292,7 @@ static int write_tar_entry(struct archiver_args *args,
 	if (S_ISLNK(mode)) {
 		if (size > sizeof(header.linkname)) {
 			xsnprintf(header.linkname, sizeof(header.linkname),
-				  "see %s.paxheader", sha1_to_hex(sha1));
+				  "see %s.paxheader", oid_to_hex(oid));
 			strbuf_append_ext_header(&ext_header, "linkpath",
 			                         buffer, size);
 		} else
@@ -308,7 +308,7 @@ static int write_tar_entry(struct archiver_args *args,
 	prepare_header(args, &header, mode, size_in_header);
 
 	if (ext_header.len > 0) {
-		write_extended_header(args, sha1, ext_header.buf,
+		write_extended_header(args, oid, ext_header.buf,
 				      ext_header.len);
 	}
 	strbuf_release(&ext_header);
@@ -317,7 +317,7 @@ static int write_tar_entry(struct archiver_args *args,
 		if (buffer)
 			write_blocked(buffer, size);
 		else
-			err = stream_blocked(sha1);
+			err = stream_blocked(oid);
 	}
 	free(buffer);
 	return err;
diff --git a/archive-zip.c b/archive-zip.c
index e8913e5a26..e2e5513c03 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -276,7 +276,7 @@ static int entry_is_binary(const char *path, const void *buffer, size_t size)
 #define STREAM_BUFFER_SIZE (1024 * 16)
 
 static int write_zip_entry(struct archiver_args *args,
-			   const unsigned char *sha1,
+			   const struct object_id *oid,
 			   const char *path, size_t pathlen,
 			   unsigned int mode)
 {
@@ -314,7 +314,7 @@ static int write_zip_entry(struct archiver_args *args,
 
 	if (pathlen > 0xffff) {
 		return error("path too long (%d chars, SHA1: %s): %s",
-				(int)pathlen, sha1_to_hex(sha1), path);
+				(int)pathlen, oid_to_hex(oid), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
@@ -325,7 +325,7 @@ static int write_zip_entry(struct archiver_args *args,
 		compressed_size = 0;
 		buffer = NULL;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
-		enum object_type type = sha1_object_info(sha1, &size);
+		enum object_type type = sha1_object_info(oid->hash, &size);
 
 		method = 0;
 		attr2 = S_ISLNK(mode) ? ((mode | 0777) << 16) :
@@ -337,18 +337,18 @@ static int write_zip_entry(struct archiver_args *args,
 
 		if (S_ISREG(mode) && type == OBJ_BLOB && !args->convert &&
 		    size > big_file_threshold) {
-			stream = open_istream(sha1, &type, &size, NULL);
+			stream = open_istream(oid->hash, &type, &size, NULL);
 			if (!stream)
 				return error("cannot stream blob %s",
-					     sha1_to_hex(sha1));
+					     oid_to_hex(oid));
 			flags |= ZIP_STREAM;
 			out = buffer = NULL;
 		} else {
-			buffer = sha1_file_to_archive(args, path, sha1, mode,
+			buffer = sha1_file_to_archive(args, path, oid->hash, mode,
 						      &type, &size);
 			if (!buffer)
 				return error("cannot read %s",
-					     sha1_to_hex(sha1));
+					     oid_to_hex(oid));
 			crc = crc32(crc, buffer, size);
 			is_binary = entry_is_binary(path_without_prefix,
 						    buffer, size);
@@ -357,7 +357,7 @@ static int write_zip_entry(struct archiver_args *args,
 		compressed_size = (method == 0) ? size : 0;
 	} else {
 		return error("unsupported file mode: 0%o (SHA1: %s)", mode,
-				sha1_to_hex(sha1));
+				oid_to_hex(oid));
 	}
 
 	if (creator_version > max_creator_version)
diff --git a/archive.c b/archive.c
index e664cdb624..4942b5632b 100644
--- a/archive.c
+++ b/archive.c
@@ -121,7 +121,7 @@ static int check_attr_export_subst(const struct attr_check *check)
 	return check && ATTR_TRUE(check->items[1].value);
 }
 
-static int write_archive_entry(const unsigned char *sha1, const char *base,
+static int write_archive_entry(const struct object_id *oid, const char *base,
 		int baselen, const char *filename, unsigned mode, int stage,
 		void *context)
 {
@@ -153,7 +153,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-		err = write_entry(args, sha1, path.buf, path.len, mode);
+		err = write_entry(args, oid, path.buf, path.len, mode);
 		if (err)
 			return err;
 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
@@ -161,7 +161,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 
 	if (args->verbose)
 		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-	return write_entry(args, sha1, path.buf, path.len, mode);
+	return write_entry(args, oid, path.buf, path.len, mode);
 }
 
 static void queue_directory(const unsigned char *sha1,
@@ -191,7 +191,7 @@ static int write_directory(struct archiver_context *c)
 	d->path[d->len - 1] = '\0'; /* no trailing slash */
 	ret =
 		write_directory(c) ||
-		write_archive_entry(d->oid.hash, d->path, d->baselen,
+		write_archive_entry(&d->oid, d->path, d->baselen,
 				    d->path + d->baselen, d->mode,
 				    d->stage, c) != READ_TREE_RECURSIVE;
 	free(d);
@@ -231,7 +231,7 @@ static int queue_or_write_archive_entry(const struct object_id *oid,
 
 	if (write_directory(c))
 		return -1;
-	return write_archive_entry(oid->hash, base->buf, base->len, filename, mode,
+	return write_archive_entry(oid, base->buf, base->len, filename, mode,
 				   stage, context);
 }
 
@@ -250,7 +250,7 @@ int write_archive_entries(struct archiver_args *args,
 			len--;
 		if (args->verbose)
 			fprintf(stderr, "%.*s\n", (int)len, args->base);
-		err = write_entry(args, args->tree->object.oid.hash, args->base,
+		err = write_entry(args, &args->tree->object.oid, args->base,
 				  len, 040777);
 		if (err)
 			return err;
diff --git a/archive.h b/archive.h
index 62d1d82c1a..741991bfb6 100644
--- a/archive.h
+++ b/archive.h
@@ -31,7 +31,7 @@ extern void init_tar_archiver(void);
 extern void init_zip_archiver(void);
 
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
-					const unsigned char *sha1,
+					const struct object_id *oid,
 					const char *path, size_t pathlen,
 					unsigned int mode);
 
