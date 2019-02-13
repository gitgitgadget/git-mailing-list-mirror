Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B28531F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfBMKDw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:03:52 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:42137 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfBMKDw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:03:52 -0500
Received: from [192.168.2.201] ([92.22.24.194])
        by smtp.talktalk.net with SMTP
        id trONgx6NToI6LtrONgV5Vt; Wed, 13 Feb 2019 10:03:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550052228;
        bh=DuqP9QuwBtm90kESGwmJQzLf1NOoGOJY76A8GX4awNc=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BDBoehC2sfto17RgoqiNPRkj0Y0xB0c+WnDlvbwN7JuGUQH8GbJoBj9h1yMZNVepu
         add8dIPVqus5aQ21Br3n42ALnciyZ0hBtBp0rj0saCb4yC+2MYHxhgtT0zF8T23Go7
         SS+SLGtw0ZFk4RGk1SJDkTYe1k/Kj7dJOBUJBkKg=
X-Originating-IP: [92.22.24.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=OJBejJTAIYRVoGQ3FWVcuw==:117
 a=OJBejJTAIYRVoGQ3FWVcuw==:17 a=IkcTkHD0fZMA:10 a=OvGfthfImMIY5VulCAsA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 07/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
 <20190210132648.12821-8-alban.gruin@gmail.com>
 <4c8f904a-329c-a42c-c2a4-06d5b348dce3@talktalk.net>
 <d334fd63-4053-7034-64f9-eee82bdd06c2@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <3bc5ffea-f8ac-65f3-c9b8-61ddc2733742@talktalk.net>
Date:   Wed, 13 Feb 2019 10:03:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d334fd63-4053-7034-64f9-eee82bdd06c2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFvKh7mZ8gc5+U2dvfWnvEwB/NgDEI3BfNdnTmHgKQDMwYCWbhloE9QFCJttrclqcgZqmBlgImEYjdpuHPNwdTUqd3ARa/irM/gJlE8emkte/825+HFK
 7+MOb4H05LH7jk+5CnOZgZMRyQDTjpbERARPhr38/RwOi84XKgTMabTVYeLDyA5xUDdkU9w1wHSofsEQp1nDFEy63Pk2Cd+UmZ6UsW1FxW+ZE3dmS24ue4QK
 ITdIMRd1mRrxPudHHf/d5ippUwPUdvKWHywUaRyt2TOONpB78gjCkE9bLrrf8uVy0lCPbt/PSxtwWni239c7Fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 12/02/2019 15:21, Alban Gruin wrote:
> Hi Phillip,
> 
> Le 12/02/2019 à 11:52, Phillip Wood a écrit :
>> Hi Alban
>>
>> I think this is almost there, I've got a couple of small comments below.
>>
>> On 10/02/2019 13:26, Alban Gruin wrote:
>>> -%<-
>>> diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
>>> index df19ccaeb9..c131fd4a27 100644
>>> --- a/builtin/rebase--interactive.c
>>> +++ b/builtin/rebase--interactive.c
>>> -%<-
>>> @@ -221,6 +222,11 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>>  		warning(_("--[no-]rebase-cousins has no effect without "
>>>  			  "--rebase-merges"));
>>>  
>>> +	if (cmd && *cmd) {
>>> +		string_list_split(&commands, cmd, '\n', -1);
>>
>> I'd suggest a comment along the lines of
>> /* As cmd always ends with a newline the last item is empty */
>>
>>> +		--commands.nr;
>>
>> Style: commands.nr--
>>
>>> +	}
>>> +
>>>  	switch (command) {
>>>  	case NONE:
>>>  		if (!onto && !upstream)
>>> @@ -228,7 +234,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>>  
>>>  		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
>>>  					    onto_name, squash_onto, head_name, restrict_revision,
>>> -					    raw_strategies, cmd, autosquash);
>>> +					    raw_strategies, &commands, autosquash);
>>>  		break;
>>>  	case SKIP: {
>>>  		struct string_list merge_rr = STRING_LIST_INIT_DUP;
>>> @@ -262,11 +268,12 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>>  		ret = rearrange_squash(the_repository);
>>>  		break;
>>>  	case ADD_EXEC:
>>> -		ret = sequencer_add_exec_commands(the_repository, cmd);
>>> +		ret = sequencer_add_exec_commands(the_repository, &commands);
>>>  		break;
>>>  	default:
>>>  		BUG("invalid command '%d'", command);
>>>  	}
>>
>> Before freeing the string list it would be good to reset the number of
>> items with commands.nr++ (with a comment explaining why) so the NUL in
>> the last item gets freed.
>>
>>> +	string_list_clear(&commands, 1);
>>
>> As we don't use item.util I think the second argument would be better as 0.
>>
>>>  	return !!ret;
>>>  }
> 
> FWIW I just stumbled across string_list_remove_empty_items(), which
> seems to do exactly the same thing, but that way we don’t have to do
> this kind of hacks.

Good find, that sounds like a much better solution.

> 
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 99e12c751e..82ca3432cd 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -4505,21 +4505,27 @@ int sequencer_make_script(struct repository *r, FILE *out,
>>>   * Add commands after pick and (series of) squash/fixup commands
>>>   * in the todo list.
>>>   */
>>> -int sequencer_add_exec_commands(struct repository *r,
>>> -				const char *commands)
>>> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>>> +					struct string_list *commands)
>>>  {
>>> -	const char *todo_file = rebase_path_todo();
>>> -	struct todo_list todo_list = TODO_LIST_INIT;
>>> -	struct strbuf *buf = &todo_list.buf;
>>> -	size_t offset = 0, commands_len = strlen(commands);
>>> -	int i, insert;
>>> +	struct strbuf *buf = &todo_list->buf;
>>> +	size_t base_offset = buf->len;
>>> +	int i, insert, nr = 0, alloc = 0;
>>> +	struct todo_item *items = NULL, *base_items = NULL;
>>>  
>>> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>> -		return error(_("could not read '%s'."), todo_file);
>>> +	base_items = xcalloc(commands->nr, sizeof(struct todo_item));
>>> +	for (i = 0; i < commands->nr; i++) {
>>> +		size_t command_len = strlen(commands->items[i].string);
>>>  
>>> -	if (todo_list_parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
>>> -		todo_list_release(&todo_list);
>>> -		return error(_("unusable todo list: '%s'"), todo_file);
>>> +		strbuf_addstr(buf, commands->items[i].string);
>>> +		strbuf_addch(buf, '\n');
>>> +
>>> +		base_items[i].command = TODO_EXEC;
>>> +		base_items[i].offset_in_buf = base_offset;
>>> +		base_items[i].arg_offset = base_offset + strlen("exec ");
>>> +		base_items[i].arg_len = command_len - strlen("exec ");
>>> +
>>> +		base_offset += command_len + 1;
>>>  	}
>>>  
>>>  	/*
>>> @@ -4527,39 +4533,60 @@ int sequencer_add_exec_commands(struct repository *r,
>>>  	 * are considered part of the pick, so we insert the commands *after*
>>>  	 * those chains if there are any.
>>>  	 */
>>> -	insert = -1;
>>> -	for (i = 0; i < todo_list.nr; i++) {
>>> -		enum todo_command command = todo_list.items[i].command;
>>> -
>>> -		if (insert >= 0) {
>>> -			/* skip fixup/squash chains */
>>> -			if (command == TODO_COMMENT)
>>> -				continue;
>>> -			else if (is_fixup(command)) {
>>> -				insert = i + 1;
>>> -				continue;
>>> -			}
>>> -			strbuf_insert(buf,
>>> -				      todo_list.items[insert].offset_in_buf +
>>> -				      offset, commands, commands_len);
>>> -			offset += commands_len;
>>> -			insert = -1;
>>
>> I like the simplification of using insert as a flag. Perhaps we should
>> document the assumptions. Maybe something like
>>
>> We insert the exec commands immediately after rearranging any fixups and
>> before the user edits the list. This means that a fixup chain can never
>> contain comments (any comments are empty picks that have been commented
>> out the the user did not specify --keep-empty) and so it is safe to
>> insert the exec command without looking at the command following the
>> comment.
>>
> 
> I slightly reworded this and added it to the existing comment just
> before the for loop:
> 
> 	/*
> 	 * Insert <commands> after every pick. Here, fixup/squash chains
> 	 * are considered part of the pick, so we insert the commands *after*
> 	 * those chains if there are any.
> 	 *
> 	 * As we insert the exec commands immediatly after rearranging
> 	 * any fixups and before the user edits the list, a fixup chain
> 	 * can never contain comments (any comments are empty picks that
> 	 * have been commented out because the user did not specify
> 	 * --keep-empty).  So, it is safe to insert an exec command
> 	 * without looking at the command following a comment.
> 	 */
> 

That sounds good

Best Wishes

Phillip

>>> +	insert = 0;
>>> +	for (i = 0; i < todo_list->nr; i++) {
>>> +		enum todo_command command = todo_list->items[i].command;
>>> +		if (insert && !is_fixup(command)) {
>>> +			ALLOC_GROW(items, nr + commands->nr, alloc);
>>> +			COPY_ARRAY(items + nr, base_items, commands->nr);
>>> +			nr += commands->nr;
>>> +
>>> +			insert = 0;
>>>  		}
>>>  
>>> -		if (command == TODO_PICK || command == TODO_MERGE)
>>> -			insert = i + 1;
>>> +		ALLOC_GROW(items, nr + 1, alloc);
>>> +		items[nr++] = todo_list->items[i];
>>> +
>>> +		if (command == TODO_PICK || command == TODO_MERGE || is_fixup(command))
>>
>> I'm not sure what the is_fixup() is for, if the command is a fixup then
>> it will have been preceded by a pick or merge so insert will already be 1
>>
>> I feel a bit mean suggesting a reroll when we're on v7 already but I
>> think these clean-ups would improve the maintainability of the code.
>> I'll take a look at the rest of the changes to this series sometime this
>> week.
>>
>> Best Wishes
>>
>> Phillip
>>
> 
> Cheers,
> Alban
> 

