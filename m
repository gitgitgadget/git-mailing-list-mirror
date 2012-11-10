From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Workflow for templates?
Date: Sat, 10 Nov 2012 08:13:49 +0100 (CET)
Message-ID: <bbc40624-f95d-48c9-83ed-fd70430226a4@zcs>
References: <20121031104403.GC28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 08:14:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TX5Gh-0002OQ-47
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 08:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301Ab2KJHNx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Nov 2012 02:13:53 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:44654 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab2KJHNw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 02:13:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 9F896460009;
	Sat, 10 Nov 2012 08:13:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VkJIHJbd859K; Sat, 10 Nov 2012 08:13:49 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id B0295622259;
	Sat, 10 Nov 2012 08:13:49 +0100 (CET)
In-Reply-To: <20121031104403.GC28437@raven.wolf.lan>
X-Originating-IP: [91.43.209.211]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209258>


> I am somewhat unsure whether it would work this way. After all, there
> seems to
> be an unbreakable rule with git: never rebase published branches.

I dont see a big problem if you just tell the downstreams to rebase
instead of merge downwards.

That's eg. my default approach for handling things like local
customizations. The fine thing here is that you'll always have a
clear separation between upstream development and your customizations.

Let's say, you have once forked at release tag v1.2.3, added 3
customization commits and later rebase onto v1.2.4, you'll still
have your 3 customization commits ontop of the upstream release.
With merge, you'll get more and more merge commits mixed later
coming customizations, and a migh higher chance of repeating conflicts.

I'd suggest some general rules:

* strict branch hierachy
* downstreams always rebase instead of merge
* probably use --onto rebase
* development is always happening in topic-branches, that will be
  rebased before merge into their upstream --> fast-forward only

> Maybe I should try to explain the problem in terms of repository
> hierarchy. Let's assume, there is this hierarchy of repositories:

Let's talk about branches instead - repos are just containers for
branches (and tags, etc). If all people are practically in the same
administrative domain (or sort of), you can even use one single
repo for that (not counting developer's and target system's local
clones).

> upstream: central repository, containing the generic template
>=20
> foo-site: repository for site foo. Here we have localizations for a
> specific
>           administrative entity named foo (say, google).
>           This is where clones for production are made from, and
>           production
>           boxes pull from here to be kept up-to-date.

Only the non-customized boxes will pull from here - if there's any bit
that needs to be changed, add separate branches for them.

And "pull" always means rebase.

When a new upstream release comes out (and is properly validated), it
will be rebased ontop of that.

> foo-devA: A clone of foo-site to make development, releases, and
> whatever for foo.
> foo-devB: One more clone of foo-site, Developer B is working here.

Developers should use topic branches, which are regularily rebased
ontop of their upstream, especially before commit and final validation.

> Further, foo-devA might be the same person as bar-devA.

He'll use separate branches anyways. Everything else is just a matter
of proper naming scheme.

=46or example, if you're using a central (bare) repository (again: not
counting the developer's locl clones), you could use something like
an <site>+"/" branch name prefix.

By the way: you really should use non-conflicting tag names (eg.
adding some <site>+"/" or <site>+"-" prefix), otherwise you'll
easiy run into conflicts, because per default retrieved and local
tags will all be in some namespace - you'll probably dont like to
set up separate namespaces for individual remotes (which is quite
easy to forget ;-o). Better consider tag names to be really global.

> So when foo-devA pulls from foo-devB, then foo-devB will create
> problems when he rebases after that pull.

pull (or probably: remote update) is different from merge or rebase
essentially, pull is a combination of remote update and an automatic
merge from or rebase onto (depending on the configuration) the
coresponding upstream branch.

> What I am trying to achieve, is to extend the workflow from
> development to
> deployment across multiple administrative entities. As a picture:
>=20
>   upstream     (templates only).
>      ^
>      |
>      v
>   development  (configured, might contain experimental changes)
>      ^
>      |
>      v
>   deployment   (configured)
>=20
> This workflow should not stop at administrative borders. Just replace
> foo by
> google and bar by Microsoft to get an idea of what I am trying to
> achieve.

We're talking about two entirely different things here:

a) repositories: container that hold references to histories
   (branches, tags, etc)

b) branches and their semantic releations


Repositories:

As git is fully distributed, it doesnt really matter where repositories
are. Developers (and other parties accessing the code) will most likely
have their own local clone. But "clone of X" means nothing more than ju=
st
happens to have some remote attachment to repo X.

So, the semantics of

    git clone /path/to/my/funny-project

is the same like:

    ( git init funny-project && \
        cd cd funny-project && \
        git remote add origin /path/to/my/funny-project && \
        git remote update origin && \
        git checkout origin/master -b master )

So, let's look at the individual steps:

   #1: git init funny-project
   --> ( mkdir funny-project && cd funny-dir && git init )
   --> creates an empty repository

   #2: git remote add origin /path/to/my/funny-project
   --> configures an remote called "origin" with url "/path/to/my/funnl=
y-project"
       and confgures it to sync the remote-side's references from refs/=
heads/*
       to locally refs/remotes/origin/*, and remote-side's refs/tags/* =
to
       locally refs/tags (without overwriting existing tag references)

   #3: git remote update origin
   --> do the actual syncing from remote "origin", get the remote ref l=
ist,
       download all yet objects (that are required for the refs to be s=
ynced)
       and adds/updates the refs into the according target namespaces
       (BTW: if a branch was removed on remote side, the local copy in
       refs/remotes/<remote-name>/* wont be deleted - you'll need to ca=
ll
       git remote prune <remote-name> for that)

   #4: git checkout origin/master -b master
   --> copies the current refs/remotes/origin/master ref to refs/heads/=
master
       and checks out that new local branch (IOW: sets the refs/HEAD sy=
mbolic
       ref to refs/heads/master and copies index and working tree from =
the
       head commit)

Branches are something completely different:

Logically, a branch is a history of commits with parent-child-relations=
hip
(mathematically spoken, it's an directed acyclic graph): each commit ma=
y
have a variable number of parent commits.

Technically, what we usally call "branch" is in fact an name (reference
in refs/heads/* namespace) which point at the head commit of that local
branch. When you do git commit, it creates a new commit object from the
index, adds some metadata (eg. your commit message) and sets the curren=
t=20
branch reference (usually that one where the symbolic reference refs/HE=
AD
points to) to the new commit object's SHA-key. IOW: you add a new objec=
t
in front of the DAG and move the pointer one step forward in the line.

When you do a merge (no matter if the source is remote or local - it ju=
st
needs to be an locally available object), there're essentially two thin=
gs
that can happen:

a) your source is an direct descendant of the target branch (IOW: the
   target's current head commit appears somewhere in the source's histo=
ry),
   it will just move the current branch forward to the merge source
   (moves the head pointer and updates index and worktree)
   this is called "fast-forward" (in fact, it the fastest kind of merge=
)

b) your source is not direct descendant: source tree will be actually
   merged into index/worktree, possibly make break when there're confli=
cts
   to be resolved manually, and create a new commit containing the curr=
ent
   (now merged) index and two parent poiters, to source and to previous
   merge target.

Now what is rebase ?

A rebase rewrites history in various ways (in fact, you can do a lot mo=
re
things than just simple rebasing, eg. edit or drop older commits, etc).

=46or example 'git rebase origin/master' will look for the latest commo=
n
ancestor of both the current and the target treeish (eg. refs/remotes/m=
aster),
start from that tree'ish and apply the changes that happend from the la=
st
common ancestor until your current branch head ontop of that treeish,
(possibly asking the user to manually resolve some conflicts), and then
replaces the current branch head by the final head.

As it changes history, it should be used wisely.

A common problem with using rebase and public branches is:

* upstream changes history (eg. because he rebased onto his upstream)
* downstream (per default) merges this upstream into his branch
--> git will see two entirely different branches get merged, so
    there's some good change of nasty conflicts, and history will
    easily get really ugly

So, if you do rebase your public branch, downstreams should also do so
(rebase their local branches ontop of your public branch instead of
merging yours into theirs).

By the way: there are several more kinds of rebases, which are very
interesting for complex or sophisticated workflows, eg:

* --ontop rebase: instead of letting git find out the starting point
  of commit sequence to apply on target treeish, you'll define it
  explicitly (eg. if you want it to forget about things previous to
  the starting treeish).
* interactive rebase:=20
  a) is able to reconstruct merges
  b) allows to cut into the sequence and change, drop or add new commit=
s

These operations are very useful for cleaning up the history, especiall=
y
with things like topic-branch workflow (eg. if you originally have some
hackish and unclean commits and you wanna put an clean and self-consist=
ant
one into your mainline instead).


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
