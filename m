Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23FDC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 19:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245108AbiBQTVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:21:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244868AbiBQTVW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 14:21:22 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BBFC3C37
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 11:21:07 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 96EFA3F4837;
        Thu, 17 Feb 2022 14:21:06 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 459AE3F4143;
        Thu, 17 Feb 2022 14:21:06 -0500 (EST)
Subject: Re: [PATCH v5 03/30] fsmonitor: config settings are
 repository-specific
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <384516ce1a190d836324b2c2262d611090207357.1644612979.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202171725060.348@tvgsbejvaqbjf.bet>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <456172c1-9648-c01b-c747-c6d77ae570bf@jeffhostetler.com>
Date:   Thu, 17 Feb 2022 14:21:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2202171725060.348@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/17/22 11:27 AM, Johannes Schindelin wrote:
> Hi Jeff,
> 
> 
> On Fri, 11 Feb 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Move fsmonitor config settings to a new and opaque
>> `struct fsmonitor_settings` structure.  Add a lazily-loaded pointer
>> to this into `struct repo_settings`
>>
>> Create an `enum fsmonitor_mode` type in `struct fsmonitor_settings` to
>> represent the state of fsmonitor.  This lets us represent which, if
>> any, fsmonitor provider (hook or IPC) is enabled.
>>
>> Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
>> related config settings.
>>
>> Get rid of the `core_fsmonitor` global variable.  Move the code to
>> lookup the existing `core.fsmonitor` config value into the fsmonitor
>> settings.
>>
>> Create a hook pathname variable in `struct fsmonitor-settings` and
>> only set it when in hook mode.
>>
>> Extend the definition of `core.fsmonitor` to be either a boolean
>> or a hook pathname.  When true, the builtin FSMonitor is used.
>> When false or unset, no FSMonitor (neither builtin nor hook) is
>> used.
>>
>> The existing `core_fsmonitor` global variable was used to store the
>> pathname to the fsmonitor hook *and* it was used as a boolean to see
>> if fsmonitor was enabled.  This dual usage and global visibility leads
>> to confusion when we add the IPC-based provider.  So lets hide the
>> details in fsmonitor-settings.c and let it decide which provider to
>> use in the case of multiple settings.  This avoids cluttering up
>> repo-settings.c with these private details.
>>
>> A future commit in builtin-fsmonitor series will add the ability to
>> disqualify worktrees for various reasons, such as being mounted from a
>> remote volume, where fsmonitor should not be started.  Having the
>> config settings hidden in fsmonitor-settings.c allows such worktree
>> restrictions to override the config values used.
> 
> Apart from my forward-compatibility concern regarding interpreting
> `core.fsmonitor` as a Boolean, this looks good. Just one thing:
> 
>> diff --git a/fsmonitor.h b/fsmonitor.h
>> index f20d72631d7..f9201411aa7 100644
>> --- a/fsmonitor.h
>> +++ b/fsmonitor.h
>> @@ -3,6 +3,7 @@
>>
>>   #include "cache.h"
>>   #include "dir.h"
>> +#include "fsmonitor-settings.h"
>>
>>   extern struct trace_key trace_fsmonitor;
>>
>> @@ -57,7 +58,11 @@ int fsmonitor_is_trivial_response(const struct strbuf *query_result);
>>    */
>>   static inline int is_fsmonitor_refreshed(const struct index_state *istate)
>>   {
>> -	return !core_fsmonitor || istate->fsmonitor_has_run_once;
>> +	struct repository *r = istate->repo ? istate->repo : the_repository;
> 
> I see this repeated a few times. Would it maybe make sense to change the
> signature of the `fsm_settings__*()` functions to accept an index instead
> of a repository?

I think is just me being paranoid -- testing istate->repo for null
and assuming the_repository if necessary.  I'm wondering if it is
always safe to just do

	fsm_mode = fsm_settings__get_mode(istate->repo);

(or maybe put the null check inside the fsm_settings__*() functions.


changing the signature of those fsm_* functions seems wrong since they
are associated with a repo and not an index.

Jeff


