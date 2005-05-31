From: =?utf-8?q?Santi_B=C3=A9jar?= <sbejar@gmmail.es>
Subject: [COGITO PATCH] Heads and tags in subdirectories
Date: Wed, 01 Jun 2005 00:00:35 +0200
Message-ID: <87is0zginw.fsf@ifae.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jun 01 00:00:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdEm0-0001uv-D8
	for gcvg-git@gmane.org; Tue, 31 May 2005 23:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVEaWCR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 May 2005 18:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVEaWCQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 18:02:16 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:37595 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S261655AbVEaWAq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 18:00:46 -0400
Received: from bela (ifae-s1.ifae.es [192.101.162.148])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id j4VM0YZ21935
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 00:00:35 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Keep heads and tags in their respective subtirectoris named as
the branch. This fixes the case where two repositoris have tags
with the same name.

Add a "-a" flag to cg-pull to download all the repositories heads,
so you can now do a "cg-log -r repo#branch" (cg-Xnormid repo#branch
job).

The transition is automatic when you do the first "cg-pull repo".

Signed-off-by: "Santi B=C3=A9jar" <sbejar@gmmail.es>

 cg-Xnormid |   14 ++++++++++-
 cg-commit  |    7 +++++
 cg-pull    |   72 +++++++++++++++++++++++++++++++++++++---------------=
---------
 3 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -16,15 +16,25 @@
=20
 id=3D"$1"
=20
+repo=3D$(echo $id | cut -d '#' -f 1)
+(echo $repo | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
+	die "name contains invalid characters"
+id=3D$(echo $id | sed 's@#@/@')
+
 if [ ! "$id" ] || [ "$id" =3D "this" ] || [ "$id" =3D "HEAD" ]; then
 	read id < "$_git/HEAD"
=20
-elif [ -r "$_git/refs/tags/$id" ]; then
+elif [ -r "$_git/refs/tags/$id" ] && [ ! -d "$_git/refs/tags/$id" ]; t=
hen
 	read id < "$_git/refs/tags/$id"
=20
-elif [ -r "$_git/refs/heads/$id" ]; then
+elif [ -r "$_git/refs/heads/$id" ] && [ ! -d "$_git/refs/tags/$id" ]; =
then
 	read id < "$_git/refs/heads/$id"
=20
+elif [ -r "$_git/branches/$id" ]; then
+	repobranch=3D$(cat "$_git/branches/$id" | cut -d '#' -f 2 -s)
+	repobranch=3D${repobranch:-master}
+	read id < "$_git/refs/heads/$id/$repobranch"
+
 # Short id's must be lower case and at least 4 digits.
 elif [[ "$id" =3D=3D [0-9a-z][0-9a-z][0-9a-z][0-9a-z]* ]]; then
 	idpref=3D${id:0:2}
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -141,7 +141,12 @@ if [ "$merging" ]; then
 	[ "$msgs" ] && echo -n 'Merge with '
 	[ -s $_git/merging-sym ] || cp $_git/merging $_git/merging-sym
 	for sym in $(cat $_git/merging-sym); do
-		uri=3D$(cat $_git/branches/$sym)
+		repo=3D$(echo $sym | cut -d '#' -f 1)
+		branch=3D$(echo $sym | cut -d '#' -f 2 -s)
+		uri=3D$(cat $_git/branches/$repo)
+		uribranch=3D$(echo $uri | cut -d '#' -f 2 -s)
+		[ -z "$uribranch" ] && [ -n "$branch" ] &&
+		[ "$branch" !=3D master ] && uri=3D${uri}#$branch
 		[ "$uri" ] || uri=3D"$sym"
 		echo "$uri" >>$LOGMSG
 		[ "$msgs" ] && echo "$uri"
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -6,23 +6,41 @@
 # Takes the branch name as an argument, defaulting to "origin".
 #
 # See `cg-branch-add` for some description.
+#
+# OPTIONS
+# -------
+# -a::
+#       Pull all the heads from repositori.
=20
-USAGE=3D"cg-pull [BRANCH_NAME]"
+USAGE=3D"cg-pull [-a] [BRANCH_NAME]"
=20
 . ${COGITO_LIB}cg-Xlib
=20
-name=3D$1
-
+[ "$1" =3D=3D "-a" ] && all=3Dyes && shift
+name=3D$1 && shift
=20
 [ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=3Dorigin; }
 [ "$name" ] || die "where to pull from?"
-uri=3D$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch=
: $name"
=20
-rembranch=3Dmaster
+repo=3D$(echo $name | cut -d '#' -f 1)
+repobranch=3D$(echo $name | cut -s -d '#' -f 2)
+
+uri=3D$(cat "$_git/branches/$name" 2>/dev/null) || die "unknown branch=
: $name"
 if echo "$uri" | grep -q '#'; then
+	[ -z "$repobranch" ] && repobranch=3D$(echo $uri | cut -d '#' -f 2)
 	rembranch=3D$(echo $uri | cut -d '#' -f 2)
 	uri=3D$(echo $uri | cut -d '#' -f 1)
 fi
+repobranch=3D${repobranch:-master}
+branch=3D$repo/$repobranch
+[ "$all" ] && repobranch=3D
+
+# So long we have:
+# $repo       =3D name of the repositori
+# $uri        =3D uri of the repositori
+# $repobranch =3D name of the branch in the repositori
+#               empty if we want all the branches
+# $branch     =3D name of the local branch in refs/heads/
=20
 pull_progress() {
 	percentage=3D""
@@ -232,39 +250,37 @@ fi
=20
=20
 orig_head=3D
-[ -s "$_git/refs/heads/$name" ] && orig_head=3D$(cat "$_git/refs/heads=
/$name")
-
+[ -s "$_git/refs/heads/$branch" ] && orig_head=3D$(cat "$_git/refs/hea=
ds/$branch")
=20
-mkdir -p $_git/refs/heads
-rsyncerr=3D
-$fetch -i "$uri/refs/heads/$rembranch" "$_git/refs/heads/$name" || rsy=
ncerr=3D1
-if [ "$rsyncerr" ]; then
-	rsyncerr=3D
-	$fetch -s "$uri/heads/$rembranch" "$_git/refs/heads/$name" || rsyncer=
r=3D1
-fi
-if [ "$rsyncerr" ] && [ "$rembranch" =3D "master" ]; then
-	rsyncerr=3D
-	$fetch -s "$uri/HEAD" "$_git/refs/heads/$name" || rsyncerr=3D1
+# 2005/05 Convert old layout
+[ -f $_git/refs/heads/$repo ] && orig_head=3D$(cat $_git/refs/heads/$r=
epo) &&
+rm -f $_git/refs/heads/$repo
+
+mkdir -p $_git/refs/heads/$repo
+if [ "$repobranch" ] ; then
+    $fetch -i "$uri/refs/heads/$repobranch" "$_git/refs/heads/$branch"=
 ||
+    $fetch -s "$uri/heads/$repobranch" "$_git/refs/heads/$branch" ||
+    { [ "$repobranch" =3D "master" ] && $fetch -s "$uri/HEAD" "$_git/r=
efs/heads/$branch"; } ||
+    rsyncerr=3D1
+else
+    $fetch -i -d "$uri/refs/heads" "$_git/refs/heads/$repo" ||
+    $fetch -s -d "$uri/heads" "$_git/refs/heads/$repo" ||
+    rsyncerr=3D1
 fi
-[ "$rsyncerr" ] && die "unable to get the head pointer of branch $remb=
ranch"
+[ "$rsyncerr" ] && die "unable to get the head pointer of branch $repo=
branch"
=20
 [ -d $_git_objects ] || mkdir -p $_git_objects
-$pull "$name" "$uri" || die "objects pull failed"
+$pull "$branch" "$uri" || die "objects pull failed"
=20
-# FIXME: Warn about conflicting tag names?
 # XXX: We now throw stderr to /dev/null since not all repositories
 # may have tags/ and users were confused by the harmless errors.
-[ -d $_git/refs/tags ] || mkdir -p $_git/refs/tags
+[ -d $_git/refs/tags/$repo ] || mkdir -p $_git/refs/tags/$repo
 rsyncerr=3D
-$fetch -i -s -u -d "$uri/refs/tags" "$_git/refs/tags" || rsyncerr=3D1
-if [ "$rsyncerr" ]; then
-	rsyncerr=3D
-	$fetch -i -s -u -d "$uri/tags" "$_git/refs/tags" || rsyncerr=3D1
-fi
+$fetch -i -s -u -d "$uri/refs/tags" "$_git/refs/tags/$repo" ||
+$fetch -i -s -u -d "$uri/tags" "$_git/refs/tags/$repo" || rsyncerr=3D1
 [ "$rsyncerr" ] && echo "unable to get tags list (non-fatal)" >&2
=20
-
-new_head=3D$(cat "$_git/refs/heads/$name")
+new_head=3D$(cat "$_git/refs/heads/$branch")
=20
 if [ ! "$orig_head" ]; then
 	echo "New branch: $new_head"

