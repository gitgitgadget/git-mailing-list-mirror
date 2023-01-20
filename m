Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73119C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 19:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjATTtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjATTtN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 14:49:13 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBE690B04
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 11:49:06 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id ADFFBCA124F;
        Fri, 20 Jan 2023 14:49:05 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6FCFBCC834F;
        Fri, 20 Jan 2023 14:49:05 -0500 (EST)
Message-ID: <d9873e9b-6225-169b-4829-92f069b943af@jeffhostetler.com>
Date:   Fri, 20 Jan 2023 14:48:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2] fsm-listen-darwin: combine bit operations
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rose via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
References: <pull.1437.git.git.1673990756466.gitgitgadget@gmail.com>
 <pull.1437.v2.git.git.1673992448371.gitgitgadget@gmail.com>
 <021ab1ab-b90a-5a24-23c4-44e46d87c476@jeffhostetler.com>
 <xmqqwn5hw0t5.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqwn5hw0t5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/20/23 12:52 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>>>      static int ef_is_dropped(const FSEventStreamEventFlags ef)
>>>    {
>>> -	return (ef & kFSEventStreamEventFlagMustScanSubDirs ||
>>> -		ef & kFSEventStreamEventFlagKernelDropped ||
>>> -		ef & kFSEventStreamEventFlagUserDropped);
>>> +	return (ef & (kFSEventStreamEventFlagMustScanSubDirs |
>>> +		      kFSEventStreamEventFlagKernelDropped |
>>> +		      kFSEventStreamEventFlagUserDropped));
>>>    }
>>
>> Technically, the returned value is slightly different, but
>> the only caller is just checking for non-zero, so it doesn't
>> matter.
>>
>> So this is fine.
> 
> But is it worth the code churn and reviewer bandwidth?  Don't we
> have better things to spend our time on?
> 
> I would not be surprised if a smart enough compiler used the same
> transformartion as this patch does manually as an optimization.
> 
> Then it matters more which one of the two is more readable by our
> developers.  And the original matches how we humans would think, I
> would imagine.  ef might have MustScanSubdirs bit, KernelDropped
> bit, or UserDropped bit and in these cases we want to say that ef is
> dropped.  Arguably, the original is more readble, and it would be a
> good change to adopt if there is an upside, like the updated code
> resulting in markedly more efficient binary.
> 
> So, this might be technically fine, but I am not enthused to see
> these kind of code churning patches with dubious upside.  An
> optimization patch should be able to demonstrate its benefit with a
> solid benchmark, or at least a clear difference in generated code.
> 
> In fact.
> 
> Compiler explorer godbolt.org tells me that gcc 12 with -O2 compiles
> the following two functions into identical assembly.  The !! prefix
> used in the second example is different from the postimage of what
> Seija posted, but this being a file-scope static function, I would
> expect the compiler to notice that the actual value would not matter
> to the callers, only the truth value, does.
> 
> 
> * Input *
> int one(unsigned int num) {
>      return ((num & 01) ||
>              (num & 02) || (num & 04));
> }
> 
> int two(unsigned int num) {
>      return !!((num) & (01|02|04));
> }
> 
> * Assembly *
> one(unsigned int):
>          xor     eax, eax
>          and     edi, 7
>          setne   al
>          ret
> two(unsigned int):
>          xor     eax, eax
>          and     edi, 7
>          setne   al
>          ret

agreed.  i didn't think the change was really worth the bother
and churn.  personally, i prefer the conceptual clarity of the
code the way I wrote it.

and i was wondering if the compiler would generate the same
result, but didn't take the time (read: was too lazy) to actually
verify that.

all i was intending to say was that it wasn't a wrong change.

jeff
