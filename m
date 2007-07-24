From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: when git-rebase -i fails to cherry-pick
Date: Tue, 24 Jul 2007 22:05:10 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070724200510.GA27610@informatik.uni-freiburg.de>
References: <20070723225402.GB22513@informatik.uni-freiburg.de> <Pine.LNX.4.64.0707240005240.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:06:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDQdi-0000Ul-JW
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 22:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761218AbXGXUFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Jul 2007 16:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760778AbXGXUFS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 16:05:18 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:65273 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760099AbXGXUFP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jul 2007 16:05:15 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IDQd7-00035R-3D; Tue, 24 Jul 2007 22:05:13 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l6OK5AFu028001;
	Tue, 24 Jul 2007 22:05:10 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l6OK5Atq028000;
	Tue, 24 Jul 2007 22:05:10 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707240005240.14781@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53635>

Hello Johannes,

Johannes Schindelin wrote:
> > - If a cherry-pick fails, it tells me to resolve my conflicts, 'git=
 add
> >   <paths>' and to do 'git commit -c $sha1id'.
> >=20
> >   But it doesn't tell me, how I continue to rebase after that.
> >=20
> >   'git rebase -i --continue' works.
>=20
> Actually, even "git rebase --continue" works.  And you do not really =
have=20
> to commit, either, just updating your index is fine.  In fact, if you=
 say=20
> "git reset --hard", it will skip the commit.
OK, thanks.

> > - If a cherry-pick of a commit to be squashed fails, the instructio=
n to
> >   do 'git commit -c $sha1id' is wrong, because then I don't get bot=
h
> >   message to squash.
>=20
> Yes, it is a leftover from the bad old days, when this script was cal=
led=20
> edit-patch-series, and I was a rebase hater.
>=20
> In the meantime, somebody on IRC explained to me how rebase works, an=
d=20
> that rebase lovers were quite annoyed not to be able to just resolve =
the=20
> conflicts and "git rebase --continue".
>=20
> I'd appreciate if you prepared a patch with better explanations, and =
also=20
> reviewed the man page, if it is in good shape (and does not lie about=
 the=20
> current behaviour).
It's on my todo list, but not the top item for git.

In the mean-time I found another nuisance:

After doing:

	tmpdir=3D/tmp/repo
	mkdir $tmpdir
	cd $tmpdir
	git init
	for n in one two three four; do echo $n >> file; git add file;
	git commit -m $n; done
	git rebase -i HEAD~3 #squash four onto two

git rebase stops (as expected) when trying to apply four, at this stage
two is already commited.

The conflicting file looks as follows:

	one
	two
	<<<<<<< HEAD:file
	=3D=3D=3D=3D=3D=3D=3D
	three
	four
	>>>>>>> e7fbd8f... four:file

I currently have no idea how to improve this, but I miss the informatio=
n
that the commit *adds* "four" and "three" is only context.

Resolving with:

	echo one > file; echo two >> file; echo four >> file;
	git add file; git rebase --continue

and typing a new log (e.g. two + four) git rebase stops once more (agai=
n
as expected) when trying to apply three, OK, resolving the conflict is
easy (one, two, three, four), git add file, git rebase --continue.

Looking at the resulting log, I have the following:

        zeisberg@cassiopeia:/tmp/repo$ git log --pretty=3Doneline
	145ce01e1cf3f4cb86cd0065c0d0d5b62b399ad4 three
	cd082bca636efca17409be4d871d0971237df06c two + four
	b6b985977db45e314509d94282597c2ff8029d3d two
	15f8cbbb5a452b075b49f3dedbeaeb66668b8025 one

So the request to squash two + four was lost.

I will look at it when I'm done with git-sendemail ...

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

main(){char*a=3D"main(){char*a=3D%c%s%c;printf(a,34,a,34%c";printf(a,34=
,a,34
,10);a=3D",10);a=3D%c%s%c;printf(a,34,a,34,10);}%c";printf(a,34,a,34,10=
);}
