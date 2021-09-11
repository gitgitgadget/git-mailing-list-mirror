Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB16FC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B483561051
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 22:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhIKWtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 18:49:55 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17620 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229800AbhIKWtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 18:49:55 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mPBnc-000A2w-Cz; Sat, 11 Sep 2021 23:48:40 +0100
Subject: Re: [PATCH] strvec: use size_t to store nr and alloc
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <YTzEvLHWcfuD20x4@coredump.intra.peff.net>
 <87o88z82pc.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email>
Date:   Sat, 11 Sep 2021 23:48:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87o88z82pc.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/09/2021 17:13, Ævar Arnfjörð Bjarmason wrote:
> On Sat, Sep 11 2021, Jeff King wrote:
>
>> We converted argv_array (which later became strvec) to use size_t in
>> 819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
>> order to avoid the possibility of integer overflow. But later, commit
>> d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
>> converted these back to ints!
>>
>> Those two commits were part of the same patch series. I'm pretty sure
>> what happened is that they were originally written in the opposite order
>> and then cleaned up and re-ordered during an interactive rebase. And
>> when resolving the inevitable conflict, I mistakenly took the "rename"
>> patch completely, accidentally dropping the type change.
>>
>> We can correct it now; better late than never.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> This was posted previously in the midst of another thread, but I don't
>> think was picked up. There was some positive reaction, but one "do we
>> really need this?" to which I responded in detail:
>>
>>   https://lore.kernel.org/git/YTIBnT8Ue1HZXs82@coredump.intra.peff.net/
>>
>> I don't really think any of that needs to go into the commit message,
>> but if that's a hold-up, I can try to summarize it (though I think
>> referring to the commit which _already_ did this and was accidentally
>> reverted would be sufficient).
> Thanks, I have a WIP version of this outstanding starting with this
> patch that I was planning to submit sometime, but I'm happy to have you
> pursue it, especially with the ~100 outstanding patches I have in
> master..seen.
>
> It does feel somewhere between iffy and a landmine waiting to be stepped
> on to only convert the member itself, and not any of the corresponding
> "int" variables that track it to "size_t".
>
> If you do the change I suggested in
> https://lore.kernel.org/git/87v93i8svd.fsf@evledraar.gmail.com/ you'll
> find that there's at least one first-order reference to this that now
> uses "int" that if converted to "size_t" will result in a wrap-around
> error, we're lucky that one has a test failure.
>
> I can tell you what that bug is, but maybe it's better if you find it
> yourself :) I.e. I found *that* one, but I'm not sure I found them
> all. I just s/int nr/size_t *nr/ and eyeballed the wall off compiler
> errors & the code context (note: pointer, obviously broken, but makes
> the compiler yell).
>
> That particular bug will be caught by the compiler as it involves a >= 0
> comparison against unsigned, but we may not not have that everywhere...

I'm particularly interested in the int -> size_t change problem as part
of the wider 4GB limitations for the LLP64 systems [0] such as the
RaspPi, git-lfs (on windows [1]), and Git-for-Windows[2]. It is a big
problem.


Philip


[0]
http://nickdesaulniers.github.io/blog/2016/05/30/data-models-and-word-size/
[1] https://github.com/git-lfs/git-lfs/issues/2434  Git on Windows
client corrupts files > 4Gb
[2] https://github.com/git-for-windows/git/pull/2179  [DRAFT] for
testing : Fix 4Gb limit for large files on Git for Windows
