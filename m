Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70AAC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 12:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiJSMqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 08:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiJSMpz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 08:45:55 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88852A8CD9
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 05:28:47 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ol8AH-0007rS-Ez;
        Wed, 19 Oct 2022 13:27:18 +0100
Message-ID: <53a8b40f-1740-581f-e2df-709b13046ffc@iee.email>
Date:   Wed, 19 Oct 2022 13:27:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
From:   Philip Oakley <philipoakley@iee.email>
Subject: Re: Handling rebasing better
To:     djvortex@gmx.com, git@vger.kernel.org
References: <trinity-15566df8-59d7-4597-b59d-2143ec978b12-1663845799823@3c-app-mailcom-bs01>
Content-Language: en-GB
In-Reply-To: <trinity-15566df8-59d7-4597-b59d-2143ec978b12-1663845799823@3c-app-mailcom-bs01>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dj,

On 22/09/2022 12:23, djvortex@gmx.com wrote:
> Hello.
>
> I wouldn't be surprised if this very subject has already been endlessly discussed over the years, but nevertheless allow me to make a feature request for git. (If this has already been discussed in the past, which I'm quite certain it has, I would like to hear the details so I can understand the design decisions that have been made in this regard.)

I'll have go at commenting from the sidelines. You can look back at /
search previous discussions at https://lore.kernel.org/git/
> Rebasing is a rather curious feature of git in that it's both an extremely common and normal operation done in many projects, and at the same time it's a very drastic measure that has the potential of badly messing up or even breaking git commit histories (as any operation that changes history is), or at a very minimum cause a lot of work.

Is this a reflection of the project organisation (e.g. trying to eat
melons in one step), or did Git somehow 'getting it wrong'? (more later..)
>  Rebasing is extremely common in many projects, so much so that there are many such projects where in fact only fast-forward merges are allowed to the master branch (which is often possible only by rebasing the branch to be merged onto the current master branch head).

Again, is this a code smell (cf Conway's law) about being too close to
the technical debt cliff.
> On the other hand, rebasing, as any other operation that changes commit history, has the potential of breaking things, or causing a ton of extra work, when more than one developer has the same branch checked out (and thus their local history diverges from the remote history).

Rebase itself doesn't typically break things, rather it's things like
forced push, and misunderstood mental models that cause the pains of a
mishandled tool. Rebase can also be too complicated, with a syntax based
on some very specific early experiences that may not reflect modern
common use. A new refactored command may help some who aren't long time
experts in rebase.

> So, given how relatively common it is to use rebasing, and how carefully it should be used, it's a bit strange how poorly git seems to handle it. Not in terms of doing the rebasing itself, but in terms of subsequent operations done to the rebased branch.
>
> For starters, if your current branch has been pushed to the remote, and then you rebase it to something else, and then do a "git status", it will tell you that the local and remote histories have diverged... and then suggests doing a "git pull"! Which is most definitely not what you want to do! 

This 'pull' message is possibly one area where maybe a change to the
message could improve outcomes by being less dogmatic about the expected
work flow, and a little bit more informative about options. It's also
worth making sure you have a complete MVCE [1] to demonstrate the issue
to avoid descriptive confusions. Hardest part is completing the MVCE
after realising where the confusion lay.

> You just rebased the branch, you don't want to try to merge it with the old branch history! (Developers who have not encountered this before may become really confused if they try the "git pull" and start getting tons of really strange merge conflicts. The absolute worst thing they could then do is try to "resolve" those conflicts, which is most definitely not what you want to do! I don't know if there are situations where you actually *don't* get any merge conflicts and the two diverged histories just merge... creating a complete mess of a hybridized duplicated history.)
>
> I think that git should be aware of what has happened, in other words, that the current local branch has been rebased to something else, and is now a completely different history from the same branch in the remote, and express this clearly and suggest the correct thing (primarily to do a "git push -f").

Do check the force-with-lease option as well, and how your workflow was
designed, and has developed to it's current state. Many workflow have
premature optimisation failures embedded in them.
>
> More importantly, I think git should handle better the situation where you are trying to pull a rebased branch (which was rebased by someone else) onto your local original non-rebased one. Again, currently you'll just get a huge bunch of weird merge conflicts (if you are lucky), and the worst thing you could do is try to "resolve" them, as that's precisely what you shouldn't be doing.

This scenario (where left hand does not know what the right hand is
doing) is a social/management problem that needs more than a technical
fix. Essentially, the two hands are having an unexpected arm wrestling
contest based on their workflows.
>
> I understand that the branch history having changed on the remote can be a nightmare to deal with, when you have a local non-rebased copy of it, especially if you have made new local commits to it. AFAIK there are no easy clear-cut solutions to this, but one of them is to just write down the hashes of your commits, reset to the remote branch, and then cherry-pick your commits in chronological order (resolving any merge conflicts that may happen).
>
> The problem is that git isn't exactly helping here. I think that git should recognize the situation

Because Git is distributed, it's not always possible to have the big
picture overview (aka "recognize"), rather its limited to noting and
reporting a few issues - the big picture isn't there.
>  and give better suggestions on what to do. In other words, if you are doing a "git pull" and the remote branch has been rebased, git should stop and tell clearly that this has happened, and suggest what to do. 

The message could be improved, but the usual discussions would ensue as
to purpose, who & what it's trying to tell, etc. (see note 4. below)
> If it detects that the local branch is identical to the old remote branch (that existed before the rebase), it could suggest a reset. If it detects that there are new local commits on top of the old history, it could make another suggestion on how to deal with it. It might also give the (rather unsafe) option of doing the pull anyway, for example with something like "git pull -f", with a huge warning.
>
> Perhaps git could even support the "reset-to-the-remote-history and then cherry-pick your new local commits" directly, to help the developer in this task (so that you don't need to write down any hashes and do all that manually). But even if this isn't really feasible, at least detecting the situation and the clearer messages would help enormously.
>
> (I understand that the current design of git might not directly allow this with just some code changes, and would perhaps require adding some kind of extra metadata. But would this be bad? It would certainly help developers handle rebases better.)

--
Philip
[1] https://stackoverflow.com/help/minimal-reproducible-example (How to ..)

Personal notes:
1. new rebase, a new command name: git transplant, git relocate, git
rendition?; freedom to get the semantic, syntax and mental models right
this time, cf the checkout/switch changeover

2. separation of concerns for the interactive and supposed automatic modes

3. "Upstream" confusion. Git being too eager to drop your work in favour
of others (causing a race to the bottom - fast failure)
3b. and effects of reflog behind the scenes.

4. Update that "git pull" advice to e.g. "`fetch` & trial merge, or
`pull`, if confident".
