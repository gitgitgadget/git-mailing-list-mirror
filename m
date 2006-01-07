From: Junio C Hamano <junkio@cox.net>
Subject: Re: needs merge
Date: Sat, 07 Jan 2006 13:06:49 -0800
Message-ID: <7vy81reoie.fsf@assigned-by-dhcp.cox.net>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A1336F@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Jan 07 22:07:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvLHJ-0001MY-S6
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 22:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030582AbWAGVGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 16:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWAGVGx
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 16:06:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64762 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030578AbWAGVGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 16:06:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107210656.JYBT25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 16:06:56 -0500
To: "Brown, Len" <len.brown@intel.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14276>

"Brown, Len" <len.brown@intel.com> writes:

> yes, it did the right thing to the source.
>
> as a user, "cute" isn't the first word that comes to mind:-)

Fair enough.  I agree that it is rather unnerving from the
user's point of view, especially because the "recursive merging
of the ancestors" part is not trivially obvious why it works.

The issue it tries to address (and the other merge strategy,
"resolve", addresses a bit differently) is to detect when two
sides of criss-cross merged branches resolved the same conflicts
differently in the past.  When merging E and F in this ancestry
graph:

             A----C---E----?
            / \  /        /
           /   \/        /
          /    /\       /
         /    /  \     /
        O----B----D---F

suppose that A and B made conflicting modifications on path P, C
and D resolved the conflicts by taking its own side, and E and F
further made independent changes to the path.  

When we try to merge E and F, if we happen to pick B as the
merge base, normal three-way merge between E and F using B as
base would say that E has change between B and C while F's
version stayed the same in the area that change touches, and you
would end up with merge result that is diff(D,F) on top of E.
If we used A, then the result would be diff(C,E) on top of F.
Doing either of these silently is not desirable [*1*].

When we use a tree that is an automerge (with conflict markers)
between A and B as the merge base for E and F, what happens is
that the three-way merge notices the part with conflict markers
as a whole is rewritten to one version in E and to another in F,
removes the original (which is the conflicting merge between A
and B) and replaces that with conflicts between E and F with its
own conflict markers, so decision to resolve the conflicting
merge between A and B which C and D resolved differently is
given to the user who tries to merge E and F.

If C and D resolved the conflicting merge the same way, the
"phantom conflict" you observed still happens while merging A
and B to come up with the merge base tree, but the part will be
rewritten the same way in both E and F, so the result will merge
cleanly.

[Footnote]

*1* While I was trying out the above scenario, I noticed that
resolve strategy does not notice this and ended up picking one
ancestor at random.  I think this is because case #16 covers
only the case where the path P is not changed between C and E
and D and F, and case #11 must pick an ancestor and picks one at
random.  Daniel, any thoughts on this?

-- >8 --
#!/bin/sh

unset GIT_DIR GIT_OBJECT_DIRECTORY
test -d .git || {
	echo Run this in a newly created empty directory please.
	exit 1
}

: <<\EOF

	Criss Cross Merge

             A----C---E----?
            / \  /        /
           /   \/        /
          /    /\       /
         /    /  \     /
        O----B----D---F

EOF

git init-db

for l in a b c d e f g h i j k l m n o p q r s t u v w x y z
do
	echo $l
done >testfile
git add testfile
git commit -m 'Initial'
git tag O
git branch bottom
git checkout -b top
cp testfile testfile.orig
tr 'm-p' 'M-P' <testfile.orig >testfile
git update-index testfile
git commit -m A
git tag A
git checkout bottom
tr 'm-p' 'A-D' <testfile.orig >testfile
git update-index testfile
git commit -m B
git tag B
git merge -s ours 'D=A+B=B' HEAD A
git tag D
git checkout top
git merge -s ours 'C=A+B=A' HEAD B
git tag C
mv testfile j; tr 'a' 'A' <j >testfile; rm -f j
git update-index testfile
git commit -m E
git tag E
git checkout bottom
mv testfile j; tr 'z' 'Z' <j >testfile; rm -f j
git update-index testfile
git commit -m F
git tag F

rm -f testfile.orig

git checkout master
git reset --hard A
git merge -s resolve V HEAD B
git update-index testfile
git commit -m 'V'
git tag V

git show-branch

git checkout top
echo "** RECURSIVE **"
git merge -s recursive recursive HEAD F
echo theirs
git diff --theirs
echo ours
git diff --ours

git reset --hard
echo "** RESOLVE **"
git merge -s resolve resolve HEAD F

echo theirs
git diff HEAD^2
echo ours
git diff HEAD^
