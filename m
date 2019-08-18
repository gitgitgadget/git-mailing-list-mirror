Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D551F461
	for <e@80x24.org>; Sun, 18 Aug 2019 20:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfHRUFh (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 16:05:37 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57926 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfHRUFd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Aug 2019 16:05:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3D59260737;
        Sun, 18 Aug 2019 20:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566158731;
        bh=fVzFyS69xZld2x+FViFNvo9u8IAZq+Ld3bt/89vjH84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=zUTS1WMn7B2P5pEMfFJB6mvsZ2XRlh9JhWMaJ3yUKr6lpLGFcGhWd7+HwgxqaWefr
         bLYUujf20V6bBF+nZlpTdQSeGkvpTq2+tU+rGHOWrVK3z/gUmQ274/OiwgO3C970SU
         1N/DMVGqApcSnyOsjVgO3zh+6UxODEZ1tAyv5Yo0dZ8Vhf7DSLYM+BoHgVK2Y358ib
         KqM61HtK8tyox89CDzoo4dGemwH2lnxH1Ycb7wAIpozGJPd9tPW61uptKNVzAE+FLD
         0HcAEEUb3JHnHvxSrLfGeZgf4LMNKX8yhzflhCI5cr4ZqKzQGKlzcaNOal4XPhQ+Yc
         BgwwbVPjn6rejwG3DtdA31U5daI8Mg43uE8J4GZjwkjSloD8Zz0zlZ0ORa5sfDA5w2
         BrMLPWscKFOrTOTC+eSrkI7lAjExaG4It3rFQhMWT9S886gVLHK/zm8qs5F+uX0kua
         eIuNfF2h4fmCiuUyXgjyXlmq1JkHbZ/onXvgJZs6kgUkIvxX9Ow
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 02/26] patch-id: convert to use the_hash_algo
Date:   Sun, 18 Aug 2019 20:04:03 +0000
Message-Id: <20190818200427.870753-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.rc1.170.gbd704faa3e
In-Reply-To: <20190818200427.870753-1-sandals@crustytoothpaste.net>
References: <20190818200427.870753-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the two separate patch-id implementations to use the_hash_algo
in their implementation.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/patch-id.c | 11 ++++++-----
 diff.c             | 46 +++++++++++++++++++++++-----------------------
 diff.h             |  2 +-
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index bd28b80b2d..3059e525b8 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,15 +1,16 @@
+#include "cache.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
 
 static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
 {
-	char name[50];
+	char name[GIT_MAX_HEXSZ + 1];
 
 	if (!patchlen)
 		return;
 
-	memcpy(name, oid_to_hex(id), GIT_SHA1_HEXSZ + 1);
+	memcpy(name, oid_to_hex(id), the_hash_algo->hexsz + 1);
 	printf("%s %s\n", oid_to_hex(result), name);
 }
 
@@ -60,9 +61,9 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 {
 	int patchlen = 0, found_next = 0;
 	int before = -1, after = -1;
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 
-	git_SHA1_Init(&ctx);
+	the_hash_algo->init_fn(&ctx);
 	oidclr(result);
 
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
@@ -122,7 +123,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		/* Compute the sha without whitespace */
 		len = remove_space(line);
 		patchlen += len;
-		git_SHA1_Update(&ctx, line, len);
+		the_hash_algo->update_fn(&ctx, line, len);
 	}
 
 	if (!found_next)
diff --git a/diff.c b/diff.c
index efe42b341a..bf51c94804 100644
--- a/diff.c
+++ b/diff.c
@@ -5978,7 +5978,7 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 }
 
 struct patch_id_t {
-	git_SHA_CTX *ctx;
+	git_hash_ctx *ctx;
 	int patchlen;
 };
 
@@ -5995,16 +5995,16 @@ static int remove_space(char *line, int len)
 	return dst - line;
 }
 
-void flush_one_hunk(struct object_id *result, git_SHA_CTX *ctx)
+void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned short carry = 0;
 	int i;
 
-	git_SHA1_Final(hash, ctx);
-	git_SHA1_Init(ctx);
+	the_hash_algo->final_fn(hash, ctx);
+	the_hash_algo->init_fn(ctx);
 	/* 20-byte sum, with carry */
-	for (i = 0; i < GIT_SHA1_RAWSZ; ++i) {
+	for (i = 0; i < the_hash_algo->rawsz; ++i) {
 		carry += result->hash[i] + hash[i];
 		result->hash[i] = carry;
 		carry >>= 8;
@@ -6018,21 +6018,21 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 
 	new_len = remove_space(line, len);
 
-	git_SHA1_Update(data->ctx, line, new_len);
+	the_hash_algo->update_fn(data->ctx, line, new_len);
 	data->patchlen += new_len;
 }
 
-static void patch_id_add_string(git_SHA_CTX *ctx, const char *str)
+static void patch_id_add_string(git_hash_ctx *ctx, const char *str)
 {
-	git_SHA1_Update(ctx, str, strlen(str));
+	the_hash_algo->update_fn(ctx, str, strlen(str));
 }
 
-static void patch_id_add_mode(git_SHA_CTX *ctx, unsigned mode)
+static void patch_id_add_mode(git_hash_ctx *ctx, unsigned mode)
 {
 	/* large enough for 2^32 in octal */
 	char buf[12];
 	int len = xsnprintf(buf, sizeof(buf), "%06o", mode);
-	git_SHA1_Update(ctx, buf, len);
+	the_hash_algo->update_fn(ctx, buf, len);
 }
 
 /* returns 0 upon success, and writes result into oid */
@@ -6040,10 +6040,10 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	git_SHA_CTX ctx;
+	git_hash_ctx ctx;
 	struct patch_id_t data;
 
-	git_SHA1_Init(&ctx);
+	the_hash_algo->init_fn(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx = &ctx;
 	oidclr(oid);
@@ -6076,27 +6076,27 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		len2 = remove_space(p->two->path, strlen(p->two->path));
 		patch_id_add_string(&ctx, "diff--git");
 		patch_id_add_string(&ctx, "a/");
-		git_SHA1_Update(&ctx, p->one->path, len1);
+		the_hash_algo->update_fn(&ctx, p->one->path, len1);
 		patch_id_add_string(&ctx, "b/");
-		git_SHA1_Update(&ctx, p->two->path, len2);
+		the_hash_algo->update_fn(&ctx, p->two->path, len2);
 
 		if (p->one->mode == 0) {
 			patch_id_add_string(&ctx, "newfilemode");
 			patch_id_add_mode(&ctx, p->two->mode);
 			patch_id_add_string(&ctx, "---/dev/null");
 			patch_id_add_string(&ctx, "+++b/");
-			git_SHA1_Update(&ctx, p->two->path, len2);
+			the_hash_algo->update_fn(&ctx, p->two->path, len2);
 		} else if (p->two->mode == 0) {
 			patch_id_add_string(&ctx, "deletedfilemode");
 			patch_id_add_mode(&ctx, p->one->mode);
 			patch_id_add_string(&ctx, "---a/");
-			git_SHA1_Update(&ctx, p->one->path, len1);
+			the_hash_algo->update_fn(&ctx, p->one->path, len1);
 			patch_id_add_string(&ctx, "+++/dev/null");
 		} else {
 			patch_id_add_string(&ctx, "---a/");
-			git_SHA1_Update(&ctx, p->one->path, len1);
+			the_hash_algo->update_fn(&ctx, p->one->path, len1);
 			patch_id_add_string(&ctx, "+++b/");
-			git_SHA1_Update(&ctx, p->two->path, len2);
+			the_hash_algo->update_fn(&ctx, p->two->path, len2);
 		}
 
 		if (diff_header_only)
@@ -6108,10 +6108,10 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 
 		if (diff_filespec_is_binary(options->repo, p->one) ||
 		    diff_filespec_is_binary(options->repo, p->two)) {
-			git_SHA1_Update(&ctx, oid_to_hex(&p->one->oid),
-					GIT_SHA1_HEXSZ);
-			git_SHA1_Update(&ctx, oid_to_hex(&p->two->oid),
-					GIT_SHA1_HEXSZ);
+			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->one->oid),
+					the_hash_algo->hexsz);
+			the_hash_algo->update_fn(&ctx, oid_to_hex(&p->two->oid),
+					the_hash_algo->hexsz);
 			continue;
 		}
 
@@ -6128,7 +6128,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 	}
 
 	if (!stable)
-		git_SHA1_Final(oid->hash, &ctx);
+		the_hash_algo->final_fn(oid->hash, &ctx);
 
 	return 0;
 }
diff --git a/diff.h b/diff.h
index c2c3056810..7f8f024feb 100644
--- a/diff.h
+++ b/diff.h
@@ -438,7 +438,7 @@ int run_diff_index(struct rev_info *revs, int cached);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
 int diff_flush_patch_id(struct diff_options *, struct object_id *, int, int);
-void flush_one_hunk(struct object_id *, git_SHA_CTX *);
+void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx);
 
 int diff_result_code(struct diff_options *, int);
 
