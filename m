From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] Documentation: add manpage about workflows
Date: Tue, 30 Sep 2008 18:05:22 +0200
Message-ID: <200809301805.30753.trast@student.ethz.ch>
References: <1221147525-5589-3-git-send-email-trast@student.ethz.ch> <1221147585-5695-1-git-send-email-trast@student.ethz.ch> <20080921202620.GG21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1326209.1NELGvvfFK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Santi =?utf-8?q?B=C3=A9jar?=" <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 18:06:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkhkJ-0005rP-Ay
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 18:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbYI3QFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 12:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYI3QFc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 12:05:32 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:24040 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817AbYI3QFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 12:05:31 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 18:05:28 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 18:05:29 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080921202620.GG21650@dpotapov.dyndns.org>
X-OriginalArrivalTime: 30 Sep 2008 16:05:29.0263 (UTC) FILETIME=[5BC48BF0:01C92316]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97130>

--nextPart1326209.1NELGvvfFK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As a quick status update, mostly to show that I haven't forgotten
about this topic:

Thanks Santi and Dmitry for your comments.  You have raised some very
good points, and I attempted to fix these issues.

Unfortunately, in some places I got stuck trying to work out good
explanations for the workings of git.git, and some of the newer
rearrangements left the lead of "Merging branches" in a dire state.
I'll see if I can find a good solution myself, but suggestions would
be welcome in any case.  The WIP text is below, and I'll follow up
with an interdiff to the last version.

- Thomas

--- 8< ---
gitworkflows(7)
===============

NAME
----
gitworkflows - An overview of recommended workflows with git

SYNOPSIS
--------
git *


DESCRIPTION
-----------

This document attempts to write down and motivate some of the workflow
elements used for `git.git` itself.  Many ideas apply in general,
though the full workflow is rarely required for smaller projects with
fewer people involved.

We formulate a set of 'rules' for quick reference, while the prose
tries to motivate each of them.  Do not always take them literally;
you should value good reasons for your actions higher than manpages
such as this one.


SEPARATE CHANGES
----------------

As a general rule, you should try to split your changes into small
logical steps, and commit each of them.  They should be consistent,
working independently of any later commits, pass the test suite, etc.
This makes the review process much easier, and the history much more
useful for later inspection and analysis, for example with
linkgit:git-blame[1] and linkgit:git-bisect[1].

To achieve this, try to split your work into small steps from the very
beginning. It is always easier to squash a few commits together than
to split one big commit into several.  Don't be afraid of making too
small or imperfect steps along the way. You can always go back later
and edit the commits with `git rebase \--interactive` before you
publish them.


MANAGING BRANCHES
-----------------

Usually a feature (or other change) evolves in stages: it "graduates"
from patch to the testing branches and on to stable releases.  During
this process, it may require fixes or improvements.  XXX terrible
paragraph XXX

Merges (as opposed to cherry-picks, see below) greatly simplify
handling large numbers of commits, so a scalable workflow needs to use
merges.  Fortunately Git is very good at merging.

XXX non sequitur XXX
In the following sections we discuss some problems that arise from
such a "change flow", and how to solve them with Git.


Graduation
~~~~~~~~~~

As a given feature goes from experimental to stable, it also
"graduates" between the corresponding branches of the software.
`git.git` uses the following 'main branches':

* 'master' tracks the commits that should go into the next release;

* 'maint' tracks the commits that should go into the next "maintenance
  release", i.e., update of the last released stable version; and

* 'next' is intended as a testing branch for people who like to use
  more experimental stuff.

There is a fourth official branch that is used slightly differently:

* 'pu' (proposed updates) is an integration branch for things that are
  not quite ready for inclusion yet (see "Integration Branches"
  below).

Conceptually, the feature enters at an unstable branch (usually 'next'
or 'pu'), and "graduates" to 'master' for the next release once it is
considered stable enough.


Merging upwards
~~~~~~~~~~~~~~~

As explained above, features conceptually "graduate downwards" to
older releases.  This cannot be done by actually merging downwards,
however, since that would merge 'all' changes on the unstable branch
into the stable one.  Hence the following:

.Merge upwards
[caption="Rule: "]
=====================================
Always commit your fixes to the oldest supported branch that require
them.  Then (periodically) merge the main branches upwards into each
other.
=====================================

This gives a very controlled flow of fixes.  If you notice that you
have applied a fix to e.g. 'master' that is also required in 'maint',
you will need to cherry-pick it (using linkgit:git-cherry-pick[1])
downwards.  This will happen a few times and is nothing to worry about
unless you do it very frequently.


Topic branches
~~~~~~~~~~~~~~

Any nontrivial feature will require several patches to implement, and
may get extra bugfixes or improvements during its lifetime.

Committing everything directly on the main branches leads to many
problems: Bad commits cannot be undone, so they must be reverted one
by one, which creates confusing histories and further error potential
when you forget to revert part of a group of changes.  Working in
parallel mixes up the changes, creating further confusion.

The key concept here is "topic branches".  The name is pretty self
explanatory, with a caveat that comes from the "merge upwards" rule
above:

.Topic branches
[caption="Rule: "]
=====================================
Make a side branch for every topic (feature, bugfix, ...). Fork it off
at the oldest main branch that you will eventually want to merge it
into.
=====================================

Many things can then be done very naturally:

* To get the feature/bugfix into a main branch, simply merge it.  If
  the topic has evolved further in the meantime, merge again.

* If you find you need new features from the branch 'other' to continue
  working on your topic, merge 'other' to 'topic'.  (However, do not
  do this "just habitually", see below.)

* If you find you forked off the wrong branch and want to move it
  "back in time", use linkgit:git-rebase[1].

Note that the last two points clash: a topic that has been merged
elsewhere should not be rebased.  See the section on RECOVERING FROM
UPSTREAM REBASE in linkgit:git-rebase[1].

We should point out that "habitually" (regularly for no real reason)
merging a main branch into your topics -- and by extension, merging
anything upstream into anything downstream on a regular basis -- is
frowned upon:

.Merge to downstream only at well-defined points
[caption="Rule: "]
=====================================
Do not merge to downstream except:

* with a good reason: upstream API changes affect your branch; your
  branch no longer merges to upstream cleanly; etc.

* at well-defined points such as when an upstream release has been tagged.
=====================================

Otherwise, the many resulting small merges will greatly clutter up
history.  Anyone who later investigates the history of a file will
have to find out whether that merge affected the topic in development.
An upstream might even inadvertently be merged into a "more stable"
branch.  And so on.


Integration branches
~~~~~~~~~~~~~~~~~~~~

If you followed the last paragraph, you will now have many small topic
branches, and occasionally wonder how they interact.  Perhaps the
result of merging them does not even work?  But on the other hand, we
want to avoid merging them anywhere "stable" because such merges
cannot easily be undone.

The solution, of course, is to make a merge that we can undo: merge
into a throw-away branch.

.Integration branches
[caption="Rule: "]
=====================================
To test the interaction of several topics, merge them into a
throw-away branch.
=====================================

If you make it (very) clear that this branch is going to be deleted
right after the testing, you can even publish this branch, for example
to give the testers a chance to work with it, or other developers a
chance to see if their in-progress work will be compatible.  `git.git`
has such an official integration branch called 'pu'.  You must never
base any work on such a throw-away branch!


SHARING WORK
------------

After the last section, you should know how to manage topics.  In
general, you will not be the only person working on the project, so
you will have to share your work.

Roughly speaking, there are two important workflows: push/pull and
format-patch/am.  The important difference is that push/pull can
propagate merges, while format-patch cannot.  Medium to large projects
will typically employ some mixture of the two:

* "Upstream" in the most general sense 'pushes' changes to the
  repositor(ies) holding the official history of the project.
  Everyone can 'fetch' from there to stay up to date.

* Frequent contributors, subsystem maintainers, etc. may push to a
  public repository to make their changes available to upstream.

* The rest -- typically anyone more than one or two levels away from the
  main maintainer -- send patches by mail.

None of these boundaries are sharp, so find out what works best for
you.


Push/pull
~~~~~~~~~

There are three main tools that can be used for this:

* linkgit:git-push[1] copies your branches to a remote repository,
  usually to one that can be read by all involved parties;

* linkgit:git-fetch[1] that copies remote branches to your repository;
  and

* linkgit:git-pull[1] that does fetch and merge in one go.

Note the last point.  Do 'not' use 'git-pull' unless you actually want
to merge the remote branch.

Getting changes out is easy:

.Push/pull: Publishing branches/topics
[caption="Recipe: "]
=====================================
`git push <remote> <branch>` and tell everyone where they can fetch
from.
=====================================

You will still have to tell people by other means, such as mail.  (Git
provides the linkgit:request-pull[1] to send preformatted pull
requests to upstream maintainers to simplify this task.)

If you just want to get the newest copies of the main branches,
staying up to date is easy too:

.Push/pull: Staying up to date
[caption="Recipe: "]
=====================================
Use `git fetch <remote>` or `git remote update` to stay up to date.
=====================================

Then simply fork your topic branches from the stable remotes as
explained earlier.

If you are a maintainer and would like to merge other people's topic
branches to the main branches, they will typically send a request to
do so by mail.  Such a request might say

-------------------------------------
Please pull from
    git://some.server.somewhere/random/repo.git mytopic
-------------------------------------

In that case, 'git-pull' can do the fetch and merge in one go, as
follows.

.Push/pull: Merging remote topics
[caption="Recipe: "]
=====================================
`git pull <url> <branch>`
=====================================

Occasionally, the maintainer may get merge conflicts when he tries to
pull changes from downstream.  In this case, he can ask downstream to
do the merge and resolve the conflicts themselves (perhaps they will
know better how to resolve them).  It is one of the rare cases where
downstream 'should' merge from upstream.


format-patch/am
~~~~~~~~~~~~~~~

If you are a contributor that sends changes upstream in the form of
emails, you should use topic branches as usual (see above).  Then use
linkgit:git-format-patch[1] to generate the corresponding emails
(highly recommended over manually formatting them because it makes the
maintainer's life easier).

.format-patch/am: Publishing branches/topics
[caption="Recipe: "]
=====================================
* `git format-patch -M upstream..topic` to turn them into preformatted
  patch files
* `git send-email --to=<recipient> <patches>`
=====================================

See the linkgit:git-format-patch[1] and linkgit:git-send-email[1]
manpages for further usage notes.  Also you should be aware that the
maintainer may impose further restrictions, such as "Signed-off-by"
requirements.

If the maintainer tells you that your patch no longer applies to the
current upstream, you will have to rebase your topic (you cannot use a
merge because you cannot format-patch merges):

.format-patch/am: Keeping topics up to date
[caption="Recipe: "]
=====================================
`git pull --rebase <url> <branch>`
=====================================

You can then fix the conflicts during the rebase.  Presumably you have
not published your topic other than by mail, so rebasing it is not a
problem.

If you receive such a patch (as maintainer, or perhaps as a reader of
the mailing list it was sent to), save the mail to a file and use
'git-am':

.format-patch/am: Publishing branches/topics
[caption="Recipe: "]
=====================================
`git am < patch`
=====================================

One feature worth pointing out is the three-way merge, which can help
if you get conflicts: `git am -3` will use index information contained
in patches to figure out the merge base.  See linkgit:git-am[1] for
other options.


SEE ALSO
--------
linkgit:gittutorial[7],
linkgit:git-push[1],
linkgit:git-pull[1],
linkgit:git-merge[1],
linkgit:git-rebase[1],
linkgit:git-format-patch[1],
linkgit:git-send-email[1],
linkgit:git-am[1]

GIT
---
Part of the linkgit:git[1] suite.



--nextPart1326209.1NELGvvfFK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjiTkoACgkQqUud07tmzP0hAwCgnaBxrgI4sRFQ7TrZpotA49ab
f+wAn2ejoR+1QAA69vDHm0vl4GukQDhr
=Vyki
-----END PGP SIGNATURE-----

--nextPart1326209.1NELGvvfFK--
