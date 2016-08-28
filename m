Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5850C2018E
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756232AbcH1X2b (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:31 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41006 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932411AbcH1X2J (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:09 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3F337280B7;
        Sun, 28 Aug 2016 23:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426887;
        bh=jamlDcTzPt732txDiH+bJYB1kBHZyTJLSnbvT4UG8Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YGbMK8Uigu6W6P6h8zmQqpNl64/BRq3BVMql7F+6uRAFypIwQmkzzQFv0JHiIaVb6
         0rWsEcNwTA2ME5htlyJyPvWSgazKZNcXvFD0rQ8hpH8I+aet+Fjq3ZSg1wPZzLfKI1
         Cq0rwfRHLgdIUixqsrImIa6s3ZOHn7wjaMFeozDiks1iopHAcZS72DNDnm4+lzuY1A
         VPP7+cov6zWGDCb1rqRvOa1sCaTB7Hrp9YDCTy1vbKWjLKqLyOuKPf3Ep7Q15cDIc4
         by01CDz6/bbWcVUcBj6vCLkvlN6NtzbOyEXDUr5p2NOAamI3B12K/JHAX1VXuxpamT
         StNcBPjIDFc/VcU4m6W5Jkn1dfyS0VbNMk3E65CknK2P6jqnZPnRnEI29sQ0fRkWr6
         VqtvKxZ1EZMr5OaRrxNNnbgxgpNvIY5d8RnBo+E3busRX882kuWaDe8+jY8dLA6bJh
         iNXpV63YRHFrO7T1dfevYsjNpmNh7OhCCNq0fwiCv1Eex6ZEaD/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 20/20] builtin/reset: convert to use struct object_id
Date:   Sun, 28 Aug 2016 23:27:57 +0000
Message-Id: <20160828232757.373278-21-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reset.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 9020ec66..5aa86079 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -39,7 +39,7 @@ static inline int is_merge(void)
 	return !access(git_path_merge_head(), F_OK);
 }
 
-static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
+static int reset_index(const struct object_id *oid, int reset_type, int quiet)
 {
 	int nr = 1;
 	struct tree_desc desc[2];
@@ -69,22 +69,22 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
 	read_cache_unmerged();
 
 	if (reset_type == KEEP) {
-		unsigned char head_sha1[20];
-		if (get_sha1("HEAD", head_sha1))
+		struct object_id head_oid;
+		if (get_oid("HEAD", &head_oid))
 			return error(_("You do not have a valid HEAD."));
-		if (!fill_tree_descriptor(desc, head_sha1))
+		if (!fill_tree_descriptor(desc, head_oid.hash))
 			return error(_("Failed to find tree of HEAD."));
 		nr++;
 		opts.fn = twoway_merge;
 	}
 
-	if (!fill_tree_descriptor(desc + nr - 1, sha1))
-		return error(_("Failed to find tree of %s."), sha1_to_hex(sha1));
+	if (!fill_tree_descriptor(desc + nr - 1, oid->hash))
+		return error(_("Failed to find tree of %s."), oid_to_hex(oid));
 	if (unpack_trees(nr, desc, &opts))
 		return -1;
 
 	if (reset_type == MIXED || reset_type == HARD) {
-		tree = parse_tree_indirect(sha1);
+		tree = parse_tree_indirect(oid->hash);
 		prime_cache_tree(&the_index, tree);
 	}
 
@@ -143,7 +143,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 }
 
 static int read_from_tree(const struct pathspec *pathspec,
-			  unsigned char *tree_sha1,
+			  struct object_id *tree_oid,
 			  int intent_to_add)
 {
 	struct diff_options opt;
@@ -154,7 +154,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
 
-	if (do_diff_cache(tree_sha1, &opt))
+	if (do_diff_cache(tree_oid->hash, &opt))
 		return 1;
 	diffcore_std(&opt);
 	diff_flush(&opt);
@@ -191,7 +191,7 @@ static void parse_args(struct pathspec *pathspec,
 		       const char **rev_ret)
 {
 	const char *rev = "HEAD";
-	unsigned char unused[20];
+	struct object_id unused;
 	/*
 	 * Possible arguments are:
 	 *
@@ -216,8 +216,8 @@ static void parse_args(struct pathspec *pathspec,
 		 * has to be unambiguous. If there is a single argument, it
 		 * can not be a tree
 		 */
-		else if ((!argv[1] && !get_sha1_committish(argv[0], unused)) ||
-			 (argv[1] && !get_sha1_treeish(argv[0], unused))) {
+		else if ((!argv[1] && !get_sha1_committish(argv[0], unused.hash)) ||
+			 (argv[1] && !get_sha1_treeish(argv[0], unused.hash))) {
 			/*
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
@@ -241,24 +241,24 @@ static void parse_args(struct pathspec *pathspec,
 		       prefix, argv);
 }
 
-static int reset_refs(const char *rev, const unsigned char *sha1)
+static int reset_refs(const char *rev, const struct object_id *oid)
 {
 	int update_ref_status;
 	struct strbuf msg = STRBUF_INIT;
-	unsigned char *orig = NULL, sha1_orig[20],
-		*old_orig = NULL, sha1_old_orig[20];
+	struct object_id *orig = NULL, oid_orig,
+		*old_orig = NULL, oid_old_orig;
 
-	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
-		old_orig = sha1_old_orig;
-	if (!get_sha1("HEAD", sha1_orig)) {
-		orig = sha1_orig;
+	if (!get_oid("ORIG_HEAD", &oid_old_orig))
+		old_orig = &oid_old_orig;
+	if (!get_oid("HEAD", &oid_orig)) {
+		orig = &oid_orig;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
+		update_ref_oid(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
 			   UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
-		delete_ref("ORIG_HEAD", old_orig, 0);
+		delete_ref("ORIG_HEAD", old_orig->hash, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
-	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0,
+	update_ref_status = update_ref_oid(msg.buf, "HEAD", oid, orig, 0,
 				       UPDATE_REFS_MSG_ON_ERR);
 	strbuf_release(&msg);
 	return update_ref_status;
@@ -357,15 +357,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		hold_locked_index(lock, 1);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, oid.hash, intent_to_add))
+			if (read_from_tree(&pathspec, &oid, intent_to_add))
 				return 1;
 			if (get_git_work_tree())
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 		} else {
-			int err = reset_index(oid.hash, reset_type, quiet);
+			int err = reset_index(&oid, reset_type, quiet);
 			if (reset_type == KEEP && !err)
-				err = reset_index(oid.hash, MIXED, quiet);
+				err = reset_index(&oid, MIXED, quiet);
 			if (err)
 				die(_("Could not reset index file to revision '%s'."), rev);
 		}
@@ -377,7 +377,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (!pathspec.nr && !unborn) {
 		/* Any resets without paths update HEAD to the head being
 		 * switched to, saving the previous head in ORIG_HEAD before. */
-		update_ref_status = reset_refs(rev, oid.hash);
+		update_ref_status = reset_refs(rev, &oid);
 
 		if (reset_type == HARD && !update_ref_status && !quiet)
 			print_new_head_line(lookup_commit_reference(oid.hash));
