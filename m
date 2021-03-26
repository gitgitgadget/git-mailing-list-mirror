Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CECCC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F82E61934
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZMpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:45:24 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:54747 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhCZMpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 08:45:23 -0400
X-Greylist: delayed 1046 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Mar 2021 08:45:22 EDT
Received: from host-92-1-139-132.as43234.net ([92.1.139.132] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lPlZC-00043w-9r; Fri, 26 Mar 2021 12:27:55 +0000
Subject: Re: [PATCH] sequencer: fix edit handling for cherry-pick and revert
 messages
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <eda509dd-d2d5-0856-0c75-094d67257d54@iee.email>
Date:   Fri, 26 Mar 2021 12:27:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

minor nit on a code comment

On 26/03/2021 07:16, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> save_opts() should save any non-default values.  It was intended to do
> this, but since most options in struct replay_opts default to 0, it only
> saved non-zero values.  Unfortunatley, this does not always work for
> options.edit.  Roughly speaking, options.edit had a default value of 0
> for cherry-pick but a default value of 1 for revert.  Make save_opts()
> record a value whenever it differs from the default.
>
> options.edit was also overly simplistic; we had more than two cases.
> The behavior that previously existed was as follows:
>
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit (ignore isatty(0))
>     cherry-pick        No edit                 See above
>     Specify --edit     Edit (ignore isatty(0)) See above
>     Specify --no-edit  (*)                     See above
>
>     (*) Before stopping for conflicts, No edit is the behavior.  After
>         stopping for conflicts, the --no-edit flag is not saved so see
>         the first two rows.
>
> However, the expected behavior is:
>
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit iff isatty(0)
>     cherry-pick        No edit                 Edit iff isatty(0)
>     Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
>     Specify --no-edit  No edit                 No edit
>
> In order to get the expected behavior, we need to change options.edit
> to a tri-state: unspecified, false, or true.  When specified, we follow
> what it says.  When unspecified, we need to check whether the current
> commit being created is resolving a conflict as well as consulting
> options.action and isatty(0).  While at it, add a should_edit() utility
> function that compresses options.edit down to a boolean based on the
> additional information for the non-conflict case.
>
> Make continue_single_pick() (which is the function responsible for
> resuming after conflict cases) stop assuming edit behavior in all cases,
> so that it can correctly handle !isatty(0) and specific requests to not
> edit the commit message.
>
> Reported-by: Renato Botelho <garga@freebsd.org>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     sequencer: fix edit handling for cherry-pick and revert messages
>     
>     save_opts() should save any non-default values. It was intended to do
>     this, but since most options in struct replay_opts default to 0, it only
>     saved non-zero values. Unfortunatley, this does not always work for
>     options.edit. Roughly speaking, options.edit had a default value of 0
>     for cherry-pick but a default value of 1 for revert. Make save_opts()
>     record a value whenever it differs from the default.
>     
>     options.edit was also overly simplistic; we had more than two cases. The
>     behavior that previously existed was as follows:
>     
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit (ignore isatty(0))
>     cherry-pick        No edit                 See above
>     Specify --edit     Edit (ignore isatty(0)) See above
>     Specify --no-edit  (*)                     See above
>     
>     (*) Before stopping for conflicts, No edit is the behavior.  After
>         stopping for conflicts, the --no-edit flag is not saved so see
>         the first two rows.
>     
>     
>     However, the expected behavior is:
>     
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit iff isatty(0)
>     cherry-pick        No edit                 Edit iff isatty(0)
>     Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
>     Specify --no-edit  No edit                 No edit
>     
>     
>     In order to get the expected behavior, we need to change options.edit to
>     a tri-state: unspecified, false, or true. When specified, we follow what
>     it says. When unspecified, we need to check whether the current commit
>     being created is resolving a conflict as well as consulting
>     options.action and isatty(0). While at it, add a should_edit() utility
>     function that compresses options.edit down to a boolean based on the
>     additional information for the non-conflict case.
>     
>     Make continue_single_pick() (which is the function responsible for
>     resuming after conflict cases) stop assuming edit behavior in all cases,
>     so that it can correctly handle !isatty(0) and specific requests to not
>     edit the commit message.
>     
>     Reported-by: Renato Botelho garga@freebsd.org Signed-off-by: Elijah
>     Newren newren@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-988%2Fnewren%2Ffix-sequencer-no-edit-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-988/newren/fix-sequencer-no-edit-v1
> Pull-Request: https://github.com/git/git/pull/988
>
>  builtin/revert.c                |  4 +--
>  sequencer.c                     | 55 ++++++++++++++++++++++++++-------
>  sequencer.h                     |  6 ++--
>  t/t3510-cherry-pick-sequence.sh | 32 ++++++++++++++++++-
>  4 files changed, 80 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 314a86c5621b..81441020231a 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -182,7 +182,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
>  				"--signoff", opts->signoff,
>  				"--no-commit", opts->no_commit,
>  				"-x", opts->record_origin,
> -				"--edit", opts->edit,
> +				"--edit", opts->edit == 1,
>  				NULL);
>  
>  	if (cmd) {
> @@ -230,8 +230,6 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
>  	int res;
>  
> -	if (isatty(0))
> -		opts.edit = 1;
>  	opts.action = REPLAY_REVERT;
>  	sequencer_init_config(&opts);
>  	res = run_sequencer(argc, argv, &opts);
> diff --git a/sequencer.c b/sequencer.c
> index 848204d3dc3f..2fe0e0eff7e6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1860,14 +1860,26 @@ static void record_in_rewritten(struct object_id *oid,
>  		flush_rewritten_pending();
>  }
>  
> +static int should_edit(struct replay_opts *opts) {
> +	assert(opts->edit >= -1 && opts->edit <= 1);
> +	if (opts->edit == -1)
> +		/*
> +		 * Note the we only handle the case of non-conflicted

This 'Note the we' doesn't parse for me.
--
Philip
> +		 * commits; continue_single_pick() handles the conflicted
> +		 * commits itself instead of calling this function.
> +		 */
> +		return (opts->action == REPLAY_REVERT && isatty(0)) ? 1 : 0;
> +	return opts->edit;
> +}
> +
>  static int do_pick_commit(struct repository *r,
>  			  enum todo_command command,
>  			  struct commit *commit,
>  			  struct replay_opts *opts,
>  			  int final_fixup, int *check_todo)
>  {
> -	unsigned int flags = opts->edit ? EDIT_MSG : 0;
> -	const char *msg_file = opts->edit ? NULL : git_path_merge_msg(r);
> +	unsigned int flags = should_edit(opts) ? EDIT_MSG : 0;
> +	const char *msg_file = should_edit(opts) ? NULL : git_path_merge_msg(r);
>  	struct object_id head;
>  	struct commit *base, *next, *parent;
>  	const char *base_label, *next_label;
> @@ -3101,9 +3113,9 @@ static int save_opts(struct replay_opts *opts)
>  	if (opts->no_commit)
>  		res |= git_config_set_in_file_gently(opts_file,
>  					"options.no-commit", "true");
> -	if (opts->edit)
> -		res |= git_config_set_in_file_gently(opts_file,
> -					"options.edit", "true");
> +	if (opts->edit != -1)
> +		res |= git_config_set_in_file_gently(opts_file, "options.edit",
> +						     opts->edit ? "true" : "false");
>  	if (opts->allow_empty)
>  		res |= git_config_set_in_file_gently(opts_file,
>  					"options.allow-empty", "true");
> @@ -4077,7 +4089,7 @@ static int pick_commits(struct repository *r,
>  	prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
>  	if (opts->allow_ff)
>  		assert(!(opts->signoff || opts->no_commit ||
> -			 opts->record_origin || opts->edit ||
> +			 opts->record_origin || should_edit(opts) ||
>  			 opts->committer_date_is_author_date ||
>  			 opts->ignore_date));
>  	if (read_and_refresh_cache(r, opts))
> @@ -4370,14 +4382,35 @@ static int pick_commits(struct repository *r,
>  	return sequencer_remove_state(opts);
>  }
>  
> -static int continue_single_pick(struct repository *r)
> +static int continue_single_pick(struct repository *r, struct replay_opts *opts)
>  {
> -	const char *argv[] = { "commit", NULL };
> +	struct strvec argv = STRVEC_INIT;
> +	int want_edit;
> +	int ret;
>  
>  	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
>  	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
>  		return error(_("no cherry-pick or revert in progress"));
> -	return run_command_v_opt(argv, RUN_GIT_CMD);
> +
> +	strvec_push(&argv, "commit");
> +
> +	/*
> +	 * continue_single_pick() handles the case of recovering from a
> +	 * conflict.  should_edit() doesn't handle that case; for a conflict,
> +	 * we want to edit if the user asked for it, or if they didn't specify
> +	 * and stdin is a tty.
> +	 */
> +	want_edit = (opts->edit == 1) || ((opts->edit == -1) && isatty(0));
> +	if (!want_edit)
> +		/*
> +		 * Include --cleanup=strip as well because we don't want the
> +		 * "# Conflicts:" messages.
> +		 */
> +		strvec_pushl(&argv, "--no-edit", "--cleanup=strip", NULL);
> +
> +	ret = run_command_v_opt(argv.v, RUN_GIT_CMD);
> +	strvec_clear(&argv);
> +	return ret;
>  }
>  
>  static int commit_staged_changes(struct repository *r,
> @@ -4547,7 +4580,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>  			goto release_todo_list;
>  		}
>  	} else if (!file_exists(get_todo_path(opts)))
> -		return continue_single_pick(r);
> +		return continue_single_pick(r, opts);
>  	else if ((res = read_populate_todo(r, &todo_list, opts)))
>  		goto release_todo_list;
>  
> @@ -4556,7 +4589,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>  		if (refs_ref_exists(get_main_ref_store(r),
>  				    "CHERRY_PICK_HEAD") ||
>  		    refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
> -			res = continue_single_pick(r);
> +			res = continue_single_pick(r, opts);
>  			if (res)
>  				goto release_todo_list;
>  		}
> diff --git a/sequencer.h b/sequencer.h
> index f8b2e4ab8527..d57d8ea23d7a 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -31,8 +31,10 @@ enum commit_msg_cleanup_mode {
>  struct replay_opts {
>  	enum replay_action action;
>  
> -	/* Boolean options */
> +	/* Tri-state options: unspecified, false, or true */
>  	int edit;
> +
> +	/* Boolean options */
>  	int record_origin;
>  	int no_commit;
>  	int signoff;
> @@ -71,7 +73,7 @@ struct replay_opts {
>  	/* Only used by REPLAY_NONE */
>  	struct rev_info *revs;
>  };
> -#define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
> +#define REPLAY_OPTS_INIT { .edit = -1, .action = -1, .current_fixups = STRBUF_INIT }
>  
>  /*
>   * Note that ordering matters in this enum. Not only must it match the mapping
> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
> index b76cb6de91d0..49010aa9469d 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -65,7 +65,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
>  	# gets interrupted, use a high-enough number that is larger
>  	# than the number of parents of any commit we have created
>  	mainline=4 &&
> -	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours initial..anotherpick &&
> +	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours --edit initial..anotherpick &&
>  	test_path_is_dir .git/sequencer &&
>  	test_path_is_file .git/sequencer/head &&
>  	test_path_is_file .git/sequencer/todo &&
> @@ -84,6 +84,36 @@ test_expect_success 'cherry-pick persists opts correctly' '
>  	ours
>  	EOF
>  	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
> +	test_cmp expect actual &&
> +	echo "true" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.edit >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'revert persists opts correctly' '
> +	pristine_detach initial &&
> +	# to make sure that the session to revert a sequence
> +	# gets interrupted, revert commits that are not in the history
> +	# of HEAD.
> +	test_expect_code 1 git revert -s --strategy=recursive -X patience -X ours --no-edit picked yetanotherpick &&
> +	test_path_is_dir .git/sequencer &&
> +	test_path_is_file .git/sequencer/head &&
> +	test_path_is_file .git/sequencer/todo &&
> +	test_path_is_file .git/sequencer/opts &&
> +	echo "true" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
> +	test_cmp expect actual &&
> +	echo "recursive" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.strategy >actual &&
> +	test_cmp expect actual &&
> +	cat >expect <<-\EOF &&
> +	patience
> +	ours
> +	EOF
> +	git config --file=.git/sequencer/opts --get-all options.strategy-option >actual &&
> +	test_cmp expect actual &&
> +	echo "false" >expect &&
> +	git config --file=.git/sequencer/opts --get-all options.edit >actual &&
>  	test_cmp expect actual
>  '
>  
>
> base-commit: 98164e9585e02e31dcf1377a553efe076c15f8c6

