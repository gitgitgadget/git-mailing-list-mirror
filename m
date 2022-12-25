Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD4BC46467
	for <git@archiver.kernel.org>; Sun, 25 Dec 2022 15:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiLYPoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 10:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLYPoT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 10:44:19 -0500
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D804EA5
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 07:44:17 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4Ng4wD40mSz5tlB;
        Sun, 25 Dec 2022 16:44:12 +0100 (CET)
Message-ID: <ef79236a-1c47-8775-3acb-aa23b7a300f9@kdbg.org>
Date:   Sun, 25 Dec 2022 16:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqpmcqv7qh.fsf@gitster.g>
 <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr> <xmqqa63ss3fl.fsf@gitster.g>
 <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de> <xmqq7cyksy88.fsf@gitster.g>
 <3c55ac67-5090-b7af-a212-2996bad66fb2@kdbg.org>
 <2090204b-52e9-a22f-f0c9-f812d1231863@web.de>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <2090204b-52e9-a22f-f0c9-f812d1231863@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.12.22 um 14:31 schrieb René Scharfe:
> Am 24.12.22 um 09:10 schrieb Johannes Sixt:
>> Am 21.12.22 um 14:05 schrieb Junio C Hamano:
>>> I know we have been operating under such a test environment, but
>>> after seeing the exchange between Réne and J6t, I was hoping that we
>>> do not have to keep being sloppy.
>>
>> Things did not turn out to be as simple. After ripping out all
>> special-casing of GIT_TEST_CMP from a MinGW build, I notice at least one
>> case that needs special treatment (it's `tar tf` that writes CRLF
>> output).
> 
> That would affect t6132 and perhaps t9502, right?
> 
> How can I reproduce it?  I get only LF:
> 
>    $ uname -rs
>    MINGW64_NT-10.0-22621 3.3.6-341.x86_64
> 
>    $ git archive HEAD Makefile | tar tf - | hexdump.exe -C
>    00000000  4d 61 6b 65 66 69 6c 65  0a                       |Makefile.|
>    00000009
> 
> Is there some configuration option that I need to set?

Good catch! Looks like I am wrong. In my environment I give the Windows
tools precedence over the MinGW tools. There is a tar.exe in
C:\Windows\System32 that writes CRLF (instead of just LF) that I was
using in my test runs.

> NATIVE_CRLF seems intended to track the macro of the same name, so it
> probably makes sense to mirror config.mak.uname, but a test helper (or
> "git version --build-options" line) that returns the actual value would
> probably be more robust.

Yes, indeed, NATIVE_CRLF has nothing to do with the CRLF vs LF behavior
of the toolset. We can ignore it in this discussion. Sorry for bringing
it to the table.

>> For the time being, I suggest to take Dscho's patch.
> 
> The patch is intended to make comparisons faster.  That works for big
> files, but the test suite compares small ones.   The total duration of
> a test suite run is about one minute longer with the patch than without
> it for me [1].  I retried with 7c2ef319c5 (The first batch for 2.40,
> 2022-12-19), and that's still the case.  Do you get different numbers?

I'm not going to measure it (one full run takes ~2 hours). I trusted
Dscho's argument that this patch brings a much better improvement based
on the one case that is cited in the commit message, but if that was
just an extraordinary outlier, I am not sure anymore...

-- Hannes

