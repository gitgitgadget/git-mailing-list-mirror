Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB443C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 19:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiEQTsz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 15:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiEQTsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 15:48:53 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762037BDC
        for <git@vger.kernel.org>; Tue, 17 May 2022 12:48:52 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 05C0D3F4129;
        Tue, 17 May 2022 15:48:52 -0400 (EDT)
Received: from REPLICASERVER01.azshci.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A6DB33F40F3;
        Tue, 17 May 2022 15:48:51 -0400 (EDT)
Subject: Re: [PATCH v6 16/28] fsmonitor--daemon: stub in health thread
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten B??gershausen <tboegi@web.de>, rsbecker@nexbridge.com,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
 <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
 <32fc6ba74378cda7a5060d63066d16333765973a.1650662994.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2205121622030.352@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d2c909df-44f6-bc2c-ebbc-13ea51cf62fe@jeffhostetler.com>
Date:   Tue, 17 May 2022 15:48:51 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2205121622030.352@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/12/22 11:05 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> On Fri, 22 Apr 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create another thread to watch over the daemon process and
>> automatically shut it down if necessary.
>>
[...]

>> The platform-specific code for Windows sets up enough of the
>> WaitForMultipleObjects() machinery to watch for system and/or custom
>> events.  Currently, the set of wait handles only includes our custom
>> shutdown event (sent from our other theads).  Later commits in this
>> series will extend the set of wait handles to monitor other
>> conditions.
[...]

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
> 
> How about defining `HANDLE hHandles[HEALTH_SHUTDOWN + 1]` to indicate that
> the constant is used as an offset into `hHandles`?
> 
>> +	int nr_handles; /* number of active event handles */

I think I'd like to keep this one as is.  It matches the style that
I used in `fsm-listen-win32.c` where I have 3 listener handles.

Granted, it does look a little odd when there is only 1 handle in the
array.  But the idea was to allow new handles to be added as we want
to watch more things.

It might be clearer (in both of them) to define the array in
terms of an enum rather than a local list of #define's.
But I'm not sure it matters.

Jeff


