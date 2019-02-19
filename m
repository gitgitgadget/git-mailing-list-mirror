Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41ACD1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfBSAGR (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:17 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34840 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732279AbfBSAGN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:13 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B67C8610A2;
        Tue, 19 Feb 2019 00:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534771;
        bh=2uMD7E1XamsDGTz/DxPvy3JxKgau2vt+hmlazkdNFIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DYo8ENHVOi+J6TvrDsagwaw3rPDUyWEHkkbCeDrvk0DH8eiQo+BnFC1cxlriXVigC
         xvNwqlljENlC8pTG6+HItW6FQwKtwdWnQT9TNahiDozf5IFA2u+az3HoJOBCyHNpy/
         4lhgkb33aD4mG2zSoOjHDo/n6Ao5XR2q/A8AahjGnzEG4cELBknnlm04NiLFN8R3YB
         N1M9vOrej+XHZgZylqOibJvXg3IDUIr9mUW9ExR4A40haLhGpWp3hsPGZNuLZ3mRKu
         mJSx6kv8xC6lfZZODTUWz6XGi475RY4f41Rv/cgHdK7qyGt0Pmwk9w3AUD3En3xxat
         2JaFfI+ONDyQTS+z1ihmzmlWokhE5885t5eDl73cj3H+ybaQ8N4wBUhLt1BFdLIBED
         pW+JXAeKU/xWMH+XBACsVTbCCoynZIHvft12TN/iocukxzDJMdvqzdR8I6vFeS8OmA
         Id4FnVZIDIGSORuK44nHUtFGwR97jclntY3FmIO8qk2JMijP1jK
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 29/35] archive: convert struct archiver_args to object_id
Date:   Tue, 19 Feb 2019 00:05:20 +0000
Message-Id: <20190219000526.476553-30-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the commit_sha1 member to be called "commit_oid" and change it to
be a pointer to struct object_id.  Additionally, update some uses of
GIT_SHA1_HEXSZ and hard-coded values to use the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-tar.c |  7 ++++---
 archive-zip.c | 10 +++++-----
 archive.c     |  8 ++++----
 archive.h     |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 4aabd566fb..3e53aac1e6 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -326,14 +326,15 @@ static int write_tar_entry(struct archiver_args *args,
 
 static void write_global_extended_header(struct archiver_args *args)
 {
-	const unsigned char *sha1 = args->commit_sha1;
+	const struct object_id *oid = args->commit_oid;
 	struct strbuf ext_header = STRBUF_INIT;
 	struct ustar_header header;
 	unsigned int mode;
 
-	if (sha1)
+	if (oid)
 		strbuf_append_ext_header(&ext_header, "comment",
-					 sha1_to_hex(sha1), 40);
+					 oid_to_hex(oid),
+					 the_hash_algo->hexsz);
 	if (args->time > USTAR_MAX_MTIME) {
 		strbuf_append_ext_header_uint(&ext_header, "mtime",
 					      args->time);
diff --git a/archive-zip.c b/archive-zip.c
index 155ee4a779..4d66b5be6e 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -577,7 +577,7 @@ static void write_zip64_trailer(void)
 	write_or_die(1, &locator64, ZIP64_DIR_TRAILER_LOCATOR_SIZE);
 }
 
-static void write_zip_trailer(const unsigned char *sha1)
+static void write_zip_trailer(const struct object_id *oid)
 {
 	struct zip_dir_trailer trailer;
 	int clamped = 0;
@@ -590,14 +590,14 @@ static void write_zip_trailer(const unsigned char *sha1)
 	copy_le16_clamp(trailer.entries, zip_dir_entries, &clamped);
 	copy_le32(trailer.size, zip_dir.len);
 	copy_le32_clamp(trailer.offset, zip_offset, &clamped);
-	copy_le16(trailer.comment_length, sha1 ? GIT_SHA1_HEXSZ : 0);
+	copy_le16(trailer.comment_length, oid ? the_hash_algo->hexsz : 0);
 
 	write_or_die(1, zip_dir.buf, zip_dir.len);
 	if (clamped)
 		write_zip64_trailer();
 	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
-	if (sha1)
-		write_or_die(1, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
+	if (oid)
+		write_or_die(1, oid_to_hex(oid), the_hash_algo->hexsz);
 }
 
 static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
@@ -635,7 +635,7 @@ static int write_zip_archive(const struct archiver *ar,
 
 	err = write_archive_entries(args, write_zip_entry);
 	if (!err)
-		write_zip_trailer(args->commit_sha1);
+		write_zip_trailer(args->commit_oid);
 
 	strbuf_release(&zip_dir);
 
diff --git a/archive.c b/archive.c
index 1f98324a93..f2c78a2712 100644
--- a/archive.c
+++ b/archive.c
@@ -380,7 +380,7 @@ static void parse_treeish_arg(const char **argv,
 		int remote)
 {
 	const char *name = argv[0];
-	const unsigned char *commit_sha1;
+	const struct object_id *commit_oid;
 	time_t archive_time;
 	struct tree *tree;
 	const struct commit *commit;
@@ -402,10 +402,10 @@ static void parse_treeish_arg(const char **argv,
 
 	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
 	if (commit) {
-		commit_sha1 = commit->object.oid.hash;
+		commit_oid = &commit->object.oid;
 		archive_time = commit->date;
 	} else {
-		commit_sha1 = NULL;
+		commit_oid = NULL;
 		archive_time = time(NULL);
 	}
 
@@ -426,7 +426,7 @@ static void parse_treeish_arg(const char **argv,
 		tree = parse_tree_indirect(&tree_oid);
 	}
 	ar_args->tree = tree;
-	ar_args->commit_sha1 = commit_sha1;
+	ar_args->commit_oid = commit_oid;
 	ar_args->commit = commit;
 	ar_args->time = archive_time;
 }
diff --git a/archive.h b/archive.h
index 21ac010699..dd022a6b46 100644
--- a/archive.h
+++ b/archive.h
@@ -11,7 +11,7 @@ struct archiver_args {
 	const char *base;
 	size_t baselen;
 	struct tree *tree;
-	const unsigned char *commit_sha1;
+	const struct object_id *commit_oid;
 	const struct commit *commit;
 	timestamp_t time;
 	struct pathspec pathspec;
