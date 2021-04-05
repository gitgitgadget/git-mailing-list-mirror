Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADFAC433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA5F61241
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239615AbhDER6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:58:39 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:21675 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232452AbhDER6i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:58:38 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4FDdgV5KcMz5tlB;
        Mon,  5 Apr 2021 19:58:28 +0200 (CEST)
Subject: Re: [GSOC][PATCH] userdiff: add support for Scheme
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <20210327173938.59391-1-raykar.ath@gmail.com>
 <3def82fd-71a7-3ad9-0fa2-48598bfd3313@kdbg.org>
 <5BA00FC6-9810-49AB-8DE2-D4F4010E2F82@gmail.com>
 <09678471-b2a2-8504-2293-e2b34a3a96e8@gmail.com>
 <D8256AFA-898E-4388-8FCC-7D3D340C001E@gmail.com>
 <A3C3DD12-3C00-49ED-B427-37AAB4211C2A@gmail.com>
 <61622cda-3ce5-7cd9-acd6-54906297500c@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <01f17458-3d99-d4f5-aee8-0f77f73063d2@kdbg.org>
Date:   Mon, 5 Apr 2021 19:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <61622cda-3ce5-7cd9-acd6-54906297500c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.21 um 12:04 schrieb Phillip Wood:
> Hi Atharva
> 
> On 30/03/2021 11:22, Atharva Raykar wrote:
>>
>>
>>> On 30-Mar-2021, at 12:34, Atharva Raykar <raykar.ath@gmail.com> wrote:
>>>
>>>
>>>
>>>> On 29-Mar-2021, at 15:48, Phillip Wood <phillip.wood123@gmail.com>
>>>> wrote:
>>>>
>>>> Hi Atharva
>>>>
>>>> On 28/03/2021 13:23, Atharva Raykar wrote:
>>>>> On 28-Mar-2021, at 05:16, Johannes Sixt <j6t@kdbg.org> wrote:
>>>>> [...]
>>>>>>> diff --git a/t/t4018/scheme-local-define
>>>>>>> b/t/t4018/scheme-local-define
>>>>>>> new file mode 100644
>>>>>>> index 0000000000..90e75dcce8
>>>>>>> --- /dev/null
>>>>>>> +++ b/t/t4018/scheme-local-define
>>>>>>> @@ -0,0 +1,4 @@
>>>>>>> +(define (higher-order)
>>>>>>> +  (define local-function RIGHT
>>>>>>
>>>>>> ... this one, which is also indented and *is* marked as RIGHT.
>>>>> In this test case, I was explicitly testing for an indented '(define'
>>>>> whereas in the former, I was testing for the top-level
>>>>> '(define-syntax',
>>>>> which happened to have an internal define (which will inevitably
>>>>> show up
>>>>> in a lot of scheme code).
>>>>
>>>> It would be nice to include indented define forms but including them
>>>> means that any change to the body of a function is attributed to the
>>>> last internal definition rather than the actual function. For example
>>>>
>>>> (define (f arg)
>>>> (define (g x)
>>>>    (+ 1 x))
>>>>
>>>> (some-func ...)
>>>> ;;any change here will have '(define (g x)' in the hunk header, not
>>>> '(define (f arg)'
>>>
>>> The reason I went for this over the top level forms, is because
>>> I felt it was useful to see the nearest definition for internal
>>> functions that often have a lot of the actual business logic of
>>> the program (at least a lot of SICP seems to follow this pattern).
>>> The disadvantage is as you said, it might also catch trivial inner
>>> functions and the developer might lose context.
>>
>> Never mind this message, I had misunderstood the problem you were
>> trying to
>> demonstrate. I wholeheartedly agree with what you are trying to say, and
>> the indentation heuristic discussed does look interesting. I shall have a
>> glance at the RFC you linked in the other reply.
>>
>>> The disadvantage is as you said, it might also catch trivial inner
>>> functions and the developer might lose context.
>>
>> Feel free to disregard me misquoting you here. You did not say that (:
>>
>>> Another problem is it may match more trivial bindings, like:
>>>
>>> (define (some-func things)
>>>   ...
>>>   (define items '(eggs
>>>                   ham
>>>                   peanut-butter))
>>>   ...)
>>>
>>> What I have noticed *anecdotally* is that this is not common enough
>>> to be too much of a problem, and local define bindings seem to be more
>>> favoured in Racket than other Schemes, that use 'let' more often.
>>>
>>>> I don't think this can be avoided as we rely on regexs rather than
>>>> parsing the source so it is probably best to only match toplevel
>>>> defines.
>>>
>>> The other issue with only matching top level defines is that a
>>> lot of scheme programs are library definitions, something like
>>>
>>> (library
>>>     (foo bar)
>>>   (export ...)
>>>   (define ...)
>>>   (define ...)
>>>   ;; and a bunch of other definitions...
>>> )
>>>
>>> Only matching top level defines will completely ignore matching all
>>> the definitions in these files.
>>
>> That said, I still stand by the fact that only catching top level defines
>> will lead to a lot of definitions being ignored. Maybe the occasional
>> mismatch may be worth the gain in the number of function contexts being
>> detected?
> 
> I'm not sure that the mismatches will be occasional - every time you
> have an internal definition in a function the hunk header will be wrong
> when you change the main body of the function. This will affect grep
> --function-context and diff -W as well as the normal hunk headers. The
> problem is there is no way to avoid that and provide something useful in
> the library example you have above. It would be useful to find some code
> bases and diff the output of 'git log --patch' with and without the
> leading whitespace match in the function pattern to see how often this
> is a problem (i.e. when the funcnames do not match see which one is
> correct).

--function-context is just one application of the function matcher. To
work properly with nested function definitions, it would have to
understand the nesting. But it does not; there is nothing that we can do
about it without a proper language parser. Therefore, the argument that
the matcher does not work well with --function-context for nested
functions is of little relevance.

IMO, the primary concern should be whether the matcher decorates hunk
contexts sufficiently well.

-- Hannes
