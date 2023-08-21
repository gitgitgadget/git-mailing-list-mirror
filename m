Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A4EE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjHUUTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHUUTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:19:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25759E4
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:19:46 -0700 (PDT)
Received: (qmail 17386 invoked by uid 109); 21 Aug 2023 20:19:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:19:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18692 invoked by uid 111); 21 Aug 2023 20:19:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:19:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:19:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 6/7] diff: drop useless return values in git-diff helpers
Message-ID: <20230821201944.GF1798590@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821201358.GA2663749@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since git-diff has many diff modes, it dispatches to many helpers to
perform each one. But every helper simply returns "0", as it exits
directly if there are serious errors (and options like --exit-code are
handled afterwards). So let's get rid of these useless return values,
which makes the code flow more clear.

There's very little chance that we'd later want to propagate errors
instead of dying immediately. These are all static-local helpers for the
git-diff program implementing its various modes. More "lib-ified" code
would directly call the underlying functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c | 62 +++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index e1f7647c84..3eba691b82 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -77,9 +77,9 @@ static void stuff_change(struct diff_options *opt,
 	diff_queue(&diff_queued_diff, one, two);
 }
 
-static int builtin_diff_b_f(struct rev_info *revs,
-			    int argc, const char **argv UNUSED,
-			    struct object_array_entry **blob)
+static void builtin_diff_b_f(struct rev_info *revs,
+			     int argc, const char **argv UNUSED,
+			     struct object_array_entry **blob)
 {
 	/* Blob vs file in the working tree*/
 	struct stat st;
@@ -109,12 +109,11 @@ static int builtin_diff_b_f(struct rev_info *revs,
 		     path);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-	return 0;
 }
 
-static int builtin_diff_blobs(struct rev_info *revs,
-			      int argc, const char **argv UNUSED,
-			      struct object_array_entry **blob)
+static void builtin_diff_blobs(struct rev_info *revs,
+			       int argc, const char **argv UNUSED,
+			       struct object_array_entry **blob)
 {
 	const unsigned mode = canon_mode(S_IFREG | 0644);
 
@@ -134,11 +133,10 @@ static int builtin_diff_blobs(struct rev_info *revs,
 		     blob_path(blob[0]), blob_path(blob[1]));
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
-	return 0;
 }
 
-static int builtin_diff_index(struct rev_info *revs,
-			      int argc, const char **argv)
+static void builtin_diff_index(struct rev_info *revs,
+			       int argc, const char **argv)
 {
 	unsigned int option = 0;
 	while (1 < argc) {
@@ -169,13 +167,12 @@ static int builtin_diff_index(struct rev_info *revs,
 		die_errno("repo_read_cache");
 	}
 	run_diff_index(revs, option);
-	return 0;
 }
 
-static int builtin_diff_tree(struct rev_info *revs,
-			     int argc, const char **argv,
-			     struct object_array_entry *ent0,
-			     struct object_array_entry *ent1)
+static void builtin_diff_tree(struct rev_info *revs,
+			      int argc, const char **argv,
+			      struct object_array_entry *ent0,
+			      struct object_array_entry *ent1)
 {
 	const struct object_id *(oid[2]);
 	struct object_id mb_oid;
@@ -208,13 +205,12 @@ static int builtin_diff_tree(struct rev_info *revs,
 	}
 	diff_tree_oid(oid[0], oid[1], "", &revs->diffopt);
 	log_tree_diff_flush(revs);
-	return 0;
 }
 
-static int builtin_diff_combined(struct rev_info *revs,
-				 int argc, const char **argv UNUSED,
-				 struct object_array_entry *ent,
-				 int ents, int first_non_parent)
+static void builtin_diff_combined(struct rev_info *revs,
+				  int argc, const char **argv UNUSED,
+				  struct object_array_entry *ent,
+				  int ents, int first_non_parent)
 {
 	struct oid_array parents = OID_ARRAY_INIT;
 	int i;
@@ -235,7 +231,6 @@ static int builtin_diff_combined(struct rev_info *revs,
 	}
 	diff_tree_combined(&ent[first_non_parent].item->oid, &parents, revs);
 	oid_array_clear(&parents);
-	return 0;
 }
 
 static void refresh_index_quietly(void)
@@ -253,7 +248,7 @@ static void refresh_index_quietly(void)
 	repo_update_index_if_able(the_repository, &lock_file);
 }
 
-static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
+static void builtin_diff_files(struct rev_info *revs, int argc, const char **argv)
 {
 	unsigned int options = 0;
 
@@ -291,7 +286,6 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 		die_errno("repo_read_index_preload");
 	}
 	run_diff_files(revs, options);
-	return 0;
 }
 
 struct symdiff {
@@ -405,7 +399,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int blobs = 0, paths = 0;
 	struct object_array_entry *blob[2];
 	int nongit = 0, no_index = 0;
-	int result = 0;
+	int result;
 	struct symdiff sdiff;
 
 	/*
@@ -584,17 +578,17 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (!ent.nr) {
 		switch (blobs) {
 		case 0:
-			result = builtin_diff_files(&rev, argc, argv);
+			builtin_diff_files(&rev, argc, argv);
 			break;
 		case 1:
 			if (paths != 1)
 				usage(builtin_diff_usage);
-			result = builtin_diff_b_f(&rev, argc, argv, blob);
+			builtin_diff_b_f(&rev, argc, argv, blob);
 			break;
 		case 2:
 			if (paths)
 				usage(builtin_diff_usage);
-			result = builtin_diff_blobs(&rev, argc, argv, blob);
+			builtin_diff_blobs(&rev, argc, argv, blob);
 			break;
 		default:
 			usage(builtin_diff_usage);
@@ -603,18 +597,18 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	else if (blobs)
 		usage(builtin_diff_usage);
 	else if (ent.nr == 1)
-		result = builtin_diff_index(&rev, argc, argv);
+		builtin_diff_index(&rev, argc, argv);
 	else if (ent.nr == 2) {
 		if (sdiff.warn)
 			warning(_("%s...%s: multiple merge bases, using %s"),
 				sdiff.left, sdiff.right, sdiff.base);
-		result = builtin_diff_tree(&rev, argc, argv,
-					   &ent.objects[0], &ent.objects[1]);
+		builtin_diff_tree(&rev, argc, argv,
+				  &ent.objects[0], &ent.objects[1]);
 	} else
-		result = builtin_diff_combined(&rev, argc, argv,
-					       ent.objects, ent.nr,
-					       first_non_parent);
-	result = diff_result_code(&rev.diffopt, result);
+		builtin_diff_combined(&rev, argc, argv,
+				      ent.objects, ent.nr,
+				      first_non_parent);
+	result = diff_result_code(&rev.diffopt, 0);
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
 	release_revisions(&rev);
-- 
2.42.0.rc2.423.g967ecb4f2b

