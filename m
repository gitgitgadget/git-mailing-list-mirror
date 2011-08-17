From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Heitzmann?= 
	<frederic.heitzmann@gmail.com>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Wed, 17 Aug 2011 16:35:03 +0200
Message-ID: <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
 <7vty9ijs1i.fsf@alter.siamese.dyndns.org> <20110817003023.GA30153@dcvr.yhbt.net>
 <CALeToSWJNK=q4iPwxNvgGin0T61oLKJd=b9F3cSSo0vVebrhhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 17 16:35:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QthDN-0001qe-Mc
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 16:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab1HQOfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Aug 2011 10:35:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50235 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab1HQOfX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2011 10:35:23 -0400
Received: by vws1 with SMTP id 1so697928vws.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=d88yFq9+eLnblBIx0RxsU9TkXoNn9VaCRVe3xj7mLMA=;
        b=p8+uE/W6cEq6O2Br1oEm4Qodc16X5RCX9ERDieJLIIWZzT03WhYbHqabQWdNM3ghh4
         FZ9vfI2asHNRAtzPO6FFRHBpm7vj+NIPRcDiQiO3LaFaQk1LAHU6jWioIy3MJ/OQZXV+
         IIQElMudCDhMx0uGsvgOmv+1bh/2e8jwR25do=
Received: by 10.52.21.201 with SMTP id x9mr1029692vde.363.1313591723103; Wed,
 17 Aug 2011 07:35:23 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Wed, 17 Aug 2011 07:35:03 -0700 (PDT)
In-Reply-To: <CALeToSWJNK=q4iPwxNvgGin0T61oLKJd=b9F3cSSo0vVebrhhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179514>

Hi all.

Maybe I should give some more context to explain why a hook could be a
potential improvement.

Let's consider the following workflow :
1) git svn clone from the SVN server, then git checkout -b topic
2) git commit some "reference data", before starting some optimization
or code refactoring.
** These reference data are not supposed to find their way to the SVN s=
erver **
Committing such "reference data" is just a convenience because git
does a great job to show how these data may or may not change during
the development process.
3) hack, test, commit ...
3 bis) it may happen that reference data change for some very good
reason (for instance some protocol change)
New reference data are then commited.

back to 3 ...

4) Before merging back to master and commitng to SVN, it is necessary
to remove commits with reference data (git rebase -i --onto master
master topic ...)
5) merge topic branch with master and git svn dcommit

-- end --

It is very easy to forget step 4, and svn commit lots of useless data.

Proposal 1)
* commit reference data with some specific mark in the commit message
(e.g. "NO_SVN")
* use pre-svn-dcommit hook to detect such commits

Proposal 2) (not fully feasable for what I know)
* git svn clone to a bare repo
* clone a working repo from the the bare repo.
* steps 2, 3, maybe 3bis, ... then 4
* push commits to the bare repo, while using pre-receive or update
hook to look for wrong commits, and abort if so.
* use post-receive hook to trigger git svn dcommit

Main drawback for proposal 2 (appart from needing 2 repo instead of
one) is that each time you want to update your working=A0 repo, you hav=
e
to git svn rebase the bare repo, then git pull.

Proposal 2bis)
* add a pre-send hook on the bare repo, and trigger some git svn
rebase with this hook.
I am not sure to see all the potential consequences of such a hook thou=
gh.

All things begin equal, proposal 1 seems to be the easier path, but it
is highly debatable.

--
=46red

ps : I had to resend this email because first attempt included HTML
(sic). Very sorry if you receive it twice.

2011/8/17 Eric Wong <normalperson@yhbt.net>
>
> Junio C Hamano <gitster@pobox.com> wrote:
> > Fr=E9d=E9ric Heitzmann =A0<frederic.heitzmann@gmail.com> writes:
> >
> > > The 'pre-svn-dcommit' hook is called before 'git svn dcommit', wh=
ich aborts
> > > if return value is not zero. The only parameter given to the hook=
 is the
> > > reference given to 'git svn dcommit'. If no paramter was used, ho=
ok gets HEAD
> > > as its only parameter.
> >
> > It appears that this is in the same spirit as the pre-commit hook u=
sed in
> > "git commit", so it may not hurt but I do not know if having a sepa=
rate
> > hook is the optimal approach to achieve what it wants to do.
> >
> > I notice that git-svn users have been happily using the subsystem w=
ithout
> > need for any hook (not just pre-commit). Does "git svn" need an equ=
ivalent
> > of pre-commit hook? If so, does it need equivalents to other hooks =
as
> > well? I am not suggesting you to add support for a boatload of othe=
r hooks
> > in this patch---I am trying to see if this is really a necessary ch=
ange to
> > begin with.
> >
> > Eric, do you want this one?
>
> I'm not sure. =A0I feel hooks should be avoided whenever possible, an=
d
> a git-svn-specific hook for dcommit wouldn't place the same restricti=
on
> as a server-side SVN hook for svn(1) users.
>
> Preventing certain commits from accidentally hitting the SVN server c=
an
> be useful, I think. =A0On the other hand, I'm not sure if people who =
run
> accidental dcommits would remember to the pre-dcommit hook, either.
>
> Perhaps an interactive option for dcommit would be just as useful?
>
> Test cases are required for any new features of git-svn, though.
>
> > > + =A0 system($hook, $head);
> > > + =A0 if ($? =3D=3D -1) {
> > > + =A0 =A0 =A0 =A0 =A0 print "[pre_svn_dcommit_hook] failed to exe=
cute $hook: $!\n";
> > > + =A0 =A0 =A0 =A0 =A0 return 1;
> > > + =A0 } elsif ($? & 127) {
> > > + =A0 =A0 =A0 =A0 =A0 printf "[pre_svn_dcommit_hook] child died w=
ith signal %d, %s coredump\n",
> > > + =A0 =A0 =A0 =A0 =A0 ($? & 127), =A0($? & 128) ? 'with' : 'witho=
ut';
> > > + =A0 =A0 =A0 =A0 =A0 return 1;
> > > + =A0 } else {
> > > + =A0 =A0 =A0 =A0 =A0 return $? >> 8;
> > > + =A0 }
> > > +}
> >
> > Should these messages go to the standard output?
>
> Failure messages should definitely go to stderr.
>
> --
> Eric Wong
