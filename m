From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH 0/5] ff-refs: builtin command to fast-forward local refs
Date: Wed, 11 Nov 2015 07:32:37 -0500
Message-ID: <CANoM8SV77Jg8qYsn7UZ=a18WvrA_ayAWCnAjN9Tf6Re=r1Ggsg@mail.gmail.com>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com> <56431B69.9010007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	David Turner <dturner@twopensource.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 13:33:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwUaH-0004wb-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 13:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbbKKMdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 07:33:00 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33161 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbKKMc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 07:32:59 -0500
Received: by obbww6 with SMTP id ww6so20833987obb.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 04:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BU489F44fnTiqGMAltGXX+G9QRFqFb2qB4UDMJMwweI=;
        b=xwPPfikLhPKKqZsy2DkVs9Hdt69JPHaDoVf3qFP2MJ80kqZckEw6HZcSCFD9S/0JH+
         CwOZeWNhgg0kN5Ov5l2mnAy8gcpiMeAtkU24WqTw25EOuTbqjNXuRnzLbI9+jaJ3XEzt
         74B9I3ax/UZtR3Rn2kUc1jRF19S/QQCNLK6+Au5Lay2TczNvmqFeK7tFaDhPsviRECh/
         6RElprEgWnn3s8q7LRSRSx1vivUL2MpGBfyUL0X5Ah7AvErwbe4/EpggR7vk+ZCn/PzA
         eM5AX2qzBt76jIhy35WWrJ1k+XNoDgd6QV9Q5rguus7JSJtmQeNwXKsQWPYb9BZCujUU
         JQJA==
X-Received: by 10.60.15.131 with SMTP id x3mr5081979oec.74.1447245178120; Wed,
 11 Nov 2015 04:32:58 -0800 (PST)
Received: by 10.202.79.76 with HTTP; Wed, 11 Nov 2015 04:32:37 -0800 (PST)
In-Reply-To: <56431B69.9010007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281161>

On Wed, Nov 11, 2015 at 5:41 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Michael Rappazzo venit, vidit, dixit 11.11.2015 03:11:
>> This patch series is built on (based on) 'next' because it relies on
>> worktree.c
>>
>> `ff-refs` will update local branches which can be fast-forwarded to their
>> upstream tracking branch.  Any branch which has diverged from the upstream
>> will be left untouched by this command.  Additionally, there are options
>> for '--dry-run' and to '--skip-worktrees'.
>>
>> There are two primary update mechanisms for fast-forwarding a branch.
>>   - For a checked out branch, emulate `git-merge --ff-only`
>>   - For a non-checked out branch, emulate `git update-ref`
>>
>> When run on a repo with multiple worktrees (created with git-worktree add),
>> git-ff-refs will take that into account when fast-forwarding.  That is, it
>> will run in 'merge --ff-only' emulation mode when a branch is checked out
>> in a worktree, rather than in 'update-ref' mode.
>>
>> The primary benefit of ff-refs will come for those who maintain several
>> local branches which track upstream remote branches that update often.  The
>> intended usage pattern is to run `git-fetch` followed by `git-ff-refs`.
>
> I'm sorry, but I don't see why this deserves a new command. If refspec
> with and without "+" are not enough then maybe "git fetch --all" or "git
> remote update" should learn a new "--ff-only" option (ignoring all "+")
> like merge has.

Maybe I wasn't clear in my description, or maybe I misunderstand
something.  This command is about updating local refs (branches,
really), not the local copy of a remote ref.  If, for example I have
local branches:

    master -> origin/master
    next -> origin/next
    pu -> origin/pu
    feature1 -> features/feature1
    feature2 -> features/feature2
    feature3 -> features/feature3
    bug1 -> features/bugs/bug1
    bug2 -> features/bugs/bug2

If I don't use multiple worktrees, I probably only have one of those
checked out at any one time.  If any of the upstream branches are
updated, then when I fetch those branches will be behind.  If I wanted
to make sure that the branches I am not touching are updated, I would
have to do it individually (AFAIK).  And why not update my local
worktree if it is a fast-forward?.  This command aims to put that
local branch update into a single command.

    > git fetch --all
    fetching origin...
        abc1234..abc1235  next -> origin/next
        abd1234..abd1235  pu -> origin/pu

    fetching features...
        123abcd..123abce  feature1 -> features/feature1
      + 124abcd...124abce feature2 -> features/feature2
        125abcd..125abce  feature3 -> features/feature3
    > git ff-refs
        master -> origin/master.........[UP-TO-DATE]
        next -> origin/next.............[UPDATED]
        pu -> origin/pu.................[UPDATED]
        feature1 -> features/feature1...[UPDATED]
        feature2 -> features/feature2...[NON-FAST-FORWARD]
        feature3 -> features/feature3...[UPDATED]
        bug1 -> features/bugs/bug1......[UP-TO-DATE]
        bug2 -> features/bugs/bug2......[UP-TO-DATE]

For reference, I have been using a scripted version of this command
[1].  Assuming that I change your mind on this command, I will add
this example to the help doc.

>
> As for updating worktrees: This shouldn't be taken too lightly anyways.
> But the worktree interface still has some rough edges, and I would hope
> that it learns a "foreach" subcommand very much like the submodule
> version. That would allow you to
>
> git worktree foreach git merge --ff-only
>
> with a systematic aproach that opens many other opportunities.
>
> Michael

I am aware of the current status of the worktrees command (I worked on
the 'list' command).  If a user only wants to update unchecked out
branches, there is a command line option provided, '--skip-worktrees'.

The foreach command sounds like a good idea, but I don't know that it
would help here, as ff-refs is looping through all of the refs already
(ala for-each-ref).  If you are proposing foreach-worktree as an
alternative, that is good for half of the command, but I would still
want to update the unchecked out refs.

_Mike


[1] https://github.com/rappazzo/dotfiles/blob/ff-refs/bin/git-ff-refs
