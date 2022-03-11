Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8CCC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 14:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349058AbiCKOJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 09:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243047AbiCKOI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 09:08:58 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D1E29CBA
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 06:07:51 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 72AA33F4807;
        Fri, 11 Mar 2022 09:07:50 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E74823F47F8;
        Fri, 11 Mar 2022 09:07:49 -0500 (EST)
Subject: Re: [PATCH v6 03/30] fsmonitor: config settings are
 repository-specific
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <ae622a517cf500d5b068871434e33f98e9cf586b.1646160212.git.gitgitgadget@gmail.com>
 <220311.86fsnpi73l.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <dd9a1847-7163-49e6-4a8b-bc5c8c381f0d@jeffhostetler.com>
Date:   Fri, 11 Mar 2022 09:07:47 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220311.86fsnpi73l.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/10/22 8:47 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 01 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> I know this is in "next", just looking over this code again...
> 
>> +static void lookup_fsmonitor_settings(struct repository *r)
> 
> Here we'll start loading the settings...
> 
>> +{
>> +	struct fsmonitor_settings *s;
>> +	const char *const_str;
>> +	int bool_value;
>> +
>> +	if (r->settings.fsmonitor)
>> +		return;
> 
> MARK
> 
>> +	CALLOC_ARRAY(s, 1);
>> +
>> +	r->settings.fsmonitor = s;
> 
> And right after we alloc the r->settings.fsmonitor we'll ...
> 
>> +	fsm_settings__set_disabled(r);
> 
> ...call this method...
>> +
>> +	/*
>> +	 * Overload the existing "core.fsmonitor" config setting (which
>> +	 * has historically been either unset or a hook pathname) to
>> +	 * now allow a boolean value to enable the builtin FSMonitor
>> +	 * or to turn everything off.  (This does imply that you can't
>> +	 * use a hook script named "true" or "false", but that's OK.)
>> +	 */
>> +	switch (repo_config_get_maybe_bool(r, "core.fsmonitor", &bool_value)) {
>> +
>> +	case 0: /* config value was set to <bool> */
>> +		if (bool_value)
>> +			fsm_settings__set_ipc(r);
>> +		return;
>> +
>> +	case 1: /* config value was unset */
>> +		const_str = getenv("GIT_TEST_FSMONITOR");
>> +		break;
>> +
>> +	case -1: /* config value set to an arbitrary string */
>> +		if (repo_config_get_pathname(r, "core.fsmonitor", &const_str))
>> +			return; /* should not happen */
>> +		break;
>> +
>> +	default: /* should not happen */
>> +		return;
>> +	}
>> +
>> +	if (!const_str || !*const_str)
>> +		return;
>> +
>> +	fsm_settings__set_hook(r, const_str);
>> +}
>> [...]
>> +void fsm_settings__set_disabled(struct repository *r)
>> +{
>> +	if (!r)
>> +		r = the_repository;
>> +
>> +	lookup_fsmonitor_settings(r);
> 
> ...which here will recurse into lookup_fsmonitor_settings and hit
> "MARK".
> 
> So isn't that fsm_settings__set_disabled() within that method pointless?

Yeah, that got rolled up in one too many rebase/refactorings...
I'll simplify.

thanks
jeff

> 
>> +	r->settings.fsmonitor->mode = FSMONITOR_MODE_DISABLED;
>> +	FREE_AND_NULL(r->settings.fsmonitor->hook_path);
> 
> It seems as though the intent was to reach this, but these all happen to
> be the same thing you'd get with CALLOC_ARRAY(), so I think this just
> happened to work out...
> 
>> +enum fsmonitor_mode {
>> +	FSMONITOR_MODE_DISABLED = 0,
> 
> ...I.e. this is luckily zero.
> 
