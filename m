From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/10] update-index: migrate to parse-options API
Date: Wed, 1 Dec 2010 17:34:06 -0600
Message-ID: <20101201233406.GK31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:34:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNwCA-0003AZ-Dd
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756703Ab0LAXeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:34:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51333 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756572Ab0LAXeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:34:16 -0500
Received: by vws16 with SMTP id 16so761312vws.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=FKgQp0w3iNttyQf8CmkqymL6jCcSgUc8q2mu6hi8nGA=;
        b=j6V28vtGQiB/C1O39jqS6dEr0pv2f5ctYpodvJzTl+fMQh2IENj2ccSeTKdwmMU8rj
         JmDo2zl+9uHrn8AFr/+9Nvlw3WwrgZInFNfJzWr6+Alsa2Uq4T6WZrAH5UqiLpz+TsVy
         l+Ac/nEDFwyf+Oolu7zwRLHM0icagYphwt0iU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=m69n+pMVWks3Lg2O0g/AME4F0uvo0cuoEOXR+ELKM+jX5WsUjmtnmxM8cWxHWjHwhK
         EBlV2PbYQQ0HaZOGqFGgfhwKG8IINpMZEc1UavoCcMqai5Ebq78KayWn5YFROdq2nmhq
         Px6A5/PEn9jvpM4YBtT5uuvFQKE5Wp4pRp418=
Received: by 10.220.193.11 with SMTP id ds11mr2490719vcb.209.1291246455068;
        Wed, 01 Dec 2010 15:34:15 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id i2sm156221vcs.33.2010.12.01.15.34.12
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:34:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162648>

--refresh and --really-refresh accept flags (like -q) and modify
an error indicator.  It might make sense to make the error
indicator global, but just pass the flags and a pointer to the error
indicator in a struct instead.

--cacheinfo wants 3 arguments.  Use the OPTION_LOWLEVEL_CALLBACK
extension to grab them and PARSE_OPT_NOARG to disallow the "sticked"
--cacheinfo=foo form.  (The resulting message

	$ git update-index --cacheinfo=foo
	error: option `cacheinfo' takes no value

is unfortunately incorrect.)

--assume-unchanged and --no-assume-unchanged probably should use the
OPT_UYN feature; but use a callback for now so the existing MARK_FLAG
and UNMARK_FLAG values can be used.

--stdin and --index-info are still constrained to be the last argument
(implemented using the OPTION_LOWLEVEL_CALLBACK extension).

--unresolve and --again consume all arguments that come after them
(also using OPTION_LOWLEVEL_CALLBACK).

The order of options matters.  Each path on the command line is
affected only by the options that come before it.  A custom
argument-parsing loop with parse_options_step() brings that about.

In exchange for all the fuss, we get the usual perks: support for
un-sticked options, better usage error messages, more useful -h
output, and argument parsing code that should be easier to tweak
in the future.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/update-index.c |  392 ++++++++++++++++++++++++++++++------------------
 1 files changed, 243 insertions(+), 149 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 62d9f3f..869f5b1 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "refs.h"
 #include "resolve-undo.h"
+#include "parse-options.h"
 
 /*
  * Default to not allowing changes to the list of files. The
@@ -397,8 +398,10 @@ static void read_index_info(int line_termination)
 	strbuf_release(&uq);
 }
 
-static const char update_index_usage[] =
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] [<file>...]";
+static const char * const update_index_usage[] = {
+	"git update-index [options] [--] [<file>...]",
+	NULL
+};
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -578,16 +581,211 @@ static int do_reupdate(int ac, const char **av,
 	return 0;
 }
 
+struct refresh_params {
+	unsigned int flags;
+	int *has_errors;
+};
+
+static int refresh(struct refresh_params *o, unsigned int flag)
+{
+	setup_work_tree();
+	*o->has_errors |= refresh_cache(o->flags | flag);
+	return 0;
+}
+
+static int refresh_callback(const struct option *opt,
+				const char *arg, int unset)
+{
+	return refresh(opt->value, 0);
+}
+
+static int really_refresh_callback(const struct option *opt,
+				const char *arg, int unset)
+{
+	return refresh(opt->value, REFRESH_REALLY);
+}
+
+static int chmod_callback(const struct option *opt,
+				const char *arg, int unset)
+{
+	char *flip = opt->value;
+	if ((arg[0] != '-' && arg[0] != '+') || arg[1] != 'x' || arg[2])
+		return error("option 'chmod' expects \"+x\" or \"-x\"");
+	*flip = arg[0];
+	return 0;
+}
+
+static int resolve_undo_clear_callback(const struct option *opt,
+				const char *arg, int unset)
+{
+	resolve_undo_clear();
+	return 0;
+}
+
+static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
+				const struct option *opt, int unset)
+{
+	unsigned char sha1[20];
+	unsigned int mode;
+
+	if (ctx->argc <= 3)
+		return error("option 'cacheinfo' expects three arguments");
+	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
+	    get_sha1_hex(*++ctx->argv, sha1) ||
+	    add_cacheinfo(mode, sha1, *++ctx->argv, 0))
+		die("git update-index: --cacheinfo cannot add %s", *ctx->argv);
+	ctx->argc -= 3;
+	return 0;
+}
+
+static int stdin_cacheinfo_callback(struct parse_opt_ctx_t *ctx,
+			      const struct option *opt, int unset)
+{
+	int *line_termination = opt->value;
+
+	if (ctx->argc != 1)
+		return error("option '%s' must be the last argument", opt->long_name);
+	allow_add = allow_replace = allow_remove = 1;
+	read_index_info(*line_termination);
+	return 0;
+}
+
+static int stdin_callback(struct parse_opt_ctx_t *ctx,
+				const struct option *opt, int unset)
+{
+	int *read_from_stdin = opt->value;
+
+	if (ctx->argc != 1)
+		return error("option '%s' must be the last argument", opt->long_name);
+	*read_from_stdin = 1;
+	return 0;
+}
+
+static int unresolve_callback(struct parse_opt_ctx_t *ctx,
+				const struct option *opt, int flags)
+{
+	int *has_errors = opt->value;
+	const char *prefix = startup_info->prefix;
+
+	/* consume remaining arguments. */
+	*has_errors = do_unresolve(ctx->argc, ctx->argv,
+				prefix, prefix ? strlen(prefix) : 0);
+	if (*has_errors)
+		active_cache_changed = 0;
+
+	ctx->argv += ctx->argc - 1;
+	ctx->argc = 1;
+	return 0;
+}
+
+static int reupdate_callback(struct parse_opt_ctx_t *ctx,
+				const struct option *opt, int flags)
+{
+	int *has_errors = opt->value;
+	const char *prefix = startup_info->prefix;
+
+	/* consume remaining arguments. */
+	setup_work_tree();
+	*has_errors = do_reupdate(ctx->argc, ctx->argv,
+				prefix, prefix ? strlen(prefix) : 0);
+	if (*has_errors)
+		active_cache_changed = 0;
+
+	ctx->argv += ctx->argc - 1;
+	ctx->argc = 1;
+	return 0;
+}
+
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
-	int i, newfd, entries, has_errors = 0, line_termination = '\n';
-	int allow_options = 1;
+	int newfd, entries, has_errors = 0, line_termination = '\n';
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	char set_executable_bit = 0;
-	unsigned int refresh_flags = 0;
+	struct refresh_params refresh_args = {0, &has_errors};
 	int lock_error = 0;
 	struct lock_file *lock_file;
+	struct parse_opt_ctx_t ctx;
+	int parseopt_state = PARSE_OPT_UNKNOWN;
+	struct option options[] = {
+		OPT_BIT('q', NULL, &refresh_args.flags,
+			"continue refresh even when index needs update",
+			REFRESH_QUIET),
+		OPT_BIT(0, "ignore-submodules", &refresh_args.flags,
+			"refresh: ignore submodules",
+			REFRESH_IGNORE_SUBMODULES),
+		OPT_SET_INT(0, "add", &allow_add,
+			"do not ignore new files", 1),
+		OPT_SET_INT(0, "replace", &allow_replace,
+			"let files replace directories and vice-versa", 1),
+		OPT_SET_INT(0, "remove", &allow_remove,
+			"notice files missing from worktree", 1),
+		OPT_BIT(0, "unmerged", &refresh_args.flags,
+			"refresh even if index contains unmerged entries",
+			REFRESH_UNMERGED),
+		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
+			"refresh stat information",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			refresh_callback},
+		{OPTION_CALLBACK, 0, "really-refresh", &refresh_args, NULL,
+			"like --refresh, but ignore assume-unchanged setting",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			really_refresh_callback},
+		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
+			"<mode> <object> <path>",
+			"add the specified entry to the index",
+			PARSE_OPT_NOARG |	/* disallow --cacheinfo=<mode> form */
+			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+			(parse_opt_cb *) cacheinfo_callback},
+		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+/-)x",
+			"override the executable bit of the listed files",
+			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
+			chmod_callback},
+		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
+			"mark files as \"not changing\"",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
+		{OPTION_SET_INT, 0, "no-assume-unchanged", &mark_valid_only, NULL,
+			"clear assumed-unchanged bit",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		{OPTION_SET_INT, 0, "skip-worktree", &mark_skip_worktree_only, NULL,
+			"mark files as \"index-only\"",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
+		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, NULL,
+			"clear skip-worktree bit",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
+		OPT_SET_INT(0, "info-only", &info_only,
+			"add to index only; do not add content to object database", 1),
+		OPT_SET_INT(0, "force-remove", &force_remove,
+			"remove named paths even if present in worktree", 1),
+		OPT_SET_INT('z', NULL, &line_termination,
+			"with --stdin: input lines are terminated by null bytes", '\0'),
+		{OPTION_LOWLEVEL_CALLBACK, 0, "stdin", &read_from_stdin, NULL,
+			"read list of paths to be updated from standard input",
+			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			(parse_opt_cb *) stdin_callback},
+		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &line_termination, NULL,
+			"add entries from standard input to the index",
+			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			(parse_opt_cb *) stdin_cacheinfo_callback},
+		{OPTION_LOWLEVEL_CALLBACK, 0, "unresolve", &has_errors, NULL,
+			"repopulate stages #2 and #3 for the listed paths",
+			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			(parse_opt_cb *) unresolve_callback},
+		{OPTION_LOWLEVEL_CALLBACK, 'g', "again", &has_errors, NULL,
+			"only update entries that differ from HEAD",
+			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			(parse_opt_cb *) reupdate_callback},
+		OPT_BIT(0, "ignore-missing", &refresh_args.flags,
+			"ignore files missing from worktree",
+			REFRESH_IGNORE_MISSING),
+		OPT_SET_INT(0, "verbose", &verbose,
+			"report actions to standard output", 1),
+		{OPTION_CALLBACK, 0, "clear-resolve-undo", NULL, NULL,
+			"(for porcelains) forget saved unresolved conflicts",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			resolve_undo_clear_callback},
+		OPT_END()
+	};
 
 	git_config(git_default_config, NULL);
 
@@ -602,151 +800,48 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
 
-	for (i = 1 ; i < argc; i++) {
-		const char *path = argv[i];
-		const char *p;
+	/*
+	 * Custom copy of parse_options() because we want to handle
+	 * filename arguments as they come.
+	 */
+	parse_options_start(&ctx, argc, argv, prefix,
+			    PARSE_OPT_STOP_AT_NON_OPTION, options);
+	while (ctx.argc) {
+		if (parseopt_state != PARSE_OPT_DONE)
+			parseopt_state = parse_options_step(&ctx, options,
+							    update_index_usage);
+		if (!ctx.argc)
+			break;
+		switch (parseopt_state) {
+		case PARSE_OPT_HELP:
+			exit(129);
+		case PARSE_OPT_NON_OPTION:
+		case PARSE_OPT_DONE:
+		{
+			const char *path = ctx.argv[0];
+			const char *p;
 
-		if (allow_options && *path == '-') {
-			if (!strcmp(path, "--")) {
-				allow_options = 0;
-				continue;
-			}
-			if (!strcmp(path, "-q")) {
-				refresh_flags |= REFRESH_QUIET;
-				continue;
-			}
-			if (!strcmp(path, "--ignore-submodules")) {
-				refresh_flags |= REFRESH_IGNORE_SUBMODULES;
-				continue;
-			}
-			if (!strcmp(path, "--add")) {
-				allow_add = 1;
-				continue;
-			}
-			if (!strcmp(path, "--replace")) {
-				allow_replace = 1;
-				continue;
-			}
-			if (!strcmp(path, "--remove")) {
-				allow_remove = 1;
-				continue;
-			}
-			if (!strcmp(path, "--unmerged")) {
-				refresh_flags |= REFRESH_UNMERGED;
-				continue;
-			}
-			if (!strcmp(path, "--refresh")) {
-				setup_work_tree();
-				has_errors |= refresh_cache(refresh_flags);
-				continue;
-			}
-			if (!strcmp(path, "--really-refresh")) {
-				setup_work_tree();
-				has_errors |= refresh_cache(REFRESH_REALLY | refresh_flags);
-				continue;
-			}
-			if (!strcmp(path, "--cacheinfo")) {
-				unsigned char sha1[20];
-				unsigned int mode;
-
-				if (i+3 >= argc)
-					die("git update-index: --cacheinfo <mode> <sha1> <path>");
-
-				if (strtoul_ui(argv[i+1], 8, &mode) ||
-				    get_sha1_hex(argv[i+2], sha1) ||
-				    add_cacheinfo(mode, sha1, argv[i+3], 0))
-					die("git update-index: --cacheinfo"
-					    " cannot add %s", argv[i+3]);
-				i += 3;
-				continue;
-			}
-			if (!strcmp(path, "--chmod=-x") ||
-			    !strcmp(path, "--chmod=+x")) {
-				if (argc <= i+1)
-					die("git update-index: %s <path>", path);
-				set_executable_bit = path[8];
-				continue;
-			}
-			if (!strcmp(path, "--assume-unchanged")) {
-				mark_valid_only = MARK_FLAG;
-				continue;
-			}
-			if (!strcmp(path, "--no-assume-unchanged")) {
-				mark_valid_only = UNMARK_FLAG;
-				continue;
-			}
-			if (!strcmp(path, "--no-skip-worktree")) {
-				mark_skip_worktree_only = UNMARK_FLAG;
-				continue;
-			}
-			if (!strcmp(path, "--skip-worktree")) {
-				mark_skip_worktree_only = MARK_FLAG;
-				continue;
-			}
-			if (!strcmp(path, "--info-only")) {
-				info_only = 1;
-				continue;
-			}
-			if (!strcmp(path, "--force-remove")) {
-				force_remove = 1;
-				continue;
-			}
-			if (!strcmp(path, "-z")) {
-				line_termination = 0;
-				continue;
-			}
-			if (!strcmp(path, "--stdin")) {
-				if (i != argc - 1)
-					die("--stdin must be at the end");
-				read_from_stdin = 1;
-				break;
-			}
-			if (!strcmp(path, "--index-info")) {
-				if (i != argc - 1)
-					die("--index-info must be at the end");
-				allow_add = allow_replace = allow_remove = 1;
-				read_index_info(line_termination);
-				break;
-			}
-			if (!strcmp(path, "--unresolve")) {
-				has_errors = do_unresolve(argc - i, argv + i,
-							  prefix, prefix_length);
-				if (has_errors)
-					active_cache_changed = 0;
-				goto finish;
-			}
-			if (!strcmp(path, "--again") || !strcmp(path, "-g")) {
-				setup_work_tree();
-				has_errors = do_reupdate(argc - i, argv + i,
-							 prefix, prefix_length);
-				if (has_errors)
-					active_cache_changed = 0;
-				goto finish;
-			}
-			if (!strcmp(path, "--ignore-missing")) {
-				refresh_flags |= REFRESH_IGNORE_MISSING;
-				continue;
-			}
-			if (!strcmp(path, "--verbose")) {
-				verbose = 1;
-				continue;
-			}
-			if (!strcmp(path, "--clear-resolve-undo")) {
-				resolve_undo_clear();
-				continue;
-			}
-			if (!strcmp(path, "-h") || !strcmp(path, "--help"))
-				usage(update_index_usage);
-			die("unknown option %s", path);
+			setup_work_tree();
+			p = prefix_path(prefix, prefix_length, path);
+			update_one(p, NULL, 0);
+			if (set_executable_bit)
+				chmod_path(set_executable_bit, p);
+			if (p < path || p > path + strlen(path))
+				free((char *)p);
+			ctx.argc--;
+			ctx.argv++;
+			break;
+		}
+		case PARSE_OPT_UNKNOWN:
+			if (ctx.argv[0][1] == '-')
+				error("unknown option '%s'", ctx.argv[0] + 2);
+			else
+				error("unknown switch '%c'", *ctx.opt);
+			usage_with_options(update_index_usage, options);
 		}
-		setup_work_tree();
-		p = prefix_path(prefix, prefix_length, path);
-		update_one(p, NULL, 0);
-		if (set_executable_bit)
-			chmod_path(set_executable_bit, p);
-		if (p < path || p > path + strlen(path))
-			free((char *)p);
 	}
+	argc = parse_options_end(&ctx);
+
 	if (read_from_stdin) {
 		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
@@ -770,10 +865,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
- finish:
 	if (active_cache_changed) {
 		if (newfd < 0) {
-			if (refresh_flags & REFRESH_QUIET)
+			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
 			unable_to_lock_index_die(get_index_file(), lock_error);
 		}
-- 
1.7.2.3
