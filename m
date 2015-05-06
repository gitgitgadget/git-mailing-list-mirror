From: Stephen Robin <stephen.robin@gmail.com>
Subject: [PATCH 4/6] pull: reimplement as a builtin in C
Date: Wed,  6 May 2015 01:00:51 +0100
Message-ID: <1430870453-5408-5-git-send-email-stephen.robin@gmail.com>
References: <CACRoPnQ5_r-26J4gBHc27KZt3X9KAU7eFkA3vz_GE6_dP-Uyug@mail.gmail.com>
 <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Cc: git@vger.kernel.org
To: pyokagan@gmail.com
X-From: git-owner@vger.kernel.org Wed May 06 02:01:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypmm5-0004e4-T9
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 02:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082AbbEFABM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 20:01:12 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36120 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbbEFAAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 20:00:54 -0400
Received: by wizk4 with SMTP id k4so181820402wiz.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JZO0nJZzop9c9TkZobq1aohqxD4D1t8rVbnsSzDJP2c=;
        b=BqHiFgzCqgnBm0kYqwwuo4LMI1Cnybq0DuX74yCaCAAkK7nz7alfeNYfSkDTMFLrCw
         A8sj7WLMswzQ0BuW0oFGcfX6KAPE/4JtdayEsXMW2nOptJ8wbrDHLX1p4UxxFDNZ+dgz
         Veji1Z5Vr65f+tUW/ygOyHa3lsYkFvW7Ip+09oPuRMd52VTHb7IlTzkufXgg9KV1+TgP
         HXIfcSYqNJhJ7o2LbB6ksY86FURfL2l/GJoJc6btBIM9tfHZerlOWK/Wuc5uJd4Pcou+
         bWHMDSXiFk1iVv69LOTnucSQ+xF0J1jRNRlT/0bNqH2V3b7tz4QyFksQjMKjSK0nxcYu
         OIvQ==
X-Received: by 10.194.237.34 with SMTP id uz2mr55223394wjc.157.1430870453160;
        Tue, 05 May 2015 17:00:53 -0700 (PDT)
Received: from localhost ([141.0.152.225])
        by mx.google.com with ESMTPSA id bg4sm43004wjc.10.2015.05.05.17.00.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 May 2015 17:00:52 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.7.gf20f26f
In-Reply-To: <1430870453-5408-1-git-send-email-stephen.robin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268439>

THIS PATCH SERIES IS NOT CODE-COMPLETE OR FULLY TESTED.
See code comments beginning TODO for work remaining.

Known differences between builtin/pull.c and git-pull.sh:
 - The output of git pull -h and git pull --help-all has changed.  It is
   now more comprehensive and consistent with other builtins.
 - The error message given when dying due to unmerged changes in the
   working tree has changed.  In git-pull.sh it would list all unmerged
   files.  In builtin/pull.c it is consistent with git merge and will not
   list file status.
 - --s and --st can no longer be used as a shorthand for --strategy.
   They would be ambiguous with --stat.

Signed-off-by: Stephen Robin <stephen.robin@gmail.com>
---
 .gitignore                   |   1 -
 Makefile                     |   2 +-
 builtin.h                    |   1 +
 builtin/pull.c               | 993 +++++++++++++++++++++++++++++++++++++++++++
 contrib/examples/git-pull.sh | 340 +++++++++++++++
 git-pull.sh                  | 340 ---------------
 git.c                        |   1 +
 7 files changed, 1336 insertions(+), 342 deletions(-)
 create mode 100644 builtin/pull.c
 create mode 100755 contrib/examples/git-pull.sh
 delete mode 100755 git-pull.sh

diff --git a/.gitignore b/.gitignore
index a052419..6287647 100644
--- a/.gitignore
+++ b/.gitignore
@@ -108,7 +108,6 @@
 /git-patch-id
 /git-prune
 /git-prune-packed
-/git-pull
 /git-push
 /git-quiltimport
 /git-read-tree
diff --git a/Makefile b/Makefile
index 5f3987f..8d8fb3a 100644
--- a/Makefile
+++ b/Makefile
@@ -472,7 +472,6 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
@@ -874,6 +873,7 @@ BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
 BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
+BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
diff --git a/builtin.h b/builtin.h
index d8e0e5a..b2d7daa 100644
--- a/builtin.h
+++ b/builtin.h
@@ -100,6 +100,7 @@ extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
+extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/pull.c b/builtin/pull.c
new file mode 100644
index 0000000..f420b4a
--- /dev/null
+++ b/builtin/pull.c
@@ -0,0 +1,993 @@
+/*
+ * Copyright (c) 2015 Stephen Robin <stephen.robin@gmail.com>
+ *
+ * Based on git-pull.sh by Junio C Hamano
+ */
+
+#include "builtin.h"
+#include "parse-options.h"
+#include "submodule.h"
+#include "dir.h"
+#include "run-command.h"
+#include "argv-array.h"
+#include "fmt-merge-msg.h"
+#include "refs.h"
+#include "revision.h"
+#include "remote.h"
+
+enum ff_type {
+	FF_NOT_SET = -1,
+	FF_NO,
+	FF_ALLOW,
+	FF_ONLY
+};
+
+enum pull_mode {
+	PULL_NOT_SET = -1,
+	PULL_MERGE,
+	PULL_REBASE,
+	PULL_PRESERVE_MERGES_REBASE
+};
+
+static const char * const builtin_pull_usage[] = {
+	N_("git pull [<options>] [<fetch-options>] [<repository> [<refspec>...]]"),
+	NULL
+};
+
+static enum pull_mode pull_mode_from_args = PULL_NOT_SET;
+static enum pull_mode pull_mode_from_branch_config = PULL_NOT_SET;
+static enum pull_mode pull_mode_from_config = PULL_NOT_SET;
+
+static enum ff_type ff_type_from_args = FF_NOT_SET;
+static enum ff_type ff_type_from_config = FF_NOT_SET;
+
+/*
+ * These are passed to the underlying fetch / merge / rebase commands but not
+ * used to make decisions within pull itself.
+ *  1  command line includes --option
+ *  0  command line includes --no-option
+ *  -1 neither is on command line
+ */
+static int progress = -1;
+static int show_diffstat = -1;
+static int shortlog_len = -1;
+static int squash = -1;
+static int option_commit = -1;
+static int option_edit = -1;
+static int verify_signatures = -1;
+
+static int dryrun;
+static int verbosity;
+static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+
+static const char **use_strategies;
+static size_t use_strategies_nr, use_strategies_alloc;
+
+static const char **xopts;
+static size_t xopts_nr, xopts_alloc;
+
+static const char *option_gpg_sign;
+
+static const char *curr_branch, *curr_branch_short;
+
+static int parse_pull_mode(const char *name, const char* arg,
+	enum pull_mode *option_rebase)
+{
+	int arg_as_bool = git_config_maybe_bool(name, arg);
+
+	if (arg_as_bool == 0) {
+		*option_rebase = PULL_MERGE;
+		return 0;
+	}
+
+	if (arg_as_bool == 1) {
+		*option_rebase = PULL_REBASE;
+		return 0;
+	}
+
+	if (!strcmp(arg, "preserve")) {
+		*option_rebase = PULL_PRESERVE_MERGES_REBASE;
+		return 0;
+	}
+
+	error(_("Invalid value for %s, should be 'true', 'false' or 'preserve'."), name);
+	return -1;
+}
+
+static int parse_ff_type(const char *name, const char* arg,
+	enum ff_type *fast_forward)
+{
+	int arg_as_bool = git_config_maybe_bool(name, arg);
+
+	if (arg_as_bool == 0) {
+		*fast_forward = FF_NO;
+		return 0;
+	}
+
+	if (arg_as_bool == 1) {
+		*fast_forward = FF_ALLOW;
+		return 0;
+	}
+
+	if (!strcmp(arg, "only")) {
+		*fast_forward = FF_ONLY;
+		return 0;
+	}
+
+	error(_("Invalid value for %s, should be 'true', 'false', or 'only'."), name);
+	return -1;
+}
+
+static int git_pull_config(const char *key, const char *value, void *cb)
+{
+	if (curr_branch_short &&
+		starts_with(key, "branch.") &&
+		starts_with(key + 7, curr_branch_short) &&
+		!strcmp(key + 7 + strlen(curr_branch_short), ".rebase"))
+		return parse_pull_mode(key, value, &pull_mode_from_branch_config);
+
+	if (!strcmp(key, "pull.rebase"))
+		return parse_pull_mode(key, value, &pull_mode_from_config);
+
+	if (!strcmp(key, "pull.ff"))
+		return parse_ff_type(key, value, &ff_type_from_config);
+
+	return fmt_merge_msg_config(key, value, cb);
+}
+
+static int option_parse_n(const struct option *opt,
+	const char *arg, int unset)
+{
+	show_diffstat = unset;
+	return 0;
+}
+
+static int option_parse_recurse_submodules(const struct option *opt,
+	const char *arg, int unset)
+{
+	if (unset)
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+	else if (arg)
+		recurse_submodules = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
+	else
+		recurse_submodules = RECURSE_SUBMODULES_ON;
+
+	return 0;
+}
+
+static int option_parse_rebase(const struct option *opt,
+	const char *arg, int unset)
+{
+	if (unset) {
+		pull_mode_from_args = PULL_MERGE;
+		return 0;
+	}
+
+	if (!arg) {
+		pull_mode_from_args = PULL_REBASE;
+		return 0;
+	}
+
+	if (!parse_pull_mode(opt->long_name, arg, &pull_mode_from_args))
+		return 0;
+
+	return -1;
+}
+
+static int option_parse_strategy(const struct option *opt,
+	const char *arg, int unset)
+{
+	if (unset)
+		return 0;
+
+	ALLOC_GROW(use_strategies, use_strategies_nr + 1, use_strategies_alloc);
+	use_strategies[use_strategies_nr++] = xstrdup(arg);
+	return 0;
+}
+
+static int option_parse_x(const struct option *opt,
+	const char *arg, int unset)
+{
+	if (unset)
+		return 0;
+
+	ALLOC_GROW(xopts, xopts_nr + 1, xopts_alloc);
+	xopts[xopts_nr++] = xstrdup(arg);
+	return 0;
+}
+
+static struct option builtin_pull_options[] = {
+	{ OPTION_CALLBACK, 0, "rebase", NULL, N_("true|false|preserve"),
+		N_("incorporate changes by rebasing rather than merging"),
+		PARSE_OPT_OPTARG, option_parse_rebase },
+	OPT_BOOL(0, "progress", &progress,
+		N_("force progress reporting")),
+	OPT__VERBOSITY(&verbosity),
+	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
+		N_("control recursive fetching of submodules"),
+	PARSE_OPT_OPTARG, option_parse_recurse_submodules },
+	/* We can't use OPT__DRY_RUN as it uses 'n' as the short form, which we use as the short form of stat. */
+	OPT_BOOL(0, "dry-run", &dryrun, N_("dry run")),
+	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
+		N_("do not show a diffstat at the end of the merge"),
+		PARSE_OPT_NOARG, option_parse_n },
+	OPT_BOOL(0, "stat", &show_diffstat,
+		N_("show a diffstat at the end of the merge")),
+	OPT_HIDDEN_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
+	{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
+		N_("add (at most <n>) entries from shortlog to merge commit message"),
+		PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
+	OPT_BOOL(0, "squash", &squash,
+		N_("create a single commit instead of doing a merge")),
+	OPT_BOOL(0, "commit", &option_commit,
+		N_("perform a commit if the merge succeeds (default)")),
+	OPT_BOOL('e', "edit", &option_edit,
+		N_("edit message before committing")),
+	OPT_SET_INT(0, "ff", &ff_type_from_args,
+		N_("allow fast-forward (default)"), FF_ALLOW),
+	{ OPTION_SET_INT, 0, "ff-only", &ff_type_from_args, NULL,
+		N_("abort if fast-forward is not possible"),
+		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
+	OPT_BOOL(0, "verify-signatures", &verify_signatures,
+		N_("verify that the named commit has a valid GPG signature")),
+	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
+		N_("merge strategy to use"), option_parse_strategy),
+	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=value"),
+		N_("option for selected merge strategy"), option_parse_x),
+	{ OPTION_STRING, 'S', "gpg-sign", &option_gpg_sign, N_("key-id"),
+		N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+	OPT_END()
+};
+
+static enum pull_mode get_pull_mode()
+{
+	/* use --[no-]rebase[=preserve] from the command line, if specified. */
+	if (pull_mode_from_args != PULL_NOT_SET)
+		return pull_mode_from_args;
+
+	/* otherwise use branch.<name>.rebase from config, if set. */
+	if (pull_mode_from_branch_config != PULL_NOT_SET)
+		return pull_mode_from_branch_config;
+
+	/* otherwise use pull.rebase from config, if set. */
+	if (pull_mode_from_config != PULL_NOT_SET)
+		return pull_mode_from_config;
+
+	/* use merge by default. */
+	return PULL_MERGE;
+}
+
+static enum ff_type get_ff_type()
+{
+	if (ff_type_from_args != FF_NOT_SET)
+		return ff_type_from_args;
+
+	if (ff_type_from_config != FF_NOT_SET)
+		return ff_type_from_config;
+
+	return FF_ALLOW;
+}
+
+static char *get_merge_msg()
+{
+	const char *inpath = NULL;
+	FILE *in;
+	struct strbuf input = STRBUF_INIT, output = STRBUF_INIT;
+	struct fmt_merge_msg_opts opts;
+
+	inpath = git_path("FETCH_HEAD");
+	in = fopen(inpath, "r");
+	if (!in)
+		die_errno("cannot open '%s'", inpath);
+
+	if (strbuf_read(&input, fileno(in), 0) < 0)
+		die_errno("could not read '%s'", inpath);
+
+	fclose(in);
+
+	memset(&opts, 0, sizeof(opts));
+	opts.add_title = 1;
+	opts.credit_people = 1;
+	opts.shortlog_len = shortlog_len;
+
+	fmt_merge_msg(&input, &output, &opts);
+
+	strbuf_release(&input);
+
+	return strbuf_detach(&output, NULL);
+}
+
+static const struct string_list get_merge_head()
+{
+	/*
+	 * Read FETCH_HEAD line by line
+	 * ... exclude lines containing \tnot-for-merge\t
+	 * ... exclude everything after the first tab in remaining lines
+	 * ... result is a list of sha1s to be merged.
+	 */
+
+	const char *filename;
+	FILE *fp;
+	struct strbuf line = STRBUF_INIT;
+	struct string_list merge_head = STRING_LIST_INIT_DUP;
+	char *ptr;
+
+	filename = git_path("FETCH_HEAD");
+	fp = fopen(filename, "r");
+	if (!fp)
+		die_errno(_("could not open '%s' for reading"), filename);
+
+	while (strbuf_getline(&line, fp, '\n') != EOF) {
+
+		ptr = strstr(line.buf, "\tnot-for-merge\t");
+		if (!ptr) {
+			ptr = strchr(line.buf, '\t');
+			if (ptr) {
+				strbuf_setlen(&line, ptr - line.buf);
+				string_list_append(&merge_head, line.buf);
+			}
+		}
+
+		strbuf_reset(&line);
+	}
+
+	fclose(fp);
+	strbuf_release(&line);
+
+	return merge_head;
+}
+
+static int run_fetch(const int additional_argc, const char **additional_argv)
+{
+	int v, q, idx, result;
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
+	argv_array_push(&argv, "fetch");
+
+	for (v = verbosity; v > 0; v--)
+		argv_array_push(&argv, "-v");
+
+	for (q = verbosity; q < 0; q++)
+		argv_array_push(&argv, "-q");
+
+	if (progress == 1)
+		argv_array_push(&argv, "--progress");
+	else if (progress == 0)
+		argv_array_push(&argv, "--no-progress");
+
+	if (dryrun)
+		argv_array_push(&argv, "--dry-run");
+
+	if (recurse_submodules == RECURSE_SUBMODULES_ON)
+		argv_array_push(&argv, "--recurse-submodules");
+	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
+		argv_array_push(&argv, "--recurse-submodules=on-demand");
+	else if (recurse_submodules == RECURSE_SUBMODULES_OFF)
+		argv_array_push(&argv, "--no-recurse-submodules");
+
+	argv_array_push(&argv, "--update-head-ok");
+
+	for (idx = 0; idx < additional_argc; idx++)
+		argv_array_push(&argv, additional_argv[idx]);
+
+	result = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+
+	argv_array_clear(&argv);
+
+	return result;
+}
+
+static int run_merge(const struct string_list merge_head)
+{
+	int v, q, idx, result;
+	struct argv_array argv = ARGV_ARRAY_INIT;
+	const char *merge_msg;
+	enum ff_type fast_forward_type;
+
+	merge_msg = get_merge_msg();
+	fast_forward_type = get_ff_type();
+
+
+	argv_array_push(&argv, "merge");
+
+	if (show_diffstat == 1)
+		argv_array_push(&argv, "--stat");
+	else if (show_diffstat == 0)
+		argv_array_push(&argv, "--no-stat");
+
+	if (option_commit == 1)
+		argv_array_push(&argv, "--commit");
+	else if (option_commit == 0)
+		argv_array_push(&argv, "--no-commit");
+
+	if (verify_signatures == 1)
+		argv_array_push(&argv, "--verify-signatures");
+	else if (verify_signatures == 0)
+		argv_array_push(&argv, "--no-verify-signatures");
+
+	if (option_edit == 1)
+		argv_array_push(&argv, "--edit");
+	else if (option_edit == 0)
+		argv_array_push(&argv, "--no-edit");
+
+	if (squash == 1)
+		argv_array_push(&argv, "--squash");
+	else if (squash == 0)
+		argv_array_push(&argv, "--no-squash");
+
+	if (fast_forward_type == FF_ALLOW)
+		argv_array_push(&argv, "--ff");
+	else if (fast_forward_type == FF_NO)
+		argv_array_push(&argv, "--no-ff");
+	else if (fast_forward_type == FF_ONLY)
+		argv_array_push(&argv, "--ff-only");
+
+	if (shortlog_len >= 0)
+		argv_array_pushf(&argv, "--log=%d", shortlog_len);
+
+	for (idx = 0; idx < use_strategies_nr; idx++)
+		argv_array_pushf(&argv, "--strategy=%s", use_strategies[idx]);
+
+	for (idx = 0; idx < xopts_nr; idx++)
+		argv_array_pushf(&argv, "-X%s", xopts[idx]);
+
+	for (v = verbosity; v > 0; v--)
+		argv_array_push(&argv, "-v");
+
+	for (q = verbosity; q < 0; q++)
+		argv_array_push(&argv, "-q");
+
+	if (progress == 1)
+		argv_array_push(&argv, "--progress");
+	else if (progress == 0)
+		argv_array_push(&argv, "--no-progress");
+
+	if (option_gpg_sign)
+		argv_array_pushf(&argv, "-S%s", option_gpg_sign);
+
+	argv_array_pushf(&argv, "\"%s\"", merge_msg);
+
+	argv_array_push(&argv, "HEAD");
+
+	for (idx = 0; idx < merge_head.nr; idx++)
+		argv_array_push(&argv, merge_head.items[idx].string);
+
+	result = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+
+	argv_array_clear(&argv);
+
+	return result;
+}
+
+static const char *run_show_branch(const char *merge_head,
+	const char *fork_point_for_rebase)
+{
+	/*
+	 * TODO Should be able to do the same thing without needing to fork another
+	 * git instance. It's just a simple search of the graph after all.
+	 */
+
+	int len;
+	struct child_process cp;
+	struct strbuf buffer = STRBUF_INIT;
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
+	argv_array_push(&argv, "show-branch");
+	argv_array_push(&argv, "--merge-base");
+
+	argv_array_push(&argv, curr_branch);
+	argv_array_push(&argv, merge_head);
+	argv_array_push(&argv, fork_point_for_rebase);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv.argv;
+	cp.out = -1;
+	cp.git_cmd = 1;
+
+	if (start_command(&cp))
+		die(_("could not run git show-branch."));
+	len = strbuf_read(&buffer, cp.out, 1024);
+	close(cp.out);
+
+	if (finish_command(&cp) || len < 0)
+		die(_("show-branch failed"));
+	else if (!len)
+		return NULL;
+
+	return strbuf_detach(&buffer, NULL);
+}
+
+static int run_rebase(const struct string_list merge_head, const char *fork_point,
+	const enum pull_mode pull_mode)
+{
+	int v, q, idx, result;
+	struct argv_array argv = ARGV_ARRAY_INIT;
+
+	if (merge_head.nr > 1)
+		die(_("Cannot rebase onto multiple branches"));
+
+	if (fork_point) {
+		const char *show_branch_result = run_show_branch(merge_head.items[0].string, fork_point);
+		if (!strcmp(fork_point, show_branch_result))
+			fork_point = NULL;
+	}
+
+	argv_array_push(&argv, "rebase");
+
+	if (show_diffstat == 1)
+		argv_array_push(&argv, "--stat");
+	else if (show_diffstat == 0)
+		argv_array_push(&argv, "--no-stat");
+
+	for (idx = 0; idx < use_strategies_nr; idx++)
+		argv_array_pushf(&argv, "--strategy=%s", use_strategies[idx]);
+
+	for (idx = 0; idx < xopts_nr; idx++)
+		argv_array_pushf(&argv, "-X%s", xopts[idx]);
+
+	if (pull_mode == PULL_PRESERVE_MERGES_REBASE)
+		argv_array_push(&argv, "--preserve-merges");
+
+	for (v = verbosity; v > 0; v--)
+		argv_array_push(&argv, "-v");
+
+	for (q = verbosity; q < 0; q++)
+		argv_array_push(&argv, "-q");
+
+	if (option_gpg_sign)
+		argv_array_pushf(&argv, "-S%s", option_gpg_sign);
+
+	argv_array_push(&argv, "--onto");
+	argv_array_push(&argv, merge_head.items[0].string);
+
+	if (fork_point)
+		argv_array_push(&argv, fork_point);
+	else
+		argv_array_push(&argv, merge_head.items[0].string);
+
+	result = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+
+	argv_array_clear(&argv);
+
+	return result;
+}
+
+static int get_remote_name(struct remote *remote, void *priv)
+{
+	struct string_list *list = priv;
+	string_list_append(list, remote->name);
+	return 0;
+}
+
+static void error_on_no_merge_candidates(enum pull_mode mode,
+	int argc, const char **argv)
+{
+	const char *op_type, *op_prep;
+	int idx;
+	struct branch *branch;
+
+	/*
+	 * TODO Existing bug in git-pull.sh, add another patch to the series to fix:
+	 * This function fails to take into account any arguments to be passed to
+	 * git fetch other than the remote and the refs.
+	 *
+	 * Set up a pair of test repos as follows:
+	 *   mkdir repo
+	 *   cd repo
+	 *   git init
+	 *   echo test > test
+	 *   git add test
+	 *   git commit -m "a commit"
+	 *   cd ..
+	 *   git clone repo cloned
+	 *   cd cloned
+	 *   git remote add nondefaultremote "../repo"
+	 *
+	 * Now compare the output of:
+	 *   git pull nondefaultremote
+	 *   git pull -p nondefaultremote
+	 *
+	 * The messages should be identical but aren't, the second is incorrect.
+	 */
+
+	for (idx = 0; idx < argc; idx++) {
+		if (!strcmp("-t", argv[idx]) || starts_with(argv[idx], "--t"))
+			die(_("It doesn't make sense to pull all tags; you probably meant:\n"
+			"git fetch --tags"));
+	}
+
+	branch = branch_get(curr_branch_short);
+
+	if (mode == PULL_MERGE) {
+		op_type = "merge";
+		/*
+		 * TRANSLATORS: This is the preposition associated with the merge
+		 * operation. In English it is used as "specify the branch you want to
+		 * merge _with_"
+		 */
+		op_prep = _("with");
+	} else {
+		op_type = "rebase";
+		/*
+		* TRANSLATORS: This is the preposition associated with the rebase
+		* operation. In English it is used as "specify the branch you want to
+		* rebase _against_"
+		*/
+		op_prep = _("against");
+	}
+
+	if (argc > 1) {
+		if (mode == PULL_MERGE)
+			die(_("There are no candidates for merging\n"
+			"among the refs that you just fetched.\n"
+			"Generally this means that you provided a wildcard refspec which had no\n"
+			"matches on the remote end."));
+		else
+			die(_("There is no candidate for rebasing against\n"
+			"among the refs that you just fetched.\n"
+			"Generally this means that you provided a wildcard refspec which had no\n"
+			"matches on the remote end.\n"));
+	} else if (argc > 0 && branch && branch->remote_name &&
+		strcmp(argv[0], branch->remote_name)) {
+		die(_("You asked to pull from the remote '%s', but did not specify\n"
+			"a branch. Because this is not the default configured remote\n"
+			"for your current branch, you must specify a branch on the command line."), argv[0]);
+	} else if (!curr_branch_short) {
+		/*
+		 * TRANSLATORS: first parameter is the operation (merge or rebase),
+		 * second is the preposition (with or against in English).
+		 */
+		die(_("You are not currently on a branch. Please specify which\n"
+			"branch you want to %s %s. See git help pull for details.\n\n"
+			"  git pull <remote> <branch>"), op_type, op_prep);
+	} else if (!branch || !branch->merge || !branch->merge[0] ||
+		!branch->merge[0]->dst || !branch->remote_name) {
+		/* If there's only one remote, use that in the suggestion */
+		struct string_list list = STRING_LIST_INIT_NODUP;
+		char *remote_name;
+
+		for_each_remote(get_remote_name, &list);
+
+		if (list.nr == 1)
+			remote_name = list.items[0].string;
+		else
+			remote_name = "<remote>";
+		/*
+		* TRANSLATORS: first parameter is the operation (merge or rebase),
+		* second is the preposition (with or against in English).
+		*/
+		die(_("There is no tracking information for the current branch.\n"
+			"Please specify which branch you want to %s %s.\n"
+			"See git help pull for details\n\n"
+			"  git pull <remote> <branch>\n\n"
+			"If you wish to set tracking information for this branch you can do so with:\n\n"
+			"  git branch --set-upstream-to=%s/<branch> %s"),
+			op_type, op_prep, remote_name, curr_branch_short);
+	} else {
+		const char *upstream_short = strncmp(branch->merge[0]->dst, "refs/heads/", 11)
+			? branch->merge[0]->dst : branch->merge[0]->dst + 11;
+		/*
+		* TRANSLATORS: first parameter is the operation (merge or rebase),
+		* second is the preposition (with or against in English).
+		*/
+		die(_("Your configuration specifies to %s %s the ref '%s'\n"
+			"from the remote, but no such ref was fetched."),
+			op_type, op_prep, upstream_short);
+	}
+}
+
+static const char *get_remote_merge_branch(int argc, const char **argv)
+{
+	/*
+	 * TODO Existing bug in git-pull.sh, add another patch to the series to fix:
+	 * This function fails to take into account any arguments to be passed to git
+	 * fetch other than the remote and the refs.
+	 *
+	 * See also error_on_no_merge_candidates, it has the same problem.
+	 */
+
+	/*
+	 * TODO Existing bug in git-pull.sh, add another patch to the series to fix:
+	 * This function doesn't always take into account mapping of remote to local
+	 * branch names.
+	 */
+
+	if (argc <= 1) {
+		struct remote *my_remote;
+		struct branch *branch;
+
+		my_remote = (argc == 1) ? remote_get(argv[0]) : remote_get(NULL);
+		if (!my_remote || !my_remote->name)
+			return NULL;
+
+		branch = branch_get(curr_branch_short);
+		if (!branch || !branch->merge || !branch->merge[0] ||
+			!branch->merge[0]->dst || !branch->remote_name)
+			return NULL;
+
+		if (strcmp(branch->remote_name, my_remote->name))
+			return NULL;
+
+		return branch->merge[0]->dst;
+
+	} else {
+		/*
+		 * TODO Code here is ugly but should do the same thing as
+		 * git-parse-remote.sh. I haven't fully tested it as I want to rewrite
+		 * the whole function in a subsequent patch anyway.
+		 */
+
+		static const char **refs_to_parse = NULL;
+		int refs_to_parse_nr = argc - 1;
+		int i;
+		struct refspec *parsed_refspec;
+		char *remote_ref;
+
+		refs_to_parse = xcalloc(argc, sizeof(const char *));
+		for (i = 0; i < refs_to_parse_nr; i++)
+			refs_to_parse[i] = argv[i + 1];
+		refs_to_parse[i] = NULL;
+
+		parsed_refspec = parse_fetch_refspec(refs_to_parse_nr, refs_to_parse);
+
+		remote_ref = parsed_refspec->src;
+
+		if (!remote_ref)
+			remote_ref = "HEAD";
+		else if (starts_with(remote_ref, "heads/"))
+			remote_ref += strlen("heads/");
+		else if (starts_with(remote_ref, "refs/heads/"))
+			remote_ref += strlen("refs/heads/");
+		else if (starts_with(remote_ref, "refs/"))
+			remote_ref = NULL;
+		else if (starts_with(remote_ref, "tags/"))
+			remote_ref = NULL;
+		else if (starts_with(remote_ref, "remotes/"))
+			remote_ref = NULL;
+
+		if (!remote_ref)
+			return NULL;
+
+		if (!strcmp(argv[0], ".")) {
+			char *full_ref = xmalloc(strlen(remote_ref) + 12);
+			strcpy(full_ref, "refs/heads/");
+			strcat(full_ref, remote_ref);
+			return full_ref;
+		} else {
+			char *full_ref = xmalloc(strlen(remote_ref) +strlen(argv[0]) + 15);
+			strcpy(full_ref, "refs/remotes/");
+			strcat(full_ref, argv[0]);
+			strcat(full_ref, "/");
+			strcat(full_ref, remote_ref);
+			return full_ref;
+		}
+
+	}
+}
+
+static char *find_fork_point_for_rebase(int argc, const char** argv, unsigned char sha1_orig_head[20])
+{
+	const char *remote_ref;
+	const unsigned char *fork_point_sha1;
+
+	remote_ref = get_remote_merge_branch(argc, argv);
+	if (!remote_ref)
+		return NULL;
+
+	fork_point_sha1 = get_fork_point(remote_ref, sha1_orig_head);
+	if (is_null_sha1(fork_point_sha1))
+		return NULL;
+
+	return sha1_to_hex(fork_point_sha1);
+}
+
+static int fast_forward_unborn_branch(const struct string_list merge_head)
+{
+	/*
+	* Pulling into an unborn branch.
+	* We claim the index is based on an empty tree and try to fast-forward
+	* to merge-head. This ensures we will not lose index / worktree
+	* changes that the user already made on the unborn branch.
+	*/
+	unsigned char sha1[20];
+
+	if (merge_head.nr > 1)
+		die(_("Cannot merge multiple branches into empty head"));
+
+	if (get_sha1_hex(merge_head.items[0].string, sha1))
+		die(_("Unable to find '%s'. FETCH_HEAD may be corrupt"), merge_head.items[0].string);
+
+	if (checkout_fast_forward(EMPTY_TREE_SHA1_BIN, sha1, 0))
+		return 1;
+
+	if (update_ref("initial pull", "HEAD", sha1, NULL, 0, UPDATE_REFS_DIE_ON_ERR))
+		return 1;
+
+	return 0;
+}
+
+static int check_for_unstaged_changes()
+{
+	struct rev_info rev;
+	int result;
+
+	/* Check for changes in the working tree */
+	init_revisions(&rev, NULL);
+	setup_revisions(0, NULL, &rev, NULL);
+	DIFF_OPT_SET(&rev.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev.diffopt, QUICK);
+	DIFF_OPT_SET(&rev.diffopt, HAS_CHANGES);
+	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+	result = run_diff_files(&rev, 0);
+
+	return diff_result_code(&rev.diffopt, result);
+}
+
+static int check_for_uncommitted_changes()
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt;
+	int result;
+
+	/* Check for changes in the index */
+	init_revisions(&rev, NULL);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	setup_revisions(0, NULL, &rev, &opt);
+	DIFF_OPT_SET(&rev.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev.diffopt, QUICK);
+	DIFF_OPT_SET(&rev.diffopt, HAS_CHANGES);
+	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+	result = run_diff_index(&rev, 1);
+
+	return diff_result_code(&rev.diffopt, result);
+}
+
+static void check_state_before_starting(const enum pull_mode mode, const int unborn)
+{
+	/*
+	 * TODO This function is as close to git-pull.sh as possible. We should be
+	 * able to tidy it up and improve it now it's in c (e.g. fail early if
+	 * cherry-pick in progress), perhaps using wt_status stuff.
+	 */
+
+	if (read_cache_unmerged())
+		die_resolve_conflict("pull");
+
+	if (file_exists(git_path("MERGE_HEAD")))
+		die_merge_in_progress();
+
+	if (mode != PULL_MERGE) {
+
+		/*
+		 * TODO Existing bug in git-pull.sh, add another patch to the series to fix:
+		 * We'll die unnecessarily on the next line if files are added to the
+		 * index then removed again, leaving the index empty, e.g.
+		 *
+		 *    mkdir temp
+		 *    cd temp
+		 *    git init
+		 *    echo test > test
+		 *    git add test
+		 *    git reset test
+		 *    rm test
+		 *    git pull --rebase ../another-repo
+		 * => "updating an unborn branch with changes added to the index"
+		 */
+		if (unborn && file_exists(get_index_file()))
+			die(_("Updating an unborn branch with changes added to the index"));
+
+		if (!unborn) {
+			int unstaged_changes = 0;
+			int uncommited_changes = 0;
+
+			if (read_cache_preload(NULL) < 0)
+				die(_("Corrupt index file"));
+
+			refresh_cache(REFRESH_QUIET | REFRESH_IGNORE_SUBMODULES);
+
+			unstaged_changes = check_for_unstaged_changes();
+			uncommited_changes = check_for_uncommitted_changes();
+
+			if (unstaged_changes && uncommited_changes)
+				die(_("Cannot pull with rebase: You have unstaged changes and your index contains uncommitted changes./n"
+					"Please commit or stash them."));
+
+			if (unstaged_changes)
+				die(_("Cannot pull with rebase: You have unstaged changes./n"
+					"Please commit or stash them."));
+
+			if (uncommited_changes)
+				die(_("Cannot pull with rebase: Your index contains uncommitted changes./n"
+					"Please commit or stash them."));
+		}
+	}
+}
+
+static void set_reflog_message(int argc, const char **argv)
+{
+	int idx;
+	struct strbuf reflog_message = STRBUF_INIT;
+
+	for (idx = 0; idx < argc; idx++) {
+		strbuf_addstr(&reflog_message, argv[idx]);
+		strbuf_addch(&reflog_message, ' ');
+	}
+
+	strbuf_trim(&reflog_message);
+
+	setenv("GIT_REFLOG_ACTION", reflog_message.buf, 0);
+
+	strbuf_release(&reflog_message);
+}
+
+int cmd_pull(int argc, const char **argv, const char *prefix)
+{
+	unsigned char sha1_orig_head[20], sha1_curr_head[20];
+	enum pull_mode mode = PULL_NOT_SET;
+	char *fork_point_for_rebase = NULL;
+
+	set_reflog_message(argc, argv);
+
+	curr_branch = resolve_refdup("HEAD", 0, sha1_orig_head, NULL);
+	if (curr_branch && starts_with(curr_branch, "refs/heads/"))
+		curr_branch_short = curr_branch + 11;
+
+	git_config(git_pull_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, builtin_pull_options,
+		builtin_pull_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	mode = get_pull_mode();
+
+	if (shortlog_len < 0)
+		shortlog_len = (merge_log_config > 0) ? merge_log_config : 0;
+
+	check_state_before_starting(mode, is_null_sha1(sha1_orig_head));
+
+	if (mode != PULL_MERGE && !is_null_sha1(sha1_orig_head))
+		fork_point_for_rebase = find_fork_point_for_rebase(argc, argv, sha1_orig_head);
+
+	if (run_fetch(argc, argv))
+		return 1;
+
+	if (dryrun)
+		return 0;
+
+	get_sha1("HEAD", sha1_curr_head);
+
+	if (!is_null_sha1(sha1_orig_head) &&
+		hashcmp(sha1_orig_head, sha1_curr_head)) {
+		/*
+		 * The fetch involved updating the current branch.
+		 * The working tree and the index file are still based on the
+		 * orig_head commit, but we are merging into curr_head.
+		 * First update the working tree to match curr_head.
+		 */
+
+		/* TRANSLATORS: %s is a SHA1 identifying a commit. */
+		warning(_("fetch updated the current branch head.\n"
+			"fast-forwarding your working tree from\n"
+			"commit %s."), sha1_to_hex(sha1_orig_head));
+
+		if (checkout_fast_forward(sha1_orig_head, sha1_curr_head, 0))
+			die(_("Cannot fast-forward your working tree.\n"
+			"After making sure that you saved anything precious from\n\n"
+			"  git diff %s\n\n"
+			"output, run\n\n"
+			"  git reset --hard\n\n"
+			"to recover."), sha1_to_hex(sha1_orig_head));
+	}
+
+	const struct string_list merge_head = get_merge_head();
+	if (merge_head.nr == 0)
+		error_on_no_merge_candidates(mode, argc, argv);
+
+	if (is_null_sha1(sha1_orig_head))
+		return fast_forward_unborn_branch(merge_head);
+
+	if (mode == PULL_MERGE)
+		return run_merge(merge_head);
+
+	return run_rebase(merge_head, fork_point_for_rebase, mode);
+}
diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
new file mode 100755
index 0000000..4d4fc77
--- /dev/null
+++ b/contrib/examples/git-pull.sh
@@ -0,0 +1,340 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# Fetch one or more remote refs and merge it/them into the current HEAD.
+
+USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
+LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
+SUBDIRECTORY_OK=Yes
+OPTIONS_SPEC=
+. git-sh-setup
+. git-sh-i18n
+set_reflog_action "pull${1+ $*}"
+require_work_tree_exists
+cd_to_toplevel
+
+
+die_conflict () {
+    git diff-index --cached --name-status -r --ignore-submodules HEAD --
+    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
+	die "$(gettext "Pull is not possible because you have unmerged files.
+Please, fix them up in the work tree, and then use 'git add/rm <file>'
+as appropriate to mark resolution and make a commit.")"
+    else
+	die "$(gettext "Pull is not possible because you have unmerged files.")"
+    fi
+}
+
+die_merge () {
+    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
+	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).
+Please, commit your changes before you can merge.")"
+    else
+	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).")"
+    fi
+}
+
+test -z "$(git ls-files -u)" || die_conflict
+test -f "$GIT_DIR/MERGE_HEAD" && die_merge
+
+bool_or_string_config () {
+	git config --bool "$1" 2>/dev/null || git config "$1"
+}
+
+strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
+log_arg= verbosity= progress= recurse_submodules= verify_signatures=
+merge_args= edit= rebase_args=
+curr_branch=$(git symbolic-ref -q HEAD)
+curr_branch_short="${curr_branch#refs/heads/}"
+rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
+if test -z "$rebase"
+then
+	rebase=$(bool_or_string_config pull.rebase)
+fi
+
+# Setup default fast-forward options via `pull.ff`
+pull_ff=$(git config pull.ff)
+case "$pull_ff" in
+false)
+	no_ff=--no-ff
+	;;
+only)
+	ff_only=--ff-only
+	;;
+esac
+
+
+dry_run=
+while :
+do
+	case "$1" in
+	-q|--quiet)
+		verbosity="$verbosity -q" ;;
+	-v|--verbose)
+		verbosity="$verbosity -v" ;;
+	--progress)
+		progress=--progress ;;
+	--no-progress)
+		progress=--no-progress ;;
+	-n|--no-stat|--no-summary)
+		diffstat=--no-stat ;;
+	--stat|--summary)
+		diffstat=--stat ;;
+	--log|--no-log)
+		log_arg=$1 ;;
+	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
+		no_commit=--no-commit ;;
+	--c|--co|--com|--comm|--commi|--commit)
+		no_commit=--commit ;;
+	-e|--edit)
+		edit=--edit ;;
+	--no-edit)
+		edit=--no-edit ;;
+	--sq|--squ|--squa|--squas|--squash)
+		squash=--squash ;;
+	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
+		squash=--no-squash ;;
+	--ff)
+		no_ff=--ff ;;
+	--no-ff)
+		no_ff=--no-ff ;;
+	--ff-only)
+		ff_only=--ff-only ;;
+	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
+		--strateg=*|--strategy=*|\
+	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
+		case "$#,$1" in
+		*,*=*)
+			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
+		1,*)
+			usage ;;
+		*)
+			strategy="$2"
+			shift ;;
+		esac
+		strategy_args="${strategy_args}-s $strategy "
+		;;
+	-X*)
+		case "$#,$1" in
+		1,-X)
+			usage ;;
+		*,-X)
+			xx="-X $(git rev-parse --sq-quote "$2")"
+			shift ;;
+		*,*)
+			xx=$(git rev-parse --sq-quote "$1") ;;
+		esac
+		merge_args="$merge_args$xx "
+		;;
+	-r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*)
+		rebase="${1#*=}"
+		;;
+	-r|--r|--re|--reb|--reba|--rebas|--rebase)
+		rebase=true
+		;;
+	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
+		rebase=false
+		;;
+	--recurse-submodules)
+		recurse_submodules=--recurse-submodules
+		;;
+	--recurse-submodules=*)
+		recurse_submodules="$1"
+		;;
+	--no-recurse-submodules)
+		recurse_submodules=--no-recurse-submodules
+		;;
+	--verify-signatures)
+		verify_signatures=--verify-signatures
+		;;
+	--no-verify-signatures)
+		verify_signatures=--no-verify-signatures
+		;;
+	--gpg-sign|-S)
+		gpg_sign_args=-S
+		;;
+	--gpg-sign=*)
+		gpg_sign_args=$(git rev-parse --sq-quote "-S${1#--gpg-sign=}")
+		;;
+	-S*)
+		gpg_sign_args=$(git rev-parse --sq-quote "$1")
+		;;
+	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
+		dry_run=--dry-run
+		;;
+	-h|--help-all)
+		usage
+		;;
+	*)
+		# Pass thru anything that may be meant for fetch.
+		break
+		;;
+	esac
+	shift
+done
+
+case "$rebase" in
+preserve)
+	rebase=true
+	rebase_args=--preserve-merges
+	;;
+true|false|'')
+	;;
+*)
+	echo "Invalid value for --rebase, should be true, false, or preserve"
+	usage
+	exit 1
+	;;
+esac
+
+error_on_no_merge_candidates () {
+	exec >&2
+	for opt
+	do
+		case "$opt" in
+		-t|--t|--ta|--tag|--tags)
+			echo "It doesn't make sense to pull all tags; you probably meant:"
+			echo "  git fetch --tags"
+			exit 1
+		esac
+	done
+
+	if test true = "$rebase"
+	then
+		op_type=rebase
+		op_prep=against
+	else
+		op_type=merge
+		op_prep=with
+	fi
+
+	upstream=$(git config "branch.$curr_branch_short.merge")
+	remote=$(git config "branch.$curr_branch_short.remote")
+
+	if [ $# -gt 1 ]; then
+		if [ "$rebase" = true ]; then
+			printf "There is no candidate for rebasing against "
+		else
+			printf "There are no candidates for merging "
+		fi
+		echo "among the refs that you just fetched."
+		echo "Generally this means that you provided a wildcard refspec which had no"
+		echo "matches on the remote end."
+	elif [ $# -gt 0 ] && [ "$1" != "$remote" ]; then
+		echo "You asked to pull from the remote '$1', but did not specify"
+		echo "a branch. Because this is not the default configured remote"
+		echo "for your current branch, you must specify a branch on the command line."
+	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
+		. git-parse-remote
+		error_on_missing_default_upstream "pull" $op_type $op_prep \
+			"git pull <remote> <branch>"
+	else
+		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
+		echo "from the remote, but no such ref was fetched."
+	fi
+	exit 1
+}
+
+test true = "$rebase" && {
+	if ! git rev-parse -q --verify HEAD >/dev/null
+	then
+		# On an unborn branch
+		if test -f "$GIT_DIR/index"
+		then
+			die "$(gettext "updating an unborn branch with changes added to the index")"
+		fi
+	else
+		require_clean_work_tree "pull with rebase" "Please commit or stash them."
+	fi
+	oldremoteref= &&
+	test -n "$curr_branch" &&
+	. git-parse-remote &&
+	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch 2>/dev/null)
+}
+orig_head=$(git rev-parse -q --verify HEAD)
+git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
+test -z "$dry_run" || exit 0
+
+curr_head=$(git rev-parse -q --verify HEAD)
+if test -n "$orig_head" && test "$curr_head" != "$orig_head"
+then
+	# The fetch involved updating the current branch.
+
+	# The working tree and the index file is still based on the
+	# $orig_head commit, but we are merging into $curr_head.
+	# First update the working tree to match $curr_head.
+
+	eval_gettextln "Warning: fetch updated the current branch head.
+Warning: fast-forwarding your working tree from
+Warning: commit \$orig_head." >&2
+	git update-index -q --refresh
+	git read-tree -u -m "$orig_head" "$curr_head" ||
+		die "$(eval_gettext "Cannot fast-forward your working tree.
+After making sure that you saved anything precious from
+$ git diff \$orig_head
+output, run
+$ git reset --hard
+to recover.")"
+
+fi
+
+merge_head=$(sed -e '/	not-for-merge	/d' \
+	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
+	tr '\012' ' ')
+
+case "$merge_head" in
+'')
+	error_on_no_merge_candidates "$@"
+	;;
+?*' '?*)
+	if test -z "$orig_head"
+	then
+		die "$(gettext "Cannot merge multiple branches into empty head")"
+	fi
+	if test true = "$rebase"
+	then
+		die "$(gettext "Cannot rebase onto multiple branches")"
+	fi
+	;;
+esac
+
+# Pulling into unborn branch: a shorthand for branching off
+# FETCH_HEAD, for lazy typers.
+if test -z "$orig_head"
+then
+	# Two-way merge: we claim the index is based on an empty tree,
+	# and try to fast-forward to HEAD.  This ensures we will not
+	# lose index/worktree changes that the user already made on
+	# the unborn branch.
+	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	git read-tree -m -u $empty_tree $merge_head &&
+	git update-ref -m "initial pull" HEAD $merge_head "$curr_head"
+	exit
+fi
+
+if test true = "$rebase"
+then
+	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
+	if test "$oldremoteref" = "$o"
+	then
+		unset oldremoteref
+	fi
+fi
+
+merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
+case "$rebase" in
+true)
+	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
+	eval="$eval $gpg_sign_args"
+	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
+	;;
+*)
+	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
+	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
+	eval="$eval $gpg_sign_args"
+	eval="$eval \"\$merge_name\" HEAD $merge_head"
+	;;
+esac
+eval "exec $eval"
diff --git a/git-pull.sh b/git-pull.sh
deleted file mode 100755
index 4d4fc77..0000000
--- a/git-pull.sh
+++ /dev/null
@@ -1,340 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano
-#
-# Fetch one or more remote refs and merge it/them into the current HEAD.
-
-USAGE='[-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>...'
-LONG_USAGE='Fetch one or more remote refs and integrate it/them with the current HEAD.'
-SUBDIRECTORY_OK=Yes
-OPTIONS_SPEC=
-. git-sh-setup
-. git-sh-i18n
-set_reflog_action "pull${1+ $*}"
-require_work_tree_exists
-cd_to_toplevel
-
-
-die_conflict () {
-    git diff-index --cached --name-status -r --ignore-submodules HEAD --
-    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
-	die "$(gettext "Pull is not possible because you have unmerged files.
-Please, fix them up in the work tree, and then use 'git add/rm <file>'
-as appropriate to mark resolution and make a commit.")"
-    else
-	die "$(gettext "Pull is not possible because you have unmerged files.")"
-    fi
-}
-
-die_merge () {
-    if [ $(git config --bool --get advice.resolveConflict || echo true) = "true" ]; then
-	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).
-Please, commit your changes before you can merge.")"
-    else
-	die "$(gettext "You have not concluded your merge (MERGE_HEAD exists).")"
-    fi
-}
-
-test -z "$(git ls-files -u)" || die_conflict
-test -f "$GIT_DIR/MERGE_HEAD" && die_merge
-
-bool_or_string_config () {
-	git config --bool "$1" 2>/dev/null || git config "$1"
-}
-
-strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity= progress= recurse_submodules= verify_signatures=
-merge_args= edit= rebase_args=
-curr_branch=$(git symbolic-ref -q HEAD)
-curr_branch_short="${curr_branch#refs/heads/}"
-rebase=$(bool_or_string_config branch.$curr_branch_short.rebase)
-if test -z "$rebase"
-then
-	rebase=$(bool_or_string_config pull.rebase)
-fi
-
-# Setup default fast-forward options via `pull.ff`
-pull_ff=$(git config pull.ff)
-case "$pull_ff" in
-false)
-	no_ff=--no-ff
-	;;
-only)
-	ff_only=--ff-only
-	;;
-esac
-
-
-dry_run=
-while :
-do
-	case "$1" in
-	-q|--quiet)
-		verbosity="$verbosity -q" ;;
-	-v|--verbose)
-		verbosity="$verbosity -v" ;;
-	--progress)
-		progress=--progress ;;
-	--no-progress)
-		progress=--no-progress ;;
-	-n|--no-stat|--no-summary)
-		diffstat=--no-stat ;;
-	--stat|--summary)
-		diffstat=--stat ;;
-	--log|--no-log)
-		log_arg=$1 ;;
-	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
-		no_commit=--no-commit ;;
-	--c|--co|--com|--comm|--commi|--commit)
-		no_commit=--commit ;;
-	-e|--edit)
-		edit=--edit ;;
-	--no-edit)
-		edit=--no-edit ;;
-	--sq|--squ|--squa|--squas|--squash)
-		squash=--squash ;;
-	--no-sq|--no-squ|--no-squa|--no-squas|--no-squash)
-		squash=--no-squash ;;
-	--ff)
-		no_ff=--ff ;;
-	--no-ff)
-		no_ff=--no-ff ;;
-	--ff-only)
-		ff_only=--ff-only ;;
-	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
-		--strateg=*|--strategy=*|\
-	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
-		case "$#,$1" in
-		*,*=*)
-			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
-		1,*)
-			usage ;;
-		*)
-			strategy="$2"
-			shift ;;
-		esac
-		strategy_args="${strategy_args}-s $strategy "
-		;;
-	-X*)
-		case "$#,$1" in
-		1,-X)
-			usage ;;
-		*,-X)
-			xx="-X $(git rev-parse --sq-quote "$2")"
-			shift ;;
-		*,*)
-			xx=$(git rev-parse --sq-quote "$1") ;;
-		esac
-		merge_args="$merge_args$xx "
-		;;
-	-r=*|--r=*|--re=*|--reb=*|--reba=*|--rebas=*|--rebase=*)
-		rebase="${1#*=}"
-		;;
-	-r|--r|--re|--reb|--reba|--rebas|--rebase)
-		rebase=true
-		;;
-	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		rebase=false
-		;;
-	--recurse-submodules)
-		recurse_submodules=--recurse-submodules
-		;;
-	--recurse-submodules=*)
-		recurse_submodules="$1"
-		;;
-	--no-recurse-submodules)
-		recurse_submodules=--no-recurse-submodules
-		;;
-	--verify-signatures)
-		verify_signatures=--verify-signatures
-		;;
-	--no-verify-signatures)
-		verify_signatures=--no-verify-signatures
-		;;
-	--gpg-sign|-S)
-		gpg_sign_args=-S
-		;;
-	--gpg-sign=*)
-		gpg_sign_args=$(git rev-parse --sq-quote "-S${1#--gpg-sign=}")
-		;;
-	-S*)
-		gpg_sign_args=$(git rev-parse --sq-quote "$1")
-		;;
-	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
-		dry_run=--dry-run
-		;;
-	-h|--help-all)
-		usage
-		;;
-	*)
-		# Pass thru anything that may be meant for fetch.
-		break
-		;;
-	esac
-	shift
-done
-
-case "$rebase" in
-preserve)
-	rebase=true
-	rebase_args=--preserve-merges
-	;;
-true|false|'')
-	;;
-*)
-	echo "Invalid value for --rebase, should be true, false, or preserve"
-	usage
-	exit 1
-	;;
-esac
-
-error_on_no_merge_candidates () {
-	exec >&2
-	for opt
-	do
-		case "$opt" in
-		-t|--t|--ta|--tag|--tags)
-			echo "It doesn't make sense to pull all tags; you probably meant:"
-			echo "  git fetch --tags"
-			exit 1
-		esac
-	done
-
-	if test true = "$rebase"
-	then
-		op_type=rebase
-		op_prep=against
-	else
-		op_type=merge
-		op_prep=with
-	fi
-
-	upstream=$(git config "branch.$curr_branch_short.merge")
-	remote=$(git config "branch.$curr_branch_short.remote")
-
-	if [ $# -gt 1 ]; then
-		if [ "$rebase" = true ]; then
-			printf "There is no candidate for rebasing against "
-		else
-			printf "There are no candidates for merging "
-		fi
-		echo "among the refs that you just fetched."
-		echo "Generally this means that you provided a wildcard refspec which had no"
-		echo "matches on the remote end."
-	elif [ $# -gt 0 ] && [ "$1" != "$remote" ]; then
-		echo "You asked to pull from the remote '$1', but did not specify"
-		echo "a branch. Because this is not the default configured remote"
-		echo "for your current branch, you must specify a branch on the command line."
-	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
-		. git-parse-remote
-		error_on_missing_default_upstream "pull" $op_type $op_prep \
-			"git pull <remote> <branch>"
-	else
-		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
-		echo "from the remote, but no such ref was fetched."
-	fi
-	exit 1
-}
-
-test true = "$rebase" && {
-	if ! git rev-parse -q --verify HEAD >/dev/null
-	then
-		# On an unborn branch
-		if test -f "$GIT_DIR/index"
-		then
-			die "$(gettext "updating an unborn branch with changes added to the index")"
-		fi
-	else
-		require_clean_work_tree "pull with rebase" "Please commit or stash them."
-	fi
-	oldremoteref= &&
-	test -n "$curr_branch" &&
-	. git-parse-remote &&
-	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
-	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch 2>/dev/null)
-}
-orig_head=$(git rev-parse -q --verify HEAD)
-git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
-test -z "$dry_run" || exit 0
-
-curr_head=$(git rev-parse -q --verify HEAD)
-if test -n "$orig_head" && test "$curr_head" != "$orig_head"
-then
-	# The fetch involved updating the current branch.
-
-	# The working tree and the index file is still based on the
-	# $orig_head commit, but we are merging into $curr_head.
-	# First update the working tree to match $curr_head.
-
-	eval_gettextln "Warning: fetch updated the current branch head.
-Warning: fast-forwarding your working tree from
-Warning: commit \$orig_head." >&2
-	git update-index -q --refresh
-	git read-tree -u -m "$orig_head" "$curr_head" ||
-		die "$(eval_gettext "Cannot fast-forward your working tree.
-After making sure that you saved anything precious from
-$ git diff \$orig_head
-output, run
-$ git reset --hard
-to recover.")"
-
-fi
-
-merge_head=$(sed -e '/	not-for-merge	/d' \
-	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
-	tr '\012' ' ')
-
-case "$merge_head" in
-'')
-	error_on_no_merge_candidates "$@"
-	;;
-?*' '?*)
-	if test -z "$orig_head"
-	then
-		die "$(gettext "Cannot merge multiple branches into empty head")"
-	fi
-	if test true = "$rebase"
-	then
-		die "$(gettext "Cannot rebase onto multiple branches")"
-	fi
-	;;
-esac
-
-# Pulling into unborn branch: a shorthand for branching off
-# FETCH_HEAD, for lazy typers.
-if test -z "$orig_head"
-then
-	# Two-way merge: we claim the index is based on an empty tree,
-	# and try to fast-forward to HEAD.  This ensures we will not
-	# lose index/worktree changes that the user already made on
-	# the unborn branch.
-	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
-	git read-tree -m -u $empty_tree $merge_head &&
-	git update-ref -m "initial pull" HEAD $merge_head "$curr_head"
-	exit
-fi
-
-if test true = "$rebase"
-then
-	o=$(git show-branch --merge-base $curr_branch $merge_head $oldremoteref)
-	if test "$oldremoteref" = "$o"
-	then
-		unset oldremoteref
-	fi
-fi
-
-merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
-case "$rebase" in
-true)
-	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
-	eval="$eval $gpg_sign_args"
-	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
-	;;
-*)
-	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
-	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
-	eval="$eval $gpg_sign_args"
-	eval="$eval \"\$merge_name\" HEAD $merge_head"
-	;;
-esac
-eval "exec $eval"
diff --git a/git.c b/git.c
index 42a4ee5..cd824b6 100644
--- a/git.c
+++ b/git.c
@@ -445,6 +445,7 @@ static struct cmd_struct commands[] = {
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
 	{ "receive-pack", cmd_receive_pack },
-- 
2.4.0.7.gf20f26f
