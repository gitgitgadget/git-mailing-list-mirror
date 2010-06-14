From: Johan Herland <johan@herland.net>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Tue, 15 Jun 2010 01:59:42 +0200
Message-ID: <201006150159.42680.johan@herland.net>
References: <cover.1276059473.git.hvoigt@hvoigt.net>
 <201006131959.43356.johan@herland.net> <20100614170222.GB1389@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jun 15 01:59:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOJZI-0000tt-KT
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 01:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740Ab0FNX7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 19:59:46 -0400
Received: from smtp.getmail.no ([84.208.15.66]:50197 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab0FNX7p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 19:59:45 -0400
Received: from get-mta-scan03.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4100DJY3ZJV170@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 15 Jun 2010 01:59:43 +0200 (MEST)
Received: from get-mta-scan03.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 810BB1EEEE3F_C16C26FB	for <git@vger.kernel.org>; Mon,
 14 Jun 2010 23:59:43 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan03.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 264E51EEC20B_C16C26FF	for <git@vger.kernel.org>; Mon,
 14 Jun 2010 23:59:43 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L4100L333ZJ8L10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 15 Jun 2010 01:59:43 +0200 (MEST)
User-Agent: KMail/1.13.3 (Linux/2.6.33-ARCH; KDE/4.4.4; x86_64; ; )
In-reply-to: <20100614170222.GB1389@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149148>

On Monday 14 June 2010, Heiko Voigt wrote:
> On Sun, Jun 13, 2010 at 07:59:43PM +0200, Johan Herland wrote:
> > On Saturday 12 June 2010, Heiko Voigt wrote:
> > A better solution would be, to put it generally: Given a submodule
> > being part of a superproject conflict, if one of the candidate
> > submodule SHA1s is is a descendant of _all_ the other submodule SHA=
1
> > candidates, then choose that SHA1 as the proposed resolution (but
> > please leave the index entry "unmerged", so that the resolution mus=
t
> > be confirmed by the user).
>=20
> Is there currently any logic to support a "suggested" merge resolutio=
n
> in git.git? I am not that familiar with code base yet and I do not th=
ink
> that I have seen something like that. Is it done somewhere already?

In the case of a regular file, you can replace the default working tree=
=20
version (the one with conflict markers) by a version containing your=20
suggested merge resolution, but NOT add that version to the index, so t=
he=20
index still thinks the file is unmerged. You then 'git add' the file to=
=20
acknowledge the suggested resolution.

In the case of submodules, you would check out the suggested version of=
 the=20
submodule, but not add its SHA1 to the superproject index. Again, the u=
ser=20
acknowledges the suggested resolution by 'git add'ing the submodule.

My point is that when Git tries to suggest merge resolutions, it should=
=20
purposefully NOT add these to the index, so that the user HAS to acknow=
ledge=20
them. This is similar to the default behaviour of 'git rerere' which=20
resolves your conflicts automatically, but does not touch the correspon=
ding=20
"unmerged" index entries, so that you manually have to 'git add' the re=
sult.

> > This removes all the "stable" branch magic from your patch. All you
> > need to look at are the candidate SHA1s and their relationship in t=
he
> > commit graph. No refs involved.
> >=20
> > In the A->B vs. A->C case above, we would see that C is a descendan=
t of
> > B, and we would therefore choose C as a suggested conflict resoluti=
on,
> > which IMHO is a much better choice than D.
> >=20
> > I still don't want to add a lot of auto-resolving cleverness to Git=
, as
> > it inevitably _will_ choose incorrectly sometimes, and in those
> > situations it will be much more confusing than if it didn't choose =
at
> > all.
>=20
> I see your point. But nevertheless there is a specific workflow I tar=
get
> to support which is not supported by your approach:
>=20
> Lets assume Alice creates a feature branch feature_a for her developm=
ent
> and needs to modify the submodule and creates a branch there as well.=
 At
> the same time Bob develops feature_b and also needs changes in the
> submodule and so he creates a feature branch there as well.
>=20
> Assume we now have the following history in the submodule:
>=20
>   B---C---D         [feature_a]
>  /         \
> A---E---F---G---K   [master]
>      \         /
>       H---I---J     [feature_b]
>=20
> Now during the development of her branch Alice would link D in the
> superproject as it is the tip of her branch. Bob would do the same an=
d
> link to J as his tip. Now Alice sends out her branch to the reviewers
> and after everybody is happy with it the maintainer merges her branch
> first. The superproject links to D.

No. The superproject would get a conflict between the A->D and A->F upd=
ates=20
of the submodule. The correct resolution would be to go into the submod=
ule,=20
do the merge to produce G, and then record this as the correct merge=20
resolution in the superproject.

You want Git to do this automatically for you, whereas I think that Git=
=20
should not be that "clever", because there are situations (as I've=20
demonstrated previously in this thread) where the "cleverness" would do=
 The=20
Wrong Thing.

> Now Bob does the same and the
> maintainer wants to merge his branch and gets a merge conflict becaus=
e D
> and J do not have a parent/children relationship.

Well, s/D/G/, but your point still stands. And the correct resolution i=
s, of=20
course, to merge G and J to produce K, and then record K in the superpr=
oject=20
as the correct merge resolution.

Again, the question is whether Git should do these submodule merges=20
automatically, or not.

> I think this is a fairly natural pattern which evolves from the use o=
f
> feature branches in git. So I would like to make git behave naturally
> for this workflow and automatically merge.

Please keep in mind that your workflow is but one, and Git has to suppo=
rt a=20
wide variety of different workflows without breaking down.

It actually seems to me that - in your workflow scenario, where the=20
submodule seems to be fairly tightly coupled to the superproject - you =
would=20
be better off using branch-tracking submodules (recently discussed in t=
he=20
thread called 'RFC: Making submodules "track" branches').

When using branch-tracking submodules, Alice would configure the submod=
ule=20
to track the "feature_a" branch, while Bob would configure the submodul=
e to=20
track the "feature_b" branch. When merging these branches, the correct =
merge=20
resolution would be (after having merged the submodule feature branches=
 back=20
into the submodule "master") to track the "master" branch in the submod=
ule.

When merging the two feature branches back into "master" there would (i=
n=20
addition to the conflicted submodule entry) be conflicts in the .gitmod=
ules=20
file on which submodule branch to track (I'm following =C6var's proposa=
l=20
here), and the resolution of _that_ conflict would specify which submod=
ule=20
branch/version to use in the resolved merge.

Now, in your proposal, you would have an _additional_ config variable f=
or=20
controlling which submodule branch is equivalent to "master" in the abo=
ve=20
example. If this branch were to be different from the "tracked" branch =
(as=20
defined in =C6var's proposal), you would be in the deeply confusing sit=
uation=20
of having the merge resolved to the tip of one branch, while you've tol=
d the=20
submodule to track a _different_ branch. The only thing that makes sens=
e=20
would be for these two variables to always be identical, at which point=
 you=20
should simply eliminate one of them.

I guess what I'm getting at (sorry for taking a while to get here) is t=
hat=20
you could maybe solve your problem by a combination of what I suggested=
 in=20
my previous mail, plus the use of branch-tracking submodules. There are=
=20
still some things to be worked out here, but I don't believe adding an=20
almost-but-not-quite-submodule-branch-tracking option is the best way t=
o go.

> Now your point is that master could be wrong and you are right, but
> normal merges can go wrong in a similar way. Just imagine this:
>=20
> Alice adds a parameter to the static function somefunc() and changes =
all
> callsites of it in her branch. Independently Bob writes new code in
> his branch that uses somefunc() with the old signature. When both
> branches are merged git has no chance of doing it right and the code
> will not compile. So even normal merging is always a little heuristic=
=2E
> Question is: How well does the heuristic perform in practise.

True, but I don't necessarily accept that one sometimes-wrong heuristic=
=20
justifies another sometimes-wrong heuristic. Follow that logic, and we =
can=20
pile on heuristics until we almost always get something wrong...

> > Ok, so you can configure exactly which branch(es) you consider stab=
le.
> > I'd still much rather prefer the approach I outlined above, which d=
oes
> > away with all the "stable" branch magic, and only considers the com=
mit
> > ancestry directly.
>=20
> Ok what do you think about combining both approaches: If no stable
> branches are configured we default to your strategy and if the user
> wants some magic (I mean isn't that what git is all about: magic)
> configuring stable branches will enable git to resolve conflicts like
> the ones I described above.

=46WIW, IMHO Git is NOT about magic at all. It even says so at the top =
of the=20
git(1) manual page: "git - the stupid content tracker". And both Junio =
and=20
Linus have repeatedly argued how Git purposefully only auto-resolves th=
e=20
_simple_ cases, and leaves the _hard_ cases to the user, since trying t=
o be=20
clever about the hard cases inevitably leads to more confusion and insa=
nity.

In this case, your scenario/proposal just about crosses into what I con=
sider=20
the _hard_ space, which is why I'm critical of the cleverness.

As for combining both approaches (subject to some config option), I gue=
ss=20
that could work, but I'd certainly like to see a significant amount of=20
support for your proposal before we go there.

> My feeling is that in practise automatic merging into stable branches
> will work well and the cases of failure will be neglectable to not
> happening at all. So my approach would be to go ahead, implement the
> strategy and let people play around with it so we can collect some re=
al
> life data whether it is helping or making matters worse.

=46eel free to post the patches, if you can spend the time making them.=
 So=20
far, there's been no other feedback in this thread, so maybe I'm alone =
in my=20
worries...


Cheers,

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
