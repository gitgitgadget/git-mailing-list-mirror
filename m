Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A147FC433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B03164F92
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhBEWBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:01:19 -0500
Received: from siwi.pair.com ([209.68.5.199]:62888 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232920AbhBEO4x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:53 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 806563F40D9;
        Fri,  5 Feb 2021 11:34:41 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 43F5A3F4098;
        Fri,  5 Feb 2021 11:34:41 -0500 (EST)
Subject: Re: [PATCH] usage: trace2 BUG() invocations
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20210205054914.104640-1-jonathantanmy@google.com>
 <xmqq1rdv2g3q.fsf@gitster.c.googlers.com>
 <YB0JYPLMC+hbcxCa@coredump.intra.peff.net>
 <1051d473-5d1b-1155-8d9e-93eb2cc349f0@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7ea4bd72-1229-2652-678c-e78c10eaf5d3@jeffhostetler.com>
Date:   Fri, 5 Feb 2021 11:34:40 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1051d473-5d1b-1155-8d9e-93eb2cc349f0@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/5/21 7:51 AM, Derrick Stolee wrote:
> On 2/5/2021 4:01 AM, Jeff King wrote:
>> On Thu, Feb 04, 2021 at 10:17:29PM -0800, Junio C Hamano wrote:
>>
>>> Jonathan Tan <jonathantanmy@google.com> writes:
>>>
>>>> die() messages are traced in trace2, but BUG() messages are not. Anyone
>>>> tracking die() messages would have even more reason to track BUG().
>>>> Therefore, write to trace2 when BUG() is invoked.
>>>>
>>>> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
>>>> ---
>>>> This was noticed when we observed at $DAYJOB that a certain BUG()
>>>> invocation [1] wasn't written to traces.
>>>>
>>>> [1] https://lore.kernel.org/git/YBn3fxFe978Up5Ly@google.com/
>>>> ---
>>>>   t/helper/test-trace2.c   |  9 +++++++++
>>>>   t/t0210-trace2-normal.sh | 19 +++++++++++++++++++
>>>>   usage.c                  |  6 ++++++
>>>>   3 files changed, 34 insertions(+)
>>>
>>> Sounds like a good idea.  Expert opinions?
>>
>> I like the overall idea, but it does open the possibility of a BUG() in
>> the trace2 code looping infinitely.
> 
> I also like the idea. This infinite loop is scary.
> 
>> We've had a similar problem on the die() side in the past, and solved it
>> with a recursion flag. But note it gets a bit non-trivial in the face of
>> threads. There's some discussion in 1ece66bc9e (run-command: use
>> thread-aware die_is_recursing routine, 2013-04-16).
>>
>> That commit talks about a case where "die()" in a thread takes down the
>> thread but not the whole process. That wouldn't be true here (we'd
>> expect BUG() to take everything down). So a single counter might be OK
>> in practice, though I suspect we could trigger the problem racily
>> Likewise this is probably a lurking problem when other threaded code
>> calls die(), but we just don't do that often enough for anybody to have
>> noticed.
> 
> Would a simple "BUG() has been called" static suffice?
> 
> diff --git a/usage.c b/usage.c
> index 1868a24f7a..0d2408f79e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -265,7 +265,11 @@ int BUG_exit_code;
>   
>   static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
>   {
> +       static int in_bug = 0;
>          char prefix[256];
> +       if (in_bug)
> +               abort();
> +       in_bug = 1;
>   
>          /* truncation via snprintf is OK here */
>          if (file)
> 
> Note that the NOTRETURN means we can't no-op with something like
> 
> 	if (in_bug)
> 		return;
> 
> so the trace2 call would want to be as close to the abort as
> possible to avoid a silent failure. So, in the patch...
> 
>>>> diff --git a/usage.c b/usage.c
>>>> index 1868a24f7a..16272c5348 100644
>>>> --- a/usage.c
>>>> +++ b/usage.c
>>>> @@ -273,6 +273,12 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
>>>>   	else
>>>>   		snprintf(prefix, sizeof(prefix), "BUG: ");
>>>>   
>>>> +	/*
>>>> +	 * We call this trace2 function first and expect it to va_copy 'params'
>>>> +	 * before using it (because an 'ap' can only be walked once).
>>>> +	 */
>>>> +	trace2_cmd_error_va(fmt, params);
>>>> +
>>>>   	vreportf(prefix, fmt, params);
> 
> We would want this vreportf() to be before the call to
> trace2_cmd_error_va(), right?

There's a subtle quirk in the va_list stuff that we can only traverse
the list once.  So my trace2_ routines always do a `va_copy` and iterate
on it.  This leaves the original `params` untouched when it is handed to
`vreportf()`.

If we want to reorder the output, we'd need to va_copy it first.
(Or teach vreporf to always va_copy its arg.)

> 
> Thanks,
> -Stolee
> 
