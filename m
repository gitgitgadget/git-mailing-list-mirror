Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F0C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 22:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348686AbiEKWYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 18:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiEKWYO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 18:24:14 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85513325A
        for <git@vger.kernel.org>; Wed, 11 May 2022 15:24:11 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1noukb-0004MA-DU;
        Wed, 11 May 2022 23:24:09 +0100
Message-ID: <972cb306-04ce-133d-9d09-5da40afd675f@iee.email>
Date:   Wed, 11 May 2022 23:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Prevent git from rehashing 4GBi files
Content-Language: en-US
To:     "Jason D. Hatton" <jason.hatton@gmail.com>,
        Jason Hatton <jhatton@globalfinishing.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, l.s.r@web.de
References: <CY4PR16MB1655F83010A128D4ED67C7EDAFC49@CY4PR16MB1655.namprd16.prod.outlook.com>
 <1a56b96c-2c58-ccaf-11ae-5e8264a323b1@iee.email>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <1a56b96c-2c58-ccaf-11ae-5e8264a323b1@iee.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/05/2022 18:47, Jason D. Hatton wrote:
>> Is there a problem that 1<<31, when on a 32bit long is MAX_NEG, 
>> rather than being MAX_POS? And the size would need to be positive to 
>> be an acceptable file size?
>> (The code is a bit of a mish-mash on the Windows LLP64 side, where 
>> long is only 32 bits).
>>
>> Philip
>> Apologies for the terseness.
>
> Philip
>
> I made a little test script and tried out several different
> things.
>
> tldr; It didn't make any difference.
>
> Files tested:
> 1, 2 and 4 GiB with and without LFS. Tested with 0, 1, 1<<30,
> and 1<<31 mung builds. I'm only listing the problems unless
> stated otherwise. The mung didn't appear to introduce any
> new issues with my limited tests.
>
> git 2.36.0.windows.1 release:    fails on 4GiB w/o LFS - corrupts pack 
> file
>    git status is very slow.
>    Sometimes stores zero file instead of corruption.
>
> git 2.36.0.windows.1 custom compile w/o patches:
>    fails on 4GiB w/o LFS - stores zero file
>    git status is very slow.
>
> git 2.36.0.windows.1 with 1U<<31 mung:
>    fails on 4GiB w/o LFS - stores zero file
>
> git 2.36.0.windows.1 with 1U<<30 mung:
>    fails on 4GiB w/o LFS - stores zero file
>
> git 2.36.0.windows.1 with 1 mung:
>    fails on 4GiB w/o LFS - stores zero file
>
> git 2.36.0 Ubuntu
>    unpatched works, but has the slow status issue.
>
> The test script I used is below:

Without the git-lfs (to grossly shorten the file size in the pack) I 
wasn't expecting much, given the use of 'long' in places in the code 
base for the file sizes, so 2GiB and 4GiB files would likely fail on the 
Windows LP32 parts.

I was under the impression that the core code for packs had been size_t 
hardened, but there may be some paths either in git-lfs or the actual 
file checkout that cause that fail.

There was a previous series by Matt Cooper on:
  "Allow clean/smudge filters to handle huge files in the LLP64 data model"
(https://lore.kernel.org/git/pull.1068.git.1635320952.gitgitgadget@gmail.com/t/#u)
  Merge commit f9ba6acaa9348ea7b733bf78adc2f084247a912f
'mc/clean-smudge-with-llp64'

That series had some in-code checks, and some test-suite tests, though 
the latter classed as EXPENSIVE (i.e. not normally run), which may add 
more insight.

>
>
> #!/bin/sh
>
> GB1=$((1 * 1024*1024*1024))
> GB2=$((2 * 1024*1024*1024))
> GB4=$((4 * 1024*1024*1024))
>
> die()
> {
>    echo "$1"
>    exit 1
> }
>
> test_file()
> {
>    echo "=== TESTING $2 ==="
>    rm -rf .git .gitattributes .gitignore .gitmodules &&
>        git init &&
>        git lfs track '*.big' &&
>        truncate --size "$1" "$2" &&
>        git add "$2" &&
>        git commit -m "$2" &&
>        git fsck &&
>        mv "$2" bak &&
>        git restore "$2" &&
>        cmp "$2" bak || die "$2"
>    git status && timeout 5 git status || die "$2 git status slow"
>    rm -rf .git .gitattributes .gitignore .gitmodules "$2" bak
> }
>
> test_file "$GB1" gb1.big
> test_file "$GB2" gb2.big
> test_file "$GB4" gb4.big
> test_file "$GB1" gb1
> test_file "$GB2" gb2
> test_file "$GB4" gb4
> echo done 
--
Philip
