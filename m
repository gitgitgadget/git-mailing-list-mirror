Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA22BC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE1360F9B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 19:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhJ0Tze (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 15:55:34 -0400
Received: from siwi.pair.com ([209.68.5.199]:51737 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240410AbhJ0Tzd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 15:55:33 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BDBD23F40E6;
        Wed, 27 Oct 2021 15:53:07 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8E63A3F4090;
        Wed, 27 Oct 2021 15:53:07 -0400 (EDT)
Subject: Re: [PATCH v4 03/29] fsmonitor: config settings are
 repository-specific
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
 <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <882789b4dfebddb059f62b0b2edb95b92f3c69ee.1634826309.git.gitgitgadget@gmail.com>
 <xmqqlf2mjdgf.fsf@gitster.g> <xmqqh7dajcxr.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <74282d08-aaeb-0a1e-cad3-1de17d59b4d1@jeffhostetler.com>
Date:   Wed, 27 Oct 2021 15:53:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7dajcxr.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/21/21 5:16 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> +enum fsmonitor_mode {
>>> +	FSMONITOR_MODE_DISABLED = 0,
>>> +	FSMONITOR_MODE_HOOK = 1, /* core.fsmonitor */
>>> +	FSMONITOR_MODE_IPC = 2,  /* core.useBuiltinFSMonitor */
>>> +};
>>
>> Please remind me why we need a new separate variable, instead of
>> turning the core.fsmonitor variable into an extended bool <false,
>> true, builtin>?
> 
> Ah, I see.
> 
> The vocabulary of the value for the existing variable is between
> "unset means disabled" and "the path-to-hook means enabled", so
> unless we forbid a bareword path "builtin" (which I do not think is
> such a bad idea, by the way), it becomes a bit fuzzy what a
> non-empty token means.
> 
> In any case, the "set to path to enable, leave unset to leave
> disabled" is a cumbersome to use and may want to be rethought.  It
> is unclear how one would override a configured path-to-hook, for
> example.
> 
> Considering that we need to reserve a special word, say, "disabled",
> that has to be distinguishable from a normal "here is a path to the
> hook script" ANYWAY, in order to allow such a "last one wins"
> configuration override (or "git -c core.fsmonitor=disabled cmd"), it
> starts to sound more and more reasonable to reserve yet another word
> "builtin" as a special value of core.fsmonitor, without having to
> introduce a new configuration variable, no?
> 

For a while we were using a ":builtin:" reserved value (which isn't
a valid pathname on Windows) but thought it better to split it into
two different config values to avoid the confusion (since it is a
valid path on Mac/Linux).  But having 2 config vars is also confusing.

And yes, I'm not sure there is a way for a local fsmonitor hook
config to override a global hook value unless we add a "disabled"
or "off" value.

Let me revisit this.  We could have:

     [] unset, <any of the standard boolean false values>, "disabled"
     [] <hook-path>
     [] "builtin", "ipc"

and just make the literals special reserved values.


I've not kept up on the configurable hooks series, but I have to
wonder if this usage (pathname or reserved word) will cause problems
with the changes being planned for hooks.  The existing fsmonitor
usage doesn't use find_hook() nor run_hook*(), so I don't expect
an immediate conflict.  But again, I haven't kept up with that
effort.

Jeff
