From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH] Fetch: get the remote branches to merge from the branch properties.
Date: Sat, 23 Sep 2006 01:41:17 +0200
Message-ID: <874puza2qq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 23 01:41:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQue6-0007mc-F9
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 01:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbWIVXlX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Sep 2006 19:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWIVXlX
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 19:41:23 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:45454 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964933AbWIVXlW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 19:41:22 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k8MNfKQ26283;
	Sat, 23 Sep 2006 01:41:20 +0200
To: git <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27546>

If in branch "foo" and this in config:

[branch "foo"]
       merge=3Dbar

"git fetch": fetch from the default repository and program the "bar"
             branch to be merged with pull.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/config.txt |    4 ++++
 git-parse-remote.sh      |   13 ++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fa20e28..b4de243 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -122,6 +122,10 @@ apply.whitespace::
 branch.<name>.remote::
        When in branch <name>, it tells `git pull` which remote to fetc=
h.

+branch.<name>.merge::
+       When in branch <name>, it tells `git fetch` the remote branch t=
o be
+       merged.
+
 pager.color::
        A boolean to enable/disable colored output when the pager is in
        use (default is true).
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 187f088..0b14606 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -86,9 +86,12 @@ get_remote_default_refs_for_push () {
=20
 # Subroutine to canonicalize remote:local notation.
 canon_refs_list_for_fetch () {
-	# Leave only the first one alone; add prefix . to the rest
+	# Leave the branches in branch.${curr_branch}.merge alone,
+	# or the first one; add prefix . to the rest
 	# to prevent the secondary branches to be merged by default.
-	dot_prefix=3D
+	curr_branch=3D$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
+	merge_branches=3D$(git-repo-config --get-all "branch.${curr_branch}.m=
erge")
+	[ -z "$merge_branches" ] && merge_branches=3D$1
 	for ref
 	do
 		force=3D
@@ -101,6 +104,11 @@ canon_refs_list_for_fetch () {
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
@@ -120,7 +128,6 @@ canon_refs_list_for_fetch () {
 		   die "* refusing to create funny ref '$local_ref_name' locally"
 		fi
 		echo "${dot_prefix}${force}${remote}:${local}"
-		dot_prefix=3D.
 	done
 }
=20
--=20
1.4.2.1.g4b5cd
