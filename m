Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D03C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E417D61073
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbhJHUia (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:38:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:50686 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242708AbhJHUi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:38:29 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 94EF13F410F;
        Fri,  8 Oct 2021 16:36:33 -0400 (EDT)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 61DBD3F4103;
        Fri,  8 Oct 2021 16:36:33 -0400 (EDT)
Subject: Re: [PATCH v2 3/5] fsmonitor: config settings are repository-specific
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.git.1631822063.gitgitgadget@gmail.com>
 <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
 <7d5a353e74d2f2a1ed3f9275425bb564265323d6.1633614772.git.gitgitgadget@gmail.com>
 <877deohiad.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <492b6dcb-dfae-f57b-6467-ba5a6808fc92@jeffhostetler.com>
Date:   Fri, 8 Oct 2021 16:36:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <877deohiad.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/7/21 12:59 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 07 2021, Jeff Hostetler via GitGitGadget wrote:
> 
> Good to see this move forward!
> 
> This bit:
> 
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -20,6 +20,8 @@ void prepare_repo_settings(struct repository *r)
>>   	if (r->settings.initialized++)
>>   		return;
>>   
>> +	r->settings.fsmonitor = NULL; /* lazy loaded */
>> +
>>   	/* Defaults */
>>   	r->settings.index_version = -1;
>>   	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
>> diff --git a/repository.h b/repository.h
> 
> Is carried forward from v1, but with 3050b6dfc75 (repo-settings.c:
> simplify the setup, 2021-09-21) isn't needed. It's init'd to 0/NULL
> already, but was -1 before.
> 
> So this hunk can go, and its presence makes for confusing reading
> without that history, is it set before somehow? No, just working around
> older code that's no longer there.

Um, yeah, if the structure is now zero-filled on init
rather than the weird -1, then we don't need this here.
I'll remove in my next version.  Thanks!


> 
> But also: For untracked_cache_setting and fetch_negotiation_setting
> we've got an embedded enum in the struct, but this...
> 
>> index a057653981c..89a1873ade7 100644
>> --- a/repository.h
>> +++ b/repository.h
>> @@ -4,6 +4,7 @@
>>   #include "path.h"
>>   
>>   struct config_set;
>> +struct fsmonitor_settings;
>>   struct git_hash_algo;
>>   struct index_state;
>>   struct lock_file;
>> @@ -34,6 +35,8 @@ struct repo_settings {
>>   	int command_requires_full_index;
>>   	int sparse_index;
>>   
>> +	struct fsmonitor_settings *fsmonitor; /* lazy loaded */
>> +
>>   	int index_version;
>>   	enum untracked_cache_setting core_untracked_cache;
>>   
> 
> Is a pointer to a struct that has an "enum fsmonitor_mode mode", and the
> code in fsmonitor-settings.c seems to be repeating the patterns we had
> in repo-settings.c pre-3050b6dfc75, e.g. checking whether a bool config
> variable exists *and* is true, v.s. checking if it exists (presumably an
> explicit false wants to override something).

My usage is a little more complicated because the historical value
had double duty.  And I only want to set the hook value when not
using the builtin and when the repo itself is compatible with being
monitored.  Later in the series we'll disallow remote worktrees,
for example.  I wanted to hide some of those details in my
fsmonitor-settings.c and keep them out of repo-settings.c.  And
to avoid paying for that when not needed, I made is a lazy-load
and hid the values behind an opaque type with access functions.


> 
> I haven't looked carefully, but between that & the "char *hook_path"
> being something that'll need to be made to use Emily's hook config
> series sooner than later, can't we read/setup the initial config in
> "repo_cfg_bool"?

It's been a while since I looked at Emily's series. I'll have to
revisit that later.  I do wonder if the existing fsmonitor hook
is in the same class as the other hooks or whether it is a one-off
and should be separate, but again I need to review that work first.

> 
> The relevant commit message just says:
> 
>      Move FSMonitor config settings to a new `struct fsmonitor_settings`
>      structure.  Add a lazily-loaded pointer to `struct repo_settings`.
>      Create `fsm_settings__get_*()` getters to lazily look up fsmonitor-
>      related config settings.[...]
> 
> Which I think can be paraphrased as "Add scaffolding to repo-settings.c
> but do config loading differently than everything there (lazily),
> because...", except the "because" is missing :)
> 

Let me reword the commit message and try to explain what I was
going for.  Thanks!

Jeff


