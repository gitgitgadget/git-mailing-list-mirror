From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2.1] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 31 Mar 2014 20:58:44 +0200
Message-ID: <5339BAE4.8020306@web.de>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de> <CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com> <53374E49.9000702@gmail.com> <533874F9.3090802@web.de> <5338AC36.6000109@gmail.com> <5338B1B0.3050703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 20:59:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhQA-00036N-Ug
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 20:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbaCaS6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 14:58:54 -0400
Received: from mout.web.de ([212.227.15.3]:53297 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbaCaS6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 14:58:52 -0400
Received: from [192.168.178.41] ([79.193.64.198]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MfYTr-1Wg10U3FsZ-00P87b; Mon, 31 Mar 2014 20:58:49
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <5338B1B0.3050703@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:H8TfjqcKDqXhNdUl7DdR7pQsj1jWNCRHCasSDDC7apu9wBrT/31
 KR+AtUM4CqGP00DrrfIO81UNgHVDYOWn8RK6O/Gqg1G/x7EZ3NeMjGzmCrnhJysGlQZU23d
 PjOvI9ZaRXGO+78FP0K+xMlZ5T6jY0UTd3DQsDc0IZZV4dC0WPHvGuRS/Qf0/IKtx7OPrii
 iq3cAzVSTKYrf2/vvd6pw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245510>

Am 31.03.2014 02:07, schrieb Ronald Weiss:
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
> 
> Signed-off-by: Ronald Weiss <weiss.ronald@gmail.com>
> ---
> The previous patch version (v2) contained bug in the test, by mistake I
> have sent older version than I was testing with, sorry for that.
> 
> On 30. 3. 2014 21:48, Jens Lehmann wrote:
>> Looking good so far, but we definitely need tests for this new option.
> 
> I added two simple tests (one for --ignore-submodules=all, another one
> for =none). But I am sure the tests could be written better, by someone
> more proficient in Git than I am.
> 
> The tests immediately revealed, that the patch was not complete. It
> didn't work with commit message given on command line (-m). To make
> that work, I had to also patch the index_differs_from function in
> diff-lib.c.

Which is exactly the same function I have to tweak to make my
"status/commit: always show staged submodules regardless of
ignore config" patch work for "git commit -m" too ;-)

I was doing that slightly differently but it seems that your way
of adding the "ignore_submodules_arg" parameter could serve us
both. Will update my upcoming patch accordingly.

>> But I wonder if it would make more sense to start by teaching the
>> --ignore-submodules option to git add. Then this patch could reuse
>> that for commit -a.
> 
> That sounds reasonable, however I don't think that any code from my
> patch would be affected, or would it? IOW, would commit really "reuse"
> anything? If not (or not much), there is probably no point in
> postponing this patch, support for git add may be added later.

You might be right as I didn't really check the actual codepaths. I
was deducing this from the observation that most changes were made
to builtin/add.c. And seeing a function like add_files_to_cache()
being modified made me expect that plain add would use the same
function to stage the files.

As Junio mentioned it would be great if you could teach the add
command also honor the --ignore-submodule command line option in
a companion patch. In the course of doing so you'll easily see if
I was right or not, then please just order them in the most logical
way.

Thanks for digging into this!

>  Documentation/git-commit.txt        |  6 ++++++
>  builtin/add.c                       | 16 +++++++++++----
>  builtin/checkout.c                  |  2 +-
>  builtin/commit.c                    | 10 ++++++++--
>  cache.h                             |  2 +-
>  diff-lib.c                          |  7 ++++++-
>  diff.h                              |  3 ++-
>  sequencer.c                         |  4 ++--
>  t/t7513-commit-ignore-submodules.sh | 39 +++++++++++++++++++++++++++++++++++++
>  9 files changed, 77 insertions(+), 12 deletions(-)
>  create mode 100644 t/t7513-commit-ignore-submodules.sh
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
> index 26b2986..b3fb28e 100644
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
> @@ -827,7 +827,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		if (get_sha1(parent, sha1))
>  			commitable = !!active_nr;
>  		else
> -			commitable = index_differs_from(parent, 0);
> +			commitable = index_differs_from(parent, 0, ignore_submodule_arg);
>  	}
>  	strbuf_release(&committer_ident);
>  
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
> diff --git a/diff-lib.c b/diff-lib.c
> index 2eddc66..fec5ad4 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -508,7 +508,8 @@ int do_diff_cache(const unsigned char *tree_sha1, struct diff_options *opt)
>  	return 0;
>  }
>  
> -int index_differs_from(const char *def, int diff_flags)
> +int index_differs_from(const char *def, int diff_flags,
> +		       const char *ignore_submodules_arg)
>  {
>  	struct rev_info rev;
>  	struct setup_revision_opt opt;
> @@ -520,6 +521,10 @@ int index_differs_from(const char *def, int diff_flags)
>  	DIFF_OPT_SET(&rev.diffopt, QUICK);
>  	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
>  	rev.diffopt.flags |= diff_flags;
> +	if (ignore_submodules_arg) {
> +		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
> +		handle_ignore_submodules_arg(&rev.diffopt, ignore_submodules_arg);
> +	}
>  	run_diff_index(&rev, 1);
>  	if (rev.pending.alloc)
>  		free(rev.pending.objects);
> diff --git a/diff.h b/diff.h
> index ce123fa..0ac869b 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -334,7 +334,8 @@ extern int diff_result_code(struct diff_options *, int);
>  
>  extern void diff_no_index(struct rev_info *, int, const char **, const char *);
>  
> -extern int index_differs_from(const char *def, int diff_flags);
> +extern int index_differs_from(const char *def, int diff_flags,
> +			      const char *ignore_submodules_arg);
>  
>  extern size_t fill_textconv(struct userdiff_driver *driver,
>  			    struct diff_filespec *df,
> diff --git a/sequencer.c b/sequencer.c
> index 90cac7b..de9edec 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -496,7 +496,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		unborn = get_sha1("HEAD", head);
>  		if (unborn)
>  			hashcpy(head, EMPTY_TREE_SHA1_BIN);
> -		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0))
> +		if (index_differs_from(unborn ? EMPTY_TREE_SHA1_HEX : "HEAD", 0, NULL))
>  			return error_dirty_index(opts);
>  	}
>  	discard_cache();
> @@ -1042,7 +1042,7 @@ static int sequencer_continue(struct replay_opts *opts)
>  		if (ret)
>  			return ret;
>  	}
> -	if (index_differs_from("HEAD", 0))
> +	if (index_differs_from("HEAD", 0, NULL))
>  		return error_dirty_index(opts);
>  	todo_list = todo_list->next;
>  	return pick_commits(todo_list, opts);
> diff --git a/t/t7513-commit-ignore-submodules.sh b/t/t7513-commit-ignore-submodules.sh
> new file mode 100644
> index 0000000..a7148ce
> --- /dev/null
> +++ b/t/t7513-commit-ignore-submodules.sh
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> +
> +test_description='git commit --ignore-submodules'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'create submodule' '
> +	test_create_repo sm && (
> +		cd sm &&
> +		>foo &&
> +		git add foo &&
> +		git commit -m "Add foo"
> +	) &&
> +	git submodule add ./sm &&
> +	git commit -m "Add sm"
> +'
> +
> +update_sm () {
> +	(cd sm &&
> +		echo bar >> foo &&
> +		git add foo &&
> +		git commit -m "Updated foo"
> +	)
> +}
> +
> +test_expect_success 'commit -a --ignore-submodules=all ignores dirty submodule' '
> +	update_sm &&
> +	test_must_fail git commit -a --ignore-submodules=all -m "Update sm"
> +'
> +
> +test_expect_success 'commit -a --ignore-submodules=none overrides ignore=all setting' '
> +	update_sm &&
> +	git config submodule.sm.ignore all &&
> +	git commit -a --ignore-submodules=none -m "Update sm" &&
> +	git diff-index --exit-code --cached --ignore-submodules=none HEAD &&
> +	git diff-files --exit-code --ignore-submodules=none
> +'
> +
> +test_done
> 
