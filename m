Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AB3E20248
	for <e@80x24.org>; Fri, 22 Mar 2019 15:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfCVPVW (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 11:21:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:54959 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfCVPVV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 11:21:21 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B15ED3F4024;
        Fri, 22 Mar 2019 11:21:20 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 83EB93F4013;
        Fri, 22 Mar 2019 11:21:20 -0400 (EDT)
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
 <pull.108.v6.git.gitgitgadget@gmail.com> <87a7iyk0r8.fsf@evledraar.gmail.com>
 <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com>
 <87k1gxa8cm.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1903211528090.41@tvgsbejvaqbjf.bet>
 <87mulocmgz.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1903221416230.41@tvgsbejvaqbjf.bet>
 <37cffd65-58bd-3fae-a4f1-44038ed52f60@jeffhostetler.com>
 <87h8bvc65j.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4c5cef43-2f35-124a-b88c-397866b6111f@jeffhostetler.com>
Date:   Fri, 22 Mar 2019 11:21:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <87h8bvc65j.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/2019 10:53 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 22 2019, Jeff Hostetler wrote:
> 
>> On 3/22/2019 9:17 AM, Johannes Schindelin wrote:
>>> Hi Ævar,
>>>
>>> On Thu, 21 Mar 2019, Ævar Arnfjörð Bjarmason wrote:
>>>
>>>> On Thu, Mar 21 2019, Johannes Schindelin wrote:
>>>>
>>>>> On Sun, 17 Mar 2019, Ævar Arnfjörð Bjarmason wrote:
>>>>>
>>>>>>
>>>>>> On Fri, Feb 15 2019, Jeff Hostetler wrote:
>>>>>>
>>>>>>> I could see having a "~/.git_tr2_config" or something similar in
>>>>>>> some place like "/etc" that only contained the Trace2 settings. It
>>>>>>> would be safe to read very early inside main() and we would not
>>>>>>> consider it to be part of the real config.  For example, "git
>>>>>>> config" would not know about it.  Then you could enforce a
>>>>>>> system-wide setting without any of the env var issues.
>>>>>>
>>>>>> I haven't written a patch for this, but it seems to me that we could
>>>>>> just start reading /etc/gitconfig via some custom config callback
>>>>>> code early as e.g. 58b284a2e91 ("worktree: add per-worktree config
>>>>>> files", 2018-10-21) does for the worktree config.
>>>>>
>>>>> Oy. Oy, oy, oy.
>>>>>
>>>>> Maybe use `read_early_config()` instead? That would be *a lot*
>>>>> cleaner. You could maybe use a9bcf6586d1a (alias: use the early config
>>>>> machinery to expand aliases, 2017-06-14) as an inspiration.
>>>>
>>>> Thanks. I was thinking *only* to do /etc/gitconfig and not the whole
>>>> .git/config -> ~/.gitconfig etc. sequence just in terms of saving
>>>> critical time (this is the performance trace path, after all...).
>>>>
>>>> But on a second reading I see that read_early_config() can do that if
>>>> you set config_source->file, opts->respect_includes etc. I.e. it just
>>>> (depending on options) resolves to git_config_from_file() which
>>>> 58b284a2e91 used directly.
>>>
>>> Sure, it can exclude the repo and user config, but would that not be
>>> rather confusing?
>>
>> This was hidden in my earlier message.
>>
>> There's a lot a config machinery here with lots of chicken-n-egg
>> problems.  I want to know at the top of main() as quickly as possible
>> whether trace2 should be enabled.
>>
>> I don't want to slow down git by spinning up a bunch of trace2 state
>> and wait until the git-dir is discovered, the "-c" args are processed,
>> and we dispatch into the builtin layer and the config is enumerated
>> to know if it should really be on or not.
>>
>> I also didn't want to introduce another full iteration of the full
>> config system for startup performance reasons.
>>
>> I played with read_early_config() at one point and it always seemed
>> to introduce side-effects.  Perhaps I was calling it earlier than it
>> was expecting and that triggered some of the git-dir discovery or
>> something. I don't remember all the details, I just remember that it
>> changed some behaviors in subtle ways.
>>
>> Perhaps I could call something like git_config_from_file() with the
>> right set of magic bits to get it to parse exactly 1 system config
>> file that would contain my trace2 settings.  Hopefully, this will
>> not have any side-effects.
> 
> Right, it also occurred to me that e.g. /home tends to be on NFS on some
> systems, but very rarely /etc. I'd hate for trace reporting for git to
> stall because NFS slows to a halt, so aside from temporary
> implementation details (e.g. -c on the CLI not working) there's a good
> case to be made for "read this from /etc/gitconfig only".
> 
>> But if we lump them in with the main /etc/gitconfig settings, we
>> would have to explain that these trace2 config settings are
>> system-only and ARE NOT overridden by "-c", global, local, ...
>> config settings.  This would get confusing if the user tried to
>> set local values and did:
>> 	git config --list --show-origin
>> and it showed system and local values but yet "stubbornly" refused
>> to use the local values over the system values. (I think this was
>> Johannes' point.)
>>
>> That's why I was suggesting a system trace2 config file that is a
>> peer of /etc/gitconfig (maybe /etc/gittrace2) that would have these
>> values and not be expected to interact with the main config system.
>> That is, we just use the git_config_ routines to parse the file format,
>> rather than inventing another file format, but not change the
>> expectation of the established config value inheritance system.
>>
>> If there's no objections, I'll take a look at doing this.
> 
> I'd much rather just drop it in /etc/gitconfig with documented caveats
> than introduce a new and permanent thing like /etc/gittrace2 due to a
> current implementation detail.
> 
> Unlike something in core.* or whatever this facility is specialized
> enough that I think it's fine to make it a bit of a special snowflake
> given what it does and the target audience.
> 
> But even with those caveats it's still useful to see it in 'git config
> -l --show-origin' for inspecting, and e.g. have it just work out of the
> box with say the default puppetry for the likes of GitLab that now knows
> how to set stuff in its /etc/gitconfig, but would need a special case
> just for this.
> 

ok, if we're comfortable with those caveats, i'll proceed as
you suggested. thanks for the quick response.

Jeff
