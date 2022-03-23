Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2ECC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbiCWQfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiCWQfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:35:20 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2462475224
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:33:49 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 27EA33F47F0;
        Wed, 23 Mar 2022 12:33:49 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BEED23F47EF;
        Wed, 23 Mar 2022 12:33:48 -0400 (EDT)
Subject: Re: [PATCH v7 24/29] t/perf/p7519: speed up test on Windows
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <803a540cc0022e893a75eae8815b3275a7fac3af.1647972011.git.gitgitgadget@gmail.com>
 <220322.865yo5q13f.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3c3ec71c-d2f6-338d-721a-a76bcb588e0a@jeffhostetler.com>
Date:   Wed, 23 Mar 2022 12:33:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220322.865yo5q13f.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/22 2:43 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 22 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Change p7519 to use `test_seq` and `xargs` rather than a `for` loop
>> to touch thousands of files.  This takes minutes off of test runs
>> on Windows because of process creation overhead.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   t/perf/p7519-fsmonitor.sh | 32 ++++++++++++++++++++------------
>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>> index c8be58f3c76..0611e533951 100755
>> --- a/t/perf/p7519-fsmonitor.sh
>> +++ b/t/perf/p7519-fsmonitor.sh
>> @@ -72,7 +72,7 @@ then
[...]
>>   
>> -trace_stop() {
>> +trace_stop () {
>>   	if test -n "$GIT_PERF_7519_TRACE"
>>   	then
>>   		unset GIT_TRACE2_PERF
>>   	fi
>>   }
> 
> (I think I noted in a previous version): Would be nice to have an
> optimization change not do unrelated refactoring....

In V4 24/29, Junio pushed a fixup! commit onto my branch to
add the space between the function name and the parens of the
function that I added.  And fixed the other existing instances
while he was at it.  I squashed that down into my branch during
cleanups between V4 and V5.  It seemed less trouble/noise than
splitting it into two commits.  (I was also at the 30 commit
limit of GGG in V5 and V6, so that was another reason not to
split it.)

Now that I'm at 29 in V7, I suppose that I could split it.



> 
>> +touch_files () {
>> +	n=$1
>> +	d="$n"_files
>> +
>> +	(cd $d ; test_seq 1 $n | xargs touch )
> 
> 
> ...and here we don't &&-chain.
> 

Right, thanks.

Jeff

