Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D5C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbiCDOAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 09:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiCDOAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 09:00:24 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0AA41987
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:59:36 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4K98c55bwnz5tlG;
        Fri,  4 Mar 2022 14:59:33 +0100 (CET)
Message-ID: <674822c0-583c-a5ca-6528-751777a24f99@kdbg.org>
Date:   Fri, 4 Mar 2022 14:59:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
Content-Language: en-US
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
 <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
 <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
 <c1298c9d-0f4a-40b8-b337-896f4d4777f3@kdbg.org>
 <90596af6-0158-beb9-7fa7-9237e7cff4fb@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <90596af6-0158-beb9-7fa7-9237e7cff4fb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.03.22 um 13:28 schrieb Jaydeep Das:
> On 3/4/22 01:34, Johannes Sixt wrote:
>> Am 03.03.22 um 12:41 schrieb Jaydeep Das:
>>> How about modifying the number match regex to:
>>>
>>> `[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]` ?
>>>
>>> The `[^a-zA-Z]` in the end would make sure to not match
>>> the `.F` in `X.Find`.
>  
>> No, you cannot do that, because then in X.u+1 you have three tokens X
>> .u+ 1, which you do not want, either.
> 
> If X is an integer here, then

No, I mean X literally, i.e., an identifier.

> 
> In C/C++ 2.f is equivalent to 2.000000
> However in Kotlin 2.f is invalid syntax. 2.0f is valid.
> 
> So is implementing a proper regex for invalid syntax really
> necessary?

No, that's not necessary. It can be assumed that invalid syntax does not
occur. For this reason...

>> Have a look at the regex in the cpp driver. I think we need something
>> like this:
>>
>>    /* integers floatingpoint numbers */
>>    "|[0-9][0-9_.]*([Ee][*-]?[0-9]+)?[FfLl]*"

... I propose this loose [0-9_.]* after the first digit, even though it
would match "9.8_7._65"; we can assume that this invalid token will not
occur.

BTW, make that [FfLlUl] near the end.

>>    /* floatingpoint numbers that begin with a decimal point */
>>    "|[.][0-9][0-9_]*([Ee][*-]?[0-9]+)?[FfLl]*"
> 
> 
>> Drop the second option if numbers such as .5 are invalid syntax in
>> Kotlin.
> .5 is valid syntax in Kotlin.

OK, then we need this second branch, which ensures that there is a digit
after the fullstop.

-- Hannes
