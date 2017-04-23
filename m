Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F03A207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046280AbdDWViI (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:38:08 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37624 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046083AbdDWVgS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:36:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id D0344280DD;
        Sun, 23 Apr 2017 21:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983342;
        bh=FeQQtFeoaxAqX6Tj4fD3BCEBOjUjLTdNGZPNZFxhd4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISRGR1eMVwEsQsIjjAi73UZfFEJSoSmAw8FCdxJGr+auYIpQ5j+3O0Ryh3gTCQdpM
         7ZKCYp6wDqqUgPdRiFyiLncXGKeSBAvEi+QvZc2FTOQT0LtpPesEe2ufqtxWuAHRhA
         kxdbDZVd4q7a04+xQjLSfQL7Ho316x7LnOVLJ4xEv6q8d/QS9aa72UxIb5WLmNAjC+
         L4Rq3kZoVVh4EQSzRuwgijtFZR7P1hpdoLGbC1NoPAgTvpz9BckhH4A6ScNrpbC8Tu
         ySMJwBeqG+1gW5g65MtXtv4hEcXFusKQtEMh0cAkqo+JSCQbwKvyXcSxYwn6lTaxmk
         a5Lg+hA6fm+SFGTzN9gxh8WxR3aex0cXpu8DoEX1eTC2gdCCOE1cQ3mJakSNTgw+Gz
         I4fmIWAZfVN4637bXmo7QFlSLw/YUiAN4rfbUnlOS7D+ontChpU7Tl/6h6NgwD/9BD
         RK+KM0Pqfu6x1oa2l+RDN5hobD8eUqP04wmdCHIkEIStrOQvIS/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 48/53] merge: convert checkout_fast_forward to struct object_id
Date:   Sun, 23 Apr 2017 21:34:48 +0000
Message-Id: <20170423213453.253425-49-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
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
index 21e114ec0..f539c7f78 100644
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
index ba27595d5..552c44ef0 100644
--- a/cache.h
+++ b/cache.h
@@ -2188,8 +2188,8 @@ struct commit_list;
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
index c673bb930..dfa44afa7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -382,7 +382,7 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
-	if (checkout_fast_forward(from->hash, to->hash, 1))
+	if (checkout_fast_forward(from, to, 1))
 		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
