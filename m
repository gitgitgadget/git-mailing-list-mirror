Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30DECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiISRLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiISRLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:11:32 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6C3A4A5
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:09:45 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 194F7CA1259;
        Mon, 19 Sep 2022 13:08:55 -0400 (EDT)
Received: from jeffhost-mbp.local (addr-66.249.231.194.nptpop-cmts01-cable-sub.rdns-bnin.net [66.249.231.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A69ABCC8337;
        Mon, 19 Sep 2022 13:08:54 -0400 (EDT)
Subject: Re: [PATCH v7 2/6] fsmonitor: relocate socket file if .git directory
 is remote
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
 <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
 <075340bd2a713905d8bee4f53765dcbcba9a17c4.1663358014.git.gitgitgadget@gmail.com>
 <xmqqy1ujf5a9.fsf@gitster.g>
 <5c50a3cf-c5ac-6b11-2548-8400e5574b32@jeffhostetler.com>
 <xmqq35cnco3h.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <40b47246-adb6-cf56-02ef-25ab1429a42e@jeffhostetler.com>
Date:   Mon, 19 Sep 2022 13:08:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq35cnco3h.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/19/22 12:42 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> On 9/16/22 4:11 PM, Junio C Hamano wrote:
>>> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> +const char *fsmonitor_ipc__get_path(struct repository *r)
>>>> +{
>>>> +	static const char *ipc_path;
>>>> +	SHA_CTX sha1ctx;
>>>> +	char *sock_dir;
>>>> +	struct strbuf ipc_file = STRBUF_INIT;
>>>> +	unsigned char hash[SHA_DIGEST_LENGTH];
>>>> +
>>>> +	if (ipc_path)
>>>> +		return ipc_path;
>>>> +
>>>> +	if (!r)
>>>> +		r = the_repository;
>>> I'd prefer not to see this "NULL means the_repository".  It would be
>>> a different story if the caller does not necessarily have a ready
>>> access to the_repository, but it is a global, so the caller can pass
>>> the_repository and be more explicit.  Giving two ways to the caller
>>> to express same thing is not a good idea.
>>> Thanks.
>>>
>>
>> To be fair, I added several "if (!r) r = the_repository;" statements
>> to the original public FSMonitor routines.  There were obscure cases
>> where tests would sometimes randomly fail because "r" wasn't completely
>> passed down via some hard to isolate call stack.  Offlist, AEvar told me
>> that he managed to isolate it and has a fix.
>>
>> So eventually, we'll be able to get rid of all of these direct
>> references to "the_repository" and properly assume that "r" is
>> always passed down.
>>
>> But for now, I think we should let this stay for safety.
> 
> I wouldn't call "sweeping a breakage under the rug" a "safety",
> though.  If the caller cannot decide which repository instance is
> the right thing to pass, or the caller does not yet have a good one
> to pass when making a call down the codepath, how can it be safer to
> use the_repository that may or may not be the appropriate one than
> noticing the problem by dying and stopping the spread of damage?
> 

Aren't we in the middle of a transition from always
using the global "the_repository" to a passed "r" variable?
We're getting closer to being able to hide the the global
symbol, but we're not there yet, right?

I'm thinking that at as long as the global exists, we are not
safe to have multiple "struct repository" instances, right?

All I'm saying is that there are obscure/edge code paths where
a valid "r" is not being passed down.  Or, more likely, someone
has an "istate" that doesn't yet have "istate->repo" set at the
point of the call, so they might be passing "istate->repo", but
it is null.

Tracking down these nulls is important, but shouldn't it be
independent of this one?

Jeff
