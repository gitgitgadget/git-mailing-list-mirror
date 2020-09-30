Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD10C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8F52071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgI3M2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:28:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:45288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgI3M2U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:28:20 -0400
Received: (qmail 23905 invoked by uid 109); 30 Sep 2020 12:28:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:28:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27916 invoked by uid 111); 30 Sep 2020 12:28:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:28:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:28:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/10] drop unused argc parameters
Message-ID: <20200930122818.GB1901279@coredump.intra.peff.net>
References: <20200930122732.GA1901036@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930122732.GA1901036@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many functions take an argv/argc pair, but never actually look at argc.
This makes it useless at best (we use the NULL sentinel in argv to find
the end of the array), and misleading at worst (what happens if the argc
count does not match the argv NULL?).

In each of these instances, the argv NULL does match the argc count, so
there are no bugs here. But let's tighten the interfaces to make it
harder to get wrong (and to reduce some -Wunused-parameter complaints).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/add.c                                |  4 ++--
 builtin/commit.c                             | 12 ++++++------
 commit.h                                     |  2 +-
 revision.c                                   |  6 +++---
 t/helper/test-submodule-nested-repo-config.c |  6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 26b6ced09e..a825887c50 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -239,7 +239,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	return status;
 }
 
-int interactive_add(int argc, const char **argv, const char *prefix, int patch)
+int interactive_add(const char **argv, const char *prefix, int patch)
 {
 	struct pathspec pathspec;
 
@@ -451,7 +451,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	if (add_interactive) {
 		if (pathspec_from_file)
 			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
-		exit(interactive_add(argc - 1, argv + 1, prefix, patch_interactive));
+		exit(interactive_add(argv + 1, prefix, patch_interactive));
 	}
 	if (legacy_stash_p) {
 		struct pathspec pathspec;
diff --git a/builtin/commit.c b/builtin/commit.c
index 42b964e0ca..1dfd799ec5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -326,7 +326,7 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
 
-static const char *prepare_index(int argc, const char **argv, const char *prefix,
+static const char *prepare_index(const char **argv, const char *prefix,
 				 const struct commit *current_head, int is_status)
 {
 	struct string_list partial = STRING_LIST_INIT_DUP;
@@ -378,7 +378,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-		if (interactive_add(argc, argv, prefix, patch_interactive) != 0)
+		if (interactive_add(argv, prefix, patch_interactive) != 0)
 			die(_("interactive add failed"));
 
 		the_repository->index_file = old_repo_index_file;
@@ -1241,13 +1241,13 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	return argc;
 }
 
-static int dry_run_commit(int argc, const char **argv, const char *prefix,
+static int dry_run_commit(const char **argv, const char *prefix,
 			  const struct commit *current_head, struct wt_status *s)
 {
 	int committable;
 	const char *index_file;
 
-	index_file = prepare_index(argc, argv, prefix, current_head, 1);
+	index_file = prepare_index(argv, prefix, current_head, 1);
 	committable = run_status(stdout, index_file, prefix, 0, s);
 	rollback_index_files();
 
@@ -1584,8 +1584,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
 	if (dry_run)
-		return dry_run_commit(argc, argv, prefix, current_head, &s);
-	index_file = prepare_index(argc, argv, prefix, current_head, 0);
+		return dry_run_commit(argv, prefix, current_head, &s);
+	index_file = prepare_index(argv, prefix, current_head, 0);
 
 	/* Set up everything for writing the commit object.  This includes
 	   running hooks, writing the trees, and interacting with the user.  */
diff --git a/commit.h b/commit.h
index e6f8f7c26f..5467786c7b 100644
--- a/commit.h
+++ b/commit.h
@@ -248,7 +248,7 @@ struct oid_array;
 struct ref;
 int for_each_commit_graft(each_commit_graft_fn, void *);
 
-int interactive_add(int argc, const char **argv, const char *prefix, int patch);
+int interactive_add(const char **argv, const char *prefix, int patch);
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const struct pathspec *pathspec);
 
diff --git a/revision.c b/revision.c
index d9dc5781ac..aa62212040 100644
--- a/revision.c
+++ b/revision.c
@@ -2580,8 +2580,8 @@ static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void
 }
 
 static int handle_revision_pseudo_opt(const char *submodule,
-				struct rev_info *revs,
-				int argc, const char **argv, int *flags)
+				      struct rev_info *revs,
+				      const char **argv, int *flags)
 {
 	const char *arg = argv[0];
 	const char *optarg;
@@ -2752,7 +2752,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			int opts;
 
 			opts = handle_revision_pseudo_opt(submodule,
-						revs, argc - i, argv + i,
+						revs, argv + i,
 						&flags);
 			if (opts > 0) {
 				i += opts - 1;
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index bc97929bbc..c5fd4527dc 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "submodule-config.h"
 
-static void die_usage(int argc, const char **argv, const char *msg)
+static void die_usage(const char **argv, const char *msg)
 {
 	fprintf(stderr, "%s\n", msg);
 	fprintf(stderr, "Usage: %s <submodulepath> <config name>\n", argv[0]);
@@ -14,13 +14,13 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv)
 	const struct submodule *sub;
 
 	if (argc < 3)
-		die_usage(argc, argv, "Wrong number of arguments.");
+		die_usage(argv, "Wrong number of arguments.");
 
 	setup_git_directory();
 
 	sub = submodule_from_path(the_repository, &null_oid, argv[1]);
 	if (repo_submodule_init(&subrepo, the_repository, sub)) {
-		die_usage(argc, argv, "Submodule not found.");
+		die_usage(argv, "Submodule not found.");
 	}
 
 	/* Read the config of _child_ submodules. */
-- 
2.28.0.1173.gad90222cf0

