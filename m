Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D5C433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 15:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5998364D9E
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhBPPyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 10:54:40 -0500
Received: from siwi.pair.com ([209.68.5.199]:39633 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhBPPyc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 10:54:32 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5578E3F4098;
        Tue, 16 Feb 2021 10:53:50 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E3D4F3F404F;
        Tue, 16 Feb 2021 10:53:49 -0500 (EST)
Subject: Re: [PATCH v3 12/12] t0052: add simple-ipc tests and
 t/helper/test-simple-ipc tool
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <1e5c856ade8557d7514d9bee1c58bf978aba062c.1613174954.git.gitgitgadget@gmail.com>
 <20210213093052.GJ1015009@szeder.dev>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <01e7805a-a245-7640-42d4-5ecc01195598@jeffhostetler.com>
Date:   Tue, 16 Feb 2021 10:53:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210213093052.GJ1015009@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/13/21 4:30 AM, SZEDER Gábor wrote:

[...]

> [...]
> 
>> +int cmd__simple_ipc(int argc, const char **argv)
>> +{
>> +	const char *path = "ipc-test";
> 
> Since the path of the socket used in the tests is hardcoded, we could
> use it in the tests as well to check its presence/absence.
> 
> [...]
> 
>> diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
>> new file mode 100755
>> index 000000000000..e36b786709ec
>> --- /dev/null
>> +++ b/t/t0052-simple-ipc.sh
>> @@ -0,0 +1,134 @@
> 
> [...]
> 
>> +# Sending a "quit" message to the server causes it to start an "async
>> +# shutdown" -- queuing shutdown events to all socket/pipe thread-pool
>> +# threads.  Each thread will process that event after finishing
>> +# (draining) any in-progress IO with other clients.  So when the "send
>> +# quit" client command exits, the ipc-server may still be running (but
>> +# it should be cleaning up).
>> +#
>> +# So, insert a generous sleep here to give the server time to shutdown.
>> +#
>> +test_expect_success '`quit` works' '
>> +	test-tool simple-ipc send quit &&
>> +
>> +	sleep 5 &&
> 
> The server process is responsible for removing the socket, so instead
> of a hard-coded 5 seconds delay the test could (semi-)busy wait in a
> loop until the socket disappears like this:
> 
> diff --git a/t/t0052-simple-ipc.sh b/t/t0052-simple-ipc.sh
> index 6958835454..609d8d4283 100755
> --- a/t/t0052-simple-ipc.sh
> +++ b/t/t0052-simple-ipc.sh
> @@ -122,6 +122,13 @@ test_expect_success 'stress test threads' '
>   
>   test_expect_success '`quit` works' '
>   	test-tool simple-ipc send quit &&
> +	nr_tries_left=10 &&
> +	while test -S ipc-test &&
> +	      test $nr_tries_left -gt 0
> +	do
> +		sleep 1
> +		nr_tries_left=$(($nr_tries_left - 1))
> +	done &&
>   	test_must_fail test-tool simple-ipc is-active &&
>   	test_must_fail test-tool simple-ipc send ping
>   '
> 
> This way we might get away without any delay or with only a single
> one-second sleep in most cases, while we could bump the timeout a bit
> higher for the sake of a CI system in a particularly bad mood.
> 
> Would this work on Windows, or at least could it be tweaked to work
> there?
> 
> I think this is conceptually the same as what you did at startup,
> except in this example the test script waits instead of the test-tool
> subcommand.  Perhaps it would be worth incorporating this wait into
> the test-tool as well; or perhaps it would be simpler to do the
> waiting in the test script at startup as well.

Thanks for the suggestions.  Let me take another pass at
it.  I think making the "send quit" command try to wait until
the server shutdown would make it easier for all concerned.

> 
>> +	test_must_fail test-tool simple-ipc is-active &&
>> +	test_must_fail test-tool simple-ipc send ping
>> +'
>> +
>> +test_done
>> -- 
>> gitgitgadget
