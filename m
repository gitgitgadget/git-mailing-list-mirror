Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A65D207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046275AbdDWViF (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:38:05 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37630 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046108AbdDWVgY (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:24 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4FF21280DF;
        Sun, 23 Apr 2017 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983343;
        bh=PWGG8TNbmMswWTGU8VI4IMFUtLMfJYQ+gSoIDZxIfRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVwD+L0HALajMQCbnK7lKyG9WX3WKZGeuWKp9dJIjCHn2xipjwp2AvO6zY5tcuQyE
         ged4C+sMLDDKnsY669ERNixZI7e2+YxuFjQiLPzkxQRKtavDudjcuAjGlcXnh8oT3K
         ZR9kt5MIi3hff+7yuRe4/OmbMgHMloPQPjtz+PpTA5IizdfbbNcRslEDFwxjmXGQrM
         OnS6TRL5+8D8BUcYM+LoZ/kJQy4TNJ1b6jIra1zlWrdgB0YI8x6dYfhohPD/1nDdtd
         WCaZh08HUjJ2/pgDxezYCquKWSo/ehrEyRMl66qgpuLO73Or0IO2d6mZu5MZteaylN
         FIqpMzC0iQcwyGaGdggVZGXV/5p/NhOdUNxA4JGPRvAYakodGRerpERIqdkqfHwncn
         CRZryrJgehUUHIyEZdgfHFIOB6+PTkKRX3N7Cp2jSp9JK0xNAvbz1+kA8g5NaBth0P
         nptP+iyAiSw7MJafWVWWs8eYIjigcK1p5nN/PXejVVzxcVtnGFu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 50/53] diff-lib: convert do_diff_cache to struct object_id
Date:   Sun, 23 Apr 2017 21:34:50 +0000
Message-Id: <20170423213453.253425-51-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
index 46828646c..210ecc554 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1143,7 +1143,7 @@ static int index_has_changes(struct strbuf *sb)
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
