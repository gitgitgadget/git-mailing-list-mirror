Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED908C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 19:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiKXTSz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 24 Nov 2022 14:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiKXTSx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 14:18:53 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61B869AB3
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 11:18:52 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2AOJIlFv058395
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Nov 2022 14:18:48 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <010201d9002e$8e2f9940$aa8ecbc0$@nexbridge.com> <221124.86o7swnqc1.gmgdl@evledraar.gmail.com>
In-Reply-To: <221124.86o7swnqc1.gmgdl@evledraar.gmail.com>
Subject: RE: [BUG} t2201.7+ Failure to Create Thread in 2.39.0-rc0
Date:   Thu, 24 Nov 2022 14:18:41 -0500
Organization: Nexbridge Inc.
Message-ID: <010c01d90039$938568b0$ba903a10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFGpJPtZgFqVIqLLqBzAuIVm5wgnAIIG9s7r2LodpA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 24, 2022 1:41 PM, Ævar Arnfjörð Bjarmason wrote:
>[CC-ing Jeff, this is from the "stopwatch timers" topic]
>
>On Thu, Nov 24 2022, rsbecker@nexbridge.com wrote:
>
>> While running t2201.7 (and subsequent) for 2.39.0-rc0, I hit a
>> condition
>> where:
>
>Don't you mean t0211-trace2-perf.sh?
>
>> <snip>
>> + test_when_finished rm trace.perf actual test_config_global
>> + trace2.perfBrief 1 pwd test_config_global trace2.perfTarget
>> /home/ituglib/randall/jenkins/.jenkins/workspace/Git_Pipeline/t/trash
>> directory.t0211-trace2-perf/trace.perf
>> + test-tool trace2 101timer 5 10 3
>> fatal: failed to create thread[0]
>>
>> was encountered, causing the test to fail. Pointers on resolving this
>> would be helpful.
>
>Apparently we really could use a NO_PTHREADS=Y CI setup, because that's all
>that's needed to reproduce this on linux & elsewhere. Running the test with that:
>
>	+ test-tool trace2 101timer 5 10 3
>	fatal: failed to create thread[0]
>	error: last command exited with $?=128
>
>For that all that's needed is this:
>
>	diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
>	index 0b3436e8cac..cfba6861322 100755
>	--- a/t/t0211-trace2-perf.sh
>	+++ b/t/t0211-trace2-perf.sh
>	@@ -203,7 +203,7 @@ test_expect_success 'stopwatch timer test/test1' '
>	 	have_timer_event "main" "timer" "test" "test1" 5 actual
>	 '
>
>	-test_expect_success 'stopwatch timer test/test2' '
>	+test_expect_success PTHREADS 'stopwatch timer test/test2' '
>	 	test_when_finished "rm trace.perf actual" &&
>	 	test_config_global trace2.perfBrief 1 &&
>	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
>	@@ -249,7 +249,7 @@ test_expect_success 'global counter test/test1' '
>	 	have_counter_event "main" "counter" "test" "test1" 15 actual
>	 '
>
>	-test_expect_success 'global counter test/test2' '
>	+test_expect_success PTHREADS 'global counter test/test2' '
>	 	test_when_finished "rm trace.perf actual" &&
>	 	test_config_global trace2.perfBrief 1 &&
>	 	test_config_global trace2.perfTarget "$(pwd)/trace.perf" &&
>
>I think that's the correct fix here, and it should go into rc1.

I assume we do not have to modify the platform's entry in config.mak.uname, which already has NO_PTHREADS=UnfortunatelyYes.

Thanks,
Randall

