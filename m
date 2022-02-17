Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ADBC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244935AbiBQTEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:04:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbiBQTEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 14:04:10 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5051F8093D
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 11:03:55 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7BC343F4823;
        Thu, 17 Feb 2022 14:03:54 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2F4C43F483A;
        Thu, 17 Feb 2022 14:03:54 -0500 (EST)
Subject: Re: [PATCH v5 24/30] t/perf/p7519: speed up test on Windows
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <fcf843a0d42f3a6b1d226b42014835c3e410fc7d.1644612979.git.gitgitgadget@gmail.com>
 <xmqqk0dub8ex.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <66663b27-952e-5072-3123-6a091c56d315@jeffhostetler.com>
Date:   Thu, 17 Feb 2022 14:03:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0dub8ex.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/16/22 8:15 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +touch_files () {
>> +	n=$1
>> +	d="$n"_files
>> +
>> +	(cd $d ; test_seq 1 $n | xargs touch )
>> +}
>> +
>>   test_expect_success "one time repo setup" '
>>   	# set untrackedCache depending on the environment
>>   	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
>> @@ -119,10 +126,11 @@ test_expect_success "one time repo setup" '
>>   	fi &&
>>   
>>   	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
>> -	for i in $(test_seq 1 10); do touch 10_files/$i || return 1; done &&
>> -	for i in $(test_seq 1 100); do touch 100_files/$i || return 1; done &&
>> -	for i in $(test_seq 1 1000); do touch 1000_files/$i || return 1; done &&
>> -	for i in $(test_seq 1 10000); do touch 10000_files/$i || return 1; done &&
>> +	touch_files 1 &&
> 
> This causes touch_files to chdir to 1_files and run "touch 1" in
> there, but because there is no such directory (we have 1_file/
> directory, but not 1_files/ directory), it would fail.
> 
>> +	touch_files 10 &&
>> +	touch_files 100 &&
>> +	touch_files 1000 &&
>> +	touch_files 10000 &&
> 
> Apparently nobody has run this perf script recently since part #2
> was posted.
> 
>>   	git add 1_file 10_files 100_files 1000_files 10000_files &&
> 
> The original introduced at bb7cc7e7 (t/perf/fsmonitor: separate one
> time repo initialization, 2020-10-26) created an empty directory 1_file
> and without creating anything in it, ran "git add" on it.
> 
> If we are not doing anything to 1_file directory anyway, perhaps we
> can get rid of it to avoid the breakage in "make perf"?
> 
> If we have a chance to reroll this series, we can squash in
> something like this, perhaps (it does not deserve to be a separate
> step).

Good catch!

It looks to me like there was an oversight/typo in the original
89afd5f5ad (t/perf: add fsmonitor perf test for git diff, 2020-10-20).
They created the "1_file" directory and didn't put anything in it.
Then later when they test it, they say "0_files" in the test name
and "1_file" in the "git diff" command.

I don't think it's worth keeping an empty directory here, since there
won't be anything in the index after the add and since the directory
is empty the untracked cache won't have anything to scan.

My version (without the typo) would have created 1 file in the directory
but I don't think that's worth keeping either, since we create thousands
of files in steps right after it.

I'll make a note to remove it.

Jeff



> 
> --- >8 ---
> Subject: [PATCH] p7519: leave 1_file directory empty
> 
> The step "t/perf/p7519: speed up test on Windows" in the topic
> builtin-fsmonitor-part-2 (not in 'next' yet) attempts to create one
> file in 1_files directory, but the original introduced at bb7cc7e7
> (t/perf/fsmonitor: separate one time repo initialization,
> 2020-10-26):
> 
>   (1) created 1_file directory,
> 
>   (2) left the directory empty, and
> 
>   (3) a later test expected (and still expects) that there is nothing
>       in the directory.
> 
> Revert the behaviour back to what the original wanted to do.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>   t/perf/p7519-fsmonitor.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
> index 9a2288a622..a1c552129c 100755
> --- a/t/perf/p7519-fsmonitor.sh
> +++ b/t/perf/p7519-fsmonitor.sh
> @@ -126,7 +126,7 @@ test_expect_success "one time repo setup" '
>   	fi &&
>   
>   	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
> -	touch_files 1 &&
> +	: 1_file directory should be left empty &&
>   	touch_files 10 &&
>   	touch_files 100 &&
>   	touch_files 1000 &&
> 
