From: Junio C Hamano <junkio@cox.net>
Subject: [RFH] straightening out "read-tree -m"
Date: Sun, 18 Mar 2007 00:25:40 -0700
Message-ID: <7vtzwjnhcb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 08:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSplw-00087q-AF
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 08:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbXCRHZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 03:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbXCRHZm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 03:25:42 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40162 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbXCRHZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 03:25:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070318072542.YUHE2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 18 Mar 2007 03:25:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id c7Rg1W0091kojtg0000000; Sun, 18 Mar 2007 03:25:41 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42478>

While everybody else was having fun with low-hanging fruit
performance tweaking ;-), I was looking at rather depressing
picture.

I do not have much energy left to look into this further
tonight, but I noticed this while drawing a case table to deal
with the recent "why can't I switch between these two branches"
problem.

First part is sort of "accomplishment" for tonight.  Two case
tables that describe desired semantics (meaning, the current
"read-tree -m -u" does not do this, and neither does
merge-recursive because it shares the same unpack-trees
backend).

* 2-way "read-tree -m -u A B".

While switching from branch A to branch B, if a path "foo" is
directory/file in A while the path is directory/file in B, then
these things should happen...

A	B	Outcome
----------------------------------------------------------------
D	D	No problem.

D	F	This should result in refusal when there are
                local modification to paths in "foo" directory,
		or there are untracked (but unignored) paths in
                "foo/".

F	D	This should result in refusal if "foo" has local
                modification.

F	F	This should result in refusal if "foo" has local
		modification.


The patch to "verify_absent()" I sent out earlier tries to deal
with the second case above, although it still has issues
(namely, the *indpos needs to be recomputed after replacing
potentially multiple entries under "foo/" with "foo" from B,
which the patch does not do).

Then I started to wonder if we have similar problem on the 3-way
side.

* 3-way "read-tree -m -u O A B"

While on branch A, if you try to merge branch B using O as the
merge base, if a path "foo" is D/F in A/B/C (there are 8
combinations), these things should happen...

O	A	B	Outcome
----------------------------------------------------------------
D	D	D	No problem.  Paths in the "foo/" directory 
			are merged subject to the usual rule.

D	D	F	File "foo", which did not exist in ancestor
			and we did not touch, is created.  Which means
			that contents of "foo/" is about to be
			lost.  We need to refuse this unless
			everything in "foo/" matches between O
			and A, there is no local modifications
			in "foo/", and there is no untracked but
			unignored paths in "foo/".

D	F	D	File "foo", which did not exist in
			ancestor and they did not touch, is
			created, so we would want to keep it.
			Which means that their changes to paths
			in "foo/" will be lost.  We should leave
			conflict for paths in "foo/" that are
			different between O and B.

D	F	F	No problem.  This is usual "added on
			both branches" conflict.

F	D	D	No problem.  Paths in the "foo/"
        		directory have usual "added on both
        		branches" conflict.

F	D	F	No problem.  If file "foo" was modified
			by them (i.e. O!=B) then usual "remove-modify"
			conflict arises.

F	F	D	No problem.  If file "foo" was modified
			by us (i.e. O!=A) then usual "remove-modify"
			conflict arises.  Also "foo" must not
			have local modifications.

F	F	F	No problem, usual 3-way rule applies.
			Also "foo" must not have local modifications.


The sad story is how confused the current unpack-trees is, given
the test case for the above 3-way.

The attached script demonstrates one aspect of the sorry state
of three-way merge done with unpack-trees.  You would notice
that there are multiple paths that have both stage '0' entry and
higher stage entries at the same time --- I do not think this
should not happen.

Git v1.0.0 to v1.2.0 refuse to merge but leaves two stage '0'
entries for path '4' and '8' (which is already incorrect but in
a different way).  v1.3.0 and later leaves stage 0/1/2/3 entry
for path '8'.

Depressing...


#!/bin/sh

# If your 'test' is precious, do not run this script!
/bin/rm -fr test

create () {
	rm -f .git/index
	mark="$1"
	shift
	num=0
	for t
	do
		num=$(($num+1))
		rm -fr "$num"
		case "$t" in
		D)
			mkdir "$num"; t="$num/$num" ;;
		F)
			t="$num" ;;
		esac
		echo "$mark" >"$t"
		git add "$t"
	done
	git commit -m "$mark: $*"
}

mkdir test || exit
cd test
git init-db

create O D D D D F F F F
git tag O
git branch a
git branch b

rm -rf ?
git checkout a
create A D D F F D D F F
git tag A

rm -rf ?
git checkout b
create B D F D F D F D F
git tag B

rm -rf ?
git checkout a
git read-tree -m O A B

git ls-files -s
