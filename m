Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBE0C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiCCQQx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiCCQQw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:16:52 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F847198EDF
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:16:03 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 684543F4823;
        Thu,  3 Mar 2022 11:16:02 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 368133F4815;
        Thu,  3 Mar 2022 11:16:02 -0500 (EST)
Subject: Re: [PATCH 17/23] fsmonitor--daemon: stub in health thread
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <4a77f5b1fdef3af20fbfefccccc5fee194eb3422.1644940774.git.gitgitgadget@gmail.com>
 <4c784936-7b70-3910-6413-0438e86b23c4@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5bb246d3-82d0-835a-cfc4-be2824479a82@jeffhostetler.com>
Date:   Thu, 3 Mar 2022 11:16:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4c784936-7b70-3910-6413-0438e86b23c4@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/24/22 11:04 AM, Derrick Stolee wrote:
> On 2/15/2022 10:59 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create another thread to watch over the daemon process and
>> automatically shut it down if necessary.
>>
>> This commit creates the basic framework for a "health" thread
>> to monitor the daemon and/or the file system.  Later commits
>> will add platform-specific code to do the actual work.
> 
> ...
...
> 
>> diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
>> new file mode 100644
>> index 00000000000..94b1d020f25
>> --- /dev/null
>> +++ b/compat/fsmonitor/fsm-health-win32.c
>> @@ -0,0 +1,72 @@
>> +#include "cache.h"
>> +#include "config.h"
>> +#include "fsmonitor.h"
>> +#include "fsm-health.h"
>> +#include "fsmonitor--daemon.h"
>> +
>> +struct fsm_health_data
>> +{
>> +	HANDLE hEventShutdown;
>> +
>> +	HANDLE hHandles[1]; /* the array does not own these handles */
>> +#define HEALTH_SHUTDOWN 0
>> +	int nr_handles; /* number of active event handles */
>> +};
>> +
>> +int fsm_health__ctor(struct fsmonitor_daemon_state *state)
>> +{
>> +	struct fsm_health_data *data;
>> +
>> +	CALLOC_ARRAY(data, 1);
>> +
>> +	data->hEventShutdown = CreateEvent(NULL, TRUE, FALSE, NULL);
>> +
>> +	data->hHandles[HEALTH_SHUTDOWN] = data->hEventShutdown;
>> +	data->nr_handles++;
>> +
>> +	state->health_data = data;
>> +	return 0;
>> +}
>> +
>> +void fsm_health__dtor(struct fsmonitor_daemon_state *state)
>> +{
>> +	struct fsm_health_data *data;
>> +
>> +	if (!state || !state->health_data)
>> +		return;
>> +
>> +	data = state->health_data;
>> +
>> +	CloseHandle(data->hEventShutdown);
>> +
>> +	FREE_AND_NULL(state->health_data);
>> +}
>> +
>> +void fsm_health__loop(struct fsmonitor_daemon_state *state)
>> +{
>> +	struct fsm_health_data *data = state->health_data;
>> +
>> +	for (;;) {
>> +		DWORD dwWait = WaitForMultipleObjects(data->nr_handles,
>> +						      data->hHandles,
>> +						      FALSE, INFINITE);
>> +
>> +		if (dwWait == WAIT_OBJECT_0 + HEALTH_SHUTDOWN)
>> +			goto clean_shutdown;
>> +
>> +		error(_("health thread wait failed [GLE %ld]"),
>> +		      GetLastError());
>> +		goto force_error_stop;
>> +	}
>> +
>> +force_error_stop:
>> +	state->health_error_code = -1;
>> +	ipc_server_stop_async(state->ipc_server_data);
>> +clean_shutdown:
>> +	return;
>> +}
>> +
>> +void fsm_health__stop_async(struct fsmonitor_daemon_state *state)
>> +{
>> +	SetEvent(state->health_data->hHandles[HEALTH_SHUTDOWN]);
>> +}
> 
> But it apppears the Windows code is actually implemented. Did you
> mean to do that as separate step, or should the commit message
> mention that the Windows implementation is included?

The Windows version stubs in just enough of the thread-proc to keep
the health thread alive and waiting for a shutdown event.  It doesn'ta
actually have any health monitor in it yet.

I'll update the commit message to clarify.

Thanks
Jeff

