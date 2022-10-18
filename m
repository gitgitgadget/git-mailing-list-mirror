Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B97C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 01:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJRBCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiJRBCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 21:02:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BEF79A66
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 18:02:03 -0700 (PDT)
Received: (qmail 28720 invoked by uid 109); 18 Oct 2022 01:02:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Oct 2022 01:02:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13373 invoked by uid 111); 18 Oct 2022 01:02:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 21:02:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 21:02:02 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/12] submodule--helper: drop unused argc from
 module_list_compute()
Message-ID: <Y037Cnlg2ChlQAJT@coredump.intra.peff.net>
References: <Y036whEorZV0rOgB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y036whEorZV0rOgB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The module_list_compute() function takes an argc/argv pair, but never
looks at argc. This is OK, as the NULL terminator in argv is sufficient
for our purposes (we feed it to parse_pathspec(), which takes only the
array, not a count).

Note that one of the callers _looks_ like it would be buggy, but isn't:
we pass 0/NULL for argc/argv from module_foreach(), so finding the
terminating NULL in that argv naively would segfault. However,
parse_pathspec() is smart enough to interpret a bare NULL as an empty
argv.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b4acb442b..1e29a3d7dc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -181,7 +181,7 @@ static void module_list_release(struct module_list *ml)
 	free(ml->entries);
 }
 
-static int module_list_compute(int argc, const char **argv,
+static int module_list_compute(const char **argv,
 			       const char *prefix,
 			       struct pathspec *pathspec,
 			       struct module_list *list)
@@ -405,7 +405,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_foreach_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(0, NULL, prefix, &pathspec, &list) < 0)
+	if (module_list_compute(NULL, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
 	info.argc = argc;
@@ -545,7 +545,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_init_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
 	/*
@@ -732,7 +732,7 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_status_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
 	info.prefix = prefix;
@@ -1326,7 +1326,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_sync_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
 	info.prefix = prefix;
@@ -1479,7 +1479,7 @@ static int module_deinit(int argc, const char **argv, const char *prefix)
 	if (!argc && !all)
 		die(_("Use '--all' if you really want to deinitialize all submodules"));
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
 	info.prefix = prefix;
@@ -2697,7 +2697,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	if (opt.update_default)
 		opt.update_strategy.type = opt.update_default;
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &opt.list) < 0) {
+	if (module_list_compute(argv, prefix, &pathspec, &opt.list) < 0) {
 		ret = 1;
 		goto cleanup;
 	}
@@ -2709,7 +2709,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct module_list list = MODULE_LIST_INIT;
 		struct init_cb info = INIT_CB_INIT;
 
-		if (module_list_compute(argc, argv, opt.prefix,
+		if (module_list_compute(argv, opt.prefix,
 					&pathspec2, &list) < 0) {
 			module_list_release(&list);
 			ret = 1;
@@ -2840,7 +2840,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, embed_gitdir_options,
 			     git_submodule_helper_usage, 0);
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
+	if (module_list_compute(argv, prefix, &pathspec, &list) < 0)
 		goto cleanup;
 
 	for (i = 0; i < list.nr; i++)
-- 
2.38.0.371.g300879f34e

