From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Our merge bases sometimes suck
Date: Fri, 13 Jun 2014 00:12:15 +0200
Message-ID: <539A25BF.4060501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030106050707010306060805"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 00:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvDER-0005U4-RK
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 00:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbaFLWMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 18:12:20 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61258 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093AbaFLWMT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jun 2014 18:12:19 -0400
X-AuditID: 12074414-f79f86d000000b9f-99-539a25c17a9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C9.07.02975.1C52A935; Thu, 12 Jun 2014 18:12:17 -0400 (EDT)
Received: from [192.168.69.130] (p4FC964CF.dip0.t-ipconnect.de [79.201.100.207])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5CMCG0G005090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 12 Jun 2014 18:12:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqHtQdVawwdu55hZdV7qZHBg9Pm+S
	C2CM4rZJSiwpC85Mz9O3S+DOuHjrO0vBgeWMFdsfvWBpYGydxNjFyMkhIWAi8WTDExYIW0zi
	wr31bF2MXBxCApcZJRp2v4ZyXjFJ3FwxAayDV0BbYn77bDCbRUBVYsmXucwgNpuArsSinmYm
	EFtUIEhi9ud57BD1ghInZ0JsEAGq2fXsKtBQDg5hAXWJS0dDQUwJAXGJnsYgkApmgQCJl30T
	2Scw8s5C0jwLSQrC1pF41/eAGcKWl2jeOhvKNpBYdOY7E4StKDGl+yFUvY3Es4PtrAsY2Vcx
	yiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISryA7GIyflDjEKcDAq8fCu+Dgz
	WIg1say4MvcQoyQHk5Iob7zwrGAhvqT8lMqMxOKM+KLSnNTiQ4wqQMsebVh9gVGKJS8/L1VJ
	hNdHEqiONyWxsiq1KB+mTJqDRUmc99tidT8hgfTEktTs1NSC1CKYrAwHh5IE7xYVoEbBotT0
	1Iq0zJwShDQTB+chRgkOLimR4tS8lNSixNKSjHhQbMcXA6MbJMUDtHcGSDtvcUFiLlAUovUU
	oyvHiScn25g4Js06BSSngcl5YHIBiBQCO1pKnNcMpFkApDmjNA9uNSzJvWIUB4aKMO8ykCoe
	YIKE2/AKaDkT0PLXntNBlpckIqSkGhgbrp9dGKR1fE94znHXVOd1Yivsb7369P7bC1/eTVwX
	nJ7n+vx/lOShOKF2g8X+Z2G8L89PyTvCJ1zfEXbmjPqK7moFq//2Go8aH3KciVMX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251502>

This is a multi-part message in MIME format.
--------------030106050707010306060805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

I've been thinking a lot about merge bases lately and think I have
discovered something interesting.

tl;dr:

When two branches have multiple merge bases,

    git merge-base $master $branch

picks one merge base more or less arbitrarily.  Here I describe a
criterion for picking a "best" merge base.  When the best merge base
is used, the diff output by

    git diff $master...$branch

becomes shorter and simpler--sometimes dramatically so.  I have
quantified the improvement by analyzing historical merges from the Git
project (see attached image).  Best merge bases might also help reduce
conflicts when conducting merges.


Background
==========

A merge base of two or more branches is a common ancestor of those
branches that has no descendant that is also a common ancestor (see
`git-merge-base(1)`).  Merge bases are important when merging
branches, and are also used internally to some other commands like
"git diff $master...$branch".

Sometimes branches have multiple merge bases, such as in the case of a
criss-cross merge:

    o--A--o--o--X--o--Y--o--Z    <- master
        \        \   /
         \        \ /
          \        ·
           \      / \
            \    /   \
             B--C--D--E--F       <- branch

Here, commits X and C are both merge bases for branches master and
branch.  You can list all merge bases by running

    git merge-base --all $master $branch

But if you run

    git merge-base $master $branch

only one merge base is returned.  *Which* one it returns is not
documented and appears to be pretty arbitrary (probably a side effect
of the traversal order?)


The "best" merge base
=====================

But not all merge bases are created equal.  It is possible to define a
"best" merge base that has some nice properties.

Let's focus on the command

    git diff $master...$branch

which is equivalent to

    git diff $(git merge-base $master $branch)..$branch

We want such a diff to have two properties:

1. It must include *all* changes that have been made on the branch but
   are not yet contained in master.

2. It should contain *as few* changes as possible that are already in
   master.

The first property is satisfied automatically if the left end of the
"diff" range is any merge base.  Because a merge base is an ancestor
of master, it cannot possibly include any changes that were made on
the branch but have not yet been merged to master [1].

The second property requires as a *necessary* condition that the left
end of the diff is a merge base.  But the property also helps us pick
the best among multiple merge bases.  We just need to make the idea of
"contains as few changes as possible" more precise.

I propose that the best merge base is the merge base "candidate" that
minimizes the number of non-merge commits that are in

    git rev-list --no-merges $candidate..$branch

but are already in master:

    git rev-list --no-merges $master

Since a non-merge commit should embody a single logical change,
counting non-merge commits is in some sense counting changes [2].

We can put this criterion in simpler form.  Because every candidate is
a merge-base,

    git rev-list --no-merges $candidate..$branch

necessarily includes *all* of the non-merge commits that are on branch
but not on master.  This is a fixed number of commits, the same for
every candidate.  It *additionally* includes the commits that are on
master but not yet in branch.  This second number varies from one
candidate to another.  So if we minimize the number of commits in this
output, is is the same as minimizing the number of unwanted commits.
Therefore, to get the best merge base, all we have to do is pick the
merge base that minimizes

    git rev-list --count --no-merges $candidate..$branch

There can be ties, but in practice they are rare enough that it is
probably not worth worrying about them.


Symmetry; generalization to more than two branches
==================================================

Interestingly, minimizing the last criterion is the same as maximizing

    git rev-list --count --no-merges $candidate

because there is a fixed number of commits in

    git rev-list --no-merges $branch

, and each of those commits is in exactly one of the two counts above.
This formulation shows that the best merge base for computing

    git diff $master...$branch

is also the best merge base for computing

    git diff $branch...$master

; i.e., the best merge base is symmetric in its arguments.  It also
shows that the concept of "best merge base" can trivially be
generalized to more than two branches.


git-best-merge-base script
===========================

The best merge base can be computed, for example, using the following
script:

    #! /bin/sh
    # Usage: git-best-merge-base MASTER BRANCH

    set -e

    master="$1"
    branch="$2"

    count() {
        git rev-list --no-merges --count "$1..$branch"
    }

    # Note that if $master and $branch have no common ancestors, `git
    # merge-base` fails with retcode=1, causing the script to exit
    # with the same error code.
    merge_bases=$(git merge-base --all "$master" "$branch")

    case "${#merge_bases}" in
    40)
        # One merge base -> use it.
        echo $merge_bases
        ;;
    *)
        # Multiple merge bases -> pick the one for which $base..$branch
        # has the fewest commits that are already in $master.  To ensure
        # that the result is repeatable, if there is a tie we choose the
        # merge base that comes first when sorted by SHA-1:
        for merge_base in $merge_bases
        do
            echo $(count $merge_base) $merge_base
        done | sort -k1,1n -k2 | sed -ne '1s/^.* //p'
        ;;
    esac


Do best merge bases really help?
================================

I analyzed all of the 2-parent merges made in the history of the Git
project.  (I limited the analysis to 2-parent merges just for
simplicity.)  I computed the size of the asymmetric diffs

    git diff $commit^1...$commit^2

using the current code and using git-best-merge-base, with the
following script:

    #! /bin/sh

    old_diff_len() {
        git diff $1...$2 | wc -l
    }

    new_diff_len() {
        git diff $(git-best-merge-base $1 $2)..$2 | wc -l
    }

    git rev-list --min-parents=2 --max-parents=2 --parents "$@" |
    while read commit p1 p2
    do
        echo "$commit $(git merge-base --all $p1 $p2 | wc -l)
$(old_diff_len $p1 $p2) $(new_diff_len $p1 $p2)"
    done


Results:

* Total number of merges: 8263

* Total number of merges with exactly two parents: 8229

  Of which:

  * Number with zero merge bases: 6 (0.07%)

  * Number with one merge base: 7823 (95.1%)

  * Number with multiple merge bases: 400 (4.8%)

    Of which:

    * Number whose diffs shrink: 71 (17.8%)

    * Number whose diffs remain the same length: 323 (80.1%)

    * Number whose diffs grow: 6 (1.5%)

I have attached a graph plotting the diff sizes against each other on
a log-log scale.  The points *under* the red line are diffs that have
shrunk; the points *over* the red line are the diffs that have grown.
As you can see, far more diffs shrank than grew, and by larger
factors.  Some of the diffs have shrunk dramatically.  In the most
drastic case, the diff shrank from 466602 lines to 81 lines.

A relatively small fraction of all merges are affected, but of merges
that have multiple merge bases (which are the most difficult merges to
handle), more than one in six would be simplified.

I should mention that I have done a similar analysis of a large
commercial software project's history, with broadly similar results.

I wouldn't be surprised if selecting merge bases more intelligently in
"git merge" also helps make more merges go through without conflicts.


Suggested next steps
====================

I don't have time right now to work more on best merge bases, and I am
not very familiar with the parts of the code that would be involved.
So I'm hoping that somebody else finds this a worthwhile improvement
and tries implementing best merge bases in git core.  I have the
following suggestions:

* Add an option

      git merge-base --best <commit> <commit>...

  that computes the best merge base as described above.  Its output
  can be tested against the git-best-merge-base script that I
  provided.

* Use the best merge base when computing

      git diff <commit>...<commit>

  This should give shorter differences in many cases.

* Benchmark "merge-base" with the "--best" option and, if it is not
  too expensive, perhaps make it the default behavior of "merge-base".

* See whether best merge bases can be used to improve other parts of
  the code, especially the code for the recursive merge strategy.

Michael

[1] I assume that commits make independent changes.  If some commits
    in fact revert changes made by other commits, or some commits have
    been cherry-picked across branches, then the correlation between
    number of commits and size of diff will be a bit weaker but should
    still be a useful approximation.

[2] There are other ways that "fewest changes" could be defined.  We
    could include merge commits in the count of extra commits.  (This
    variant could be implemented by omitting `--no-merges` in the
    `rev-list` commands above.)  Or, when diffing only text files, we
    could try to minimize the overall textual length of the diff.  The
    definition used in the main text is chosen for being reasonable,
    general, symmetric, and not too expensive to compute.

-- 
Michael Haggerty
mhagger@alum.mit.edu


--------------030106050707010306060805
Content-Type: image/png;
 name="diff-sizes.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff-sizes.png"

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
QmCC
--------------030106050707010306060805--
