From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/7] New sequencer workflow!
Date: Tue, 15 Nov 2011 14:03:01 +0530
Message-ID: <CALkWK0kdCnU_BUaYPiNAKypRvEKgDtDKLO=Qed4CQtX23tq0wA@mail.gmail.com>
References: <1321181181-23923-1-git-send-email-artagnon@gmail.com>
 <7v39droi63.fsf@alter.siamese.dyndns.org> <7vaa7zmuwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 09:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQESP-00007O-B1
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 09:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab1KOIdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 03:33:24 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37430 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab1KOIdX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 03:33:23 -0500
Received: by wyh15 with SMTP id 15so6759385wyh.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cX6/hj1Otl/lWgX7/f871NvdjJt+QZqEAZHf9ZEq9rk=;
        b=o6gXI4/ok9QU3a5K3vRPXcI0iyM8oJjRVbFyRhwqkg5fXtNFPdi0Inb6PTkzW7wHaM
         rp02SSwCSWQnvN96kK3L61j5sd7lmA/rGMXzsHP6PYFc00RCwa7GyuQ3QLkaoDpqdbUa
         1jUw31G6sfQwpZPDJ/65wO5TEqo4cBWNc85T0=
Received: by 10.216.188.145 with SMTP id a17mr4252017wen.24.1321346002458;
 Tue, 15 Nov 2011 00:33:22 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Tue, 15 Nov 2011 00:33:01 -0800 (PST)
In-Reply-To: <7vaa7zmuwt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185443>

Hi Junio,

Thanks for the fantastic review.  My lack of foresight is very disturbing.

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> This series preserves the old workflow:
>> [...]
> Hmm, doesn't "git add && git cherry-pick --continue" (i.e. no "git commit"
> in between) trigger the "commit the resolution first and then go on"?

Ugh, right.  I can't possibly preserve the old workflow fully- what I
meant is that users can still "git commit" before continuing (in the
case of a multi-commit operation).  It's not so much about preserving
a workflow, as it is about not breaking existing tests.

> Almost. If these are replaced with "git cherry-pick --continue" and "git
> revert --continue" that internally triggers "git sequencer --continue"
> *and* errors out if a wrong command was used to "--continue", it would be
> perfect.

Okay, there are two ways to fix this:
1. If the first instruction in the instruction sheet is a "revert" and
"git cherry-pick --continue" is called or viceversa, error out.  The
downside is that there's really no sane way to handle mixed "pick" and
"revert" instructions in the sheet using this approach: parsing the
whole sheet in advance is a total overkill.
2. The key issue is that the sequencer doesn't keep track of which
command was actually executed (argv[0]): fix this by creating a new
'.git/sequencer/cmd' to keep this information.

I think we should pick the latter option.  Also, why should "git
<cherry-pick|revert> --continue" invoke "git sequencer --continue"
when it can just call into the corresponding function in the sequencer
library (isn't lib'ification one of the issues we're trying to
address)?

> While I do not mind "sequencer --continue" as a step to get us closer to a
> more pleasant user experience at the implementation level, exposing the
> name "sequencer" or having the user to type "sequencer --continue" is going
> in a very wrong direction at the UI level.
> [...]
> Now, if you rename "cherry-pick --continue" and "revert --continue" to
> "sequencer --continue", what message are you sending to the users? They
> now need to learn that only these two commands are based on something
> called "sequencer", can be resumed with "sequencer --continue", but other
> commands need to be continued with "X --continue".

Thanks for the superb explanation- it's plain as day now.  In a
nutshell: it makes little sense to have a grand plan about an
all-encompassing "git sequencer --continue"; even if that is the plan
in the super-long term (although "git continue" is a better idea), it
makes no sense to burden the user now with additional UI
inconsistencies.

I'm still a little confused about what to do with the "git sequencer"
builtin though: how do we prevent users from being confused by it- by
not advertising it?

> The original workflow was "pull; edit && add && commit", and it is very
> unlikely this will change while we are still in Git 1.X series. The
> original single commit variants of "cherry-pick" and "revert" are in the
> same category. We would need to keep supporting "cherry-pick/revert; edit
> && add && commit" as a workflow for a while.

True.  I wrote this pretending that only "git <cherry-pick|revert>"
was stuck with this UI inconsistency between one-commit picks and
many-commit picks.

> In the shorter term, a person new to Git, after learning "run command X, X
> gives back control asking for help, help X by editing and adding, and
> telling X to continue" pattern from these commands, will eventually find
> that the commands in single stop-point category (i.e. "pull", "merge" and
> single-commit "cherry-pick" and "revert") inconsistent from others that
> take "--continue" to resume. For this reason, "git cherry-pick --continue"
> that would work even when picking a single commit like this would be
> beneficial:
> [...]

Interesting aside: this final detail is fixed only in the last patch
in the series; that's how deep the problem is.

> In the longer term (now we are talking about Git 2.X version bump), it
> would be ideal if all the "git X --continue" can be consolidated to a
> single "git continue" command (and "git abort" to give up the sequence
> of operations).
>
> Given that bash-completion script can tell in what state the repository
> is, I think this is doable. "git continue" may invoke your implementation
> of "git sequencer --continue" internally when it detects that the state is
> something the "sequencer" machinery knows how to continue, and if it is in
> the middle of conflicted "am -3" or rejected "am", the command may invoke
> "git am --continue" instead.

Makes perfect sense.

Thanks.

-- Ram
