Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46DDB1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 11:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJKSw1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 14:52:27 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:58890 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeJKSw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 14:52:26 -0400
Received: from [192.168.2.240] ([92.28.142.68])
        by smtp.talktalk.net with SMTP
        id AZ5zgynVlVlGZAZ5zgSaKx; Thu, 11 Oct 2018 12:25:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539257136;
        bh=BWfWWr/3ahGfRfnfplKbVdDkk3hCGYYhTIyNXabNJsg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=f42PsNJzvRiNc8ksjETWeP73M+rgiFzUwZZTYOvZ9cu89OOj5UunBbyTDxG8aIJPK
         xH6UrXSxmyMPpgYVb58fOOZEpjUfbbvEzav9bc2iF01Nne5HQK7k3sxMb5k3O9SCAX
         5pK9ezqb1mRFkG+omEbEoaPVTIupd3TTyElNy1m4=
X-Originating-IP: [92.28.142.68]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=UGDAwvN9cmeZh0o4udnnNw==:117
 a=UGDAwvN9cmeZh0o4udnnNw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=IAWz5USDbM__wxkDbm4A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/15] sequencer: refactor sequencer_add_exec_commands()
 to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-5-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6188911e-fd21-4c7c-885d-a15d2b46aa86@talktalk.net>
Date:   Thu, 11 Oct 2018 12:25:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181007195418.25752-5-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOXV2KmWWGKKGWOikrguYPu9/PSubJw1Gdx0mbzcZZf5vW1Mj43HRGmCSNPwDyMrHqvRQowtN04bcwErwfhoZDu4IsTXYLUFxyc0o5wWEVOtZilOWwy+
 PMp5dxox+UBaOZyOWfTISVmWEVyGnNsQ5iGtGyCwVvwMUzCZQPCDp5DuR0nYR3YU0WQElTf6yBQ5+b1ixQLto+JeNvzxmzSZeALHgWs3TuEFUbl2XLEQ+29U
 clU2UywbG2vGjiQsY3ngjlmaH2frk05rPojlXRMEmEE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/2018 20:54, Alban Gruin wrote:
> This refactors sequencer_add_exec_commands() to work on a todo_list to
> avoid redundant reads and writes to the disk.
> 
> sequencer_add_exec_commands() still reads the todo list from the disk,
> as it is needed by rebase -p.  todo_list_add_exec_commands() works on a
> todo_list structure, and reparses it at the end.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   sequencer.c | 56 +++++++++++++++++++++++++++++++----------------------
>   1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 8dda61927c..6d998f21a4 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4370,34 +4370,21 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
>   	return 0;
>   }
>   
> -/*
> - * Add commands after pick and (series of) squash/fixup commands
> - * in the todo list.
> - */
> -int sequencer_add_exec_commands(const char *commands)
> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
> +					const char *commands)
>   {
> -	const char *todo_file = rebase_path_todo();
> -	struct todo_list todo_list = TODO_LIST_INIT;
> -	struct strbuf *buf = &todo_list.buf;
> +	struct strbuf *buf = &todo_list->buf;
>   	size_t offset = 0, commands_len = strlen(commands);
>   	int i, insert;
>   
> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> -		return error(_("could not read '%s'."), todo_file);
> -
> -	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
> -		todo_list_release(&todo_list);
> -		return error(_("unusable todo list: '%s'"), todo_file);
> -	}
> -
>   	/*
>   	 * Insert <commands> after every pick. Here, fixup/squash chains
>   	 * are considered part of the pick, so we insert the commands *after*
>   	 * those chains if there are any.
>   	 */
>   	insert = -1;
> -	for (i = 0; i < todo_list.nr; i++) {
> -		enum todo_command command = todo_list.items[i].command;
> +	for (i = 0; i < todo_list->nr; i++) {
> +		enum todo_command command = todo_list->items[i].command;
>   
>   		if (insert >= 0) {
>   			/* skip fixup/squash chains */
> @@ -4408,7 +4395,7 @@ int sequencer_add_exec_commands(const char *commands)
>   				continue;
>   			}
>   			strbuf_insert(buf,
> -				      todo_list.items[insert].offset_in_buf +
> +				      todo_list->items[insert].offset_in_buf +
>   				      offset, commands, commands_len);
>   			offset += commands_len;
>   			insert = -1;
> @@ -4419,15 +4406,38 @@ int sequencer_add_exec_commands(const char *commands)
>   	}
>   
>   	/* insert or append final <commands> */
> -	if (insert >= 0 && insert < todo_list.nr)
> -		strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
> +	if (insert >= 0 && insert < todo_list->nr)
> +		strbuf_insert(buf, todo_list->items[insert].offset_in_buf +
>   			      offset, commands, commands_len);
>   	else if (insert >= 0 || !offset)
>   		strbuf_add(buf, commands, commands_len);
>   
> -	i = write_message(buf->buf, buf->len, todo_file, 0);
> +	if (todo_list_parse_insn_buffer(buf->buf, todo_list))
> +		BUG("unusable todo list");}

It is a shame to have to re-parse the todo list, I wonder how difficult 
it would be to adjust the todo_list item array as the exec commands are 
inserted. The same applies to the next couple of patches

Best Wishes

Phillip

> +
> +/*
> + * Add commands after pick and (series of) squash/fixup commands
> + * in the todo list.
> + */
> +int sequencer_add_exec_commands(const char *commands)
> +{
> +	const char *todo_file = rebase_path_todo();
> +	struct todo_list todo_list = TODO_LIST_INIT;
> +	int res;
> +
> +	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
> +		return error(_("could not read '%s'."), todo_file);
> +
> +	if (todo_list_parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
> +		todo_list_release(&todo_list);
> +		return error(_("unusable todo list: '%s'"), todo_file);
> +	}
> +
> +	todo_list_add_exec_commands(&todo_list, commands);
> +	res = write_message(todo_list.buf.buf, todo_list.buf.len, todo_file, 0);
>   	todo_list_release(&todo_list);
> -	return i;
> +
> +	return res;
>   }
>   
>   int transform_todos(unsigned flags)
> 

