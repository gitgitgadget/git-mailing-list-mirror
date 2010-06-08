From: Johan Herland <johan@herland.net>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 08 Jun 2010 09:12:31 +0200
Message-ID: <201006080912.31448.johan@herland.net>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 09:12:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLszK-0004nL-3E
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 09:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282Ab0FHHMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 03:12:37 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34569 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979Ab0FHHMg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 03:12:36 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3O002HUPCWJYB0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Jun 2010 09:12:32 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 845911EA5612_C0DED60B	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 07:12:32 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id C96761EA3217_C0DED5FF	for <git@vger.kernel.org>; Tue,
 08 Jun 2010 07:12:31 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L3O00FD2PCV1020@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Jun 2010 09:12:31 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148646>

On Tuesday 08 June 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Fri, May 21, 2010 at 16:10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com>=20
wrote:
> > Add a $toplevel variable accessible to `git submodule foreach`, it
> > contains the absolute path of the top level directory (where
> > .gitmodules is).
> >=20
> > This makes it possible to e.g. read data in .gitmodules from within
> > foreach commands. I'm using this to configure the branch names I wa=
nt
> > to track for each submodule:
> >=20
> >    git submodule foreach 'git checkout $(git config --file
> > $toplevel/.gitmodules submodule.$name.branch) && git pull'
> >=20
> > For a little history: This patch is borne out of my continuing figh=
t
> > of trying to have Git track the branches of submodules, not just th=
eir
> > commits.
> >=20
> > Obviously that's not how they work (they only track commits), but I=
'm
> > just interested in being able to do:
> >=20
> >    git submodule foreach 'git pull'
> >=20
> > Of course that won't work because the submodule is in a disconnecte=
d
> > head, so I first have to connect it, but connect it *to what*.
> >=20
> > For a while I was happy with this because as fate had it, it just s=
o
> > happened to do what I meant:
> >=20
> >    git submodule foreach 'git checkout $(git describe --all --alway=
s)
> > && git pull'
> >=20
> > But then that broke down, if there's a tag and a branch the tag wil=
l
> > win out, and I can't git pull a branch:
> >=20
> >    $ git branch -a
> >    * master
> >      remotes/origin/HEAD -> origin/master
> >      remotes/origin/master
> >    $ git tag -l
> >    release-0.0.6
> >    $ git describe --always --all
> >    release-0.0.6
> >=20
> > So I figured that I might as well start tracking the branches I wan=
t
> > in .gitmodules itself:
> >=20
> >    [submodule "yaml-mode"]
> >        path =3D yaml-mode
> >        url =3D git://github.com/yoshiki/yaml-mode.git
> >        branch =3D master
> >=20
> > So now I can just do (as stated above):
> >=20
> >    git submodule foreach 'git checkout $(git config --file
> > $toplevel/.gitmodules submodule.$name.branch) && git pull'
> >=20
> > Maybe there's a less painful way to do *that* (I'd love to hear abo=
ut
> > it). But regardless of that I think it's a good idea to be able to
> > know what the top-level is from git submodule foreach.
>=20
> This patch is getting merged to next as per the June 2 What's cooking
> in Git post.
>=20
> But I wonder how evil it would be to expand this this idea to allow
> the porcelain to track branches instead of commits at the porcelain
> level.
>=20
> That /could/ work like this. The tree format would be exactly the
> same, i.e. bound to a specific commit:
>=20
>     $ git ls-tree HEAD | grep subthing
>     160000 commit 37469ca3fae264e790e4daac0fa8f2ddf8039c93  subthing
>=20
> *But*, the user could add some new submodule.*.* config key/values
> that specify what branch the module should track and whether 'git
> pull' on the master project should also pull new changes (from the
> 'newstuff' branch) into the submodule:
>=20
>     [submodule "subthing"]
>         path =3D subthing
>         url =3D git://github.com/avar/subthing.git
>         branch =3D newstuff
>         update-on-pull =3D true

I certainly like the idea, and so far this is the best way I've seen fo=
r=20
associating submodules to branches. I don't like the last "update-on-pu=
ll"=20
option, though. It should probably be somewhat more general set of=20
options/triggers with a richer set of values than true/false. What abou=
t=20
something like this?

    [submodule "subthing"]
        path =3D subthing
        url =3D git://github.com/avar/subthing.git
        branch =3D newstuff
        on-pull =3D checkout,pull
        on-checkout =3D checkout
        on-commit =3D ignore (or commit?)
        ...

See below for more discussion...

> Coupled with .gitignore this would allow for SVN-like externals that
> always track the latest version of upstream, but it'd all be done on
> the porcelain side.
>=20
> The checked out copy wouldn't match the commit in the tree, but the
> user could still git add && git commit it to record the new commit in
> the master repository history.
>=20
> The lack of this ability seems to be a fairly common complaint about
> submodules in Git, that you always have to do something in the parent
> project to update the submodules, even if you don't care about
> specific revisions, or the ability to roll back.
>=20
> I couldn't find a prior discussion of this on the list, maybe this ha=
s
> been beaten to death already.

There are a lot of non-trivial challenges when you want to aggregate se=
veral=20
submodule operations into a single "toplevel" command. Here are some of=
f the=20
top of my head:

- When submodule pulls result in conflicts, these must be presented to =
the=20
user in a way that's simple and straightforward for the user to resolve=
=2E

- When switching branches in the superrepo, you sometimes also want to=20
switch branches in the submodule. This is signalled by changing the=20
submodules.subthing.branch variable in .gitmodules between the two bran=
ches.=20
However, it means that the submodule's update/pull operation must also =
be=20
done on 'checkout' in the superrepo.

- How to handle local/uncommitted (staged or unstaged) modifications in=
 a=20
submodule when pulling or switching branches in the superrepo? The righ=
t=20
answer here is probably to do the same as in the no-submodule case, i.e=
=2E to=20
refuse if it would clobber/conflict with the local modifications.

- When you track submodule branches instead of commits, the actual comm=
it=20
referenced in the superrepo is no longer as important (provided it's pa=
rt of=20
the ancestry of the submodule branch you're tracking). However, diff/st=
atus=20
will still list the submodule as changed because you checked out a diff=
erent=20
commit from what Git has recorded. This raises two concerns: (1) What=20
_should_ be considered "changed" from the diff/status perspective when=20
tracking submodule branches? and (2) When do you update the commit refe=
rence=20
in the submodule? "never" would work (since you're checking out a diffe=
rent=20
commit anyway), "always" would also work (for the same reason), but wou=
ld=20
litter the superrepo history with submodule updates. There may be a bet=
ter=20
alternative somewhere in between.

- If you want to give the illusion of "one big repo" then maybe it shou=
ld=20
also be possible to trigger submodule commits from a superrepo commit? =
(i.e.=20
having a single toplevel "git commit" also trigger commits in submodule=
s).=20
Some users will want to specify the commit message for each submodule=20
separately (IMHO the better approach), while some will want to give onl=
y one=20
commit message that is reused in every submodule commit.

- As always with submodules, keep the case of nested submodules in mind=
=2E

There are probably more issues that escape me now...

Thanks for resurrecting the discussion.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
