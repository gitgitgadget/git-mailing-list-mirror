From: Josh Triplett <josh@freedesktop.org>
Subject: [PATCH] Remove useless uses of cat, and replace with filename arguments
 or redirection
Date: Tue, 05 Jun 2007 18:34:59 -0700
Message-ID: <46660F43.4060402@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig28CB6EECD85A9CA907AD90B4"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 03:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvkRD-0006Fh-SA
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 03:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758510AbXFFBfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 21:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761085AbXFFBfl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 21:35:41 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:48034 "EHLO
	mail4.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758510AbXFFBfk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 21:35:40 -0400
Received: (qmail 13396 invoked from network); 6 Jun 2007 01:35:39 -0000
Received: from dsl093-040-092.pdx1.dsl.speakeasy.net (HELO [192.168.0.122]) (josh@[66.93.40.92])
          (envelope-sender <josh@freedesktop.org>)
          by mail4.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <git@vger.kernel.org>; 6 Jun 2007 01:35:39 -0000
User-Agent: Icedove 1.5.0.10 (X11/20070329)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49236>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28CB6EECD85A9CA907AD90B4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Replace all uses of cat that do nothing other than read a single file.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 git-commit.sh        |    2 +-
 git-filter-branch.sh |    4 ++--
 git-ls-remote.sh     |    2 +-
 git-quiltimport.sh   |    4 ++--
 git-verify-tag.sh    |    3 +--
 5 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index e8b60f7..06b6cd7 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -617,7 +617,7 @@ then
 		tree=3D$(GIT_INDEX_FILE=3D"$TMP_INDEX" git-write-tree) &&
 		rm -f "$TMP_INDEX"
 	fi &&
-	commit=3D$(cat "$GIT_DIR"/COMMIT_MSG | git-commit-tree $tree $PARENTS) =
&&
+	commit=3D$(git-commit-tree $tree $PARENTS < "$GIT_DIR"/COMMIT_MSG) &&
 	rlogm=3D$(sed -e 1q "$GIT_DIR"/COMMIT_MSG) &&
 	git-update-ref -m "$GIT_REFLOG_ACTION: $rlogm" HEAD $commit "$current" =
&&
 	rm -f -- "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/MERGE_MSG" &&
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0c8a7df..bfac6f2 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -333,7 +333,7 @@ for commit in $unchanged; do
 done
=20
 git-rev-list --reverse --topo-order $srcbranch --not $unchanged >../revs=

-commits=3D$(cat ../revs | wc -l | tr -d " ")
+commits=3D$(wc -l ../revs | tr -d " ")
=20
 test $commits -eq 0 && die "Found nothing to rewrite"
=20
@@ -386,7 +386,7 @@ while read commit; do
 done <../revs
=20
 git-update-ref refs/heads/"$dstbranch" $(head -n 1 ../map/$(tail -n 1 ..=
/revs))
-if [ "$(cat ../map/$(tail -n 1 ../revs) | wc -l)" -gt 1 ]; then
+if [ "$(wc -l ../map/$(tail -n 1 ../revs))" -gt 1 ]; then
 	echo "WARNING: Your commit filter caused the head commit to expand to s=
everal rewritten commits. Only the first such commit was recorded as the =
current $dstbranch head but you will need to resolve the situation now (p=
robably by manually merging the other commits). These are all the commits=
:" >&2
 	sed 's/^/	/' ../map/$(tail -n 1 ../revs) >&2
 	ret=3D1
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index a6ed99a..f5b2e77 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -82,7 +82,7 @@ rsync://* )
 	(cd $tmpdir && find refs -type f) |
 	while read path
 	do
-		cat "$tmpdir/$path" | tr -d '\012'
+		tr -d '\012' < "$tmpdir/$path"
 		echo "	$path"
 	done &&
 	rm -fr $tmpdir
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index a7a6757..bd540cd 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -70,9 +70,9 @@ tmp_info=3D"$tmp_dir/info"
 commit=3D$(git-rev-parse HEAD)
=20
 mkdir $tmp_dir || exit 2
-for patch_name in $(cat "$QUILT_PATCHES/series" | grep -v '^#'); do
+for patch_name in $(grep -v '^#' "$QUILT_PATCHES/series"); do
 	echo $patch_name
-	(cat $QUILT_PATCHES/$patch_name | git-mailinfo "$tmp_msg" "$tmp_patch" =
> "$tmp_info") || exit 3
+	git-mailinfo "$tmp_msg" "$tmp_patch" < "$QUILT_PATCHES/$patch_name" > "=
$tmp_info" || exit 3
 	test -s .dotest/patch || {
 		echo "Patch is empty.  Was it split wrong?"
 		exit 1
diff --git a/git-verify-tag.sh b/git-verify-tag.sh
index 8db7dd0..11ce947 100755
--- a/git-verify-tag.sh
+++ b/git-verify-tag.sh
@@ -38,8 +38,7 @@ trap 'rm -f "$GIT_DIR/.tmp-vtag"' 0
=20
 git-cat-file tag "$1" >"$GIT_DIR/.tmp-vtag" || exit 1
=20
-cat "$GIT_DIR/.tmp-vtag" |
-sed '/-----BEGIN PGP/Q' |
+sed '/-----BEGIN PGP/Q' "$GIT_DIR/.tmp-vtag" |
 gpg --verify "$GIT_DIR/.tmp-vtag" - || exit 1
 rm -f "$GIT_DIR/.tmp-vtag"
=20
--=20
1.5.2.1



--------------enig28CB6EECD85A9CA907AD90B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGZg9DGJuZRtD+evsRAozxAJ9nwivvBzXRqMZZFvXza9R3wIX44gCgp9iT
FGyj4ery0bR7meAjuhhAqns=
=2XDD
-----END PGP SIGNATURE-----

--------------enig28CB6EECD85A9CA907AD90B4--
