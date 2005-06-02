From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [COGITO PATCH]Re: Origin handling
Date: Thu, 02 Jun 2005 12:18:26 +0200
Message-ID: <87ll5trril.fsf@gmail.com>
References: <877jhdthhr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jun 02 12:16:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddmjr-00066z-Iy
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 12:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFBKSo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 2 Jun 2005 06:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVFBKSo
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 06:18:44 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:12222 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261363AbVFBKS0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 06:18:26 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j52AIMZ00581
	for <git@vger.kernel.org>; Thu, 2 Jun 2005 12:18:24 +0200
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <877jhdthhr.fsf@gmail.com> (
 =?utf-8?q?Santi_B=C3=A9jar's_message_of?= "Thu, 02 Jun 2005 08:12:00
 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I propose that the origin of a branch comes from a file in
=2Egit/branches/ of the same name. So the origin of default branch
master is the content of the file .git/branches/master that in
the current practice would be "origin". But we could have the
remote branch "git", being the origin of the local branch
"git_dirs" (the content of .git/branches/git_dirs =3D "git").

The origin branch is reserved. When you cg-clone the origin is now
called cloned (but "commit-id cloned" =3D "commit-id origin" while you =
do
not switch to another branch whith other origin). The transition from
old handling is not in the patch.

So now you can:

cg-clone -s rsync://rsync.kernel.org/pub/scm/git/git.git/

and work in this in your "master" branch with origin "cloned".

You can add another repository:

cg-branch-add pb http://pasky.or.cz/~pasky/dev/git/git-pb.git
cg-pull pb

and if you want to do some modifications based on pb:

cg-branch-add pb-sb pb
ln -s refs/heads/pb-sb .git/HEAD
commit-id pb > .git/HEAD
git-read-tree HEAD
git-checkout-cache -f -q -u -a

and work on your branch.

The last four lines are the work of the hipothetical cg-branch-switch.



Signed-off-by: "Santi B=C3=A9jar" <sbejar@gmail.com>

---

 cg-Xnormid    |    6 ++++++
 cg-branch-add |    2 +-
 cg-clone      |    2 +-
 cg-commit     |    7 ++++++-
 cg-init       |    9 +++++----
 cg-merge      |    7 ++++++-
 cg-pull       |    7 ++++++-
 7 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -6,6 +6,7 @@
 #
 # Strings resolve in this order:
 # 	NULL, this, HEAD  =3D> .git/HEAD
+# 	origin =3D> origin of the branch
 # 	<tags>
 # 	<heads>
 # 	short SHA1 (4 or more hex digits)
@@ -19,6 +20,11 @@ id=3D"$1"
 if [ ! "$id" ] || [ "$id" =3D "this" ] || [ "$id" =3D "HEAD" ]; then
 	read id < "$_git/HEAD"
=20
+elif [ "$id" =3D "origin" ]; then
+	branch=3D$(readlink $_git/HEAD | sed 's@refs/heads/@@')
+	origin=3D$(cat $_git/branches/$branch)
+	read id < "$_git/refs/heads/$origin"
+
 elif [ -r "$_git/refs/tags/$id" ]; then
 	read id < "$_git/refs/tags/$id"
=20
diff --git a/cg-branch-add b/cg-branch-add
--- a/cg-branch-add
+++ b/cg-branch-add
@@ -40,7 +40,7 @@ location=3D$2
 ([ "$name" ] && [ "$location" ]) || usage
 (echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
 	die "name contains invalid characters"
-if [ "$name" =3D "this" ] || [ "$name" =3D "HEAD" ]; then
+if [ "$name" =3D "this" ] || [ "$name" =3D "HEAD" ] || [ "$name" =3D "=
origin" ]; then
 	die "given branch name is reserved"
 fi
=20
diff --git a/cg-clone b/cg-clone
--- a/cg-clone
+++ b/cg-clone
@@ -56,4 +56,4 @@ fi
 trap "rm -rf $dir" SIGTERM EXIT
 cg-init $location || exit $?
 trap "" SIGTERM EXIT
-echo "Cloned to $dir/ (origin $location available as branch \"origin\"=
)"
+echo "Cloned to $dir/ (origin $location available as branch \"cloned\"=
)"
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -141,7 +141,12 @@ if [ "$merging" ]; then
 	[ "$msgs" ] && echo -n 'Merge with '
 	[ -s $_git/merging-sym ] || cp $_git/merging $_git/merging-sym
 	for sym in $(cat $_git/merging-sym); do
-		uri=3D$(cat $_git/branches/$sym)
+		if [ $sym =3D origin ] ; then
+			branch=3D$(readlink $_git/HEAD | sed 's@refs/heads/@@')
+			uri=3D$(cat $_git/branches/$branch)
+		else
+			uri=3D$(cat $_git/branches/$sym)
+		fi
 		[ "$uri" ] || uri=3D"$sym"
 		echo "$uri" >>$LOGMSG
 		[ "$msgs" ] && echo "$uri"
diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -26,15 +26,16 @@ mkdir $_git/branches
 touch $_git/refs/heads/master
=20
 if [ "$uri" ]; then
-	echo "$uri" >$_git/branches/origin
-	cg-pull origin || die "pull failed"
+	echo "$uri" >$_git/branches/cloned
+	echo cloned >$_git/branches/master
+	cg-pull cloned || die "pull failed"
=20
-	cp $_git/refs/heads/origin $_git/refs/heads/master
+	cp $_git/refs/heads/cloned $_git/refs/heads/master
 	git-read-tree HEAD
 	git-checkout-cache -a
 	git-update-cache --refresh
=20
-	echo "Cloned (origin $uri available as branch \"origin\")"
+	echo "Cloned (cloned $uri available as branch \"cloned\")"
 else
 	git-read-tree # Seed the dircache
 	find * \( -type f -o -type l \) -print0 | xargs -0r cg-add
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -14,10 +14,15 @@ USAGE=3D"cg-pull [BRANCH_NAME]"
 name=3D$1
=20
=20
-[ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=3Dorigin; }
+if [ -z "$name" ]; then
+	branch=3D$(readlink $_git/HEAD | sed 's@refs/heads/@@')
+	name=3D$(cat $_git/branches/$branch 2>/dev/null)
+fi
 [ "$name" ] || die "where to pull from?"
 uri=3D$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch=
: $name"
=20
+[ -e "$_git/branches/$uri" ] && die "local branches cannot pull"
+
 rembranch=3Dmaster
 if echo "$uri" | grep -q '#'; then
 	rembranch=3D$(echo $uri | cut -d '#' -f 2)

