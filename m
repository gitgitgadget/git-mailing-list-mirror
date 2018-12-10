Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E108120A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 14:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeLJOdh (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 09:33:37 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:60113 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeLJOdh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 09:33:37 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id WMcmgmv9PAGVrWMcmgso2a; Mon, 10 Dec 2018 14:33:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1544452413;
        bh=eu2xfdvbfUOsscAim2j7viGnrTV/0owBW7eL7py4DUo=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VvQH46/OSKfQct2/bcu6q0LEdG4PXE9Jh2UqJKBgMCYPss0JNqPqFUXoybBGltRTE
         ZVZC2spGYjn4R0gRyEe3PloX5j+xqChXuxJ9RFDNaYHZSjy96MMXACjV6Hd/hYUo/W
         6trULEk/Wkc+9k869z3u+JyM9KBn46QJvwOEOyBs=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=kLZgNU7G5xcJSCznY00A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 06/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181109080805.6350-7-alban.gruin@gmail.com>
 <0e00acd9-5b09-b712-2e21-550e348ea0df@talktalk.net>
 <nycvar.QRO.7.76.6.1811302002340.41@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a1a828e5-6faa-b1f2-20c3-a53b1a3d779a@talktalk.net>
Date:   Mon, 10 Dec 2018 14:33:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1811302002340.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHtm70KALbXZnaGCcyerSn76nxikqJzsFt9a7yUOG4II85Ild9gP84WwCzflkt6JRZRD5f8wHs9YOqYWKX+xZFicN4oBLonIiQK7pStdEjfD51/tE5l4
 3wGIE0OexwR5IsKc8i6bBLGmwZzGPxGh48Cye291ns3UtKeyMdNf1c4InBiA4AApuwTO1NCntJ7o2JTagxEZ8vnfUvWcnY3FzvxGXN9LEjFN7XzSPyRrxBpC
 ZThLJKgPeIhJX89Munb4mTydSbEf+EWjgAxr7wz1bp0YuhHmF7x6XKKqi4If4Xw63u8XFl3GG+5xvaENC7HHcg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/11/2018 19:06, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 30 Nov 2018, Phillip Wood wrote:
> 
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 900899ef20..11692d0b98 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -4394,24 +4394,29 @@ int sequencer_make_script(FILE *out, int argc, const
>>> char **argv,
>>>   	return 0;
>>>   }
>>>   
>>> -/*
>>> - * Add commands after pick and (series of) squash/fixup commands
>>> - * in the todo list.
>>> - */
>>> -int sequencer_add_exec_commands(const char *commands)
>>> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>>> +					struct string_list *commands)
>>> {
>>> -	const char *todo_file = rebase_path_todo();
>>> -	struct todo_list todo_list = TODO_LIST_INIT;
>>> -	struct strbuf *buf = &todo_list.buf;
>>> -	size_t offset = 0, commands_len = strlen(commands);
>>> -	int i, insert;
>>> +	struct strbuf *buf = &todo_list->buf;
>>> +	const char *old_buf = buf->buf;
>>> +	size_t base_length = buf->len;
>>> +	int i, insert, nr = 0, alloc = 0;
>>> +	struct todo_item *items = NULL, *base_items = NULL;
>>>
>>> -	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>> -		return error(_("could not read '%s'."), todo_file);
>>> +	for (i = 0; i < commands->nr; ++i) {
>>> +		strbuf_addstr(buf, commands->items[i].string);
>>> +		strbuf_addch(buf, '\n');
>>> +	}
>>
>> This could cause buf->buf to be reallocated in which case all the
>> todo_list_item.arg pointers will be invalidated.
> 
> I guess it is a good time for me to admit that the `arg` idea was not my
> best. Maybe it would be good to convert that from a pointer to an offset,
> e.g. `size_t arg_offset_in_buf;`? Or maybe we should just drop the
> `_in_buf` suffix and clarify in a comment next to the declaration of the
> fields that they are offsets in the strbuf?

I think that sounds sensible (though I haven't looked at how much work 
it would be), having a comment and calling it arg_offset would be my 
preference.

Best Wishes

Phillip
> 
> Ciao,
> Dscho
> 

