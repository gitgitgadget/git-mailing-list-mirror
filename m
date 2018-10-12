Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EE11F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 09:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeJLRZ4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 13:25:56 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:20612 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLRZz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 13:25:55 -0400
Received: from [192.168.2.201] ([92.22.37.149])
        by smtp.talktalk.net with SMTP
        id Au9AgpHkpwhzSAu9Agoc7D; Fri, 12 Oct 2018 10:54:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1539338057;
        bh=Q2dLOjjbvE2AYlncSlmov89PcQxZ8L1ht40PupqLjgM=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=dYkMLZ4iPvga4PjAqiPsVoKzi4xa3u1984irXr0N+vGLb44Q3UsyJIYaBfBaJP3Je
         4RDArhzw1QOHHPNli9HxwyON8RtInBurkgcbVsIHgutqIVWrS5iF/2+9SaCLacpZpB
         v4+TzeL258HwgB7kyBFKvcFtq0S4/g6MRQPcB2aI=
X-Originating-IP: [92.22.37.149]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=nqOWhaM9XRsRdUafe8zwgQ==:117
 a=nqOWhaM9XRsRdUafe8zwgQ==:17 a=IkcTkHD0fZMA:10 a=QofnhrIh6XfvnRSa64MA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 04/15] sequencer: refactor sequencer_add_exec_commands()
 to work on a todo_list
To:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20181007195418.25752-1-alban.gruin@gmail.com>
 <20181007195418.25752-5-alban.gruin@gmail.com>
 <6188911e-fd21-4c7c-885d-a15d2b46aa86@talktalk.net>
 <6c55857a-ce3c-f9fc-18c6-d7cef2976931@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <10482114-7954-2d1d-1612-f2b559d4ca8f@talktalk.net>
Date:   Fri, 12 Oct 2018 10:54:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6c55857a-ce3c-f9fc-18c6-d7cef2976931@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAJOL6UtGCGNeV5xuQCHy8AjqC53mm4qh2g+6o4gu+C8yZrdby947bKf0opA/f80JjWgK7k22tJLcZYX34WpQYLMywf1NslcDylgEDtu8ExdhAK42ojx
 1pNWKPet/S70XjF0W3fJaTMiDfLInZ+aLWCFuUp/h4O1HTN+pTpXdrIZm+u9NLos2lyNpWVGDIoxLGQ9qbDMs8RcOVDGonb/PWHmN8Hgva5JUeEtcab/yjUc
 nswrgFzPkXlHXLv/vdUHv0r0iDVVLU+tNbXTvI4NOza3C3zyxisPd990TjxbEipRdGGWzB97sWc5H3CU6PG/cg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2018 17:57, Alban Gruin wrote:
> Hi Phillip,
> 
> thanks for taking the time to review my patches.
> 
> Le 11/10/2018 à 13:25, Phillip Wood a écrit :
>> On 07/10/2018 20:54, Alban Gruin wrote:
>>> @@ -4419,15 +4406,38 @@ int sequencer_add_exec_commands(const char
>>> *commands)
>>>       }
>>>         /* insert or append final <commands> */
>>> -    if (insert >= 0 && insert < todo_list.nr)
>>> -        strbuf_insert(buf, todo_list.items[insert].offset_in_buf +
>>> +    if (insert >= 0 && insert < todo_list->nr)
>>> +        strbuf_insert(buf, todo_list->items[insert].offset_in_buf +
>>>                     offset, commands, commands_len);
>>>       else if (insert >= 0 || !offset)
>>>           strbuf_add(buf, commands, commands_len);
>>>   -    i = write_message(buf->buf, buf->len, todo_file, 0);
>>> +    if (todo_list_parse_insn_buffer(buf->buf, todo_list))
>>> +        BUG("unusable todo list");}
>>
>> It is a shame to have to re-parse the todo list, I wonder how difficult
>> it would be to adjust the todo_list item array as the exec commands are
>> inserted. The same applies to the next couple of patches
>>
> 
> Good question.
> 
> This function inserts an `exec' command after every `pick' command.
> These commands are stored in a dynamically allocated list, grew with
> ALLOW_GROW().
> 
> If we want to keep the current structure, we would have to grow the size
> of the list by 1 and move several element to the end every time we want
> to add an `exec' command.  It would not be very effective.  Perhaps I
> should use a linked list here, instead.  It may also work well with
> rearrange_squash() and skip_unnecessary_picks().
> 
> Maybe we could even get rid of the strbuf at some point.

Another way would be to use the strbuf as a string pool rather than a
copy of the text of the file. There could be a write_todo_list()
function that takes a todo list and some flags, iterates over the items
in the todo list and writes the file. The flags would specify whether to
append the todo help and whether to abbreviate the object ids (so there
is no need for a separate call to transform_todos()). Then
add_exec_commands() could allocate a new array of todo items which it
builds up as it works through the original list and replaces the
original list with the new one at the end. The text of the exec items
can be added to the end of the strbuf (we only need one copy of the exec
text with this scheme). rearrange_squash() can use a temporary array to
build a new list as well or just memmove() things but that might be
slower if there is a lot of rearrangement to do. skip_unecessary_picks()
could just set the current item to the one we want to start with.

Best Wishes

Phillip

> 
>> Best Wishes
>>
>> Phillip
>>
> 
> Cheers,
> Alban
> 

