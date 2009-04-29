From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Thu, 30 Apr 2009 00:37:47 +0200
Message-ID: <20090429223747.GG15420@raven.wolf.lan>
References: <20090427201251.GC15420@raven.wolf.lan> <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com> <20090428223728.GE15420@raven.wolf.lan> <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com> <20090429160129.GF15420@raven.wolf.lan> <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 00:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIRO-0000y2-Oc
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759250AbZD2Win convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 18:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762077AbZD2Wim
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:38:42 -0400
Received: from quechua.inka.de ([193.197.184.2]:34111 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759265AbZD2Wij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:38:39 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LzIQG-0005rl-Kq; Thu, 30 Apr 2009 00:38:36 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 2E50C2CC85; Thu, 30 Apr 2009 00:37:47 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117969>

Thanks for your great explanations, Avery!

On Wed, Apr 29, 2009 at 02:13:29PM -0400, Avery Pennarun wrote:
> On Wed, Apr 29, 2009 at 12:01 PM, Josef Wolf <jw@raven.inka.de> wrote=
:
> > On Tue, Apr 28, 2009 at 11:19:51PM -0400, Avery Pennarun wrote:
> >> Okay, I think I'm following you. =A0And I think the difficulty of =
your
> >> solution will depend on how important it is to cherry-pick each
> >> individual commit from each repo vs. just merging everything as a
> >> batch.
> >
> > I've already done the cherry-picking.
>=20
> So you're saying that from now on, *all* changes from *both* branches
> need to be integrated in both directions?

Exactly.  Those three commands:

  git diff first-svn        second-svn  # this should be the "private" =
diff
  git diff first-svn/trunk  first-svn   # what my cherry-picking has ch=
anged
                                        # (and waits for push) in first=
-svn
  git diff second-svn/trunk second-svn  # what my cherry-picking has ch=
anged
                                        # (and waits for push) in secon=
d-svn

show me _exactly_ what I want them to be.  The manual synchronizations
which were done in the past are resolved now.  But I can't find the way
how to put the result of this cherry-picking back into the svn reposito=
ries

> If so, you're done with cherry-picking.  If not, you're not.

Yeah, I think I'm done with it.  That's why I tried to "git merge -s ou=
rs"
to tell git about the good news ;-)

> > =A0Basically, I've done this:
> >
> > =A0# first, move patches from second-svn to first-svn
> > =A0git checkout first-svn
> > =A0git svn rebase
> > =A0git cherry-pick sha1 # repeat as needed
> > =A0git merge -s ours second-svn
> >
> > =A0# Now, the other way around
> > =A0git checkout second-svn
> > =A0git svn rebase
> > =A0git cherry-pick sha1 # repeat as needed
> > =A0git merge -s ours first-svn
> >
> > The first git-svn-rebase after the merge causes all the (already pi=
cked)
> > commits from the other branch to be pulled into the current branch.
> > Adding the --no-ff option does not help. =A0Omitting the cherry-pic=
king
> > does not help, either.
>=20
> Hmm, I don't see any 'git svn dcommit' in there.  The steps I listed
> referred to dcommit, but explicitly left out calls to 'git svn
> rebase'.

Ah!  I thought I _have_ to "git svn rebase" before I dcommit, like I ne=
ed
to "svn update" before I can do "svn commit".

> I think it's likely that your problems stem from this. The git svn
> documentation refers to the 'git svn rebase' operation a lot, but it'=
s
> only really useful for one thing: linearizing history to make it look
> (to svn) like git was never involved. This is handy for people who
> want to use git at work without their boss knowing about it, but it
> *loses information* and will mess up future merges.

OK, I'll try without rebase.

> In general, 'git svn rebase' should be avoided for all the same
> reasons that 'git rebase' should be avoided.  They're both great when
> used carefully, but they shouldn't be your main day-to-day activity.

Unfortunately, all the howto's I could find recommend exactly that:
git-svn-rebase for getting commits from svn and dcommit for sending
commits to svn.

> Unfortunately git svn encourages you to use rebase in your day-to-day
> activity... but the workflow I'm talking about actually avoids this
> problem completely.  What you want most of the time is really just
> 'git svn fetch'. and 'git svn dcommit'.
>=20
> I think I was also a bit too offhand in my previous email when
> expanding my suggestion to work with multiple svn hosts.  The cleares=
t
> way to do this is with three branches:
>=20
>   - 1 remote branch: git-svn-1
>   - 1 remote branch: git-svn-2
>   - 1 local branch: master

I will try this one.  But this will take a while, since my
cherry-picking was done criss-cross.  Thus, I need to "rebase"
the cherries now to get them onto a single branch.  Is there
a simple way to do that or do I have to redo the cherry-picking from
scratch?

> So the steps are something like this.  (Again, WARNING: I'm not
> running these as I type them, so I could be screwing up just about
> anything.)
>=20
> Getting started:
>=20
>   git checkout master
>   ... Use 'git svn fetch' to update git-svn-1 and git-svn-2 ...
>   ... git merge/cherry-pick what you want from git-svn-1 and
> git-svn-2.  ALWAYS use --no-ff if using git merge
>   git merge --no-ff -s ours git-svn-1
>   git merge --no-ff -s ours git-svn-2
>     # now master has everything from both svn repositories

I guess I need

   git checkout git-svn-1; git svn dcommit
   git checkout git-svn-2; git svn dcommit

at this point to push the synchronization work to the svn repositories?

> >From now on:
>=20
>   # Update git-svn-1 with the latest master
>   git checkout git-svn-1
>     # since git-svn-1 is a remote branch, you now have a detached HEA=
D
>   git merge --no-ff master
>   git svn dcommit
>=20
>   # Update git-svn-2 with the latest master
>   git checkout git-svn-2
>     # since git-svn-2 is a remote branch, you now have a *different*
> detached HEAD
>   git merge --no-ff master
>   git svn dcommit
>=20
>   # Update master with the latest svn
>   git checkout master
>     # HEAD is now attached to master
>   git merge --no-ff git-svn-1
>   git merge --no-ff git-svn-2
>     # no need for '-s ours' in the above merge, as no rebasing means
> no merge history was lost

Looks reasonable.

> >> At Versabanq, we're using git for a bunch of stuff including our
> >> autobuilder (http://github.com/apenwarr/gitbuilder) and my own
> >
> > Interesting project. =A0One question: the README mentions that the
> > gitbuilder as capable to update itself. =A0But I can not actually s=
ee
> > this functionality in the scripts. =A0Is that just a typo or am I m=
issing
> > something?
>=20
> I guess you're reading the line that says, "Now that your gitbuilder
> is working, you probably want to have it continue
> to update itself automatically."

Exactly.

> This is actually talking about
> *running* itself automatically, as in "upating the build results to
> the latest copy of your project."  I can see how it's a very unclear
> word to use there.  Thanks for the feedback.

OK..

> >> As long as you "git config merge.summary true" (to make the merge
> >> commit list all the commits it's merging)
> >
> > How does this option influence the merge operation? =A0Or is this m=
eant
> > to provide additional information to the person who does the next m=
erge?
>=20
> When you *merge* (as opposed to rebase or cherry-pick) into an svn
> branch, you only create a *single* svn commit that contains *all* the
> changes.  The above config setting just makes the merge commit contai=
n
> a list of all the commits it contains.

But git will not use this information in any way, AFAIK.  So this infor=
mation
is only for the person who will do the next merge?

> >> Now, your problem is a little more complex, because it sounds like
> >> people are checking in two types of things on both sides: private
> >> things and public things. =A0So if you want *only* the private thi=
ngs,
> >
> > I want both. =A0The difference is that I (usually) want to pull the=
 public
> > things unmodified, while I want to generalize/localize the private =
things.
> > So when merging the private part, I would not want to pick the spec=
ific
> > entries. =A0But I still want to pick the _structure_ (possibly remo=
ving or
> > modifying the localized entries).
>=20
> If you're going to be mangling things so thoroughly, then you might
> just have to resort to cherry-picking everything one by one from one
> branch to the other.  It doesn't sound very fun, but if other people
> are being so uncooperative by mixing public and private stuff in thei=
r
> repositories, there's no way I can see to automate it anyhow.

The people are not uncooperative.  It is just that there's no way to
completely separate the public and private content.  For example, the
private part of my apache config looks like this (somewhat simplified):

    &set_conf (apache =3D> {
        servername =3D> "my.host.org",
        davlock =3D> "/m/a/dav/lock",
        confdir =3D> "/m/a/etc/apache",
        httpdir =3D> "/m/b/httpd",
        docroot =3D> "/m/b/httpd/htdocs",
        svndir  =3D> "/m/b/repos/svn",
        gitdir  =3D> "/m/b/repos/git",
        vhosts =3D> {
            "*:80"=3D> {
                downloads =3D> {
                    "my-debian-repos"=3D>["/m/b/lib/my-debian",
                },
            },
            "*:443"=3D> {
                docroot =3D> "/m/b/httpd/htdocs",
                downloads =3D> {
                    "kdb"      =3D> ["/m/b/lib/kdb/SRC",   "Kdb downloa=
d"],
                    "kdbdemo"  =3D> ["/m/b/lib/kdbdemo",   "Kdbdemo dow=
nload"],
                    "pictures" =3D> ["/m/b/Pictures",      "Pictures"],
                },
                cgis =3D> {
                    "svn"  =3D> ["/m/l/svn/cgi", "Svn repos administrat=
ion"],
                    "misc" =3D> ["/m/a/cgi", "Misc cgi scripts"],
                },
                svn =3D> { # FIXME: svn, repos
                    "ab"            =3D> ["Ab repository"],
                    "misc"          =3D> ["Subversion Repository"],
                    "pmisc"         =3D> ["Private Subversion Repositor=
y"],
                },
                git =3D> {
                    "test" =3D> ["Git test repos"],
                },
                revproxies =3D> {
                    "/test/"   =3D> ["http://localhost:3000/railstest/"=
],
                    "/foobar/" =3D> ["http://foo.bar.org:8001/"],
                }
            },
        },
    });

=46rom this information, the public part knows how to generate the apac=
he
config.  Other people are not interested which locations are defined
here,  But they _are_ interested in the layout how this (perl) structur=
e=20
looks like.  So I need to strip my localizations and provide the
structure as a template for other people to fill in.  Of course, this
leads to more conflicts in the future every time the layout is changed.

> If you're using cherry-pick for everything, there's no reason to use
> tricks like 'merge -s ours'.  Just leave out the merging entirely and
> don't pretend that what you're doing is merging; it isn't.  (You stil=
l
> don't need 'git svn rebase' for anything.  Just checkout the branch
> you want to change, cherry-pick stuff into it, and 'git svn dcommit'
> if appropriate.)

But then I have to do the book-keeping (what was already picked in whic=
h
direction) by myself?

> If the situation ever changes, you can always do one last 'merge -s
> ours' and mark the histories as combined.  Then future merges will
> bring in any future changes.

OK
