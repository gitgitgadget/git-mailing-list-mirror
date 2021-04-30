Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D256C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517FB61040
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 14:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhD3OY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 10:24:27 -0400
Received: from siwi.pair.com ([209.68.5.199]:14273 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233309AbhD3OY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 10:24:26 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3AB483F412A;
        Fri, 30 Apr 2021 10:23:37 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 09A2E3F4119;
        Fri, 30 Apr 2021 10:23:37 -0400 (EDT)
Subject: Re: [PATCH 04/23] fsmonitor: introduce `core.useBuiltinFSMonitor` to
 call the daemon via IPC
To:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <7082528d8f7c1afa33e1146e3d274e044735f6a1.1617291666.git.gitgitgadget@gmail.com>
 <f77457d0-925d-2ea1-4ad4-b3315532b37f@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4552971c-0a23-c19a-6a23-cb5737e43b2a@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 10:23:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f77457d0-925d-2ea1-4ad4-b3315532b37f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 10:56 AM, Derrick Stolee wrote:
> On 4/1/21 11:40 AM, Johannes Schindelin via GitGitGadget wrote:> @@ -2515,6 +2515,11 @@ int git_config_get_max_percent_split_change(void)
>>   
>>   int repo_config_get_fsmonitor(struct repository *r)
>>   {
>> +	if (r->settings.use_builtin_fsmonitor > 0) {
> 
> Don't forget to run prepare_repo_settings(r) first.
> 
>> +		core_fsmonitor = "(built-in daemon)";
>> +		return 1;
>> +	}
>> +
> 
> I found this odd, assigning a string to core_fsmonitor that
> would definitely cause a problem trying to execute it as a
> hook. I wondered the need for it at all, but found that
> there are several places in the FS Monitor subsystem that use
> core_fsmonitor as if it was a boolean, indicating whether or
> not the feature is enabled at all.
> 
> A cleaner way to handle this would be to hide the data behind
> a helper method, say "fsmonitor_enabled()" that could then
> check a value on the repository (or index) and store the hook
> value as a separate value that is only used by the hook-based
> implementation.
> 
> It's probably a good idea to do that cleanup now, before we
> find on accident that we missed a gap and start trying to run
> this bogus string as a hook invocation.

Good point.  In an earlier draft we were using that known
string as a bogus hook path to indicate that we should
call the IPC routines rather than the hook API.  But then
we added the `core.useBuiltinFSMonitor` boolean and had it
override all of the existing fsmonitor config settings.
So we don't technically need it to have a value now and can
and should stop using the pointer as a boolean.

Thanks!

>> -static int query_fsmonitor(int version, const char *last_update, struct strbuf *query_result)
>> +static int query_fsmonitor(int version, struct index_state *istate, struct strbuf *query_result)
>>   {
>> +	struct repository *r = istate->repo ? istate->repo : the_repository;
>> +	const char *last_update = istate->fsmonitor_last_update;
>>   	struct child_process cp = CHILD_PROCESS_INIT;
>>   	int result;
>>   
>>   	if (!core_fsmonitor)
>>   		return -1;
> 
> Here is an example of it being used as a boolean.
> 
>> +	if (r->settings.use_builtin_fsmonitor > 0) {
>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +		return fsmonitor_ipc__send_query(last_update, query_result);
>> +#else
>> +		/* Fake a trivial response. */
>> +		warning(_("fsmonitor--daemon unavailable; falling back"));
>> +		strbuf_add(query_result, "/", 2);
>> +		return 0;
>> +#endif
> 
> This seems like a case where the helper fsmonitor_ipc__is_supported()
> could be used instead of compile-time macros.
> 
> (I think this is especially true when we consider the future of the
> feature on Linux and the possibility of the same compiled code needing
> to check run-time properties of the platform for compatibility.)

Yes.

>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -58,6 +58,9 @@ void prepare_repo_settings(struct repository *r)
>>   		r->settings.core_multi_pack_index = value;
>>   	UPDATE_DEFAULT_BOOL(r->settings.core_multi_pack_index, 1);
>>   
>> +	if (!repo_config_get_bool(r, "core.usebuiltinfsmonitor", &value) && value)
>> +		r->settings.use_builtin_fsmonitor = 1;
>> +
> 
> Follows the patterns of repo settings. Good.
> 

I'm going to ignore all of the thread responses to this patch
dealing with how we acquire config settings and macros and etc.
Those issues are completely independent of FSMonitor (which is
already way too big).

Jeff

