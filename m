From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Our merge bases sometimes suck
Date: Fri, 13 Jun 2014 11:38:24 +0200
Message-ID: <539AC690.6000906@drmicha.warpmail.net>
References: <539A25BF.4060501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 11:38:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvNwQ-0008Hi-IK
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 11:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaFMJia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 05:38:30 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46287 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbaFMJi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2014 05:38:28 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CC1A720D87;
	Fri, 13 Jun 2014 05:38:26 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 13 Jun 2014 05:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=l6/59DVlruwsJwBTk9/qa6
	RTLmE=; b=R9UO6NZSzNBq4f2ncRswNffyS6eoQetuZfA6ra+cAmBjwB6nrU93z8
	qyG8yyN1HJYdodLFk1FPH6T0g+c0hgmWWU1+ND0rlkCEs1ryL67ZJH3ZSlv5ZRNv
	yXNVe69/buRuiZ5DR3Xo6gc7bK4TSyFCzQ4AfdXTBtuq9UTAZpDKA=
X-Sasl-enc: vDCO2fGQ1iPTWhn8ZrE54sSf1y8E7WUoCH6yvGMHII4x 1402652306
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2287E6800BF;
	Fri, 13 Jun 2014 05:38:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <539A25BF.4060501@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251534>

Michael Haggerty venit, vidit, dixit 13.06.2014 00:12:
> I've been thinking a lot about merge bases lately and think I have
> discovered something interesting.
>=20
> tl;dr:
>=20
> When two branches have multiple merge bases,
>=20
>     git merge-base $master $branch
>=20
> picks one merge base more or less arbitrarily.  Here I describe a
> criterion for picking a "best" merge base.  When the best merge base
> is used, the diff output by
>=20
>     git diff $master...$branch
>=20
> becomes shorter and simpler--sometimes dramatically so.  I have
> quantified the improvement by analyzing historical merges from the Gi=
t
> project (see attached image).  Best merge bases might also help reduc=
e
> conflicts when conducting merges.
>=20

Everytime I looked at our merge base code, my head started spinning. So
it's admirable you even started this endeavor :)

We use merge bases for several things:

- merging
- resolving "A...B" rev notation (rev-list and friends), aka symmetric
difference
- left/right selection/annotation of commits (rev-list/log)
- resolving "diff A...B", which may be a handy notation, but is horribl=
y
misleading because it is a very unsymmetric form of diff

Out of these four, you seemingly picked the one as pivoting example
which is most different from any symmetric notion of "...". But in fact=
,
"merging" is quite unsymmetric, too, because merging branch into master
is quite different from the other way round.

This is certainly obvious to you, bit I thought I point it out for the
convenience of other readers: You are after optimizing the merge base
choice for an unsymmetric use case, which covers "diff A...B" as well a=
s
"merge B into A".

In these two cases, choosing different merge bases can lead to differen=
t
results. The other two basically use all merge bases anyways.

(I seem to recall that our cherry code could profit from improvements, =
too.)

> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> A merge base of two or more branches is a common ancestor of those
> branches that has no descendant that is also a common ancestor (see
> `git-merge-base(1)`).  Merge bases are important when merging
> branches, and are also used internally to some other commands like
> "git diff $master...$branch".
>=20
> Sometimes branches have multiple merge bases, such as in the case of =
a
> criss-cross merge:
>=20
>     o--A--o--o--X--o--Y--o--Z    <- master
>         \        \   /
>          \        \ /
>           \        =B7
>            \      / \
>             \    /   \
>              B--C--D--E--F       <- branch
>=20
> Here, commits X and C are both merge bases for branches master and
> branch.  You can list all merge bases by running
>=20
>     git merge-base --all $master $branch
>=20
> But if you run
>=20
>     git merge-base $master $branch
>=20
> only one merge base is returned.  *Which* one it returns is not
> documented and appears to be pretty arbitrary (probably a side effect
> of the traversal order?)
>=20
>=20
> The "best" merge base
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> But not all merge bases are created equal.  It is possible to define =
a
> "best" merge base that has some nice properties.
>=20
> Let's focus on the command
>=20
>     git diff $master...$branch
>=20
> which is equivalent to
>=20
>     git diff $(git merge-base $master $branch)..$branch
>=20
> We want such a diff to have two properties:
>=20
> 1. It must include *all* changes that have been made on the branch bu=
t
>    are not yet contained in master.
>=20
> 2. It should contain *as few* changes as possible that are already in
>    master.
>=20
> The first property is satisfied automatically if the left end of the
> "diff" range is any merge base.  Because a merge base is an ancestor
> of master, it cannot possibly include any changes that were made on
> the branch but have not yet been merged to master [1].
>=20
> The second property requires as a *necessary* condition that the left
> end of the diff is a merge base.  But the property also helps us pick
> the best among multiple merge bases.  We just need to make the idea o=
f
> "contains as few changes as possible" more precise.
>=20
> I propose that the best merge base is the merge base "candidate" that
> minimizes the number of non-merge commits that are in
>=20
>     git rev-list --no-merges $candidate..$branch
>=20
> but are already in master:
>=20
>     git rev-list --no-merges $master
>=20
> Since a non-merge commit should embody a single logical change,
> counting non-merge commits is in some sense counting changes [2].
>=20
> We can put this criterion in simpler form.  Because every candidate i=
s
> a merge-base,
>=20
>     git rev-list --no-merges $candidate..$branch
>=20
> necessarily includes *all* of the non-merge commits that are on branc=
h
> but not on master.=20

This is actually true for every merge base candidate (i.e. every commit
which is both on master and branch).

[These things are really much easier in set language, A..B being B
\setminus A, being B intersected with the complement of A etc.]

> This is a fixed number of commits, the same for
> every candidate.

"This" refers to "branch minus master" (commits on branch but not on
master), which is defined indepently of candidate.

>  It *additionally* includes the commits that are on
> master but not yet in branch.  This second number varies from one
> candidate to another.

"master minus branch" is independent of candidate also.

The second number is rather those commits on candidate..branch which ar=
e
not "branch minus master", i.e. "branch minus candidate" minus "branch
minus master", which is "branch intersected with master minus
candidate", i.e. those commits on candidate..branch which are also on
master. [Again this is true for every merge base candidate, not just
every merge base.]

>  So if we minimize the number of commits in this
> output, is is the same as minimizing the number of unwanted commits.

Now I understand why this statement is true :)

> Therefore, to get the best merge base, all we have to do is pick the
> merge base that minimizes
>=20
>     git rev-list --count --no-merges $candidate..$branch
>=20
> There can be ties, but in practice they are rare enough that it is
> probably not worth worrying about them.
>=20
>=20
> Symmetry; generalization to more than two branches
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> Interestingly, minimizing the last criterion is the same as maximizin=
g
>=20
>     git rev-list --count --no-merges $candidate
>=20
> because there is a fixed number of commits in
>=20
>     git rev-list --no-merges $branch
>=20
> , and each of those commits is in exactly one of the two counts above=
=2E

That's a cute observation, which in the example above is wrong on first
glance, but true on second: Visually/subjectively, one easily misses
commits B and C when counting "X..master", which is not just the commit=
s
"extending master beyond X", etc.

> This formulation shows that the best merge base for computing
>=20
>     git diff $master...$branch
>=20
> is also the best merge base for computing
>=20
>     git diff $branch...$master
>=20
> ; i.e., the best merge base is symmetric in its arguments.  It also
> shows that the concept of "best merge base" can trivially be
> generalized to more than two branches.

That symmetry is really surprising, but the argument is convincingly
correct. Alas, that count back to the roots can be really expensive.

Given that the arguments in the previous argument show that everything
applies to merge base candidates as well, not just merge bases, I'm
wondering whether we can weave in the weighing (which one is best) with
our existing merge base algorithm or maybe an alternative algorithm
using generation numbers or such.

> git-best-merge-base script
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> The best merge base can be computed, for example, using the following
> script:
>=20
>     #! /bin/sh
>     # Usage: git-best-merge-base MASTER BRANCH
>=20
>     set -e
>=20
>     master=3D"$1"
>     branch=3D"$2"
>=20
>     count() {
>         git rev-list --no-merges --count "$1..$branch"
>     }
>=20
>     # Note that if $master and $branch have no common ancestors, `git
>     # merge-base` fails with retcode=3D1, causing the script to exit
>     # with the same error code.
>     merge_bases=3D$(git merge-base --all "$master" "$branch")
>=20
>     case "${#merge_bases}" in
>     40)
>         # One merge base -> use it.
>         echo $merge_bases
>         ;;
>     *)
>         # Multiple merge bases -> pick the one for which $base..$bran=
ch
>         # has the fewest commits that are already in $master.  To ens=
ure
>         # that the result is repeatable, if there is a tie we choose =
the
>         # merge base that comes first when sorted by SHA-1:
>         for merge_base in $merge_bases
>         do
>             echo $(count $merge_base) $merge_base
>         done | sort -k1,1n -k2 | sed -ne '1s/^.* //p'
>         ;;
>     esac
>=20
>=20
> Do best merge bases really help?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I analyzed all of the 2-parent merges made in the history of the Git
> project.  (I limited the analysis to 2-parent merges just for
> simplicity.)  I computed the size of the asymmetric diffs
>=20
>     git diff $commit^1...$commit^2
>=20
> using the current code and using git-best-merge-base, with the
> following script:
>=20
>     #! /bin/sh
>=20
>     old_diff_len() {
>         git diff $1...$2 | wc -l
>     }
>=20
>     new_diff_len() {
>         git diff $(git-best-merge-base $1 $2)..$2 | wc -l
>     }
>=20
>     git rev-list --min-parents=3D2 --max-parents=3D2 --parents "$@" |
>     while read commit p1 p2
>     do
>         echo "$commit $(git merge-base --all $p1 $p2 | wc -l)
> $(old_diff_len $p1 $p2) $(new_diff_len $p1 $p2)"
>     done
>=20
>=20
> Results:
>=20
> * Total number of merges: 8263
>=20
> * Total number of merges with exactly two parents: 8229
>=20
>   Of which:
>=20
>   * Number with zero merge bases: 6 (0.07%)
>=20
>   * Number with one merge base: 7823 (95.1%)
>=20
>   * Number with multiple merge bases: 400 (4.8%)

I guess that shows how well thought out our maintainer's branch and
merge workflow is: practically no criss-crossing, everything merged
downwards, for almost constant definition of "down" ;)

>     Of which:
>=20
>     * Number whose diffs shrink: 71 (17.8%)
>=20
>     * Number whose diffs remain the same length: 323 (80.1%)
>=20
>     * Number whose diffs grow: 6 (1.5%)
>=20
> I have attached a graph plotting the diff sizes against each other on
> a log-log scale.  The points *under* the red line are diffs that have
> shrunk; the points *over* the red line are the diffs that have grown.
> As you can see, far more diffs shrank than grew, and by larger
> factors.  Some of the diffs have shrunk dramatically.  In the most
> drastic case, the diff shrank from 466602 lines to 81 lines.
>=20
> A relatively small fraction of all merges are affected, but of merges
> that have multiple merge bases (which are the most difficult merges t=
o
> handle), more than one in six would be simplified.
>=20
> I should mention that I have done a similar analysis of a large
> commercial software project's history, with broadly similar results.
>=20
> I wouldn't be surprised if selecting merge bases more intelligently i=
n
> "git merge" also helps make more merges go through without conflicts.
>=20
>=20
> Suggested next steps
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I don't have time right now to work more on best merge bases, and I a=
m
> not very familiar with the parts of the code that would be involved.
> So I'm hoping that somebody else finds this a worthwhile improvement
> and tries implementing best merge bases in git core.  I have the
> following suggestions:
>=20
> * Add an option
>=20
>       git merge-base --best <commit> <commit>...
>=20
>   that computes the best merge base as described above.  Its output
>   can be tested against the git-best-merge-base script that I
>   provided.
>=20
> * Use the best merge base when computing
>=20
>       git diff <commit>...<commit>
>=20
>   This should give shorter differences in many cases.
>=20
> * Benchmark "merge-base" with the "--best" option and, if it is not
>   too expensive, perhaps make it the default behavior of "merge-base"=
=2E
>=20
> * See whether best merge bases can be used to improve other parts of
>   the code, especially the code for the recursive merge strategy.
>=20
> Michael
>=20
> [1] I assume that commits make independent changes.  If some commits
>     in fact revert changes made by other commits, or some commits hav=
e
>     been cherry-picked across branches, then the correlation between
>     number of commits and size of diff will be a bit weaker but shoul=
d
>     still be a useful approximation.
>=20
> [2] There are other ways that "fewest changes" could be defined.  We
>     could include merge commits in the count of extra commits.  (This
>     variant could be implemented by omitting `--no-merges` in the
>     `rev-list` commands above.)  Or, when diffing only text files, we
>     could try to minimize the overall textual length of the diff.  Th=
e
>     definition used in the main text is chosen for being reasonable,
>     general, symmetric, and not too expensive to compute.
>=20
