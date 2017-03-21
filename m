Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF7B20958
	for <e@80x24.org>; Tue, 21 Mar 2017 01:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbdCUB26 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 21:28:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:48322 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753724AbdCUB25 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 21:28:57 -0400
Received: (qmail 10805 invoked by uid 109); 21 Mar 2017 01:28:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Mar 2017 01:28:53 +0000
Received: (qmail 9919 invoked by uid 111); 21 Mar 2017 01:29:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 21:29:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 21:28:49 -0400
Date:   Mon, 20 Mar 2017 21:28:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] prefix_filename: return newly allocated string
Message-ID: <20170321012847.yebhpdmk5zrizgmj@sigill.intra.peff.net>
References: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170321011838.rdhnbfwbigm4s4e3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prefix_filename() function returns a pointer to static
storage, which makes it easy to use dangerously. We already
fixed one buggy caller in hash-object recently, and the
calls in apply.c are suspicious (I didn't dig in enough to
confirm that there is a bug, but we call the function once
in apply_all_patches() and then again indirectly from
parse_chunk()).

Let's make it harder to get wrong by allocating the return
value. For simplicity, we'll do this even when the prefix is
empty (and we could just return the original file pointer).
That will cause us to allocate sometimes when we wouldn't
otherwise need to, but this function isn't called in
performance critical code-paths (and it already _might_
allocate on any given call, so a caller that cares about
performance is questionable anyway).

The downside is that the callers need to remember to free()
the result to avoid leaking. Most of them already used
xstrdup() on the result, so we know they are OK. The
remainder have been converted to use free() as appropriate.

I considered retaining a prefix_filename_unsafe() for cases
where we know the static lifetime is OK (and handling the
cleanup is awkward). This is only a handful of cases,
though, and it's not worth the mental energy in worrying
about whether the "unsafe" variant is OK to use in any
situation.

Signed-off-by: Jeff King <peff@peff.net>
---
 abspath.c             | 10 ++++------
 apply.c               |  9 ++++++---
 builtin/config.c      |  3 +--
 builtin/hash-object.c |  2 +-
 builtin/log.c         |  2 +-
 builtin/mailinfo.c    | 11 ++---------
 builtin/merge-file.c  | 14 +++++++++++---
 builtin/rev-parse.c   |  4 +++-
 builtin/worktree.c    |  3 ++-
 cache.h               |  6 +++---
 diff-no-index.c       |  2 +-
 diff.c                |  6 +++---
 parse-options.c       |  2 +-
 setup.c               | 11 ++++++++---
 worktree.c            |  5 ++++-
 15 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/abspath.c b/abspath.c
index c6f480993..4addd1fde 100644
--- a/abspath.c
+++ b/abspath.c
@@ -246,20 +246,18 @@ char *absolute_pathdup(const char *path)
 	return strbuf_detach(&sb, NULL);
 }
 
-const char *prefix_filename(const char *pfx, const char *arg)
+char *prefix_filename(const char *pfx, const char *arg)
 {
-	static struct strbuf path = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
 	size_t pfx_len = pfx ? strlen(pfx) : 0;
 
 #ifndef GIT_WINDOWS_NATIVE
 	if (!pfx_len || is_absolute_path(arg))
-		return arg;
-	strbuf_reset(&path);
+		return xstrdup(arg);
 	strbuf_add(&path, pfx, pfx_len);
 	strbuf_addstr(&path, arg);
 #else
 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
-	strbuf_reset(&path);
 	if (is_absolute_path(arg))
 		pfx_len = 0;
 	else if (pfx_len)
@@ -267,5 +265,5 @@ const char *prefix_filename(const char *pfx, const char *arg)
 	strbuf_addstr(&path, arg);
 	convert_slashes(path.buf + pfx_len);
 #endif
-	return path.buf;
+	return strbuf_detach(&path, NULL);
 }
diff --git a/apply.c b/apply.c
index b8bd5a4be..e6dbab26a 100644
--- a/apply.c
+++ b/apply.c
@@ -2046,7 +2046,7 @@ static void prefix_one(struct apply_state *state, char **name)
 	char *old_name = *name;
 	if (!old_name)
 		return;
-	*name = xstrdup(prefix_filename(state->prefix, *name));
+	*name = prefix_filename(state->prefix, *name);
 	free(old_name);
 }
 
@@ -4805,6 +4805,7 @@ int apply_all_patches(struct apply_state *state,
 
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
+		char *to_free = NULL;
 		int fd;
 
 		if (!strcmp(arg, "-")) {
@@ -4814,19 +4815,21 @@ int apply_all_patches(struct apply_state *state,
 			errs |= res;
 			read_stdin = 0;
 			continue;
-		} else if (0 < state->prefix_length)
-			arg = prefix_filename(state->prefix, arg);
+		} else
+			arg = to_free = prefix_filename(state->prefix, arg);
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0) {
 			error(_("can't open patch '%s': %s"), arg, strerror(errno));
 			res = -128;
+			free(to_free);
 			goto end;
 		}
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
 		res = apply_patch(state, fd, arg, options);
 		close(fd);
+		free(to_free);
 		if (res < 0)
 			goto end;
 		errs |= res;
diff --git a/builtin/config.c b/builtin/config.c
index 74f6c34d1..4f49a0edb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -527,8 +527,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	else if (given_config_source.file) {
 		if (!is_absolute_path(given_config_source.file) && prefix)
 			given_config_source.file =
-				xstrdup(prefix_filename(prefix,
-							given_config_source.file));
+				prefix_filename(prefix, given_config_source.file);
 	}
 
 	if (respect_includes == -1)
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 2ea36909d..bbeaf20bc 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -145,7 +145,7 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
 		char *to_free = NULL;
 
 		if (prefix)
-			arg = to_free = xstrdup(prefix_filename(prefix, arg));
+			arg = to_free = prefix_filename(prefix, arg);
 		hash_object(arg, type, no_filters ? NULL : vpath ? vpath : arg,
 			    flags, literally);
 		free(to_free);
diff --git a/builtin/log.c b/builtin/log.c
index bfdc7a23d..670229cbb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1084,7 +1084,7 @@ static const char *set_outdir(const char *prefix, const char *output_directory)
 	if (!output_directory)
 		return prefix;
 
-	return xstrdup(prefix_filename(prefix, output_directory));
+	return prefix_filename(prefix, output_directory);
 }
 
 static const char * const builtin_format_patch_usage[] = {
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 681f07f54..cfb667a59 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -11,13 +11,6 @@
 static const char mailinfo_usage[] =
 	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
 
-static char *prefix_copy(const char *prefix, const char *filename)
-{
-	if (!prefix || is_absolute_path(filename))
-		return xstrdup(filename);
-	return xstrdup(prefix_filename(prefix, filename));
-}
-
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
 	const char *def_charset;
@@ -60,8 +53,8 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 	mi.input = stdin;
 	mi.output = stdout;
 
-	msgfile = prefix_copy(prefix, argv[1]);
-	patchfile = prefix_copy(prefix, argv[2]);
+	msgfile = prefix_filename(prefix, argv[1]);
+	patchfile = prefix_filename(prefix, argv[2]);
 
 	status = !!mailinfo(&mi, msgfile, patchfile);
 	clear_mailinfo(&mi);
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 63cd94358..47dde7c39 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -65,11 +65,18 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < 3; i++) {
-		const char *fname = prefix_filename(prefix, argv[i]);
+		char *fname;
+		int ret;
+
 		if (!names[i])
 			names[i] = argv[i];
-		if (read_mmfile(mmfs + i, fname))
+
+		fname = prefix_filename(prefix, argv[i]);
+		ret = read_mmfile(mmfs + i, fname);
+		free(fname);
+		if (ret)
 			return -1;
+
 		if (mmfs[i].size > MAX_XDIFF_SIZE ||
 		    buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
 			return error("Cannot merge binary files: %s",
@@ -86,7 +93,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 
 	if (ret >= 0) {
 		const char *filename = argv[0];
-		const char *fpath = prefix_filename(prefix, argv[0]);
+		char *fpath = prefix_filename(prefix, argv[0]);
 		FILE *f = to_stdout ? stdout : fopen(fpath, "wb");
 
 		if (!f)
@@ -98,6 +105,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		else if (fclose(f))
 			ret = error_errno("Could not close %s", filename);
 		free(result.ptr);
+		free(fpath);
 	}
 
 	if (ret > 127)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c8035331e..7cd01c281 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -228,7 +228,9 @@ static int show_file(const char *arg, int output_prefix)
 	if ((filter & (DO_NONFLAGS|DO_NOREV)) == (DO_NONFLAGS|DO_NOREV)) {
 		if (output_prefix) {
 			const char *prefix = startup_info->prefix;
-			show(prefix_filename(prefix, arg));
+			char *fname = prefix_filename(prefix, arg);
+			show(fname);
+			free(fname);
 		} else
 			show(arg);
 		return 1;
diff --git a/builtin/worktree.c b/builtin/worktree.c
index e38325e44..9993ded41 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -318,7 +318,8 @@ static int add(int ac, const char **av, const char *prefix)
 {
 	struct add_opts opts;
 	const char *new_branch_force = NULL;
-	const char *path, *branch;
+	char *path;
+	const char *branch;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
diff --git a/cache.h b/cache.h
index 0b53aef0e..aa6a0fb91 100644
--- a/cache.h
+++ b/cache.h
@@ -537,10 +537,10 @@ extern char *prefix_path_gently(const char *prefix, int len, int *remaining, con
  * not have to interact with index entry; i.e. name of a random file
  * on the filesystem.
  *
- * The return value may point to static storage which will be overwritten by
- * further calls.
+ * The return value is always a newly allocated string (even if the
+ * prefix was empty).
  */
-extern const char *prefix_filename(const char *prefix, const char *path);
+extern char *prefix_filename(const char *prefix, const char *path);
 
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix,
diff --git a/diff-no-index.c b/diff-no-index.c
index 5f7317ced..79229382b 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -266,7 +266,7 @@ void diff_no_index(struct rev_info *revs,
 			 */
 			p = file_from_standard_input;
 		else if (prefix)
-			p = xstrdup(prefix_filename(prefix, p));
+			p = prefix_filename(prefix, p);
 		paths[i] = p;
 	}
 
diff --git a/diff.c b/diff.c
index 70870b4b6..58cb72d7e 100644
--- a/diff.c
+++ b/diff.c
@@ -4023,8 +4023,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--pickaxe-regex"))
 		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
 	else if ((argcount = short_opt('O', av, &optarg))) {
-		const char *path = prefix_filename(prefix, optarg);
-		options->orderfile = xstrdup(path);
+		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
 	}
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
@@ -4071,13 +4070,14 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-function-context"))
 		DIFF_OPT_CLR(options, FUNCCONTEXT);
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
-		const char *path = prefix_filename(prefix, optarg);
+		char *path = prefix_filename(prefix, optarg);
 		options->file = fopen(path, "w");
 		if (!options->file)
 			die_errno("Could not open '%s'", path);
 		options->close_file = 1;
 		if (options->use_color != GIT_COLOR_ALWAYS)
 			options->use_color = GIT_COLOR_NEVER;
+		free(path);
 		return argcount;
 	} else
 		return 0;
diff --git a/parse-options.c b/parse-options.c
index ba6cc30b2..a23a1e67f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -40,7 +40,7 @@ static void fix_filename(const char *prefix, const char **file)
 	if (!file || !*file || !prefix || is_absolute_path(*file)
 	    || !strcmp("-", *file))
 		return;
-	*file = xstrdup(prefix_filename(prefix, *file));
+	*file = prefix_filename(prefix, *file);
 }
 
 static int opt_command_mode_error(const struct option *opt,
diff --git a/setup.c b/setup.c
index a76379e0c..5c7946d2b 100644
--- a/setup.c
+++ b/setup.c
@@ -135,6 +135,7 @@ int path_inside_repo(const char *prefix, const char *path)
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
+	char *to_free = NULL;
 	struct stat st;
 
 	if (starts_with(arg, ":/")) {
@@ -142,13 +143,17 @@ int check_filename(const char *prefix, const char *arg)
 			return 1;
 		name = arg + 2;
 	} else if (prefix)
-		name = prefix_filename(prefix, arg);
+		name = to_free = prefix_filename(prefix, arg);
 	else
 		name = arg;
-	if (!lstat(name, &st))
+	if (!lstat(name, &st)) {
+		free(to_free);
 		return 1; /* file exists */
-	if (errno == ENOENT || errno == ENOTDIR)
+	}
+	if (errno == ENOENT || errno == ENOTDIR) {
+		free(to_free);
 		return 0; /* file does not exist */
+	}
 	die_errno("failed to stat '%s'", arg);
 }
 
diff --git a/worktree.c b/worktree.c
index 42dd3d52b..2520fc65c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -250,16 +250,19 @@ struct worktree *find_worktree(struct worktree **list,
 {
 	struct worktree *wt;
 	char *path;
+	char *to_free;
 
 	if ((wt = find_worktree_by_suffix(list, arg)))
 		return wt;
 
-	arg = prefix_filename(prefix, arg);
+	if (prefix)
+		arg = to_free = prefix_filename(prefix, arg);
 	path = real_pathdup(arg, 1);
 	for (; *list; list++)
 		if (!fspathcmp(path, real_path((*list)->path)))
 			break;
 	free(path);
+	free(to_free);
 	return *list;
 }
 
-- 
2.12.1.683.gcd02edfec

