Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EB4C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiK3X2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiK3X22 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 18:28:28 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04ED90777
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 15:19:12 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 79D52CA1246;
        Wed, 30 Nov 2022 18:18:28 -0500 (EST)
Received: from [10.0.0.3] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 40916CC8441;
        Wed, 30 Nov 2022 18:18:28 -0500 (EST)
Message-ID: <d9160bf2-4bce-2624-c80d-fd924e014f70@jeffhostetler.com>
Date:   Wed, 30 Nov 2022 18:18:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: fsmonitor: t7527 racy on OSX?
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric DeCosta <edecosta@mathworks.com>
Cc:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git ML <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <221121.86y1s4bfp6.gmgdl@evledraar.gmail.com>
 <Y3t/YbZUIuIJkSil@danh.dev>
 <BL0PR05MB55715FF24BD1AD53EE81A5A2D90D9@BL0PR05MB5571.namprd05.prod.outlook.com>
 <221122.86r0xuaawz.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <221122.86r0xuaawz.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/22/22 5:12 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Nov 22 2022, Eric DeCosta wrote:
> 
>>> -----Original Message-----
>>> From: Đoàn Trần Công Danh <congdanhqx@gmail.com>
>>> Sent: Monday, November 21, 2022 8:39 AM
>>> To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> Cc: Git ML <git@vger.kernel.org>; Eric DeCosta
>>> <edecosta@mathworks.com>; Jeff Hostetler <jeffhost@microsoft.com>
>>> Subject: Re: fsmonitor: t7527 racy on OSX?
>>>
>>> On 2022-11-21 14:07:13+0100, Ævar Arnfjörð Bjarmason
>>> <avarab@gmail.com> wrote:
>>>> I have access to a Mac OS X M1 box (gcc104 at [1]) where t7527
>>>> reliably fails due to what seems to be a race us doing something, and
>>>> assuming that fsmonitor picked up on it.
>>>
>>> See also https://lore.kernel.org/git/YvZbGAf+82WtNXcJ@danh.dev/
>>> <https://protect-
>>> us.mimecast.com/s/580RCpYn6ETDOBoycYVkUq?domain=lore.kernel.org>
>>>
>>> I raised 3 months ago and it seems like Jeff Hostetler is too busy.
>>>
>>>>
>>>> This makes the tests pass:
>>>>
>>>> diff --git a/t/t7527-builtin-fsmonitor.sh
>>>> b/t/t7527-builtin-fsmonitor.sh index 56c0dfffea..ce2555d558 100755
>>>> --- a/t/t7527-builtin-fsmonitor.sh
>>>> +++ b/t/t7527-builtin-fsmonitor.sh
>>>> @@ -428,6 +428,7 @@ test_expect_success 'edit some files' '
>>>> start_daemon --tf "$PWD/.git/trace" &&
>>>>
>>>> edit_files &&
>>>> + sleep 1 &&
>>>>
>>>> test-tool fsmonitor-client query --token 0 &&
>>>>
>>>> @@ -443,6 +444,7 @@ test_expect_success 'create some files' '
>>>> start_daemon --tf "$PWD/.git/trace" &&
>>>>
>>>> create_files &&
>>>> + sleep 1 &&
>>>>
>>>> test-tool fsmonitor-client query --token 0 &&
>>>>
>>>> @@ -471,6 +473,7 @@ test_expect_success 'rename some files' '
>>>> start_daemon --tf "$PWD/.git/trace" &&
>>>>
>>>> rename_files &&
>>>> + sleep 1 &&
>>>>
>>>> test-tool fsmonitor-client query --token 0 &&
>>>>
>>>> @@ -978,6 +981,7 @@ test_expect_success
>>> !UNICODE_COMPOSITION_SENSITIVE 'Unicode nfc/nfd' '
>>>> mkdir test_unicode/nfd/d_${utf8_nfd} &&
>>>>
>>>> git -C test_unicode fsmonitor--daemon stop &&
>>>> + sleep 1 &&
>>>>
>>>> if test_have_prereq UNICODE_NFC_PRESERVED then
>>>>
>>>> The failure is when we grep out the events we expect, which aren't
>>>> there, but if you manually inspect them they're there. I.e. they're
>>>> just not "in" yet.
>>>>
>>>> I thought this might be a lack of flushing or syncing in our own trace
>>>> code, but adding an fsync() to trace_write() didn't do the trick.
>>>>
>>>> 1. https://cfarm.tetaneutral.net/news/41#
>>>> <https://protect-
>>> us.mimecast.com/s/S6YNCqxoXGIWkoNRHEfMzu?domain=cfarm
>>>> .tetaneutral.net>
>>>
>>> --
>>> Danh
>>
>> Honestly, I'm not surprised. Stopping the daemon and grepping for
>> expected results immediately there after is just asking for these
>> sorts of races. Sleeping is a bit ugly, but without an explicit means
>> of synchronization is probably the best that can be done. I can take a
>> look at it some more as I have access to M1 Macs.
> 
> I don't see why it would have to do with stopping the daemon. If
> anything that should reduce the odds that you're running into a
> race. I.e. on OSX in general this will work:
> 
> 	echo foo >f &&
> 	grep foo f
> 
> Or, the equivalent with an "echo" that's not a shell built-in. I.e. we
> had a process start, print to a file, and then we grep data out of it
> agin.
> 
> The reason I'm saying it should reduce them is if the "echo" were some
> long-running daemon process that was still running the "grep" might fail
> because the "foo" was still in some buffer and hadn't been written or
> fsync'd to disk.
> 
> Anyway, all of that seems inapplicable to these failures, as we're not
> stopping the daemon yet by the time we run into the synchronization
> problem. We just *started* it, then renamed some files, but when we ask
> for those events we don't get them back.
> 
> Maybe there's some innocuous reason for that, but I have the sinking
> feeling that it might be some race between creating the files, the
> kernel getting those events, acting on them, but not having sent notice
> of those events to the daemon that's listening.
> 
> *That* would be much scarier, and would mean that this fsmonitor
> implementation would be racy outside of our tests, wouldn't it?

I managed to reliably reproduce this on my new M1 mac (and while
working on replacing the call to the deprecated FSEvents routine
mentioned in another thread).

I should have a fix for this/them shortly.

Thanks for your patience.
Jeff

