From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] pull: fail early if we know we can't merge from upstream
Date: Thu, 11 Apr 2013 15:26:41 +0200
Message-ID: <1365686801-17206-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 15:26:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQHWe-0002AA-Vp
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 15:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934489Ab3DKN0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Apr 2013 09:26:45 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:50683 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S934370Ab3DKN0o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 09:26:44 -0400
Received: from cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by hessy.dwim.me (Postfix) with ESMTPA id 77CAE81E52
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 15:26:42 +0200 (CEST)
Received: (nullmailer pid 17242 invoked by uid 1000);
	Thu, 11 Apr 2013 13:26:41 -0000
X-Mailer: git-send-email 1.8.2.524.g8f8def7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220878>

A 'git pull' without specifying a remote is asked to take the current
branch's upstream as the branch to merge from. This cannot work
without an upstream configuration nor with HEAD detached, but we only
check for this after fetching.

Perform the check beforehand, as we already know whether we have
enough information to merge and can fail immediately otherwise.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 git-pull.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++---------=
--------
 1 file changed, 45 insertions(+), 17 deletions(-)

I can't quite decide whether the behaviour of 'git pull' with no
upstream configured but a default remote with no fetch refspecs
merging the remote's HEAD is a feature, a bug or something in between,
but it's used by t7409 so maybe someone else is using it and we
shouldn't break it.

There's another check that could be made earlier ('git pull
someremote' when that's not the branch's upstream remote), but then
you have to start figuring out what the flags to fetch are. I'll
revisit this at some point, but I wanted to get this out since it's
working.

diff --git a/git-pull.sh b/git-pull.sh
index 266e682..b62f5d3 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -43,6 +43,8 @@ log_arg=3D verbosity=3D progress=3D recurse_submodule=
s=3D
 merge_args=3D edit=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D"${curr_branch#refs/heads/}"
+upstream=3D$(git config "branch.$curr_branch_short.merge")
+remote=3D$(git config "branch.$curr_branch_short.remote")
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
 if test -z "$rebase"
 then
@@ -138,6 +140,47 @@ do
 	esac
 	shift
 done
+if test true =3D "$rebase"
+then
+    op_type=3Drebase
+    op_prep=3Dagainst
+else
+    op_type=3Dmerge
+    op_prep=3Dwith
+fi
+
+check_args_against_config () {
+	# If fetch gets user-provided arguments, the user is
+	# overriding the upstream configuration, so we have to wait
+	# for fetch to do its work to know if we can merge.
+	if [ $# -gt 0 ]; then
+		return
+	fi
+
+	# Figure out what remote we're going to be fetching from
+	use_remote=3Dorigin
+	if [ -n "$remote" ]; then
+		use_remote=3D"$remote"
+	fi
+
+	# If the remote doesn't have a fetch refspec, then we'll merge
+	# whatever fetch marks for-merge, same as above.
+	fetch=3D$(git config --get-all "remote.$use_remote.fetch")
+	if [ -z "$fetch" ]; then
+		return
+	fi
+
+	# The typical 'git pull' case where it should merge from the
+	# current branch's upstream. We can already check whether we
+	# we can do it. If HEAD is detached or there is no upstream
+	# branch, complain now.
+	if [ -z "$curr_branch_short" -o -z "$upstream" ]; then
+		. git-parse-remote
+		error_on_missing_default_upstream "pull" $op_type $op_prep \
+		    "git pull <remote> <branch>"
+		exit 1
+	fi
+}
=20
 error_on_no_merge_candidates () {
 	exec >&2
@@ -151,19 +194,6 @@ error_on_no_merge_candidates () {
 		esac
 	done
=20
-	if test true =3D "$rebase"
-	then
-		op_type=3Drebase
-		op_prep=3Dagainst
-	else
-		op_type=3Dmerge
-		op_prep=3Dwith
-	fi
-
-	curr_branch=3D${curr_branch#refs/heads/}
-	upstream=3D$(git config "branch.$curr_branch.merge")
-	remote=3D$(git config "branch.$curr_branch.remote")
-
 	if [ $# -gt 1 ]; then
 		if [ "$rebase" =3D true ]; then
 			printf "There is no candidate for rebasing against "
@@ -177,10 +207,6 @@ error_on_no_merge_candidates () {
 		echo "You asked to pull from the remote '$1', but did not specify"
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the comm=
and line."
-	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
-		. git-parse-remote
-		error_on_missing_default_upstream "pull" $op_type $op_prep \
-			"git pull <remote> <branch>"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${u=
pstream#refs/heads/}'"
 		echo "from the remote, but no such ref was fetched."
@@ -213,6 +239,8 @@ test true =3D "$rebase" && {
 		fi
 	done
 }
+
+check_args_against_config "$@"
 orig_head=3D$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-h=
ead-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
--=20
1.8.2.524.g8f8def7
