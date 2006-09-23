From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 2/2] Fetch: get the remote branches to merge from the branch properties
Date: Sat, 23 Sep 2006 12:08:25 +0200
Message-ID: <877izux5d2.fsf@gmail.com>
References: <87venex5je.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 12:08:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR4Qy-0003qL-Ih
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 12:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWIWKI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 23 Sep 2006 06:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbWIWKI3
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 06:08:29 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:8352 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751456AbWIWKI2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 06:08:28 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8NA8QQ31600
	for <git@vger.kernel.org>; Sat, 23 Sep 2006 12:08:26 +0200
To: git <git@vger.kernel.org>
In-Reply-To: <87venex5je.fsf@gmail.com> (Santi =?utf-8?Q?B=C3=A9jar's?=
 message of "Sat, 23 Sep
	2006 12:04:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27578>


If in branch "foo" and this in config:

[branch "foo"]
      merge=3Dbar

"git fetch": fetch from the default repository and program the "bar"
             branch to be merged with pull.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    4 ++++
 git-parse-remote.sh      |   30 ++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 04c5094..98c1f3e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -122,6 +122,10 @@ apply.whitespace::
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
=20
+branch.<name>.merge::
+	When in branch <name>, it tells `git fetch` the default remote branch
+	to be merged.
+
 pager.color::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 6999816..d3a1b9a 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -92,9 +92,22 @@ get_remote_default_refs_for_push () {
=20
 # Subroutine to canonicalize remote:local notation.
 canon_refs_list_for_fetch () {
-	# Leave only the first one alone; add prefix . to the rest
+	# If called from get_remote_default_refs_for_fetch
+	# leave the branches in branch.${curr_branch}.merge alone,
+	# or the first one otherwise; add prefix . to the rest
 	# to prevent the secondary branches to be merged by default.
-	dot_prefix=3D
+	if test "$1" =3D "-d"
+	then
+		shift ; remote=3D"$1" ; shift
+		if test "$remote" =3D "$(get_default_remote)"
+		then
+			curr_branch=3D$(git-symbolic-ref HEAD | \
+			    sed -e 's|^refs/heads/||')
+			merge_branches=3D$(git-repo-config \
+			    --get-all "branch.${curr_branch}.merge")
+		fi
+	fi
+	[ -z "$merge_branches" ] && merge_branches=3D$1
 	for ref
 	do
 		force=3D
@@ -107,6 +120,11 @@ canon_refs_list_for_fetch () {
 		expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
 		remote=3D$(expr "z$ref" : 'z\([^:]*\):')
 		local=3D$(expr "z$ref" : 'z[^:]*:\(.*\)')
+		dot_prefix=3D.
+		for merge_branch in $merge_branches
+		do
+		    [ "$remote" =3D "$merge_branch" ] && dot_prefix=3D && break
+		done
 		case "$remote" in
 		'') remote=3DHEAD ;;
 		refs/heads/* | refs/tags/* | refs/remotes/*) ;;
@@ -126,7 +144,6 @@ canon_refs_list_for_fetch () {
 		   die "* refusing to create funny ref '$local_ref_name' locally"
 		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
-		dot_prefix=3D.
 	done
 }
=20
@@ -137,7 +154,7 @@ get_remote_default_refs_for_fetch () {
 	'' | config-partial | branches-partial)
 		echo "HEAD:" ;;
 	config)
-		canon_refs_list_for_fetch \
+		canon_refs_list_for_fetch -d "$1" \
 			$(git-repo-config --get-all "remote.$1.fetch") ;;
 	branches)
 		remote_branch=3D$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
@@ -145,10 +162,7 @@ get_remote_default_refs_for_fetch () {
 		echo "refs/heads/${remote_branch}:refs/heads/$1"
 		;;
 	remotes)
-		# This prefixes the second and later default refspecs
-		# with a '.', to signal git-fetch to mark them
-		# not-for-merge.
-		canon_refs_list_for_fetch $(sed -ne '/^Pull: */{
+		canon_refs_list_for_fetch -d "$1" $(sed -ne '/^Pull: */{
 						s///p
 					}' "$GIT_DIR/remotes/$1")
 		;;
--=20
1.4.2.1.g94da7
