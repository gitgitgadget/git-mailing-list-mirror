From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 14/17] reset: Make hard reset remove the sequencer state
Date: Sun, 17 Jul 2011 22:10:03 +0530
Message-ID: <CALkWK0=XP=hwsN8vVmTc2Rs3mYuZnLZOpg4=OE7mrYbAYm6nCQ@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-15-git-send-email-artagnon@gmail.com> <20110712201532.GE14909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 17 18:40:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiUOL-0001dz-Gc
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 18:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab1GQQkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 12:40:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43851 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462Ab1GQQkY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jul 2011 12:40:24 -0400
Received: by wwe5 with SMTP id 5so2549795wwe.1
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9nEZh0RkOyS0ct98BGHSdFysBZtcSitQsvwmW5vf1SE=;
        b=EF8XRqjcMNPxHoVLC6nw8btL1DQGTg3PB+ahEwruQTk8GE+Pq42d+98LImDIc7SYDk
         3PRdXNkjrIrVj60v6fJiNZG997tQLrZE93c/5OXt2hMmLIFDcCVmx8onVE757Hf0aiM5
         4LGUxCJNVKSj58eD4mctgJSfPdPSB1uIo7T4w=
Received: by 10.216.143.66 with SMTP id k44mr2292982wej.81.1310920823091; Sun,
 17 Jul 2011 09:40:23 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Sun, 17 Jul 2011 09:40:03 -0700 (PDT)
In-Reply-To: <20110712201532.GE14909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177305>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Years of muscle memory have trained users to use "git reset --hard" =
to
>> remove away the branch state after any sort of operation. =C2=A0In
>> retrospect, while this may not have been the best design decision, w=
e
>> are stuck with it for historical reasons.
>
> Wait, wait! =C2=A0If that was a bad design decision, we should try to=
 find
> a way to smoothly transition to a world without it, instead of
> layering workarounds on top of it.
>
> But actually I think it is good UI. =C2=A0When you do "git merge", it=
 works
> like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git merge <foo>; # conflicts!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... hack hack hack ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Oh, bother, let me go back to a state I =
know well and am
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# comfortable with.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard <bar>
>
> And the same psychological effect applies in the cherry-pick case:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick <foo>; # conflicts!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... hack hack hack ...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Oh, bother, let me go back to a state I =
know well and am
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# comfortable with.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard <bar>
>
> See, it's about the tool working with you. =C2=A0When I abandon a mer=
ge,
> I don't want to have to search through the owner's manual for the
> button to get git to clear away this unpleasant and unfamiliar state.

=46air enough.  It's a large hammer to solve the problem, and it's used
by many people; I use it a lot myself.

> Now, by contrast, sometimes one wants something less aggressive.
> For example, to abandon a partial merge conflict resolution but
> keep unrelated changes in the worktree:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --merge HEAD
>
> Or to get out of the "mergy" state but leave the worktree alone:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset
>
> There's no porcelain or plumbing to abandon a rebase without
> additional side-effects, but "git status" suggests a command for
> it if I remember correctly.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -fr .git/rebase-merge

We're not making this mistake with the sequencer :)

>> Additionally, this patch ensures that some existing tests don't brea=
k
>> when features like "--reset" and "--continue" are introduced later i=
n
>> the series.
>
> That's not "Additionally" --- it's the same problem. =C2=A0One way to
> phrase it would be "Noticed by running such-and-such test after
> such-and-such change".

Right.  Minor tweaks made to the commit message.

reset: Make reset remove the sequencer state

Years of muscle memory have trained users to use "git reset --hard" to
remove the branch state after any sort operation.  Make it also remove
the sequencer state so that this sort of workflow is now possible:

$ git cherry-pick foo..bar
=2E.. conflict encountered ...
$ git reset --hard # Oops, I didn't mean that
$ git cherry-pick quux..bar
=2E.. cherry-pick succeeded ...

Also, guard against accidental removal of the sequencer state by
moving ".git/sequencer" to ".git/sequencer-old" in the first "git
reset --hard" call, and only remove it completely only after the
second call.

This patch ensures that some existing tests don't break when features
like "--reset" and "--continue" are introduced later in the series.
Without this patch, we would expect the last cherry-pick call in the
example to fail with the complaint that an existing cherry-pick
operation is in progress.

>> +test_expect_success 'reset --hard cleans up sequencer state' '
>
> Hoorah! =C2=A0Thanks.
>
> Why isn't the .git/sequencer removal in remove_branch_state() like
> MERGE_MSG and other similar examples are? =C2=A0(Not a rhetorical que=
stion;
> it would be interesting to know.)

I thought we should only make a hard reset clear it, but all the reset
codepaths reach remove_branch_state().  However, in view of
consistency, I've put the removal code in remove_branch_state() now.

-- Ram
