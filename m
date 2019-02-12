Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6301F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfBLBXs (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34380 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727269AbfBLBXp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 26CF660E5E;
        Tue, 12 Feb 2019 01:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934623;
        bh=2TtYrNMb/kzBAydNMsK0aKUC/eRRWFYRlEz1ei0ENP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=PlFvxd6YRabT1QOOIfIbQVk9N4uaxjWQNi0jspawaBJg0IREa6l+Rv7O7y8GY7sbl
         LUmikA37+ZTm4CPBWlDRe8hd7ucFJUWgOb81yq3ilx2hFICzu0OI8b+Pd/0Vb9Ds0y
         CiIWpaP1FgX109dC1gfiK5+VnqU/HuMrNHvL3/i62izFd7SR79ToGj/JO3nAsRqic8
         rCCtOxt/6EPDXoTOETk9q2HlTPLlRzvHQrTJn/e7l+2Bjf6utS2KbMJpjlXxqSb5Hn
         73x2sK0ujdi02WBH0U5OTTzwotG4FJd2qNb6wRwsknBAbkwqy5tCxDfomTysCrag/l
         AvmI90vlsOGjsBaJKdW7gLhQQ6MajMB4LDLMCw8+syFFAlOffiJ3PMZJPI0i/8LcTJ
         bXt1RAE1UqWfPsSvV5W1sfeVYAv10q18xbN/TtikLmVDeNCUFc9O9qCFbIbGNV1xCm
         vhhTJJAJu630di1Azl9up6q+iOSVY41WrqjdE7MEiPynAr8f3sW
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 28/31] dir: make untracked cache extension hash size independent
Date:   Tue, 12 Feb 2019 01:22:53 +0000
Message-Id: <20190212012256.1005924-29-sandals@crustytoothpaste.net>
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
 
