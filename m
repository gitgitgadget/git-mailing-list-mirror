Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54192095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751295AbdCRVbU (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:31:20 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46196 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751253AbdCRVbI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Mar 2017 17:31:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 8CA08280AF;
        Sat, 18 Mar 2017 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489872000;
        bh=yLNnRP2glEFqCNZJ8WwpSK27tqDX0lGqbttO7JZQ9Bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGWeTXgyluWdRL4rPzyeVUsYg1zQXlpwdQJUwQcKgo596lq12Pp8FU9h+vFNOV+Z7
         Ft+vfeVh2XCjPnTkP5VRUMtMjqE7vm1KxfTQSHjQRmc46DpxIvM70CkfBR76gzu0Ka
         mFEp3ZicPPEfUtksdbIw5fxDfz5V5SrebhOI+IJkBOutZnvkULQ5Og6h6PFlMHeJBM
         hYKF0WTLeO3wwbUaryllm8+LEd6LO8HjN6/RKdyXyE6ZWCDGLuIdGJnlo7vHJC802d
         kYqUCKBljoPmn4hvpw5EWk/tsDVOJh3UwplZk5aq+jD4Q5VVH4hntnngMBkeREo83A
         kQ24wAzPYcTQ0dazs0d3Vo49s8wDm9BWpaJ2bgY2ovYS5tSLanBfg0adsaWnFx43xh
         mxZy7W9J6ytuowlDASS/FC0CnhgdqUY33XHRwWrgwz8wkuxO+WeTmKeclPTAEvqXCd
         S3olKA1yYXwj9L75F9m6yQVZs1Rdkppn87+d4QmVkDm74uklZWU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/20] Convert GIT_SHA1_HEXSZ used for allocation to GIT_MAX_HEXSZ
Date:   Sat, 18 Mar 2017 21:19:36 +0000
Message-Id: <20170318211954.564030-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170318211954.564030-1-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we will likely be introducing a new hash function at some point,
and that hash function might be longer than 40 hex characters, use the
constant GIT_MAX_HEXSZ, which is designed to be suitable for
allocations, instead of GIT_SHA1_HEXSZ.  This will ease the transition
down the line by distinguishing between places where we need to allocate
memory suitable for the largest hash from those where we need to handle
the current hash.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bisect.c              | 2 +-
 builtin/blame.c       | 4 ++--
 builtin/merge-index.c | 2 +-
 builtin/merge.c       | 2 +-
 builtin/rev-list.c    | 2 +-
 diff.c                | 4 ++--
 hex.c                 | 2 +-
 sha1_file.c           | 2 +-
 sha1_name.c           | 6 +++---
 transport.c           | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/bisect.c b/bisect.c
index 30808cadf7..21c3e34636 100644
--- a/bisect.c
+++ b/bisect.c
@@ -682,7 +682,7 @@ static int is_expected_rev(const struct object_id *oid)
 
 static int bisect_checkout(const unsigned char *bisect_rev, int no_checkout)
 {
-	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
+	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 
 	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
diff --git a/builtin/blame.c b/builtin/blame.c
index f7aa95f4ba..07506a3e45 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1890,7 +1890,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 	int cnt;
 	const char *cp;
 	struct origin *suspect = ent->suspect;
-	char hex[GIT_SHA1_HEXSZ + 1];
+	char hex[GIT_MAX_HEXSZ + 1];
 
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 	printf("%s %d %d %d\n",
@@ -1928,7 +1928,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	const char *cp;
 	struct origin *suspect = ent->suspect;
 	struct commit_info ci;
-	char hex[GIT_SHA1_HEXSZ + 1];
+	char hex[GIT_MAX_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 
 	get_commit_info(suspect->commit, &ci, 1);
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 2d1b6db6bd..c99443b095 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -9,7 +9,7 @@ static int merge_entry(int pos, const char *path)
 {
 	int found;
 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
-	char hexbuf[4][GIT_SHA1_HEXSZ + 1];
+	char hexbuf[4][GIT_MAX_HEXSZ + 1];
 	char ownbuf[4][60];
 
 	if (pos >= active_nr)
diff --git a/builtin/merge.c b/builtin/merge.c
index 7554b8d412..a2cceea3fb 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1296,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (verify_signatures) {
 		for (p = remoteheads; p; p = p->next) {
 			struct commit *commit = p->item;
-			char hex[GIT_SHA1_HEXSZ + 1];
+			char hex[GIT_MAX_HEXSZ + 1];
 			struct signature_check signature_check;
 			memset(&signature_check, 0, sizeof(signature_check));
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 0aa93d5891..bcf77f0b8a 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -212,7 +212,7 @@ static void print_var_int(const char *var, int val)
 static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 {
 	int cnt, flags = info->flags;
-	char hex[GIT_SHA1_HEXSZ + 1] = "";
+	char hex[GIT_MAX_HEXSZ + 1] = "";
 	struct commit_list *tried;
 	struct rev_info *revs = info->revs;
 
diff --git a/diff.c b/diff.c
index a628ac3a95..330b640c68 100644
--- a/diff.c
+++ b/diff.c
@@ -398,7 +398,7 @@ static struct diff_tempfile {
 	 */
 	const char *name;
 
-	char hex[GIT_SHA1_HEXSZ + 1];
+	char hex[GIT_MAX_HEXSZ + 1];
 	char mode[10];
 
 	/*
@@ -4219,7 +4219,7 @@ const char *diff_aligned_abbrev(const struct object_id *oid, int len)
 	 * uniqueness across all objects (statistically speaking).
 	 */
 	if (abblen < GIT_SHA1_HEXSZ - 3) {
-		static char hex[GIT_SHA1_HEXSZ + 1];
+		static char hex[GIT_MAX_HEXSZ + 1];
 		if (len < abblen && abblen <= len + 2)
 			xsnprintf(hex, sizeof(hex), "%s%.*s", abbrev, len+3-abblen, "..");
 		else
diff --git a/hex.c b/hex.c
index eab7b626ee..28b44118cb 100644
--- a/hex.c
+++ b/hex.c
@@ -85,7 +85,7 @@ char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
-	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
+	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
 	return sha1_to_hex_r(hexbuffer[bufno], sha1);
 }
diff --git a/sha1_file.c b/sha1_file.c
index 29bbc5f427..cc6b93c8a9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3764,7 +3764,7 @@ static int for_each_file_in_obj_subdir(int subdir_nr,
 		strbuf_addf(path, "/%s", de->d_name);
 
 		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2)  {
-			char hex[GIT_SHA1_HEXSZ+1];
+			char hex[GIT_MAX_HEXSZ+1];
 			struct object_id oid;
 
 			snprintf(hex, sizeof(hex), "%02x%s",
diff --git a/sha1_name.c b/sha1_name.c
index cda9e49b12..964201bc26 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -15,7 +15,7 @@ typedef int (*disambiguate_hint_fn)(const unsigned char *, void *);
 
 struct disambiguate_state {
 	int len; /* length of prefix in hex chars */
-	char hex_pfx[GIT_SHA1_HEXSZ + 1];
+	char hex_pfx[GIT_MAX_HEXSZ + 1];
 	unsigned char bin_pfx[GIT_SHA1_RAWSZ];
 
 	disambiguate_hint_fn fn;
@@ -80,7 +80,7 @@ static void update_candidates(struct disambiguate_state *ds, const unsigned char
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
 	struct alternate_object_database *alt;
-	char hex[GIT_SHA1_HEXSZ];
+	char hex[GIT_MAX_HEXSZ];
 	static struct alternate_object_database *fakeent;
 
 	if (!fakeent) {
@@ -509,7 +509,7 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 const char *find_unique_abbrev(const unsigned char *sha1, int len)
 {
 	static int bufno;
-	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
+	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	char *hex = hexbuffer[bufno];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
 	find_unique_abbrev_r(hex, sha1, len);
diff --git a/transport.c b/transport.c
index 417ed7f19f..8a90b0c29b 100644
--- a/transport.c
+++ b/transport.c
@@ -447,7 +447,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 
 static int measure_abbrev(const struct object_id *oid, int sofar)
 {
-	char hex[GIT_SHA1_HEXSZ + 1];
+	char hex[GIT_MAX_HEXSZ + 1];
 	int w = find_unique_abbrev_r(hex, oid->hash, DEFAULT_ABBREV);
 
 	return (w < sofar) ? sofar : w;
