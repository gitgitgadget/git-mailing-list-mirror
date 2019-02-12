Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A68E1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfBLBXt (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:49 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34362 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727259AbfBLBXn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:43 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id F36FF60E59;
        Tue, 12 Feb 2019 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934621;
        bh=SRAkzt22seKEh5pn4oaphfXHekT+q2Jm8m9IG0k53B4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nsI0Kt27Gwo9d69Bl7oLLlhHfAN7ZWO0JHzVjXruPAK/VkFa6EGnvca+FGMqux+2V
         GYdsLvK/MMNexZbXoh4liayh7xvYAyS1pMqSngvvuvNn0ocSOZpKiaJCIMWxo1cpz4
         GENH4O3oFk4QCCZNo283xcgXt1M3E/23iWTW9VD+fUJp/DW8HQ4Re9QGY+zyAZTfwj
         XRaE+XGpTv597GJvNHRP9wfnHMu9voWBy/BAqvCEQQNucxzbkF2aPaFWUm+AKKVCzf
         zICCD20XG+nMcCT/O55L9AqGo/ezHQPC3cunKwcgs+EfW2a1Mrm7HT1JYff5cs7Go6
         bVnZEw6AsILUtmf9Q3MCTB4AiDnC6JRw/nW88wOKHdentXzk0ziCbI+AaW7rN6VJEY
         PJP3ZsV0GcVE7jtR2erADwAHS7Yrk/l5mPEM63fUyIci+BGwHwuG4P9hQTYa3cWBOm
         kDLoCxPba1wr0sqsrg4a1X1ZEulCOiuLOaW4x7rvbXA3zACqYei
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 25/31] archive: convert struct archiver_args to object_id
Date:   Tue, 12 Feb 2019 01:22:50 +0000
Message-Id: <20190212012256.1005924-26-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the commit_sha1 member to be called "commit_oid" and change it to
be a pointer to struct object_id.  Additionally, update two uses of
GIT_SHA1_HEXSZ to use the_hash_algo instead.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 archive-tar.c |  6 +++---
 archive-zip.c | 10 +++++-----
 archive.c     |  8 ++++----
 archive.h     |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index a5ba55c11e..3e53aac1e6 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -326,14 +326,14 @@ static int write_tar_entry(struct archiver_args *args,
 
 static void write_global_extended_header(struct archiver_args *args)
 {
-	const unsigned char *hash = args->commit_sha1;
+	const struct object_id *oid = args->commit_oid;
 	struct strbuf ext_header = STRBUF_INIT;
 	struct ustar_header header;
 	unsigned int mode;
 
-	if (hash)
+	if (oid)
 		strbuf_append_ext_header(&ext_header, "comment",
-					 hash_to_hex(hash),
+					 oid_to_hex(oid),
 					 the_hash_algo->hexsz);
 	if (args->time > USTAR_MAX_MTIME) {
 		strbuf_append_ext_header_uint(&ext_header, "mtime",
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
