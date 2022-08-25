Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6738C04AA5
	for <git@archiver.kernel.org>; Thu, 25 Aug 2022 10:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiHYKrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 06:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbiHYKrF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 06:47:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0082A2230
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 03:47:01 -0700 (PDT)
Received: (qmail 14169 invoked by uid 109); 25 Aug 2022 10:47:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 25 Aug 2022 10:47:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28381 invoked by uid 111); 25 Aug 2022 10:47:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Aug 2022 06:47:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 25 Aug 2022 06:47:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH 1/3] pass subcommand "prefix" arguments to parse_options()
Message-ID: <YwdTJOVo46PrIHMc@coredump.intra.peff.net>
References: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recent commits such as bf0a6b65fc (builtin/multi-pack-index.c: let
parse-options parse subcommands, 2022-08-19) converted a few functions
to match our usual argc/argv/prefix conventions, but the prefix argument
remains unused.

However, there is a good use for it: they should pass it to their own
parse_options() functions, where it may be used to adjust the value of
any filename options. In all but one of these functions, there's no
behavior change, since they don't use OPT_FILENAME. But this is an
actual fix for one option, which you can see by modifying the test suite
like so:

	diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
	index 4fe57414c1..d0974d4371 100755
	--- a/t/t5326-multi-pack-bitmaps.sh
	+++ b/t/t5326-multi-pack-bitmaps.sh
	@@ -186,7 +186,11 @@ test_expect_success 'writing a bitmap with --refs-snapshot' '

	 		# Then again, but with a refs snapshot which only sees
	 		# refs/tags/one.
	-		git multi-pack-index write --bitmap --refs-snapshot=snapshot &&
	+		(
	+			mkdir subdir &&
	+			cd subdir &&
	+			git multi-pack-index write --bitmap --refs-snapshot=../snapshot
	+		) &&

	 		test_path_is_file $midx &&
	 		test_path_is_file $midx-$(midx_checksum $objdir).bitmap &&

I'd emphasize that this wasn't broken by bf0a6b65fc; it has been broken
all along, because the sub-function never got to see the prefix. It is
that commit which is actually enabling us to fix it (and which also
brought attention to the problem because it triggers -Wunused-parameter!)

The other functions changed here don't use OPT_FILENAME at all. In their
cases this isn't fixing anything visible, but it's following the usual
pattern and future-proofing them against somebody adding new options and
being surprised.

I didn't include a test for the one visible case above. We don't
generally test routine parse-options behavior for individual options.
The challenge here was finding the problem, and now that this has been
done, it's not likely to regress. Likewise, we could apply the patch
above to cover it "for free" but it makes reading the rest of the test
unnecessarily complicated.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit-graph.c     |  4 ++--
 builtin/multi-pack-index.c |  8 ++++----
 builtin/remote.c           | 28 ++++++++++++++++------------
 builtin/sparse-checkout.c  |  8 ++++----
 4 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 1eb5492cbd..dc3cc35394 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -80,7 +80,7 @@ static int graph_verify(int argc, const char **argv, const char *prefix)
 	trace2_cmd_mode("verify");
 
 	opts.progress = isatty(2);
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     options,
 			     builtin_commit_graph_verify_usage, 0);
 	if (argc)
@@ -241,7 +241,7 @@ static int graph_write(int argc, const char **argv, const char *prefix)
 
 	git_config(git_commit_graph_write_config, &opts);
 
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     options,
 			     builtin_commit_graph_write_usage, 0);
 	if (argc)
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index b8320d597b..248929f2e6 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -133,7 +133,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	if (isatty(2))
 		opts.flags |= MIDX_PROGRESS;
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     options, builtin_multi_pack_index_write_usage,
 			     0);
 	if (argc)
@@ -176,7 +176,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 
 	if (isatty(2))
 		opts.flags |= MIDX_PROGRESS;
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     options, builtin_multi_pack_index_verify_usage,
 			     0);
 	if (argc)
@@ -203,7 +203,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 
 	if (isatty(2))
 		opts.flags |= MIDX_PROGRESS;
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     options, builtin_multi_pack_index_expire_usage,
 			     0);
 	if (argc)
@@ -233,7 +233,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 
 	if (isatty(2))
 		opts.flags |= MIDX_PROGRESS;
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     options,
 			     builtin_multi_pack_index_repack_usage,
 			     0);
diff --git a/builtin/remote.c b/builtin/remote.c
index 4a6d47c03a..96f562f00a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -177,8 +177,8 @@ static int add(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_add_usage,
-			     0);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_add_usage, 0);
 
 	if (argc != 2)
 		usage_with_options(builtin_remote_add_usage, options);
@@ -695,7 +695,7 @@ static int mv(int argc, const char **argv, const char *prefix)
 	int i, refs_renamed_nr = 0, refspec_updated = 0;
 	struct progress *progress = NULL;
 
-	argc = parse_options(argc, argv, NULL, options,
+	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_rename_usage, 0);
 
 	if (argc != 2)
@@ -1264,7 +1264,8 @@ static int show(int argc, const char **argv, const char *prefix)
 	};
 	struct show_info info = SHOW_INFO_INIT;
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_show_usage,
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_show_usage,
 			     0);
 
 	if (argc < 1)
@@ -1371,8 +1372,8 @@ static int set_head(int argc, const char **argv, const char *prefix)
 			 N_("delete refs/remotes/<name>/HEAD")),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_sethead_usage,
-			     0);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_sethead_usage, 0);
 	if (argc)
 		strbuf_addf(&buf, "refs/remotes/%s/HEAD", argv[0]);
 
@@ -1471,8 +1472,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_prune_usage,
-			     0);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_prune_usage, 0);
 
 	if (argc < 1)
 		usage_with_options(builtin_remote_prune_usage, options);
@@ -1504,7 +1505,8 @@ static int update(int argc, const char **argv, const char *prefix)
 	int default_defined = 0;
 	int retval;
 
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_update_usage,
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_update_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
 	strvec_push(&fetch_argv, "fetch");
@@ -1583,7 +1585,7 @@ static int set_branches(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	argc = parse_options(argc, argv, NULL, options,
+	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_setbranches_usage, 0);
 	if (argc == 0) {
 		error(_("no remote specified"));
@@ -1608,7 +1610,8 @@ static int get_url(int argc, const char **argv, const char *prefix)
 			 N_("return all URLs")),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_geturl_usage, 0);
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_geturl_usage, 0);
 
 	if (argc != 1)
 		usage_with_options(builtin_remote_geturl_usage, options);
@@ -1668,7 +1671,8 @@ static int set_url(int argc, const char **argv, const char *prefix)
 			    N_("delete URLs")),
 		OPT_END()
 	};
-	argc = parse_options(argc, argv, NULL, options, builtin_remote_seturl_usage,
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_remote_seturl_usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
 	if (add_mode && delete_mode)
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 7b39a150a9..287716db68 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -60,7 +60,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 	if (!core_apply_sparse_checkout)
 		die(_("this worktree is not sparse"));
 
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_list_options,
 			     builtin_sparse_checkout_list_usage, 0);
 
@@ -452,7 +452,7 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 	init_opts.cone_mode = -1;
 	init_opts.sparse_index = -1;
 
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_init_options,
 			     builtin_sparse_checkout_init_usage, 0);
 
@@ -860,7 +860,7 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	reapply_opts.cone_mode = -1;
 	reapply_opts.sparse_index = -1;
 
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
 
@@ -897,7 +897,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
 	 * forcibly return to a dense checkout regardless of initial state.
 	 */
 
-	argc = parse_options(argc, argv, NULL,
+	argc = parse_options(argc, argv, prefix,
 			     builtin_sparse_checkout_disable_options,
 			     builtin_sparse_checkout_disable_usage, 0);
 
-- 
2.37.2.1034.gd926c9c740

