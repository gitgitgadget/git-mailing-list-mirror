From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2] commit: add --ignore-submodules[=<when>] parameter
Date: Sun, 30 Mar 2014 21:48:09 +0200
Message-ID: <533874F9.3090802@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com> <53374E49.9000702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 21:48:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WULiW-0003sq-Op
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 21:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbaC3TsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 15:48:20 -0400
Received: from mout.web.de ([212.227.15.3]:53264 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbaC3TsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 15:48:18 -0400
Received: from [192.168.178.41] ([84.132.177.33]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LoHKz-1WxLrr0VPF-00gIzM; Sun, 30 Mar 2014 21:48:14
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53374E49.9000702@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:XK33IAxBNZlR4dPfV6DQO6S3AOOxnr9C0iUhBUxhpUMoM5F3m1r
 l0M2OwzTKDqkq3Z81DkzanffuiaAcCbWKjp4+s0Zfe3iunp10siYjNrGfdShlbuuHMyXFYz
 Tk6kttzM2lnrrYb2mnrKGCCihilC4Xa1VXfYO3dHvs4IHo1DTw2Ah9c1WYAblVdXqsOPL/y
 sG0JHLotFa6hWx1wclQPg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245487>

Am 29.03.2014 23:50, schrieb Ronald Weiss:
> Git commit honors the 'ignore' setting from .gitmodules or .git/config,
> but didn't allow to override it from command line, like other commands do.
> 
> Useful <when> values for commit are 'all' (default) or 'none'. The others
> ('dirty' and 'untracked') have same effect as 'none', as commit is only
> interested in whether the submodule's HEAD differs from what is commited
> in the superproject.
> 
> Changes in add.c and cache.h (and related compilo fix in checkout.c) are
> needed to make it work for "commit -a" too.

Looking good so far, but we definitely need tests for this new option.

But I wonder if it would make more sense to start by teaching the
--ignore-submodules option to git add. Then this patch could reuse
that for commit -a.

> Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
> ---
>  Documentation/git-commit.txt |  6 ++++++
>  builtin/add.c                | 16 ++++++++++++----
>  builtin/checkout.c           |  2 +-
>  builtin/commit.c             |  8 +++++++-
>  cache.h                      |  2 +-
>  5 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 1a7616c..c8839c8 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> +	   [--ignore-submodules[=<when>]]
>  	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
>  
>  DESCRIPTION
> @@ -271,6 +272,11 @@ The possible options are:
>  The default can be changed using the status.showUntrackedFiles
>  configuration variable documented in linkgit:git-config[1].
>  
> +--ignore-submodules[=<when>]::
> +	Can be used to override any settings of the 'ignore' option
> +	in linkgit:git-config[1] or linkgit:gitmodules[5].
> +	<when> can be either "none" or "all", which is the default.
> +
>  -v::
>  --verbose::
>  	Show unified diff between the HEAD commit and what
> diff --git a/builtin/add.c b/builtin/add.c
> index 672adc0..1086294 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -168,7 +168,8 @@ static void update_callback(struct diff_queue_struct *q,
>  
>  static void update_files_in_cache(const char *prefix,
>  				  const struct pathspec *pathspec,
> -				  struct update_callback_data *data)
> +				  struct update_callback_data *data,
> +				  const char *ignore_submodules_arg)
>  {
>  	struct rev_info rev;
>  
> @@ -180,17 +181,24 @@ static void update_files_in_cache(const char *prefix,
>  	rev.diffopt.format_callback = update_callback;
>  	rev.diffopt.format_callback_data = data;
>  	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
> +
> +	if (ignore_submodules_arg) {
> +		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
> +		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
> +	}
> +
>  	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
>  }
>  
>  int add_files_to_cache(const char *prefix,
> -		       const struct pathspec *pathspec, int flags)
> +		       const struct pathspec *pathspec, int flags,
> +		       const char *ignore_submodules_arg)
>  {
>  	struct update_callback_data data;
>  
>  	memset(&data, 0, sizeof(data));
>  	data.flags = flags;
> -	update_files_in_cache(prefix, pathspec, &data);
> +	update_files_in_cache(prefix, pathspec, &data, ignore_submodules_arg);
>  	return !!data.add_errors;
>  }
>  
> @@ -576,7 +584,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		memset(&pathspec, 0, sizeof(pathspec));
>  	}
>  	update_data.flags = flags & ~ADD_CACHE_IMPLICIT_DOT;
> -	update_files_in_cache(prefix, &pathspec, &update_data);
> +	update_files_in_cache(prefix, &pathspec, &update_data, NULL);
>  
>  	exit_status |= !!update_data.add_errors;
>  	if (add_new_files)
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index ada51fa..22a4b48 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -525,7 +525,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			 * entries in the index.
>  			 */
>  
> -			add_files_to_cache(NULL, NULL, 0);
> +			add_files_to_cache(NULL, NULL, 0, NULL);
>  			/*
>  			 * NEEDSWORK: carrying over local changes
>  			 * when branches have different end-of-line
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 26b2986..121c185 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -360,7 +360,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix,
>  	 */
>  	if (all || (also && pathspec.nr)) {
>  		fd = hold_locked_index(&index_lock, 1);
> -		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
> +		add_files_to_cache(also ? prefix : NULL, &pathspec, 0, ignore_submodule_arg);
>  		refresh_cache_or_die(refresh_flags);
>  		update_main_cache_tree(WRITE_TREE_SILENT);
>  		if (write_cache(fd, active_cache, active_nr) ||
> @@ -1492,6 +1492,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
>  		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
>  		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> +		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
> +		  N_("ignore changes to submodules, optional when: all, none. (Default: all)"),
> +		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>  		/* end commit contents options */
>  
>  		OPT_HIDDEN_BOOL(0, "allow-empty", &allow_empty,
> @@ -1531,6 +1534,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
>  					  builtin_commit_usage,
>  					  prefix, current_head, &s);
> +
> +	s.ignore_submodule_arg = ignore_submodule_arg;
> +
>  	if (dry_run)
>  		return dry_run_commit(argc, argv, prefix, current_head, &s);
>  	index_file = prepare_index(argc, argv, prefix, current_head, 0);
> diff --git a/cache.h b/cache.h
> index ebe9a40..5ef8dd6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1282,7 +1282,7 @@ void packet_trace_identity(const char *prog);
>   * return 0 if success, 1 - if addition of a file failed and
>   * ADD_FILES_IGNORE_ERRORS was specified in flags
>   */
> -int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags);
> +int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int flags, const char *ignore_submodules_arg);
>  
>  /* diff.c */
>  extern int diff_auto_refresh_index;
> 
