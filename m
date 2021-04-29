Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C9CC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E4361185
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhD2IXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhD2IXe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 04:23:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38599C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:22:48 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso10559979pjn.3
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oVHFkQ/SRAvphqxOsVySNTWHqf71ldc6TZ/PXTo0Eek=;
        b=NNavqQWk4HWhDeQ40bn4NmG/zjPxd7fETkLvxtaDhpBOsETrkDo4cmmKlDlxSWGNYV
         f/O049RiKiRV2y2qhv2Y1553HldXMJ7lM7qw2uAFP8OK3sVqBSIBwHC/3aV8k7z/Wdmw
         qh4cwRgdSZfibepIwdvQ0YDDxbuer1biKg51A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVHFkQ/SRAvphqxOsVySNTWHqf71ldc6TZ/PXTo0Eek=;
        b=q0HrC7OKpIxUthHoLzqSABJZBuSI0/lBQ/cUkBi3amHGJPN+Aj3Rsa5arASvHVkJzu
         BS9D7qSXtFHTkkaGp5WRCZPfT/lvQQEO/AHZ8yFlgQA6d2sfwKidLLuaLrNvq2Ffqm5x
         x53FKZ+47Zh44MOqpHxTjkop3kyZxSWWBkbjJGFarNgupFAosqbf8Ub9SNpvaCyT0ysg
         UYJYpiaK+/ajMbeDs98Z9ZB4NRMKFCANGQgH+4WOhhOTxEhpM7Ryr1YXtExnrktiQgh+
         3nbbFnnlurnV8o2YhtUOOUOo3fU2kI3KVD4TqpXR1MaZMOqBD9x6mEydGuNXHiMWnamt
         J8wg==
X-Gm-Message-State: AOAM5323XUL1pRL+QdyYoMeO0cQXMUBAv1z27YwrFsvr9pzTq4OeV22v
        4UedIcIO9opNUFyPyRBQ0NBGonzNvySigQ==
X-Google-Smtp-Source: ABdhPJz6ZPtgUF/9Ecj7959piZ2Mo7e0em6K6aY6N0Fe5nQQMyASCDaDd1G2xQ7WR2dqQF1LDPD5hw==
X-Received: by 2002:a17:90b:3b4b:: with SMTP id ot11mr4687173pjb.189.1619684567314;
        Thu, 29 Apr 2021 01:22:47 -0700 (PDT)
Received: from [192.168.245.142] (cpc108961-cmbg20-2-0-cust748.5-4.cable.virginm.net. [80.5.130.237])
        by smtp.gmail.com with ESMTPSA id o9sm1959141pfh.217.2021.04.29.01.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 01:22:46 -0700 (PDT)
Subject: Re: [PATCH] git-p4: speed up search for branch parent
To:     Joachim Kuebart <joachim.kuebart@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Joachim Kuebart via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
 <xmqq5z05akyf.fsf@gitster.g>
 <CAJGkkrQJFaLPfCBTVn6k1v9cCwF4wEUxr+ZyzebUBQJB8qLaWg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Message-ID: <b0befcf3-8d8a-f99f-d4f0-78b2cfe22505@diamand.org>
Date:   Thu, 29 Apr 2021 08:22:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJGkkrQJFaLPfCBTVn6k1v9cCwF4wEUxr+ZyzebUBQJB8qLaWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/04/2021 07:48, Joachim Kuebart wrote:
> On Thu, 29 Apr 2021 at 04:22, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Joachim Kuebart <joachim.kuebart@gmail.com>
>>
>> Thanks.  As git-p4 is not in my area of expertise, I'll make a style
>> critique first, while pinging Luke as an area expert (you can learn
>> who they are with "git shortlog --no-merges --since=18.months.ago
>> git-p4.py").
> 
> Hi Junio, thanks for your timely and thorough review and for putting
> up with my greenhorn mistakes ;-)
> 
>>> Previously, the code iterated through the parent branch commits and
>>> compared each one to the target tree using diff-tree.
>>
>> It is customary in this project to describe the problem in the
>> present tense.  In other words, whoever is writing the log message
>> still lives in the world without this patch applied to the system.
> 
> I will rephrase the commit message and give better details as you
> mentioned. Thanks a lot for your suggestions!
> 
>> When making a claim on performance, it is helpful to our readers to
>> give some numbers, even in a limited test, e.g.
>>
>>      In a sample history where ~100 commits needed to be traversed to
>>      find the fork point on my Windows box, the current code took
>>      10.4 seconds to complete, while the new code yields the same
>>      result in 1.8 seconds, which is a significant speed-up.
>>
>> or something along these lines.
> 
> I will add some measurements.
> 
>>> Signed-off-by: Joachim Kuebart <joachim.kuebart@gmail.com>
>>>   git-p4.py | 22 +++++++++++-----------
>>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/git-p4.py b/git-p4.py
>>> index 09c9e93ac401..dbe94e6fb83b 100755
>>> --- a/git-p4.py
>>> +++ b/git-p4.py
>>> @@ -3600,19 +3600,19 @@ def importNewBranch(self, branch, maxChange):
>>>           return True
>>>
>>>       def searchParent(self, parent, branch, target):
>>> +        for tree in read_pipe_lines(["git", "rev-parse",
>>> +                                     "{}^{{tree}}".format(target)]):
>>> +            targetTree = tree.strip()
>>
>> It looks very strange to run a commit that you expect a single line
>> of output, and read the result in a loop.  Doesn't git-p4.py supply
>> a more suitable helper to read a single line output from a command?
> 
> You're absolutely right that this isn't very readable. I had a quick
> look around for a function that reads a single-line response, but I'll
> look again and come up with a clearer solution.

I don't think there is one - git-p4 has lots of functions for calling 
`p4', but for calling git, it just uses Python's Popen() API.

A good question is whether we can start taking advantage of the newer 
features in Python3 which will obviously break backward compatibility.

> 
>>> +        for blob in read_pipe_lines(["git", "rev-list", "--format=%H %T",
>>>                                        "--no-merges", parent]):
>>
>> This is not a new problem you introduced, but when we hear word
>> "blob" in the context of this project, it reminds us of the "blob"
>> object, while the 'blob' variable used in this loop has nothing to
>> do with it.  Perhaps rename it to say 'line' or something? >
> Will do, thanks!

It confused me as well.

> 
>>> +            if blob[:7] == "commit ":
>>> +                continue
>>
>> Perhaps blob.startswith("commit ") to avoid hardcoded string length?
> 
> Yes, that's the name of the function that I can never think of when I need it.
> 
> Thanks again for your comments,
> 
> Joachim
> 

There are existing tests for importing branches which should cover this. 
I don't know if they need to be extended or not, you might want to check.

Looks good otherwise.


