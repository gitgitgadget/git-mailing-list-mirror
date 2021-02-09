Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C4C433E6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 15:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC6164E05
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 15:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbhBIPqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 10:46:36 -0500
Received: from siwi.pair.com ([209.68.5.199]:25657 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232609AbhBIPq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 10:46:26 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 8E77A3F40FA;
        Tue,  9 Feb 2021 10:45:44 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D9D5D3F40D9;
        Tue,  9 Feb 2021 10:45:43 -0500 (EST)
Subject: Re: [PATCH v2 09/14] simple-ipc: add t/helper/test-simple-ipc and
 t0052
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <f0bebf1cdb31f94cb111df100b3bcb5e2d93a91e.1612208747.git.gitgitgadget@gmail.com>
 <20210202213523.GD2091@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7a84352f-1b86-ff3d-27f0-131b873573b5@jeffhostetler.com>
Date:   Tue, 9 Feb 2021 10:45:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210202213523.GD2091@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/2/21 4:35 PM, SZEDER Gábor wrote:
> On Mon, Feb 01, 2021 at 07:45:42PM +0000, Jeff Hostetler via GitGitGadget wrote:
>> diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
>> new file mode 100755
>> index 00000000000..69588354545
>> --- /dev/null
>> +++ b/t/t0052-simple-ipc.sh
>> @@ -0,0 +1,129 @@
>> +#!/bin/sh
>> +
>> +test_description='simple command server'
>> +
>> +. ./test-lib.sh
>> +
>> +test-tool simple-ipc SUPPORTS_SIMPLE_IPC || {
>> +	skip_all='simple IPC not supported on this platform'
>> +	test_done
>> +}
>> +
>> +stop_simple_IPC_server () {
>> +	test -n "$SIMPLE_IPC_PID" || return 0
>> +
>> +	kill "$SIMPLE_IPC_PID" &&
>> +	SIMPLE_IPC_PID=
>> +}
>> +
>> +test_expect_success 'start simple command server' '
>> +	{ test-tool simple-ipc daemon --threads=8 & } &&
>> +	SIMPLE_IPC_PID=$! &&
>> +	test_atexit stop_simple_IPC_server &&
>> +
>> +	sleep 1 &&
> 
> This will certainly lead to occasional failures when the daemon takes
> longer than that mere 1 second delay under heavy load or in CI jobs.


Good point.  Thanks!


> 
>> +
>> +	test-tool simple-ipc is-active
>> +'
