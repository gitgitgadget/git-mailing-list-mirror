From: Adam Spiers <git@adamspiers.org>
Subject: RFC: new git-splice subcommand for non-interactive branch splicing
Date: Fri, 27 May 2016 15:08:11 +0100
Message-ID: <20160527140811.GB11256@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 16:13:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6IWO-0001rm-Kr
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 16:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950AbcE0ONh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 10:13:37 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:44358 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921AbcE0ONf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 10:13:35 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 May 2016 10:13:35 EDT
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 035292E0E6
	for <git@vger.kernel.org>; Fri, 27 May 2016 15:08:12 +0100 (BST)
Content-Disposition: inline
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295755>

Hi all,

I finally got around to implementing a new git subcommand which I've
wanted for quite a while.  I've called it git-splice.

Description
-----------

git-splice(1) non-interactively splices the current branch by removing
a range of commits from within it and/or cherry-picking a range of
commits into it.  It's essentially just a glorified wrapper around
cherry-pick and rebase -i.

Usage
-----

Examples:

    # Remove commit A from the current branch
    git splice A^!

    # Remove commits A..B from the current branch
    git splice A..B

    # Remove commits A..B from the current branch, and cherry-pick
    # commits C..D at the same point
    git splice A..B C..D

    # Cherry-pick commits C..D, splicing them in just after commit A
    git splice A C..D

    # Remove first commit mentioning 'foo', and insert all commits
    # in the 'elsewhere' branch which mention 'bar'
    git splice --grep=foo -n1 HEAD -- --grep=bar HEAD..elsewhere

    # Abort a splice which failed during cherry-pick or rebase
    git splice --abort

    # Resume a splice after manually fixing conflicts caused by
    # cherry-pick or rebase
    git splice --continue

N.B. Obviously this command rewrites history!  As with git rebase,
you should be aware of all the implications of history rewriting
before using it.

Code
----

Currently this is in alpha state:

  https://github.com/git/git/compare/master...aspiers:splice

and I reserve the right to rewrite the history of that branch in the
near future ;-)

I realise that the code does not yet conform to the coding standards
of the git project.  For example, it relies on non-POSIX bash
features, like arrays.  I would be happy to fix this if there is a
chance git-splice might be accepted for inclusion within the git
distribution.  (Presumably contrib/ is another possibility.)
Also, I haven't yet written a proper man page for it.

Motivation
----------

I wrote git-splice as the next step in the journey towards being able
to implement a tool which automatically (or at least
semi-automatically) splits a linear sequence of commits into a commit
graph where ancestry exactly mirrors commit "dependency".[0]  In other
words, in this commit graph, a commit B would have commit A as an
ancestor if and *only* if commit B cannot cleanly apply without A
already being present in the branch.  As a corollary, if commit F
depends on D and E, but D and E are mutually independent, F would
need to depend on a merge commit which contains D and E.

Such a tool could be useful for a few reasons.  Firstly, large patch
series are much harder to review than single commits or small patch
series, but typical development workflows often lead to large patch
series.

For example, if I work privately on a new feature for some hours /
days / weeks, I will typically amass a bunch of commits which are not
all directly related to the new feature: there are often refactorings,
fixes for bugs discovered during development of the new feature, etc.

I doubt I'm the only git user not disciplined enough to maintain neat
branch organization for the whole of a long period of hacking!
i.e. religiously maintaining one branch per bugfix, one branch per
refactoring, and one branch for the new feature.[1]  Typically, tidying
up the branches comes a bit later, when I want to start feeding stuff
upstream for review.

Therefore being able to reduce the effort involved with breaking a
large patch series into smaller related chunks seems potentially very
useful.

As well as making reviews smaller easier, this allows both the reviews
and any corresponding CI to proceed in a more parallelized fashion.

Some review systems can implicitly discourage reviews of large patch
series, by treating each commit as a review in its own right and/or not
providing sophisticated support for patch series.  Gerrit is one
example; gitlab and GitHub are counter-examples.

I'm sure there are other use cases which I didn't think of yet.

Next steps, and the future
--------------------------

Obviously, I'd welcome thoughts on whether it would make sense to
include this in the git distribution.

In the longer term however, I'd like to write two more subcommands:

  - git-transplant(1) which wraps around git-splice(1) and enables
    easy non-interactive transplanting of a range of commits from
    one branch to another.  This should be pretty straightforward
    to implement.

  - git-explode(1) which wraps around git-transplant(1) and
    git-deps(1), and automatically breaks a linear sequence of commits
    into multiple smaller sequences, forming a commit graph where
    ancestry mirrors commit dependency, as mentioned above.  I expect
    this to be more difficult, and would probably write it in Python.

    Ideally, this tool would also be able to integrate with other
    workflow management tools[1] in order to effectively create /
    manage topic branches and track dependencies between them.

Eventually, the utopia I'm dreaming about would become a reality and
look something like this:

    git checkout -b new-feature

    while in_long_frenzied_period_of_hacking; do
        # don't worry too much about branch maintenance here, just hack
        git add ...
        git commit ...
    done

    # Break lots of commits from new-feature into new topic branches:
    git explode

    # List topic branches
    git work list

    # Manually complete tidy-up of those branches
    git push ...
    git send-email ...


Feedback on any of this is very welcome!

Thanks,
Adam


[0] https://github.com/aspiers/git-deps/#user-content-use-case-2-splitting-a-patch-series

    This type of dependency could be described as textual or syntactic or
    lexical, and is automatically detected by git-deps:

        https://github.com/aspiers/git-deps/

    which I wrote a couple of years ago and previously announced on this list:

        http://thread.gmane.org/gmane.comp.version-control.git/262000/focus=262606

    Of course, this is a somewhat naive approach in that it has no
    awareness of semantic dependencies, e.g. commit A changing file X
    in a way which only makes sense if commit B changing file Y is
    already present.  However in my experience it's still a useful
    start in the right direction, saving a lot of time by detecting
    the "obvious" dependencies, and often revealing dependencies which
    I would have otherwise missed.

[1] There are tools which can help with this, e.g. topgit, git-flow,
    and gitwork, which IMHO is particularly interesting.
