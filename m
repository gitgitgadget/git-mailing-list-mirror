Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAEEC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F12610D1
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhDILKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:10:43 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:64700 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232042AbhDILKn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 07:10:43 -0400
Received: from host-92-1-139-132.as43234.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lUp1w-0003jU-E1; Fri, 09 Apr 2021 12:10:29 +0100
Subject: Re: [RFC PATCH 2/2] config: add 'config.superproject' file
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210408233936.533342-1-emilyshaffer@google.com>
 <20210408233936.533342-3-emilyshaffer@google.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <e19a250a-c4ca-fc32-83f9-a03aa03cd88a@iee.email>
Date:   Fri, 9 Apr 2021 12:10:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210408233936.533342-3-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/04/2021 00:39, Emily Shaffer wrote:
> Some configs, such as wrapper directives like gerrit.createChangeId, or
> forthcoming hook configs, should apply to a superproject as well as all
> its submodules. It may not be appropriate to apply them globally - for
> example, if the user also contributes to many projects which do not use
> the configs necessary for one project-with-submodules - and it may be
> burdensome to apply them locally to the superproject and each of its
> submodules. Even if the user runs 'git submodule foreach "git config
> --local foo.bar', if a new submodule is added later on, that config is
> not applied to the new submodule.
>
> It is also inappropriate to share the entire superproject config, since
> some items - like remote URLs or partial-clone filters - would not apply
> to a submodule.
>
> To make life easier for projects with many submodules, then, create a
> new "config.superproject" config scope, which is included in the config
> parse for the superproject as well as for all the submodules of that
> superproject.
>
> For the superproject, this new config file is equally local to the local
> config; for the submodule, the new config file is less local than the
> local config. So let's include it directly before the local config
> during the config parse.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---

Does this need an update to the `git config --show-origin --show-scope`
capability?
--
Philip
>  Documentation/git-config.txt   |  21 +++++-
>  builtin/config.c               |  10 ++-
>  config.c                       |  26 +++++++
>  config.h                       |   3 +
>  submodule.c                    |  29 ++++++++
>  submodule.h                    |   6 ++
>  t/t1311-superproject-config.sh | 124 +++++++++++++++++++++++++++++++++
>  7 files changed, 216 insertions(+), 3 deletions(-)
>  create mode 100755 t/t1311-superproject-config.sh
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 4b4cc5c5e8..a33136fb08 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -48,7 +48,7 @@ unset an existing `--type` specifier with `--no-type`.
>  
>  When reading, the values are read from the system, global and
>  repository local configuration files by default, and options
> -`--system`, `--global`, `--local`, `--worktree` and
> +`--system`, `--global`, `--superproject`, `--local`, `--worktree` and
>  `--file <filename>` can be used to tell the command to read from only
>  that location (see <<FILES>>).
>  
> @@ -127,6 +127,17 @@ rather than from all available files.
>  +
>  See also <<FILES>>.
>  
> +--superproject::
> +	For writing options: write to the superproject's
> +	`.git/config.superproject` file, even if run from a submodule of that
> +	superproject.
> ++
> +For reading options: read only from the superproject's
> +`.git/config.superproject` file, even if run from a submodule of that
> +superproject, rather than from all available files.
> ++
> +See also <<FILES>>.
> +
>  --local::
>  	For writing options: write to the repository `.git/config` file.
>  	This is the default behavior.
> @@ -283,7 +294,7 @@ The default is to use a pager.
>  FILES
>  -----
>  
> -If not set explicitly with `--file`, there are four files where
> +If not set explicitly with `--file`, there are five files where
>  'git config' will search for configuration options:
>  
>  $(prefix)/etc/gitconfig::
> @@ -301,6 +312,12 @@ $XDG_CONFIG_HOME/git/config::
>  	User-specific configuration file. Also called "global"
>  	configuration file.
>  
> +$GIT_DIR/config.superproject::
> +	When `git config` is run from a project which is a submodule of another
> +	project, that superproject's $GIT_DIR will be used. Use this config file
> +	to set configurations which need to be the same across a superproject
> +	and all its submodules.
> +
>  $GIT_DIR/config::
>  	Repository specific configuration file.
>  
> diff --git a/builtin/config.c b/builtin/config.c
> index f71fa39b38..f0a57a89ca 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -26,7 +26,7 @@ static char key_delim = ' ';
>  static char term = '\n';
>  
>  static int use_global_config, use_system_config, use_local_config;
> -static int use_worktree_config;
> +static int use_worktree_config, use_superproject_config;
>  static struct git_config_source given_config_source;
>  static int actions, type;
>  static char *default_value;
> @@ -130,6 +130,8 @@ static struct option builtin_config_options[] = {
>  	OPT_GROUP(N_("Config file location")),
>  	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
>  	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
> +	OPT_BOOL(0, "superproject",
> +		 &use_superproject_config, N_("use superproject config file")),
>  	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
>  	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
>  	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
> @@ -697,6 +699,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  	else if (use_system_config) {
>  		given_config_source.file = git_etc_gitconfig();
>  		given_config_source.scope = CONFIG_SCOPE_SYSTEM;
> +	} else if (use_superproject_config) {
> +		struct strbuf superproject_cfg = STRBUF_INIT;
> +		git_config_superproject(&superproject_cfg, get_git_dir());
> +		given_config_source.file = xstrdup(superproject_cfg.buf);
> +		given_config_source.scope = CONFIG_SCOPE_SUPERPROJECT;
> +		strbuf_release(&superproject_cfg);
>  	} else if (use_local_config) {
>  		given_config_source.file = git_pathdup("config");
>  		given_config_source.scope = CONFIG_SCOPE_LOCAL;
> diff --git a/config.c b/config.c
> index 67d9bf2238..28bb80fd0d 100644
> --- a/config.c
> +++ b/config.c
> @@ -21,6 +21,7 @@
>  #include "dir.h"
>  #include "color.h"
>  #include "refs.h"
> +#include "submodule.h"
>  
>  struct config_source {
>  	struct config_source *prev;
> @@ -1852,6 +1853,17 @@ const char *git_etc_gitconfig(void)
>  	return system_wide;
>  }
>  
> +void git_config_superproject(struct strbuf *sb, const char *gitdir)
> +{
> +	if (!get_superproject_gitdir(sb)) {
> +		/* not a submodule */
> +		strbuf_reset(sb);
> +		strbuf_addstr(sb, gitdir);
> +	}
> +
> +	strbuf_addstr(sb, "/config.superproject");
> +}
> +
>  /*
>   * Parse environment variable 'k' as a boolean (in various
>   * possible spellings); if missing, use the default value 'def'.
> @@ -1909,6 +1921,17 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
>  		ret += git_config_from_file(fn, user_config, data);
>  
> +	current_parsing_scope = CONFIG_SCOPE_SUPERPROJECT;
> +	if (opts->git_dir && !opts->ignore_superproject) {
> +
> +		struct strbuf superproject_gitdir = STRBUF_INIT;
> +		git_config_superproject(&superproject_gitdir, opts->git_dir);
> +		if (!access_or_die(superproject_gitdir.buf, R_OK, 0))
> +			ret += git_config_from_file(fn, superproject_gitdir.buf, data);
> +
> +		strbuf_release(&superproject_gitdir);
> +	}
> +
>  	current_parsing_scope = CONFIG_SCOPE_LOCAL;
>  	if (!opts->ignore_repo && repo_config &&
>  	    !access_or_die(repo_config, R_OK, 0))
> @@ -2027,6 +2050,7 @@ void read_very_early_config(config_fn_t cb, void *data)
>  
>  	opts.respect_includes = 1;
>  	opts.ignore_repo = 1;
> +	opts.ignore_superproject = 1;
>  	opts.ignore_worktree = 1;
>  	opts.ignore_cmdline = 1;
>  	opts.system_gently = 1;
> @@ -3515,6 +3539,8 @@ const char *config_scope_name(enum config_scope scope)
>  		return "command";
>  	case CONFIG_SCOPE_GITMODULES:
>  		return "gitmodules";
> +	case CONFIG_SCOPE_SUPERPROJECT:
> +		return "superproject";
>  	default:
>  		return "unknown";
>  	}
> diff --git a/config.h b/config.h
> index 535f5517b8..b42e1d13eb 100644
> --- a/config.h
> +++ b/config.h
> @@ -43,6 +43,7 @@ enum config_scope {
>  	CONFIG_SCOPE_WORKTREE,
>  	CONFIG_SCOPE_COMMAND,
>  	CONFIG_SCOPE_GITMODULES,
> +	CONFIG_SCOPE_SUPERPROJECT,
>  };
>  const char *config_scope_name(enum config_scope scope);
>  
> @@ -84,6 +85,7 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
>  struct config_options {
>  	unsigned int respect_includes : 1;
>  	unsigned int ignore_repo : 1;
> +	unsigned int ignore_superproject : 1;
>  	unsigned int ignore_worktree : 1;
>  	unsigned int ignore_cmdline : 1;
>  	unsigned int system_gently : 1;
> @@ -319,6 +321,7 @@ int git_config_rename_section_in_file(const char *, const char *, const char *);
>  int git_config_copy_section(const char *, const char *);
>  int git_config_copy_section_in_file(const char *, const char *, const char *);
>  const char *git_etc_gitconfig(void);
> +void git_config_superproject(struct strbuf *, const char *);
>  int git_env_bool(const char *, int);
>  unsigned long git_env_ulong(const char *, unsigned long);
>  int git_config_system(void);
> diff --git a/submodule.c b/submodule.c
> index 9767ba9893..92b00f8697 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2178,6 +2178,35 @@ void absorb_git_dir_into_superproject(const char *path,
>  	}
>  }
>  
> +int get_superproject_gitdir(struct strbuf *buf)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	int rc = 0;
> +
> +	/* NEEDSWORK: this call also calls out to a subprocess! */
> +	rc = get_superproject_working_tree(&sb);
> +	strbuf_release(&sb);
> +
> +	if (!rc)
> +		return rc;
> +
> +	prepare_submodule_repo_env_no_git_dir(&cp.env_array);
> +
> +	strvec_pushl(&cp.args, "-C", "..", "rev-parse", "--absolute-git-dir", NULL);
> +	cp.git_cmd = 1;
> +
> +	rc = capture_command(&cp, buf, 0);
> +	strbuf_trim_trailing_newline(buf);
> +
> +	/* leave buf empty if we didn't have a superproject gitdir */
> +	if (rc)
> +		strbuf_reset(buf);
> +
> +	/* rc reflects the exit code of the rev-parse; invert into a bool */
> +	return !rc;
> +}
> +
>  int get_superproject_working_tree(struct strbuf *buf)
>  {
>  	struct child_process cp = CHILD_PROCESS_INIT;
> diff --git a/submodule.h b/submodule.h
> index 4ac6e31cf1..1308d5ae2d 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -149,6 +149,12 @@ void prepare_submodule_repo_env(struct strvec *out);
>  void absorb_git_dir_into_superproject(const char *path,
>  				      unsigned flags);
>  
> +/*
> + * Return the gitdir of the superproject, which this project is a submodule of.
> + * If this repository is not a submodule of another repository, return 0.
> + */
> +int get_superproject_gitdir(struct strbuf *buf);
> +
>  /*
>   * Return the absolute path of the working tree of the superproject, which this
>   * project is a submodule of. If this repository is not a submodule of
> diff --git a/t/t1311-superproject-config.sh b/t/t1311-superproject-config.sh
> new file mode 100755
> index 0000000000..650c4d24c7
> --- /dev/null
> +++ b/t/t1311-superproject-config.sh
> @@ -0,0 +1,124 @@
> +#!/bin/sh
> +
> +test_description='Test git config --superproject in different settings'
> +
> +. ./test-lib.sh
> +
> +# follow t7400's example and use the trash dir repo as a submodule to add
> +submodurl=$(pwd -P)
> +
> +# since only the configs are modified, set up the repo structure only once
> +test_expect_success 'setup repo structure' '
> +	test_commit "base" &&
> +	git submodule add "${submodurl}" sub/ &&
> +	git commit -m "add a submodule"
> +'
> +
> +test_expect_success 'superproject config applies to super and submodule' '
> +	cat >.git/config.superproject <<-EOF &&
> +	[foo]
> +		bar = baz
> +	EOF
> +
> +	git config --get foo.bar &&
> +	git -C sub config --get foo.bar &&
> +
> +	rm .git/config.superproject
> +'
> +
> +test_expect_success 'can add from super or sub' '
> +	git config --superproject apple.species honeycrisp &&
> +	git -C sub config --superproject banana.species cavendish &&
> +
> +	cat >expect <<-EOF &&
> +	apple.species=honeycrisp
> +	banana.species=cavendish
> +	EOF
> +
> +	git config --list >actual &&
> +	grep -Ff expect actual &&
> +
> +	git -C sub config --list >actual &&
> +	grep -Ff expect actual &&
> +
> +	rm .git/config.superproject
> +'
> +
> +test_expect_success 'can --unset from super or sub' '
> +	git config --superproject apple.species honeycrisp &&
> +	git -C sub config --superproject banana.species cavendish &&
> +
> +	git config --unset --superproject banana.species &&
> +	git -C sub config --unset --superproject apple.species
> +'
> +
> +test_expect_success 'can --edit superproject config' '
> +	test_config core.editor "echo [foo]bar=baz >" &&
> +	git config --edit --superproject &&
> +
> +	git config --get foo.bar &&
> +
> +	rm .git/config.superproject
> +'
> +
> +test_expect_success 'can --show-origin the superproject config' '
> +	git config --superproject --add foo.bar baz &&
> +
> +	git config --list --show-origin >actual &&
> +	grep -F "config.superproject" actual &&
> +
> +	rm .git/config.superproject
> +'
> +
> +test_expect_success 'can --show-scope the superproject config' '
> +	git config --superproject --add foo.bar baz &&
> +
> +	git config --list --show-scope >actual &&
> +	grep "superproject" actual &&
> +
> +	rm .git/config.superproject
> +'
> +
> +test_expect_success 'pre-existing config applies to new submodule' '
> +	git config --superproject --add foo.bar baz &&
> +
> +	git submodule add "${submodurl}" sub2/ &&
> +	git commit -m "add a second submodule" &&
> +
> +	git -C sub2 config --get foo.bar &&
> +
> +	# clean up
> +	git reset HEAD^ &&
> +	rm -fr sub2 &&
> +	rm .git/config.superproject
> +'
> +
> +# NEEDSWORK: submodule.c:get_superproject_working_tree doesn't support worktree
> +test_expect_failure 'worktrees can still access config.superproject' '
> +	git config --superproject --add foo.bar baz &&
> +
> +	git worktree add wt &&
> +	(
> +		cd wt &&
> +		git config --get foo.bar
> +	) &&
> +
> +	# clean up
> +	git worktree remove wt &&
> +	rm .git/config.superproject
> +'
> +
> +# This test deletes the submodule! Keep it at the end of the test suite.
> +test_expect_success 'config.submodule works even with no submodules' '
> +	# get rid of the submodule
> +	git reset HEAD^ &&
> +	rm -fr sub &&
> +
> +	git config --superproject --add foo.bar baz &&
> +
> +	git config --get foo.bar &&
> +
> +	rm .git/config.superproject
> +'
> +
> +test_done

