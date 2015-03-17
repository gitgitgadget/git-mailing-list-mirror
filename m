From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Tue, 17 Mar 2015 21:57:42 +0800
Message-ID: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 14:58:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXs0v-00063e-RI
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 14:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908AbbCQN62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 09:58:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33322 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbbCQN60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 09:58:26 -0400
Received: by pagr17 with SMTP id r17so10747352pag.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 06:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LqSlv8zvwJx+GnOaB5uhL7DOwuVBwe+Pao4X5f0l6fg=;
        b=rxQIYwA80XuCueQvnwVok4vsUmlF6y9PzG05ANLXBzp7qORD0NPoqJoC6njaHvYItq
         Zfdhvp5GZoSjD67ELFrvr/wrrt8xHKGFfouCs6agWdtcP8DCQ4NpI1fGvSiztiwbrOu7
         Y4GvySW9Sq8hTQTRk7SVET+MBU9EkuyH4cphhdiTrOsE5aFMlB+xwRnxagWa/id1agvq
         WkTcuU3FXtAlM5YOseORTPayxZR4IQJFI2EnN2SN8FvsvGKKPQQV7kFOWO9OVFEN2J9g
         SmETTC+KGIwc5vjV4xYpVJUtlcoDKvZ3meUmnRtZ/DapOjCG18VazefXw/VjF8zzsF/n
         8ANQ==
X-Received: by 10.66.146.100 with SMTP id tb4mr118797046pab.104.1426600705476;
        Tue, 17 Mar 2015 06:58:25 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id os6sm22703346pac.28.2015.03.17.06.58.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 06:58:24 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YXs0i-0008Rh-VF; Tue, 17 Mar 2015 21:58:20 +0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265628>

The git-pull command is currently implemented by the shell script
git-pull.sh. However, git-pull.sh suffers from some problems:

* Inconsistent command line interface: since git-pull.sh does not use
  git's internal parse-options API, it's command line interface is
  inconsistent with other git builtins. For example, the option --st
  should throw an ambigious option error as it could mean --stat or
  --strategy, but git-pull.sh is hardcoded to assume --st resolves to
  --strategy.  It also does not list the command line options in its
  usage help.

* Inefficient: shell scripts can only access git functionality through
  spawning git processes, which has a relatively high overhead on
  certain operating systems such as Windows. Furthermore, the repeated
  starting up of git means that commonly-used files such config files,
  the index file and often accessed objects/packfiles are repeatedly
  read, which can cause poor performance on filesystems or operating
  systems with slow IO operations.

* Makes it difficult to port git: git-pull.sh requires a posix
  conformant shell and utilities such as sed and tr. This makes it
  harder to port git to non-posix environments.

By making git-pull a builtin, it has access to git's internal API and
thus solves the above problems:

* Usage of parse-options API means greater consistency of the
  command-line interface with other git commands.

* No spawning of external git processes: internal API and builtins are
  called directly. This also means that they use the same underlying
  object/config cache, which reduces needless IO/parsing operations.

* Low-level control over code execution and thus greater efficiency. For
  example commit SHA1s now only need to be parsed from a string once
  (when resolving branch refs), while as a shell script they would have
  to be stored as strings and parsed over and over again.

Furthermore, this reduces git's dependence on posix shells and
utilities, which would be very helpful in porting git to non-posix
environments such as Windows.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Hi, I would like to share this very rough prototype with everyone. All
the relevant tests (t5520-t5572) pass.

I did a quick benchmark on my Linux and Windows systems, which have
nearly the same hardware, by running 'git pull' 100 times on a repo and
its clone with 1 commit. On Linux, there is negligible performance
difference, but on Windows the runtime fell from 8m 25s to 1m 3s. The
timings should not be affected by any msys2 emulation as the git
processes were spawned from a native executable. I started this as a
just-for-fun exercise to learn about the git internal API, but seeing as
the results are very encouraging, I'm tempted to take on this project
for GSoC.

Of course, it would be easy to make any shell script a builtin by using
the run_command* functions, but I feel that that would not take
advantage of the potential benefits in using git's internal API
directly. So, I set myself a few requirements for the ideal end result:

* zero spawning of processes so that the internal object, index and
config cache can be taken advantage of. Some operating systems (like
Windows) also have a relatively large overhead when spawning
processes[1].

* avoid needless parsing/string conversions by directly accessing the C
data structures. Massaging of strings cause too much code churn, so
functions that take the richer C data structures as input should be
preferred over functions that work by parsing string arguments (e.g.
prefer using the run_diff_files() function instead of calling
cmd_diff_files or spawning a git diff-files process)

* use the internal API as much as possible: share code between the
builtins (e.g. builtin fmt-merge-msg, exposed in fmt-merge-msg.h)
in order to reduce code complexity. For example, the fork_point() code
in this patch should be shared with the merge-base builtin.

[1] http://stackoverflow.com/questions/10710912

However, there were some problems encountered when trying to fulfill the
requirements above:

* Many builtins only provide their main entry point to access their
functionality -- this means that argument options are parsed, put back
together, and then re-parsed again, which is quite inefficient and can
create a lot of code complexity. A better solution would be to expose
the functionality of these builtins as a separate function without
argument parsing, similar to how fmt_merge_msg is implemented.

* Some buitins do not expect to be called by their cmd_* functions
through code paths other than git.c. For example, fetch.c actually
frees the strings it pulls from argv. This patch works around these
functions by not attempting to free memory passed to these functions,
but a more comprehensive solution would be to investigate and fix
these functions. (Or expose their functionality in as a separate function)

* Finally, there is the possibility that in the process of conversion
bugs or incompatible behavioral changes may be introduced which are
not caught by the test suite. Ideally, I think the solution is to
improve the test suite and make it as comprehensive as possible, but
writing a comprehensive test suite may be too time consuming. A
simpler, but less perfect strategy might be to just convert the shell
scripts directly statement by statement to C, using the run_command*()
functions as Duy Nguyen[2] suggested, before changing the code to use
the internal API.

[2] http://thread.gmane.org/gmane.comp.version-control.git/265575/focus=265602

This patch is the result of trying to fulfill the above requirements,
and temporarily working around the above problems until I can find their
source/come up with a patch. (There may also be some bugs in the
git-pull.sh code related to not taking into account the fact that "$@"
can contain arguments for git-fetch. However, I have not found a way to
trigger them yet in practice.) I would like some feedback on whether the
above requirements are sane, and whether there may be disadvantages that
I'm missing out on. As stated above, there are big performance wins for
Windows, but I think the biggest win of all is to reduce git's
dependence on a scripting language, improving portability and reducing
code duplication between the languages, thus making git a better
universal cross-platform solution for version control :)

Regards,
Paul

 Makefile       |   2 +-
 builtin.h      |   1 +
 builtin/pull.c | 938 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git.c          |   1 +
 4 files changed, 941 insertions(+), 1 deletion(-)
 create mode 100644 builtin/pull.c

diff --git a/Makefile b/Makefile
index 44f1dd1..50a6a16 100644
--- a/Makefile
+++ b/Makefile
@@ -470,7 +470,6 @@ SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
-SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-remote-testgit.sh
@@ -872,6 +871,7 @@ BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
 BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
+BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
 BUILTIN_OBJS += builtin/receive-pack.o
diff --git a/builtin.h b/builtin.h
index b87df70..ea3c834 100644
--- a/builtin.h
+++ b/builtin.h
@@ -98,6 +98,7 @@ extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
+extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
diff --git a/builtin/pull.c b/builtin/pull.c
new file mode 100644
index 0000000..73fa87e
--- /dev/null
+++ b/builtin/pull.c
@@ -0,0 +1,938 @@
+/*
+ * Builtin "git pull"
+ *
+ * Based on git-pull.sh by Junio C Hamano
+ *
+ * Fetch one or more remote refs and merge it/them into the current HEAD.
+ */
+#include "cache.h"
+#include "builtin.h"
+#include "string-list.h"
+#include "cache.h"
+#include "refs.h"
+#include "diff.h"
+#include "revision.h"
+#include "submodule.h"
+#include "commit.h"
+#include "dir.h"
+#include "remote.h"
+#include "argv-array.h"
+#include "sha1-array.h"
+#include "run-command.h"
+#include "lockfile.h"
+#include "fmt-merge-msg.h"
+
+static const char * const builtin_pull_usage[] = {
+	N_("git pull [-n | --no-stat] [--[no-]commit] [--[no-]squash] [--[no-]ff|--ff-only] [--[no-]rebase|--rebase=preserve] [-s strategy]... [<fetch-options>] <repo> <head>..."),
+	NULL
+};
+
+static const char *opt_prefix;
+static int opt_verbosity = 0;
+static int opt_progress = -1;
+static int opt_diffstat = -1;
+/* NOTE: git-pull.sh only supports --log and --no-log, as opposed to what
+ * man git-pull says. */
+static int opt_shortlog_len;
+static int opt_commit = -1;
+static int opt_edit = -1;
+static int opt_squash = -1;
+static int opt_ff;
+static struct string_list opt_merge_strategies = STRING_LIST_INIT_NODUP;
+static struct string_list opt_merge_strategy_opts = STRING_LIST_INIT_NODUP;
+static int opt_rebase;
+static int opt_recurse_submodules;
+static int opt_verify_signatures = -1;
+static const char *opt_gpg_sign;
+static int opt_dry_run;
+
+/* Global vars since they are used often */
+static char *head_name;
+static const char *head_name_short;
+static unsigned char head_sha1[20];
+static int head_flags;
+
+enum rebase_type {
+	REBASE_FALSE = 0,
+	REBASE_TRUE = 1,
+	REBASE_PRESERVE = 2
+};
+
+/**
+ * Parse rebase config/option value and return corresponding int
+ */
+static int parse_rebase(const char *arg)
+{
+	if (!strcmp(arg, "true"))
+		return REBASE_TRUE;
+	else if (!strcmp(arg, "false"))
+		return REBASE_FALSE;
+	else if (!strcmp(arg, "preserve"))
+		return REBASE_PRESERVE;
+	else
+		return -1; /* Invalid value */
+}
+
+/**
+ * Returns default rebase option value
+ */
+static int rebase_config_default(void)
+{
+	struct strbuf name = STRBUF_INIT;
+	const char *value = NULL;
+	int boolval;
+
+	strbuf_addf(&name, "branch.%s.rebase", head_name_short);
+	if (git_config_get_value(name.buf, &value))
+		git_config_get_value("pull.rebase", &value);
+	strbuf_release(&name);
+	if (!value)
+		return REBASE_FALSE;
+	boolval = git_config_maybe_bool("pull.rebase", value);
+	if (boolval >= 0)
+		return boolval ? REBASE_TRUE : REBASE_FALSE;
+	else if (value && !strcmp(value, "preserve"))
+		return REBASE_PRESERVE;
+	die(_("invalid value for branch.%s.rebase \"%s\""), head_name_short, value);
+}
+
+static int parse_opt_rebase(const struct option *opt, const char *arg, int unset)
+{
+	if (arg)
+		*(int *)opt->value = parse_rebase(arg);
+	else
+		*(int *)opt->value = unset ? REBASE_FALSE : REBASE_TRUE;
+	return (*(int *)opt->value) >= 0 ? 0 : -1;
+}
+
+enum ff_type {
+	FF_NO = 0,
+	FF_ALLOW = 1,
+	FF_ONLY = 2
+};
+
+/**
+ * Returns default --ff value
+ */
+static int ff_config_default(void)
+{
+	const char *value = NULL;
+	int boolval;
+
+	git_config_get_value("pull.ff", &value);
+	boolval = git_config_maybe_bool("pull.ff", value);
+	if (boolval >= 0)
+		return boolval ? FF_ALLOW : FF_NO;
+	else if (value && !strcmp(value, "only"))
+		return FF_ONLY;
+	return FF_ALLOW; /* don't barf on values from future versions of git */
+}
+
+enum recurse_submodules_type {
+	RS_NO = 0,
+	RS_YES = 1,
+	RS_ON_DEMAND = 2
+};
+
+static int parse_opt_recurse_submodules(const struct option *opt, const char *arg, int unset)
+{
+	if (!arg)
+		*(int *)opt->value = unset ? RS_NO : RS_YES;
+	else if (!strcmp(arg, "no"))
+		*(int *)opt->value = RS_NO;
+	else if (!strcmp(arg, "yes"))
+		*(int *)opt->value = RS_YES;
+	else if (!strcmp(arg, "on-demand"))
+		*(int *)opt->value = RS_ON_DEMAND;
+	else
+		return -1;
+	return 0;
+}
+
+static struct option builtin_pull_options[] = {
+	OPT__VERBOSITY(&opt_verbosity),
+	OPT_BOOL(0, "progress", &opt_progress,
+		N_("force progress reporting")),
+	{ OPTION_SET_INT, 'n', "no-stat", &opt_diffstat, NULL,
+	  N_(""),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+	{ OPTION_SET_INT, 0, "stat", &opt_diffstat, NULL,
+	  N_(""),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+	{ OPTION_SET_INT, 0, "summary", &opt_diffstat, NULL,
+	  N_(""),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1},
+	{ OPTION_SET_INT, 0, "no-summary", &opt_diffstat, NULL,
+	  N_(""),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 0},
+	/* NOTE: git-pull.sh only support --log and --no-log */
+	{ OPTION_INTEGER, 0, "log", &opt_shortlog_len, N_("n"),
+	  N_("populate log with at most <n> entries from shortlog"),
+	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN},
+	OPT_BOOL(0, "commit", &opt_commit,
+		N_("perform a commit if the merge succeeds (default)")),
+	OPT_BOOL('e', "edit", &opt_edit,
+		N_("edit message before committing")),
+	OPT_BOOL(0, "squash", &opt_squash,
+		N_("create a single commit instead of doing a merge")),
+	OPT_BOOL(0, "ff", &opt_ff,
+		N_("allow fast-forward")),
+	{ OPTION_SET_INT, 0, "ff-only", &opt_ff, NULL,
+	  N_("abort if fast-forward is not possible"),
+	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY},
+	OPT_STRING_LIST('s', "strategy", &opt_merge_strategy_opts,
+		N_("strategy"),
+		N_("merge strategy to use")),
+	OPT_STRING_LIST('X', "strategy-option", &opt_merge_strategy_opts,
+		N_("option=value"),
+		N_("option for selected merge strategy")),
+	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase, N_("false|true|preserve"),
+	  N_("rebase"),
+	  PARSE_OPT_OPTARG, parse_opt_rebase, 0},
+	OPT_CALLBACK(0, "recurse-submodules", &opt_recurse_submodules, N_("yes|on-demand|no"),
+		N_("New commits of all populated submodules should be fetched too"),
+		parse_opt_recurse_submodules),
+	OPT_BOOL(0, "verify-signatures", &opt_verify_signatures,
+		N_("verify GPG signatures of commits being merged")),
+	{ OPTION_STRING, 0, "gpg-sign", &opt_gpg_sign, N_("keyid"),
+		N_("GPG-sign the resulting commit"),
+		PARSE_OPT_OPTARG | PARSE_OPT_NONEG, NULL, (intptr_t) ""},
+	OPT_BOOL(0, "dry-run", &opt_dry_run,
+		N_("dry run")),
+	OPT_END()
+};
+
+/**
+ * Prints unmerged (conflicting) files before error()-ing with an appropriate
+ * message depending on the config value of advice.resolveConflict
+ */
+static int error_conflict(void) {
+	struct rev_info rev;
+	int resolve_conflict = 1;
+	init_revisions(&rev, opt_prefix);
+	git_config(git_diff_basic_config, NULL);
+	rev.abbrev = 0;
+	rev.diff = 1;
+	DIFF_OPT_SET(&rev.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
+	rev.diffopt.output_format = DIFF_FORMAT_NAME_STATUS;
+	diff_setup_done(&rev.diffopt);
+	add_head_to_pending(&rev);
+	if (run_diff_index(&rev, 1))
+		return 1;
+	git_config_get_bool("advice.resolveConflict", &resolve_conflict);
+	if (resolve_conflict)
+		return error(_("Pull is not possible because you have unmerged files.\n"
+			"Please, fix them up in the work tree, and then use 'git add/rm <file>'\n"
+			"as appropriate to mark resolution and make a commit."));
+	else
+		return error(_("Pull is not possible because you have unmerged files."));
+}
+
+/**
+ * Errors with an appropriate message depending on the config value of
+ * advice.resolve_conflict
+ */
+static int error_merge(void)
+{
+	int resolve_conflict = 1;
+	git_config_get_bool("advice.resolveConflict", &resolve_conflict);
+	if (resolve_conflict)
+		return error(_("You have not concluded your merge (MERGE_HEAD exists).\n"
+			"Please, commit your changes before you can merge."));
+	else
+		return error(_("You have not concluded your merge (MERGE_HEAD exists)."));
+}
+
+/**
+ * Returns 0 if there are no unstaged changes.
+ */
+static int has_unstaged_changes(void)
+{
+	/* diff-files --quiet --ignore-submodules */
+	struct rev_info rev_info;
+	int result;
+	init_revisions(&rev_info, opt_prefix);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK); /* --quiet */
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_files(&rev_info, 0);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * Returns 0 if there are no uncommitted changes.
+ */
+static int has_uncommitted_changes(void)
+{
+	struct rev_info rev_info;
+	int result;
+	init_revisions(&rev_info, opt_prefix);
+	DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
+	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+	add_head_to_pending(&rev_info);
+	diff_setup_done(&rev_info.diffopt);
+	result = run_diff_index(&rev_info, 1);
+	return diff_result_code(&rev_info.diffopt, result);
+}
+
+/**
+ * Refresh index cache and attempt to write it.
+ */
+static void refresh_and_write_cache(void)
+{
+	static struct lock_file lock_file;
+	int newfd = hold_locked_index(&lock_file, 0);
+	refresh_cache(REFRESH_REALLY | REFRESH_IGNORE_SUBMODULES);
+	if (newfd < 0)
+		return;
+	if (active_cache_changed)
+		write_locked_index(&the_index, &lock_file, COMMIT_LOCK);
+	rollback_lock_file(&lock_file);
+}
+
+
+static int require_clean_work_tree(const char *action, const char *dowhat)
+{
+	int ret = 0;
+
+	refresh_and_write_cache();
+	if (has_unstaged_changes())
+		ret = error(_("Cannot %s: You have unstaged changes."), action);
+	if (has_uncommitted_changes()) {
+		if (ret)
+			error(_("Additionally, your index contains uncommitted changes."));
+		else
+			ret = error(_("Cannot %s: Your index contains uncommitted changes."), action);
+	}
+	if (ret && dowhat)
+		error("%s", dowhat);
+	return ret;
+}
+
+/**
+ * Returns remote for branch
+ */
+static const char *config_get_branch_remote(const char *branch)
+{
+	struct strbuf key = STRBUF_INIT;
+	const char *remote = NULL;
+	if (!branch)
+		branch = head_name_short;
+	strbuf_addf(&key, "branch.%s.remote", branch);
+	git_config_get_value(key.buf, &remote);
+	strbuf_release(&key);
+	return remote;
+}
+
+/**
+ * Returns upstream branch name for `branch`.
+ */
+static const char *config_get_branch_upstream(const char *branch)
+{
+	struct strbuf key = STRBUF_INIT;
+	const char *upstream = NULL;
+	if (!branch)
+		branch = head_name_short;
+	strbuf_addf(&key, "branch.%s.merge", branch);
+	git_config_get_value(key.buf, &upstream);
+	strbuf_release(&key);
+	return upstream;
+}
+
+static char *get_remote_merge_branch(int argc, const char *argv[])
+{
+	if (argc <= 1) {
+		const char *repo = argc ? argv[0] : "";
+		const char *default_remote = config_get_branch_remote(NULL);
+		if (!default_remote)
+			default_remote = "origin";
+		if (repo[0] == '\0')
+			repo = default_remote;
+		if (!strcmp(repo, default_remote)) {
+			struct branch *branch = branch_get(NULL);
+
+			if (!branch)
+				return NULL;
+			return xstrdup(branch->merge[0]->dst);
+		} else
+			return NULL;
+	} else {
+		const char *repo = argv[0];
+		struct refspec *ref = parse_fetch_refspec(1, &argv[1]);
+		const char *remote;
+		struct strbuf out = STRBUF_INIT;
+		/* FIXME: It should return the tracking branch
+		 * Currently only works with the default mapping */
+		if (ref->src[0] == '\0' || !strcmp(ref->src, "HEAD"))
+			remote = "HEAD";
+		else if (skip_prefix(ref->src, "heads/", &remote))
+			;
+		else if (skip_prefix(ref->src, "refs/heads/", &remote))
+			;
+		else if (starts_with(ref->src, "refs/") ||
+			starts_with(ref->src, "tags/") ||
+			starts_with(ref->src, "remotes/"))
+			remote = "";
+		else
+			remote = ref->src;
+		if (remote[0]) {
+			if (!strcmp(repo, "."))
+				strbuf_addf(&out, "refs/heads/%s", remote);
+			else
+				strbuf_addf(&out, "refs/remotes/%s/%s", repo, remote);
+			return out.buf;
+		}
+		return NULL;
+	}
+}
+
+/* FIXME: The following code is copied (and slightly modified) from
+ * merge-base.c.  Ideally, the functionality should be shared */
+
+struct rev_collect {
+	struct commit **commit;
+	int nr;
+	int alloc;
+	unsigned int initial : 1;
+};
+
+static void add_one_commit(unsigned char *sha1, struct rev_collect *revs)
+{
+	struct commit *commit;
+
+	if (is_null_sha1(sha1))
+		return;
+
+	commit = lookup_commit(sha1);
+	if (!commit ||
+	    (commit->object.flags & TMP_MARK) ||
+	    parse_commit(commit))
+		return;
+
+	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
+	revs->commit[revs->nr++] = commit;
+	commit->object.flags |= TMP_MARK;
+}
+
+static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+				  const char *ident, unsigned long timestamp,
+				  int tz, const char *message, void *cbdata)
+{
+	struct rev_collect *revs = cbdata;
+
+	if (revs->initial) {
+		revs->initial = 0;
+		add_one_commit(osha1, revs);
+	}
+	add_one_commit(nsha1, revs);
+	return 0;
+}
+
+/**
+ * Returns in out_sha1 the point at which a branch leading to commitname forked
+ * from another branch ref. Returns 0 if a fork point was found, 1 if it was
+ * not found.
+ */
+static int fork_point(const char *ref, const char *commitname,
+		unsigned char out_sha1[20])
+{
+	unsigned char sha1[20];
+	char *refname;
+	struct rev_collect revs = {};
+	struct commit *derived;
+	struct commit_list *bases;
+	int i, ret = 0;
+
+	if (!ref)
+		return error("ref is NULL");
+
+	switch(dwim_ref(ref, strlen(ref), sha1, &refname)) {
+	case 0:
+		return error("No such ref: '%s'", ref);
+	case 1:
+		break; /* good */
+	default:
+		return error("Ambiguous refname: '%s'", ref);
+	}
+
+	if (!commitname)
+		commitname = "HEAD";
+
+	if (get_sha1(commitname, sha1))
+		return error("Not a valid object name: '%s'", commitname);
+
+	derived = lookup_commit_reference(sha1);
+
+	revs.initial = 1;
+
+	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
+
+	for (i = 0; i < revs.nr; i++)
+		revs.commit[i]->object.flags &= ~TMP_MARK;
+
+	bases = get_merge_bases_many(derived, revs.nr, revs.commit);
+	/*
+	 * There should be one and only one merge base, when we found
+	 * a common ancestor among reflog entries.
+	 */
+	if (!bases || bases->next) {
+		ret = 1;
+		goto cleanup_return;
+	}
+
+	/* And the found one must be one of the reflog entries */
+	for (i = 0; i < revs.nr; i++)
+		if (&bases->item->object == &revs.commit[i]->object)
+			break; /* found */
+
+	if (revs.nr <= i) {
+		ret = 1;
+		goto cleanup_return;
+	}
+
+	if (out_sha1)
+		hashcpy(out_sha1, bases->item->object.sha1);
+
+cleanup_return:
+	free_commit_list(bases);
+	return ret;
+}
+
+/**
+ * Appends FETCH_HEAD's merge heads into arr. Returns number of merge heads,
+ * or -1 on error.
+ */
+static int sha1_array_append_fetch_merge_heads(struct sha1_array *arr)
+{
+	int num_heads = 0;
+	char *filename = git_path("FETCH_HEAD");
+	FILE *fp = fopen(filename, "r");
+	if (!fp) {
+		error(_("cannot open %s: %s\n"), filename, strerror(errno));
+		return -1;
+	}
+	for (;;) {
+		unsigned char sha1[20];
+		char sha1_text[40];
+		char text[128];
+		int c, ret;
+
+		ret = fscanf(fp, "%40c %127[^\n]", sha1_text, text);
+
+		if (ret == EOF)
+			break;
+		else if (ret != 2) {
+			error(_("error parsing %s"), filename);
+			fclose(fp);
+			return -1;
+		}
+		/* Read until the next newline */
+		for (;;) {
+			c = fgetc(fp);
+			if (c == '\n' || c == EOF)
+				break;
+		}
+		/* Skip over merge heads that are marked not-for-merge */
+		if (strstr(text, "not-for-merge"))
+			continue;
+		/* Parse SHA1 */
+		if (get_sha1_hex(sha1_text, sha1)) {
+			error(_("failed to parse SHA1 from %s"), filename);
+			fclose(fp);
+			return -1;
+		}
+		sha1_array_append(arr, sha1);
+		num_heads ++;
+	}
+	fclose(fp);
+	return num_heads;
+}
+
+static int get_octopus_merge_base(const struct sha1_array *rev_sha1s,
+		unsigned char merge_base_sha1[20])
+{
+	struct commit_list *revs = NULL, *result;
+	int i;
+	for (i = rev_sha1s->nr - 1; i >= 0; i--)
+		commit_list_insert(lookup_commit_reference(rev_sha1s->sha1[i]), &revs);
+	result = reduce_heads(get_octopus_merge_bases(revs));
+	free_commit_list(revs);
+	if (!result)
+		return 1;
+	if (merge_base_sha1)
+		hashcpy(merge_base_sha1, result->item->object.sha1);
+	return 0;
+}
+
+static void argv_array_push_verbosity(struct argv_array *arr, int verbosity)
+{
+	while (verbosity) {
+		if (verbosity < 0) {
+			argv_array_push(arr, "-q");
+			verbosity++;
+		} else if (verbosity > 0) {
+			argv_array_push(arr, "-v");
+			verbosity--;
+		}
+	}
+}
+
+static void argv_array_push_strategies(struct argv_array *arr,
+		const struct string_list *strategies)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, strategies)
+		argv_array_pushl(arr, "-s", item->string, NULL);
+}
+
+
+static void argv_array_push_merge_args(struct argv_array *arr,
+		const struct string_list *merge_args)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, merge_args)
+		argv_array_pushl(arr, "-X", item->string, NULL);
+}
+
+
+static void argv_array_push_rs(struct argv_array *arr, int recurse_submodules)
+{
+	switch (recurse_submodules) {
+	case RS_NO:
+		argv_array_push(arr, "--no-recurse-submodules");
+		break;
+	case RS_YES:
+		argv_array_push(arr, "--recurse-submodules");
+		break;
+	case RS_ON_DEMAND:
+		argv_array_push(arr, "--recurse-submodules=on-demand");
+		break;
+	}
+}
+
+static void argv_array_push_ff(struct argv_array *arr, int ff)
+{
+	switch(ff) {
+	case FF_NO:
+		argv_array_push(arr, "--no-ff");
+		break;
+	case FF_ALLOW:
+		argv_array_push(arr, "--ff");
+		break;
+	case FF_ONLY:
+		argv_array_push(arr, "--ff-only");
+		break;
+	}
+}
+
+static void argv_array_push_gpg_sign(struct argv_array *arr,
+		const char *gpg_sign)
+{
+	struct strbuf arg = STRBUF_INIT;
+	if (!gpg_sign)
+		return;
+	strbuf_addf(&arg, "-S%s", gpg_sign);
+	argv_array_push(arr, arg.buf);
+	strbuf_release(&arg);
+}
+
+static void argv_array_push_shortlog_len(struct argv_array *arr,
+		int shortlog_len)
+{
+	struct strbuf arg = STRBUF_INIT;
+	strbuf_addf(&arg, "--log=%d", shortlog_len);
+	argv_array_push(arr, arg.buf);
+	strbuf_release(&arg);
+}
+
+static int error_on_no_merge_candidates(int argc, const char *argv[])
+{
+	const char *op_type, *op_prep, *upstream, *remote;
+
+	op_type = opt_rebase ? "rebase" : "merge";
+	op_prep = opt_rebase ? "against" : "with";
+
+	upstream = config_get_branch_upstream(NULL);
+	if (upstream)
+		skip_prefix(upstream, "refs/heads/", &upstream);
+	remote = config_get_branch_remote(NULL);
+	if (!remote)
+		remote = "origin";
+	if (argc > 1) {
+		if (opt_rebase)
+			fprintf(stderr, "There is no candidate for rebasing against ");
+		else
+			fprintf(stderr, "There are no candidates for merging ");
+		fputs("among the refs that you just fetched.\n"
+			"Generally this means that you provided a wildcard refspec which had no\n"
+			"matches on the remote end.\n", stderr);
+	} else if (argc > 0 && strcmp(argv[0], remote))
+		fprintf(stderr, _("You asked to pull from the remote '%s', but did not specify\n"
+			"a branch. Because this is not the default configured remote\n"
+			"for your current branch, you must specify a branch on the command line.\n"), argv[0]);
+	else if (is_null_sha1(head_sha1) || !upstream)
+		fprintf(stderr, _("There is no tracking information for the current branch.\n"
+			"Please specify which branch you want to %s %s\n"
+			"See git-pull(1) for details\n\n"
+			"\tgit pull <remote> <branch>\n\n"
+			"If you wish to set tracking information for this branch you can do so with:\n\n"
+			"\tgit branch --set-upstream-to=%s/<branch> %s\n"),
+			op_type, op_prep, remote, head_name_short);
+	else
+		fprintf(stderr, _("Your configuration specified to %s %s the ref '%s'\n"
+			"from the remote, but no such ref was fetched.\n"),
+			op_type, op_prep, upstream);
+	return 1;
+}
+
+int cmd_pull(int argc, const char *argv[], const char *prefix)
+{
+	struct argv_array cmd_args = ARGV_ARRAY_INIT;
+	unsigned char oldremoteref[20] = {0};
+	unsigned char orig_head_sha1[20];
+	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
+	struct strbuf merge_name = STRBUF_INIT;
+	int i, ret = 0, reflog_msg_set = 0;
+
+	opt_prefix = prefix;
+
+	git_config(git_diff_basic_config, NULL);
+
+	if (read_cache() < 0)
+		return 1;
+
+	if (unmerged_cache())
+		return error_conflict();
+
+	if (file_exists(git_path("MERGE_HEAD")))
+		return error_merge();
+
+	head_name = resolve_refdup("HEAD", 0, head_sha1, &head_flags);
+	if (!head_name)
+		return error(_("could not resolve ref HEAD"));
+	if (!skip_prefix(head_name, "refs/heads/", &head_name_short))
+		head_name_short = head_name;
+
+	/* Set reflog message */
+	if (!getenv("GIT_REFLOG_ACTION")) {
+		struct strbuf msg = STRBUF_INIT;
+		strbuf_addf(&msg, "pull ");
+		for (i = 1; i < argc; i++)
+			strbuf_add(&msg, argv[i], strlen(argv[i]));
+		msg.buf[msg.len - 1] = '\0'; /* Remove trailing space */
+		if (!setenv("GIT_REFLOG_ACTION", msg.buf, 1))
+			reflog_msg_set = 1;
+		strbuf_release(&msg);
+	}
+
+	git_config(fmt_merge_msg_config, NULL);
+
+	opt_shortlog_len = merge_log_config;
+	opt_ff = ff_config_default();
+	opt_rebase = rebase_config_default();
+
+	argc = parse_options(argc, argv, prefix, builtin_pull_options,
+			builtin_pull_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	if (opt_rebase) {
+		char *remote_ref;
+
+		if (is_null_sha1(head_sha1)) {
+			/* If on unborn branch, index must be unborn as well */
+			if (!is_cache_unborn())
+				die(_("updating an unborn branch with changes added to the index"));
+		} else {
+			if ((ret = require_clean_work_tree(_("pull with rebase"), _("Please commit or stash them."))))
+				goto cleanup;
+		}
+		remote_ref = get_remote_merge_branch(argc, argv);
+		if (remote_ref) {
+			if (fork_point(remote_ref, head_name, oldremoteref))
+				hashclr(oldremoteref);
+			free(remote_ref);
+		}
+	}
+
+	/* Before running git-fetch, store original head SHA1 */
+	hashcpy(orig_head_sha1, head_sha1);
+
+	/* Run git-fetch */
+	argv_array_push(&cmd_args, "fetch");
+	argv_array_push_verbosity(&cmd_args, opt_verbosity);
+	if (opt_progress >= 0)
+		argv_array_push(&cmd_args, opt_progress ? "--progress" : "--no-progress");
+	argv_array_push(&cmd_args, opt_dry_run ? "--dry-run" : "--no-dry-run");
+	argv_array_push_rs(&cmd_args, opt_recurse_submodules);
+	argv_array_push(&cmd_args, "--update-head-ok");
+	for (i = 0; i < argc; i++)
+		argv_array_push(&cmd_args, argv[i]);
+	if (cmd_fetch(cmd_args.argc, cmd_args.argv, opt_prefix)) {
+		ret = 1;
+		goto cleanup;
+	}
+	/* FIXME: cmd_fetch frees strings in argv */
+	argv_array_init(&cmd_args);
+
+	if (opt_dry_run)
+		goto cleanup;
+
+	/* Get current head SHA1 */
+	head_name = resolve_refdup("HEAD", 0, head_sha1, &head_flags);
+
+	if (!is_null_sha1(orig_head_sha1) && hashcmp(head_sha1, orig_head_sha1)) {
+		/* The fetch involved updating the current branch.
+		 * The working tree and the index file is still based on
+		 * orig_head_sha1 commit, but we are merging into head_sha1.
+		 * First update the working tree to match head_sha1
+		 */
+		warning(_("fetch updated the current branch head"));
+		warning(_("fast-forwarding your working tree from commit %s"),
+				sha1_to_hex(orig_head_sha1));
+		refresh_and_write_cache();
+		/* TODO: Need to catch die() and write the user-friendly
+		 * recovery message */
+		argv_array_pushl(&cmd_args, "read-tree", "-u", "-m", NULL);
+		argv_array_push(&cmd_args, sha1_to_hex(orig_head_sha1));
+		argv_array_push(&cmd_args, sha1_to_hex(head_sha1));
+		if ((ret = cmd_read_tree(cmd_args.argc, cmd_args.argv, opt_prefix)))
+			goto cleanup;
+		argv_array_clear(&cmd_args);
+	}
+
+	/* Read merge heads from FETCH_HEAD */
+	if (sha1_array_append_fetch_merge_heads(&merge_heads) < 0) {
+		ret = 1;
+		goto cleanup;
+	}
+
+	if (merge_heads.nr == 0) {
+		ret = error_on_no_merge_candidates(argc, argv);
+		goto cleanup;
+	} else if (merge_heads.nr > 1) {
+		if (is_null_sha1(orig_head_sha1)) {
+			ret = error(_("Cannot merge multiple branches into empty head"));
+			goto cleanup;
+		} else if (opt_rebase) {
+			ret = error(_("Cannot rebase into multiple branches"));
+			goto cleanup;
+		}
+	}
+
+	/* Pulling into unborn branch: a shorthand for branching off
+	 * FETCH_HEAD, for lazy typers */
+	if (is_null_sha1(orig_head_sha1)) {
+		/* Two-way merge: we claim the index is based on an empty tree,
+		 * and try to fast-forward to HEAD. This ensures we will not
+		 * lose index/worktree changes that the user already made on
+		 * the unborn branch.
+		 */
+		argv_array_pushl(&cmd_args, "read-tree", "-u", "-m",
+				EMPTY_TREE_SHA1_HEX,
+				sha1_to_hex(merge_heads.sha1[0]), NULL);
+		if ((ret = cmd_read_tree(cmd_args.argc, cmd_args.argv, opt_prefix)))
+			goto cleanup;
+		/* FIXME: read_tree */
+		argv_array_init(&cmd_args); /* argv_array_clear(&cmd_args) */
+		argv_array_pushl(&cmd_args, "update-ref", "-m", "initial pull",
+				"HEAD", NULL);
+		argv_array_push(&cmd_args, sha1_to_hex(merge_heads.sha1[0]));
+		argv_array_push(&cmd_args, sha1_to_hex(head_sha1));
+		ret = cmd_update_ref(cmd_args.argc, cmd_args.argv, opt_prefix);
+		goto cleanup;
+	}
+	if (opt_rebase) {
+		struct sha1_array octopus_merge_heads = SHA1_ARRAY_INIT;
+		unsigned char octopus_merge_base[20];
+
+		sha1_array_append(&octopus_merge_heads, head_sha1);
+		sha1_array_append(&octopus_merge_heads, merge_heads.sha1[0]);
+		if (!is_null_sha1(oldremoteref))
+			sha1_array_append(&octopus_merge_heads, oldremoteref);
+		if (get_octopus_merge_base(&octopus_merge_heads, octopus_merge_base)) {
+			ret = error(_("could not get octopus merge base"));
+			sha1_array_clear(&octopus_merge_heads);
+			goto cleanup;
+		}
+		sha1_array_clear(&octopus_merge_heads);
+		if (!hashcmp(octopus_merge_base, oldremoteref))
+			hashclr(oldremoteref);
+	}
+	/* fmt-merge-msg */
+	{
+		struct fmt_merge_msg_opts opts = {0};
+		FILE *fp;
+		char *filename = git_path("FETCH_HEAD");
+		struct strbuf input = STRBUF_INIT;
+		opts.add_title = 1;
+		opts.credit_people = 1;
+		opts.shortlog_len = opt_shortlog_len;
+		fp = fopen(filename, "r");
+		if (!fp) {
+			ret = error(_("cannot open %s: %s\n"), filename, strerror(errno));
+			goto cleanup;
+		}
+		if (strbuf_read(&input, fileno(fp), 0) < 0) {
+			ret = error(_("could not read %s: %s\n"), filename, strerror(errno));
+			goto cleanup;
+		}
+		fclose(fp);
+		if ((ret = fmt_merge_msg(&input, &merge_name, &opts)))
+			goto cleanup;
+	}
+
+	if (opt_rebase) {
+		argv_array_push(&cmd_args, "rebase");
+		if (opt_diffstat >= 0)
+			argv_array_push(&cmd_args, opt_diffstat ? "--stat" : "--no-stat");
+		argv_array_push_strategies(&cmd_args, &opt_merge_strategies);
+		argv_array_push_merge_args(&cmd_args, &opt_merge_strategy_opts);
+		if (opt_rebase == REBASE_PRESERVE)
+			argv_array_push(&cmd_args, "--preserve-merges");
+		argv_array_push_verbosity(&cmd_args, opt_verbosity);
+		argv_array_push_gpg_sign(&cmd_args, opt_gpg_sign);
+		argv_array_push(&cmd_args, "--onto");
+		argv_array_push(&cmd_args, sha1_to_hex(merge_heads.sha1[0]));
+		argv_array_push(&cmd_args, sha1_to_hex(is_null_sha1(oldremoteref) ? merge_heads.sha1[0] : oldremoteref));
+		if (run_command_v_opt(cmd_args.argv, RUN_GIT_CMD)) {
+			ret = 1;
+			goto cleanup;
+		}
+		argv_array_clear(&cmd_args);
+	} else {
+		argv_array_push(&cmd_args, "merge");
+		if (opt_diffstat >= 0)
+			argv_array_push(&cmd_args, opt_diffstat ? "--stat" : "--no-stat");
+		if (opt_commit >= 0)
+			argv_array_push(&cmd_args, opt_commit ? "--commit" : "--no-commit");
+		if (opt_verify_signatures >= 0)
+			argv_array_push(&cmd_args, opt_verify_signatures ? "--verify-signatures" : "--no-verify-signatures");
+		if (opt_edit >= 0)
+			argv_array_push(&cmd_args, opt_edit ? "--edit" : "--no-edit");
+		if (opt_squash >= 0)
+			argv_array_push(&cmd_args, opt_squash ? "--squash" : "--no-squash");
+		argv_array_push_ff(&cmd_args, opt_ff);
+		argv_array_push_shortlog_len(&cmd_args, opt_shortlog_len);
+		argv_array_push_strategies(&cmd_args, &opt_merge_strategies);
+		argv_array_push_merge_args(&cmd_args, &opt_merge_strategy_opts);
+		argv_array_push_verbosity(&cmd_args, opt_verbosity);
+		if (opt_progress >= 0)
+			argv_array_push(&cmd_args, opt_progress ? "--progress" : "--no-progress");
+		argv_array_push_gpg_sign(&cmd_args, opt_gpg_sign);
+		argv_array_pushl(&cmd_args, merge_name.buf, "HEAD", NULL);
+		for (i = 0; i < merge_heads.nr; i++)
+			argv_array_push(&cmd_args, sha1_to_hex(merge_heads.sha1[i]));
+		if ((ret = cmd_merge(cmd_args.argc, cmd_args.argv, opt_prefix)))
+			goto cleanup;
+		/* FIXME: merge */
+		argv_array_init(&cmd_args); /* argv_array_clear(&cmd_args); */
+	}
+cleanup:
+	/* argv_array_clear(&cmd_args); */
+	free(head_name);
+	string_list_clear(&opt_merge_strategies, 0);
+	string_list_clear(&opt_merge_strategy_opts, 0);
+	if (reflog_msg_set)
+		unsetenv("GIT_REFLOG_ACTION");
+	return ret;
+}
diff --git a/git.c b/git.c
index 8c7ee9c..c322b07 100644
--- a/git.c
+++ b/git.c
@@ -443,6 +443,7 @@ static struct cmd_struct commands[] = {
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
+	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE},
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
 	{ "receive-pack", cmd_receive_pack },
-- 
2.1.4
