Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2AD1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 11:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfBGLJH (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 06:09:07 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:37284 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGLJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 06:09:06 -0500
Received: from [192.168.2.201] ([92.26.119.161])
        by smtp.talktalk.net with SMTP
        id rhYFgRtQeAGVrrhYFgf1bJ; Thu, 07 Feb 2019 11:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1549537744;
        bh=UWfjVLZyR+fnHrVxM+4hGaLVgHhUgQxmxp2FHR1K8YY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YZkE/6kfdeY0GI3v1Ez0bqopmBArpCrSoG2er3PiTqE6fz8N1yZ+p13W9tjKeis2K
         qnFyE+FLoiLYj2lm91NwKbxRTPVpje+ZvHqlO/zWTuZVUNhdRgjGZVltAHr7xonGgW
         mb92/rqE/xuXBcBj4ZoMZKl2xwmyUn82ey92Fdic=
X-Originating-IP: [92.26.119.161]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=6TU8oh9ZJkj8/yVa3BaM0A==:117
 a=6TU8oh9ZJkj8/yVa3BaM0A==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=NfWWnYjQfxFj3rPg3XgA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 07/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190129150159.10588-8-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <97f77aca-bd19-f763-349a-de40c4b94161@talktalk.net>
Date:   Thu, 7 Feb 2019 11:09:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129150159.10588-8-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEO/mA4dyRCbdvxAhZ8q4eEFpAUTJ/FXToWcnLIQ3J43EdIAYZAxQnPJE7oeAN9y0Fpr6fCyI+citZiTiRXcpVtTYGhOBXEKeJCFPF72hTmB7K8PTXVd
 kZOJmWiZRrYNtbEhZ8WJbx6uv9cuAt50pMOmvilzO5b5fKqmL4/h80iUp9zXFqjDHF1lI4mQ5TGrGTMVpcDKZ8DTLVrt7I8ZlNu19X8IEur+WvqUtwJoPSf3
 8yiofBHyBSzE4c0UjrTQj53SiI02PbimgZnhXUl2T0HRdKCo9IC76Z+CQF6eJ3rGvOm2fRkYxXq5QjVKExTGSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 29/01/2019 15:01, Alban Gruin wrote:
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
>  sequencer.c                   | 110 +++++++++++++++++++++-------------
>  sequencer.h                   |   5 +-
>  3 files changed, 82 insertions(+), 48 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index df19ccaeb9..53056ee713 100644
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

This is leaked, I think we should call string_list_clear() at the end.

Best Wishes

Phillip

>  	char *raw_strategies = NULL;
>  	enum {
>  		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
> @@ -221,6 +222,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  		warning(_("--[no-]rebase-cousins has no effect without "
>  			  "--rebase-merges"));
>  
> +	if (cmd && *cmd) {
> +		string_list_split(&commands, cmd, '\n', -1);
> +		if (strlen(commands.items[commands.nr - 1].string) == 0)
> +			--commands.nr;
> +	}
> +
>  	switch (command) {
>  	case NONE:
>  		if (!onto && !upstream)
> @@ -228,7 +235,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  
>  		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
>  					    onto_name, squash_onto, head_name, restrict_revision,
> -					    raw_strategies, cmd, autosquash);
> +					    raw_strategies, &commands, autosquash);
>  		break;
>  	case SKIP: {
>  		struct string_list merge_rr = STRING_LIST_INIT_DUP;
> @@ -262,7 +269,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>  		ret = rearrange_squash(the_repository);
>  		break;
>  	case ADD_EXEC:
> -		ret = sequencer_add_exec_commands(the_repository, cmd);
> +		ret = sequencer_add_exec_commands(the_repository, &commands);
>  		break;
>  	default:
>  		BUG("invalid command '%d'", command);
> diff --git a/sequencer.c b/sequencer.c
> index 266f80d704..3a90b419d7 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4446,25 +4446,27 @@ int sequencer_make_script(struct repository *r, FILE *out,
>  	return 0;
>  }
>  
> -/*
> - * Add commands after pick and (series of) squash/fixup commands
> - * in the todo list.
> - */
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
> +	for (i = 0; i < commands->nr; ++i) {
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
> @@ -4473,38 +4475,62 @@ int sequencer_add_exec_commands(struct repository *r,
>  	 * those chains if there are any.
>  	 */
>  	insert = -1;
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
> +	for (i = 0; i < todo_list->nr; i++) {
> +		enum todo_command command = todo_list->items[i].command;
> +		if (insert >= 0 && command != TODO_COMMENT && !is_fixup(command)) {
> +			ALLOC_GROW(items, nr + commands->nr, alloc);
> +			COPY_ARRAY(items + nr, base_items, commands->nr);
> +			nr += commands->nr;
>  			insert = -1;
>  		}
>  
> -		if (command == TODO_PICK || command == TODO_MERGE)
> +		ALLOC_GROW(items, nr + 1, alloc);
> +		items[nr++] = todo_list->items[i];
> +
> +		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
>  			insert = i + 1;
>  	}
>  
>  	/* insert or append final <commands> */
> -	if (insert >= 0 && insert < todo_list.nr)
> -		strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
> -			      offset, commands, commands_len);
> -	else if (insert >= 0 || !offset)
> -		strbuf_add(buf, commands, commands_len);
> +	if (insert >= 0 || nr == todo_list->nr) {
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
> +/*
> + * Add commands after pick and (series of) squash/fixup commands
> + * in the todo list.
> + */
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
> @@ -4735,7 +4761,7 @@ static int skip_unnecessary_picks(struct repository *r, struct object_id *output
>  
>  int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>  		    const char *shortrevisions, const char *onto_name,
> -		    const char *onto, const char *orig_head, const char *cmd,
> +		    const char *onto, const char *orig_head, struct string_list *commands,
>  		    unsigned autosquash)
>  {
>  	const char *shortonto, *todo_file = rebase_path_todo();
> @@ -4754,8 +4780,8 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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
> index 1de97f188d..e79f03e213 100644
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

