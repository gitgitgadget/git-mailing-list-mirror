Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA2F2013E
	for <e@80x24.org>; Fri,  3 Mar 2017 02:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdCCCEq (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 21:04:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:60525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751261AbdCCCES (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 21:04:18 -0500
Received: from virtualbox ([89.204.153.4]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnxVE-1c3hBP0iSW-00g2ru; Fri, 03
 Mar 2017 03:03:59 +0100
Date:   Fri, 3 Mar 2017 03:03:56 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 0/9] Fix the early config
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1488506615.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tUTRzSgRPmRxGrRNXS99artZEF6xNz9UfvRZJH6wl1WiSU8cjvg
 t/K/nin0kv7iFZx3Wwc5jJrKNt8PfCdefvWtMm1hQJw5hijttWvN40DFJElCPeNd9zgwPY6
 xiuTZJs9Fz3E8teKGSHzfHG/z+nOQyZbxIqOOeIq856elh0ZBaIqVPEap5mhx7OimdwsVe6
 9O/snr6naVSP5qqLwSisg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W82pnT72nA8=:ptSiSbmti4N76eawU7SFUr
 k0oQL0n2O2zxCtlbW6Ghoy18gFtTpuMbWg+qhw9yEt6yDJiY/EOe76G0wb6TSYStakLQ1vFPC
 rV8PNB1FhhcoP6WW2+2X6Fx0iPhEEHAHA5BvdfTw6DH9fm3uaVBsVV1nwAkibi8rCrEudkpGj
 ZbFRdeijdsbww2H6FvpBIz+BJ5cVkhRfvlwdeQeygeBWd4OAYJW5kigG2/kab/u2uEmxUztVl
 PnJ8Llop1WMiz6iD6PUZ+cHhHPj9LklRbDVDi1SJ10rWHaiJah9ONi5Ov0YyEXfXo6SUMQETE
 KfvLXDFSTomesr6QV79I2EhKwiAyidCPyMzkEgG292+D1qC5CCRxeXJlMwu1gUk1OkpkXHgqw
 ubvwwLJQtTz5I40Bnvh0UOb+AgWqOLvkMr7JHK6Cg58yCk+0wo2hOfS8QOHKVxLrKoAkXka0A
 OyMGqQU3BTNN7kl+7WeEUndnaHcnPRYWw1S0HjPRNnOzIf0ulvMH2Yyz6Ec1TnR4hhjDY1VaQ
 tZF9ALmqeTjFZm8NM6/8gLe7a///vZJJbyfOhRyoOBStn5cb5WYbrSGHOinN/Gnodzt1uf69U
 dJ7yxhfG2MjW/TIqf0jFVjuE8eFQA/yWkbII4w5iEANPUz+yqV1aHfSEOWghCtV16XRkWZpcv
 qYLCeD45hy4lS3tinlLTWAicCe/G/OP8mj3pkqPCYBD9uPhFqGJ5qQ5AIbsA+KULotA6gAkOs
 qIQ/NACRvPEONNG5sfdK1HrePWEbNtB1qkQ+up9tswcleB2yubPIEqyBeyxTT6x1UlFau2H9o
 toFyR//
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are an attempt to make Git's startup sequence a bit less
surprising.

The idea here is to discover the .git/ directory gently (i.e. without
changing the current working directory, or global variables), and to use
it to read the .git/config file early, before we actually called
setup_git_directory() (if we ever do that).

This also allows us to fix the early config e.g. to determine the pager
or to resolve aliases in a non-surprising manner.

The first iteration of this patch series still tried to be clever and to
avoid having to disentangle the side effects from the
setup_git_directory_gently_1() function simply by duplicating the logic.

However, Peff suggested in a very short sentence that this would not fly
well.

Little did I know that I would spend the better part of an entire week
on trying to address that innocuous comment! There are simply *so many*
side effects in that code. Who would have thought that a function
called check_repository_format() would set global variables?

But after all that work, I am actually quite a bit satisfied with the
way things turned out.

My dirty little secret is that I actually need this for something else
entirely. I need to patch an internal version of Git to gather
statistics, and to that end I need to read the config before and after
running every Git command. Hence the need for a gentle, and correct
early config.

Notes:

- I do not handle dashed invocations of `init` and `clone` correctly.
  That is, even if `git-init` and `git-clone` clearly do not want to
  read the local config, they do. It does not matter all that much
  because they do not use a pager, but still. It is a wart.

- The read_early_config() function is still called multiple times,
  re-reading all the config files and re-discovering the .git/ directory
  multiple times, which is quite wasteful. I was tempted to take care of
  that but I must not run the danger to spread myself even thinner these
  days. If a patch adding that caching were to fly my way, I'd gladly
  integrate it, of course... ;-)

Changes since v1:

- the discover_git_directory() function is no longer completely separate
  from setup_git_directory(), but a callee of the latter.

- t7006 succeeds now (I removed the incorrect test case in favor of one
  that verifies that setup_git_directory() was not run via the tell-tale
  that the current working directory has not changed when the pager
  runs).


Johannes Schindelin (9):
  t7006: replace dubious test
  setup_git_directory(): use is_dir_sep() helper
  setup_git_directory(): avoid changing global state during discovery
  Export the discover_git_directory() function
  Make read_early_config() reusable
  read_early_config(): special-case builtins that create a repository
  read_early_config(): avoid .git/config hack when unneeded
  read_early_config(): really discover .git/
  Test read_early_config()

 cache.h                 |   4 +-
 config.c                |  36 +++++++++
 git.c                   |   3 +
 pager.c                 |  31 -------
 setup.c                 | 211 +++++++++++++++++++++++++++++++-----------------
 t/helper/test-config.c  |  15 ++++
 t/t1309-early-config.sh |  50 ++++++++++++
 t/t7006-pager.sh        |  18 ++++-
 8 files changed, 257 insertions(+), 111 deletions(-)
 create mode 100755 t/t1309-early-config.sh


base-commit: 3bc53220cb2dcf709f7a027a3f526befd021d858
Published-As: https://github.com/dscho/git/releases/tag/early-config-v2
Fetch-It-Via: git fetch https://github.com/dscho/git early-config-v2

Interdiff vs v1:

 diff --git a/builtin/am.c b/builtin/am.c
 index 2b81dabddd9..f7a7a971fbe 100644
 --- a/builtin/am.c
 +++ b/builtin/am.c
 @@ -1791,7 +1791,7 @@ static int do_interactive(struct am_state *state)
  			}
  			strbuf_release(&msg);
  		} else if (*reply == 'v' || *reply == 'V') {
 -			const char *pager = git_pager(1, 1);
 +			const char *pager = git_pager(1);
  			struct child_process cp = CHILD_PROCESS_INIT;
  
  			if (!pager)
 diff --git a/builtin/blame.c b/builtin/blame.c
 index 628ca237da6..cffc6265408 100644
 --- a/builtin/blame.c
 +++ b/builtin/blame.c
 @@ -2919,7 +2919,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
  	assign_blame(&sb, opt);
  
  	if (!incremental)
 -		setup_pager(1);
 +		setup_pager();
  
  	free(final_commit_name);
  
 diff --git a/builtin/grep.c b/builtin/grep.c
 index f820e4b1c4d..9304c33e750 100644
 --- a/builtin/grep.c
 +++ b/builtin/grep.c
 @@ -1133,7 +1133,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
  	}
  
  	if (show_in_pager == default_pager)
 -		show_in_pager = git_pager(1, 1);
 +		show_in_pager = git_pager(1);
  	if (show_in_pager) {
  		opt.color = 0;
  		opt.name_only = 1;
 @@ -1268,7 +1268,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
  		die(_("option not supported with --recurse-submodules."));
  
  	if (!show_in_pager && !opt.status_only)
 -		setup_pager(1);
 +		setup_pager();
  
  	if (!use_index && (untracked || cached))
  		die(_("--cached or --untracked cannot be used with --no-index."));
 diff --git a/builtin/log.c b/builtin/log.c
 index 96618d38cbf..55d20cc2d88 100644
 --- a/builtin/log.c
 +++ b/builtin/log.c
 @@ -203,7 +203,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
  	if (rev->line_level_traverse)
  		line_log_init(rev, line_cb.prefix, &line_cb.args);
  
 -	setup_pager(1);
 +	setup_pager();
  }
  
  static void cmd_log_init(int argc, const char **argv, const char *prefix,
 @@ -1600,7 +1600,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
  	if (!use_stdout)
  		output_directory = set_outdir(prefix, output_directory);
  	else
 -		setup_pager(1);
 +		setup_pager();
  
  	if (output_directory) {
  		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
 diff --git a/builtin/var.c b/builtin/var.c
 index 879867b8427..aedbb53a2da 100644
 --- a/builtin/var.c
 +++ b/builtin/var.c
 @@ -19,7 +19,7 @@ static const char *editor(int flag)
  
  static const char *pager(int flag)
  {
 -	const char *pgm = git_pager(1, 1);
 +	const char *pgm = git_pager(1);
  
  	if (!pgm)
  		pgm = "cat";
 diff --git a/cache.h b/cache.h
 index 4d89966d711..0af7141242f 100644
 --- a/cache.h
 +++ b/cache.h
 @@ -518,6 +518,7 @@ extern void set_git_work_tree(const char *tree);
  #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
  
  extern void setup_work_tree(void);
 +extern const char *discover_git_directory(struct strbuf *gitdir);
  extern const char *setup_git_directory_gently(int *);
  extern const char *setup_git_directory(void);
  extern char *prefix_path(const char *prefix, int len, const char *path);
 @@ -1428,7 +1429,7 @@ extern const char *fmt_name(const char *name, const char *email);
  extern const char *ident_default_name(void);
  extern const char *ident_default_email(void);
  extern const char *git_editor(void);
 -extern const char *git_pager(int stdout_is_tty, int discover_git_dir);
 +extern const char *git_pager(int stdout_is_tty);
  extern int git_ident_config(const char *, const char *, void *);
  extern void reset_ident_date(void);
  
 @@ -1797,8 +1798,7 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
  				     const unsigned char *sha1, void *data);
  extern void git_config_push_parameter(const char *text);
  extern int git_config_from_parameters(config_fn_t fn, void *data);
 -extern void read_early_config(config_fn_t cb, void *data,
 -			      int discover_git_dir);
 +extern void read_early_config(config_fn_t cb, void *data);
  extern void git_config(config_fn_t fn, void *);
  extern int git_config_with_options(config_fn_t fn, void *,
  				   struct git_config_source *config_source,
 @@ -1994,12 +1994,12 @@ __attribute__((format (printf, 2, 3)))
  extern void write_file(const char *path, const char *fmt, ...);
  
  /* pager.c */
 -extern void setup_pager(int discover_git_dir);
 +extern void setup_pager(void);
  extern int pager_in_use(void);
  extern int pager_use_color;
  extern int term_columns(void);
  extern int decimal_width(uintmax_t);
 -extern int check_pager_config(const char *cmd, int discover_git_dir);
 +extern int check_pager_config(const char *cmd);
  extern void prepare_pager_args(struct child_process *, const char *pager);
  
  extern const char *editor_program;
 @@ -2070,7 +2070,7 @@ const char *split_cmdline_strerror(int cmdline_errno);
  
  /* setup.c */
  struct startup_info {
 -	int have_repository;
 +	int have_repository, creating_repository;
  	const char *prefix;
  };
  extern struct startup_info *startup_info;
 diff --git a/config.c b/config.c
 index c9f191e1fe3..bcda397d42e 100644
 --- a/config.c
 +++ b/config.c
 @@ -1412,106 +1412,32 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
  	}
  }
  
 -/*
 - * A "string_list_each_func_t" function that canonicalizes an entry
 - * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
 - * discards it if unusable.  The presence of an empty entry in
 - * GIT_CEILING_DIRECTORIES turns off canonicalization for all
 - * subsequent entries.
 - */
 -static int canonicalize_ceiling_entry(struct string_list_item *item,
 -				      void *cb_data)
 -{
 -	int *empty_entry_found = cb_data;
 -	char *ceil = item->string;
 -
 -	if (!*ceil) {
 -		*empty_entry_found = 1;
 -		return 0;
 -	} else if (!is_absolute_path(ceil)) {
 -		return 0;
 -	} else if (*empty_entry_found) {
 -		/* Keep entry but do not canonicalize it */
 -		return 1;
 -	} else {
 -		const char *real_path = real_path_if_valid(ceil);
 -		if (!real_path)
 -			return 0;
 -		free(item->string);
 -		item->string = xstrdup(real_path);
 -		return 1;
 -	}
 -}
 -
 -/*
 - * Note that this is a really dirty hack that replicates what the
 - * setup_git_directory() function does, without changing the current
 - * working directory. The crux of the problem is that we cannot run
 - * setup_git_directory() early on in git's setup, so we have to
 - * duplicate the work that setup_git_directory() would otherwise do.
 - */
 -static int discover_git_directory_gently(struct strbuf *result)
 -{
 -	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 -	int ceiling_offset = -1;
 -	const char *p;
 -
 -	if (strbuf_getcwd(result) < 0)
 -		return -1;
 -	p = real_path_if_valid(result->buf);
 -	if (!p)
 -		return -1;
 -	strbuf_reset(result);
 -	strbuf_addstr(result, p);
 -
 -	if (env_ceiling_dirs) {
 -		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
 -		int empty_entry_found = 0;
 -
 -		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP,
 -				  -1);
 -		filter_string_list(&ceiling_dirs, 0, canonicalize_ceiling_entry,
 -				   &empty_entry_found);
 -		ceiling_offset = longest_ancestor_length(result->buf,
 -							 &ceiling_dirs);
 -		string_list_clear(&ceiling_dirs, 0);
 -	}
 -
 -	if (ceiling_offset < 0 && has_dos_drive_prefix(result->buf))
 -		ceiling_offset = 1;
 -
 -	for (;;) {
 -		int len = result->len, i;
 -
 -		strbuf_addstr(result, "/" DEFAULT_GIT_DIR_ENVIRONMENT);
 -		p = read_gitfile_gently(result->buf, &i);
 -		if (p) {
 -			strbuf_reset(result);
 -			strbuf_addstr(result, p);
 -			return 0;
 -		}
 -		if (is_git_directory(result->buf))
 -			return 0;
 -		strbuf_setlen(result, len);
 -		if (is_git_directory(result->buf))
 -			return 0;
 -		for (i = len; --i > ceiling_offset; )
 -			if (is_dir_sep(result->buf[i]))
 -				break;
 -		if (i <= ceiling_offset)
 -			return -1;
 -		strbuf_setlen(result, i);
 -	}
 -}
 -
 -void read_early_config(config_fn_t cb, void *data, int discover_git_dir)
 +void read_early_config(config_fn_t cb, void *data)
  {
  	struct strbuf buf = STRBUF_INIT;
  
  	git_config_with_options(cb, data, NULL, 1);
  
 -	if (discover_git_dir && !have_git_dir() &&
 -	    !discover_git_directory_gently(&buf)) {
 +	/*
 +	 * Note that this is a really dirty hack that does the wrong thing in
 +	 * many cases. The crux of the problem is that we cannot run
 +	 * setup_git_directory() early on in git's setup, so we have no idea if
 +	 * we are in a repository or not, and therefore are not sure whether
 +	 * and how to read repository-local config.
 +	 *
 +	 * So if we _aren't_ in a repository (or we are but we would reject its
 +	 * core.repositoryformatversion), we'll read whatever is in .git/config
 +	 * blindly. Similarly, if we _are_ in a repository, but not at the
 +	 * root, we'll fail to find .git/config (because it's really
 +	 * ../.git/config, etc). See t7006 for a complete set of failures.
 +	 *
 +	 * However, we have historically provided this hack because it does
 +	 * work some of the time (namely when you are at the top-level of a
 +	 * valid repository), and would rarely make things worse (i.e., you do
 +	 * not generally have a .git/config file sitting around).
 +	 */
 +	if (!startup_info->creating_repository && !have_git_dir() &&
 +	    discover_git_directory(&buf)) {
  		struct git_config_source repo_config;
  
  		memset(&repo_config, 0, sizeof(repo_config));
 diff --git a/diff.c b/diff.c
 index 1e1d3b85c2a..051761be405 100644
 --- a/diff.c
 +++ b/diff.c
 @@ -5259,6 +5259,6 @@ void setup_diff_pager(struct diff_options *opt)
  	 * --exit-code" in hooks and other scripts, we do not do so.
  	 */
  	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
 -	    check_pager_config("diff", 1) != 0)
 -		setup_pager(1);
 +	    check_pager_config("diff") != 0)
 +		setup_pager();
  }
 diff --git a/git.c b/git.c
 index d4712b25fee..9fb9bb90a21 100644
 --- a/git.c
 +++ b/git.c
 @@ -61,13 +61,13 @@ static void restore_env(int external_alias)
  	}
  }
  
 -static void commit_pager_choice(int discover_git_dir) {
 +static void commit_pager_choice(void) {
  	switch (use_pager) {
  	case 0:
  		setenv("GIT_PAGER", "cat", 1);
  		break;
  	case 1:
 -		setup_pager(discover_git_dir);
 +		setup_pager();
  		break;
  	default:
  		break;
 @@ -261,7 +261,7 @@ static int handle_alias(int *argcp, const char ***argv)
  		if (alias_string[0] == '!') {
  			struct child_process child = CHILD_PROCESS_INIT;
  
 -			commit_pager_choice(1);
 +			commit_pager_choice();
  			restore_env(1);
  
  			child.use_shell = 1;
 @@ -318,13 +318,12 @@ static int handle_alias(int *argcp, const char ***argv)
  #define RUN_SETUP		(1<<0)
  #define RUN_SETUP_GENTLY	(1<<1)
  #define USE_PAGER		(1<<2)
 -#define CREATES_GIT_DIR         (1<<3)
  /*
   * require working tree to be present -- anything uses this needs
   * RUN_SETUP for reading from the configuration file.
   */
 -#define NEED_WORK_TREE		(1<<4)
 -#define SUPPORT_SUPER_PREFIX	(1<<5)
 +#define NEED_WORK_TREE		(1<<3)
 +#define SUPPORT_SUPER_PREFIX	(1<<4)
  
  struct cmd_struct {
  	const char *cmd;
 @@ -338,6 +337,9 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
  	struct stat st;
  	const char *prefix;
  
 +	if (p->fn == cmd_init_db || p->fn == cmd_clone)
 +		startup_info->creating_repository = 1;
 +
  	prefix = NULL;
  	help = argc == 2 && !strcmp(argv[1], "-h");
  	if (!help) {
 @@ -349,7 +351,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
  		}
  
  		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY))
 -			use_pager = check_pager_config(p->cmd, !(p->option & CREATES_GIT_DIR));
 +			use_pager = check_pager_config(p->cmd);
  		if (use_pager == -1 && p->option & USE_PAGER)
  			use_pager = 1;
  
 @@ -357,7 +359,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
  		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
  			trace_repo_setup(prefix);
  	}
 -	commit_pager_choice(!(p->option & CREATES_GIT_DIR));
 +	commit_pager_choice();
  
  	if (!help && get_super_prefix()) {
  		if (!(p->option & SUPPORT_SUPER_PREFIX))
 @@ -413,7 +415,7 @@ static struct cmd_struct commands[] = {
  	{ "cherry", cmd_cherry, RUN_SETUP },
  	{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
  	{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 -	{ "clone", cmd_clone, CREATES_GIT_DIR },
 +	{ "clone", cmd_clone },
  	{ "column", cmd_column, RUN_SETUP_GENTLY },
  	{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
  	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 @@ -440,7 +442,7 @@ static struct cmd_struct commands[] = {
  	{ "hash-object", cmd_hash_object },
  	{ "help", cmd_help },
  	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
 -	{ "init", cmd_init_db, CREATES_GIT_DIR },
 +	{ "init", cmd_init_db },
  	{ "init-db", cmd_init_db },
  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
  	{ "log", cmd_log, RUN_SETUP },
 @@ -585,8 +587,8 @@ static void execv_dashed_external(const char **argv)
  		die("%s doesn't support --super-prefix", argv[0]);
  
  	if (use_pager == -1)
 -		use_pager = check_pager_config(argv[0], 1);
 -	commit_pager_choice(1);
 +		use_pager = check_pager_config(argv[0]);
 +	commit_pager_choice();
  
  	argv_array_pushf(&cmd.args, "git-%s", argv[0]);
  	argv_array_pushv(&cmd.args, argv + 1);
 @@ -684,7 +686,7 @@ int cmd_main(int argc, const char **argv)
  		skip_prefix(argv[0], "--", &argv[0]);
  	} else {
  		/* The user didn't specify a command; give them help */
 -		commit_pager_choice(1);
 +		commit_pager_choice();
  		printf("usage: %s\n\n", git_usage_string);
  		list_common_cmds_help();
  		printf("\n%s\n", _(git_more_info_string));
 diff --git a/pager.c b/pager.c
 index 16b3cbe2320..73ca8bc3b17 100644
 --- a/pager.c
 +++ b/pager.c
 @@ -43,7 +43,7 @@ static int core_pager_config(const char *var, const char *value, void *data)
  	return 0;
  }
  
 -const char *git_pager(int stdout_is_tty, int discover_git_dir)
 +const char *git_pager(int stdout_is_tty)
  {
  	const char *pager;
  
 @@ -53,8 +53,7 @@ const char *git_pager(int stdout_is_tty, int discover_git_dir)
  	pager = getenv("GIT_PAGER");
  	if (!pager) {
  		if (!pager_program)
 -			read_early_config(core_pager_config, NULL,
 -					  discover_git_dir);
 +			read_early_config(core_pager_config, NULL);
  		pager = pager_program;
  	}
  	if (!pager)
 @@ -101,9 +100,9 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
  	setup_pager_env(&pager_process->env_array);
  }
  
 -void setup_pager(int discover_git_dir)
 +void setup_pager(void)
  {
 -	const char *pager = git_pager(isatty(1), discover_git_dir);
 +	const char *pager = git_pager(isatty(1));
  
  	if (!pager)
  		return;
 @@ -209,7 +208,7 @@ static int pager_command_config(const char *var, const char *value, void *vdata)
  }
  
  /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
 -int check_pager_config(const char *cmd, int discover_git_dir)
 +int check_pager_config(const char *cmd)
  {
  	struct pager_command_config_data data;
  
 @@ -217,7 +216,7 @@ int check_pager_config(const char *cmd, int discover_git_dir)
  	data.want = -1;
  	data.value = NULL;
  
 -	read_early_config(pager_command_config, &data, discover_git_dir);
 +	read_early_config(pager_command_config, &data);
  
  	if (data.value)
  		pager_program = data.value;
 diff --git a/setup.c b/setup.c
 index 967f289f1ef..7ceca6cc6ef 100644
 --- a/setup.c
 +++ b/setup.c
 @@ -816,50 +816,49 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
  	}
  }
  
 +enum discovery_result {
 +	GIT_DIR_NONE = 0,
 +	GIT_DIR_EXPLICIT,
 +	GIT_DIR_DISCOVERED,
 +	GIT_DIR_BARE,
 +	/* these are errors */
 +	GIT_DIR_HIT_CEILING = -1,
 +	GIT_DIR_HIT_MOUNT_POINT = -2
 +};
 +
  /*
   * We cannot decide in this function whether we are in the work tree or
   * not, since the config can only be read _after_ this function was called.
 + *
 + * Also, we avoid changing any global state (such as the current working
 + * directory) to allow early callers.
 + *
 + * The directory where the search should start needs to be passed in via the
 + * `dir` parameter; upon return, the `dir` buffer will contain the path of
 + * the directory where the search ended, and `gitdir` will contain the path of
 + * the discovered .git/ directory, if any. This path may be relative against
 + * `dir` (i.e. *not* necessarily the cwd).
   */
 -static const char *setup_git_directory_gently_1(int *nongit_ok)
 +static enum discovery_result discover_git_directory_1(struct strbuf *dir,
 +						      struct strbuf *gitdir)
  {
  	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
  	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
 -	static struct strbuf cwd = STRBUF_INIT;
 -	const char *gitdirenv, *ret;
 -	char *gitfile;
 -	int offset, offset_parent, ceil_offset = -1;
 +	const char *gitdirenv;
 +	int ceil_offset = -1, min_offset = has_dos_drive_prefix(dir->buf) ? 3 : 1;
  	dev_t current_device = 0;
  	int one_filesystem = 1;
  
  	/*
 -	 * We may have read an incomplete configuration before
 -	 * setting-up the git directory. If so, clear the cache so
 -	 * that the next queries to the configuration reload complete
 -	 * configuration (including the per-repo config file that we
 -	 * ignored previously).
 -	 */
 -	git_config_clear();
 -
 -	/*
 -	 * Let's assume that we are in a git repository.
 -	 * If it turns out later that we are somewhere else, the value will be
 -	 * updated accordingly.
 -	 */
 -	if (nongit_ok)
 -		*nongit_ok = 0;
 -
 -	if (strbuf_getcwd(&cwd))
 -		die_errno(_("Unable to read current working directory"));
 -	offset = cwd.len;
 -
 -	/*
  	 * If GIT_DIR is set explicitly, we're not going
  	 * to do any discovery, but we still do repository
  	 * validation.
  	 */
  	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
 -	if (gitdirenv)
 -		return setup_explicit_git_dir(gitdirenv, &cwd, nongit_ok);
 +	if (gitdirenv) {
 +		strbuf_addstr(gitdir, gitdirenv);
 +		return GIT_DIR_EXPLICIT;
 +	}
  
  	if (env_ceiling_dirs) {
  		int empty_entry_found = 0;
 @@ -867,15 +866,15 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
  		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
  		filter_string_list(&ceiling_dirs, 0,
  				   canonicalize_ceiling_entry, &empty_entry_found);
 -		ceil_offset = longest_ancestor_length(cwd.buf, &ceiling_dirs);
 +		ceil_offset = longest_ancestor_length(dir->buf, &ceiling_dirs);
  		string_list_clear(&ceiling_dirs, 0);
  	}
  
 -	if (ceil_offset < 0 && has_dos_drive_prefix(cwd.buf))
 -		ceil_offset = 1;
 +	if (ceil_offset < 0)
 +		ceil_offset = min_offset - 2;
  
  	/*
 -	 * Test in the following order (relative to the cwd):
 +	 * Test in the following order (relative to the dir):
  	 * - .git (file containing "gitdir: <path>")
  	 * - .git/
  	 * - ./ (bare)
 @@ -887,61 +886,123 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
  	 */
  	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
  	if (one_filesystem)
 -		current_device = get_device_or_die(".", NULL, 0);
 +		current_device = get_device_or_die(dir->buf, NULL, 0);
  	for (;;) {
 -		gitfile = (char*)read_gitfile(DEFAULT_GIT_DIR_ENVIRONMENT);
 -		if (gitfile)
 -			gitdirenv = gitfile = xstrdup(gitfile);
 -		else {
 -			if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 -				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 -		}
 -
 +		int offset = dir->len;
 +
 +		if (offset > min_offset)
 +			strbuf_addch(dir, '/');
 +		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
 +		gitdirenv = read_gitfile(dir->buf);
 +		if (!gitdirenv && is_git_directory(dir->buf))
 +			gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 +		strbuf_setlen(dir, offset);
  		if (gitdirenv) {
 -			ret = setup_discovered_git_dir(gitdirenv,
 -						       &cwd, offset,
 -						       nongit_ok);
 -			free(gitfile);
 -			return ret;
 +			strbuf_addstr(gitdir, gitdirenv);
 +			return GIT_DIR_DISCOVERED;
  		}
 -		free(gitfile);
  
 -		if (is_git_directory("."))
 -			return setup_bare_git_dir(&cwd, offset, nongit_ok);
 -
 -		offset_parent = offset;
 -		while (--offset_parent > ceil_offset && cwd.buf[offset_parent] != '/');
 -		if (offset_parent <= ceil_offset)
 -			return setup_nongit(cwd.buf, nongit_ok);
 -		if (one_filesystem) {
 -			dev_t parent_device = get_device_or_die("..", cwd.buf,
 -								offset);
 -			if (parent_device != current_device) {
 -				if (nongit_ok) {
 -					if (chdir(cwd.buf))
 -						die_errno(_("Cannot come back to cwd"));
 -					*nongit_ok = 1;
 -					return NULL;
 -				}
 -				strbuf_setlen(&cwd, offset);
 -				die(_("Not a git repository (or any parent up to mount point %s)\n"
 -				"Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
 -				    cwd.buf);
 -			}
 -		}
 -		if (chdir("..")) {
 -			strbuf_setlen(&cwd, offset);
 -			die_errno(_("Cannot change to '%s/..'"), cwd.buf);
 +		if (is_git_directory(dir->buf)) {
 +			strbuf_addstr(gitdir, ".");
 +			return GIT_DIR_BARE;
  		}
 -		offset = offset_parent;
 +
 +		if (offset <= min_offset)
 +			return GIT_DIR_HIT_CEILING;
 +
 +		while (--offset > ceil_offset && !is_dir_sep(dir->buf[offset]));
 +		if (offset <= ceil_offset)
 +			return GIT_DIR_HIT_CEILING;
 +
 +		strbuf_setlen(dir, offset > min_offset ?  offset : min_offset);
 +		if (one_filesystem &&
 +		    current_device != get_device_or_die(dir->buf, NULL, offset))
 +			return GIT_DIR_HIT_MOUNT_POINT;
 +	}
 +}
 +
 +const char *discover_git_directory(struct strbuf *gitdir)
 +{
 +	struct strbuf dir = STRBUF_INIT;
 +	int len;
 +
 +	if (strbuf_getcwd(&dir))
 +		return NULL;
 +
 +	len = dir.len;
 +	if (discover_git_directory_1(&dir, gitdir) < 0) {
 +		strbuf_release(&dir);
 +		return NULL;
 +	}
 +
 +	if (dir.len < len && !is_absolute_path(gitdir->buf)) {
 +		strbuf_addch(&dir, '/');
 +		strbuf_insert(gitdir, 0, dir.buf, dir.len);
  	}
 +	strbuf_release(&dir);
 +
 +	return gitdir->buf;
  }
  
  const char *setup_git_directory_gently(int *nongit_ok)
  {
 +	struct strbuf cwd = STRBUF_INIT, dir = STRBUF_INIT, gitdir = STRBUF_INIT;
  	const char *prefix;
  
 -	prefix = setup_git_directory_gently_1(nongit_ok);
 +	/*
 +	 * We may have read an incomplete configuration before
 +	 * setting-up the git directory. If so, clear the cache so
 +	 * that the next queries to the configuration reload complete
 +	 * configuration (including the per-repo config file that we
 +	 * ignored previously).
 +	 */
 +	git_config_clear();
 +
 +	/*
 +	 * Let's assume that we are in a git repository.
 +	 * If it turns out later that we are somewhere else, the value will be
 +	 * updated accordingly.
 +	 */
 +	if (nongit_ok)
 +		*nongit_ok = 0;
 +
 +	if (strbuf_getcwd(&cwd))
 +		die_errno(_("Unable to read current working directory"));
 +	strbuf_addbuf(&dir, &cwd);
 +
 +	switch (discover_git_directory_1(&dir, &gitdir)) {
 +	case GIT_DIR_NONE:
 +		prefix = NULL;
 +		break;
 +	case GIT_DIR_EXPLICIT:
 +		prefix = setup_explicit_git_dir(gitdir.buf, &cwd, nongit_ok);
 +		break;
 +	case GIT_DIR_DISCOVERED:
 +		if (dir.len < cwd.len && chdir(dir.buf))
 +			die(_("Cannot change to '%s'"), dir.buf);
 +		prefix = setup_discovered_git_dir(gitdir.buf, &cwd, dir.len,
 +						  nongit_ok);
 +		break;
 +	case GIT_DIR_BARE:
 +		if (dir.len < cwd.len && chdir(dir.buf))
 +			die(_("Cannot change to '%s'"), dir.buf);
 +		prefix = setup_bare_git_dir(&cwd, dir.len, nongit_ok);
 +		break;
 +	case GIT_DIR_HIT_CEILING:
 +		prefix = setup_nongit(cwd.buf, nongit_ok);
 +		break;
 +	case GIT_DIR_HIT_MOUNT_POINT:
 +		if (nongit_ok) {
 +			*nongit_ok = 1;
 +			return NULL;
 +		}
 +		die(_("Not a git repository (or any parent up to mount point %s)\n"
 +		      "Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set)."),
 +		    dir.buf);
 +	default:
 +		die("BUG: unhandled discover_git_directory() result");
 +	}
 +
  	if (prefix)
  		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
  	else
 diff --git a/t/helper/test-config.c b/t/helper/test-config.c
 index 51050695876..8e3ed6a76cb 100644
 --- a/t/helper/test-config.c
 +++ b/t/helper/test-config.c
 @@ -84,7 +84,7 @@ int cmd_main(int argc, const char **argv)
  	struct config_set cs;
  
  	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
 -		read_early_config(early_config_cb, (void *)argv[2], 1);
 +		read_early_config(early_config_cb, (void *)argv[2]);
  		return 0;
  	}
  
 diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
 index c8dc665f2fd..bf89340988b 100755
 --- a/t/t7006-pager.sh
 +++ b/t/t7006-pager.sh
 @@ -360,27 +360,37 @@ test_pager_choices                       'git aliasedlog'
  test_default_pager        expect_success 'git -p aliasedlog'
  test_PAGER_overrides      expect_success 'git -p aliasedlog'
  test_core_pager_overrides expect_success 'git -p aliasedlog'
 -test_core_pager_subdir    expect_failure 'git -p aliasedlog'
 +test_core_pager_subdir    expect_success 'git -p aliasedlog'
  test_GIT_PAGER_overrides  expect_success 'git -p aliasedlog'
  
  test_default_pager        expect_success 'git -p true'
  test_PAGER_overrides      expect_success 'git -p true'
  test_core_pager_overrides expect_success 'git -p true'
 -test_core_pager_subdir    expect_failure 'git -p true'
 +test_core_pager_subdir    expect_success 'git -p true'
  test_GIT_PAGER_overrides  expect_success 'git -p true'
  
  test_default_pager        expect_success test_must_fail 'git -p request-pull'
  test_PAGER_overrides      expect_success test_must_fail 'git -p request-pull'
  test_core_pager_overrides expect_success test_must_fail 'git -p request-pull'
 -test_core_pager_subdir    expect_failure test_must_fail 'git -p request-pull'
 +test_core_pager_subdir    expect_success test_must_fail 'git -p request-pull'
  test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p request-pull'
  
  test_default_pager        expect_success test_must_fail 'git -p'
  test_PAGER_overrides      expect_success test_must_fail 'git -p'
  test_local_config_ignored expect_failure test_must_fail 'git -p'
 -test_no_local_config_subdir expect_success test_must_fail 'git -p'
  test_GIT_PAGER_overrides  expect_success test_must_fail 'git -p'
  
 +test_expect_success TTY 'core.pager in repo config works and retains cwd' '
 +	sane_unset GIT_PAGER &&
 +	test_config core.pager "cat >cwd-retained" &&
 +	(
 +		cd sub &&
 +		rm -f cwd-retained &&
 +		test_terminal git -p rev-parse HEAD &&
 +		test -e cwd-retained
 +	)
 +'
 +
  test_doesnt_paginate      expect_failure test_must_fail 'git -p nonsense'
  
  test_pager_choices                       'git shortlog'

-- 
2.12.0.windows.1.3.g8a117c48243

