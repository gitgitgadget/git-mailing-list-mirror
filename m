Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAEDE1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 10:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbeKBTQf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 15:16:35 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:38290 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeKBTQe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 15:16:34 -0400
Received: from [192.168.2.201] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id IWOng9naqdJAeIWOogTKmw; Fri, 02 Nov 2018 10:09:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1541153394;
        bh=qHP5zssQwFC1jEqDQIXBfUS9/RfvYjrVR7Z6bkErjcg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BA7M6U6f1sxFGmNGAodgNvyfACjodE1CWijyxbphe1PiOOdIYnkl50lLgjp0vTUv5
         Otq0AxTVD6vwh97SKJhcd7C5S0/iy/B6oP9gAqODlsSOWYDt8b+u7OTB3CxJNAV7l2
         YeMlxt3uFK56m8mJ2g6BOUM7dpXAfFRDc8MtbBWo=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=4HbDcKlBB5qNPOfK9zsA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 06/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181027212930.9303-7-alban.gruin@gmail.com>
 <12e849d3-351b-7673-1f14-742d0fbb1ac1@talktalk.net>
 <c57384de-0996-2294-db8f-0204f9c16226@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <351e3398-8239-5348-2880-d253d8a125d7@talktalk.net>
Date:   Fri, 2 Nov 2018 10:09:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c57384de-0996-2294-db8f-0204f9c16226@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfD0QawbP/7nxBAcEbCgEXaNj/YHiXW/wiQQXBn+JSaCoSVU+cCUQd591yP7i9DZ8yvxzEwDAFi0uMsWlcd7kT63jnlONEzlCEPlKNKs6y/SnqtoO6LSE
 cAHY4f4u6/JKkywwksLYM0uQUVKQkrHjOStEK3o7wmtvT56Yoz7BanWp8OpBTp2fqgwmNNCGGt4w+zeVVzkriLpBtEZ5fiBS9g7h2Jr0GYK1m9VonqJkzZsA
 IvgF2Rd4R+USosa1kt9onnzZPOrqDXVSGAqkibzKt13Ar30Y/l94R5lk9PkuYxeCUFIcqotQuG6vRuz89QV3Qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 01/11/2018 23:31, Alban Gruin wrote:
> Le 30/10/2018 à 17:47, Phillip Wood a écrit :
>> On 27/10/2018 22:29, Alban Gruin wrote:
>>> This refactors sequencer_add_exec_commands() to work on a todo_list to
>>> avoid redundant reads and writes to the disk.
>>>
>>> An obvious way to do this would be to insert the `exec' command between
>>> the other commands, and reparse it once this is done.  This is not what
>>> is done here.  Instead, the command is appended to the buffer once, and
>>> a new list of items is created.  Items from the old list are copied to
>>> it, and new `exec' items are appended when necessary.  This eliminates
>>> the need to reparse the todo list, but this also means its buffer cannot
>>> be directly written to the disk, hence todo_list_write_to_disk().
>>
>> I'd reword this slightly, maybe
>>
>> Instead of just inserting the `exec' command between the other commands,
>> and re-parsing the buffer at the end the exec command is appended to the
>> buffer once, and a new list of items is created.  Items from the old
>> list are copied across and new `exec' items are appended when necessary.
>>  This eliminates the need to reparse the buffer, but this also means we
>> have to use todo_list_write_to_disk() to write the file.
>>
>>> sequencer_add_exec_commands() still reads the todo list from the disk,
>>> as it is needed by rebase -p.  todo_list_add_exec_commands() works on a
>>> todo_list structure, and reparses it at the end.
>>
>> I think the saying 'reparses' is confusing as that is what we're trying
>> to avoid.
>>
>>> complete_action() still uses sequencer_add_exec_commands() for now.
>>> This will be changed in a future commit.
>>>
>>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>>> ---
>>>   sequencer.c | 69 +++++++++++++++++++++++++++++++++++++----------------
>>>   1 file changed, 49 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index e12860c047..12a3efeca8 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -4216,6 +4216,50 @@ int sequencer_make_script(FILE *out, int argc,
>>> const char **argv,
>>>       return 0;
>>>   }
>>>   +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>>> +                    const char *commands)
>>> +{
>>> +    struct strbuf *buf = &todo_list->buf;
>>> +    const char *old_buf = buf->buf;
>>> +    size_t commands_len = strlen(commands + strlen("exec ")) - 1;
>>> +    int i, first = 1, nr = 0, alloc = 0;
>>
>> Minor nit pick, I think it is clearer if first is initialized just
>> before the loop as it is in the deleted code below.
>>
>>> +    struct todo_item *items = NULL,
>>> +        base_item = {TODO_EXEC, NULL, 0, 0, commands_len, 0};
>>> +
>>> +    strbuf_addstr(buf, commands);
>>> +    base_item.offset_in_buf = buf->len - commands_len - 1;
>>> +    base_item.arg = buf->buf + base_item.offset_in_buf;
>>
>> I think if the user gives --exec more than once on the command line then
>> commands will contain more than one exec command so this needs to parse
>> commands and create one todo_item for each command.
>>
> 
> Ouch, you’re right.  Thanks for the heads up.

I haven't looked how difficult it would be but it might be best to
change the option parsing to pass an array of strings containing the
exec commands rather than one long string so we can just loop over the
array here.

> 
>>> +
>>> +    /*
>>> +     * Insert <commands> after every pick. Here, fixup/squash chains
>>> +     * are considered part of the pick, so we insert the commands
>>> *after*
>>> +     * those chains if there are any.
>>> +     */
>>> +    for (i = 0; i < todo_list->nr; i++) {
>>> +        enum todo_command command = todo_list->items[i].command;
>>> +        if (todo_list->items[i].arg)
>>> +            todo_list->items[i].arg = todo_list->items[i].arg -
>>> old_buf + buf->buf;
>>> +
>>> +        if (command == TODO_PICK && !first) {
>>> +            ALLOC_GROW(items, nr + 1, alloc);
>>> +            memcpy(items + nr++, &base_item, sizeof(struct todo_item));
>>
>> I think it would be clearer to say
>>     items[nr++] = base_item;
>> rather than using memcpy. This applies below and to some of the other
>> patches as well. Also this needs to loop over all the base_items if the
>> user gave --exec more than once on the command line.
>>
> 
> I agree with you, it’s way more readable, IMO.  But for some reason, I
> thought it was not possible to assign a struct to another in C.

In general one needs to be careful as it is only does a shallow copy but
that is exactly what we want here. Having said that if we have an array
of exec commands to insert then it might be worth sticking with memcpy()
here so the whole array can be copied in one go.

Best Wishes

Phillip

>> Best Wishes
>>
>> Phillip
>>
> 
> Cheers,
> Alban
> 

