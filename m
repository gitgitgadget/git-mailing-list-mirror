Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4148EC18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1374320727
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wkFH2p+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCJSWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:11 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51046 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726436AbgCJSWL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 14:22:11 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 8D27C607A4;
        Tue, 10 Mar 2020 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583864529;
        bh=m3pBgUv4fBeTRqfCH+RM+g7Cf6PH2U0xhXLgAGmrgN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=wkFH2p+rWJ9y1CURWnES2zvlUkqjatpniywfj7G3E/ZxeruNKbP8AVvY1OVuCfoDT
         QbpScDss22FvPHMRHPFUJ/suNA6JELQZEQAOncZ7V185rOGieZn0bHkwp1jbItPAnU
         5xD5XdnayX7deFCKWVEt0LyYMUG9CTM4vl6hwLn7LZoSHIHdADWTWzQCyuSC2u1Y3A
         gzBeppOthSi8/3j5Yci4+YYBnVtad68m1CHXb3auEwqG0dhwdaZU0e85re9cFiY3zx
         FpLreLG6beWrMl91hM8DP2MDhiud+V8EFDkIMy/8LXPr7YW0SoO7g3x4hD4LVphc1n
         8tRxTo4gf6dsTbr8o5gK4u39zrEy/Mk63tlI32IV8WKPCkCDdgeDJfn3Q9s8ZT57+T
         H4OhY+5RuSqcBr4hJ9APlSO2b33Ayjl9OefYOzKTOrD9BWZGa715qB1k2dWGuqjPx9
         UGx7COGTX0OtzN+KNYLzrt3xrHyvgcFlIP/Hr8f/ZcOP3E6qvRh
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/8] builtin/checkout: pass branch info down to checkout_worktree
Date:   Tue, 10 Mar 2020 18:20:39 +0000
Message-Id: <20200310182046.748959-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200310182046.748959-1-sandals@crustytoothpaste.net>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

In the future, we're going to want to use the branch info in
checkout_worktree, so let's pass the whole struct branch_info down, not
just the revision name.  We hoist the definition of struct branch_info
so it's in scope.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/checkout.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d6773818b8..8a28f48d67 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -88,6 +88,17 @@ struct checkout_opts {
 	struct tree *source_tree;
 };
 
+struct branch_info {
+	const char *name; /* The short name used */
+	const char *path; /* The full name of a real branch */
+	struct commit *commit; /* The named commit */
+	/*
+	 * if not null the branch is detached because it's already
+	 * checked out in this checkout
+	 */
+	char *checkout;
+};
+
 static int post_checkout_hook(struct commit *old_commit, struct commit *new_commit,
 			      int changed)
 {
@@ -337,7 +348,8 @@ static void mark_ce_for_checkout_no_overlay(struct cache_entry *ce,
 	}
 }
 
-static int checkout_worktree(const struct checkout_opts *opts)
+static int checkout_worktree(const struct checkout_opts *opts,
+			     const struct branch_info *info)
 {
 	struct checkout state = CHECKOUT_INIT;
 	int nr_checkouts = 0, nr_unmerged = 0;
@@ -396,7 +408,7 @@ static int checkout_worktree(const struct checkout_opts *opts)
 }
 
 static int checkout_paths(const struct checkout_opts *opts,
-			  const char *revision)
+			  const struct branch_info *new_branch_info)
 {
 	int pos;
 	static char *ps_matched;
@@ -462,7 +474,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		else
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
-		return run_add_interactive(revision, patch_mode, &opts->pathspec);
+		return run_add_interactive(new_branch_info->name, patch_mode, &opts->pathspec);
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
@@ -523,7 +535,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	/* Now we are committed to check them out */
 	if (opts->checkout_worktree)
-		errs |= checkout_worktree(opts);
+		errs |= checkout_worktree(opts, new_branch_info);
 	else
 		remove_marked_cache_entries(&the_index, 1);
 
@@ -620,17 +632,6 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	}
 }
 
-struct branch_info {
-	const char *name; /* The short name used */
-	const char *path; /* The full name of a real branch */
-	struct commit *commit; /* The named commit */
-	/*
-	 * if not null the branch is detached because it's already
-	 * checked out in this checkout
-	 */
-	char *checkout;
-};
-
 static void setup_branch_path(struct branch_info *branch)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -1710,7 +1711,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	UNLEAK(opts);
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, new_branch_info.name);
+		return checkout_paths(opts, &new_branch_info);
 	else
 		return checkout_branch(opts, &new_branch_info);
 }
