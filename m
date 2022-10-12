Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18480C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJLNbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLNbP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:31:15 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B44814C9
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:31:11 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B3EADCA1255;
        Wed, 12 Oct 2022 09:31:10 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7AA94CC831A;
        Wed, 12 Oct 2022 09:31:10 -0400 (EDT)
Subject: Re: [RFC PATCH] trace2 API: don't save a copy of constant
 "thread_name"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
References: <xmqqr0zkipva.fsf@gitster.g>
 <RFC-patch-1.1-8563d017137-20221007T010829Z-avarab@gmail.com>
 <xmqqo7uoh1q0.fsf@gitster.g> <221007.865ygvrjs7.gmgdl@evledraar.gmail.com>
 <afc73d87-b2d9-72e9-1be5-156f37102747@jeffhostetler.com>
 <221011.86h70ao4g6.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e138b178-99d9-e537-2cb1-c240962a35f2@jeffhostetler.com>
Date:   Wed, 12 Oct 2022 09:31:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <221011.86h70ao4g6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/11/22 9:31 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Oct 10 2022, Jeff Hostetler wrote:
> 
>> On 10/7/22 6:03 AM, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Oct 06 2022, Junio C Hamano wrote:
>>>
>>>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>>>
>>>>> A cleaned up version of the test code I had on top of "master", RFC
>>>>> because I may still be missing some context here. E.g. maybe there's a
>>>>> plan to dynamically construct these thread names?
>>>>
[...]

> I left more extensive commentary in the side-thread in
> https://lore.kernel.org/git/221011.86lepmo5dn.gmgdl@evledraar.gmail.com/,
> just a quick reply here.
> 
>> WRT optimizing memory usage.  We're talking about ~25 byte buffer
>> per thread.  Most commands execute in 1 thread -- if they read the
>> index they may have ~10 threads (depending on the size of the index
>> and if preload-index is enabled).  So, I don't think we really need
>> to optimize this.  Threading is used extensively in fsmonitor-daemon,
>> but it creates a fixed thread-pool at startup, so it may have ~12
>> threads.  Again, not worth optimizing for the thread-name field.
> 
> Yes, I agree it's not worth optimizing.
> 
> The reason for commenting on this part is that it isn't clear to me why
> your proposed patch then isn't doing the more obvious "it's not worth
> optimizing" pattern, per Junio's [1] comment on the initial version.
> 
> The "flex array" method is seemingly taking pains to reduce the runtime
> memory use of these by embedding this string in the space reserved for
> the struct.
> 
> So it's just meant as a question for you & the proposed patch.

I think we're converging on some common understanding (and I
think we've gone around on this topic more than enough).  :-)

I really was just trying to get rid of the strbuf and make it
a fixed string -- I chose a flex-array rather than just detaching
the buffer from a local in the thread-start code.  I should have
done the latter.  I saw the flex-array as a fixed-size object
that can't be replaced or extended (without recreating the
thread-local storage) -- yes, people could overwrite existing
bytes in-place in the flex-array, but who does that??


I understood what you were asking (illustrated in your RFC).
That is, I understood the "what/how" you wanted to do to refactor /
redesign the field, but I couldn't understand the "why".  That
is, why you've taken such interest in this field (and such
a relatively unimportant change).  We've spent nearly a week
discussing it and we both agree that the optimization that I
didn't suggest isn't worth doing.  (I'm paraphrasing slightly.) :-)

So, rather than continuing with the back-n-forth, let me skip
over the remaining questions in this thread and prepare a re-roll.
Hopefully, I can simplify and more clearly explain the method to
my madness and we can move on.


>> Now, if you want to optimize over all trace2 events (a completely
>> different topic), you could create a large scratch strbuf buffer in
>> each thread context and use it so that we don't have to malloc/free
>> during each trace message.  That might be worth while.
> 
> *nod*

I'll make a note to revisit this idea in a future series.

Thanks
Jeff

