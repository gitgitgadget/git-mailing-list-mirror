Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46EAD1F454
	for <e@80x24.org>; Tue, 30 Oct 2018 16:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJaBlh (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 21:41:37 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:23456 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeJaBlh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 21:41:37 -0400
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id HXAngWa3rpXFjHXAngC1Sy; Tue, 30 Oct 2018 16:47:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1540918042;
        bh=jf2Ck5dM2wGy6srRzuiXlvVaT01xKpNkeXcZUg42bh8=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TUTmVQjB6w/tq9K0fsdRT4GaeQZxbz3xVQCXcDFMxCJKEwIioTWEpgWpIdarst+Z9
         /n0Zeoxc4omrsAuBqGk5biMxD7WzXlJfMovzz8zAxZZ2/RQhPTG3ycO3n3qGFBOOgR
         QUdHJJz8xjIR8J1eSmHDrV5X6js/tYfuaPtDcKe0=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ZaSOmg4lNZTgWZJ-H9cA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 06/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181027212930.9303-7-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <12e849d3-351b-7673-1f14-742d0fbb1ac1@talktalk.net>
Date:   Tue, 30 Oct 2018 16:47:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181027212930.9303-7-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOHViCo+d7S/FLLBNoE4sJP37wtrw7/arD2WKLBBmNIY+3P0s/YsEoOApt1oFykzZRqcAG/Lw2GdJVV1p0lnYWDpOLRlUJRJOo7rq2UCL5n9LkYUwod7
 jDgDrKadsCTzSVsY9JQRcIJmU/iFbXgNFU1oYxlzhoUZ4ylKe6R050f4GGAJ8D8lrNRoHTC+KneN/PTjmp/j4ObREor9gGCAJd/iZg3URiJ+biK4wE1MbtTV
 Y7vEYgDOcXQJpPF4+lcJ3tgQmXr0gAfbhZKbDNXoB4c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/10/2018 22:29, Alban Gruin wrote:
> This refactors sequencer_add_exec_commands() to work on a todo_list to
> avoid redundant reads and writes to the disk.
> 
> An obvious way to do this would be to insert the `exec' command between
> the other commands, and reparse it once this is done.  This is not what
> is done here.  Instead, the command is appended to the buffer once, and
> a new list of items is created.  Items from the old list are copied to
> it, and new `exec' items are appended when necessary.  This eliminates
> the need to reparse the todo list, but this also means its buffer cannot
> be directly written to the disk, hence todo_list_write_to_disk().

I'd reword this slightly, maybe

Instead of just inserting the `exec' command between the other commands, 
and re-parsing the buffer at the end the exec command is appended to the 
buffer once, and a new list of items is created.  Items from the old 
list are copied across and new `exec' items are appended when necessary. 
  This eliminates the need to reparse the buffer, but this also means we 
have to use todo_list_write_to_disk() to write the file.

> sequencer_add_exec_commands() still reads the todo list from the disk,
> as it is needed by rebase -p.  todo_list_add_exec_commands() works on a
> todo_list structure, and reparses it at the end.

I think the saying 'reparses' is confusing as that is what we're trying 
to avoid.

> complete_action() still uses sequencer_add_exec_commands() for now.
> This will be changed in a future commit.
> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>   sequencer.c | 69 +++++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 49 insertions(+), 20 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e12860c047..12a3efeca8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4216,6 +4216,50 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
>   	return 0;
>   }
>   
> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
> +					const char *commands)
> +{
> +	struct strbuf *buf = &todo_list->buf;
> +	const char *old_buf = buf->buf;
> +	size_t commands_len = strlen(commands + strlen("exec ")) - 1;
> +	int i, first = 1, nr = 0, alloc = 0;

Minor nit pick, I think it is clearer if first is initialized just 
before the loop as it is in the deleted code below.

> +	struct todo_item *items = NULL,
> +		base_item = {TODO_EXEC, NULL, 0, 0, commands_len, 0};
> +
> +	strbuf_addstr(buf, commands);
> +	base_item.offset_in_buf = buf->len - commands_len - 1;
> +	base_item.arg = buf->buf + base_item.offset_in_buf;

I think if the user gives --exec more than once on the command line then 
commands will contain more than one exec command so this needs to parse 
commands and create one todo_item for each command.

> +
> +	/*
> +	 * Insert <commands> after every pick. Here, fixup/squash chains
> +	 * are considered part of the pick, so we insert the commands *after*
> +	 * those chains if there are any.
> +	 */
> +	for (i = 0; i < todo_list->nr; i++) {
> +		enum todo_command command = todo_list->items[i].command;
> +		if (todo_list->items[i].arg)
> +			todo_list->items[i].arg = todo_list->items[i].arg - old_buf + buf->buf;
> +
> +		if (command == TODO_PICK && !first) {
> +			ALLOC_GROW(items, nr + 1, alloc);
> +			memcpy(items + nr++, &base_item, sizeof(struct todo_item));

I think it would be clearer to say
	items[nr++] = base_item;
rather than using memcpy. This applies below and to some of the other 
patches as well. Also this needs to loop over all the base_items if the 
user gave --exec more than once on the command line.

Best Wishes

Phillip

> +		}
> +
> +		ALLOC_GROW(items, nr + 1, alloc);
> +		memcpy(items + nr++, todo_list->items + i, sizeof(struct todo_item));
> +		first = 0;
> +	}
> +
> +	/* insert or append final <commands> */
> +	ALLOC_GROW(items, nr + 1, alloc);
> +	memcpy(items + nr++, &base_item, sizeof(struct todo_item));
> +
> +	FREE_AND_NULL(todo_list->items);
> +	todo_list->items = items;
> +	todo_list->nr = nr;
> +	todo_list->alloc = alloc;
> +}
> +
>   /*
>    * Add commands after pick and (series of) squash/fixup commands
>    * in the todo list.
> @@ -4224,10 +4268,7 @@ int sequencer_add_exec_commands(const char *commands)
>   {
>   	const char *todo_file = rebase_path_todo();
>   	struct todo_list todo_list = TODO_LIST_INIT;
> -	struct todo_item *item;
> -	struct strbuf *buf = &todo_list.buf;
> -	size_t offset = 0, commands_len = strlen(commands);
> -	int i, first;
> +	int res;
>   
>   	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>   		return error(_("could not read '%s'."), todo_file);
> @@ -4237,23 +4278,11 @@ int sequencer_add_exec_commands(const char *commands)
>   		return error(_("unusable todo list: '%s'"), todo_file);
>   	}
>   
> -	first = 1;
> -	/* insert <commands> before every pick except the first one */
> -	for (item = todo_list.items, i = 0; i < todo_list.nr; i++, item++) {
> -		if (item->command == TODO_PICK && !first) {
> -			strbuf_insert(buf, item->offset_in_buf + offset,
> -				      commands, commands_len);
> -			offset += commands_len;
> -		}
> -		first = 0;
> -	}
> -
> -	/* append final <commands> */
> -	strbuf_add(buf, commands, commands_len);
> -
> -	i = write_message(buf->buf, buf->len, todo_file, 0);
> +	todo_list_add_exec_commands(&todo_list, commands);
> +	res = todo_list_write_to_file(&todo_list, todo_file, NULL, NULL, 0, 0, -1, 0);
>   	todo_list_release(&todo_list);
> -	return i;
> +
> +	return res;
>   }
>   
>   static void todo_list_to_strbuf(struct todo_list *todo_list, struct strbuf *buf,
> 

