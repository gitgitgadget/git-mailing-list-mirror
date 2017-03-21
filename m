Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB16C20958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756103AbdCUBWe (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:22:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:48312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755329AbdCUBWd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:22:33 -0400
Received: (qmail 10279 invoked by uid 109); 21 Mar 2017 01:22:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:22:32 +0000
Received: (qmail 9867 invoked by uid 111); 21 Mar 2017 01:22:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:22:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:22:28 -0400
Date:   Mon, 20 Mar 2017 21:22:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] prefix_filename: drop length parameter
Message-ID: <20170321012228.ondlwe4hoaf3yks4@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function takes the prefix as a ptr/len pair, but in
every caller the length is exactly strlen(ptr). Let's
simplify the interface and just take the string. This saves
callers specifying it (and in some cases handling a NULL
prefix).

In a handful of cases we had the length already without
calling strlen, so this is technically slower. But it's not
likely to matter (after all, if the prefix is non-empty
we'll allocate and copy it into a buffer anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 abspath.c             | 4 +++-
 apply.c               | 6 ++----
 builtin/config.c      | 1 -
 builtin/hash-object.c | 9 +++------
 builtin/log.c         | 3 +--
 builtin/mailinfo.c    | 2 +-
 builtin/merge-file.c  | 8 ++------
 builtin/rev-parse.c   | 4 +---
 builtin/worktree.c    | 2 +-
 cache.h               | 2 +-
 diff-no-index.c       | 7 +++----
 diff.c                | 4 ++--
 parse-options.c       | 2 +-
 setup.c               | 2 +-
 worktree.c            | 2 +-
 15 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/abspath.c b/abspath.c
index fd30aff08..c6f480993 100644
--- a/abspath.c
+++ b/abspath.c
@@ -246,9 +246,11 @@ char *absolute_pathdup(const char *path)
 	return strbuf_detach(&sb, NULL);
 }
 
-const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
+const char *prefix_filename(const char *pfx, const char *arg)
 {
 	static struct strbuf path = STRBUF_INIT;
+	size_t pfx_len = pfx ? strlen(pfx) : 0;
+
 #ifndef GIT_WINDOWS_NATIVE
 	if (!pfx_len || is_absolute_path(arg))
 		return arg;
diff --git a/apply.c b/apply.c
index 0e2caeab9..b8bd5a4be 100644
--- a/apply.c
+++ b/apply.c
@@ -2046,7 +2046,7 @@ static void prefix_one(struct apply_state *state, char **name)
 	char *old_name = *name;
 	if (!old_name)
 		return;
-	*name = xstrdup(prefix_filename(state->prefix, state->prefix_length, *name));
+	*name = xstrdup(prefix_filename(state->prefix, *name));
 	free(old_name);
 }
 
@@ -4815,9 +4815,7 @@ int apply_all_patches(struct apply_state *state,
 			read_stdin = 0;
 			continue;
 		} else if (0 < state->prefix_length)
-			arg = prefix_filename(state->prefix,
-					      state->prefix_length,
-					      arg);
+			arg = prefix_filename(state->prefix, arg);
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0) {
diff --git a/builtin/config.c b/builtin/config.c
index 05843a0f9..74f6c34d1 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -528,7 +528,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
 				xstrdup(prefix_filename(prefix,
-							strlen(prefix),
 							given_config_source.file));
 	}
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 56df77b0c..2ea36909d 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -102,7 +102,6 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int i;
-	int prefix_length = -1;
 	const char *errstr = NULL;
 
 	argc = parse_options(argc, argv, NULL, hash_object_options,
@@ -113,9 +112,8 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 	else
 		prefix = setup_git_directory_gently(&nongit);
 
-	prefix_length = prefix ? strlen(prefix) : 0;
 	if (vpath && prefix)
-		vpath = xstrdup(prefix_filename(prefix, prefix_length, vpath));
+		vpath = xstrdup(prefix_filename(prefix, vpath));
 
 	git_config(git_default_config, NULL);
 
@@ -146,9 +144,8 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 		char *to_free = NULL;
 
-		if (0 <= prefix_length)
-			arg = to_free =
-				xstrdup(prefix_filename(prefix, prefix_length, arg));
+		if (prefix)
+			arg = to_free = xstrdup(prefix_filename(prefix, arg));
 		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
 			    flags, literally);
 		free(to_free);
diff --git a/builtin/log.c b/builtin/log.c
index 281af8c1e..bfdc7a23d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1084,8 +1084,7 @@ static const char *set_outdir(const char *prefix, const char *output_directory)
 	if (!output_directory)
 		return prefix;
 
-	return xstrdup(prefix_filename(prefix, outdir_offset,
-				       output_directory));
+	return xstrdup(prefix_filename(prefix, output_directory));
 }
 
 static const char * const builtin_format_patch_usage[] = {
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index e3b62f2fc..681f07f54 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -15,7 +15,7 @@ static char *prefix_copy(const char *prefix, const char *filename)
 {
 	if (!prefix || is_absolute_path(filename))
 		return xstrdup(filename);
-	return xstrdup(prefix_filename(prefix, strlen(prefix), filename));
+	return xstrdup(prefix_filename(prefix, filename));
 }
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 13e22a2f0..63cd94358 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -28,7 +28,6 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	xmparam_t xmp = {{0}};
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
-	int prefixlen = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
 		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
@@ -65,11 +64,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			return error_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (prefix)
-		prefixlen = strlen(prefix);
-
 	for (i = 0; i < 3; i++) {
-		const char *fname = prefix_filename(prefix, prefixlen, argv[i]);
+		const char *fname = prefix_filename(prefix, argv[i]);
 		if (!names[i])
 			names[i] = argv[i];
 		if (read_mmfile(mmfs + i, fname))
@@ -90,7 +86,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 	if (ret >= 0) {
 		const char *filename = argv[0];
-		const char *fpath = prefix_filename(prefix, prefixlen, argv[0]);
+		const char *fpath = prefix_filename(prefix, argv[0]);
 		FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
 
 		if (!f)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 254964326..c8035331e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -228,9 +228,7 @@ static int show_file(const char *arg, int output_prefix)
 	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
 		if (output_prefix) {
 			const char *prefix = startup_info->prefix;
-			show(prefix_filename(prefix,
-					     prefix ? strlen(prefix) : 0,
-					     arg));
+			show(prefix_filename(prefix, arg));
 		} else
 			show(arg);
 		return 1;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 831fe058a..e38325e44 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -338,7 +338,7 @@ static int add(int ac, const char **av, const char *prefix)
 	if (ac < 1 || ac > 2)
 		usage_with_options(worktree_usage, options);
 
-	path = prefix_filename(prefix, strlen(prefix), av[0]);
+	path = prefix_filename(prefix, av[0]);
 	branch = ac < 2 ? "HEAD" : av[1];
 
 	if (!strcmp(branch, "-"))
diff --git a/cache.h b/cache.h
index a01668fc4..0b53aef0e 100644
--- a/cache.h
+++ b/cache.h
@@ -540,7 +540,7 @@ extern char *prefix_path_gently(const char *prefix, int len, int *remaining, con
  * The return value may point to static storage which will be overwritten by
  * further calls.
  */
-extern const char *prefix_filename(const char *prefix, int len, const char *path);
+extern const char *prefix_filename(const char *prefix, const char *path);
 
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix,
diff --git a/diff-no-index.c b/diff-no-index.c
index df762fd0f..5f7317ced 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -236,7 +236,7 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv)
 {
-	int i, prefixlen;
+	int i;
 	const char *paths[2];
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
@@ -257,7 +257,6 @@ void diff_no_index(struct rev_info *revs,
 		}
 	}
 
-	prefixlen = prefix ? strlen(prefix) : 0;
 	for (i = 0; i < 2; i++) {
 		const char *p = argv[argc - 2 + i];
 		if (!strcmp(p, "-"))
@@ -266,8 +265,8 @@ void diff_no_index(struct rev_info *revs,
 			 * path that is "-", spell it as "./-".
 			 */
 			p = file_from_standard_input;
-		else if (prefixlen)
-			p = xstrdup(prefix_filename(prefix, prefixlen, p));
+		else if (prefix)
+			p = xstrdup(prefix_filename(prefix, p));
 		paths[i] = p;
 	}
 
diff --git a/diff.c b/diff.c
index a628ac3a9..70870b4b6 100644
--- a/diff.c
+++ b/diff.c
@@ -4023,7 +4023,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--pickaxe-regex"))
 		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
 	else if ((argcount = short_opt('O', av, &optarg))) {
-		const char *path = prefix_filename(prefix, strlen(prefix), optarg);
+		const char *path = prefix_filename(prefix, optarg);
 		options->orderfile = xstrdup(path);
 		return argcount;
 	}
@@ -4071,7 +4071,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-function-context"))
 		DIFF_OPT_CLR(options, FUNCCONTEXT);
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
-		const char *path = prefix_filename(prefix, strlen(prefix), optarg);
+		const char *path = prefix_filename(prefix, optarg);
 		options->file = fopen(path, "w");
 		if (!options->file)
 			die_errno("Could not open '%s'", path);
diff --git a/parse-options.c b/parse-options.c
index 4fbe924a5..ba6cc30b2 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -40,7 +40,7 @@ static void fix_filename(const char *prefix, const char **file)
 	if (!file || !*file || !prefix || is_absolute_path(*file)
 	    || !strcmp("-", *file))
 		return;
-	*file = xstrdup(prefix_filename(prefix, strlen(prefix), *file));
+	*file = xstrdup(prefix_filename(prefix, *file));
 }
 
 static int opt_command_mode_error(const struct option *opt,
diff --git a/setup.c b/setup.c
index 64f922a93..a76379e0c 100644
--- a/setup.c
+++ b/setup.c
@@ -142,7 +142,7 @@ int check_filename(const char *prefix, const char *arg)
 			return 1;
 		name = arg + 2;
 	} else if (prefix)
-		name = prefix_filename(prefix, strlen(prefix), arg);
+		name = prefix_filename(prefix, arg);
 	else
 		name = arg;
 	if (!lstat(name, &st))
diff --git a/worktree.c b/worktree.c
index fa7bc67a5..42dd3d52b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -254,7 +254,7 @@ struct worktree *find_worktree(struct worktree **list,
 	if ((wt = find_worktree_by_suffix(list, arg)))
 		return wt;
 
-	arg = prefix_filename(prefix, strlen(prefix), arg);
+	arg = prefix_filename(prefix, arg);
 	path = real_pathdup(arg, 1);
 	for (; *list; list++)
 		if (!fspathcmp(path, real_path((*list)->path)))
-- 
2.12.1.683.gcd02edfec

