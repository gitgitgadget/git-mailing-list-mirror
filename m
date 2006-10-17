From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCHv2] git-branch: Set branch properties
Date: Tue, 17 Oct 2006 16:47:07 +0200
Message-ID: <87y7rf80es.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Oct 17 16:47:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZqDs-0006iM-1J
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 16:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWJQOrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 10:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWJQOrL
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 10:47:11 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:55180 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751123AbWJQOrK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 10:47:10 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k9HEl8J21461
	for <git@vger.kernel.org>; Tue, 17 Oct 2006 16:47:08 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29083>


Added a flag to git-branch (-c) that makes git-branch to write the
config (branch properties) for the new branch so it will pull the same
branch it branched from.

If you want to work in the 'next' branch of git.git:

$ git clone git://git.kernel.org/pub/scm/git/git.git
$ cd git
$ git branch -c mynext origin next
$ tail -n 3 .git/config
[branch "mynext"]
        remote =3D origin
        merge =3D refs/heads/next
$ git branch -c secondnext next
$ tail -n 3 .git/config
[branch "secondnext"]
        remote =3D .
        merge =3D next

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---

 Hi,

   it needs the get_ref_for_remote_branch function in
   git-parse-remote.sh that is with the patch:

   [RFC/PATCH] git-fetch: Use already fetched branch with the --local
   flag

   Also, this does not apply cleanly in next, the change in next is and
   the resolution trivial:

 <	rm -f "$GIT_DIR/logs/refs/heads/$branch_name"
 <	rm -f "$GIT_DIR/refs/heads/$branch_name"
 >	git update-ref -d "refs/heads/$branch_name" "$branch"

 What I have to do? Send the postimage or what?

 Another questions is about rerere: Can it be done at the hunk level? W=
e
 could record the git-patch-id of the conflict and the postimage.

 Documentation/git-branch.txt |   12 ++++++++++--
 git-branch.sh                |   30 +++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index d43ef1d..77bbf81 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-branch' [-r]
-'git-branch' [-l] [-f] <branchname> [<start-point>]
+'git-branch' [-l] [-f] [-c] <branchname> [<start-point> | <remote> <re=
motebranch>]
 'git-branch' (-d | -D) <branchname>...
=20
 DESCRIPTION
@@ -18,7 +18,8 @@ With no arguments given (or just `-r`) a
 will be shown, the current branch will be highlighted with an asterisk=
=2E
=20
 In its second form, a new branch named <branchname> will be created.
-It will start out with a head equal to the one given as <start-point>.
+It will start out with a head equal to the one given as <start-point>,
+or from branch <remotebranch> of the repository <remote>.
 If no <start-point> is given, the branch will be created with a head
 equal to that of the currently checked out branch.
=20
@@ -26,9 +27,16 @@ With a `-d` or `-D` option, `<branchname
 specify more than one branch for deletion.  If the branch currently
 has a ref log then the ref log will also be deleted.
=20
+With a `-c` option, the branch properties `branch.<branchname>.remote`
+and `branch.<branchname>.merge` will be set.
+
=20
 OPTIONS
 -------
+-c::
+	Write the branch properties `branch.<branchname>.remote`
+	and `branch.<branchname>.merge`.
+
 -d::
 	Delete a branch. The branch must be fully merged.
=20
diff --git a/git-branch.sh b/git-branch.sh
index 4f31903..afd768a 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,9 +1,10 @@
 #!/bin/sh
=20
-USAGE=3D'[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-po=
int>]] | -r'
+USAGE=3D'[-l] [(-d | -D) <branchname>] | [[-f] [-c] <branchname> [<sta=
rt-point> | <remote> <remotebranch>]] | -r'
 LONG_USAGE=3D'If no arguments, show available branches and mark curren=
t branch with a star.
 If one argument, create a new branch <branchname> based off of current=
 HEAD.
-If two arguments, create a new branch <branchname> based off of <start=
-point>.'
+If two arguments, create a new branch <branchname> based off of <start=
-point>.
+If three arguments, create a new branch <branchname> based off the bra=
nch <remotebranch> of the repository <remote>.'
=20
 SUBDIRECTORY_OK=3D'Yes'
 . git-sh-setup
@@ -44,6 +45,8 @@ If you are sure you want to delete it, r
 	esac
 	rm -f "$GIT_DIR/logs/refs/heads/$branch_name"
 	rm -f "$GIT_DIR/refs/heads/$branch_name"
+	git repo-config --unset branch."$branchname".remote
+	git repo-config --unset-all branch."$branchname".merge
 	echo "Deleted branch $branch_name."
     done
     exit 0
@@ -71,6 +74,9 @@ do
 	-f)
 		force=3D"$1"
 		;;
+	-c)
+		config=3D"yes"
+		;;
 	-l)
 		create_log=3D"yes"
 		;;
@@ -101,9 +107,21 @@ case "$#" in
 	done
 	exit 0 ;;
 1)
+	remote=3D"."
+	remote_branch=3D"$headref"
 	head=3DHEAD ;;
 2)
+	remote=3D"."
+	remote_branch=3D"$2"
 	head=3D"$2^0" ;;
+3)
+	remote=3D"$2"
+	remote_branch=3D"$3"
+	. git-parse-remote
+	ref=3D$(get_ref_for_remote_branch "$remote" "$remote_branch")
+	[ -z "$ref" ] && remote_branch=3D"refs/heads/$remote_branch" && \
+		ref=3D$(get_ref_for_remote_branch "$remote" "$remote_branch")
+	head=3D"$ref^0";;
 esac
 branchname=3D"$1"
=20
@@ -137,4 +155,10 @@ then
 	mkdir -p $(dirname "$GIT_DIR/logs/refs/heads/$branchname")
 	touch "$GIT_DIR/logs/refs/heads/$branchname"
 fi
-git update-ref -m "branch: Created from $head" "refs/heads/$branchname=
" $rev
+git update-ref -m "branch: Created from $head" "refs/heads/$branchname=
" $rev || exit $?
+
+if test "$config" =3D "yes"
+then
+	git repo-config branch."$branchname".remote "$remote"
+	git repo-config branch."$branchname".merge "$remote_branch"
+fi
--=20
1.4.2.4.g687a-dirty
