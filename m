From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH] bisect: use update-ref to update refs
Date: Wed, 28 Mar 2007 14:35:20 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070328123519.GA4472@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 14:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWXNE-0004Du-K8
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 14:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbXC1MfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 28 Mar 2007 08:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbXC1MfY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 08:35:24 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:57121 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751498AbXC1MfX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2007 08:35:23 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HWXN4-0007dX-NP
	for git@vger.kernel.org; Wed, 28 Mar 2007 14:35:22 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l2SCZKMK015486
	for <git@vger.kernel.org>; Wed, 28 Mar 2007 14:35:20 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l2SCZK5N015485
	for git@vger.kernel.org; Wed, 28 Mar 2007 14:35:20 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.14+cvs20070321 (2007-03-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43371>

update-ref is safer than manualy echoing values to various files in
$GIT_DIR/refs/heads/.

bisect predates update-ref and was never updated to use the latter.

Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
---

There are some style nits in git-bisect.sh that I found while producing=
 that
patch.  E.g. the 3rd hunk shows=20

	GIT_DIR=3D"$GIT_DIR" git-$command ...

where the assignment to GIT_DIR should be superfluous?  In some places
git-command is used, and in other git command.

 git-bisect.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index a12ea31..1589870 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -90,7 +90,7 @@ bisect_bad() {
 	*)
 		usage ;;
 	esac || exit
-	echo "$rev" >"$GIT_DIR/refs/bisect/bad"
+	git update-ref "refs/bisect/bad" "$rev"
 	echo "# bad: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
 	echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
 	bisect_auto_next
@@ -106,7 +106,7 @@ bisect_good() {
 	for rev in $revs
 	do
 		rev=3D$(git-rev-parse --verify "$rev^{commit}") || exit
-		echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
+		git update-ref "refs/bisect/good-$rev" "$rev"
 		echo "# good: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
 		echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
 	done
@@ -159,9 +159,10 @@ bisect_next() {
 		nr=3D"$nr_good";
 	fi;
 	echo "Bisecting: maximal $nr revisions left to test"
-	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
+	git update-ref refs/heads/new-bisect "$rev"
 	git checkout -q new-bisect || exit
-	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
+	git update-ref refs/heads/bisect "$rev" &&
+	git update-ref -d refs/heads/new-bisect "$rev" &&
 	GIT_DIR=3D"$GIT_DIR" git-symbolic-ref HEAD refs/heads/bisect
 	git-show-branch "$rev"
 }
@@ -211,12 +212,12 @@ bisect_replay () {
 			eval "$cmd"
 			;;
 		good)
-			echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
+			git update-ref "refs/bisect/good-$rev" "$rev"
 			echo "# good: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
 			echo "git-bisect good $rev" >>"$GIT_DIR/BISECT_LOG"
 			;;
 		bad)
-			echo "$rev" >"$GIT_DIR/refs/bisect/bad"
+			git update-ref "refs/bisect/bad" "$rev"
 			echo "# bad: "$(git-show-branch $rev) >>"$GIT_DIR/BISECT_LOG"
 			echo "git-bisect bad $rev" >>"$GIT_DIR/BISECT_LOG"
 			;;
--=20
1.5.0.2.260.g2eb065


--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
