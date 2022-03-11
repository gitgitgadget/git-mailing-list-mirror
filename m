Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1620C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiCKWwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiCKWwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:13 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB2913D900
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:25:52 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D75863F4161;
        Fri, 11 Mar 2022 17:25:51 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 781A53F4139;
        Fri, 11 Mar 2022 17:25:51 -0500 (EST)
Subject: Re: [PATCH v2 04/27] fsmonitor-settings: bare repos are incompatible
 with FSMonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <8c4f90ae4fd5d9fbac9acb9307ee82ceffc7df08.1646777727.git.gitgitgadget@gmail.com>
 <220311.86k0d1i7xr.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <73f6702b-95cd-794e-6ca7-5c995294935a@jeffhostetler.com>
Date:   Fri, 11 Mar 2022 17:25:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220311.86k0d1i7xr.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/10/22 8:31 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 08 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>> [...]
>> +	prepare_repo_settings(the_repository);
>> +	fsm_settings__set_ipc(the_repository);
>> +
>> +	if (fsm_settings__get_mode(the_repository) == FSMONITOR_MODE_INCOMPATIBLE) {
>> +		const char *msg = fsm_settings__get_reason_msg(the_repository);
>> +
>> +		return error("%s '%s'", msg ? msg : "???", xgetcwd());
>> +	}
>> +
>>   	if (!strcmp(subcmd, "start"))
>>   		return !!try_to_start_background_daemon();
>>   
>> diff --git a/builtin/update-index.c b/builtin/update-index.c
>> index d335f1ac72a..8f460e7195f 100644
>> --- a/builtin/update-index.c
>> +++ b/builtin/update-index.c
>> @@ -1237,6 +1237,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>>   
>>   	if (fsmonitor > 0) {
>>   		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
>> +
>> +		if (fsm_mode == FSMONITOR_MODE_INCOMPATIBLE) {
>> +			const char *msg = fsm_settings__get_reason_msg(r);
>> +
>> +			return error("%s '%s'", msg ? msg : "???", xgetcwd());
>> +		}
>> +
>>   		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
>>   			advise(_("core.fsmonitor is unset; "
>>   				 "set it if you really want to "
> 
> Can w assert somewhere earlier that ->mode can't be
> FSMONITOR_MODE_INCOMPATIBLE at the same time that ->reason ==
> FSMONITOR_REASON_OK, should that ever happen?
> 
> Then we can get rid of the "???" case here.
> 

Yeah, it would be nice to assert() the pair and simplify things.  I'll
make a note to look at that.


> The "%s '%s'" here should really be marked for translation, but just
> "some reason '$path'" is a pretty confusing message. This will emit
> e.g.:

I already have translations in the code that looks up the message,
so doing it here for a pair of %s's felt wrong.

> 
>      "bare repos are incompatible with fsmonitor '/some/path/to/repo'"
> 
> Since we always hand these to error maybe have the helper do e.g.:
> 
>      error(_("bare repository '%s' is incompatible with fsmonitor"), path);
> 

I'm wondering now if we should just drop the path from the message
and use the error message from __get_reason_msg() as is.  (It was
useful during debugging, but I could see it going away.)


> I find the second-guessing in fsmonitor-settings.c really hard to
> follow, i.e. how seemingly every function has some "not loaded yet? load
> it" instead of a more typical "init it", "use it", "free it"
> pattern. Including stuff like this:
> 	
> 	enum fsmonitor_mode fsm_settings__get_mode(struct repository *r)
> 	{
> 	        if (!r)
> 	                r = the_repository;
> 
> But anyway, seeing as we do try really hard to load the_repository (or a
> repository) can't we use the_repository->gitdir etc. here instead of
> xgetcwd(), or the_repository->worktree when non-bare?
> 

I'll take a look and see if I can simplify it.

Thanks
Jeff
