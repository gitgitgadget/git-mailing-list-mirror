Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA5C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbjHXQqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbjHXQq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 12:46:27 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0401BFE
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 09:46:18 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4938723EDB;
        Thu, 24 Aug 2023 12:46:16 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qZDTM-PGm-00; Thu, 24 Aug 2023 18:46:16 +0200
Date:   Thu, 24 Aug 2023 18:46:16 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] rebase: improve resumption from incorrect initial
 todo list
Message-ID: <ZOeJWODUB4QeLaNP@ugly>
References: <20230323162235.995574-1-oswald.buddenhagen@gmx.de>
 <20230323162235.995574-9-oswald.buddenhagen@gmx.de>
 <8a188876-c456-7269-28de-9ff406204030@dunelm.org.uk>
 <ZElEis+PLDYR+Jvr@ugly>
 <08c4c313-35c8-63e9-7d66-a35b24a449dd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08c4c313-35c8-63e9-7d66-a35b24a449dd@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 01:13:28PM +0100, Phillip Wood wrote:
>On 26/04/2023 16:34, Oswald Buddenhagen wrote:
>> the failed state is identical to the "still editing the initial todo" 
>> state as far as "git status" and the shell prompt are concerned. this 
>> seems reasonable. i'll add it to the commit message.
>
>When you do that please mention what "git status" and the shell prompt 
>actually print in this case.
>
i'll go with "This seems reasonable, irrespective of the actual 
presentation (which could be improved)".

>Ideally "git status" should mention that the todo list needs to be 
>edited if there are still errors in it, though it would not surprise me 
>if it is not that helpful at the moment.
>
that would require actually validating the todo instead of just printing 
it. or maybe the presence of the backup file could be used to make 
reliable inferences. have fun! ;)

>>>  - Previously if the user created a commit before running "rebase
>>>    --continue" we'd rebase on to that commit. Now that commit will be
>>>    silently dropped.
>>>
>> this is arguably a problem, but not much different from the pre-existing 
>> behavior of changes to HEAD done during the initial todo edit being lost.
>
>I think there is a significant difference in that we're moving from a 
>situation where we lose commits that are created while rebase is running 
>to one where we're losing commits created while rebase is stopped. If a 
>user tries to create a commit while rebase is running then they're 
>asking for trouble. I don't think creating commits when rebase is 
>stopped is unreasonable in the same way.
>
i think that this is a completely meaningless distinction. a rebase is 
"running" while the state directory exists. having multiple terminals 
open is the norm, and when havoc ensues it doesn't matter to the user 
whether one of the terminals had an editor launched by git open at the 
time.

>> to avoid that, we'd need to lock HEAD while editing the todo. is that 
>> realistic at all?
>
>I don't think it is practical to lock HEAD while git is not running.
>
what measure of "practical" are you applying?
i'm assuming that no persistent locking infra exists currently. but i 
don't see a reason why it _couldn't_ - having some functions to populate 
and query .git/locked-refs/** in the right places doesn't seem like a 
fundamentally hard problem.

>We could just check HEAD has not changed when the rebase continues 
>after the user has fixed the todo list as you suggest below.
>
that's a good safeguard which i intend to implement, but when it 
triggers, the user will have to deal with the conflict. it would be much 
nicer to avoid it in the first place.

>> on top of that, i should verify HEAD against orig-head in 
>> start_rebase(). though the only way for the user to get out of that 
>> situation is saving the todo contents and --abort'ing (and we must 
>> take care not the touch HEAD).
>
>I think in that case it wouldn't be terrible to lose the edited todo 
>list as it is a bit of a corner case.
>
actually, yes, it would be. that's why i posted a patch that avoids it.

>> this is somewhat similar to the abysmal situation of the final 
>> update-ref failing if the target ref has been modified while being 
>> rebased. we'd need to lock that ref for the entire duration of the 
>> rebase to avoid that.
>
>"abysmal" is rather harsh - it would also be bad to overwrite the ref in 
>that case. I think it in relatively hard to get into that situation 
>though as "git checkout" wont checkout a branch that is being updated by 
>a rebase.
>
i have no clue how it happened (certainly something to do with many open 
terminals), but i actually got into that situation shortly before 
writing that mail, and i assure you that "abysmal" is absolutely not an 
overstatement. i mean, what do you expect a user to think when presented 
with two diverging heads when trying to finish a rebase?

>>>  - Previously if the user checkout out another commit before running
>>>    "rebase --continue" we'd rebase on to that commit. Now we we rebase
>>>    on to the original "onto" commit.
>>>
>> this can be subsumed into the above case.
>
>Meaning check and error out if HEAD has changed?
>
yes

>>> > This makes aborting cheaper and will simplify
>>> > things in a later change.
>>>
>>> Given that we're stopping so the user can fix the problem and continue 
>>> the rebase I don't think optimizing for aborting is a convincing 
>>> reason for this change on its own.
>>>
>> this is all part of the "More or less as a side effect" paragraph, so 
>> this isn't a relevant objection.
>
>I'm simply saying that we should not be optimizing for "rebase --abort" 
>in this case. Do you think we should?
>
you're missing the point. the optimization isn't something anyone aimed 
for.

regards
