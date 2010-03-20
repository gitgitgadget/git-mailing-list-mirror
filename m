From: Thomas Koch <thomas@koch.ro>
Subject: Re: rethinking patch management with GIT / topgit
Date: Sat, 20 Mar 2010 19:53:34 +0100
Message-ID: <201003201953.34666.thomas@koch.ro>
References: <201003201802.51129.thomas@koch.ro> <20100320174740.GC4535@machine.or.cz>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, vcs-pkg-discuss@lists.alioth.debian.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Mar 20 19:53:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3o4-0005qo-3k
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 19:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab0CTSxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 14:53:48 -0400
Received: from koch.ro ([88.198.2.104]:43215 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab0CTSxs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Mar 2010 14:53:48 -0400
Received: from 138-229.76-83.cust.bluewin.ch ([83.76.229.138] helo=jona.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1Nt3km-0005Ox-MQ; Sat, 20 Mar 2010 19:50:32 +0100
User-Agent: KMail/1.12.4 (Linux/2.6.32-2-amd64; KDE/4.3.4; x86_64; ; )
In-Reply-To: <20100320174740.GC4535@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142735>

Petr Baudis:
> > - it pollutes the patch branches with metadata (.topmsg, .topdeps)
>=20
> I'd like to single this out - this is a very arbitrary decision and h=
as
> its distinct pros and cons compared to alternative approaches, and wa=
s
> not taken lightly. It wouldn't be that difficult to go in a different
> way and it's not a fundamental limitation.
It's also the most minor problem I see, rather a matter of taste.

> > - AFAIK nobody has solved the problem of managing different patchse=
ts
> > with tg
>=20
> Why not just manage them in separate repositories? If you want to pic=
k
> patches between patchsets, that should be easily posible through remo=
tes.
You mean having multiple local working directories per project? That's =
not=20
nice. If you also work on the project with an IDE, it'd most probably m=
ean=20
setting up the same project multiple times.

>   I agree that topgit really sucks in many areas. :) While it is usab=
le
> in practice if you know what you are doing, in some aspects it never =
got
> out of the proof-of-concept stage.
Thank you for not taking it personaly! :-)

> > 1) merge commits to save history
> >
> > git allows the free creation of merge commits with an arbitrary con=
tent
> > tree. So we can create an octupus merge combining all patch-branche=
s
> > while the content of this merge can contain meta data about a patch=
set
> > instead of the content of the merged commits.
> > Such a merge commit thus provides a pointer to all the history of a=
ll
> > patches and can contain all metadata about the merged patch branche=
s.
> > Pushing only a branch or tag with this commit to a central reposito=
ry
> > thus pushes all the history of all contained patches.
>=20
>   But how is this different from TopGit's approach? TopGit doesn't us=
e
> octopus merges for various reasons (I mainly guess since I was too la=
zy
> to implement that), but that's more of an implementation detail than
> anything conceptual.
Maybe I didn't make clear that the commits on the patchset branch shoul=
d not=20
necessarily contain the merged content of all patches. The role of the =
merges=20
is solely to keep pointers to the commits making up the patch branches.
Now that you're asking there may however be a similarity to topgit in t=
hat you=20
can have one topgit controlled branch that combines all topgit branches=
=20
belonging to the same patchset.
However there still remain some differences:

- in tg you need to push all tg branches while in my approach you'd nee=
d to=20
push only one branch per patchset
- As far as I understand tg, all commands are repository global while f=
or the=20
Debian packaging use case you'd need patchset local commands:
  - tg export <patchset>
    export <patchset> as a quilt series

  - tg summary <patchset>
    gives summary information for the branches of <patchset>

  - tg delete <patchset> <branch>
    removes <branch> from <patchset>. However old history of <branch> i=
s still=20
recorded in the history of the <patchset>-branch

  - tg add <patchset> <branch>
    adds <branch> to <patchset>
    (The question is open, where to record the merge resolution of all=20
patches)

  - tg recreate <patchset> <newbase> <new patchset name>
    Creates a new patchset with root <newbase> by creating new patch br=
anches=20
for each patch branch in <patchset>
    This command is useful if you need to keep the old patchset to main=
tain an=20
older version of your Debian package.
   =20
> > 2) collapse / expand branches
> >
> > Managing a Debian package in stable, unstable and experimental can
> > quickly doom you to manage at least three different patchsets with
> > possibly three different roots. The list of branches grows in the
> > douzens. Which branches belong to which patchset? Which branches ar=
e
> > already pushed or pulled? It may be an advantage to see only some m=
ain
> > branches and the branches of one patchset I'm currently working on.
> > The tool I propose would manage each patchset in one branch per pat=
chset.
> > This branch has two roles:
> > - keep the metadata of the patchset as files in the content tree
> > - keep pointers to the top of the patch-branches in the parent poin=
ters
> > of the commit
> > With the help of such a patchset-metadata-branch I can:
> > - delete the patch-branches of one patchset while the commits are k=
ept
> > save - recreate the patch-branches of one patchset
>=20
>   The disadvantage is that you will have to invent a lot of arbitrary
> metadata and wide range of commands to manipulate and work with this
> metadata, all to accomplish something that _is actually one of the ma=
in
> Git functions to do_!
I don't see this. What do I miss? All metadata I'd need to manage is:
- one file with the name of each branch, it's last commit and the names=
 of its=20
dependencies (the root of the patchset, if empty)
- one message file for each patch
- the root of the patchset

The example commands given above would manipulate or read the patchset =
branch=20
in the background much like pristine-tar does it with its metadata bran=
ch.
=20
>   Wouldn't it be better to do the collapsing/expanding instead, e.g.
> have a convention for patchset/stage branch tying up all patchset/*
> branches, and an alias that lists only */stage branches and another t=
hat
> lists only patchset/* minus patchset/stage branches.
So you propose not to delete/recreate the patch branches but to provide=
 extra=20
commands to list only the desired subset of branches? This would still =
mean=20
that I'd see douzens of patch branches in gitweb and that I't need to p=
ush=20
douzens of branches to my co-packagers. - That doesn't solve it for me.
It may also be of interest, that Guido G=FCnther, the author of git-
buildpackage[1] wrote a command git-pq to "maintain debian/patches on a=
 patch=20
queue branch". - There seems to be a need to have few branches and that=
 it=20
seems to be practical to create and destroy patch branches in your work=
flow.

[1] https://honk.sigxcpu.org/piki/projects/git-buildpackage/

> > Is my explanation understandable? Could this approach work or did I=
 miss
> > something? Who has time to implement it (GSOC?)?
>=20
>   It's especially not clear at all whether you propose to start over =
or
> just make two improvements to TopGit, and if the former, how would yo=
ur
> approach differ from TopGit in all the other aspects. It's all a bit
> ambiguous.
I hope I managed to make it clearer this time. I believe my proposals a=
re=20
incompatible to topgit and thus would require a new project from scratc=
h.=20
However it may well be that some code from topgit could be reused.

Best regards,

Thomas Koch, http://www.koch.ro
