Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876B820193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754887AbcJ0UGB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:06:01 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:52727 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754069AbcJ0UF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:05:56 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3t4dD64lvnz5tlQ;
        Thu, 27 Oct 2016 22:05:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2F48B101;
        Thu, 27 Oct 2016 22:05:26 +0200 (CEST)
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Stefan Beller <sbeller@google.com>
References: <20161026215732.16411-1-sbeller@google.com>
 <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com>
 <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com>
 <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org>
 <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org>
Date:   Thu, 27 Oct 2016 22:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.2016 um 21:08 schrieb Stefan Beller:
> On Thu, Oct 27, 2016 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Am 27.10.2016 um 19:01 schrieb Stefan Beller:
>>> ...
>>> It is not possible to mark a mutex uninitialized on Windows without an
>>> extra piece of data. A solution would become quite complicated quite
>>> quickly, and at the cost of additional operations that are in the same
>>> ballpark as an uncontended mutex. I'm not enthused.
>>>
>>>> The positive aspect of this way the patch proposes would be that any
>>>> future contributor not knowing the details of how to do mutexes right
>>>> on Windows, would not totally break the whole system, i.e. this seems
>>>> to be more maintainable in the future as it reduces the friction between
>>>> pthreads mutexes and the way we can do things in Git in a platform
>>>> independent way
>>>
>>> This is a non-argument. Coders have to know their tools.
>
> Windows is not my tool.

The tool I meant is pthreads. For example, you can't have a 
pthread_mutex_t variable and not initialize it with either 
PTHREAD_MUTEX_INITIALIZER or pthread_mutex_init.

>> The codebase should strive to give coders a coherent abstraction
>> that can be implemented efficiently on platforms, so that coders do
>> not have to care too deeply about quirks that exist on individual
>> platforms.
>
> Currently working as a coder I care about "submodules, that work on
> linux." I do not care about Windows in the big picture.

I don't know what you meant to say with this sentence, but taken 
literally, are you on the right ship here, I have to ask?

> I am however
> willing to go an extra step to not break Windows.

"Not break Windows" is equivalent to "make it work on Windows", mind 
you. We can't have a new feature only on Linux when there is no reason 
not to have it on Windows as well. Sorry, "Git is for Unix only" is long 
over.

> However that requires
> a little bit of effort from both me and you:
> * I need to be aware of what I cannot do with "not-my-tools". (So please
>   somebody tell me, also in the future when I break obscure platforms. Mind
>   that I don't equate obscure with not widely used or in any other way negative.
>   It's just that people working on linux find some quirks on Windows
> not "obvious")

That goes without saying.

> * the workaround should not be too time consuming in the bigger picture,

That, however, is wishful thinking. If you want to have a feature 
dearly, you have to make it work, and that may take its time. I'm not 
saying that *you* have to make it work (there are platform experts 
around to lend a hand), but just an extra step to "not break" an 
important platform is not enough.

>   which is why I propose to make the API a bit clearer by emulating posix
>   mutexes harder. (From a Windows POV this might sound like making it
>   more obscure because posix mutexes itself are obscure.)

So, when you think that POSIX mutexes are obscure, why don't we settle 
on the simpler Windows critical sections? Emulating them with pthreads 
should be child's play.

> The implementation under discussion (well we did not discuss the
> implementation a
> whole lot yet) ...

There's not a whole lot to discuss: it must be rewritten from scratch 
(it's not just the memory barriers, it is everything else, too). But 
time is much better spent on an attr_start() solution.

-- Hannes

