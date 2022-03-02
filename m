Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FE7C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245033AbiCBVKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245054AbiCBVKP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:10:15 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BCFA94E2
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:09:31 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D5FDB3F47F5;
        Wed,  2 Mar 2022 16:09:30 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9A0673F40F4;
        Wed,  2 Mar 2022 16:09:30 -0500 (EST)
Subject: Re: [PATCH 05/23] fsmonitor-settings: bare repos are incompatible
 with FSMonitor
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <44cc61e186cb65fa6b2c1d5a0f080fc0b2265e57.1644940773.git.gitgitgadget@gmail.com>
 <220225.86ee3q7k2s.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1fe07a1b-df7f-5230-5f49-4cb454c3df9f@jeffhostetler.com>
Date:   Wed, 2 Mar 2022 16:09:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220225.86ee3q7k2s.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/25/22 3:42 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Feb 15 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> +static void create_reason_message(struct repository *r,
>> +				  struct strbuf *buf_reason)
>> +{
>> +	struct fsmonitor_settings *s = r->settings.fsmonitor;
>> +
>> +	switch (s->reason) {
>> +	case FSMONITOR_REASON_ZERO:
>> +		return;
>> +
>> +	case FSMONITOR_REASON_BARE:
>> +		strbuf_addstr(buf_reason,
>> +			      _("bare repos are incompatible with fsmonitor"));
>> +		return;
>> +
>> +	default:
>> +		BUG("Unhandled case in create_reason_message '%d'", s->reason);
>> +	}
>> +}
>> +
>> +enum fsmonitor_reason fsm_settings__get_reason(struct repository *r,
>> +					       struct strbuf *buf_reason)
>> +{
>> +	lookup_fsmonitor_settings(r);
>> +
>> +	strbuf_reset(buf_reason);
>> +	if (r->settings.fsmonitor->mode == FSMONITOR_MODE_INCOMPATIBLE)
>> +		create_reason_message(r, buf_reason);
>> +
>> +	return r->settings.fsmonitor->reason;
>> +}
> 
> This API (just looking at one small bit discussed because related bits
> conflict with another series) seems to require a lot of ceremony just to
> get a const char * error.

My thought at the time was that the __get_reason() code might want to
format a message and include details from the repo (such as the working
directory root) or the kind of objection (such as a remote SMB mount).
So I had it take a strbuf rather than a "const char *" return value.

But so far (in the successive commits) all of the reason messages have
been constant and I think I'm OK with having the non-specific messages.

So yes, I could simplify it.

Thanks
Jeff

