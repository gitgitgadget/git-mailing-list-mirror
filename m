Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950F2C433EF
	for <git@archiver.kernel.org>; Tue, 10 May 2022 22:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiEJWpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 18:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiEJWpS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 18:45:18 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF920D271
        for <git@vger.kernel.org>; Tue, 10 May 2022 15:45:17 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1noYbU-00043O-AP;
        Tue, 10 May 2022 23:45:16 +0100
Message-ID: <1a56b96c-2c58-ccaf-11ae-5e8264a323b1@iee.email>
Date:   Tue, 10 May 2022 23:45:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Content-Language: en-US
To:     Jason Hatton <jhatton@globalfinishing.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CY4PR16MB1655F83010A128D4ED67C7EDAFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CY4PR16MB1655F83010A128D4ED67C7EDAFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05/2022 03:15, Jason Hatton wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>>> This may treat non-zero multiple of 4GiB as "not racy", but has
>>>> anybody double checked the concern Réne brought up earlier that a
>>>> 4GiB file that was added and then got rewritten to 2GiB within the
>>>> same second would suddenly start getting treated as not racy?
>>> This is the pre-existing problem, that ~1in 2^31 size changes might not
>>> get noticed for size change. The 0 byte / 4GiB change is an identical
>>> issue, as is changing from 3 bytes to 4GiB+3 bytes, etc., so that's no
>>> worse than before (well maybe twice as 'unlikely').
>> OK, it added one more case to 2^32-1 existing cases, I guess.
>>
>>>> The patch (the firnal version of it anyway) needs to be accompanied
>>>> by a handful of test additions to tickle corner cases like that.
>>> They'd be protected by the EXPENSIVE prerequisite I would assume.
>> Oh, absolutely.  Thanks for spelling that out.
> I have been testing out the patch a bit and have good and (mostly) bad news.
>
> What works using a munge value of 1.
>
> $ git add
> $ git status
>
> Racy seems to work.
>
> $ touch .git/index 4GiB # 4GiB is now racy
> $ git status # Git will rehash the racy file
> $ git status # Git cached the file. Second status is fast.
>
> What doesn't work.
>
> $ git checkout 4GiB
> $ fatal: packed object is corrupt!
>
> Using a munge value of 1<<31 causes even more problems. The file hash in the
> index for 4GiB files (git ls-files -s --debug) are set to the zero file hash.
>
> I looked up and down the code base and couldn't figure out how the munged
> value was leaking out of read-cache.c and breaking things. Most of the code
> I found tends to use stat and then convert that to a size_t, not using the
> munged unsigned int at all.
>
> Maybe someone else will have better luck. This seems over my head :(
>
> Thanks
> --
> Jason
>
Is there a problem that 1<<31, when on a 32bit long is MAX_NEG, rather 
than being MAX_POS? And the size would need to be positive to be an 
acceptable file size?
(The code is a bit of a mish-mash on the Windows LLP64 side, where long 
is only 32 bits).

Philip
Apologies for the terseness.
