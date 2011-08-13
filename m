From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Sat, 13 Aug 2011 23:10:35 +0530
Message-ID: <CALkWK0=seEY+O8qmNKoPyYPW-QT9zpwGsh8SB89qcd6kUQRdKg@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com> <20110811215650.GA13839@elie.gateway.2wire.net>
 <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com> <alpine.LNX.2.00.1108131215170.2056@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Aug 13 19:41:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsICw-0002jn-4k
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 19:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426Ab1HMRk4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 13:40:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48858 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1HMRk4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 13:40:56 -0400
Received: by wwf5 with SMTP id 5so3757822wwf.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Z562SSPLNolQ4mIeiu0IEAAWvmYGC2jOMsa9aB1LMmM=;
        b=N5coXOPqoooMCkKkta5o7Wpy2IqID6z8xW3z4nkLJb/w93UfrIM6X5K8aH1WZSeAnG
         SiED2fN2b+B3YoKo7JRbo1MI2wKMRot3/39mOkL38ZlZj4id1LKLvfXFOUYcjobP5I6Z
         /DZmfMyQhtEbS/+6pRHUs7oz9dYzYiPkKb/aU=
Received: by 10.216.175.130 with SMTP id z2mr1416707wel.63.1313257255067; Sat,
 13 Aug 2011 10:40:55 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Sat, 13 Aug 2011 10:40:35 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1108131215170.2056@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179285>

Hi Daniel,

Daniel Barkalow writes:
>> 1. Make prepare_revs and walk_revs_populate_todo return errors to be
>> handled by callers. =C2=A0This is a fairly small patch that can come=
 before
>> the big "code moving patch".
>
> This makes sense. If you type "git log --stat=3Dfoo", you don't get a
> diff usage message, even though it's an error parsing options that we=
re
> originally part of diff.

Yes :) I really liked the "revert: Propagate errors upwards from
do_pick_commit" patch.  I hope we improve the error handling in other
parts of Git soon.

>> 2. Duplicate action_name in both files. =C2=A0I don't think it's too
>> serious, and we can fix this later.
>
> This is actually probably even a good idea, because the two functions
> might actually want to give different results. Maybe revert.c will en=
d up
> doing different sequencer operations depending on whether the commit =
is a
> merge, but if revert.c has to give an error, it would call it the sam=
e
> thing either way, because the difference doesn't matter at the level =
of
> detail the revert.c works at; on the other hand, sequencer.c would wa=
nt to
> distinguish the cases so that it is explaining exactly what it's tryi=
ng to
> do in this step because it matters to how the issue would be resolved=
=2E
>
> Of course, at the point where you move the code, you only have one pi=
ece
> of code that you're starting from, so they'll be the same. But you mi=
ght
> want to name them differently.

Excellent suggestion- I want to create a differentiation between the
sequencer "pick" action and the builtin "cherry-pick" operation.  I
mentioned earlier that I wanted the sequencer to be more than a fast
git-shell.  It'll be interesting to see the kinds of composite
"actions" we invent later; especially ones that only make sense in the
context of sequencing commits.

>> It has been enormously annoying to work with this "code moving patch=
":
>> everytime I make some changes to the earlier patches, I have to
>> recreate this one by hand; rebase offers no help whatsoever. =C2=A0A=
fter
>> throwing away code based on this patch several times, I learnt my
>> lesson and restricted my series to avoid building on this patch. =C2=
=A0I
>> consider this a very serious glitch and I'm interested in fixing it.
>> Thoughts?
>
> It's a hard problem, although likely worthwhile to solve. But only wh=
en
> you're not doing anything else, because it's complicated and will tak=
e you
> far afield. Essentially, what you need to do is implement a diff algo=
rithm
> that can detect reorganization (or copying) of sections; this isn't
> something you can represent in unified diff output, but that's okay
> because you're not going to output it. You merge two of these results=
 and
> apply the result to the base, which gives you a file (potentially wit=
h
> conflicts, which is another interesting issue because you have to
> represent and explain them somehow).

Hm, I was actually thinking of a much less ambitious helper that would
kick in when the heuristic correlation between two files is above a
certain threshold.  Your idea is better!  It would be totally awesome
if we could modify the diffing algorithm to work between files,
although I can't even imagine where to start.  Oh, and I think we have
to go far beyond the traditional in-file conflict markers to resolve
conflicts.  Pretty insane challenge :D  I'm definitely not experienced
enough to take this on now, although I hope to be good enough someday.

> *: bisect could be using sequencer in order to handle the situation w=
here
> the user has said "commit A is good, commit B is bad, commit C breaks=
 my
> system in a way that's unrelated"; the system should then be able to =
check
> out a maybe-bad commit and revert C from it, but it would be doing th=
is in
> response to an instruction from the user: "give me something to test
> next", and would have to present errors differently.

Thanks for the interesting sidenote.

-- Ram
