Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E015F1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 17:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404671AbeKTDqF (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 22:46:05 -0500
Received: from avasout04.plus.net ([212.159.14.19]:59370 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeKTDqF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 22:46:05 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id OnExg9SLpYyh2OnEygYa3P; Mon, 19 Nov 2018 17:21:41 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MoN8FVSe c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=4E2Ug9f9Q2qsITbt49kA:9
 a=xinywWv30vdBhOAJ:21 a=J_Kcb51Nex-CMNiW:21 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive
 filesystems
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, git@jeffhostetler.com, gitster@pobox.com,
        newren@gmail.com, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
References: <20180817161645.28249-1-pclouds@gmail.com>
 <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a4d29a9a-5ac0-2952-42bc-5f822d44d055@ramsayjones.plus.com>
Date:   Mon, 19 Nov 2018 17:21:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <37b7a395-3846-6664-9c4d-66d2e4277618@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfB6Lonxrd1Rdn6B/hznl0xiVjrmUDWno5UANnBV3UPvI2BHxBc+ex9x6Gwxo7K/Rg01aLsYSTAWK3g6Yy1ha8wZ7UanXUwqpEZ17DaKqWZHV6tJR3XD6
 lphnrG1Jz1nuVA+HWaFRVJl5I2f2Y1zQizNJx/vtJipWphOyFcB2yaPF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/11/2018 12:28, Torsten Bögershausen wrote:
> On 2018-11-19 09:20, Carlo Marcelo Arenas Belón wrote:
>> While I don't have an HFS+ volume to test, I suspect this patch should be
>> needed for both, even if I have to say thay even the broken output was
>> better than the current state.
>>
>> Travis seems to be using a case sensitive filesystem so wouldn't catch this.
>>
>> Was windows/cygwin tested?
>>
>> Carlo
>> -- >8 --
>> Subject: [PATCH] entry: fix t5061 on macOS
>>
>> b878579ae7 ("clone: report duplicate entries on case-insensitive filesystems",
>> 2018-08-17) was tested on Linux with an excemption for Windows that needs
>> to be expanded for macOS (using APFS), which then would show :
>>
>> $ git clone git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
>> warning: the following paths have collided (e.g. case-sensitive paths
>> on a case-insensitive filesystem) and only one from the same
>> colliding group is in the working tree:
>>
>>   'man2/_Exit.2'
>>   'man2/_exit.2'
>>   'man3/NAN.3'
>>   'man3/nan.3'
>>
>> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>> ---
>>  entry.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/entry.c b/entry.c
>> index 5d136c5d55..3845f570f7 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -404,7 +404,7 @@ static void mark_colliding_entries(const struct checkout *state,
>>  {
>>  	int i, trust_ino = check_stat;
>>  
>> -#if defined(GIT_WINDOWS_NATIVE)
>> +#if defined(GIT_WINDOWS_NATIVE) || defined(__APPLE__)
>>  	trust_ino = 0;
>>  #endif
>>  
>>
> 
> Sorry,
> but I can't reproduce your problem here.
> 
> Did you test it on Mac ?
> If I run t5601 on a case sensitive files system
> (Mac, mounted NFS, exported from Linux)
> I get:
> ok 99 # skip colliding file detection (missing CASE_INSENSITIVE_FS of
> !MINGW,!CYGWIN,CASE_INSENSITIVE_FS)

I tested v2.20.0-rc0 on cygwin last night and it passed just fine.
I just ran t5601-clone.sh on its own and got:

    $ ./t5601-clone.sh
    ...
    ok 98 - clone on case-insensitive fs
    ok 99 # skip colliding file detection (missing !CYGWIN of !MINGW,!CYGWIN,CASE_INSENSITIVE_FS)
    ok 100 - partial clone
    ok 101 - partial clone: warn if server does not support object filtering
    ok 102 - batch missing blob request during checkout
    ok 103 - batch missing blob request does not inadvertently try to fetch gitlinks
    # passed all 103 test(s)
    # SKIP no web server found at '/usr/sbin/apache2'
    1..103
    $ 

ATB,
Ramsay Jones
