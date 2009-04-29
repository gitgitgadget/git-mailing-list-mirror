From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Wed, 29 Apr 2009 18:01:30 +0200
Message-ID: <20090429160129.GF15420@raven.wolf.lan>
References: <20090427201251.GC15420@raven.wolf.lan> <32541b130904281353k572fed5la468de65f73ccd19@mail.gmail.com> <20090428223728.GE15420@raven.wolf.lan> <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 18:11:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzCNf-00052Y-Kj
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 18:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757755AbZD2QKq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 12:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757258AbZD2QKq
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 12:10:46 -0400
Received: from quechua.inka.de ([193.197.184.2]:58182 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090AbZD2QKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 12:10:45 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1LzCMu-0005Lg-34; Wed, 29 Apr 2009 18:10:44 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
	id 1F8C5740D5; Wed, 29 Apr 2009 18:01:30 +0200 (CEST)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <32541b130904282019n4b930f80g1ed22b2dde22510a@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117902>

Thanks for your answer, Avery!

On Tue, Apr 28, 2009 at 11:19:51PM -0400, Avery Pennarun wrote:
> On Tue, Apr 28, 2009 at 6:37 PM, Josef Wolf <jw@raven.inka.de> wrote:
> > Currently, there exist multiple independent repositories (for secur=
ity
> > reasons). =A0In the past, the repositories were "synchronized" manu=
ally.
> > So technically, the repositories have no common history (at least n=
ot
> > in svn's metadata). =A0But the contents are actually rather "simila=
r",
> > since they were synchronized multiple times in the past.
> >
> > In the long term, I'd like to move everything completely to git. =A0=
That
> > would make it much easier to move changes from one repos to the oth=
er
> > while keeping the (intended) differences in the policy.
> >
> > So my first goal is to bring the contents into sync. =A0The next st=
ep would
> > be to create a "reference" (the official) git repository, which can=
 be
> > cloned by the administrations to create their localized repositorie=
s.
> >
> > In the meantime, I need a way to synchronize the contents from time=
 to
> > time. =A0I guess it will take some time to create the official repo=
s and
> > get used to the work flow.
>=20
> Okay, I think I'm following you.  And I think the difficulty of your
> solution will depend on how important it is to cherry-pick each
> individual commit from each repo vs. just merging everything as a
> batch.

I've already done the cherry-picking.  Basically, I've done this:

  # first, move patches from second-svn to first-svn
  git checkout first-svn
  git svn rebase
  git cherry-pick sha1 # repeat as needed
  git merge -s ours second-svn

  # Now, the other way around
  git checkout second-svn
  git svn rebase
  git cherry-pick sha1 # repeat as needed
  git merge -s ours first-svn

The first git-svn-rebase after the merge causes all the (already picked=
)
commits from the other branch to be pulled into the current branch.
Adding the --no-ff option does not help.  Omitting the cherry-picking
does not help, either.

To be honest, I do not understand this behavior at all.  I thought
"-s ours" should mark the other branch as "already merged".  IMHO, this
should prevent future merges from pulling those commits again.  But
this seems not to be true: git-svn-rebase tries to apply them _again_,
causing almost everything to conflict.

> At Versabanq, we're using git for a bunch of stuff including our
> autobuilder (http://github.com/apenwarr/gitbuilder) and my own

Interesting project.  One question: the README mentions that the
gitbuilder as capable to update itself.  But I can not actually see
this functionality in the scripts.  Is that just a typo or am I missing
something?

> Yes, it is possible to rebase everything from git onto an svn branch,
> and then git svn dcommit it.

AFAICS, this is the preferred work flow of git-svn.

> However, in my experience, this is
> fairly nasty (and it also tries to linearize non-linear history, whic=
h
> is just messy).  What we've been doing lately is just merging all
> changes from git into the svn branch as a single commit:
>=20
>    git checkout git-svn
>    git merge --no-ff mybranch   # --no-ff prevents git-svn from
> crazily linearizing things
>    git svn dcommit
>=20
>    git checkout mybranch
>    git merge git-svn

How would this be changed if the commits are coming from the other svn
repo instead of directly from git?

So should I replace all my "git cherry-pick sha1" by corresponding
"git merge -s ??? --no-ff sha1" commands?

> As long as you "git config merge.summary true" (to make the merge
> commit list all the commits it's merging)

How does this option influence the merge operation?  Or is this meant
to provide additional information to the person who does the next merge=
?

> and you merge frequently
> enough, this is reasonably painless.  You end up with a lot of merge
> commits, but the git history is recording everything fully, so if you
> want to throw away svn someday, you can just go ahead.

Sounds good, but I still don't get it :-)  Can you provide a more
verbose example of the workflow?

> Now, your problem is a little more complex, because it sounds like
> people are checking in two types of things on both sides: private
> things and public things.  So if you want *only* the private things,

I want both.  The difference is that I (usually) want to pull the publi=
c
things unmodified, while I want to generalize/localize the private thin=
gs.
So when merging the private part, I would not want to pick the specific
entries.  But I still want to pick the _structure_ (possibly removing o=
r
modifying the localized entries).

> you're going to have to cherry-pick, and cherry-picking is going to
> confuse your merging.
>=20
> If you could convince the people using svn to use two branches: one
> for private stuff and one for public stuff, then your life would be
> easier.  You could just merge the public stuff in git, and ignore the
> private stuff.
>=20
> If that's not an option, you *can* combine cherry-pick with -s ours a=
s
> you suggest, though it's kind of nasty.  The trick is to merge -s our=
s
> in *both* directions at the right time, so you can avoid conflicts.
>=20
>     git checkout git-svn
>     git merge mybranch
>=20
>     git checkout mybranch
>     [git cherry-pick or git merge *everything* you're missing from gi=
t-svn...]
>     git merge -s ours --no-ff git-svn
>       # future merges from git-svn will ignore everything in mybranch=
 up to now
>=20
>     git checkout git-svn
>       # we know git-svn is already up to date, because of the first m=
erge above
>     git merge -s ours --no-ff mybranch
>       # future merges from mybranch will ignore everything in git-svn=
 up to now
>     git svn dcommit

Does that mean I should do a normal merge _before_ I go cherry-pick?

> After these steps (WARNING: I didn't actually run them, so I might
> have made a mistake), you should have both branches in sync, and you
> *should* be able to merge in both directions whenever you want (make
> sure you use --no-ff), until the next time someone commits something
> private and screws you over again.
>=20
> If you have more than one svn server, the above method should be
> extensible; just use another svn branch in place of 'mybranch' or kee=
p
> cross-merging across all the branches.

Maybe I got confused about what I should do on which branch.  Currently=
,
I have five branches:

  first-svn/trunk    # svn-remote branch of my repos
  second-svn/trunk   # svn-remote branch of their repos
  first-svn          # created by "git checkout -b first-svn/trunk"
  second-svn         # created by "git checkout -b second-svn/trunk"
  master             # I don't use this one yet

=46or this, I have the following configuration:

  [svn-remote "first-svn"]
          url =3D file:///var/tmp/builds/git-sync/svn/first-svn
          fetch =3D trunk:refs/remotes/first-svn/trunk
          branches =3D branches/*:refs/remotes/first-svn/*
          tags =3D tags/*:refs/remotes/first-svn/tags/*
  [svn-remote "second-svn"]
          url =3D file:///var/tmp/builds/git-sync/svn/second-svn
          fetch =3D trunk:refs/remotes/second-svn/trunk
          branches =3D branches/*:refs/remotes/second-svn/*
          tags =3D tags/*:refs/remotes/second-svn/tags/*
