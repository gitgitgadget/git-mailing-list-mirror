Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61D3620966
	for <e@80x24.org>; Fri, 31 Mar 2017 01:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935141AbdCaBk6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 21:40:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:59216 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934971AbdCaBkI (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Mar 2017 21:40:08 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 5FED6280B0;
        Fri, 31 Mar 2017 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490924406;
        bh=rmi+PkJT4MhwapTtHdYOimZUmRnVV7HGYdfS+aIJe0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoJzD3BHAkTax2hF12kcHiV1d0z0UtpYL2c3PvnwJ23y9ocDYQcpbQxOb9FOALRkZ
         Bb3u2Y9PPgYWCEKHH03Ho2ku7vY5K3pnsJKjZ2fQKZFYwo3841s/jwfYw+2rQ+nuY+
         jifYWBT7K3NeJ8qnLAXGZb0cM0OuKPfLvd2bxMzd8vie8n4+rLee19FVuEJPJBHCju
         AxVPIrfhSd8tkuIz5H5CfhSQHSunlb3aerVePO5Bp+VZIJ0bt3QFbhx2OBTsY+u3cz
         4pEeu8UMF4KhDwM8NrOhkaD4RkqMiaqRjxNzdftjpz7xroW7UQfHG6hclRE6/LqBf8
         FYWa4usYeW7+yZ+4GEhBZ3VzrQxrl5XD4sq4nfInPsY/sbv03o3vmyf3ttxg5cRi1+
         KnVDWkA3sYJZ2fof45UWk9H5Qv5qchJniZ4bnFb8b0owXC4gMaWxLnWF0XK4BGg8eH
         jO5qRJXhFL/Ke6tQ/gU1X9d7HJv6CZJpPXqG6OD97IemVeg9FFR
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 03/20] Convert GIT_SHA1_RAWSZ used for allocation to GIT_MAX_RAWSZ
Date:   Fri, 31 Mar 2017 01:39:44 +0000
Message-Id: <20170331014001.953484-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170331014001.953484-1-sandals@crustytoothpaste.net>
References: <20170331014001.953484-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we will likely be introducing a new hash function at some point,
and that hash function might be longer than 20 bytes, use the constant
GIT_MAX_RAWSZ, which is designed to be suitable for allocations, instead
of GIT_SHA1_RAWSZ.  This will ease the transition down the line by
distinguishing between places where we need to allocate memory suitable
for the largest hash from those where we need to handle the current
hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/patch-id.c     | 2 +-
 builtin/receive-pack.c | 2 +-
 cache.h                | 2 +-
 patch-ids.c            | 2 +-
 patch-ids.h            | 2 +-
 sha1_file.c            | 4 ++--
 sha1_name.c            | 4 ++--
 wt-status.h            | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index a84d0003a3..81552e02e4 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -55,7 +55,7 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 
 static void flush_one_hunk(struct object_id *result, git_SHA_CTX *ctx)
 {
-	unsigned char hash[GIT_SHA1_RAWSZ];
+	unsigned char hash[GIT_MAX_RAWSZ];
 	unsigned short carry = 0;
 	int i;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fb2a090a0c..feafb076a4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1162,7 +1162,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	const char *dst_name;
 	struct string_list_item *item;
 	struct command *dst_cmd;
-	unsigned char sha1[GIT_SHA1_RAWSZ];
+	unsigned char sha1[GIT_MAX_RAWSZ];
 	int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
diff --git a/cache.h b/cache.h
index 02b6c753a3..db14464bce 100644
--- a/cache.h
+++ b/cache.h
@@ -980,7 +980,7 @@ extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int len);
 extern int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len);
 
-extern const unsigned char null_sha1[GIT_SHA1_RAWSZ];
+extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
 
 static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
diff --git a/patch-ids.c b/patch-ids.c
index ce285c2e0c..fa8f11de82 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -71,7 +71,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 			       struct commit *commit,
 			       struct patch_ids *ids)
 {
-	unsigned char header_only_patch_id[GIT_SHA1_RAWSZ];
+	unsigned char header_only_patch_id[GIT_MAX_RAWSZ];
 
 	patch->commit = commit;
 	if (commit_patch_id(commit, &ids->diffopts, header_only_patch_id, 1))
diff --git a/patch-ids.h b/patch-ids.h
index 0f34ea11ea..b9e5751f8e 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -3,7 +3,7 @@
 
 struct patch_id {
 	struct hashmap_entry ent;
-	unsigned char patch_id[GIT_SHA1_RAWSZ];
+	unsigned char patch_id[GIT_MAX_RAWSZ];
 	struct commit *commit;
 };
 
diff --git a/sha1_file.c b/sha1_file.c
index e763000d34..b4666ee5c2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1606,7 +1606,7 @@ static void mark_bad_packed_object(struct packed_git *p,
 		if (!hashcmp(sha1, p->bad_object_sha1 + GIT_SHA1_RAWSZ * i))
 			return;
 	p->bad_object_sha1 = xrealloc(p->bad_object_sha1,
-				      st_mult(GIT_SHA1_RAWSZ,
+				      st_mult(GIT_MAX_RAWSZ,
 					      st_add(p->num_bad_objects, 1)));
 	hashcpy(p->bad_object_sha1 + GIT_SHA1_RAWSZ * p->num_bad_objects, sha1);
 	p->num_bad_objects++;
@@ -3913,7 +3913,7 @@ static int check_stream_sha1(git_zstream *stream,
 			     const unsigned char *expected_sha1)
 {
 	git_SHA_CTX c;
-	unsigned char real_sha1[GIT_SHA1_RAWSZ];
+	unsigned char real_sha1[GIT_MAX_RAWSZ];
 	unsigned char buf[4096];
 	unsigned long total_read;
 	int status = Z_OK;
diff --git a/sha1_name.c b/sha1_name.c
index 964201bc26..3db166b40b 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -16,11 +16,11 @@ typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
 	char hex_pfx[GIT_MAX_HEXSZ + 1];
-	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
+	unsigned char bin_pfx[GIT_MAX_RAWSZ];
 
 	disambiguate_hint_fn fn;
 	void *cb_data;
-	unsigned char candidate[GIT_SHA1_RAWSZ];
+	unsigned char candidate[GIT_MAX_RAWSZ];
 	unsigned candidate_exists:1;
 	unsigned candidate_checked:1;
 	unsigned candidate_ok:1;
diff --git a/wt-status.h b/wt-status.h
index 54fec77032..6018c627b1 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -80,7 +80,7 @@ struct wt_status {
 	int hints;
 
 	enum wt_status_format status_format;
-	unsigned char sha1_commit[GIT_SHA1_RAWSZ]; /* when not Initial */
+	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
 	int commitable;
