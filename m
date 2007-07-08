From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-tree: sometimes, d/f conflict is not an issue
Date: Sun, 08 Jul 2007 13:02:38 -0700
Message-ID: <7v8x9q1x5t.fsf@assigned-by-dhcp.cox.net>
References: <20070405071615.2915.6837.reportbug@acer>
	<20070607074357.27760.qmail@69aef7b888effd.315fe32.mid.smarden.org>
	<6b8a91420706070252y3fd581a3w427d91e5b982d29d@mail.gmail.com>
	<20070613091624.26463.qmail@353090644b4917.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131354250.4059@racer.site>
	<20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0706131543140.4059@racer.site>
	<20070625071819.8091.qmail@5e4088a43a10fd.315fe32.mid.smarden.org>
	<Pine.LNX.4.64.0707080148370.4093@racer.site>
	<7vabu765r0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707080248320.4093@racer.site>
	<7v644v5tr3.fsf@assigned-by-dhcp.cox.net>
	<7vwsxb4e2q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707081353560.4248@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org,
	=?utf-8?Q?R?= =?utf-8?Q?=C3=A9mi?= Vanicat <vanicat@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 22:02:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7cy0-00051A-PG
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 22:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032AbXGHUCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Jul 2007 16:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755658AbXGHUCl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 16:02:41 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:43937 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755915AbXGHUCk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jul 2007 16:02:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070708200239.HWOP1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Jul 2007 16:02:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id M82f1X0021kojtg0000000; Sun, 08 Jul 2007 16:02:39 -0400
In-Reply-To: <Pine.LNX.4.64.0707081353560.4248@racer.site> (Johannes
	Schindelin's message of "Sun, 8 Jul 2007 14:16:38 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51912>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Besides, IMHO there is a deeper issue. Since merge-recursive started =
out=20
> as a Python script, and grew there until it was usable, and grew the=20
> rename detection therein, too, until it was finally converted to C, i=
t=20
> accumulated a lot of features that would have been nice to have=20
> independently.
> ...
> So there we are, with two really big and unwieldy chunks of code, eac=
h=20
> deserving an own GSoC project to clean them up.  Or maybe not even a =
GSoC=20
> project, but a longer project.

I would not disagree that tree merging part is a large piece of
code with nontrivial development history.  While I do agree that
merge-tree approach is attractive in the longer run, I do not
think the current "use read-tree for policy-neutral merge and
then higher level to decide what to do with conflicts" is beyond
repair.

I tried a variant of cherry-pick that does _not_ use
merge-recursive on the reproduction recipe from Gerrit & R=C3=A9mi.
Essentially, a cherry-pick with a backend is:

	git-merge-$backend $commit^ -- HEAD $commit

It was made cumbersome to try different merge backend when
cherry-pick has become built-in, but the above essentially was
what we had in the shell script version. =20

Interestingly, git-merge-resolve fails, but for an entirely
different reason; there is a bug in git-merge-one-file.  I am
kind of surprised that this has been left undetected for a long
time (this shows how everybody uses git-merge-recursive these
days and not git-merge-resolve).  commit ed93b449 adds tests for
only the "read-tree" part, even though it makes "matching"
change to merge-one-file, which was the breakage.  The bug is
that merge-one-file did not "resolve" an unmerged index entry
when it decided what the result should be --- it decided only in
its comments but not with what it does!  Embarrassing (a fix is
attached).

With that fix, the above "cherry-pick" lookalike with $backend
set to "resolve" and $commit set to "branch" in Gerrit's example
reproduction recipe seems to do the right thing.

> As it is, both unpack_trees() and merge-recursive have a certain degr=
ee of=20
> not-quite duplicated yet wants-to-do-largely-the-same functionality. =
=20
> Which of course leads to much finger pointing: "it's unpack_trees() f=
ault.=20
> no. it's merge-recursive's fault. no, vice versa."

I do not think there is any pointing-fingers involved in this
case.  The division of labor between "read-tree -m" and its
caller has been very clear from the beginning, and has not
changed.  The former does "uncontroversial parts of merge", and
the latter uses its own policy decision to resolve conflicts.

The "uncontroversial parts of merge" explicitly exclude "one
side removes (or adds), other side does not do anything" case.
This is cumbersome for rename-unaware merge-resolve, because its
policy is "we do not worry about the case that the apparent
removal is in fact it moves it to somewhere else -- if one side
removes, the result will not have it", and for that policy if
"read-tree -m" did so it would have less work to do.  But we
don't, exactly because other policy like merge-recursive may
want to look at the apparently removed path and figure out if
there is a rename involved.

The last time I looked at merge-recursive.c, I think the problem
I saw was the way it maintains and uses two lists that keeps
track of the set of directories and files; get_files_dirs() is
called for both head and merge at the beginning, and I did not
see a code that says "Oh, we recorded the path 'link' as being
potentially a directory at the beginning, but we have decided to
resolve 'link/file' by removing it, and 'link' does not have to
exist as a directory anymore. resolving 'link' as a symbolic
link is perfectly fine" --- and the reason Gerrit's test case
fails was something like that.

-- >8 --
[PATCH] Fix merge-one-file for our-side-added/our-side-removed cases

When commit ed93b449 changed the script so that it does not
touch untracked working tree file, we forgot that we still
needed to resolve the index entry (otherwise they are left
unmerged).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index ebbb575..1e7727d 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -27,8 +27,9 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# read-tree checked that index matches HEAD already,
 		# so we know we do not have this path tracked.
 		# there may be an unrelated working tree file here,
-		# which we should just leave unmolested.
-		exit 0
+		# which we should just leave unmolested.  Make sure
+		# we do not have it in the index, though.
+		exec git update-index --remove -- "$4"
 	fi
 	if test -f "$4"; then
 		rm -f -- "$4" &&
@@ -42,7 +43,8 @@ case "${1:-.}${2:-.}${3:-.}" in
 #
 ".$2.")
 	# the other side did not add and we added so there is nothing
-	# to be done.
+	# to be done, except making the path merged.
+	exec git update-index --add --cacheinfo "$6" "$2" "$4"
 	;;
 "..$3")
 	echo "Adding $4"
@@ -50,7 +52,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: untracked $4 is overwritten by the merge."
 		exit 1
 	}
-	git update-index --add --cacheinfo "$6$7" "$2$3" "$4" &&
+	git update-index --add --cacheinfo "$7" "$3" "$4" &&
 		exec git checkout-index -u -f -- "$4"
 	;;
=20
