From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Fri, 19 Aug 2011 14:38:30 +0530
Message-ID: <CALkWK0mb_9DzV_Yb6ZGzFErrMLH6NAvXWE_MuEohp=oOMjaq4g@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com> <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org> <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org> <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
 <CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com>
 <20110818191812.GG30436@elie.gateway.2wire.net> <7vvctu8naf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 11:09:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuL4c-0005V6-TN
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 11:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab1HSJI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 05:08:56 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37800 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab1HSJIv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 05:08:51 -0400
Received: by wwf5 with SMTP id 5so2952824wwf.1
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2L+T7NFlQVVb4cfczFi7bt27Bf4AzUt3n2G1f7eJSaA=;
        b=KVq4AM9q2dnrBVVllA3ZqCF4L0UBnzAH+ZHRQWrLNwHWT71IMKXyJ7C8Ls2yM/NXjo
         G0ul3OUXXn9RLsWUrbln2NvZxTFUV6mikk6M4KDMEqwdmyyB354KpSHVZtXfBRabdKA7
         Tonwl78nvZbt2lmz12KtD//Cy4sb4qmUAmvEU=
Received: by 10.216.131.134 with SMTP id m6mr1421651wei.78.1313744930117; Fri,
 19 Aug 2011 02:08:50 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Fri, 19 Aug 2011 02:08:30 -0700 (PDT)
In-Reply-To: <7vvctu8naf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179685>

Hi Jonathan and Junio,

Jonathan Nieder writes:
> Why can't it become the sequencer's responsibility, FWIW? =C2=A0That'=
s an
> implementation detail.

It can be the sequencer's responsibility if we want that!  I'm just
dabbling with the different implementation strategies and trying to
see the advantages/ disadvantages of each one.  The "right" thing to
do wasn't obvious to me immediately.

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>> Why modify tests? =C2=A0I think "git merge --continue" is a nice id=
ea,
>>> and I don't see how it's inconsistent in any way with continuing to
>>> allow old practice.
>
> I agree. Updating the test will hide a regression if Ram's update bre=
aks
> the existing workflow to conclude a conflicted merge with "git commit=
".
> If we are to add "git merge --continue" sugarcoat to make it easier t=
o
> teach new people saying that "To any Git operation that stops and ask=
s you
> to help, you can tell it that you are done helping by re-running the =
same
> command with --continue flag", then _new_ tests should be added to ma=
ke
> sure that "git merge --continue" does act just like "git commit" in s=
uch a
> case.

Right.  We have to keep the old tests around -- my bad.

>>> As Junio hinted, it could make a lot of sense for "git cherry-pick
>>> <single commit>" to not create sequencer state in the first place.
>>> "git cherry-pick --continue" does not need it --- it is enough to
>>> commit with the conflict resolved. =C2=A0"git cherry-pick --abort" =
does not
>>> need it, either --- it is enough to "git reset --merge HEAD".
>>
>> Okay, here's my problem with the idea: it'll essentially require the
>> sequencer to differentiate between one-commit operations and
>> many-commit operations.
>
> I think you are looking at it in a wrong way. It is just about giving
> backward compatibility to historical hacks. cherry-pick and revert ma=
y be
> the only ones needed, and a new command Foo that implements its workf=
low
> in terms of the sequencer can choose to (and should choose to unless =
there
> is a compelling reason not to, because of the exact reason you stated
> here) do a single-command insn sheet with "git Foo --continue" to con=
clude
> if that one and only step needed help from the end user.

No, no.  I don't _want_ to create an AM_HEAD or FOO_HEAD for every new
command that we write -- I was merely pointing out what would happen
if the sequencer were only built to handle multi-commit-operations,
and every new command would have to handle single-commit-operations on
their own.  I was emphasizing that the sequencer will need to handle
single-commit-operations as well; Jonathan has suggested that we have
special hacks to handle cherry-pick and merge commands in the
sequencer.

To conclude, let me list out the various implementation strategies
we've thought about, and the one we seem to have settled on:
0. Remove the sequencer state from "git commit".  This is wrong, as
Junio pointed out in the first email.
1. Let commands handle single-commit-operations themselves, and call
into the sequencer only for multi-commit-operations.  If they don't
call into the sequencer at all, there's no state to persist or
cleanup.  This approach is clearly wrong because each new command
would have to come up with AM_HEAD and FOO_HEAD to persist the
single-commit-operation state.
2. Expose two functions from the sequencer: "earlier-function" and
"later-function".  Let cherry-pick and merge handle their own
CHERRY_PICK_HEAD and MERGE_HEAD hacks first (by setting up the
revision walker, counting commits etc), and call into later-function
in the sequencer to do less work from the sequencer's end.  All new
commands can directly call into earlier-function directly.  I know
it's a little hand-wavy, but I hope it's atleast parse'able this time.
 As I pointed out in another email, this is also broken because
cherry-pick/ merge would have to implement their own versions of every
subcommand like "--continue".
3. Let all commands call into the sequencer for everything.  Let's
teach the sequencer about the CHERRY_PICK_HEAD and MERGE_HEAD hacks so
that it can deal with them when a "pick", "revert" or "merge"
operation is encountered.  We'll handle it by treating
CHERRY_PICK_HEAD and MERGE_HEAD as part of the "sequencer state" (so
that subcommands work just fine on them).  For all future sequencer
commands, all data will be persisted inside '.git/sequencer'.  This
seems most reasonable now.

In a nutshell, instead of side-stepping historical hacks, we want to
teach the sequencer about them as specific cases to handle carefully.
We want to this without affecting the operation of the sequencer in
the general case.  Sounds great!  An uncompromising UI at the cost of
little ugliness in the sequencer.

Thanks.

-- Ram
