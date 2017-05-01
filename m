Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A78B1F829
	for <e@80x24.org>; Mon,  1 May 2017 02:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426693AbdEACcn (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:43 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35912 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999578AbdEACbh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:37 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B3441280E1;
        Mon,  1 May 2017 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605816;
        bh=b9bqnZEUaUem62pHUnJyKiABsa7bm5SIkxqipwE124Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A8V1NuCmXFEhYjJFFZ/JwUYZt39IUs0jD1ldHSzvWue0EhVNuQaU+txX+7vUPh6GF
         XXlxeeM5rwUglr2zPSegkaCgYNZbq0JtiOma6Ynmb16RGDDUj1CGhXpdv/xP4MKK6c
         Clc8WhLCkGarbVX3WhTAIFyikLam2DTHxgs8s60UCOJ1BjnnOIZPubsWkB/hSUbZvV
         jMW9qEyktMBBIQTT9baRTCubPXyPADUQ1Byc8kzJDWQrQtQfmkvQA58O/AGMVe04a8
         AOivLwffXa+cAJxw57ikIYMjPIkg/gvTnPSpirJIl/bRSHBjQaW1pzBq7ee05SIx3H
         zetYRgeH676lqhAxTFh0E99yt/Gi/rxzzBcrlwFqSMpHbPLE3jFeizhpdJlrVFDGGe
         aw+RjpKBXZ1Re4yh5ypUM9DF/exMBApY1+nxZ6ywTP/knXq3ckG8TdcIJsGr4CCMTl
         ltPDcqCgxcsg7JvkXN8bAV6EbCG0TY9HuIxBp9p3A5qOnFQDsiA
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 50/53] diff-lib: convert do_diff_cache to struct object_id
Date:   Mon,  1 May 2017 02:29:43 +0000
Message-Id: <20170501022946.258735-51-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is needed to convert parse_tree_indirect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/am.c    |  2 +-
 builtin/blame.c |  6 +++---
 builtin/reset.c |  2 +-
 diff-lib.c      | 12 ++++++------
 diff.h          |  2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 642d7047d..200d9dbed 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1145,7 +1145,7 @@ static int index_has_changes(struct strbuf *sb)
 		DIFF_OPT_SET(&opt, EXIT_WITH_STATUS);
 		if (!sb)
 			DIFF_OPT_SET(&opt, QUICK);
-		do_diff_cache(head.hash, &opt);
+		do_diff_cache(&head, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
 			if (i)
diff --git a/builtin/blame.c b/builtin/blame.c
index 58bb274d0..e920314a7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -563,7 +563,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 	diff_setup_done(&diff_opts);
 
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
+		do_diff_cache(&parent->tree->object.oid, &diff_opts);
 	else
 		diff_tree_sha1(parent->tree->object.oid.hash,
 			       origin->commit->tree->object.oid.hash,
@@ -633,7 +633,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 	diff_setup_done(&diff_opts);
 
 	if (is_null_oid(&origin->commit->object.oid))
-		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
+		do_diff_cache(&parent->tree->object.oid, &diff_opts);
 	else
 		diff_tree_sha1(parent->tree->object.oid.hash,
 			       origin->commit->tree->object.oid.hash,
@@ -1272,7 +1272,7 @@ static void find_copy_in_parent(struct scoreboard *sb,
 		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 
 	if (is_null_oid(&target->commit->object.oid))
-		do_diff_cache(parent->tree->object.oid.hash, &diff_opts);
+		do_diff_cache(&parent->tree->object.oid, &diff_opts);
 	else
 		diff_tree_sha1(parent->tree->object.oid.hash,
 			       target->commit->tree->object.oid.hash,
diff --git a/builtin/reset.c b/builtin/reset.c
index 0be52fa36..3415dac5d 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -154,7 +154,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
 
-	if (do_diff_cache(tree_oid->hash, &opt))
+	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
diff --git a/diff-lib.c b/diff-lib.c
index 52447466b..ee9df0f84 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -478,7 +478,7 @@ static int oneway_diff(const struct cache_entry * const *src,
 }
 
 static int diff_cache(struct rev_info *revs,
-		      const unsigned char *tree_sha1,
+		      const struct object_id *tree_oid,
 		      const char *tree_name,
 		      int cached)
 {
@@ -486,10 +486,10 @@ static int diff_cache(struct rev_info *revs,
 	struct tree_desc t;
 	struct unpack_trees_options opts;
 
-	tree = parse_tree_indirect(tree_sha1);
+	tree = parse_tree_indirect(tree_oid->hash);
 	if (!tree)
 		return error("bad tree object %s",
-			     tree_name ? tree_name : sha1_to_hex(tree_sha1));
+			     tree_name ? tree_name : oid_to_hex(tree_oid));
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = 1;
 	opts.index_only = cached;
@@ -512,7 +512,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	struct object_array_entry *ent;
 
 	ent = revs->pending.objects;
-	if (diff_cache(revs, ent->item->oid.hash, ent->name, cached))
+	if (diff_cache(revs, &ent->item->oid, ent->name, cached))
 		exit(128);
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "c/", cached ? "i/" : "w/");
@@ -522,7 +522,7 @@ int run_diff_index(struct rev_info *revs, int cached)
 	return 0;
 }
 
-int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
+int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 {
 	struct rev_info revs;
 
@@ -530,7 +530,7 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt = *opt;
 
-	if (diff_cache(&revs, tree_sha1, NULL, 1))
+	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
 	return 0;
 }
diff --git a/diff.h b/diff.h
index 5be1ee77a..d75e6d15e 100644
--- a/diff.h
+++ b/diff.h
@@ -354,7 +354,7 @@ extern const char *diff_aligned_abbrev(const struct object_id *sha1, int);
 extern int run_diff_files(struct rev_info *revs, unsigned int option);
 extern int run_diff_index(struct rev_info *revs, int cached);
 
-extern int do_diff_cache(const unsigned char *, struct diff_options *);
+extern int do_diff_cache(const struct object_id *, struct diff_options *);
 extern int diff_flush_patch_id(struct diff_options *, unsigned char *, int);
 
 extern int diff_result_code(struct diff_options *, int);
