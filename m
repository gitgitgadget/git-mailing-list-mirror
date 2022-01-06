Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C622C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 10:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiAFKVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 05:21:50 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:45573 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiAFKVu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 05:21:50 -0500
Received: from [91.113.179.170] (helo=[192.168.92.29])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1n5Psw-0000Ul-Vg; Thu, 06 Jan 2022 11:20:43 +0100
Message-ID: <54fc04b3-1b6d-c8c9-f3cc-8c8bd647f187@syntevo.com>
Date:   Thu, 6 Jan 2022 11:21:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/2] t7508: add tests capturing racy timestamp handling
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
 <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
 <7d58f80611193f8696d99e317fe6b1e53ac740f7.1641388523.git.gitgitgadget@gmail.com>
 <xmqqczl5hpaq.fsf@gitster.g>
From:   Marc Strapetz <marc.strapetz@syntevo.com>
In-Reply-To: <xmqqczl5hpaq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01/2022 21:59, Junio C Hamano wrote:
>> From: Marc Strapetz <marc.strapetz@syntevo.com>
>>   
>> +test_expect_success 'racy timestamps will be fixed for clean worktree' '
>> +	echo content >racy-dirty &&
>> +	echo content >racy-racy &&
>> +	git add racy* &&
>> +	git commit -m "racy test files" &&
>> +	# let status rewrite the index, if necessary; after that we expect
>> +	# no more index writes unless caused by racy timestamps; note that
>> +	# timestamps may already be racy now (depending on previous tests)
>> +	git status &&
>> +	test-tool chmtime =1234567890 .git/index &&
>> +	test-tool chmtime --get .git/index >out &&
>> +	grep ^1234567890 out &&
> 
> If file contents were 1234567890999, this will still hit, but I do
> not think that is what you wanted to see.  Perhaps
> 
> 	git status &&
> 	echo 1234567890 >expect &&
> 	test-tool chmtime=$(cat expect) .git/index &&
> 	test-tool chmtime --get .git/index >actual &&
> 	test_cmp expect actual
> 
> or something?  But I think you inherited this bogosity from the
> previous test, so I am OK to add a few more copies of the same
> bogosity to the test.
> 
> Somebody later has to step in and clean them all up, though.  When
> that happens, we should document how the magic 1234567890 timestamp
> was chosen near its first use.

It seems like this pattern was used only once before my changes, hence I 
will extract to test-lib-functions.sh and fix the bogosity for the next 
version of my patch.

-Marc
