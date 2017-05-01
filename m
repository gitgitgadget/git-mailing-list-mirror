Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDDE61F829
	for <e@80x24.org>; Mon,  1 May 2017 02:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642397AbdEACcg (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:32:36 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:36060 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2999569AbdEACbd (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:31:33 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 35291280DE;
        Mon,  1 May 2017 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605816;
        bh=xZnSTljgVcUbAMUwk8CzXoxOLaqg+O9LtvdzMFEp06k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCkvenTOvTwabxVYlsTPh/sUWaqfRdXQfqD5JASlSPjAUrI/iMwFCzKqvOyx75Rjm
         6uAfZnIFsNlPI+9WOuI8S3oO4oQl4rp26pm5M6aC42+6dAxqbLkm3qQCbJgj2x1QTv
         QqNldMZOnjhiSN7gy5nCkaqLMv1eYMTxHfbpxTXp8i1/74VN7kWPqND/Uk8lxvOUEO
         Qxsmyr0bKMUhKgu0MquxAqpdkWlCXIqkId/Y0camNr41P9Ww8TiojAjUrKqjwIJyB2
         CVSVg6EXVTTEGiFJC2sW9Df7SrzFhqAMmLgdEtXzUFidfHjA2RHMu+DZtKLYF34Aha
         YBlw7L3xfisZIIaz42V44E0qHRuFfwK8/4JNYBKNcEp/pnoDfQ9cfOClsn2q87xlZS
         GA1Gk593Jkr6B7ldLYvCV2VF3lwhTNU9fsdaN0xM/6HLgGiMD+GMc7UOs/AKAcPsdl
         HfNMGWmGhmU56/ENScvvm9M8W7J0ocP/mR9Pob8TKTfPreSSJcD
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 48/53] merge: convert checkout_fast_forward to struct object_id
Date:   Mon,  1 May 2017 02:29:41 +0000
Message-Id: <20170501022946.258735-49-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Converting checkout_fast_forward is required to convert
parse_tree_indirect.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/merge.c | 4 ++--
 builtin/pull.c  | 4 ++--
 cache.h         | 4 ++--
 merge.c         | 8 ++++----
 sequencer.c     | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f11b5f3de..5ea7f7da9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1372,8 +1372,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			goto done;
 		}
 
-		if (checkout_fast_forward(head_commit->object.oid.hash,
-					  commit->object.oid.hash,
+		if (checkout_fast_forward(&head_commit->object.oid,
+					  &commit->object.oid,
 					  overwrite_ignore)) {
 			ret = 1;
 			goto done;
diff --git a/builtin/pull.c b/builtin/pull.c
index 2ffb6569a..318c273eb 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -523,7 +523,7 @@ static int pull_into_void(const struct object_id *merge_head,
 	 * index/worktree changes that the user already made on the unborn
 	 * branch.
 	 */
-	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, merge_head->hash, 0))
+	if (checkout_fast_forward(&empty_tree_oid, merge_head, 0))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head->hash, curr_head->hash, 0, UPDATE_REFS_DIE_ON_ERR))
@@ -839,7 +839,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"fast-forwarding your working tree from\n"
 			"commit %s."), oid_to_hex(&orig_head));
 
-		if (checkout_fast_forward(orig_head.hash, curr_head.hash, 0))
+		if (checkout_fast_forward(&orig_head, &curr_head, 0))
 			die(_("Cannot fast-forward your working tree.\n"
 				"After making sure that you saved anything precious from\n"
 				"$ git diff %s\n"
diff --git a/cache.h b/cache.h
index e1f0e182a..8862510f9 100644
--- a/cache.h
+++ b/cache.h
@@ -2198,8 +2198,8 @@ struct commit_list;
 int try_merge_command(const char *strategy, size_t xopts_nr,
 		const char **xopts, struct commit_list *common,
 		const char *head_arg, struct commit_list *remotes);
-int checkout_fast_forward(const unsigned char *from,
-			  const unsigned char *to,
+int checkout_fast_forward(const struct object_id *from,
+			  const struct object_id *to,
 			  int overwrite_ignore);
 
 
diff --git a/merge.c b/merge.c
index 04ee5fc91..b0cffe16f 100644
--- a/merge.c
+++ b/merge.c
@@ -44,8 +44,8 @@ int try_merge_command(const char *strategy, size_t xopts_nr,
 	return ret;
 }
 
-int checkout_fast_forward(const unsigned char *head,
-			  const unsigned char *remote,
+int checkout_fast_forward(const struct object_id *head,
+			  const struct object_id *remote,
 			  int overwrite_ignore)
 {
 	struct tree *trees[MAX_UNPACK_TREES];
@@ -79,10 +79,10 @@ int checkout_fast_forward(const unsigned char *head,
 	opts.fn = twoway_merge;
 	setup_unpack_trees_porcelain(&opts, "merge");
 
-	trees[nr_trees] = parse_tree_indirect(head);
+	trees[nr_trees] = parse_tree_indirect(head->hash);
 	if (!trees[nr_trees++])
 		return -1;
-	trees[nr_trees] = parse_tree_indirect(remote);
+	trees[nr_trees] = parse_tree_indirect(remote->hash);
 	if (!trees[nr_trees++])
 		return -1;
 	for (i = 0; i < nr_trees; i++) {
diff --git a/sequencer.c b/sequencer.c
index 68e032630..b295004af 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -382,7 +382,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
-	if (checkout_fast_forward(from->hash, to->hash, 1))
+	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
