Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330C61F859
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756236AbcH1X2i (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:38 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40994 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756207AbcH1X2I (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E2DD5280A7;
        Sun, 28 Aug 2016 23:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426885;
        bh=N5PGI/LLrSgAJuohumm2bLSj+K9ERcr5X53J+4Wry/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+EQ3+Sfi+Go8STAtsQ08ZwWhm/5rXLyen1rE0IRfC7PIhJwxrdtM86fOjZ+7pOy5
         3mxsMp+1BfkYu3ekNtZ7GWsFcnovb22eb6J2/F2Kccvw6fIY3NdndWslwSRYJ3ksfk
         cSyFNwo8oodkxgqHF9HkBoEsSKoI0CZmoYd/3cQr6eqgBhFS4NPOEDTz6XYfQHv7Df
         UyvMmKO6dDo8Jn2UIBsChJcAYh4Y/4yQgdJ9gDA7/nYqzSvetIzW//vScP17I94Hmx
         u5+gVsLuLhzvoVfWY2ONafpdOUjiQY3iLS3f6Kqw72Qi+qmxMFNiX1abt38oARWhMn
         ObBJTMt78CfRQ2QguN80DA6S8+tXJROheUFXzQi/YftKA+KDK+8PJjfEknm2qsIu/r
         IMRNnCboHMg/B3HdUzySdCzMk6sLKIKmu4XFB+PWd3xnGj8TTWhaZyxDpGw3BMweBa
         uJ4mS76iuK+TGBget3xBHzJaglqCo6f7lGTrgrWoNeJiR3Sabod
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 15/20] builtin/update-index: convert file to struct object_id
Date:   Sun, 28 Aug 2016 23:27:52 +0000
Message-Id: <20160828232757.373278-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all functions to use struct object_id, and replace instances of
hardcoded 40, 41, and 42 with appropriate references to GIT_SHA1_HEXSZ.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/update-index.c | 61 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a60a30a8..44fb2e4f 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -312,7 +312,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
  */
 static int process_directory(const char *path, int len, struct stat *st)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	int pos = cache_name_pos(path, len);
 
 	/* Exact match: file or existing gitlink */
@@ -321,7 +321,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 		if (S_ISGITLINK(ce->ce_mode)) {
 
 			/* Do nothing to the index if there is no HEAD! */
-			if (resolve_gitlink_ref(path, "HEAD", sha1) < 0)
+			if (resolve_gitlink_ref(path, "HEAD", oid.hash) < 0)
 				return 0;
 
 			return add_one_path(ce, path, len, st);
@@ -347,7 +347,7 @@ static int process_directory(const char *path, int len, struct stat *st)
 	}
 
 	/* No match - should we add it as a gitlink? */
-	if (!resolve_gitlink_ref(path, "HEAD", sha1))
+	if (!resolve_gitlink_ref(path, "HEAD", oid.hash))
 		return add_one_path(NULL, path, len, st);
 
 	/* Error out. */
@@ -390,7 +390,7 @@ static int process_path(const char *path)
 	return add_one_path(ce, path, len, &st);
 }
 
-static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
+static int add_cacheinfo(unsigned int mode, const struct object_id *oid,
 			 const char *path, int stage)
 {
 	int size, len, option;
@@ -403,7 +403,7 @@ static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 
-	hashcpy(ce->oid.hash, sha1);
+	oidcpy(&ce->oid, oid);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
@@ -487,7 +487,7 @@ static void read_index_info(int nul_term_line)
 	while (getline_fn(&buf, stdin) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
-		unsigned char sha1[20];
+		struct object_id oid;
 		unsigned int mode;
 		unsigned long ul;
 		int stage;
@@ -516,7 +516,7 @@ static void read_index_info(int nul_term_line)
 		mode = ul;
 
 		tab = strchr(ptr, '\t');
-		if (!tab || tab - ptr < 41)
+		if (!tab || tab - ptr < GIT_SHA1_HEXSZ + 1)
 			goto bad_line;
 
 		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
@@ -529,7 +529,8 @@ static void read_index_info(int nul_term_line)
 			ptr = tab + 1; /* point at the head of path */
 		}
 
-		if (get_sha1_hex(tab - 40, sha1) || tab[-41] != ' ')
+		if (get_oid_hex(tab - GIT_SHA1_HEXSZ, &oid) ||
+			tab[-(GIT_SHA1_HEXSZ + 1)] != ' ')
 			goto bad_line;
 
 		path_name = ptr;
@@ -557,8 +558,8 @@ static void read_index_info(int nul_term_line)
 			 * ptr[-1] points at tab,
 			 * ptr[-41] is at the beginning of sha1
 			 */
-			ptr[-42] = ptr[-1] = 0;
-			if (add_cacheinfo(mode, sha1, path_name, stage))
+			ptr[-(GIT_SHA1_HEXSZ + 2)] = ptr[-1] = 0;
+			if (add_cacheinfo(mode, &oid, path_name, stage))
 				die("git update-index: unable to update %s",
 				    path_name);
 		}
@@ -576,19 +577,19 @@ static const char * const update_index_usage[] = {
 	NULL
 };
 
-static unsigned char head_sha1[20];
-static unsigned char merge_head_sha1[20];
+static struct object_id head_oid;
+static struct object_id merge_head_oid;
 
 static struct cache_entry *read_one_ent(const char *which,
-					unsigned char *ent, const char *path,
+					struct object_id *ent, const char *path,
 					int namelen, int stage)
 {
 	unsigned mode;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int size;
 	struct cache_entry *ce;
 
-	if (get_tree_entry(ent, path, sha1, &mode)) {
+	if (get_tree_entry(ent->hash, path, oid.hash, &mode)) {
 		if (which)
 			error("%s: not in %s branch.", path, which);
 		return NULL;
@@ -601,7 +602,7 @@ static struct cache_entry *read_one_ent(const char *which,
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 
-	hashcpy(ce->oid.hash, sha1);
+	oidcpy(&ce->oid, &oid);
 	memcpy(ce->name, path, namelen);
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = namelen;
@@ -651,8 +652,8 @@ static int unresolve_one(const char *path)
 	 * stuff HEAD version in stage #2,
 	 * stuff MERGE_HEAD version in stage #3.
 	 */
-	ce_2 = read_one_ent("our", head_sha1, path, namelen, 2);
-	ce_3 = read_one_ent("their", merge_head_sha1, path, namelen, 3);
+	ce_2 = read_one_ent("our", &head_oid, path, namelen, 2);
+	ce_3 = read_one_ent("their", &merge_head_oid, path, namelen, 3);
 
 	if (!ce_2 || !ce_3) {
 		ret = -1;
@@ -683,9 +684,9 @@ static int unresolve_one(const char *path)
 
 static void read_head_pointers(void)
 {
-	if (read_ref("HEAD", head_sha1))
+	if (read_ref("HEAD", head_oid.hash))
 		die("No HEAD -- no initial commit yet?");
-	if (read_ref("MERGE_HEAD", merge_head_sha1)) {
+	if (read_ref("MERGE_HEAD", merge_head_oid.hash)) {
 		fprintf(stderr, "Not in the middle of a merge.\n");
 		exit(0);
 	}
@@ -725,7 +726,7 @@ static int do_reupdate(int ac, const char **av,
 		       PATHSPEC_PREFER_CWD,
 		       prefix, av + 1);
 
-	if (read_ref("HEAD", head_sha1))
+	if (read_ref("HEAD", head_oid.hash))
 		/* If there is no HEAD, that means it is an initial
 		 * commit.  Update everything in the index.
 		 */
@@ -740,7 +741,7 @@ static int do_reupdate(int ac, const char **av,
 		if (ce_stage(ce) || !ce_path_match(ce, &pathspec, NULL))
 			continue;
 		if (has_head)
-			old = read_one_ent(NULL, head_sha1,
+			old = read_one_ent(NULL, &head_oid,
 					   ce->name, ce_namelen(ce), 0);
 		if (old && ce->ce_mode == old->ce_mode &&
 		    !oidcmp(&ce->oid, &old->oid)) {
@@ -807,7 +808,7 @@ static int resolve_undo_clear_callback(const struct option *opt,
 
 static int parse_new_style_cacheinfo(const char *arg,
 				     unsigned int *mode,
-				     unsigned char sha1[],
+				     struct object_id *oid,
 				     const char **path)
 {
 	unsigned long ul;
@@ -822,21 +823,21 @@ static int parse_new_style_cacheinfo(const char *arg,
 		return -1; /* not a new-style cacheinfo */
 	*mode = ul;
 	endp++;
-	if (get_sha1_hex(endp, sha1) || endp[40] != ',')
+	if (get_oid_hex(endp, oid) || endp[GIT_SHA1_HEXSZ] != ',')
 		return -1;
-	*path = endp + 41;
+	*path = endp + GIT_SHA1_HEXSZ + 1;
 	return 0;
 }
 
 static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 				const struct option *opt, int unset)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	unsigned int mode;
 	const char *path;
 
-	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, sha1, &path)) {
-		if (add_cacheinfo(mode, sha1, path, 0))
+	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, &oid, &path)) {
+		if (add_cacheinfo(mode, &oid, path, 0))
 			die("git update-index: --cacheinfo cannot add %s", path);
 		ctx->argv++;
 		ctx->argc--;
@@ -845,8 +846,8 @@ static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 	if (ctx->argc <= 3)
 		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
 	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
-	    get_sha1_hex(*++ctx->argv, sha1) ||
-	    add_cacheinfo(mode, sha1, *++ctx->argv, 0))
+	    get_oid_hex(*++ctx->argv, &oid) ||
+	    add_cacheinfo(mode, &oid, *++ctx->argv, 0))
 		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
 	ctx->argc -= 3;
 	return 0;
