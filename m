Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD68C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 23:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiA1XVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 18:21:54 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:52620 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233182AbiA1XVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 18:21:53 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Jltl34f4cz5tl9;
        Sat, 29 Jan 2022 00:21:51 +0100 (CET)
Message-ID: <7f46e276-b669-e8fe-21fd-6b43f5bfb33b@kdbg.org>
Date:   Sat, 29 Jan 2022 00:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/4] i18n: factorize more 'incompatible options'
 messages
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com>
 <pull.1123.v2.git.1643408643.gitgitgadget@gmail.com>
 <844e01391e1198960072844536d736f51573cac6.1643408644.git.gitgitgadget@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <844e01391e1198960072844536d736f51573cac6.1643408644.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.01.22 um 23:24 schrieb Jean-Noël Avila via GitGitGadget:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> Find more incompatible options to factorize.
> 
> When more than two options are mutually exclusive, print the ones
> which are actually on the command line.
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  builtin/commit.c                          | 39 +++++++++---------
>  builtin/difftool.c                        |  5 ++-
>  builtin/grep.c                            |  8 ++--
>  builtin/log.c                             |  5 ++-
>  builtin/merge-base.c                      |  4 +-
>  parse-options.c                           | 50 +++++++++++++++++++++++
>  parse-options.h                           |  9 ++++
>  t/t7500-commit-template-squash-signoff.sh |  2 +-
>  8 files changed, 90 insertions(+), 32 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index b9ed0374e30..1966f965008 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1242,8 +1242,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  				      struct commit *current_head,
>  				      struct wt_status *s)
>  {
> -	int f = 0;
> -
>  	argc = parse_options(argc, argv, prefix, options, usage, 0);
>  	finalize_deferred_config(s);
>  
> @@ -1251,7 +1249,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  		force_author = find_author_by_nickname(force_author);
>  
>  	if (force_author && renew_authorship)
> -		die(_("Using both --reset-author and --author does not make sense"));
> +		die(_("options '%s' and '%s' cannot be used together"), "--reset-author", "--author");
>  
>  	if (logfile || have_option_m || use_message)
>  		use_editor = 0;
> @@ -1268,20 +1266,20 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  			die(_("You are in the middle of a rebase -- cannot amend."));
>  	}
>  	if (fixup_message && squash_message)
> -		die(_("Options --squash and --fixup cannot be used together"));
> -	if (use_message)
> -		f++;
> -	if (edit_message)
> -		f++;
> -	if (fixup_message)
> -		f++;
> -	if (logfile)
> -		f++;
> -	if (f > 1)
> -		die(_("Only one of -c/-C/-F/--fixup can be used."));
> -	if (have_option_m && (edit_message || use_message || logfile))
> -		die((_("Option -m cannot be combined with -c/-C/-F.")));
> -	if (f || have_option_m)
> +		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
> +	die_if_incompatible_opt4(!!use_message, "-C",
> +							 !!edit_message, "-c",
> +							 !!logfile, "-F",
> +							 !!fixup_message, "--fixup");
Please check the tab width setting of your editor; indentations here and
in other calls and function declarations below are too wide. Looks like
you have it at 4 instead of 8.

> +	if (have_option_m) {
> +		if (edit_message)
> +			die(_("options '%s' and '%s' cannot be used together"), "-m", "-c");
> +		else if  (use_message)
> +			die(_("options '%s' and '%s' cannot be used together"), "-m", "-C");
> +		else if (logfile)
> +			die(_("options '%s' and '%s' cannot be used together"), "-m", "-F");
> +	}

This conditional could have been another die_if_incompatible_opt4()
call, although it would only check a conflict of -m with at most one of
-c, -C, or -F.

> +	if (use_message || edit_message || logfile ||fixup_message || have_option_m)

Missing space before fixup_message.

>  		template_file = NULL;
>  	if (edit_message)
>  		use_message = edit_message;

The rewrite of the logic in this hunk looks correct.

> @@ -1306,9 +1304,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
>  	if (patch_interactive)
>  		interactive = 1;
>  
> -	if (also + only + all + interactive > 1)
> -		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
> -
> +	die_if_incompatible_opt4(also, "-i/--include",
> +							 only, "-o/--only",
> +							 all, "-a/--all",
> +							 interactive, "--interactive/-p/--patch");
>  	if (fixup_message) {
>  		/*
>  		 * We limit --fixup's suboptions to only alpha characters.
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index c79fbbf67e5..ae487785735 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -732,8 +732,9 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
>  	} else if (dir_diff)
>  		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
>  
> -	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
> -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
> +	die_if_incompatible_opt3(use_gui_tool, "--gui",
> +							 !!difftool_cmd, "--tool",
> +							 !!extcmd, "--extcmd");
>  
>  	if (use_gui_tool)
>  		setenv("GIT_MERGETOOL_GUI", "true", 1);
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 9e34a820ad4..cdf52667710 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -1167,11 +1167,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	if (!show_in_pager && !opt.status_only)
>  		setup_pager();
>  
> -	if (!use_index && (untracked || cached))
> -		die(_("--cached or --untracked cannot be used with --no-index"));
> -
> -	if (untracked && cached)
> -		die(_("--untracked cannot be used with --cached"));
> +	die_if_incompatible_opt3(!use_index, "--no-index",
> +							 untracked, "--untracked",
> +							 cached, "--cached");
>  
>  	if (!use_index || untracked) {
>  		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
> diff --git a/builtin/log.c b/builtin/log.c
> index 4b493408cc5..048b2c37470 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1978,8 +1978,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  	if (rev.show_notes)
>  		load_display_notes(&rev.notes_opt);
>  
> -	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
> -		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
> +	die_if_incompatible_opt3(use_stdout, "--stdout",
> +							 rev.diffopt.close_file, "--output",
> +							 !!output_directory, "--output-directory");
>  
>  	if (use_stdout) {
>  		setup_pager();
> diff --git a/builtin/merge-base.c b/builtin/merge-base.c
> index 6719ac198dc..1447f1c493a 100644
> --- a/builtin/merge-base.c
> +++ b/builtin/merge-base.c
> @@ -159,12 +159,12 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
>  		if (argc < 2)
>  			usage_with_options(merge_base_usage, options);
>  		if (show_all)
> -			die("--is-ancestor cannot be used with --all");
> +			die(_("options '%s' and '%s' cannot be used together"),"--is-ancestor", "--all");
>  		return handle_is_ancestor(argc, argv);
>  	}
>  
>  	if (cmdmode == 'r' && show_all)
> -		die("--independent cannot be used with --all");
> +		die(_("options '%s' and '%s' cannot be used together"),"--independent", "--all");
>  
>  	if (cmdmode == 'o')
>  		return handle_octopus(argc, argv, show_all);

These rewrites are good. Note the unusually wide indentation in the new
function calls, though.

> diff --git a/parse-options.c b/parse-options.c
> index a8283037be9..fb9e1976ab3 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -1079,3 +1079,53 @@ void NORETURN usage_msg_opt(const char *msg,
>  	die_message("%s\n", msg); /* The extra \n is intentional */
>  	usage_with_options(usagestr, options);
>  }
> +
> +void die_if_incompatible_opt3(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name)
> +{
> +	int count = 0;
> +	const char *options[3];
> +
> +	if (opt1)
> +		options[count++] = opt1_name;
> +	if (opt2)
> +		options[count++] = opt2_name;
> +	if (opt3)
> +		options[count++] = opt3_name;
> +	if (count > 2)
> +		die(_("options '%s', '%s', and '%s' cannot be used together"), opt1_name, opt2_name, opt3_name);
> +	else if (count > 1)
> +		die(_("options '%s' and '%s' cannot be used together"), options[0], options[1]);
> +}
> +
> +void die_if_incompatible_opt4(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name,
> +							  int opt4, const char *opt4_name)
> +{
> +	int count = 0;
> +	const char *options[4];
> +
> +	if (opt1)
> +		options[count++] = opt1_name;
> +	if (opt2)
> +		options[count++] = opt2_name;
> +	if (opt3)
> +		options[count++] = opt3_name;
> +	if (opt4)
> +		options[count++] = opt4_name;
> +	switch (count) {
> +	case 4:
> +		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"), opt1_name, opt2_name, opt3_name, opt4_name);
> +		break;
> +	case 3:
> +		die(_("options '%s', '%s', and '%s' cannot be used together"), options[0], options[1], options[2]);
> +		break;
> +	case 2:
> +		die(_("options '%s' and '%s' cannot be used together"), options[0], options[1]);
> +		break;
> +	default:
> +		break;
> +	}
> +}

Generally, this is good. I wonder whether we have to expect compiler
warnings about unreachable break statements after the die() calls.

A bit of code duplication could be avoided if die_if_incompatible_opt3()
forwarded with an additional pair 0, "" to die_if_incompatible_opt4().

> diff --git a/parse-options.h b/parse-options.h
> index e22846d3b7b..cf393839ac4 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -339,4 +339,13 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
>  #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
>  #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
>  
> +void die_if_incompatible_opt3(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name);
> +
> +void die_if_incompatible_opt4(int opt1, const char *opt1_name,
> +							  int opt2, const char *opt2_name,
> +							  int opt3, const char *opt3_name,
> +							  int opt4, const char *opt4_name);
> +
>  #endif

I would have placed these declarations near usage_msg_opt further above
in the header file.

> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 91964653a0b..5fcaa0b4f2a 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -442,7 +442,7 @@ test_expect_success '--fixup=reword: give error with pathsec' '
>  '
>  
>  test_expect_success '--fixup=reword: -F give error message' '
> -	echo "fatal: Only one of -c/-C/-F/--fixup can be used." >expect &&
> +	echo "fatal: options '\''-F'\'' and '\''--fixup'\'' cannot be used together" >expect &&
>  	test_must_fail git commit --fixup=reword:HEAD~ -F msg  2>actual &&
>  	test_cmp expect actual
>  '

-- Hannes
