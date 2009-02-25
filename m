From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] [TOPGIT] implement linearize export method
Date: Wed, 25 Feb 2009 21:04:00 +0100
Message-ID: <1235592240-12616-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090225195856.GA12372@pengutronix.de>
 <1235592240-12616-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1235592240-12616-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1235592240-12616-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <1235592240-12616-4-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 21:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcQ0w-0007ne-S3
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 21:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758435AbZBYUEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Feb 2009 15:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758361AbZBYUEO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 15:04:14 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45156 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758165AbZBYUEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 15:04:02 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0002lj-Ca
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1LcPz6-0003I3-94
	for git@vger.kernel.org; Wed, 25 Feb 2009 21:04:00 +0100
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1235592240-12616-4-git-send-email-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111487>

This is a draft that seems to work for my test case.  The error handlin=
g
is to be improved though.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 tg-export.sh |   67 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++-
 1 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index dea24d9..748ca54 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -27,8 +27,10 @@ while [ -n "$1" ]; do
 		driver=3Dquilt;;
 	--collapse)
 		driver=3Dcollapse;;
+	--linearize)
+		driver=3Dlinearize;;
 	-*)
-		echo "Usage: tg [...] export ([--collapse] NEWBRANCH | [-b BRANCH1,B=
RANCH2...] --quilt DIRECTORY)" >&2
+		echo "Usage: tg [...] export ([--collapse] NEWBRANCH | [-b BRANCH1,B=
RANCH2...] --quilt DIRECTORY | --linearize NEWBRANCH)" >&2
 		exit 1;;
 	*)
 		[ -z "$output" ] || die "output already specified ($output)"
@@ -195,10 +197,60 @@ quilt()
 	fi
 }
=20
+linearize()
+{
+	if test ! -f "$playground/^BASE"; then
+		head=3D"$(git rev-parse --verify "$_dep")"
+		echo "$head" > "$playground/^BASE"
+		git checkout -q "$head"
+		return;
+	fi;
+
+	head=3D$(git rev-parse --verify HEAD)
+
+	if [ -z "$_dep_is_tgish" ]; then
+		# merge in $_dep unless already included
+		rev=3D"$(git rev-parse --verify "$_dep")";
+		common=3D"$(git merge-base --all HEAD "$_dep")";
+		if test "$rev" =3D "$common"; then
+			# already included, just skip
+			:;
+		else
+			git merge -s recursive "$_dep";
+			retmerge=3D"$?";
+			if test "x$retmerge" !=3D "x0"; then
+				echo fix up the merge, commit and then exit;
+				#todo error handling
+				sh -i
+			fi;
+		fi;
+	else
+		git merge-recursive "$(pretty_tree "refs/top-bases/$_dep")" -- HEAD =
"$(pretty_tree "refs/heads/$_dep")";
+		retmerge=3D"$?";
+
+		if test "x$retmerge" !=3D "x0"; then
+			echo "fix up the merge and update the index.  Don't commit!"
+			#todo error handling
+			sh -i
+		fi
+
+		result_tree=3D$(git write-tree)
+		# testing branch_empty might not always give the right answer.
+		# It can happen that the patch is non-empty but still after
+		# linearizing there is no change.  So compare the trees.
+		if test "x$result_tree" =3D "x$(git rev-parse $head^{tree})"; then
+			echo "skip empty commit $_dep";
+		else
+			newcommit=3D$(create_tg_commit "$_dep" "$result_tree" HEAD)
+			git update-ref HEAD $newcommit $head
+			echo "exported commit $_dep";
+		fi
+	fi
+}
=20
 ## Machinery
=20
-if [ "$driver" =3D "collapse" ]; then
+if [ "$driver" =3D "collapse" ] || [ "$driver" =3D "linearize" ]; then
 	[ -n "$output" ] ||
 		die "no target branch specified"
 	! ref_exists "$output"  ||
@@ -247,6 +299,17 @@ if [ "$driver" =3D "collapse" ]; then
 elif [ "$driver" =3D "quilt" ]; then
 	depcount=3D"$(cat "$output/series" | wc -l)"
 	echo "Exported topic branch $name (total $depcount topics) to directo=
ry $output"
+
+elif [ "$driver" =3D "linearize" ]; then
+	git checkout -q -b $output
+
+	echo $name
+	if test $(git rev-parse "$(pretty_tree $name)^{tree}") !=3D $(git rev=
-parse "HEAD^{tree}"); then
+		echo "Warning: Exported result doesn't match";
+		echo "tg-head=3D$(git rev-parse "$name"), exported=3D$(git rev-parse=
 "HEAD")";
+		#git diff $head HEAD;
+	fi;
+
 fi
=20
 # vim:noet
--=20
1.5.6.5
