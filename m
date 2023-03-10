Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CD8C6FD1C
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCJRtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 12:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjCJRti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 12:49:38 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254FB2118
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 09:49:14 -0800 (PST)
Received: from [192.168.42.163] (47-99-142-46.pool.kielnet.net [46.142.99.47])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 382713C01C6;
        Fri, 10 Mar 2023 18:42:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1678470124;
        bh=P7j2bP1/atARUPIQMSVzDkNE7IuxV2SEUBgrBQvVuAg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YYem4ctga3rn7sSVXKLxLiwSGZpHX3n4jtfyY3THTTx8JGdgTS88NNu7LR3aAyWMq
         q4Yws9gNk477nwuy3sZksjwIWtWZ6k1Ake5qL/CjCywNJ0xnP1xGvCCjsqJnLUEOnG
         GzmNJtABlBUVW+IE+r3m0fgkNqfz2BZeWeS246R53Tfw9/0PsLcEZqwmXhze5ZoITK
         m33NDWzdVxHAtqljyKyVMJGqDKVkNN4RxK9cBO4qtCvhFqwINwp3TEkOrOPm4xJyVR
         x4+dCMFFGWJEGrovkK6t/U6zZDWLjEFCVIGiqFNrvNYZ7/FCAXtbG+CNa0EB3NKq7o
         +2MC0Bwg8J5sQ==
Message-ID: <805626af-b147-d3cf-5257-a5b90b7cf1d9@haller-berlin.de>
Date:   Fri, 10 Mar 2023 18:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
 <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
 <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
 <722659e9-02ac-a9d2-b0fd-b9a2a3d85753@dunelm.org.uk>
Content-Language: de-DE, en-US
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <722659e9-02ac-a9d2-b0fd-b9a2a3d85753@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.03.23 10:56, Phillip Wood wrote:
> Hi Stefan
> 
> On 08/03/2023 19:02, Stefan Haller wrote:
>> On 05.03.23 21:15, Phillip Wood wrote:
>>> Hi Stefan
>>>
>>> On 05/03/2023 19:13, Stefan Haller wrote:
>>>> On 05.03.23 17:59, Stefan Haller wrote:
>>>>> On 05.03.23 15:31, Phillip Wood wrote:
>>>>>> Hi Stefan
>>>>>>
>>>>>> On 02/03/2023 20:27, Stefan Haller wrote:
>>>>>>> On 02.03.23 11:19, Phillip Wood wrote:
>>>>>>>> On 28/02/2023 12:55, Stefan Haller wrote:
>>>>>>>>> The reason why I am asking this is: I'm using lazygit, which,
>>>>>>>>> during
>>>>>>>>> interactive rebases, shows a combined view of the real commits
>>>>>>>>> that
>>>>>>>>> were
>>>>>>>>> already applied, and the remaining commits that are yet to be
>>>>>>>>> applied
>>>>>>>>> (it gets these by parsing rebase-merge/git-rebase-todo);
>>>>>>>>> something like
>>>>>>>>> this, when I set the 2nd commit to "edit":
>>>>>>>>>
>>>>>>>>>       pick   4th commit
>>>>>>>>>       pick   3rd commit
>>>>>>>>>              2nd commit  <-- YOU ARE HERE
>>>>>>>>>              1st commit
>>>>>>>>>
>>>>>>>>> This is great, but assuming that the 2nd commit conflicted,
>>>>>>>>> currently
>>>>>>>>> the display looks like this:
>>>>>>>>>
>>>>>>>>>       pick   4th commit
>>>>>>>>>       pick   3rd commit
>>>>>>>>>              1st commit  <-- YOU ARE HERE
>>>>>>>>>
>>>>>>>>> I would like to extend this to also show a "fake entry" for the
>>>>>>>>> commit
>>>>>>>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>>>>>>>> except that I need a way to distinguish whether it was applied
>>>>>>>>> already
>>>>>>>>> or not.
>> OK, I see. Sounds like a possible algorithm could be:
>>
>> func commitNameToShowAsTheCurrentlyConflictingCommit() {
> 
> Going back to your original email, if all you want to do is show "YOU
> ARE HERE" against the correct commit then you can get that from the last
> entry in the "done" file irrespective of whether there were conflicts or
> not. If you also want to show whether it was picked cleanly or not then
> it is more complicated.

In my first example above, I'm editing the 2nd commit and it applied
cleanly. What I see in that case is

pick   4th commit
pick   3rd commit
       2nd commit  <-- YOU ARE HERE
       1st commit

2nd commit is the current HEAD, which corresponds to the last entry in
the "done" file, so there's no reason to display the "done" file entry
too in this case.

Only if it wasn't applied cleanly (and wasn't rescheduled) do I want to
show the "done" entry. This way I always see four entries in my list, no
matter what happened (unless I drop commits, of course), which is what I
want.

>>      lastDone := last command of "done" file
>>      if lastDone.command is "break" or "exec" {
>>          return nil
>>      }
>>
>>      next := first command of "git-rebase-todo" file
>>      if lastDone == next {
>>          // Command was rescheduled and shows in remaining todos already
>>          return nil
>>      }
> 
> I don't know what your current implementation looks like but if I was
> starting from scratch I think it would be simpler to always use the last
> command from "done" and then suppress the first command from
> "git-rebase-todo" if it is the same.

That would also be possible, but in lazygit it makes things harder,
because items from "git-rebase-todo" can be interacted with (e.g. moved
up or down, or dropped), whereas the "done" entry is only for display
purposes and can't be interacted with. That's why I called it a "fake"
entry above.

I tried the algorithm now and seems to do exactly what I want, so thanks
for the help with this, I'm happy now.

There's a slight correction though: if a command is rescheduled, then
git appears to re-append the last successful command to the end of the
"done" file (it's in there twice now). So I have to check the
second-to-last command of "done" against the first command of
"git-rebase-todo" to find out if a command was rescheduled.

-Stefan
