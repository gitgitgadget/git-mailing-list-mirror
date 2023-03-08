Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC21C742A7
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 19:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjCHTDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCHTDO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 14:03:14 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9241ACDA39
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 11:02:20 -0800 (PST)
Received: from [192.168.42.163] (28-49-142-46.pool.kielnet.net [46.142.49.28])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 69CD43C0623;
        Wed,  8 Mar 2023 20:02:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1678302138;
        bh=XIcukYE0gme+6LwJmlr8LreH28SSuvtkcMas63vUwR0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=oi95kdoraE4riS2K/RoSpR9dT+OG9Dr2UPx9jFMvGc0nIPqhCke8sfTovWViVq/fr
         tbq+MkTLLt8cbdPm4yVa+adJFdGwurm64Jc/a8PG691ivYayqwOYku7zsxmRaUN1oc
         Q8awyUq97x0nPh9R/DFxQC30nUru20SHH+nTw2aXsdv8hiPTW9YKSudpQHOiLYK8Oz
         OryJf9g5cDM756kn1l7VRHw/a3JfyHFFs//tRlNcPAQ7etlgeK89HOiO1DCkPFOZng
         01F2w5DqqPNHAB1JOKkQYrImKLyO7g50tbiJiuVMay2l93GUHBTlAyOsEAb7GtLcvH
         Dbv/Mnyfdbz3A==
Message-ID: <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
Date:   Wed, 8 Mar 2023 20:02:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
 <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.03.23 21:15, Phillip Wood wrote:
> Hi Stefan
> 
> On 05/03/2023 19:13, Stefan Haller wrote:
>> On 05.03.23 17:59, Stefan Haller wrote:
>>> On 05.03.23 15:31, Phillip Wood wrote:
>>>> Hi Stefan
>>>>
>>>> On 02/03/2023 20:27, Stefan Haller wrote:
>>>>> On 02.03.23 11:19, Phillip Wood wrote:
>>>>>> On 28/02/2023 12:55, Stefan Haller wrote:
>>>>>>> The reason why I am asking this is: I'm using lazygit, which, during
>>>>>>> interactive rebases, shows a combined view of the real commits that
>>>>>>> were
>>>>>>> already applied, and the remaining commits that are yet to be
>>>>>>> applied
>>>>>>> (it gets these by parsing rebase-merge/git-rebase-todo);
>>>>>>> something like
>>>>>>> this, when I set the 2nd commit to "edit":
>>>>>>>
>>>>>>>      pick   4th commit
>>>>>>>      pick   3rd commit
>>>>>>>             2nd commit  <-- YOU ARE HERE
>>>>>>>             1st commit
>>>>>>>
>>>>>>> This is great, but assuming that the 2nd commit conflicted,
>>>>>>> currently
>>>>>>> the display looks like this:
>>>>>>>
>>>>>>>      pick   4th commit
>>>>>>>      pick   3rd commit
>>>>>>>             1st commit  <-- YOU ARE HERE
>>>>>>>
>>>>>>> I would like to extend this to also show a "fake entry" for the
>>>>>>> commit
>>>>>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>>>>>> except that I need a way to distinguish whether it was applied
>>>>>>> already
>>>>>>> or not.
>>>>>>
>>>>>> Can you check the index for conflicts when the rebase stops?
>>>>>
>>>>> I could do that, but then the fake entry would go away as soon as I
>>>>> have
>>>>> staged all conflict resolutions. I would find it useful for it to stay
>>>>> visible in that case, until I continue the rebase.
>>>>
>>>> I've not used lazygit but looking at the github page it seems that
>>>> it is
>>>> a persistent process that runs "git rebase". If that's the case I would
>>>> think that you can check for conflicts when the rebase stops and keep
>>>> that value in memory until the rebase is started again.
>>>
>>> I had considered that, but it would be preferable if it were possible to
>>> quit lazygit, start it again, and have it show the same state again. Or
>>> even start the rebase outside of lazygit while it isn't running at all,
>>> and then start it and have it display the correct state.
>>>
>>>> I think your best bet might be to read "$(git rev-parse --git-path
>>>> rebase-merge/done)" the last line of which contains the last todo
>>>> command the rebase tried to execute.
>>>
>>> I'm not sure I understand; you mean in order to distinguish whether it
>>> was a pick or a fixup?
>>
>> OK, I guess it's something like
>>
>> show_fake_entry :=
>>    REBASE_HEAD exists
>>    && (last command in "done" file was not "edit"
>>        || "amend" file exists)
>>
>> Is that what you meant? (Minus the bit about rescheduling failed
>> commands, which I still need to wrap my head around...)
> 
> I meant you could just use the done file to get the last command, there
> is no need to look at REBASE_HEAD.

OK, I see. Sounds like a possible algorithm could be:

func commitNameToShowAsTheCurrentlyConflictingCommit() {
    lastDone := last command of "done" file
    if lastDone.command is "break" or "exec" {
        return nil
    }

    next := first command of "git-rebase-todo" file
    if lastDone == next {
        // Command was rescheduled and shows in remaining todos already
        return nil
    }

    if lastDone.command is "edit" {
        if "amend" file exists {
            // "edit" command was successful
            return nil
        }
    }

    return lastDone.commitName
}

Does this sound reasonable?

-Stefan
