From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 8/8] Build in rebase
Date: Wed, 18 Mar 2015 16:55:47 +0700
Message-ID: <1426672547-11369-9-git-send-email-pclouds@gmail.com>
References: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 10:57:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYAjF-0003Fj-GE
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 10:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933227AbbCRJ5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 05:57:12 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34196 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933213AbbCRJ5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 05:57:06 -0400
Received: by pdbni2 with SMTP id ni2so38509696pdb.1
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KhuelBSgeAI1gxiWt3nctyL+86JP3ulcPerCQ6E4WwE=;
        b=MwhpNTPufSXPjJx/e27KzT9djNO4unPgIIsMBECNV9mc5N6guuexW3qE3HeD2erChz
         03Y7jTMzCJm15EdOB2fqroQa4kjbmkKodV8QDu81MyYSWCXeR3taHFYANljqiDffvZNh
         gExeDJVBhm7QpW6Nvoinz3RjmU/aFc8vsXUlnctgoi4oTVwnmizryD1OdpUJVsjxT+eF
         EBm+y2DEzIEdhkt0mjZZ9M4+rDM1AbknpTImoDIxOkjkznltSEHcPaLKm5HLzKCQONzb
         w73Tz3MxXD5GOdU/E5SiQgXbPQ18pNwpmoM7nJumaGJn7+ltpl/0JXMFuoEjbZ/D92mX
         3pXA==
X-Received: by 10.66.65.195 with SMTP id z3mr160971344pas.10.1426672626264;
        Wed, 18 Mar 2015 02:57:06 -0700 (PDT)
Received: from lanh ([115.73.252.85])
        by mx.google.com with ESMTPSA id t5sm26628982pde.51.2015.03.18.02.56.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 02:56:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Mar 2015 16:56:46 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1426672547-11369-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265710>

---
 Makefile                                |   2 +-
 builtin.h                               |   1 +
 builtin/rebase.c (new)                  | 752 ++++++++++++++++++++++++++++++++
 commit.c                                |   4 +-
 commit.h                                |   4 +-
 contrib/examples/git-rebase.sh (new +x) | 532 ++++++++++++++++++++++
 git-rebase.sh (gone)                    | 532 ----------------------
 git.c                                   |   1 +
 8 files changed, 1291 insertions(+), 537 deletions(-)
 create mode 100644 builtin/rebase.c
 create mode 100755 contrib/examples/git-rebase.sh
 delete mode 100755 git-rebase.sh

diff --git a/Makefile b/Makefile
index 83972a2..223d50b 100644
--- a/Makefile
+++ b/Makefile
@@ -444,7 +444,6 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
 SCRIPT_SH += git-quiltimport.sh
-SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-rebase--am.sh
 SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase--merge.sh
@@ -903,6 +902,7 @@ BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
+BUILTIN_OBJS += builtin/rebase.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
 BUILTIN_OBJS += builtin/remote.o
diff --git a/builtin.h b/builtin.h
index 7e7bbd6..431bbbf 100644
--- a/builtin.h
+++ b/builtin.h
@@ -108,6 +108,7 @@ extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_rebase(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase.c b/builtin/rebase.c
new file mode 100644
index 0000000..29eff0e
--- /dev/null
+++ b/builtin/rebase.c
@@ -0,0 +1,752 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "argv-array.h"
+#include "run-command.h"
+#include "tree-walk.h"
+#include "unpack-trees.h"
+#include "diff.h"
+#include "commit.h"
+#include "revision.h"
+#include "submodule.h"
+#include "commit.h"
+#include "dir.h"
+
+#define REBASE_AM		1
+#define REBASE_MERGE		2
+#define REBASE_INTERACTIVE	3
+
+static const char * const builtin_rebase_usage[] = {
+	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]"),
+	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]"),
+	N_("git rebase --continue | --abort | --skip | --edit-todo"),
+	NULL
+};
+
+/* These are exported as environment variables for git-rebase--*.sh */
+static int action_abort;
+static int action_continue;
+static int action_skip;
+static int autosquash;
+static int force_rebase;
+static int keep_empty;
+static int preserve_merges;
+static int quiet;
+static int rerere_autoupdate;
+static int root;
+static int verbose;
+static const char *exec_cmd;
+static const char *head_name;
+static const char *onto;
+static const char *orig_head;
+static struct strbuf revisions = STRBUF_INIT;
+static const char *state_basedir;
+static const char *strategy;
+static const char *strategy_opts;
+static const char *switch_to;
+static const char *squash_onto;
+
+static int do_merge;
+static int edit_todo;
+static int interactive_rebase;
+static int rebase_type;
+static int show_stat;
+
+static char *read_file(const char *name)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (strbuf_read_file(&sb,
+			     git_path("%s/%s", state_basedir, name),
+			     0) >= 0)
+		return strbuf_detach(&sb, NULL);
+	else
+		return NULL;
+}
+
+static char *read_file_or_die(const char *name)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_read_file_or_die(&sb,
+				git_path("%s/%s", state_basedir, name),
+				0);
+	return strbuf_detach(&sb, NULL);
+}
+
+static void read_bool(const char *name, int *var)
+{
+	char *buf = read_file(name);
+	if (buf) {
+		*var = buf[0] && !isspace(buf[0]);
+		free(buf);
+	}
+}
+
+static int read_bool_or_die(const char *name)
+{
+	char *buf = read_file_or_die(name);
+	int ret = buf[0] && !isspace(buf[0]);
+	free(buf);
+	return ret;
+}
+
+/*
+ * Note:
+ *
+ * After git-rebase--*.sh are integrated, we should probably adopt
+ * git-config format and store everything in one file instead of so
+ * many like this. state_dir will be something different to avoid
+ * misuse by old rebase versions. This code will stay for a few major
+ * releases before being phased out.
+ */
+static void read_basic_state()
+{
+	head_name = read_file_or_die("head-name");
+	onto = read_file_or_die("onto");
+	/*
+	 * We always write to orig-head, but interactive rebase used
+	 * to write to head. Fall back to reading from head to cover
+	 * for the case that the user upgraded git with an ongoing
+	 * interactive rebase.
+	 */
+	if ((orig_head = read_file("orig-head")) == NULL)
+		orig_head = read_file_or_die("head");
+	quiet = read_bool_or_die("quiet");
+	read_bool("verbose", &verbose);
+	strategy = read_file("strategy");
+	strategy_opts = read_file("strategy_opts");
+	read_bool("allow_rerere_autoupdate", &rerere_autoupdate);
+}
+
+static void push_env_string(struct argv_array *argv,
+			    const char *name,
+			    const char *value)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addf(&sb, "%s=%s", name, value);
+	argv_array_push(argv, sb.buf);
+	strbuf_release(&sb);
+}
+
+static void push_env_bool(struct argv_array *argv,
+			  const char *name,
+			  int value)
+{
+	struct strbuf sb = STRBUF_INIT;
+	strbuf_addf(&sb, "%s=%s", name, value ? "t" : "");
+	argv_array_push(argv, sb.buf);
+	strbuf_release(&sb);
+}
+
+static int run_specific_rebase()
+{
+	struct child_process cmd;
+	struct argv_array env = ARGV_ARRAY_INIT;
+	const char *argv[2];
+	int ret;
+
+	if (interactive_rebase == -1) {
+		argv_array_push(&env, "GIT_EDITOR=:");
+		autosquash = 0;
+	}
+	push_env_bool(&env, "git_quiet", quiet);
+	if (action_continue)
+		argv_array_push(&env, "action=continue");
+	else if (action_skip)
+		argv_array_push(&env, "action=skip");
+	else if (action_abort)
+		argv_array_push(&env, "action=abort");
+	else if (edit_todo)
+		argv_array_push(&env, "action=edit-todo");
+	else
+		argv_array_push(&env, "action=");
+	push_env_bool(&env,   "allow_rerere_autoupdate", rerere_autoupdate);
+	push_env_bool(&env,   "autosquash",              autosquash);
+	push_env_string(&env, "cmd",                     exec_cmd);
+	push_env_bool(&env,   "force_rebase",            force_rebase);
+	push_env_string(&env, "git_am_opt", ""/* git_am_opt */);
+	push_env_string(&env, "head_name",               head_name);
+	push_env_bool(&env,   "keep_empty",              keep_empty);
+	push_env_string(&env, "onto",                    onto);
+	push_env_string(&env, "orig_head",               orig_head);
+	push_env_bool(&env,   "preserve_merges",         preserve_merges);
+	push_env_bool(&env,   "rebase_root",             root);
+	push_env_string(&env, "revisions",               revisions.buf);
+	push_env_string(&env, "squash_onto",             squash_onto);
+	push_env_string(&env, "state_dir", git_path("%s", state_basedir));
+	push_env_string(&env, "strategy", strategy);
+	push_env_string(&env, "strategy_opts", strategy_opts);
+	push_env_string(&env, "switch_to", switch_to);
+	/* upstream */
+	push_env_bool(&env, "verbose", verbose);
+
+	switch (rebase_type) {
+	case REBASE_INTERACTIVE: argv[0] = "rebase--interactive"; break;
+	case REBASE_AM:		 argv[0] = "rebase--am";	  break;
+	case REBASE_MERGE:	 argv[0] = "rebase--merge";	  break;
+	default:
+		die("BUG: unsupported rebase type %d", rebase_type);
+	}
+	argv[1] = NULL;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.in  = 0;
+	cmd.out = 1;
+	cmd.err = 2;
+	cmd.git_cmd = 1;
+	cmd.env = env.argv;
+	cmd.argv = argv;
+	ret = run_command(&cmd);
+	if (ret)
+		die_errno("failed to run %s", argv[0]);
+
+	argv_array_clear(&env);
+	return ret;
+}
+
+static int do_continue()
+{
+	unsigned char sha1[20];
+	if (get_sha1("HEAD", sha1))
+		die(_("Cannot read HEAD"));
+	if (read_cache_unmerged()) {
+		printf(_("You must edit all merge conflicts and then\n"
+			 "mark them as resolved using 'git add'\n"));
+		return 1;
+	}
+	read_basic_state();
+	return run_specific_rebase();
+}
+
+static int do_skip()
+{
+	int ret, error = 0;
+	unsigned char sha1[20];
+	if (get_sha1("HEAD", sha1))
+		die(_("Cannot read HEAD"));
+
+	ret = reset_tree(lookup_commit(sha1)->tree, quiet, 1, &error);
+	if (ret)
+		return ret;
+	read_basic_state();
+	return run_specific_rebase();
+}
+
+static int do_abort()
+{
+	int ret, error = 0;
+	unsigned char sha1[20];
+	const char *rerere[] = { "rerere", "clear", NULL };
+	struct strbuf path = STRBUF_INIT;
+
+	ret = run_command_v_opt(rerere, RUN_GIT_CMD);
+	if (ret)
+		return ret;
+	read_basic_state();
+	if (!prefixcmp(head_name, "refs/"))
+		create_symref("HEAD", head_name, "rebase: aborting");
+
+	if (get_sha1(orig_head, sha1))
+		die(_("Cannot read %s"), orig_head);
+
+	ret = reset_tree(lookup_commit(sha1)->tree, quiet, 1, &error);
+	if (ret)
+		return ret;
+
+	strbuf_addstr(&path, git_path("%s", state_basedir));
+	remove_dir_recursively(&path, 0);
+	strbuf_release(&path);
+	return 0;
+}
+
+static int do_edit_todo()
+{
+	if (rebase_type != REBASE_INTERACTIVE)
+		die(_("The --edit-todo action can only be "
+		      "used during interactive rebase."));
+	return run_specific_rebase();
+}
+
+static void error_on_missing_default_upstream()
+{
+	unsigned char sha1[20];
+	const char *head = resolve_ref_unsafe("HEAD", sha1, 0, NULL);
+	if (!head)
+		die(_("Failed to resolve HEAD as a valid ref."));
+	if (!strcmp(head, "HEAD")) {
+		printf(_("You are not currently on a branch. Please specify which\n"
+			 "branch you want to rebase against. See git-rebase(1) for details.\n"
+			 "\n"
+			 "    git rebase <branch>\n"));
+		return;
+	}
+
+	if (!prefixcmp(head, "refs/heads/"))
+		head += strlen("refs/heads/");
+	printf(_("There is no tracking information for the current branch.\n"
+		 "Please specify which branch you want to rebase against.\n"
+		 "See git-rebase(1) for details\n"
+		 "\n"
+		 "    git rebase <branch>\n"
+		 "\n"
+		 "If you wish to set tracking information for this branch you can do so with:\n"
+		 "\n"
+		 "    git branch --set-upstream-to=$remote/<branch> %s\n"),
+	       head);
+}
+
+static int determine_upstream(int argc, const char **argv,
+			      const struct option *options,
+			      const char **upstream_name,
+			      const char **upstream_arg)
+{
+	int consumed = 0;
+	if (!root) {
+		unsigned char sha1[20];
+		if (argc) {
+			*upstream_name = argv[0];
+			argv++;
+			argc--;
+			consumed++;
+		} else {
+			*upstream_name = "@{upstream}";
+			if (get_sha1(*upstream_name, sha1)) {
+				error_on_missing_default_upstream();
+				exit(1);
+			}
+		}
+		if (get_sha1(*upstream_name, sha1))
+			die(_("Failed to resolve %s."), *upstream_name);
+		lookup_commit_or_die(sha1, *upstream_name);
+		*upstream_arg = *upstream_name;
+		return consumed;
+	}
+
+	if (!onto) {
+		unsigned char sha1[20];
+		struct strbuf sb = STRBUF_INIT;
+		if (commit_tree(&sb, EMPTY_TREE_SHA1_BIN, NULL, sha1, NULL, NULL))
+			die(_("failed to create empty-tree commit"));
+		onto = xstrdup(sha1_to_hex(sha1));
+		squash_onto = onto;
+	}
+	if (argc > 1)
+		usage_with_options(builtin_rebase_usage,
+				   options);
+	*upstream_arg = "--root";
+	return consumed;
+}
+
+static void require_clean_work_tree()
+{
+	struct rev_info rev;
+	unsigned char sha1[20];
+	int err = 0;
+
+	if (get_sha1("HEAD", sha1))
+		die("HEAD is not a valid ref");
+
+	if (read_cache() < 0)
+		die(_("unable to read index file"));
+	refresh_cache(REFRESH_QUIET | REFRESH_IGNORE_SUBMODULES);
+
+	init_revisions(&rev, NULL);
+	DIFF_OPT_SET(&rev.diffopt, QUICK);
+	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	handle_ignore_submodules_arg(&rev.diffopt, "all");
+	diff_setup_done(&rev.diffopt);
+	run_diff_files(&rev, 0);
+	if (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) {
+		fputs(_("Cannot rebase: You have unstaged changes.\n"), stderr);
+		err = 1;
+	}
+
+	init_revisions(&rev, NULL);
+	DIFF_OPT_SET(&rev.diffopt, QUICK);
+	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	handle_ignore_submodules_arg(&rev.diffopt, "all");
+	diff_setup_done(&rev.diffopt);
+	add_head_to_pending(&rev);
+	run_diff_index(&rev, 1);
+	if (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES)) {
+		const char *msg = err ?
+			_("Additionally, your index contains uncommitted changes.\n") :
+			_("Cannot rebase: Your index contains uncommitted changes.\n");
+		fputs(msg, stderr);
+		err = 1;
+	}
+
+	if (err) {
+		fputs(_("Please commit or stash them.\n"), stderr);
+		exit(1);
+	}
+}
+
+static void run_pre_rebase_hook(int argc, const char **argv,
+				const char *upstream_arg)
+{
+	/*
+	if test -z "$ok_to_skip_pre_rebase" &&
+	   test -x "$GIT_DIR/hooks/pre-rebase"
+	then
+		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
+		die "$(gettext "The pre-rebase hook refused to rebase.")"
+	fi
+	 */
+}
+
+static int do_rebase(int argc, const char **argv,
+		     const struct option *options)
+{
+	const char *upstream_name = NULL;
+	const char *upstream_arg = NULL;
+	const char *branch_name;
+	const char *onto_name;
+	unsigned char onto_sha1[20];
+
+	int n;
+	if (root && !onto && !interactive_rebase)
+		interactive_rebase = -1; /* implied */
+
+	if (interactive_rebase) {
+		rebase_type = REBASE_INTERACTIVE;
+		state_basedir = "rebase-merge";
+	} else if (do_merge) {
+		rebase_type = REBASE_MERGE;
+		state_basedir = "rebase-merge";
+	} else {
+		rebase_type = REBASE_AM;
+		state_basedir = "rebase-apply";
+	}
+
+	n = determine_upstream(argc, argv, options,
+			       &upstream_name, &upstream_arg);
+	argc += n;
+	argv += n;
+
+	if (root)
+		upstream_arg = "--root";
+
+	/* Make sure the branch to rebase onto is valid. */
+	onto_name = onto ? onto : upstream_name;
+	if (strstr(onto, "...")) {
+		/*
+case "$onto_name" in
+*...*)
+	if	left=${onto_name%...*} right=${onto_name#*...} &&
+		onto=$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
+	then
+		case "$onto" in
+		?*"$LF"?*)
+			die "$(eval_gettext "\$onto_name: there are more than one merge bases")"
+			;;
+		'')
+			die "$(eval_gettext "\$onto_name: there is no merge base")"
+			;;
+		esac
+	else
+		die "$(eval_gettext "\$onto_name: there is no merge base")"
+	fi
+	;;
+		*/
+	} else {
+		if (get_sha1(onto_name, onto_sha1) || !lookup_commit(onto_sha1))
+			die(_("Does not point to a valid commit: %s"), onto_name);
+	}
+
+	/*
+	 * If the branch to rebase is given, that is the branch we
+	 * will rebase
+	 *
+	 * $branch_name -- branch being rebased, or HEAD (already
+	 * detached)
+	 *
+	 * $orig_head -- commit object name of tip of the branch
+	 * before rebasing
+	 *
+	 * $head_name -- refs/heads/<that-branch> or "detached HEAD"
+	 */
+	switch (argc) {
+	case 1:
+		/* Is it "rebase other $branchname" or "rebase other $commit"? */
+		branch_name = argv[0];
+		switch_to = argv[0];
+		/*
+	if git show-ref --verify --quiet -- "refs/heads/$1" &&
+	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
+	then
+		head_name="refs/heads/$1"
+	elif orig_head=$(git rev-parse -q --verify "$1")
+	then
+		head_name="detached HEAD"
+	else
+		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
+	fi
+	 */
+		break;
+
+	case 0:
+		/*
+	# Do not need to switch branches, we are already on it.
+	if branch_name=`git symbolic-ref -q HEAD`
+	then
+		head_name=$branch_name
+		branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
+	else
+		head_name="detached HEAD"
+		branch_name=HEAD ;# detached
+	fi
+	orig_head=$(git rev-parse --verify "${branch_name}^0") || exit
+		 */
+		break;
+	default:
+		die("BUG: unexpected number of arguments left to parse");
+	}
+
+	require_clean_work_tree();
+
+	/*
+	 * Now we are rebasing commits $upstream..$orig_head (or with
+	 * --root, everything leading up to $orig_head) on top of
+	 * $onto
+	 */
+
+	/*
+	 * Check if we are already based on $onto with linear history,
+	 * but this should be done only when upstream and onto are the
+	 * same and if this is not an interactive rebase.
+	 */
+
+	/*
+mb=$(git merge-base "$onto" "$orig_head")
+if test "$type" != interactive && test "$upstream" = "$onto" &&
+	test "$mb" = "$onto" &&
+	# linear history?
+	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
+then
+	if test -z "$force_rebase"
+	then
+		# Lazily switch to the target branch if needed...
+		test -z "$switch_to" || git checkout "$switch_to" --
+		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		exit 0
+	else
+		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+	fi
+fi
+	*/
+
+	/* If a hook exists, give it a chance to interrupt */
+	run_pre_rebase_hook(argc, argv, upstream_arg);
+
+	/*
+if test -n "$diffstat"
+then
+	if test -n "$verbose"
+	then
+		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
+	fi
+	# We want color (if set), but no pager
+	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
+fi
+	*/
+
+	if (rebase_type == REBASE_INTERACTIVE)
+		return run_specific_rebase();
+
+	/* Detach HEAD and reset the tree */
+	/*
+say "$(gettext "First, rewinding head to replay your work on top of it...")"
+git checkout -q "$onto^0" || die "could not detach HEAD"
+git update-ref ORIG_HEAD $orig_head
+	*/
+
+	/*
+	 * If the $onto is a proper descendant of the tip of the
+	 * branch, then we just fast-forwarded.
+	 */
+	if (!hashcmp(mb, orig_head)) {
+		printf(_("Fast-forwarded %s to %s."), branch_name, onto_name);
+		move_to_original_branch();
+		return 0;
+	}
+
+	if (root)
+		strbuf_addf(&revisions, "%s..%s", onto, orig_head);
+	else
+		strbuf_addf(&revisions, "%s..%s", upstream, orig_head);
+
+	return run_specific_rebase();
+}
+
+static int git_rebase_config(const char *name, const char *value, void *data)
+{
+	if (!strcmp(name, "rebase.stat")) {
+		show_stat = git_config_bool(name, value);
+		return 0;
+	} else if (!strcmp(name, "rebase.autosquash")) {
+		autosquash = git_config_bool(name, value);
+		return 0;
+	}
+	return git_default_config(name, value, data);
+}
+
+int cmd_rebase(int argc, const char **argv, const char *prefix)
+{
+	const char *whitespace_opt = NULL;
+	int committer_date_is_author_date = 0;
+	int context_opt = 0;
+	int ignore_date = 0;
+	int ignore_whitespace = 0;
+	int no_ff = 0;
+	int pre_rebase = 1;
+	struct option options[] = {
+		OPT__VERBOSE(&verbose,
+			     N_("display a diffstat of what changed upstream")),
+		OPT__QUIET(&quiet,
+			   N_("be quiet. implies --no-stat")),
+		OPT_STRING(0, "onto", &onto, "ref",
+			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL('p', "preserve-merges", &preserve_merges,
+			 N_("try to recreate merges instead of ignoring them")),
+		OPT_STRING('s', "stragegy", &strategy, "strategy",
+			   N_("use the given merge strategy")),
+		{ OPTION_SET_INT, 0, "no-ff", &no_ff, NULL,
+		  N_("cherry-pick all commits, even if unchanged"),
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_BOOL('m', "merge", &do_merge,
+			 N_("use merging strategies to rebase")),
+		OPT_BOOL('i', "interactive", &interactive_rebase,
+			 N_("let the user edit the list of commits to rebase")),
+		OPT_STRING('x', "exec", &exec_cmd, "command",
+			   N_("add exec lines after each commit of the editable list")),
+		OPT_BOOL('k', "keep-empty", &keep_empty,
+			 N_("preserve empty commits during rebase")),
+		OPT_BOOL('f', "force-rebase", &force_rebase,
+			 N_("force rebase even if branch is up to date")),
+		OPT_STRING('X', "strategy-options", &strategy_opts, "options",
+			   N_("pass the argument through to the merge strategy")),
+		{ OPTION_SET_INT, 0, "stat", &show_stat, NULL,
+		  N_("display a diffstat of what changed upstream"),
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, 1 },
+		OPT_SET_INT('n', "no-stat", &show_stat,
+			    N_("do not show diffstat of what changed upstream"), 0),
+		OPT_BOOL(0, "verify", &pre_rebase,
+			 N_("allow pre-rebase hook to run")),
+		OPT_BOOL(0, "rerere-autoupdate", &rerere_autoupdate,
+			 N_("allow rerere to update index with resolved conflicts")),
+		OPT_BOOL(0, "root", &root,
+			 N_("rebase all reachable commits up to the root(s)")),
+		OPT_BOOL(0, "autosquash", &autosquash,
+			 N_("move commits that begin with squash!/fixup! under -i")),
+		OPT_BOOL(0, "committer-date-is-author-date", &committer_date_is_author_date,
+			 N_("lie about committer date")),
+		OPT_BOOL(0, "ignore-date", &ignore_date,
+			 N_("use current timestamp for author date")),
+		OPT_STRING(0, "whitespace", &whitespace_opt, "mode",
+			   N_("detect new or modified lines that have whitespace errors")),
+		OPT_INTEGER('C', NULL, &context_opt,
+			    N_("ensure at least <n> lines of context match by 'git apply'")),
+		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
+			 N_("ignore changes in whitespace when finding context")),
+
+		OPT_GROUP("Actions"),
+		OPT_BOOL(0, "continue", &action_continue,
+			 N_("continue")),
+		OPT_BOOL(0, "abort", &action_abort,
+			 N_("abort and check out the original branch")),
+		OPT_BOOL(0, "skip", &action_skip,
+			 N_("skip current patch and continue")),
+		OPT_BOOL(0, "edit-todo", &edit_todo,
+			 N_("edit the todo list during an interactive rebase")),
+		OPT_END()
+	};
+	struct stat st;
+	int action_nr, in_progress;
+
+	if (!stat(git_path("rebase-apply"), &st) && S_ISDIR(st.st_mode)) {
+		if (!access(git_path("rebase-apply/applying"), F_OK))
+			die(_("It looks like git-am is in progress. Cannot rebase."));
+		rebase_type = REBASE_AM;
+		state_basedir = "rebase-apply";
+		in_progress = 1;
+	} else if (!stat(git_path("rebase-merge"), &st) &&
+		   S_ISDIR(st.st_mode)) {
+		if (!access(git_path("rebase-merge/interactive"), F_OK)) {
+			rebase_type = REBASE_INTERACTIVE;
+			interactive_rebase = 1; /* explicit */
+		} else
+			rebase_type = REBASE_MERGE;
+		state_basedir = "rebase-merge";
+		in_progress = 1;
+	} else
+		in_progress = 0;
+
+	git_config(git_rebase_config, NULL);
+	gitmodules_config();
+
+	argc = parse_options(argc, argv, prefix, options,
+			     builtin_rebase_usage, 0);
+
+	action_nr = action_continue + action_skip + action_abort + edit_todo;
+	if ((action_nr != 1 && action_nr != 0) || argc > 2)
+		usage_with_options(builtin_rebase_usage, options);
+
+	if (verbose && quiet)
+		die(_("--quiet and --verbose are incompatible"));
+	else if (verbose)
+		show_stat = 1;
+	else if (quiet)
+		show_stat = 0;
+
+	if (preserve_merges && !interactive_rebase)
+		interactive_rebase = -1; /* implied */
+
+	if (strategy_opts) {
+		if (!strategy)
+			strategy = "recursive";
+		/* validate strategy options */
+	}
+
+	if (strategy)
+		do_merge = 1;
+
+	if (!strcmp(whitespace_opt, "fix") ||
+	    !strcmp(whitespace_opt, "strip") ||
+	    committer_date_is_author_date ||
+	    no_ff)
+		force_rebase = 1;
+
+	if (exec_cmd && interactive_rebase != 1)
+		die(_("The --exec option must be used with the --interactive option"));
+
+	if (action_nr) {
+		if (!in_progress)
+			die(_("No rebase in progress?"));
+		if (rebase_type == REBASE_INTERACTIVE)
+			; /* GIT_REFLOG_ACTION = "rebase -i ($action)" */
+
+		if (action_continue)
+			return do_continue();
+		else if (action_skip)
+			return do_skip();
+		else if (action_abort)
+			return do_abort();
+		else if (edit_todo)
+			return do_edit_todo();
+		else
+			die("BUG: how do you get here?");
+	}
+
+	if (in_progress)
+		die(_("It seems that there is already a %s directory, and\n"
+		      "I wonder if you are in the middle of another rebase. If that is the\n"
+		      "case, please try\n"
+		      "\tgit rebase (--continue | --abort | --skip)\n"
+		      "If that is not the case, please\n"
+		      "\trm -rf \"%s/%s\""
+		      "and run me again. I am stopping in case you still have something\n"
+		      "valuable there."),
+		    state_basedir,
+		    get_git_dir(), state_basedir);
+
+	return do_rebase(argc, argv, options);
+}
diff --git a/commit.c b/commit.c
index e8eb0ae..395a860 100644
--- a/commit.c
+++ b/commit.c
@@ -1135,7 +1135,7 @@ void free_commit_extra_headers(struct commit_extra_header *extra)
 	}
 }
 
-int commit_tree(const struct strbuf *msg, unsigned char *tree,
+int commit_tree(const struct strbuf *msg, const unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author, const char *sign_commit)
 {
@@ -1238,7 +1238,7 @@ static const char commit_utf8_warn[] =
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n";
 
-int commit_tree_extended(const struct strbuf *msg, unsigned char *tree,
+int commit_tree_extended(const struct strbuf *msg, const unsigned char *tree,
 			 struct commit_list *parents, unsigned char *ret,
 			 const char *author, const char *sign_commit,
 			 struct commit_extra_header *extra)
diff --git a/commit.h b/commit.h
index 0f469e5..058886f 100644
--- a/commit.h
+++ b/commit.h
@@ -193,11 +193,11 @@ struct commit_extra_header {
 extern void append_merge_tag_headers(struct commit_list *parents,
 				     struct commit_extra_header ***tail);
 
-extern int commit_tree(const struct strbuf *msg, unsigned char *tree,
+extern int commit_tree(const struct strbuf *msg, const unsigned char *tree,
 		       struct commit_list *parents, unsigned char *ret,
 		       const char *author, const char *sign_commit);
 
-extern int commit_tree_extended(const struct strbuf *msg, unsigned char *tree,
+extern int commit_tree_extended(const struct strbuf *msg, const unsigned char *tree,
 				struct commit_list *parents, unsigned char *ret,
 				const char *author, const char *sign_commit,
 				struct commit_extra_header *);
diff --git a/contrib/examples/git-rebase.sh b/contrib/examples/git-rebase.sh
new file mode 100755
index 0000000..38530e8
--- /dev/null
+++ b/contrib/examples/git-rebase.sh
@@ -0,0 +1,532 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano.
+#
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
+git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
+git-rebase --continue | --abort | --skip | --edit-todo
+--
+ Available options are
+v,verbose!         display a diffstat of what changed upstream
+q,quiet!           be quiet. implies --no-stat
+onto=!             rebase onto given branch instead of upstream
+p,preserve-merges! try to recreate merges instead of ignoring them
+s,strategy=!       use the given merge strategy
+no-ff!             cherry-pick all commits, even if unchanged
+m,merge!           use merging strategies to rebase
+i,interactive!     let the user edit the list of commits to rebase
+x,exec=!           add exec lines after each commit of the editable list
+k,keep-empty	   preserve empty commits during rebase
+f,force-rebase!    force rebase even if branch is up to date
+X,strategy-option=! pass the argument through to the merge strategy
+stat!              display a diffstat of what changed upstream
+n,no-stat!         do not show diffstat of what changed upstream
+verify             allow pre-rebase hook to run
+rerere-autoupdate  allow rerere to update index with resolved conflicts
+root!              rebase all reachable commits up to the root(s)
+autosquash         move commits that begin with squash!/fixup! under -i
+committer-date-is-author-date! passed to 'git am'
+ignore-date!       passed to 'git am'
+whitespace=!       passed to 'git apply'
+ignore-whitespace! passed to 'git apply'
+C=!                passed to 'git apply'
+ Actions:
+continue!          continue
+abort!             abort and check out the original branch
+skip!              skip current patch and continue
+edit-todo!         edit the todo list during an interactive rebase
+"
+. git-sh-setup
+. git-sh-i18n
+set_reflog_action rebase
+require_work_tree_exists
+cd_to_toplevel
+
+LF='
+'
+ok_to_skip_pre_rebase=
+unset onto
+cmd=
+strategy=
+strategy_opts=
+do_merge=
+merge_dir="$GIT_DIR"/rebase-merge
+apply_dir="$GIT_DIR"/rebase-apply
+verbose=
+diffstat=
+test "$(git config --bool rebase.stat)" = true && diffstat=t
+git_am_opt=
+rebase_root=
+force_rebase=
+allow_rerere_autoupdate=
+# Non-empty if a rebase was in progress when 'git rebase' was invoked
+in_progress=
+# One of {am, merge, interactive}
+type=
+# One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
+state_dir=
+# One of {'', continue, skip, abort}, as parsed from command line
+action=
+preserve_merges=
+autosquash=
+keep_empty=
+test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+
+read_basic_state () {
+	head_name=$(cat "$state_dir"/head-name) &&
+	onto=$(cat "$state_dir"/onto) &&
+	# We always write to orig-head, but interactive rebase used to write to
+	# head. Fall back to reading from head to cover for the case that the
+	# user upgraded git with an ongoing interactive rebase.
+	if test -f "$state_dir"/orig-head
+	then
+		orig_head=$(cat "$state_dir"/orig-head)
+	else
+		orig_head=$(cat "$state_dir"/head)
+	fi &&
+	GIT_QUIET=$(cat "$state_dir"/quiet) &&
+	test -f "$state_dir"/verbose && verbose=t
+	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
+	test -f "$state_dir"/strategy_opts &&
+		strategy_opts="$(cat "$state_dir"/strategy_opts)"
+	test -f "$state_dir"/allow_rerere_autoupdate &&
+		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
+}
+
+output () {
+	case "$verbose" in
+	'')
+		output=$("$@" 2>&1 )
+		status=$?
+		test $status != 0 && printf "%s\n" "$output"
+		return $status
+		;;
+	*)
+		"$@"
+		;;
+	esac
+}
+
+move_to_original_branch () {
+	case "$head_name" in
+	refs/*)
+		message="rebase finished: $head_name onto $onto"
+		git update-ref -m "$message" \
+			$head_name $(git rev-parse HEAD) $orig_head &&
+		git symbolic-ref \
+			-m "rebase finished: returning to $head_name" \
+			HEAD $head_name ||
+		die "$(gettext "Could not move back to $head_name")"
+		;;
+	esac
+}
+
+run_specific_rebase () {
+	if [ "$interactive_rebase" = implied ]; then
+		GIT_EDITOR=:
+		export GIT_EDITOR
+		autosquash=
+	fi
+	git_quiet=$GIT_QUIET
+	export GIT_PAGER
+	export action allow_rerere_autoupdate git_am_opt git_quiet head_name keep_empty
+	export onto orig_head rebase_root revisions
+	export state_dir verbose strategy strategy_opts
+	export autosquash cmd force_rebase preserve_merges squash_onto switch_to upstream
+	exec git-rebase--$type
+}
+
+run_pre_rebase_hook () {
+	if test -z "$ok_to_skip_pre_rebase" &&
+	   test -x "$GIT_DIR/hooks/pre-rebase"
+	then
+		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
+		die "$(gettext "The pre-rebase hook refused to rebase.")"
+	fi
+}
+
+test -f "$apply_dir"/applying &&
+	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
+
+if test -d "$apply_dir"
+then
+	type=am
+	state_dir="$apply_dir"
+elif test -d "$merge_dir"
+then
+	if test -f "$merge_dir"/interactive
+	then
+		type=interactive
+		interactive_rebase=explicit
+	else
+		type=merge
+	fi
+	state_dir="$merge_dir"
+fi
+test -n "$type" && in_progress=t
+
+total_argc=$#
+while test $# != 0
+do
+	case "$1" in
+	--no-verify)
+		ok_to_skip_pre_rebase=yes
+		;;
+	--verify)
+		ok_to_skip_pre_rebase=
+		;;
+	--continue|--skip|--abort|--edit-todo)
+		test $total_argc -eq 2 || usage
+		action=${1##--}
+		;;
+	--onto)
+		test 2 -le "$#" || usage
+		onto="$2"
+		shift
+		;;
+	-x)
+		test 2 -le "$#" || usage
+		cmd="${cmd}exec $2${LF}"
+		shift
+		;;
+	-i)
+		interactive_rebase=explicit
+		;;
+	-k)
+		keep_empty=yes
+		;;
+	-p)
+		preserve_merges=t
+		test -z "$interactive_rebase" && interactive_rebase=implied
+		;;
+	--autosquash)
+		autosquash=t
+		;;
+	--no-autosquash)
+		autosquash=
+		;;
+	-M|-m)
+		do_merge=t
+		;;
+	-X)
+		shift
+		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$1")"
+		do_merge=t
+		test -z "$strategy" && strategy=recursive
+		;;
+	-s)
+		shift
+		strategy="$1"
+		do_merge=t
+		;;
+	-n)
+		diffstat=
+		;;
+	--stat)
+		diffstat=t
+		;;
+	-v)
+		verbose=t
+		diffstat=t
+		GIT_QUIET=
+		;;
+	-q)
+		GIT_QUIET=t
+		git_am_opt="$git_am_opt -q"
+		verbose=
+		diffstat=
+		;;
+	--whitespace)
+		shift
+		git_am_opt="$git_am_opt --whitespace=$1"
+		case "$1" in
+		fix|strip)
+			force_rebase=t
+			;;
+		esac
+		;;
+	--ignore-whitespace)
+		git_am_opt="$git_am_opt $1"
+		;;
+	--committer-date-is-author-date|--ignore-date)
+		git_am_opt="$git_am_opt $1"
+		force_rebase=t
+		;;
+	-C)
+		shift
+		git_am_opt="$git_am_opt -C$1"
+		;;
+	--root)
+		rebase_root=t
+		;;
+	-f|--no-ff)
+		force_rebase=t
+		;;
+	--rerere-autoupdate|--no-rerere-autoupdate)
+		allow_rerere_autoupdate="$1"
+		;;
+	--)
+		shift
+		break
+		;;
+	esac
+	shift
+done
+test $# -gt 2 && usage
+
+if test -n "$cmd" &&
+   test "$interactive_rebase" != explicit
+then
+	die "$(gettext "The --exec option must be used with the --interactive option")"
+fi
+
+if test -n "$action"
+then
+	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
+	# Only interactive rebase uses detailed reflog messages
+	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
+	then
+		GIT_REFLOG_ACTION="rebase -i ($action)"
+		export GIT_REFLOG_ACTION
+	fi
+fi
+
+if test "$action" = "edit-todo" && test "$type" != "interactive"
+then
+	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
+fi
+
+case "$action" in
+continue)
+	# Sanity check
+	git rev-parse --verify HEAD >/dev/null ||
+		die "$(gettext "Cannot read HEAD")"
+	git update-index --ignore-submodules --refresh &&
+	git diff-files --quiet --ignore-submodules || {
+		echo "$(gettext "You must edit all merge conflicts and then
+mark them as resolved using git add")"
+		exit 1
+	}
+	read_basic_state
+	run_specific_rebase
+	;;
+skip)
+	output git reset --hard HEAD || exit $?
+	read_basic_state
+	run_specific_rebase
+	;;
+abort)
+	git rerere clear
+	read_basic_state
+	case "$head_name" in
+	refs/*)
+		git symbolic-ref -m "rebase: aborting" HEAD $head_name ||
+		die "$(eval_gettext "Could not move back to \$head_name")"
+		;;
+	esac
+	output git reset --hard $orig_head
+	rm -r "$state_dir"
+	exit
+	;;
+edit-todo)
+	run_specific_rebase
+	;;
+esac
+
+# Make sure no rebase is in progress
+if test -n "$in_progress"
+then
+	state_dir_base=${state_dir##*/}
+	cmd_live_rebase="git rebase (--continue | --abort | --skip)"
+	cmd_clear_stale_rebase="rm -fr \"$state_dir\""
+	die "
+$(eval_gettext 'It seems that there is already a $state_dir_base directory, and
+I wonder if you are in the middle of another rebase.  If that is the
+case, please try
+	$cmd_live_rebase
+If that is not the case, please
+	$cmd_clear_stale_rebase
+and run me again.  I am stopping in case you still have something
+valuable there.')"
+fi
+
+if test -n "$rebase_root" && test -z "$onto"
+then
+	test -z "$interactive_rebase" && interactive_rebase=implied
+fi
+
+if test -n "$interactive_rebase"
+then
+	type=interactive
+	state_dir="$merge_dir"
+elif test -n "$do_merge"
+then
+	type=merge
+	state_dir="$merge_dir"
+else
+	type=am
+	state_dir="$apply_dir"
+fi
+
+if test -z "$rebase_root"
+then
+	case "$#" in
+	0)
+		if ! upstream_name=$(git rev-parse --symbolic-full-name \
+			--verify -q @{upstream} 2>/dev/null)
+		then
+			. git-parse-remote
+			error_on_missing_default_upstream "rebase" "rebase" \
+				"against" "git rebase <branch>"
+		fi
+		;;
+	*)	upstream_name="$1"
+		shift
+		;;
+	esac
+	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+	die "$(eval_gettext "invalid upstream \$upstream_name")"
+	upstream_arg="$upstream_name"
+else
+	if test -z "$onto"
+	then
+		empty_tree=`git hash-object -t tree /dev/null`
+		onto=`git commit-tree $empty_tree </dev/null`
+		squash_onto="$onto"
+	fi
+	unset upstream_name
+	unset upstream
+	test $# -gt 1 && usage
+	upstream_arg=--root
+fi
+
+# Make sure the branch to rebase onto is valid.
+onto_name=${onto-"$upstream_name"}
+case "$onto_name" in
+*...*)
+	if	left=${onto_name%...*} right=${onto_name#*...} &&
+		onto=$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
+	then
+		case "$onto" in
+		?*"$LF"?*)
+			die "$(eval_gettext "\$onto_name: there are more than one merge bases")"
+			;;
+		'')
+			die "$(eval_gettext "\$onto_name: there is no merge base")"
+			;;
+		esac
+	else
+		die "$(eval_gettext "\$onto_name: there is no merge base")"
+	fi
+	;;
+*)
+	onto=$(git rev-parse --verify "${onto_name}^0") ||
+	die "$(eval_gettext "Does not point to a valid commit: \$onto_name")"
+	;;
+esac
+
+# If the branch to rebase is given, that is the branch we will rebase
+# $branch_name -- branch being rebased, or HEAD (already detached)
+# $orig_head -- commit object name of tip of the branch before rebasing
+# $head_name -- refs/heads/<that-branch> or "detached HEAD"
+switch_to=
+case "$#" in
+1)
+	# Is it "rebase other $branchname" or "rebase other $commit"?
+	branch_name="$1"
+	switch_to="$1"
+
+	if git show-ref --verify --quiet -- "refs/heads/$1" &&
+	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
+	then
+		head_name="refs/heads/$1"
+	elif orig_head=$(git rev-parse -q --verify "$1")
+	then
+		head_name="detached HEAD"
+	else
+		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
+	fi
+	;;
+0)
+	# Do not need to switch branches, we are already on it.
+	if branch_name=`git symbolic-ref -q HEAD`
+	then
+		head_name=$branch_name
+		branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
+	else
+		head_name="detached HEAD"
+		branch_name=HEAD ;# detached
+	fi
+	orig_head=$(git rev-parse --verify "${branch_name}^0") || exit
+	;;
+*)
+	die "BUG: unexpected number of arguments left to parse"
+	;;
+esac
+
+require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
+
+# Now we are rebasing commits $upstream..$orig_head (or with --root,
+# everything leading up to $orig_head) on top of $onto
+
+# Check if we are already based on $onto with linear history,
+# but this should be done only when upstream and onto are the same
+# and if this is not an interactive rebase.
+mb=$(git merge-base "$onto" "$orig_head")
+if test "$type" != interactive && test "$upstream" = "$onto" &&
+	test "$mb" = "$onto" &&
+	# linear history?
+	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
+then
+	if test -z "$force_rebase"
+	then
+		# Lazily switch to the target branch if needed...
+		test -z "$switch_to" || git checkout "$switch_to" --
+		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+		exit 0
+	else
+		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+	fi
+fi
+
+# If a hook exists, give it a chance to interrupt
+run_pre_rebase_hook "$upstream_arg" "$@"
+
+if test -n "$diffstat"
+then
+	if test -n "$verbose"
+	then
+		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
+	fi
+	# We want color (if set), but no pager
+	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
+fi
+
+test "$type" = interactive && run_specific_rebase
+
+# Detach HEAD and reset the tree
+say "$(gettext "First, rewinding head to replay your work on top of it...")"
+git checkout -q "$onto^0" || die "could not detach HEAD"
+git update-ref ORIG_HEAD $orig_head
+
+# If the $onto is a proper descendant of the tip of the branch, then
+# we just fast-forwarded.
+if test "$mb" = "$orig_head"
+then
+	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
+	move_to_original_branch
+	exit 0
+fi
+
+if test -n "$rebase_root"
+then
+	revisions="$onto..$orig_head"
+else
+	revisions="$upstream..$orig_head"
+fi
+
+run_specific_rebase
diff --git a/git-rebase.sh b/git-rebase.sh
deleted file mode 100755
index 38530e8..0000000
--- a/git-rebase.sh
+++ /dev/null
@@ -1,532 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano.
-#
-
-SUBDIRECTORY_OK=Yes
-OPTIONS_KEEPDASHDASH=
-OPTIONS_SPEC="\
-git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] [<branch>]
-git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]
-git-rebase --continue | --abort | --skip | --edit-todo
---
- Available options are
-v,verbose!         display a diffstat of what changed upstream
-q,quiet!           be quiet. implies --no-stat
-onto=!             rebase onto given branch instead of upstream
-p,preserve-merges! try to recreate merges instead of ignoring them
-s,strategy=!       use the given merge strategy
-no-ff!             cherry-pick all commits, even if unchanged
-m,merge!           use merging strategies to rebase
-i,interactive!     let the user edit the list of commits to rebase
-x,exec=!           add exec lines after each commit of the editable list
-k,keep-empty	   preserve empty commits during rebase
-f,force-rebase!    force rebase even if branch is up to date
-X,strategy-option=! pass the argument through to the merge strategy
-stat!              display a diffstat of what changed upstream
-n,no-stat!         do not show diffstat of what changed upstream
-verify             allow pre-rebase hook to run
-rerere-autoupdate  allow rerere to update index with resolved conflicts
-root!              rebase all reachable commits up to the root(s)
-autosquash         move commits that begin with squash!/fixup! under -i
-committer-date-is-author-date! passed to 'git am'
-ignore-date!       passed to 'git am'
-whitespace=!       passed to 'git apply'
-ignore-whitespace! passed to 'git apply'
-C=!                passed to 'git apply'
- Actions:
-continue!          continue
-abort!             abort and check out the original branch
-skip!              skip current patch and continue
-edit-todo!         edit the todo list during an interactive rebase
-"
-. git-sh-setup
-. git-sh-i18n
-set_reflog_action rebase
-require_work_tree_exists
-cd_to_toplevel
-
-LF='
-'
-ok_to_skip_pre_rebase=
-unset onto
-cmd=
-strategy=
-strategy_opts=
-do_merge=
-merge_dir="$GIT_DIR"/rebase-merge
-apply_dir="$GIT_DIR"/rebase-apply
-verbose=
-diffstat=
-test "$(git config --bool rebase.stat)" = true && diffstat=t
-git_am_opt=
-rebase_root=
-force_rebase=
-allow_rerere_autoupdate=
-# Non-empty if a rebase was in progress when 'git rebase' was invoked
-in_progress=
-# One of {am, merge, interactive}
-type=
-# One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
-state_dir=
-# One of {'', continue, skip, abort}, as parsed from command line
-action=
-preserve_merges=
-autosquash=
-keep_empty=
-test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
-
-read_basic_state () {
-	head_name=$(cat "$state_dir"/head-name) &&
-	onto=$(cat "$state_dir"/onto) &&
-	# We always write to orig-head, but interactive rebase used to write to
-	# head. Fall back to reading from head to cover for the case that the
-	# user upgraded git with an ongoing interactive rebase.
-	if test -f "$state_dir"/orig-head
-	then
-		orig_head=$(cat "$state_dir"/orig-head)
-	else
-		orig_head=$(cat "$state_dir"/head)
-	fi &&
-	GIT_QUIET=$(cat "$state_dir"/quiet) &&
-	test -f "$state_dir"/verbose && verbose=t
-	test -f "$state_dir"/strategy && strategy="$(cat "$state_dir"/strategy)"
-	test -f "$state_dir"/strategy_opts &&
-		strategy_opts="$(cat "$state_dir"/strategy_opts)"
-	test -f "$state_dir"/allow_rerere_autoupdate &&
-		allow_rerere_autoupdate="$(cat "$state_dir"/allow_rerere_autoupdate)"
-}
-
-output () {
-	case "$verbose" in
-	'')
-		output=$("$@" 2>&1 )
-		status=$?
-		test $status != 0 && printf "%s\n" "$output"
-		return $status
-		;;
-	*)
-		"$@"
-		;;
-	esac
-}
-
-move_to_original_branch () {
-	case "$head_name" in
-	refs/*)
-		message="rebase finished: $head_name onto $onto"
-		git update-ref -m "$message" \
-			$head_name $(git rev-parse HEAD) $orig_head &&
-		git symbolic-ref \
-			-m "rebase finished: returning to $head_name" \
-			HEAD $head_name ||
-		die "$(gettext "Could not move back to $head_name")"
-		;;
-	esac
-}
-
-run_specific_rebase () {
-	if [ "$interactive_rebase" = implied ]; then
-		GIT_EDITOR=:
-		export GIT_EDITOR
-		autosquash=
-	fi
-	git_quiet=$GIT_QUIET
-	export GIT_PAGER
-	export action allow_rerere_autoupdate git_am_opt git_quiet head_name keep_empty
-	export onto orig_head rebase_root revisions
-	export state_dir verbose strategy strategy_opts
-	export autosquash cmd force_rebase preserve_merges squash_onto switch_to upstream
-	exec git-rebase--$type
-}
-
-run_pre_rebase_hook () {
-	if test -z "$ok_to_skip_pre_rebase" &&
-	   test -x "$GIT_DIR/hooks/pre-rebase"
-	then
-		"$GIT_DIR/hooks/pre-rebase" ${1+"$@"} ||
-		die "$(gettext "The pre-rebase hook refused to rebase.")"
-	fi
-}
-
-test -f "$apply_dir"/applying &&
-	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
-
-if test -d "$apply_dir"
-then
-	type=am
-	state_dir="$apply_dir"
-elif test -d "$merge_dir"
-then
-	if test -f "$merge_dir"/interactive
-	then
-		type=interactive
-		interactive_rebase=explicit
-	else
-		type=merge
-	fi
-	state_dir="$merge_dir"
-fi
-test -n "$type" && in_progress=t
-
-total_argc=$#
-while test $# != 0
-do
-	case "$1" in
-	--no-verify)
-		ok_to_skip_pre_rebase=yes
-		;;
-	--verify)
-		ok_to_skip_pre_rebase=
-		;;
-	--continue|--skip|--abort|--edit-todo)
-		test $total_argc -eq 2 || usage
-		action=${1##--}
-		;;
-	--onto)
-		test 2 -le "$#" || usage
-		onto="$2"
-		shift
-		;;
-	-x)
-		test 2 -le "$#" || usage
-		cmd="${cmd}exec $2${LF}"
-		shift
-		;;
-	-i)
-		interactive_rebase=explicit
-		;;
-	-k)
-		keep_empty=yes
-		;;
-	-p)
-		preserve_merges=t
-		test -z "$interactive_rebase" && interactive_rebase=implied
-		;;
-	--autosquash)
-		autosquash=t
-		;;
-	--no-autosquash)
-		autosquash=
-		;;
-	-M|-m)
-		do_merge=t
-		;;
-	-X)
-		shift
-		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--$1")"
-		do_merge=t
-		test -z "$strategy" && strategy=recursive
-		;;
-	-s)
-		shift
-		strategy="$1"
-		do_merge=t
-		;;
-	-n)
-		diffstat=
-		;;
-	--stat)
-		diffstat=t
-		;;
-	-v)
-		verbose=t
-		diffstat=t
-		GIT_QUIET=
-		;;
-	-q)
-		GIT_QUIET=t
-		git_am_opt="$git_am_opt -q"
-		verbose=
-		diffstat=
-		;;
-	--whitespace)
-		shift
-		git_am_opt="$git_am_opt --whitespace=$1"
-		case "$1" in
-		fix|strip)
-			force_rebase=t
-			;;
-		esac
-		;;
-	--ignore-whitespace)
-		git_am_opt="$git_am_opt $1"
-		;;
-	--committer-date-is-author-date|--ignore-date)
-		git_am_opt="$git_am_opt $1"
-		force_rebase=t
-		;;
-	-C)
-		shift
-		git_am_opt="$git_am_opt -C$1"
-		;;
-	--root)
-		rebase_root=t
-		;;
-	-f|--no-ff)
-		force_rebase=t
-		;;
-	--rerere-autoupdate|--no-rerere-autoupdate)
-		allow_rerere_autoupdate="$1"
-		;;
-	--)
-		shift
-		break
-		;;
-	esac
-	shift
-done
-test $# -gt 2 && usage
-
-if test -n "$cmd" &&
-   test "$interactive_rebase" != explicit
-then
-	die "$(gettext "The --exec option must be used with the --interactive option")"
-fi
-
-if test -n "$action"
-then
-	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
-	# Only interactive rebase uses detailed reflog messages
-	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
-	then
-		GIT_REFLOG_ACTION="rebase -i ($action)"
-		export GIT_REFLOG_ACTION
-	fi
-fi
-
-if test "$action" = "edit-todo" && test "$type" != "interactive"
-then
-	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
-fi
-
-case "$action" in
-continue)
-	# Sanity check
-	git rev-parse --verify HEAD >/dev/null ||
-		die "$(gettext "Cannot read HEAD")"
-	git update-index --ignore-submodules --refresh &&
-	git diff-files --quiet --ignore-submodules || {
-		echo "$(gettext "You must edit all merge conflicts and then
-mark them as resolved using git add")"
-		exit 1
-	}
-	read_basic_state
-	run_specific_rebase
-	;;
-skip)
-	output git reset --hard HEAD || exit $?
-	read_basic_state
-	run_specific_rebase
-	;;
-abort)
-	git rerere clear
-	read_basic_state
-	case "$head_name" in
-	refs/*)
-		git symbolic-ref -m "rebase: aborting" HEAD $head_name ||
-		die "$(eval_gettext "Could not move back to \$head_name")"
-		;;
-	esac
-	output git reset --hard $orig_head
-	rm -r "$state_dir"
-	exit
-	;;
-edit-todo)
-	run_specific_rebase
-	;;
-esac
-
-# Make sure no rebase is in progress
-if test -n "$in_progress"
-then
-	state_dir_base=${state_dir##*/}
-	cmd_live_rebase="git rebase (--continue | --abort | --skip)"
-	cmd_clear_stale_rebase="rm -fr \"$state_dir\""
-	die "
-$(eval_gettext 'It seems that there is already a $state_dir_base directory, and
-I wonder if you are in the middle of another rebase.  If that is the
-case, please try
-	$cmd_live_rebase
-If that is not the case, please
-	$cmd_clear_stale_rebase
-and run me again.  I am stopping in case you still have something
-valuable there.')"
-fi
-
-if test -n "$rebase_root" && test -z "$onto"
-then
-	test -z "$interactive_rebase" && interactive_rebase=implied
-fi
-
-if test -n "$interactive_rebase"
-then
-	type=interactive
-	state_dir="$merge_dir"
-elif test -n "$do_merge"
-then
-	type=merge
-	state_dir="$merge_dir"
-else
-	type=am
-	state_dir="$apply_dir"
-fi
-
-if test -z "$rebase_root"
-then
-	case "$#" in
-	0)
-		if ! upstream_name=$(git rev-parse --symbolic-full-name \
-			--verify -q @{upstream} 2>/dev/null)
-		then
-			. git-parse-remote
-			error_on_missing_default_upstream "rebase" "rebase" \
-				"against" "git rebase <branch>"
-		fi
-		;;
-	*)	upstream_name="$1"
-		shift
-		;;
-	esac
-	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
-	die "$(eval_gettext "invalid upstream \$upstream_name")"
-	upstream_arg="$upstream_name"
-else
-	if test -z "$onto"
-	then
-		empty_tree=`git hash-object -t tree /dev/null`
-		onto=`git commit-tree $empty_tree </dev/null`
-		squash_onto="$onto"
-	fi
-	unset upstream_name
-	unset upstream
-	test $# -gt 1 && usage
-	upstream_arg=--root
-fi
-
-# Make sure the branch to rebase onto is valid.
-onto_name=${onto-"$upstream_name"}
-case "$onto_name" in
-*...*)
-	if	left=${onto_name%...*} right=${onto_name#*...} &&
-		onto=$(git merge-base --all ${left:-HEAD} ${right:-HEAD})
-	then
-		case "$onto" in
-		?*"$LF"?*)
-			die "$(eval_gettext "\$onto_name: there are more than one merge bases")"
-			;;
-		'')
-			die "$(eval_gettext "\$onto_name: there is no merge base")"
-			;;
-		esac
-	else
-		die "$(eval_gettext "\$onto_name: there is no merge base")"
-	fi
-	;;
-*)
-	onto=$(git rev-parse --verify "${onto_name}^0") ||
-	die "$(eval_gettext "Does not point to a valid commit: \$onto_name")"
-	;;
-esac
-
-# If the branch to rebase is given, that is the branch we will rebase
-# $branch_name -- branch being rebased, or HEAD (already detached)
-# $orig_head -- commit object name of tip of the branch before rebasing
-# $head_name -- refs/heads/<that-branch> or "detached HEAD"
-switch_to=
-case "$#" in
-1)
-	# Is it "rebase other $branchname" or "rebase other $commit"?
-	branch_name="$1"
-	switch_to="$1"
-
-	if git show-ref --verify --quiet -- "refs/heads/$1" &&
-	   orig_head=$(git rev-parse -q --verify "refs/heads/$1")
-	then
-		head_name="refs/heads/$1"
-	elif orig_head=$(git rev-parse -q --verify "$1")
-	then
-		head_name="detached HEAD"
-	else
-		die "$(eval_gettext "fatal: no such branch: \$branch_name")"
-	fi
-	;;
-0)
-	# Do not need to switch branches, we are already on it.
-	if branch_name=`git symbolic-ref -q HEAD`
-	then
-		head_name=$branch_name
-		branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
-	else
-		head_name="detached HEAD"
-		branch_name=HEAD ;# detached
-	fi
-	orig_head=$(git rev-parse --verify "${branch_name}^0") || exit
-	;;
-*)
-	die "BUG: unexpected number of arguments left to parse"
-	;;
-esac
-
-require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
-
-# Now we are rebasing commits $upstream..$orig_head (or with --root,
-# everything leading up to $orig_head) on top of $onto
-
-# Check if we are already based on $onto with linear history,
-# but this should be done only when upstream and onto are the same
-# and if this is not an interactive rebase.
-mb=$(git merge-base "$onto" "$orig_head")
-if test "$type" != interactive && test "$upstream" = "$onto" &&
-	test "$mb" = "$onto" &&
-	# linear history?
-	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
-then
-	if test -z "$force_rebase"
-	then
-		# Lazily switch to the target branch if needed...
-		test -z "$switch_to" || git checkout "$switch_to" --
-		say "$(eval_gettext "Current branch \$branch_name is up to date.")"
-		exit 0
-	else
-		say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
-	fi
-fi
-
-# If a hook exists, give it a chance to interrupt
-run_pre_rebase_hook "$upstream_arg" "$@"
-
-if test -n "$diffstat"
-then
-	if test -n "$verbose"
-	then
-		echo "$(eval_gettext "Changes from \$mb to \$onto:")"
-	fi
-	# We want color (if set), but no pager
-	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
-fi
-
-test "$type" = interactive && run_specific_rebase
-
-# Detach HEAD and reset the tree
-say "$(gettext "First, rewinding head to replay your work on top of it...")"
-git checkout -q "$onto^0" || die "could not detach HEAD"
-git update-ref ORIG_HEAD $orig_head
-
-# If the $onto is a proper descendant of the tip of the branch, then
-# we just fast-forwarded.
-if test "$mb" = "$orig_head"
-then
-	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
-	move_to_original_branch
-	exit 0
-fi
-
-if test -n "$rebase_root"
-then
-	revisions="$onto..$orig_head"
-else
-	revisions="$upstream..$orig_head"
-fi
-
-run_specific_rebase
diff --git a/git.c b/git.c
index ed66c66..a4cb4a8 100644
--- a/git.c
+++ b/git.c
@@ -379,6 +379,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
+		{ "rebase", cmd_rebase, RUN_SETUP | NEED_WORK_TREE },
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
-- 
2.3.0.rc1.137.g477eb31
