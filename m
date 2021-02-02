Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E69C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 18:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108FC64F53
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 18:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbhBBSVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:21:48 -0500
Received: from siwi.pair.com ([209.68.5.199]:48783 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235140AbhBBSRT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 13:17:19 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 731033F40F1;
        Tue,  2 Feb 2021 13:16:37 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 31D863F40E4;
        Tue,  2 Feb 2021 13:16:37 -0500 (EST)
Subject: Re: [PATCH 01/11] p7519: use xargs -0 rather than -d in test
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.860.git.1612216941.gitgitgadget@gmail.com>
 <cf252e24b8c4da19ee9f886a1ab9c9c391d89d66.1612216941.git.gitgitgadget@gmail.com>
 <xmqqsg6fid57.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b2c548b7-f641-2398-c200-d774af9cf628@jeffhostetler.com>
Date:   Tue, 2 Feb 2021 13:16:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqsg6fid57.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/1/21 6:25 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> The Mac version of xargs does not support the "-d" option.  Convert the test
>> setup to pipe the data set thru `lf_to_nul | xargs -0` instead.
> 
> "xargs -0" is not all that portable, either, and neither is "touch -h".
> 
> But since the t/perf stuff already depends on having GNU toolchain
> anyway, I can be persuaded to believe that it is OK.
> 
> Do we know that this part runs much later than the staged files are
> last touched, so that these uses of "touch" actually are effective
> to make the paths stat-dirty?  Otherwise, we may be just "touch"ing
> them with the timestamp they already have after all.

I'm not sure now that you mention it.  I suppose on modern filesystems
that have mtimes with nanosecond fields we could (are) assuming that
"touch" is actually doing something.  On older filesystems (such as
FAT32), you're right it is probably not doing anything at the speed
that the test runs.

TBH I'm not sure that the test needs the "-h".  Symlinks are not that
common and it shouldn't affect the timings that much if there are a few.

I'm not sure what to do about "-0".  Not even "--null" is portable.

Let me do a little digging here.

> 
> Thanks.
> 
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   t/perf/p7519-fsmonitor.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
>> index 9b43342806b..7bb37e9a6c1 100755
>> --- a/t/perf/p7519-fsmonitor.sh
>> +++ b/t/perf/p7519-fsmonitor.sh
>> @@ -165,7 +165,7 @@ test_fsmonitor_suite() {
>>   	'
>>   
>>   	test_perf_w_drop_caches "status (dirty) ($DESC)" '
>> -		git ls-files | head -100000 | xargs -d "\n" touch -h &&
>> +		git ls-files | head -100000 | lf_to_nul | xargs -0 touch -h &&
>>   		git status
>>   	'
