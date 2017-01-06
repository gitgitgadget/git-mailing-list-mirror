Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FFC81FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 22:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S940723AbdAFWnf (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 17:43:35 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:35857 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939557AbdAFWn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 17:43:27 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3twKLV0RZxz5tlF;
        Fri,  6 Jan 2017 23:42:25 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 35EBC37C;
        Fri,  6 Jan 2017 23:42:25 +0100 (CET)
Subject: Re: Regression: Ctrl-c from the pager in an alias exits it
To:     Jeff King <peff@peff.net>
References: <20170105142529.GA15009@aaberge.net>
 <20170106064032.eqxxer5mx5hsh2md@sigill.intra.peff.net>
 <20170106064752.iccrk656c6k2wrfy@sigill.intra.peff.net>
 <20170106072602.wkbzho5z3osz5hee@sigill.intra.peff.net>
 <20170106073224.5hsrib77tx5tgx7d@sigill.intra.peff.net>
 <3d433abf-71a2-4702-f62b-e254520dc32c@kdbg.org>
 <20170106194115.k5u5esv7t63mryvk@sigill.intra.peff.net>
Cc:     Trygve Aaberge <trygveaa@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <2ed6f78b-7704-c724-c99b-e310c383c4e8@kdbg.org>
Date:   Fri, 6 Jan 2017 23:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170106194115.k5u5esv7t63mryvk@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.01.2017 um 20:41 schrieb Jeff King:
> On Fri, Jan 06, 2017 at 03:39:59PM +0100, Johannes Sixt wrote:
>
>>> diff --git a/run-command.c b/run-command.c
>>> index ca905a9e80..db47c429b7 100644
>>> --- a/run-command.c
>>> +++ b/run-command.c
>>> @@ -29,6 +29,8 @@ static int installed_child_cleanup_handler;
>>>
>>>  static void cleanup_children(int sig, int in_signal)
>>>  {
>>> +	struct child_to_clean *children_to_wait_for = NULL;
>>> +
>>>  	while (children_to_clean) {
>>>  		struct child_to_clean *p = children_to_clean;
>>>  		children_to_clean = p->next;
>>> @@ -45,6 +47,17 @@ static void cleanup_children(int sig, int in_signal)
>>>  		}
>>>
>>>  		kill(p->pid, sig);
>>> +		p->next = children_to_wait_for;
>>> +		children_to_wait_for = p;
>>> +	}
>>> +
>>> +	while (children_to_wait_for) {
>>> +		struct child_to_clean *p = children_to_wait_for;
>>> +		children_to_wait_for = p->next;
>>> +
>>> +		while (waitpid(p->pid, NULL, 0) < 0 && errno == EINTR)
>>> +			; /* spin waiting for process exit or error */
>>> +
>>>  		if (!in_signal)
>>>  			free(p);
>>>  	}
>>>
>>
>> This looks like the minimal change necessary. I wonder, though, whether the
>> new local variable is really required. Wouldn't it be sufficient to walk the
>> children_to_clean chain twice?
>
> Yeah, I considered that. The fact that we disassemble the list in the
> first loop has two side effects:
>
>   1. It lets us free the list as we go (for the !in_signal case).
>
>   2. If we were to get another signal, it makes us sort-of reentrant. We
>      will only kill and wait for each pid once.
>
> Obviously (1) moves down to the lower loop, but I was trying to preserve
> (2). I'm not sure if it is worth bothering, though.

Makes sense.

> The way we pull
> items off of the list is certainly not atomic (it does shorten the race
> to a few instructions, though, versus potentially waiting on waitpid()
> to return).
>
> My bigger concern with the whole thing is whether we could hit some sort
> of deadlock if the child doesn't die when we send it a signal. E.g.,
> imagine we have a pipe open to the child and somebody sends SIGTERM to
> us. We propagate SIGTERM to the child, and then waitpid() for it. The
> child decides to ignore our SIGTERM for some reason and keep reading
> until EOF on the pipe. It won't ever get it, and the two processes will
> hang forever.
>
> You can argue perhaps that the child is broken in that case. And I doubt
> this could trigger when running a git sub-command. But we may add more
> children in the future. Right now we use it for the new multi-file
> clean/smudge filters. They use the hook feature to close the
> descriptors, but note that that won't run in the in_signal case.
>
> So I dunno. Maybe this waiting should be restricted only to certain
> cases like executing git sub-commands.

If given it some thought.

In general, I think it is wrong to wait for child processes when a 
signal was received. After all, it is the purpose of a (deadly) signal 
to have the process go away. There may be programs that know it better, 
like less, but git should not attempt to know better in general.

We do apply some special behavior for certain cases like we do for the 
pager. And now the case with aliases is another special situation. The 
parent git process only delegates to the child, and as such it is 
reasonable that it binds its life time to the first child, which 
executes the expanded alias.

-- Hannes

