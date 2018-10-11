Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009721F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 13:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeJKVSe (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 17:18:34 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:36571 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeJKVSe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 17:18:34 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AbMug5aHpbZX5AbMugg52z; Thu, 11 Oct 2018 14:51:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539265873;
        bh=an5xR85F9kMdw1YV4NQgLl9HFgJFmmb+0fsMheN0RlY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kWblAFQiUJ875Na3CVzehq8cw57bUrzzSLcyDTlrgIP5n+VjgjIO1f75xCIgtpKgs
         ISXetEgh6BoD3+RR90ewAnOCot01zBpl5qZ8t5mDwywZkmxfvomdDXsVeSE2QzXpCt
         X5kE4SWmKV8nGyDqMCFC0GyYkn+au1yzwpTGEeZA=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ydE-0agOzRS_BDIq030A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 08/15] sequencer: change complete_action() to use the
 refactored functions
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-9-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d0adf861-3046-f0b6-3217-c89d92319e43@talktalk.net>
Date:   Thu, 11 Oct 2018 14:51:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181007195418.25752-9-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfN6WyQf3AF5lUfs4vpmcfcHdp3npGxC+8K78l9ODC6Rpb5efk+HzDZWZEJgi66+NpjwpZvLi4GFkHx6YdiBb6HFH2d3KW64Ypy8zvEsWAAWqWi7JpThA
 r7NUZQno8nLj+dPEHKodSNrvwzPvJKqjO0uV92W1PThdeaXNQ2/4TeQEBTzYIwT3D98fWvATaj8Y7GfpH1k9coXp8kfBbV/rpv+d1fHfM+Ey7APM2AJDDlCj
 1d+QE8KdDauE2ft1ora8JyGmtj/LeAHX48KGgsdjEXo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/2018 20:54, Alban Gruin wrote:
> complete_action() used functions that read the todo-list file, made some
> changes to it, and wrote it back to the disk.
> 
> The previous commits were dedicated to separate the part that deals with
> the file from the actual logic of these functions.  Now that this is
> done, we can call directly the "logic" functions to avoid useless file
> access.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   builtin/rebase--interactive.c | 13 +-----
>   sequencer.c                   | 76 +++++++++++++++++------------------
>   sequencer.h                   |  2 +-
>   3 files changed, 38 insertions(+), 53 deletions(-)
> 
> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
> index eef1ff2e83..0700339f90 100644
> --- a/builtin/rebase--interactive.c
> +++ b/builtin/rebase--interactive.c
> @@ -71,7 +71,6 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
>   	const char *head_hash = NULL;
>   	char *revisions = NULL, *shortrevisions = NULL;
>   	struct argv_array make_script_args = ARGV_ARRAY_INIT;
> -	FILE *todo_list_file;
>   	struct todo_list todo_list = TODO_LIST_INIT;
>   
>   	if (prepare_branch_to_be_rebased(opts, switch_to))
> @@ -94,14 +93,6 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
>   	if (!upstream && squash_onto)
>   		write_file(path_squash_onto(), "%s\n", squash_onto);
>   
> -	todo_list_file = fopen(rebase_path_todo(), "w");
> -	if (!todo_list_file) {
> -		free(revisions);
> -		free(shortrevisions);
> -
> -		return error_errno(_("could not open %s"), rebase_path_todo());
> -	}
> -
>   	argv_array_pushl(&make_script_args, "", revisions, NULL);
>   	if (restrict_revision)
>   		argv_array_push(&make_script_args, restrict_revision);
> @@ -109,15 +100,13 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
>   	ret = sequencer_make_script(&todo_list.buf,
>   				    make_script_args.argc, make_script_args.argv,
>   				    flags);

I think it would be clearer to parse the todo list here explicitly 
rather than doing it implicitly in complete_action()

> -	fputs(todo_list.buf.buf, todo_list_file);
> -	fclose(todo_list_file);
>   
>   	if (ret)
>   		error(_("could not generate todo list"));
>   	else {
>   		discard_cache() >   		ret = complete_action(opts, flags, shortrevisions, onto_name, onto,
> -				      head_hash, cmd, autosquash);
> +				      head_hash, cmd, autosquash, &todo_list);
>   	}
>   
>   	free(revisions);
> diff --git a/sequencer.c b/sequencer.c
> index dfb8d1c974..b37935e5ab 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4624,93 +4624,89 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
>   	return 0;
>   }
>   
> +static int todo_list_rearrange_squash(struct todo_list *todo_list);
> +
>   int complete_action(struct replay_opts *opts, unsigned flags,
>   		    const char *shortrevisions, const char *onto_name,
>   		    const char *onto, const char *orig_head, const char *cmd,
> -		    unsigned autosquash)
> +		    unsigned autosquash, struct todo_list *todo_list)
>   {
>   	const char *shortonto, *todo_file = rebase_path_todo();
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	struct strbuf *buf = &(todo_list.buf);
> +	struct todo_list new_todo = TODO_LIST_INIT;
> +	struct strbuf *buf = &todo_list->buf;
>   	struct object_id oid;
> -	struct stat st;
> +	int command_count;
>   
>   	get_oid(onto, &oid);
>   	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
>   
> -	if (!lstat(todo_file, &st) && st.st_size == 0 &&
> -	    write_message("noop\n", 5, todo_file, 0))
> -		return -1;
> +	if (buf->len == 0)
> +		strbuf_add(buf, "noop\n", 5);
> +
> +	if (todo_list_parse_insn_buffer(buf->buf, todo_list))
> +		BUG("unusable todo list");
>   
> -	if (autosquash && rearrange_squash_in_todo_file())
> +	if (autosquash && todo_list_rearrange_squash(todo_list))
>   		return -1;
>   
>   	if (cmd && *cmd)
> -		sequencer_add_exec_commands(cmd);
> +		todo_list_add_exec_commands(todo_list, cmd);
>   
> -	if (strbuf_read_file(buf, todo_file, 0) < 0)
> -		return error_errno(_("could not read '%s'."), todo_file);
> -
> -	if (todo_list_parse_insn_buffer(buf->buf, &todo_list)) {
> -		todo_list_release(&todo_list);
> -		return error(_("unusable todo list: '%s'"), todo_file);
> -	}
> -
> -	if (count_commands(&todo_list) == 0) {
> +	command_count = count_commands(todo_list);
> +	if (command_count == 0) {
>   		apply_autostash(opts);
>   		sequencer_remove_state(opts);
> -		todo_list_release(&todo_list);
>   
>   		return error(_("nothing to do"));
>   	}
>   
> +	todo_list_transform(todo_list, flags | TODO_LIST_SHORTEN_IDS);
> +
>   	strbuf_addch(buf, '\n');
>   	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
>   				      "Rebase %s onto %s (%d commands)",
> -				      count_commands(&todo_list)),
> -			      shortrevisions, shortonto, count_commands(&todo_list));
> +				      command_count),
> +			      shortrevisions, shortonto, command_count);
>   	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
>   
> -	if (write_message(buf->buf, buf->len, todo_file, 0)) {
> -		todo_list_release(&todo_list);
> -		return -1;
> -	}
> +	if (write_message(buf->buf, buf->len, todo_file, 0))
> +		return error_errno(_("could not write '%s'"), todo_file);
>   
>   	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
>   		return error(_("could not copy '%s' to '%s'."), todo_file,
>   			     rebase_path_todo_backup());
>   
> -	if (transform_todo_file(flags | TODO_LIST_SHORTEN_IDS))
> -		return error(_("could not transform the todo list"));
> -
> -	strbuf_reset(buf);
> -
> -	if (launch_sequence_editor(todo_file, buf, NULL)) {
> +	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
>   		apply_autostash(opts);
>   		sequencer_remove_state(opts);
> -		todo_list_release(&todo_list);
>   
>   		return -1;
>   	}
>   
> -	strbuf_stripspace(buf, 1);
> -	if (buf->len == 0) {
> +	strbuf_stripspace(&new_todo.buf, 1);
> +	if (new_todo.buf.len == 0) {
>   		apply_autostash(opts);
>   		sequencer_remove_state(opts);
> -		todo_list_release(&todo_list);
> +		todo_list_release(&new_todo);
>   
>   		return error(_("nothing to do"));
>   	}
>   
> -	todo_list_release(&todo_list);
> -
> -	if (check_todo_list_from_file()) {
> +	if (todo_list_check(todo_list, &new_todo)) {
>   		checkout_onto(opts, onto_name, onto, orig_head);
> +		todo_list_release(&new_todo);
> +
>   		return -1;
>   	}
>   
> -	if (transform_todo_file(flags & ~(TODO_LIST_SHORTEN_IDS)))
> -		return error(_("could not transform the todo list"));
> +	todo_list_transform(&new_todo, flags & ~(TODO_LIST_SHORTEN_IDS));
> +
> +	if (rewrite_file(todo_file, new_todo.buf.buf, new_todo.buf.len) < 0) {
> +		todo_list_release(&new_todo);
> +		return error_errno(_("could not write '%s'"), todo_file);
> +	}

rewrite_file() can truncate the old version of the file if there is an 
error when writing the new version, I think it would be better to use 
write_message() instead as that atomically updates the file. The same 
applies to patch 5 (refactor rearrange_squash()) after which I think 
there will be no callers to rewrite_file() so it can be deleted.

Best Wishes

Phillip

> +
> +	todo_list_release(&new_todo);
>   
>   	if (opts->allow_ff && skip_unnecessary_picks(&oid))
>   		return error(_("could not skip unnecessary pick commands"));
> diff --git a/sequencer.h b/sequencer.h
> index 21d9ba09ab..5bd3b79282 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -141,7 +141,7 @@ int check_todo_list_from_file(void);
>   int complete_action(struct replay_opts *opts, unsigned flags,
>   		    const char *shortrevisions, const char *onto_name,
>   		    const char *onto, const char *orig_head, const char *cmd,
> -		    unsigned autosquash);
> +		    unsigned autosquash, struct todo_list *todo_list);
>   int rearrange_squash_in_todo_file(void);
>   
>   extern const char sign_off_header[];
> 

