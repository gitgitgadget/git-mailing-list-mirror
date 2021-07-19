Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788A7C07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6004260FE4
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345993AbhGSQUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 12:20:04 -0400
Received: from siwi.pair.com ([209.68.5.199]:13251 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352498AbhGSQON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 12:14:13 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D60A23F40F4;
        Mon, 19 Jul 2021 12:54:49 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8B1843F4095;
        Mon, 19 Jul 2021 12:54:49 -0400 (EDT)
Subject: Re: [PATCH v3 11/34] fsmonitor-fs-listen-win32: stub in backend for
 Windows
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <5a9bda7220356ebf0689bb6aaa9068520dc6e33b.1625150864.git.gitgitgadget@gmail.com>
 <87v95tbqgh.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c62cf635-1d24-3b63-9566-b98aa2ec2af5@jeffhostetler.com>
Date:   Mon, 19 Jul 2021 12:54:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87v95tbqgh.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 6:45 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Stub in empty backend for fsmonitor--daemon on Windows.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   Makefile                                     | 13 ++++++
>>   compat/fsmonitor/fsmonitor-fs-listen-win32.c | 21 +++++++++
>>   compat/fsmonitor/fsmonitor-fs-listen.h       | 49 ++++++++++++++++++++
>>   config.mak.uname                             |  2 +
>>   contrib/buildsystems/CMakeLists.txt          |  5 ++
>>   5 files changed, 90 insertions(+)
>>   create mode 100644 compat/fsmonitor/fsmonitor-fs-listen-win32.c
>>   create mode 100644 compat/fsmonitor/fsmonitor-fs-listen.h
>>
>> diff --git a/Makefile b/Makefile
>> index c45caacf2c3..a2a6e1f20f6 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -467,6 +467,11 @@ all::
>>   # directory, and the JSON compilation database 'compile_commands.json' will be
>>   # created at the root of the repository.
>>   #
>> +# If your platform supports a built-in fsmonitor backend, set
>> +# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
>> +# `compat/fsmonitor/fsmonitor-fs-listen-<name>.c` that implements the
>> +# `fsmonitor_fs_listen__*()` routines.
>> +#
>>   # Define DEVELOPER to enable more compiler warnings. Compiler version
>>   # and family are auto detected, but could be overridden by defining
>>   # COMPILER_FEATURES (see config.mak.dev). You can still set
>> @@ -1929,6 +1934,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
>>   	COMPAT_OBJS += compat/access.o
>>   endif
>>   
>> +ifdef FSMONITOR_DAEMON_BACKEND
>> +	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
>> +	COMPAT_OBJS += compat/fsmonitor/fsmonitor-fs-listen-$(FSMONITOR_DAEMON_BACKEND).o
>> +endif
>> +
>>   ifeq ($(TCLTK_PATH),)
>>   NO_TCLTK = NoThanks
>>   endif
>> @@ -2793,6 +2803,9 @@ GIT-BUILD-OPTIONS: FORCE
>>   	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>>   	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
>>   	@echo X=\'$(X)\' >>$@+
>> +ifdef FSMONITOR_DAEMON_BACKEND
>> +	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
>> +endif
> 
> Why put this in an ifdef?
> 
> In 342e9ef2d9e (Introduce a performance testing framework, 2012-02-17)
> we started doing that for some perf/test options (which b.t.w., I don't
> really see the reason for, maybe it's some subtlety in how test-lib.sh
> picks those up).
> 
> But for all the other compile-time stuff we don't ifdef it, we just
> define it, and then you get an empty value or not.
> 
> This would AFAICT be the first build-time-for-the-C-program option we
> ifdef for writing a line to GIT-BUILD-OPTIONS.
> 

(I'm going to respond here on the original question rather than on any
of the follow up responses in an attempt at diffusing things a bit.)

I added the ifdef because I thought it to be the *most conservative*
thing that I could do.  The output of the generated file on unsupported
platforms should be *identical* to what it was before my changes.  I
only alter the contents of the generated file on supported platforms.

Later, when the generated file is consumed, we don't need to worry about
the effect (if any) on incremental compiles -- we will know that it
won't be set -- just like it was not set in the original compile.

That change appears right before a 12 other ifdef'd symbols also being
written to that generated file.  Most are test and perf, but some are
not.  But my point is that the pattern is present already.

The original question also references a 9.5 year old commit which
uses the same pattern as I've used here.  It also muddies the water
on why it was/wasn't needed back then.  And hints at possible
side-effects in some of our test scripts.  So it is clear that the
confusion/disagreements that we are having with the current patch
and whether or not to ifdef are not new.


So, is there value in being explicit and having the ifdef ??


There are well defined Make rules (and Junio gave us a very elegant
little script to demonstrate that), but the subtleties are there.
Especially with our use generated files like `GIT-BUILD-OPTIONS`.
We have a mailing list full of experts and yet this question received
a lot more discussion than I thought possible or necessary, but it
took a test script to demonstrate that the results are the same and it
doesn't matter.  Perhaps the clarity is worth it for the price of a
simple ifdef.


So, how much time have we (collectively) wasted discussing this
subtlety ??


To summarize, I added the ifdef to make it explicitly clear that
I'm not altering behavior on unsupported platforms.  I can remove it
from V4 if desired or I can keep it.  (We all now know that it doesn't
functionally matter -- it does however, provide clarity.)


Sorry if this sounded like a rant,
Jeff
