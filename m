Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D586D1F462
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbfBSAGZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34878 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732286AbfBSAGR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:17 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 910D161092;
        Tue, 19 Feb 2019 00:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534775;
        bh=2TtYrNMb/kzBAydNMsK0aKUC/eRRWFYRlEz1ei0ENP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=UvYRUgrg2t+IGVpJZniREkzYoEyRkjUO6moz5x/Sc9M5C41vd3sCSo3uVJ5jEy1L9
         0bp35QjYRHVHXNBh728b8VUkRapCqn+SVmrvRZmvCVcWgqRUB/8aVFIN11zsXxFBx4
         Ql/9RVNihKyNTAmYsoujNkFkg6MgiAC5DkxqNoGMhmmWkaqr2gLC2vFtQlLVfSO1h9
         ip4wRsDNiEcvmOFHjHIwGRkvPVSXKRBWIt5Z2lpgtfgeWHmMvGjnctf/7WQdvWpBYR
         v5POLuc+ZnhwYGCdktiRwHLf7z4RuC/XBxB35SvD6dUGFIDBfRpi3wGFkS4U1b/kvA
         IagKPy3ewUUmVrBs5nFhbZbmokbEGCneabQ0ONl6En4KgQQLpqoo7xBe+njzfyo9lI
         OMTkltif986j2KZR/Y10Vpestd5qpnTo6wk/qbRiKQJ8WamokCYozMkTVLE2zzqIQ+
         nX9K9tflUgRQUedLUwIS3lvBrk+YSixntG5QGRWLZMAyEA4nCM7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 32/35] dir: make untracked cache extension hash size independent
Date:   Tue, 19 Feb 2019 00:05:23 +0000
Message-Id: <20190219000526.476553-33-sandals@crustytoothpaste.net>
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

Instead of using a struct with a flex array member to read and write the
untracked cache extension, use a shorter, fixed-length struct and add
the name and hash data explicitly.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 dir.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/dir.c b/dir.c
index b2cabadf25..7503b56918 100644
--- a/dir.c
+++ b/dir.c
@@ -2545,13 +2545,9 @@ struct ondisk_untracked_cache {
 	struct stat_data info_exclude_stat;
 	struct stat_data excludes_file_stat;
 	uint32_t dir_flags;
-	unsigned char info_exclude_sha1[20];
-	unsigned char excludes_file_sha1[20];
-	char exclude_per_dir[FLEX_ARRAY];
 };
 
 #define ouc_offset(x) offsetof(struct ondisk_untracked_cache, x)
-#define ouc_size(len) (ouc_offset(exclude_per_dir) + len + 1)
 
 struct write_data {
 	int index;	   /* number of written untracked_cache_dir */
@@ -2634,20 +2630,21 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	struct write_data wd;
 	unsigned char varbuf[16];
 	int varint_len;
-	size_t len = strlen(untracked->exclude_per_dir);
+	const unsigned hashsz = the_hash_algo->rawsz;
 
-	FLEX_ALLOC_MEM(ouc, exclude_per_dir, untracked->exclude_per_dir, len);
+	ouc = xcalloc(1, sizeof(*ouc));
 	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.stat);
 	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file.stat);
-	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.oid.hash);
-	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.oid.hash);
 	ouc->dir_flags = htonl(untracked->dir_flags);
 
 	varint_len = encode_varint(untracked->ident.len, varbuf);
 	strbuf_add(out, varbuf, varint_len);
 	strbuf_addbuf(out, &untracked->ident);
 
-	strbuf_add(out, ouc, ouc_size(len));
+	strbuf_add(out, ouc, sizeof(*ouc));
+	strbuf_add(out, untracked->ss_info_exclude.oid.hash, hashsz);
+	strbuf_add(out, untracked->ss_excludes_file.oid.hash, hashsz);
+	strbuf_add(out, untracked->exclude_per_dir, strlen(untracked->exclude_per_dir) + 1);
 	FREE_AND_NULL(ouc);
 
 	if (!untracked->root) {
@@ -2834,6 +2831,9 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	int ident_len;
 	ssize_t len;
 	const char *exclude_per_dir;
+	const unsigned hashsz = the_hash_algo->rawsz;
+	const unsigned offset = sizeof(struct ondisk_untracked_cache);
+	const unsigned exclude_per_dir_offset = offset + 2 * hashsz;
 
 	if (sz <= 1 || end[-1] != '\0')
 		return NULL;
@@ -2845,7 +2845,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	ident = (const char *)next;
 	next += ident_len;
 
-	if (next + ouc_size(0) > end)
+	if (next + exclude_per_dir_offset + 1 > end)
 		return NULL;
 
 	uc = xcalloc(1, sizeof(*uc));
@@ -2853,15 +2853,15 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	strbuf_add(&uc->ident, ident, ident_len);
 	load_oid_stat(&uc->ss_info_exclude,
 		      next + ouc_offset(info_exclude_stat),
-		      next + ouc_offset(info_exclude_sha1));
+		      next + offset);
 	load_oid_stat(&uc->ss_excludes_file,
 		      next + ouc_offset(excludes_file_stat),
-		      next + ouc_offset(excludes_file_sha1));
+		      next + offset + hashsz);
 	uc->dir_flags = get_be32(next + ouc_offset(dir_flags));
-	exclude_per_dir = (const char *)next + ouc_offset(exclude_per_dir);
+	exclude_per_dir = (const char *)next + exclude_per_dir_offset;
 	uc->exclude_per_dir = xstrdup(exclude_per_dir);
 	/* NUL after exclude_per_dir is covered by sizeof(*ouc) */
-	next += ouc_size(strlen(exclude_per_dir));
+	next += exclude_per_dir_offset + strlen(exclude_per_dir) + 1;
 	if (next >= end)
 		goto done2;
 
