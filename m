Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D8CC4332F
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbiBWRpG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbiBWRpF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:45:05 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960D141331
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:44:36 -0800 (PST)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nMvgo-0009aC-Ab;
        Wed, 23 Feb 2022 17:44:34 +0000
Message-ID: <7cb42ab5-92c5-0a48-ffba-4f6b55ef130c@iee.email>
Date:   Wed, 23 Feb 2022 17:44:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] rebase: help user when dying with preserve-merges`
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1155.git.1645526016.gitgitgadget@gmail.com>
 <cd06aa68c2fc65551cd810a1c2c0941c51433163.1645526016.git.gitgitgadget@gmail.com>
 <220222.86czje7w4i.gmgdl@evledraar.gmail.com>
 <c04eba64-0357-cfdd-2ffe-3905ce4f4cb9@iee.email>
 <220223.86r17t6fvf.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <220223.86r17t6fvf.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/02/2022 10:20, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Feb 22 2022, Philip Oakley wrote:
>
>> On 22/02/2022 15:32, Ævar Arnfjörð Bjarmason wrote:
>>> On Tue, Feb 22 2022, Philip Oakley via GitGitGadget wrote:
>>>
>>>> From: Philip Oakley <philipoakley@iee.email>
>>>>
>>>> Git will die if a "rebase --preserve-merges" is in progress.
>>>> Users cannot --quit, --abort or --continue the rebase.
>>>>
>>>> This sceario can occur if the user updates their Git, or switches
>>>> to another newer version, after starting a preserve-merges rebase,
>>>> commonly via the pull setting.
>>>>
>>>> One trigger is an unexpectedly difficult to resolve conflict, as
>>>> reported on the `git-users` group.
>>>> (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
>>>>
>>>> Tell the user the cause, i.e. the existence of the directory.
>>>> The problem must be resolved manually, `git rebase --<option>`
>>>> commands will die, or the user must downgrade. Also, note that
>>>> the deleted options are no longer shown in the documentation.
>>> I can go and read the linked thread for the answer, but:
>>>
>>>>  		if (is_directory(buf.buf)) {
>>>> -			die("`rebase -p` is no longer supported");
>>>> +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
>>>> +			"You still have a `.git/rebase-merge/rewritten` directory, \n"
>>>> +			"indicating a `rebase preserve-merge` is still in progress.\n");
>>>>  		} else {
>>>>  			strbuf_reset(&buf);
>>>>  			strbuf_addf(&buf, "%s/interactive", merge_dir());
>>> As much of an improvement this is, I'd be no closer to knowing what I
>>> should do at this point.
>>>
>>> Should I "rm -rf" that directory, downgrade my version of git if I'd
>>> like to recover my work (as the message alludes to).
>>>
>>> In either case I'd think that this is getting a bit past the length
>>> where we'd have just a die() v.s. splitting it into a die()/advise()
>>> pair. I.e. to have the advise() carry some bullet-point list about X/Y/Z
>>> solutions, with the die() being a brief ~"we did because xyz dir is
>>> still here".
>>>
>>>
>> Hi Ævar,
>>
>> Exactly. This is a slightly special, but real, case. The previous
>> message was essentially totally opaque to users. An "If I were you I
>> wouldn't start from here" response is somewhat true, so we simply tell
>> the user how they got to receive the fatal message. They can then take
>> any of the options they choose.
>>
>> Ultimately the user downgraded and managed to use "rebase --continue",
>> as advised by Git, without the response "fatal:" to complete their old
>> preserve-merges rebase.
> Right. I'm pointing out that in this proposed version of the die()
> message we stop just short of actually telling the user how to proceed.
>
> I.e. just that they have a X directory, not that they should either
> remove X and lose their work, or downgrade git, proceed, and then
> upgrade git.
In a sense, that is it. They are in a difficult place, but with at least
a little information to seek further information and start making their
choices. Before, they (users in difficulty) were rather uninformed.
>> They'll hit a similar fault in short order because when they next `pull`
>> they'll be slipped into trying the preserve-merge rebase again - that's
>> the 2/2 patch, making sure they know why.
> Well, this is "rebase". You can have been running rebases in a
> repository without ever having any interactions with remotes.
True. That is a possibility. But we have also removed the preserve
option for interaction with remotes as well.
>
> And even if you had interactions with remotes you might be doing so via
> "git fetch" followed by "git rebase", and might not ever invoke "git
> pull".
>
> And even if you did a "git pull" later shouldn't the error you got here
> be sufficiently stand-alone as to tell you what to do, without needing a
> later "pull"?
Why are we delaying telling the user that they would have problems there
as well? It shouldn't be a game about how many ways we can trip up the user.

It's a pity the problem has split into the different ways into disaster.

