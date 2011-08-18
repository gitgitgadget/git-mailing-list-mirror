From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Fri, 19 Aug 2011 01:20:47 +0530
Message-ID: <CALkWK0=jRAq6s1zQ5gwB4feBgC1eo=VYLWx8bsjs+exqmz0f1A@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com> <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org> <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org> <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com> <20110818191812.GG30436@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:54:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8fB-00025K-CK
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab1HRTvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 15:51:10 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47993 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1HRTvJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 15:51:09 -0400
Received: by wwf5 with SMTP id 5so2437850wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 12:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+M5aPQ0EKd93wRwZ4Q5UHxD0pTDdi8U24DtSe0hIvu4=;
        b=Q4APpgXbhs0JlwMy0VVZFUALB8S1KoypQsyUgnp2LAZB+dDT3c/hx49Siy6a3TKKee
         rLnYj1OKi53TMUr8ijKPHGo14JtcoyckpmDbcQi27j2Jjlr0+XzrKrR3O+pjVo9uxhr7
         bscea7BW4Q1eVjnIFWSY89WSaXx1AEv1VFrSc=
Received: by 10.216.175.130 with SMTP id z2mr947364wel.63.1313697068159; Thu,
 18 Aug 2011 12:51:08 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Thu, 18 Aug 2011 12:50:47 -0700 (PDT)
In-Reply-To: <20110818191812.GG30436@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179616>

Hi Jonathan,

Jonathan Nieder writes:
> Could be briefer. :)

Sorry about the braindump :P

>> 1. Introduce a 'merge --continue' to invoke 'git commit'. =C2=A0MERG=
E_HEAD
>> helps 'git commit' finish. =C2=A0Modify tests to use '--continue' in=
stead
>> of the earlier commit-to-finish workflow, and advertise this feature
>> everywhere.
>
> Why modify tests? =C2=A0I think "git merge --continue" is a nice idea=
,
> and I don't see how it's inconsistent in any way with continuing to
> allow old practice.

In the future, we might want a 'merge' instruction in the sequencer --
I want to make it clear that we're going for a significant UI change
so that everyone (including tests, scripts) become comfortable with
the new UI.

>> 2. Make 'cherry-pick --continue' invoke 'git commit' as well.
>> CHERRY_PICK_HEAD helps 'git commit' finish. =C2=A0If the commit fini=
shes
>> successfully: (if there is one commit left, remove the sequencer
>> state; otherwise, drop the first insn on top of the list and execute
>> the next insn).
>
> Sounds like a sensible thing to do. =C2=A0I assume the "one" in the
> parenthesis is supposed to be "zero", making the "if" not even part o=
f
> the user-visible description of what it does --- it's just the
> termination condition of a loop.

Right, sorry about the convoluted thought.

> As Junio hinted, it could make a lot of sense for "git cherry-pick
> <single commit>" to not create sequencer state in the first place.
> "git cherry-pick --continue" does not need it --- it is enough to
> commit with the conflict resolved. =C2=A0"git cherry-pick --abort" do=
es not
> need it, either --- it is enough to "git reset --merge HEAD".

Okay, here's my problem with the idea: it'll essentially require the
sequencer to differentiate between one-commit operations and
many-commit operations.  In the case of one-commit operations, *every*
new command that calls into the sequencer will will need to persist
information in its own way using hacks like CHERRY_PICK_HEAD and
MERGE_HEAD.  And we have to make "git commit" unlink yet another file
:)  I'm not talking about some hypothetical case: I'm already planning
to make 'git am' call into the sequencer, so we'll need an AM_HEAD.

One final resort: Move some code back into cherry-pick, and call into
a later-function in the sequencer only if it's a many-commit
operation.  The new commands can enjoy the comfort of calling into an
earlier-function in the sequencer that'll do all the revision walk
setup and call the later-function.  I think this is reasonable.

> One part I'm handwaving is what to do about commands like "git
> cherry-pick foo^..foo" which use a commit range that only happens to
> contain one commit. =C2=A0Either behavior seems fine for such command=
s.

I don't think I follow.  This will be determined as a single-commit
operation after setting up the revisions.  I don't think it should be
treated as a multi-commit operation because the literal tree'ish
contains "..".

-- Ram
