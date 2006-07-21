From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [RFC/PATCH] Per branch properties for pull
Date: Fri, 21 Jul 2006 16:51:53 +0200
Message-ID: <87hd1b9fjq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jul 21 16:52:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3wME-0001CE-7F
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 16:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWGUOvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 21 Jul 2006 10:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWGUOvt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 10:51:49 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:34273 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1750755AbWGUOvt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jul 2006 10:51:49 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k6LDptd02663
	for <git@vger.kernel.org>; Fri, 21 Jul 2006 15:51:56 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24053>


It extracts all the information for pull from the config file.

If you have a config file as:

[branch "master"]
        remote=3Dorigin
        merge=3Dnext          #the remote name
        octopus=3Doctopus
        twohead=3Drecursive

When doing a "git pull" without extra parameters in the master branch
it will fetch the origin remote repository and will merge the next
branch (the remote name).

And you can also put the equivalent of the pull.{octopus,twohead}
options for each branch.

This only changes the behavour when these keys exist and when
git-pull is used without extra parameters.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>

---

Hi *,

   Now that we have the arbitrary keys in the config file...

   It does not affect the integrator that pulls from different
   places. I don't know exactly what is needed but just for discuss it
   could be something as:

[branch "master"]
        remote=3Dnet
        remote=3Data
        merge=3Dfor-linus from ata
        merge=3Dupstream from net

diff --git a/git-pull.sh b/git-pull.sh
index f380437..e7630b1 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -44,6 +44,14 @@ do
 	shift
 done
=20
+if [ $# -eq 0 ] ; then
+    default=3Dyes
+    curr_branch=3D$(git-symbolic-ref HEAD)
+    curr_branch=3D${curr_branch##refs/heads/}
+    remote=3D$(git-repo-config --get "branch.$curr_branch.remote")
+    test "$remote" && set x "$remote" && shift
+fi
+
 orig_head=3D$(git-rev-parse --verify HEAD) || die "Pulling into a blac=
k hole?"
 git-fetch --update-head-ok --reflog-action=3Dpull "$@" || exit 1
=20
@@ -70,9 +78,19 @@ to recover.'
=20
 fi
=20
+if [ "$default" =3D=3D yes ] ; then
+    merge_head=3D$(git repo-config --get-all "branch.$curr_branch.merg=
e")
+    for ref in $merge_head ; do
+	refspec=3D$(git-repo-config --get "remote.$remote.fetch" "^$ref:")
+	[ -z "$refspec" ] && die "Branch $ref does not exist in the repositor=
y: $remote."
+	locref=3D"$locref ${refspec##$ref:}"
+    done
+    merge_head=3D$locref
+else
 merge_head=3D$(sed -e '/	not-for-merge	/d' \
 	-e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | \
 	tr '\012' ' ')
+fi
=20
 case "$merge_head" in
 '')
@@ -85,6 +103,11 @@ case "$merge_head" in
 	then
 		strategy_default_args=3D"-s $var"
 	fi
+	var=3D`git-repo-config --get branch.$curr_branch.octopus`
+	if test -n "$var"
+	then
+		strategy_default_args=3D"-s $var"
+	fi
 	;;
 *)
 	var=3D`git-repo-config --get pull.twohead`
@@ -92,6 +115,11 @@ case "$merge_head" in
         then
 		strategy_default_args=3D"-s $var"
 	fi
+	var=3D`git-repo-config --get branch.$curr_branch.twohead`
+	if test -n "$var"
+        then
+		strategy_default_args=3D"-s $var"
+	fi
 	;;
 esac
=20
