Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34E41F453
	for <e@80x24.org>; Tue, 12 Feb 2019 10:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfBLKw3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 05:52:29 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:22815 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfBLKw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 05:52:29 -0500
Received: from [192.168.2.201] ([92.22.16.34])
        by smtp.talktalk.net with SMTP
        id tVfqgcIDyAGVrtVfrghza5; Tue, 12 Feb 2019 10:52:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1549968746;
        bh=ajWCDV+8kNd2gLN0JveCnwkta18sud/vHg9aPxSZuJE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=pCxfNiXSMyNWlcQxT9O1JMf3EsLNQ9p9gXUG850u9rIrS22JgAFoD00g+Zd7PPbBa
         roz6c4J5KbOC+HB8Bk/OHyEcEXCnQKSvx+TBP56b+ND7BN5r60zDFlQUe1Emtdj3wh
         nCjERwid7bGUY1J9LsdvqN2aBnlI9t30RrGB/1qU=
X-Originating-IP: [92.22.16.34]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=W5dqCoKFvwrB3nI5M4amZw==:117
 a=W5dqCoKFvwrB3nI5M4amZw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=f3jF1l5YNqFSaqkU-qwA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 07/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190210132648.12821-8-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4c8f904a-329c-a42c-c2a4-06d5b348dce3@talktalk.net>
Date:   Tue, 12 Feb 2019 10:52:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190210132648.12821-8-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI+BAdZRFSg5r6VVgOg1EIEpuhW4Z8T/3zwNoadR8Uaq/5czQdssZl6ktVtwd9wg82xs/CWO8zNkhojhUDudpNkkkl656zOoTm3qPvdbZQ3IdUHmd5K0
 8KLsGE3eXdWOVXdQlblPTUPjrIjFR26FmSMcbNxVmJBEOce2LU0DQYHu4Z6B9NLyogL56YK+JNhdrg/GNTYKkqZ1FqYbkb11uahyhxJpqE7jZSmYhjZ4Su7P
 D6/8Qipj/Ojx8BZcoE9NfSu9oYZUyyWvfuqMyh9rB9boweW6/MhYUoD7xwpEqyoWnSD75zhNFwdW8COmEgCsFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

I think this is almost there, I've got a couple of small comments below.

On 10/02/2019 13:26, Alban Gruin wrote:
> This refactors sequencer_add_exec_commands() to work on a todo_list to
> avoid redundant reads and writes to the disk.
> 
> Instead of inserting the `exec' commands between the other commands and
> re-parsing the buffer at the end, they are appended to the buffer once,
> and a new list of items is created.  Items from the old list are copied
> across and new `exec' items are appended when necessary.  This
> eliminates the need to reparse the buffer, but this also means we have
> to use todo_list_write_to_disk() to write the file.
> 
> todo_list_add_exec_commands() and sequencer_add_exec_commands() are
> modified to take a string list instead of a string -- one item for each
> command.  This makes it easier to insert a new command to the todo list
> for each command to execute.
> 
> sequencer_add_exec_commands() still reads the todo list from the disk,
> as it is needed by rebase -p.
> 
> complete_action() still uses sequencer_add_exec_commands() for now.
> This will be changed in a future commit.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/rebase--interactive.c |  15 +++--
>  sequencer.c                   | 109 +++++++++++++++++++++-------------
>  sequencer.h                   |   5 +-
>  3 files changed, 82 insertions(+), 47 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index df19ccaeb9..c131fd4a27 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -65,7 +65,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
>  				 const char *onto, const char *onto_name,
>  				 const char *squash_onto, const char *head_name,
>  				 const char *restrict_revision, char *raw_strategies,
> -				 const char *cmd, unsigned autosquash)
> +				 struct string_list *commands, unsigned autosquash)
>  {
>  	int ret;
>  	const char *head_hash = NULL;
> @@ -116,7 +116,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
>  		discard_cache();
>  		ret = complete_action(the_repository, opts, flags,
>  				      shortrevisions, onto_name, onto,
> -				      head_hash, cmd, autosquash);
> +				      head_hash, commands, autosquash);
>  	}
>  
>  	free(revisions);
> @@ -139,6 +139,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  	const char *onto = NULL, *onto_name = NULL, *restrict_revision = NULL,
>  		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
>  		*switch_to = NULL, *cmd = NULL;
> +	struct string_list commands = STRING_LIST_INIT_DUP;
>  	char *raw_strategies = NULL;
>  	enum {
>  		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
> @@ -221,6 +222,11 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  		warning(_("--[no-]rebase-cousins has no effect without "
>  			  "--rebase-merges"));
>  
> +	if (cmd && *cmd) {
> +		string_list_split(&commands, cmd, '\n', -1);

I'd suggest a comment along the lines of
/* As cmd always ends with a newline the last item is empty */

> +		--commands.nr;

Style: commands.nr--

> +	}
> +
>  	switch (command) {
>  	case NONE:
>  		if (!onto && !upstream)
> @@ -228,7 +234,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  
>  		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
>  					    onto_name, squash_onto, head_name, restrict_revision,
> -					    raw_strategies, cmd, autosquash);
> +					    raw_strategies, &commands, autosquash);
>  		break;
>  	case SKIP: {
>  		struct string_list merge_rr = STRING_LIST_INIT_DUP;
> @@ -262,11 +268,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  		ret = rearrange_squash(the_repository);
>  		break;
>  	case ADD_EXEC:
> -		ret = sequencer_add_exec_commands(the_repository, cmd);
> +		ret = sequencer_add_exec_commands(the_repository, &commands);
>  		break;
>  	default:
>  		BUG("invalid command '%d'", command);
>  	}

Before freeing the string list it would be good to reset the number of
items with commands.nr++ (with a comment explaining why) so the NUL in
the last item gets freed.

> +	string_list_clear(&commands, 1);

As we don't use item.util I think the second argument would be better as 0.

>  	return !!ret;
>  }
> diff --git a/sequencer.c b/sequencer.c
> index 99e12c751e..82ca3432cd 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4505,21 +4505,27 @@ int sequencer_make_script(struct repository *r, FILE *out,
>   * Add commands after pick and (series of) squash/fixup commands
>   * in the todo list.
>   */
> -int sequencer_add_exec_commands(struct repository *r,
> -				const char *commands)
> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
> +					struct string_list *commands)
>  {
> -	const char *todo_file = rebase_path_todo();
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	struct strbuf *buf = &todo_list.buf;
> -	size_t offset = 0, commands_len = strlen(commands);
> -	int i, insert;
> +	struct strbuf *buf = &todo_list->buf;
> +	size_t base_offset = buf->len;
> +	int i, insert, nr = 0, alloc = 0;
> +	struct todo_item *items = NULL, *base_items = NULL;
>  
> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> -		return error(_("could not read '%s'."), todo_file);
> +	base_items = xcalloc(commands->nr, sizeof(struct todo_item));
> +	for (i = 0; i < commands->nr; i++) {
> +		size_t command_len = strlen(commands->items[i].string);
>  
> -	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
> -		todo_list_release(&todo_list);
> -		return error(_("unusable todo list: '%s'"), todo_file);
> +		strbuf_addstr(buf, commands->items[i].string);
> +		strbuf_addch(buf, '\n');
> +
> +		base_items[i].command = TODO_EXEC;
> +		base_items[i].offset_in_buf = base_offset;
> +		base_items[i].arg_offset = base_offset + strlen("exec ");
> +		base_items[i].arg_len = command_len - strlen("exec ");
> +
> +		base_offset += command_len + 1;
>  	}
>  
>  	/*
> @@ -4527,39 +4533,60 @@ int sequencer_add_exec_commands(struct repository *r,
>  	 * are considered part of the pick, so we insert the commands *after*
>  	 * those chains if there are any.
>  	 */
> -	insert = -1;
> -	for (i = 0; i < todo_list.nr; i++) {
> -		enum todo_command command = todo_list.items[i].command;
> -
> -		if (insert >= 0) {
> -			/* skip fixup/squash chains */
> -			if (command == TODO_COMMENT)
> -				continue;
> -			else if (is_fixup(command)) {
> -				insert = i + 1;
> -				continue;
> -			}
> -			strbuf_insert(buf,
> -				      todo_list.items[insert].offset_in_buf +
> -				      offset, commands, commands_len);
> -			offset += commands_len;
> -			insert = -1;

I like the simplification of using insert as a flag. Perhaps we should
document the assumptions. Maybe something like

We insert the exec commands immediately after rearranging any fixups and
before the user edits the list. This means that a fixup chain can never
contain comments (any comments are empty picks that have been commented
out the the user did not specify --keep-empty) and so it is safe to
insert the exec command without looking at the command following the
comment.

> +	insert = 0;
> +	for (i = 0; i < todo_list->nr; i++) {
> +		enum todo_command command = todo_list->items[i].command;
> +		if (insert && !is_fixup(command)) {
> +			ALLOC_GROW(items, nr + commands->nr, alloc);
> +			COPY_ARRAY(items + nr, base_items, commands->nr);
> +			nr += commands->nr;
> +
> +			insert = 0;
>  		}
>  
> -		if (command == TODO_PICK || command == TODO_MERGE)
> -			insert = i + 1;
> +		ALLOC_GROW(items, nr + 1, alloc);
> +		items[nr++] = todo_list->items[i];
> +
> +		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))

I'm not sure what the is_fixup() is for, if the command is a fixup then
it will have been preceded by a pick or merge so insert will already be 1

I feel a bit mean suggesting a reroll when we're on v7 already but I
think these clean-ups would improve the maintainability of the code.
I'll take a look at the rest of the changes to this series sometime this
week.

Best Wishes

Phillip

> +			insert = 1;
>  	}
>  
>  	/* insert or append final <commands> */
> -	if (insert >= 0 && insert < todo_list.nr)
> -		strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
> -			      offset, commands, commands_len);
> -	else if (insert >= 0 || !offset)
> -		strbuf_add(buf, commands, commands_len);
> +	if (insert || nr == todo_list->nr) {
> +		ALLOC_GROW(items, nr + commands->nr, alloc);
> +		COPY_ARRAY(items + nr, base_items, commands->nr);
> +		nr += commands->nr;
> +	}
> +
> +	free(base_items);
> +	FREE_AND_NULL(todo_list->items);
> +	todo_list->items = items;
> +	todo_list->nr = nr;
> +	todo_list->alloc = alloc;
> +}
>  
> -	i = write_message(buf->buf, buf->len, todo_file, 0);
> +int sequencer_add_exec_commands(struct repository *r,
> +				struct string_list *commands)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int res;
> +
> +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> +		return error_errno(_("could not read '%s'."), todo_file);
> +
> +	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);
> +	}
> +
> +	todo_list_add_exec_commands(&todo_list, commands);
> +	res = todo_list_write_to_file(r, &todo_list, todo_file, NULL, NULL, -1, 0);
>  	todo_list_release(&todo_list);
> -	return i;
> +
> +	if (res)
> +		return error_errno(_("could not write '%s'."), todo_file);
> +	return 0;
>  }
>  
>  static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
> @@ -4790,7 +4817,7 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
>  
>  int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>  		    const char *shortrevisions, const char *onto_name,
> -		    const char *onto, const char *orig_head, const char *cmd,
> +		    const char *onto, const char *orig_head, struct string_list *commands,
>  		    unsigned autosquash)
>  {
>  	const char *shortonto, *todo_file = rebase_path_todo();
> @@ -4809,8 +4836,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>  	if (autosquash && rearrange_squash(r))
>  		return -1;
>  
> -	if (cmd && *cmd)
> -		sequencer_add_exec_commands(r, cmd);
> +	if (commands->nr)
> +		sequencer_add_exec_commands(r, commands);
>  
>  	if (strbuf_read_file(buf, todo_file, 0) < 0)
>  		return error_errno(_("could not read '%s'."), todo_file);
> diff --git a/sequencer.h b/sequencer.h
> index 217353e9f0..87d04a3b9b 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -146,12 +146,13 @@ int sequencer_make_script(struct repository *r, FILE *out, int argc,
>  			  const char **argv,
>  			  unsigned flags);
>  
> -int sequencer_add_exec_commands(struct repository *r, const char *command);
> +int sequencer_add_exec_commands(struct repository *r,
> +				struct string_list *commands);
>  int transform_todo_file(struct repository *r, unsigned flags);
>  int check_todo_list_from_file(struct repository *r);
>  int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>  		    const char *shortrevisions, const char *onto_name,
> -		    const char *onto, const char *orig_head, const char *cmd,
> +		    const char *onto, const char *orig_head, struct string_list *commands,
>  		    unsigned autosquash);
>  int rearrange_squash(struct repository *r);
>  
> 

