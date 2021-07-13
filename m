Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F68C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83416135A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 19:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhGMTIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 15:08:10 -0400
Received: from siwi.pair.com ([209.68.5.199]:16299 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGMTIK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 15:08:10 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7A7D33F47F3;
        Tue, 13 Jul 2021 15:05:19 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2AACC3F40B7;
        Tue, 13 Jul 2021 15:05:19 -0400 (EDT)
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
 <87h7hdbpgb.fsf@evledraar.gmail.com>
 <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
 <87k0lu2hw8.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fc37043d-5a6c-ae8a-09a9-8498c3715d43@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 15:05:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87k0lu2hw8.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/13/21 2:18 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 13 2021, Jeff Hostetler wrote:
> 
>> On 7/1/21 7:09 PM, Ævar Arnfjörð Bjarmason wrote:
>>> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>>>
>>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>>
>>>> Change p7519 to use a single "test-tool touch" command to update
>>>> the mtime on a series of (thousands) files instead of invoking
>>>> thousands of commands to update a single file.
>>>>
>>>> This is primarily for Windows where process creation is so
>>>> very slow and reduces the test run time by minutes.
>>>>
>>>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>>>> ---
>>>>    t/perf/p7519-fsmonitor.sh | 14 ++++++--------
>>>>    1 file changed, 6 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>>>> index 5eb5044a103..f74e6014a0a 100755
>>>> --- a/t/perf/p7519-fsmonitor.sh
>>>> +++ b/t/perf/p7519-fsmonitor.sh
>>>> @@ -119,10 +119,11 @@ test_expect_success "one time repo setup" '
>>>>    	fi &&
>>>>      	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
>>>> -	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
>>>> -	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
>>>> -	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
>>>> -	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
>>>> +	test-tool touch sequence --pattern="10_files/%d" --start=1 --count=10 &&
>>>> +	test-tool touch sequence --pattern="100_files/%d" --start=1 --count=100 &&
>>>> +	test-tool touch sequence --pattern="1000_files/%d" --start=1 --count=1000 &&
>>>> +	test-tool touch sequence --pattern="10000_files/%d" --start=1 --count=10000 &&
>>>> +
>>>>    	git add 1_file 10_files 100_files 1000_files 10000_files &&
>>>>    	git commit -qm "Add files" &&
>>>>    @@ -200,15 +201,12 @@ test_fsmonitor_suite() {
>>>>    	# Update the mtimes on upto 100k files to make status think
>>>>    	# that they are dirty.  For simplicity, omit any files with
>>>>    	# LFs (i.e. anything that ls-files thinks it needs to dquote).
>>>> -	# Then fully backslash-quote the paths to capture any
>>>> -	# whitespace so that they pass thru xargs properly.
>>>>    	#
>>>>    	test_perf_w_drop_caches "status (dirty) ($DESC)" '
>>>>    		git ls-files | \
>>>>    			head -100000 | \
>>>>    			grep -v \" | \
>>>> -			sed '\''s/\(.\)/\\\1/g'\'' | \
>>>> -			xargs test-tool chmtime -300 &&
>>>> +			test-tool touch stdin &&
>>>>    		git status
>>>>    	'
>>> Did you try to replace this with some variant of:
>>>       test_seq 1 10000 | xargs touch
>>> Which (depending on your xargs version) would invoke "touch"
>>> commands
>>> with however many argv items it thinks you can handle.
>>>
>>
>> a quick test on my Windows machine shows that
>>
>> 	test_seq 1 10000 | xargs touch
>>
>> takes 3.1 seconds.
>>
>> just a simple
>>
>> 	test_seq 1 10000 >/dev/null
>>
>> take 0.2 seconds.
>>
>> using my test-tool helper cuts that time in half.
> 
> There's what Elijah mentioned about test_seq, so maybe it's just that.
> 
> But what I was suggesting was using the xargs mode where it does N
> arguments at a time.
> 
> Does this work for you, and does it cause xargs to invoke "touch" with
> the relevant N number of arguments, and does it help with the
> performance?
> 
>      test_seq 1 10000 | xargs touch
>      test_seq 1 10000 | xargs -n 10 touch
>      test_seq 1 10000 | xargs -n 100 touch
>      test_seq 1 10000 | xargs -n 1000 touch

The GFW SDK version of xargs does have `-n N` and it does work as
advertised.  And it does slow down things considerably.  Letting it
do ~2500 per command in 4 commands took the 3.1 seconds listed above.

Add a -n 100 to it takes 5.7 seconds, so process creation overhead
is a factor here.


> 
> etc.
> 
> Also I didn't notice this before, but the -300 part of "chmtime -300"
> was redundant before then? I.e. you're implicitly changing it to "=+0"
> instead with your "touch" helper, are you not?
> 

Right. I'm changing it to the current time.

Jeff
