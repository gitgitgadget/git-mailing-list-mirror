Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D36C433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 22:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiEEW7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 18:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386498AbiEEW7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 18:59:10 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77410FC7
        for <git@vger.kernel.org>; Thu,  5 May 2022 15:55:27 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nmkNZ-0008TR-8N;
        Thu, 05 May 2022 23:55:26 +0100
Message-ID: <9b6b7ad0-df90-62e0-abb1-c23862ded4ac@iee.email>
Date:   Thu, 5 May 2022 23:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Git status extremely slow if any file is a multiple of 8GBi
Content-Language: en-GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jason Hatton <jhatton@globalfinishing.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <CY4PR16MB16558FE8E69B2045435AD59DAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
 <0d78c98a-841e-719b-add3-acc7a7a2d7c6@web.de>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <0d78c98a-841e-719b-add3-acc7a7a2d7c6@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/05/2022 22:04, René Scharfe wrote:
> Am 04.05.22 um 19:47 schrieb Jason Hatton:
>>>> The condition sd_size==0 is used as a signal for "no, we really need
>>>> to compare the contents", and causes the contents to be hashed, and
>>>> if the contents match the object name recorded in the index, the
>>>> on-disk size is stored in sd_size and the entry is marked as
>>>> CE_UPTODATE.  Alas, if the truncated st_size is 0, the resulting
>>>> entry would have sd_size==0 again, so a workaround like what you
>>>> outlined is needed.
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>> This is of secondary importance, but the fact that Jason observed
>>> 8GBi files gets hashed over and over unnecessarily means that we
>>> would do the same for an empty file, opening, reading 0-bytes,
>>> hashing, and closing, without taking advantage of the fact that
>>> CE_UPTODATE bit says the file contents should be up-to-date with
>>> respect to the cached object name, doesn't it?
>>>
>>> Or do we have "if st_size == 0 and sd_size == 0 then we know what it
>>> hashes to (i.e. EMPTY_BLOB_SHA*) and there is no need to do the
>>> usual open-read-hash-close dance" logic (I didn't check)?
>> Junio C Hamano
>>
>> As best as I can tell, it rechecks the zero sized files. My Linux box can run
>> git ls in .006 seconds with 1000 zero sized files in the repo. Rehashing every
>> file that is a multiple of 2^32 with every "git ls" on the other hand...
>>
>> I managed to actually compile git with the proposed changes.
> Meaning that file sizes of n * 2^32 bytes get recorded as 1 byte instead
> of 0 bytes?  Why 1 and not e.g. 2^32-1 or 2^31 (or 42)?

My thought on this. after considering a few options, would be that the
'sign bit' of the uint32_t size should be set to 1 when the high word of
the 64 bit filesize value is non zero.

This would result in file sizes of 0 to 4GiB-1 retaining their existing
values, and those from 4GiB onward produces a down-folded 2GiB to 4GiB-1
values.

This would mean, That we are able to detect almost all incremental and
decremental changes in filesizes, as well as retaining the 'zero is
racy' flag aspect.
>> It seems to correct
>> the problem and "make test" passes. If upgrading to the patched version if git,
>> git will rehash the 8GBi files once and work normally. If downgrading to an
>> unpatched version, git will perceive that the 8GBi files have changes. This
>> needs to be corrected with "git add" or "git checkout".
> Not nice, but safe.  Can there be an unsafe scenario as well?  Like if a
> 4GiB file gets added to the index by the new version, which records a
> size of 1, then the file is extended by one byte while mtime stays the
> same and then an old git won't detect the change?

There is still some potential for different Git versions to be
'confused' for these very large files, but I feel that it's relatively
safe (no worse than the 'set to unity' idea). For large files we will
always have that loss of precision at the 32bit rollover. It just a case
of choosing a least worst.

I haven't considered if my proposed 'truncation' overhead would be fast
code.

>> If you people are
>> interested, I may be able to find a way to send a patch to the list or put it
>> on github.
> Patches are always welcome, they make discussions and testing easier.
>
> René
Philip
