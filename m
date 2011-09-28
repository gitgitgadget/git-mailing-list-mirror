From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Wed, 28 Sep 2011 10:49:05 -0400
Message-ID: <CAOeW2eFyTewS2+QK7UW_yOWpVKtCkwSBH0PjPutn0BYYqgV1HQ@mail.gmail.com>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com>
	<CALkWK0mggSNoxxqzUaGp1-AxGWSpCb0HnRmBxSkcVrHnhwMr1Q@mail.gmail.com>
	<alpine.DEB.2.00.1109242148570.24369@debian>
	<201109261110.59940.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 28 16:49:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8vRm-0001Dn-N4
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 16:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab1I1OtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Sep 2011 10:49:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47437 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754437Ab1I1OtG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Sep 2011 10:49:06 -0400
Received: by iaqq3 with SMTP id q3so6952657iaq.19
        for <git@vger.kernel.org>; Wed, 28 Sep 2011 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=6QuchqmBjSBOtjMCwFlErZDvOte9YsgIF050VE7Mmn4=;
        b=xurfhIrzU61jygH0yCwJqne3Gz5DikSoQ2AmxWf+oe78h+76ackELT6zmAA73ba0Zj
         55cZUP9woiQQT/rzEH3NP3ALIIigDZmrvHzr2N/Znq1ThcfXR4bLGT91NRDqAv/WIAG7
         UOvtwcO916XR2V5D0jjhyAZxTMbLwGTn9Xq4o=
Received: by 10.231.82.131 with SMTP id b3mr12529529ibl.74.1317221345898; Wed,
 28 Sep 2011 07:49:05 -0700 (PDT)
Received: by 10.231.200.193 with HTTP; Wed, 28 Sep 2011 07:49:05 -0700 (PDT)
In-Reply-To: <201109261110.59940.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182330>

On Mon, Sep 26, 2011 at 5:10 AM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> Martin von Zweigbergk wrote:
>>
>> If I understand correctly, [rebase --root] was introduced to solve
>> exactly the same reason problem that made Francis start this thread
>> -- to avoid re-applying patches that are already in $onto.
>
> Not quite; I wrote it because at the time, there was no way to
> transplant git history onto a git-svn "make empty subdir" commit for
> later dcommitting. =C2=A0So the main point was really

But that was only due to the bug/limitation in format-patch that you
(?) fixed a few days later, no?

> I still think it would be natural for a user to want a way to say "al=
l
> the way back to the root commit". =C2=A0At least for me the "full" re=
base
> invocation is
>
> =C2=A0git rebase --onto onto base branch

Sure, I can understand that. Still,  it would just be an alternative
syntax and nothing else. So I think I should also update the
documentation after my other patches to make it clear that that is the
case. We also have to think about backwards compatibility, so I'm
obviously not suggesting that we should stop supporting the flag; I
just wanted to make sure that it is not technically needed.

>> I saw that
>> "--root" is also passed to the hook. Should that value be passed to
>> the hook also when the old base is not explicitly a root (by "rebase
>> --root"), but only implicitly so (by an $onto that is disjoint from
>> $branch)?
>
> I think I did it that way because if you use --root, the base/upstrea=
m
> argument is missing, and the hook needs to know that.
>
> If the user specifies an upstream that is disjoint from the branch
> itself, the hook gets the upstream argument and can presumably work i=
t
> out from there. =C2=A0So you could perhaps save the hook some trouble=
 if
> you *know* that it's a disjoint rebase, but I wouldn't spend too much
> time on that.

The hook would still have to be able to handle both cases (i.e.
getting the upstream argument as "--root" or simply a commit that
happens to be disjoint from the the branch-to-be-rebased). I believe
that has been the case since that bug in format-patch was fixed. So if
we were to change git-rebase so it no longer passes the --root flag to
the hook, I think any (correctly written) hooks should still work. I
don't see much reason to change it, though; if the user uses the
--root syntax, we can pass the flag, otherwise we don't.

Martin
