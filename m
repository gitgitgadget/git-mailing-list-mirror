Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC4320248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDAVFL (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:05:11 -0400
Received: from siwi.pair.com ([209.68.5.199]:31168 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbfDAVFL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:05:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6271C3F40D9;
        Mon,  1 Apr 2019 17:05:10 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:74a2:1cda:f42b:77ce] (unknown [IPv6:2001:4898:8010:0:5dd8:1cda:f42b:77ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DBEFA3F40D0;
        Mon,  1 Apr 2019 17:05:09 -0400 (EDT)
Subject: Re: [PATCH v2 5/7] trace2: report peak memory usage of the process
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
 <86d8fe28cf2f51a494163f9cec3e3b0541288435.1553879063.git.gitgitgadget@gmail.com>
 <87k1gh9vii.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ded19f10-569a-f6d7-ad77-17a6f9c6b3a5@jeffhostetler.com>
Date:   Mon, 1 Apr 2019 17:05:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87k1gh9vii.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/29/2019 6:16 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 29 2019, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach Windows version of git to report peak memory usage
>> during exit() processing.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>   common-main.c                            |  2 +-
>>   compat/win32/trace2_win32_process_info.c | 50 ++++++++++++++++++++++--
>>   trace2.c                                 |  2 +
>>   trace2.h                                 | 14 +++++--
>>   4 files changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/common-main.c b/common-main.c
>> index 299ca62a72..582a7b1886 100644
>> --- a/common-main.c
>> +++ b/common-main.c
>> @@ -41,7 +41,7 @@ int main(int argc, const char **argv)
>>
>>   	trace2_initialize();
>>   	trace2_cmd_start(argv);
>> -	trace2_collect_process_info();
>> +	trace2_collect_process_info(TRACE2_PROCESS_INFO_STARTUP);
>>
>>   	git_setup_gettext();
>>
>> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
>> index 52bd62034b..2a514caed9 100644
>> --- a/compat/win32/trace2_win32_process_info.c
>> +++ b/compat/win32/trace2_win32_process_info.c
>> @@ -1,5 +1,6 @@
>>   #include "../../cache.h"
>>   #include "../../json-writer.h"
>> +#include "lazyload.h"
>>   #include <Psapi.h>
>>   #include <tlHelp32.h>
>>
>> @@ -137,11 +138,54 @@ static void get_is_being_debugged(void)
>>   				   "windows/debugger_present", 1);
>>   }
>>
>> -void trace2_collect_process_info(void)
>> +/*
>> + * Emit JSON data with the peak memory usage of the current process.
>> + */
>> +static void get_peak_memory_info(void)
>> +{
>> +	DECLARE_PROC_ADDR(psapi.dll, BOOL, GetProcessMemoryInfo,
>> +			  HANDLE, PPROCESS_MEMORY_COUNTERS, DWORD);
>> +
>> +	if (INIT_PROC_ADDR(GetProcessMemoryInfo)) {
>> +		PROCESS_MEMORY_COUNTERS pmc;
>> +
>> +		if (GetProcessMemoryInfo(GetCurrentProcess(), &pmc,
>> +					 sizeof(pmc))) {
>> +			struct json_writer jw = JSON_WRITER_INIT;
>> +
>> +			jw_object_begin(&jw, 0);
>> +
>> +#define KV(kv) #kv, (intmax_t)pmc.kv
>> +
>> +			jw_object_intmax(&jw, KV(PageFaultCount));
>> +			jw_object_intmax(&jw, KV(PeakWorkingSetSize));
>> +			jw_object_intmax(&jw, KV(PeakPagefileUsage));
>> +
>> +			jw_end(&jw);
>> +
>> +			trace2_data_json("process", the_repository,
>> +					 "windows/memory", &jw);
>> +			jw_release(&jw);
>> +		}
>> +	}
>> +}
>> +
>> +void trace2_collect_process_info(enum trace2_process_info_reason reason)
>>   {
>>   	if (!trace2_is_enabled())
>>   		return;
>>
>> -	get_is_being_debugged();
>> -	get_ancestry();
>> +	switch (reason) {
>> +	case TRACE2_PROCESS_INFO_STARTUP:
>> +		get_is_being_debugged();
>> +		get_ancestry();
>> +		return;
>> +
>> +	case TRACE2_PROCESS_INFO_EXIT:
>> +		get_peak_memory_info();
>> +		return;
>> +
>> +	default:
>> +		BUG("trace2_collect_process_info: unknown reason '%d'", reason);
>> +	}
>>   }
>> diff --git a/trace2.c b/trace2.c
>> index 490b3f071e..6baa65cdf9 100644
>> --- a/trace2.c
>> +++ b/trace2.c
>> @@ -213,6 +213,8 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
>>   	if (!trace2_enabled)
>>   		return code;
>>
>> +	trace2_collect_process_info(TRACE2_PROCESS_INFO_EXIT);
>> +
>>   	tr2main_exit_code = code;
>>
>>   	us_now = getnanotime() / 1000;
>> diff --git a/trace2.h b/trace2.h
>> index 894bfca7e0..888531eb08 100644
>> --- a/trace2.h
>> +++ b/trace2.h
>> @@ -391,13 +391,19 @@ void trace2_printf(const char *fmt, ...);
>>    * Optional platform-specific code to dump information about the
>>    * current and any parent process(es).  This is intended to allow
>>    * post-processors to know who spawned this git instance and anything
>> - * else the platform may be able to tell us about the current process.
>> + * else that the platform may be able to tell us about the current process.
>>    */
>> +
>> +enum trace2_process_info_reason {
>> +	TRACE2_PROCESS_INFO_STARTUP,
>> +	TRACE2_PROCESS_INFO_EXIT,
>> +};
>> +
>>   #if defined(GIT_WINDOWS_NATIVE)
>> -void trace2_collect_process_info(void);
>> +void trace2_collect_process_info(enum trace2_process_info_reason reason);
>>   #else
>> -#define trace2_collect_process_info() \
>> -	do {                          \
>> +#define trace2_collect_process_info(reason) \
>> +	do {                                \
>>   	} while (0)
>>   #endif
> 
> FWIW this is the "VmPeak" line in /proc/$$/status on Linux. I don't know
> if we can/should parse that in practice (I've been bitten in the past by
> things in /proc having high cost on some kernel versions in the past,
> notably smaps).
> 

Thanks,

Yeah, I've avoided adding the corresponding platform-specific changes
in for non-Windows versions because I didn't want to venture off into
the weeds and introduce a perf or functional problem (for something
that I'm not going to make use of in the short term).  Whereas, we're
seeing occasional perf problems with our Windows users on the OS repo
where some (yet to be determined) commands will just go out to lunch.

I suspect we'll have similar problems with out Mac users in the near
future, but I didn't want to jump in there just yet.

Jeff



