From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 10:27:55 +0200
Message-ID: <20091016082755.GA19395@atjola.homenet>
References: <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
 <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com>
 <alpine.LFD.2.00.0910151436180.20122@xanadu.home>
 <7v1vl45t9k.fsf@alter.siamese.dyndns.org>
 <20091015212632.GA13180@coredump.intra.peff.net>
 <7v1vl42uid.fsf@alter.siamese.dyndns.org>
 <20091016042955.GA9233@atjola.homenet>
 <alpine.LNX.2.00.0910160128400.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	James Pickens <jepicken@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 10:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyiFh-0000yJ-5R
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 10:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbZJPI2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Oct 2009 04:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbZJPI2w
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 04:28:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:34923 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751614AbZJPI2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 04:28:49 -0400
Received: (qmail invoked by alias); 16 Oct 2009 08:28:01 -0000
Received: from i59F5472B.versanet.de (EHLO atjola.homenet) [89.245.71.43]
  by mail.gmx.net (mp022) with SMTP; 16 Oct 2009 10:28:01 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/cMCEWZJDckM94t3fEJnqf1ntJXUvFfYq4irhwso
	nw7GOBeaFCfC9f
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910160128400.32515@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130466>

On 2009.10.16 02:02:09 -0400, Daniel Barkalow wrote:
> On Fri, 16 Oct 2009, Bj=F6rn Steinbrink wrote:
>=20
> > On 2009.10.15 14:54:18 -0700, Junio C Hamano wrote:
> > > If it is very important to support:
> > >=20
> > >     $ git checkout --look-but-not-touch origin/next^
> > >=20
> > > then James's approach would not be very useful, as we do have to =
detach
> > > HEAD and implement the "do not touch" logic for detached HEAD sta=
te
> > > anyway, so we might just use the same logic we would use for orig=
in/next^
> > > when checking out origin/next itself.
> >=20
> > I don't have any numbers backing this up, but my gut feeling says t=
hat
> > most cases of "Where have my commits gone?" that I have seen on #gi=
t
> > were due to "git checkout HEAD~2"-like actions. Either because the =
user
> > assumed SVN-like behaviour (you can't commit until you do "svn up",=
 like
> > "git reset --merge HEAD@{1}") or thought that "git checkout
> > <committish>" would act like "git reset --hard <committish>".
> >=20
> > For the latter I fail to envision any solution except for
> > education (and I have no idea why the user expected checkout to wor=
k
> > like reset).
> >=20
> > The former can be solved by the proposed extra information in HEAD,
> > forbidding changes to HEAD that make it reference a commit that's n=
ot
> > reachable through the head stored in the extra information[*1*] and=
 providing
> > some command that acts like "svn up".
> >=20
> > This seems quite different from the plain "forbid committing" or "d=
etach
> > and know how you get there", but more like "detach and know where y=
ou're
> > coming from".
>=20
> What's the state before the "git checkout HEAD~2"?
>=20
> If it's:
>=20
> $ git checkout origin/some-obscure-branch
> (get curious about the commit a bit back)
> $ git checkout HEAD~2

IIRC, most of the time it was:
git checkout master # not detaching
git checkout HEAD~2

Another version I recall (but that's what I use myself regularly, so I
might be biased and think that it's more common that it actually was)
is:

git checkout master
git log # Find commit, copy hash
git checkout <hash> # Pasting the copied hash

> And then the user doesn't know how to get back to where they were, th=
en it=20
> should work if git had stored "origin/some-obscure-branch~2" at this =
point=20
> (having substituted "origin/some-obscure-branch" (the previous extra =
info)=20
> for HEAD). Then we could have a "git up" that would discard modifiers=
 from=20
> the extra info and check that out. Or users might find "git checkout=20
> origin/some-obscure-branch" obvious enough if git is reporting someth=
ing=20
> related.

I'd not put "origin/some-obscure-branch~2" in there, but just
"origin/some-obscure-branch". Rationale: The ~2 modifier may become
invalid when you do "git fetch". And I don't see any value in having
that modifier, and even if there are some corner-cases, those could use
"git describe" or so, to get the modifiers on the fly.

> I know I often find my git.git repos on "* (no branch)", and I don't=20
> remember if I checked that out as origin/master or origin/next. And t=
hat's=20
> an important clue as to when I'd been doing there previously, and wha=
t I=20
> might want to do next. Perhaps these users are having a similar probl=
em,=20
> where they're relying on git to remember what they were doing?

Hm, maybe. I'm more inclined to think that they assumed that "git
checkout <branch_head>" 'binds' them to that branch head. But git allow=
s
them to jump around freely, the 'binding' is very weak.

SVN has:
"svn up": Get an older/newer version of the branch I'm on
"svn switch": Switch to a different branch

You cannot jump around without binding yourself to any branch.

git has:
"git checkout": Go anywhere, bind to that till the next checkout.

With "git checkout <non-branch-head>" working like a temporary unnamed
branch head.

In my view, there's the huge conceptual difference that svn has named
branches, while git only has named branch heads, that have a history
(reflog) that isn't necessarily even remotely similar to that of the
branch it currently points at.

          G---H---I (bar)
         /       /
A---B---C---D---E (master)
     \
      F (foo)

In SVN, you'd have a history that describes how "bar" came into its
current state, consisting of: G, H, I (Not following the copy at
G).

In git, you have a history that describes how commit I came into
existence (not branch head "bar"!), that is: A, B, C, D, E, G, H, I.

And the actual history for "bar" in git (the reflog) might be as weird
as: E, F, H, I, B, I. Jumping wildly across the commit DAG.


My view is that with git you're never "on a branch", but you have an
active branch head (possibly unnamed [detached HEAD]) that marks a tip,
where the DAG grows. A branch, to me, has an extent. In the above graph=
,
G, H, I is a branch, and F is a branch, but "bar" is not. "bar" has no
extent, it's just where the "G, H, I" branch might possibly grow.

When you do "git checkout bar~2", you're not on "no branch". Your activ=
e
branch head is just unnamed. The branch is yet to be born (unless you
consider e.g. "A, B, C, G" to be your branch), but at least after doing
a "git commit", you'll have:

            J (HEAD)
           /
          G---H---I (bar)
         /       /
A---B---C---D---E (master)
     \
      F (foo)

And then you clearly do have a branch "J" there. At least if you stop s=
aying
that a branch is just its head. And "git branch" saying that you're on
"no branch" makes no sense at all then.

Git simply doesn't expose branches in a sense of "a series of commit".
To get that, you need things like "git log master..bar" to get the "G, =
H,
I" branch.

SVN has this clear "this branch has this name" concept, git does not. I
prefer gits way. But maybe it should simply not use the term "branch"
when it means "branch head".

And the glossary even somewhat agrees with me, although it disagrees
with itself:

  branch
    A "branch" is an active line of development. The most recent commit
    on a branch is referred to as the tip of that branch. The tip of
    the branch is referenced by a branch head, which moves forward as
    additional development is done on the branch. A single git
    repository can track an arbitrary number of branches, but your
    working tree is associated with just one of them (the "current" or
    "checked out" branch), and HEAD points to that branch.

So a branch is an active line of development. If I do "git checkout
foo~2" and "git commit", I clearly do have an active line of
development. So it's not "no branch".

And a "branch head" references the tip (point of growth) of a branch.
It's not identical to a branch.

But then there comes HEAD, which is said to point to a branch, while it
of course points to a branch head. I guess the glossary is outdated WRT
detached HEAD, but if you ignore the implementation details, it could
still be said that in case of a detached HEAD, HEAD points to an unname=
d
branch head.


The user manual also makes this distinction, but says that "when no
confusion will result, we often just use the term 'branch' both for
branches and for branch heads".

And the command man pages follow that "just use 'branch'" way:

"git checkout" is said to checkout (and possibly create) a branch, not =
a
branch head.

"git branch":
 - List, create or delete branches
 - --contains/--merged/--no-merged =3D> show branches that...

But the clear winner is (from git-branch(1)):
"If the <commit> argument is missing it defaults to HEAD (i.e. the tip
of the current branch)."

Combine that with a detached HEAD and the according "git branch" output=
=2E
The <commit> argument will default to the tip of no branch! Epic.


Don't get me wrong though. I like git's model, and think that its
anonymous branches with named branch heads offer a lot more than e.g.
SVN's named branches (and namespace pollution is just a minor factor).
But I'm more and more convinced that suggesting the unknowing user who
didn't read the "we term A for A and B" notice in the manual, that git
does have named branches (branches being a series of commits) is a bad
thing that leads to confusion (in contrast to what the manual assumes).

Examples:

User asking about deleting a "branch" without deleting its commits:
http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-14#l2113

User asking whether deleting master will mess up other "branches":
http://colabti.de/irclogger/irclogger_log/git?date=3D2009-10-13#l2407

(I thought that there were two more in the last week, but I couldn't
find them, so maybe I was wrong, or they used some other word than
"delete", which I used to search the logs).

In both cases, the user wanted to delete the branch head, but was afrai=
d
that that would kill the commits, as they were told that they will
delete the "branch" and assumed the "branch" to be all commits reachabl=
e
through the branch head.

And I kind of doubt that this just applies to SVN refugees that are use=
d
to SVN's meaning of branches, but also to people that are new to any
kind of VCS and "naively" apply the branch-analogy to real-world trees,
where branches are more than just their tips.

And I believe that this is closely related to the detached HEAD thing.
See above for the "no branch" stuff that now doesn't even make any sens=
e
to me anymore (even less after reading the git-branch(1) man page ;-)).
But also the fact that checkout is hardly about branches, but about
(possibly unnamed) branch heads. One might have certain branch heads
that are never rewound and thus might be more or less equal to a branch=
,
but that seems like it's almost(?) a special case if you consider what
"checkout" can actually do.

I'm not sure how this can be alleviated. Just saying "branch head"
instead of "branch" is more correct, but probably still doesn't really
express those differences that make git what it is. Making "git branch"
say "* (unnamed branch head)" instead of "* (no branch)" seems like a
good start, but the user manual would need a very close look to catch
all the text that stops to make sense when you suddenly start to make a
stronger difference between a branch and a branch head. I'll look into
that over the weekend, but won't promise anything.

Bj=F6rn, hoping that he didn't run too far off the track
