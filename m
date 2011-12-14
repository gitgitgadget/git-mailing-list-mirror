From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/7] revert: allow single-pick in the middle of
 cherry-pick sequence
Date: Wed, 14 Dec 2011 21:18:45 +0530
Message-ID: <CALkWK0mt03SSNT-svUO1wHdq5OpM=0xQO3FHkSGGEDuW-jUEXA@mail.gmail.com>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net> <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net> <20111210125948.GE22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 16:49:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rar51-00007l-BD
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 16:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab1LNPtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 10:49:10 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34136 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab1LNPtH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 10:49:07 -0500
Received: by faar15 with SMTP id r15so1302249faa.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dQef7J966Nu9kn69J1RmKxS640GVOPIz05kV05ciBWA=;
        b=w1FfNE1jecBTrAG8T7+bN2pHWuMjFMRmO+N8/WHKRBYeyMkH9nvrWLsnhE6aTBo3Ip
         IMdSZHvOx7ZbMF8tK70+Yy/6UY1ArTcufUWvZyqJ939CYGqtWbsX4UoqkgtAqDAw6Ne5
         eyvtPjPE1JBKdhNpNCP6iZ9b1tl6KKZ4kxZkY=
Received: by 10.180.88.66 with SMTP id be2mr5686397wib.54.1323877746270; Wed,
 14 Dec 2011 07:49:06 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Wed, 14 Dec 2011 07:48:45 -0800 (PST)
In-Reply-To: <20111210125948.GE22035@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187134>

Hi,

Jonathan Nieder wrote:
> When I messed up a difficult conflict in the middle of a cherry-pick
> sequence, it can be useful to be able to 'git checkout HEAD . && git
> cherry-pick that-one-commit' to restart the conflict resolution.

I was about to complain about the commit message until I noticed that
Junio already fixed it in `next`:

    revert: allow single-pick in the middle of cherry-pick sequence

    After messing up a difficult conflict resolution in the middle of a
    cherry-pick sequence, it can be useful to be able to

        git checkout HEAD . && git cherry-pick that-one-commit

    to restart the conflict resolution. The current code however errors=
 out
    saying that another cherry-pick is already in progress.

Interesting concept; let's see how it's implemented.

> Suggested-by: Johannes Sixt <j6t@kdbg.org>

Could you link to the corresponding thread with Johannes?

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 71570357..dcb69904 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -1072,6 +1072,12 @@ static int sequencer_continue(struct replay_op=
ts *opts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return pick_commits(todo_list, opts);
> =C2=A0}
>
> +static int single_pick(struct commit *cmit, struct replay_opts *opts=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 setenv(GIT_REFLOG_ACTION, action_name(opts), 0=
);
> + =C2=A0 =C2=A0 =C2=A0 return do_pick_commit(cmit, opts);
> +}

single_pick as opposed to the continue_single_pick introduced in 2/7.

> =C2=A0static int pick_revisions(struct replay_opts *opts)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit_list *todo_list =3D NULL;
> @@ -1097,6 +1103,26 @@ static int pick_revisions(struct replay_opts *=
opts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return sequenc=
er_continue(opts);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* If we were called as "git cherry-pick =
<commit>", just
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* cherry-pick/revert it, set CHERRY_PICK=
_HEAD /
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* REVERT_HEAD, and don't touch the seque=
ncer state.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* This means it is possible to cherry-pi=
ck in the middle
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* of a cherry-pick sequence.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/

Conceptually all very good.  What I'm really interested in seeing is
how you persist opts for "cherry-pick --continue" when a single-commit
pick fails: in other words, how you manage to get " --continue of
single-pick respects -x" to pass.

> + =C2=A0 =C2=A0 =C2=A0 if (opts->revs->cmdline.nr =3D=3D 1 &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->revs->cmdline.rev->whence =
=3D=3D REV_CMD_REV &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opts->revs->no_walk &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !opts->revs->cmdline.rev->flags)=
 {

Yuck, seriously.
1. I'd have expected you to check opts->revs->commits, not
opts->revs->cmdline.nr.  Okay, you're using the cmdline because the
revision walk hasn't happened yet.
2. Why are you using opts->revs->cmdline.rev->whence as opposed to
opts->action?  Why do you want to expose the underlying revision
walking mechanism?
3. When will the opts->revs->no_walk condition not be satisfied?  Only
when you explicitly set it to 0 or NULL, right -- where is this
happening in revert.c?
4. Why are you checking flags?  When is this condition not going to be
satisfied?

Since 3 and 4 indicate that you're being overly defensive, consistency
requires you to guarantee that this code will work no matter what the
rev_info struct is filled up with prior to this segment.
Is this true?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct commit *cmi=
t;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prepare_revisi=
on_walk(opts->revs))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die(_("revision walk setup failed"));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmit =3D get_revis=
ion(opts->revs);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cmit || get_r=
evision(opts->revs))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("BUG: expected exactly one commit from walk");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return single_pick=
(cmit, opts);
> + =C2=A0 =C2=A0 =C2=A0 }

I'd have expected you to reuse prepare_revs().

> + =C2=A0 =C2=A0 =C2=A0 /*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Start a new cherry-pick/ revert sequenc=
e; but
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * first, make sure that an existing one i=
sn't in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * progress

Since all your new code is a special case of "Start a new cherry-pick/
revert sequence", you don't check the sequencer state in the first
place.

> diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-se=
quence.sh
> index 56c95ec1..98a27a23 100755
> --- a/t/t3510-cherry-pick-sequence.sh
> +++ b/t/t3510-cherry-pick-sequence.sh
> @@ -50,6 +50,18 @@ test_expect_success 'cherry-pick persists data on =
failure' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_path_is_file .git/sequencer/opts
> =C2=A0'
>
> +test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
> + =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick base..anotherpi=
ck &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp_rev picked CHERRY_PICK_HEAD &&
> + =C2=A0 =C2=A0 =C2=A0 # "oops, I forgot that these patches rely on t=
he change from base"
> + =C2=A0 =C2=A0 =C2=A0 git checkout HEAD foo &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick base &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick picked &&
> + =C2=A0 =C2=A0 =C2=A0 git cherry-pick --continue &&
> + =C2=A0 =C2=A0 =C2=A0 git diff --exit-code anotherpick
> +'

Cute feature, although I don't ever recall needing it personally.  Why
does this relatively esoteric "feature" belong along with the other
"maintenance patches" in  jn/maint-sequencer-fixes?

-- Ram
