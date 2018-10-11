Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D88F1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJKStw (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:49:52 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22116 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeJKStw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:49:52 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AZ3WgymzAVlGZAZ3WgSaDg; Thu, 11 Oct 2018 12:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539256983;
        bh=U/dsEE2EG444VgRzcsB6Mabf/x4ugjOh8ad56G7abOg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=b2dNLfpeJFEUCLon3NGsmSz9wQfzvfugwI8QzMKISE/inSTHleXN93CeUqUZX/1Vg
         +P55kKev2Tx1R1rhN1E4kqPVSLy3Vju5EgnZemiJU7TZBlXUyQRkQ/Ug5nB4TrrwQN
         ZpSzvJah2KLg1BBZhZLy9iwogzFlg7rkjXErvwl4=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=uFnzFbruSwuNAIMaHqoA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/15] sequencer: refactor check_todo_list() to work on a
 todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-4-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <b87d71e4-7fa9-fc8b-90af-7baed2671aaa@talktalk.net>
Date:   Thu, 11 Oct 2018 12:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181007195418.25752-4-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAUr/B8YTBqTMFIAoUSpGkXsfTV7FdxRYKfxxRN7QgBGYpMTOUoSTZCC9kGh4BEe0ssOX2sEAQDv6n0s7cr3D4SHk5PX1x9aUB2tPx5jryiWcL2D2bhW
 b4VJsmD3zfGulzVwZCsepJ6ByG+efynMbctPr5WWqed/fVugjDK0ILTq9LRQHF+9PUVy8PV4BuSS9LM8ZLKTmxeME+jlTLlpPfCTDAV0eyeIB2yEAo5wrEGP
 5sKjJl61+7HyOceREgIWZtWocqT4SbC3O6yKEpyJTHU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

I like the direction that this series is going

On 07/10/2018 20:54, Alban Gruin wrote:
> This refactors check_todo_list() to work on a todo_list to avoid
> redundant reads and writes to the disk.  The function is renamed
> todo_list_check().
> 
> As rebase -p still need to check the todo list from the disk, a new
> function is introduced, check_todo_list_from_file().  It reads the file
> from the disk, parses it, pass the todo_list to todo_list_check(), and
> writes it back to the disk.

After this commit we still use check_todo_list_from_file() even without 
'-p', it would be clearer if this (and the following commits) mentioned 
that the new function will be wired up later.

> As get_missing_commit_check_level() and the enum
> missing_commit_check_level are no longer needed inside of sequencer.c,
> they are moved to rebase-interactive.c, and made static again.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase--interactive.c |   2 +-
>   rebase-interactive.c          | 106 ++++++++++++++++++++++++++++++++-
>   rebase-interactive.h          |   1 +
>   sequencer.c                   | 109 ++++------------------------------
>   sequencer.h                   |   9 +--
>   5 files changed, 120 insertions(+), 107 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index a2ab68ed06..ea1f93ccb6 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -255,7 +255,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>   		ret = transform_todos(flags);
>   		break;
>   	case CHECK_TODO_LIST:
> -		ret = check_todo_list();
> +		ret = check_todo_list_from_file();
>   		break;
>   	case REARRANGE_SQUASH:
>   		ret = rearrange_squash();
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index 0f4119cbae..ef8540245d 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -1,8 +1,32 @@
>   #include "cache.h"
>   #include "commit.h"
> -#include "rebase-interactive.h"
>   #include "sequencer.h"
> +#include "rebase-interactive.h"
>   #include "strbuf.h"
> +#include "commit-slab.h"
> +#include "config.h"
> +
> +enum missing_commit_check_level {
> +	MISSING_COMMIT_CHECK_IGNORE = 0,
> +	MISSING_COMMIT_CHECK_WARN,
> +	MISSING_COMMIT_CHECK_ERROR
> +};
> +
> +static enum missing_commit_check_level get_missing_commit_check_level(void)
> +{
> +	const char *value;
> +
> +	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
> +			!strcasecmp("ignore", value))
> +		return MISSING_COMMIT_CHECK_IGNORE;
> +	if (!strcasecmp("warn", value))
> +		return MISSING_COMMIT_CHECK_WARN;
> +	if (!strcasecmp("error", value))
> +		return MISSING_COMMIT_CHECK_ERROR;
> +	warning(_("unrecognized setting %s for option "
> +		  "rebase.missingCommitsCheck. Ignoring."), value);
> +	return MISSING_COMMIT_CHECK_IGNORE;
> +}
>   
>   void append_todo_help(unsigned edit_todo, unsigned keep_empty,
>   		      struct strbuf *buf)
> @@ -88,3 +112,83 @@ int edit_todo_list(unsigned flags)
>   
>   	return 0;
>   }
> +
> +define_commit_slab(commit_seen, unsigned char);
> +/*
> + * Check if the user dropped some commits by mistake
> + * Behaviour determined by rebase.missingCommitsCheck.
> + * Check if there is an unrecognized command or a
> + * bad SHA-1 in a command.
> + */
> +int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo)
> +{
> +	enum missing_commit_check_level check_level = get_missing_commit_check_level();
> +	struct strbuf missing = STRBUF_INIT;
> +	int advise_to_edit_todo = 0, res = 0, i;
> +	struct commit_seen commit_seen;
> +
> +	init_commit_seen(&commit_seen);
> +
> +	res = todo_list_parse_insn_buffer(old_todo->buf.buf, old_todo);

While it made sense to parse the old and new todo lists here when they 
were being loaded from a file, I think it is confusing to keep that 
behavior now it is being passed struct todo_lists. When we get to patch 
8 the newly read commit list is passed to this function without being 
parsed which confused me until I came back and check what was going on here.

Best Wishes

Phillip

> +	if (!res)
> +		res = todo_list_parse_insn_buffer(new_todo->buf.buf, new_todo);
> +	if (res) {
> +		advise_to_edit_todo = res;
> +		goto leave_check;
> +	}
> +
> +	if (check_level == MISSING_COMMIT_CHECK_IGNORE)
> +		goto leave_check;
> +
> +	/* Mark the commits in git-rebase-todo as seen */
> +	for (i = 0; i < new_todo->nr; i++) {
> +		struct commit *commit = new_todo->items[i].commit;
> +		if (commit)
> +			*commit_seen_at(&commit_seen, commit) = 1;
> +	}
> +
> +	/* Find commits in git-rebase-todo.backup yet unseen */
> +	for (i = old_todo->nr - 1; i >= 0; i--) {
> +		struct todo_item *item = old_todo->items + i;
> +		struct commit *commit = item->commit;
> +		if (commit && !*commit_seen_at(&commit_seen, commit)) {
> +			strbuf_addf(&missing, " - %s %.*s\n",
> +				    find_unique_abbrev(&commit->object.oid, DEFAULT_ABBREV),
> +				    item->arg_len, item->arg);
> +			*commit_seen_at(&commit_seen, commit) = 1;
> +		}
> +	}
> +
> +	/* Warn about missing commits */
> +	if (!missing.len)
> +		goto leave_check;
> +
> +	if (check_level == MISSING_COMMIT_CHECK_ERROR)
> +		advise_to_edit_todo = res = 1;
> +
> +	fprintf(stderr,
> +		_("Warning: some commits may have been dropped accidentally.\n"
> +		"Dropped commits (newer to older):\n"));
> +
> +	/* Make the list user-friendly and display */
> +	fputs(missing.buf, stderr);
> +	strbuf_release(&missing);
> +
> +	fprintf(stderr, _("To avoid this message, use \"drop\" to "
> +		"explicitly remove a commit.\n\n"
> +		"Use 'git config rebase.missingCommitsCheck' to change "
> +		"the level of warnings.\n"
> +		"The possible behaviours are: ignore, warn, error.\n\n"));
> +
> +leave_check:
> +	clear_commit_seen(&commit_seen);
> +
> +	if (advise_to_edit_todo)
> +		fprintf(stderr,
> +			_("You can fix this with 'git rebase --edit-todo' "
> +			  "and then run 'git rebase --continue'.\n"
> +			  "Or you can abort the rebase with 'git rebase"
> +			  " --abort'.\n"));
> +
> +	return res;
> +}
> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index 971da03776..6bc7bc315d 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -4,5 +4,6 @@
>   void append_todo_help(unsigned edit_todo, unsigned keep_empty,
>   		      struct strbuf *buf);
>   int edit_todo_list(unsigned flags);
> +int todo_list_check(struct todo_list *old_todo, struct todo_list *new_todo);
>   
>   #endif
> diff --git a/sequencer.c b/sequencer.c
> index bb8ca2477f..8dda61927c 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4487,111 +4487,26 @@ int transform_todos(unsigned flags)
>   	return i;
>   }
>   
> -enum missing_commit_check_level get_missing_commit_check_level(void)
> +int check_todo_list_from_file(void)
>   {
> -	const char *value;
> -
> -	if (git_config_get_value("rebase.missingcommitscheck", &value) ||
> -			!strcasecmp("ignore", value))
> -		return MISSING_COMMIT_CHECK_IGNORE;
> -	if (!strcasecmp("warn", value))
> -		return MISSING_COMMIT_CHECK_WARN;
> -	if (!strcasecmp("error", value))
> -		return MISSING_COMMIT_CHECK_ERROR;
> -	warning(_("unrecognized setting %s for option "
> -		  "rebase.missingCommitsCheck. Ignoring."), value);
> -	return MISSING_COMMIT_CHECK_IGNORE;
> -}
> -
> -define_commit_slab(commit_seen, unsigned char);
> -/*
> - * Check if the user dropped some commits by mistake
> - * Behaviour determined by rebase.missingCommitsCheck.
> - * Check if there is an unrecognized command or a
> - * bad SHA-1 in a command.
> - */
> -int check_todo_list(void)
> -{
> -	enum missing_commit_check_level check_level = get_missing_commit_check_level();
> -	struct strbuf todo_file = STRBUF_INIT;
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	struct strbuf missing = STRBUF_INIT;
> -	int advise_to_edit_todo = 0, res = 0, i;
> -	struct commit_seen commit_seen;
> -
> -	init_commit_seen(&commit_seen);
> +	struct todo_list old_todo = TODO_LIST_INIT, new_todo = TODO_LIST_INIT;
> +	int res = 0;
>   
> -	strbuf_addstr(&todo_file, rebase_path_todo());
> -	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
> +	if (strbuf_read_file_or_whine(&new_todo.buf, rebase_path_todo()) < 0) {
>   		res = -1;
> -		goto leave_check;
> -	}
> -	advise_to_edit_todo = res =
> -		todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
> -
> -	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
> -		goto leave_check;
> -
> -	/* Mark the commits in git-rebase-todo as seen */
> -	for (i = 0; i < todo_list.nr; i++) {
> -		struct commit *commit = todo_list.items[i].commit;
> -		if (commit)
> -			*commit_seen_at(&commit_seen, commit) = 1;
> +		goto out;
>   	}
>   
> -	todo_list_release(&todo_list);
> -	strbuf_addstr(&todo_file, ".backup");
> -	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file.buf) < 0) {
> +	if (strbuf_read_file_or_whine(&old_todo.buf, rebase_path_todo_backup()) < 0) {
>   		res = -1;
> -		goto leave_check;
> -	}
> -	strbuf_release(&todo_file);
> -	res = !!todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list);
> -
> -	/* Find commits in git-rebase-todo.backup yet unseen */
> -	for (i = todo_list.nr - 1; i >= 0; i--) {
> -		struct todo_item *item = todo_list.items + i;
> -		struct commit *commit = item->commit;
> -		if (commit && !*commit_seen_at(&commit_seen, commit)) {
> -			strbuf_addf(&missing, " - %s %.*s\n",
> -				    short_commit_name(commit),
> -				    item->arg_len, item->arg);
> -			*commit_seen_at(&commit_seen, commit) = 1;
> -		}
> +		goto out;
>   	}
>   
> -	/* Warn about missing commits */
> -	if (!missing.len)
> -		goto leave_check;
> -
> -	if (check_level == MISSING_COMMIT_CHECK_ERROR)
> -		advise_to_edit_todo = res = 1;
> +	res = todo_list_check(&old_todo, &new_todo);
>   
> -	fprintf(stderr,
> -		_("Warning: some commits may have been dropped accidentally.\n"
> -		"Dropped commits (newer to older):\n"));
> -
> -	/* Make the list user-friendly and display */
> -	fputs(missing.buf, stderr);
> -	strbuf_release(&missing);
> -
> -	fprintf(stderr, _("To avoid this message, use \"drop\" to "
> -		"explicitly remove a commit.\n\n"
> -		"Use 'git config rebase.missingCommitsCheck' to change "
> -		"the level of warnings.\n"
> -		"The possible behaviours are: ignore, warn, error.\n\n"));
> -
> -leave_check:
> -	clear_commit_seen(&commit_seen);
> -	strbuf_release(&todo_file);
> -	todo_list_release(&todo_list);
> -
> -	if (advise_to_edit_todo)
> -		fprintf(stderr,
> -			_("You can fix this with 'git rebase --edit-todo' "
> -			  "and then run 'git rebase --continue'.\n"
> -			  "Or you can abort the rebase with 'git rebase"
> -			  " --abort'.\n"));
> +out:
> +	todo_list_release(&old_todo);
> +	todo_list_release(&new_todo);
>   
>   	return res;
>   }
> @@ -4769,7 +4684,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
>   
>   	todo_list_release(&todo_list);
>   
> -	if (check_todo_list()) {
> +	if (check_todo_list_from_file()) {
>   		checkout_onto(opts, onto_name, onto, orig_head);
>   		return -1;
>   	}
> diff --git a/sequencer.h b/sequencer.h
> index c786dee543..fb8b85bf9e 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -63,12 +63,6 @@ struct replay_opts {
>   };
>   #define REPLAY_OPTS_INIT { .action = -1, .current_fixups = STRBUF_INIT }
>   
> -enum missing_commit_check_level {
> -	MISSING_COMMIT_CHECK_IGNORE = 0,
> -	MISSING_COMMIT_CHECK_WARN,
> -	MISSING_COMMIT_CHECK_ERROR
> -};
> -
>   int write_message(const void *buf, size_t len, const char *filename,
>   		  int append_eol);
>   
> @@ -142,8 +136,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
>   
>   int sequencer_add_exec_commands(const char *command);
>   int transform_todos(unsigned flags);
> -enum missing_commit_check_level get_missing_commit_check_level(void);
> -int check_todo_list(void);
> +int check_todo_list_from_file(void);
>   int complete_action(struct replay_opts *opts, unsigned flags,
>   		    const char *shortrevisions, const char *onto_name,
>   		    const char *onto, const char *orig_head, const char *cmd,
> 

