Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B61C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 14:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448885AbiDVOuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 10:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiDVOuu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 10:50:50 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B0B26
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 07:47:57 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6170F3F48F5;
        Fri, 22 Apr 2022 10:47:56 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 092163F47F4;
        Fri, 22 Apr 2022 10:47:55 -0400 (EDT)
Subject: Re: [PATCH v4 04/27] fsmonitor-settings: bare repos are incompatible
 with FSMonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
 <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
 <f2c0569c9012a86f252562a9a906f6de37d0a236.1648140680.git.gitgitgadget@gmail.com>
 <220419.86mtgh8kep.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <3a7d7f7b-dfba-9aa8-271f-6d12773668a4@jeffhostetler.com>
Date:   Fri, 22 Apr 2022 10:47:55 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220419.86mtgh8kep.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/19/22 5:44 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 24 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
>> index 46be55a4618..50ae3cca575 100644
>> --- a/builtin/fsmonitor--daemon.c
>> +++ b/builtin/fsmonitor--daemon.c
>> @@ -1449,6 +1449,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>>   		die(_("invalid 'ipc-threads' value (%d)"),
>>   		    fsmonitor__ipc_threads);
> 
> I think that structurally the way things are done in
> fsmonitor-settings.c make its use really hard to follow. E.g. here:
> 
>> +	prepare_repo_settings(the_repository);
> 
> We prep the repo, OK.
> 
>> +	fsm_settings__set_ipc(the_repository);
> 
> Set IPC.
> 
>> +	if (fsm_settings__error_if_incompatible(the_repository))
> 
> And here we'll error out if we're incompatible, and this is in the
> top-level cmd_fsmonitor__daemon() function. All OK, except why didn't we
> check this before "set IPC?".
> 
> Anyway, re-arranging some of the diff below:
> 
>> @@ -86,6 +111,9 @@ void fsm_settings__set_ipc(struct repository *r)
>>   
>>   	lookup_fsmonitor_settings(r);
>>   
>> +	if (check_for_incompatible(r))
>> +		return;
>> +
>>   	r->settings.fsmonitor->mode = FSMONITOR_MODE_IPC;
>>   	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
>>   }
> 
> Here in fsm_settings__set_ipc we return with a NOOP if we're not
> compatible.
> 
> Then:
> 
>> +int fsm_settings__error_if_incompatible(struct repository *r)
>> +{
>> +	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
>> +
>> +	switch (reason) {
>> +	case FSMONITOR_REASON_OK:
>> +		return 0;
>> +
>> +	case FSMONITOR_REASON_BARE:
>> +		error(_("bare repository '%s' is incompatible with fsmonitor"),
>> +		      xgetcwd());
>> +		return 1;
>> +	}
>> +
>> +	BUG("Unhandled case in fsm_settings__error_if_incompatible: '%d'",
>> +	    reason);
>> +}
> 
> Here we'll call fsm_settings__get_reason() which does the same.
> 
>> +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
>> +{
>> +	if (!r)
>> +		r = the_repository;
>> +
>> +	lookup_fsmonitor_settings(r);
>> +
>> +	return r->settings.fsmonitor->reason;
>> +}
> 
> Is there a reason we can't skip this indirection when using the API like
> this and e.g. do:
> 
> 	enum fsmonitor_reason reason;
> 	prepare_repo_settings(the_repository);
> 	reason = fsmonitor_check_for_incompatible(the_repository)
>          if (reason != FSMONITOR_REASON_OK)
>          	die("%s", fsm_settings__get_reason_string(reason));
> 
> There's just two callers of this API in "seen", and neither need/want
> this pattern where every method needs to lazy load itself, or the
> indirection where fsmonitor-settings.c needs to be used as a
> clearing-house for state management.
> 
> Maybe I'm missing something, but why not make check_for_incompatible()
> non-static and have the callers use that (and then it would return
> "fsmonitor_reason", not "int", the int return value being redundant to
> the enum)>

I suppose we could rearrange things to hide less of the
state management.  I'm not sure it matters one way or the
other, but I'll give it a try and see if simplifies things.

> 
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index 876112abb21..d29048f16f2 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -1237,6 +1237,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>   
>>   	if (fsmonitor > 0) {
>>   		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
>> +
>> +		if (fsm_settings__error_if_incompatible(the_repository))
>> +			return 1;
>> +
>>   		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
>>   			warning(_("core.fsmonitor is unset; "
>>   				"set it if you really want to "
> 
> This looks like a bug, we knew before aquiring the lockfile that we
> weren't compatible, so why wait until here to error out? This seems to
> skip the rollback_lock_file(), so won't we leave a stale lock?
> 

Yes, good catch.  The `return` here will bypass the rollback.
Hopefully, the above rearrangement will make this go away.

I do have to wonder about the rest of this function.  There are
several `die()`, `exit()`, `usage()`, `BUG()`, and other `return`
statements after the index lock is taken that won't hit the
rollback.  Should those be investigated too?  (I can't do that
now in the context of this series, though.)

Jeff
