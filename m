From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [RFC/PATCH] git-fetch: Use already fetched branch with the --local flag.
Date: Mon, 16 Oct 2006 15:40:42 +0200
Message-ID: <87ac3w8jl1.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Oct 16 15:40:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZSi4-0002AQ-60
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 15:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWJPNkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Oct 2006 09:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWJPNkp
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 09:40:45 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:37535 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1750721AbWJPNko (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 09:40:44 -0400
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k9GDegP16450
	for <git@vger.kernel.org>; Mon, 16 Oct 2006 15:40:43 +0200
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28959>


It allows to separate when you fetch from when you merge. So, a "git pu=
ll"
can be:

$ git fetch
$ git pull --local

and the pull call can be made later. This is usefull when you have mult=
iple
branches and you want to merge the same "upstream" branch, or when you =
are
offline but you have already fetched the remote branch.

Note that this is different from:

$ git fetch
$ git pull . origin

(1) you do not have to tell explicitly the branch to merge
(2) the commit message is exactly as with "git pull"

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/fetch-options.txt |    3 +++
 git-fetch.sh                    |   25 +++++++++++++++++++------
 git-parse-remote.sh             |   22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 13f34d3..3a6cb3d 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -39,3 +39,6 @@
 	check.  Note that fetching into the current branch will not
 	update the index and working directory, so use it with care.
=20
+\--local::
+	Do not fetch from the remote repository. Use the already fetched
+	branches to program the merge for `git-pull`.
diff --git a/git-fetch.sh b/git-fetch.sh
index 79222fb..5ff800a 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -21,6 +21,7 @@ update_head_ok=3D
 exec=3D
 upload_pack=3D
 keep=3D--thin
+local_fetch=3D
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
@@ -56,6 +57,9 @@ do
 	--reflog-action=3D*)
 		rloga=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
 		;;
+	--local)
+		local_fetch=3Dt
+		;;
 	-*)
 		usage
 		;;
@@ -80,6 +84,10 @@ refs=3D
 rref=3D
 rsync_slurped_objects=3D
=20
+[ "$local_fetch" =3D t ] && [ "$remote_nick" =3D "$remote" ] && \
+    [ "$remote" !=3D "." ] && \
+    die "Flag --local only compatible with remote shorthands"
+
 rloga=3D"$rloga $remote_nick"
 test "$remote_nick" =3D "$remote" || rloga=3D"$rloga $remote"
=20
@@ -285,8 +293,8 @@ fetch_main () {
       rref=3D"$rref$LF$remote_name"
=20
       # There are transports that can fetch only one head at a time...
-      case "$remote" in
-      http://* | https://* | ftp://*)
+      case "$local_fetch,$remote" in
+      ,http://* | ,https://* | ,ftp://*)
 	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
 	      curl_extra_args=3D"-k"
 	  fi
@@ -313,7 +321,7 @@ fetch_main () {
 	  echo >&2 Fetching "$remote_name from $remote" using http
 	  git-http-fetch -v -a "$head" "$remote/" || exit
 	  ;;
-      rsync://*)
+      ,rsync://*)
 	  TMP_HEAD=3D"$GIT_DIR/TMP_HEAD"
 	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
 	  head=3D$(git-rev-parse --verify TMP_HEAD)
@@ -343,6 +351,11 @@ fetch_main () {
 	      rsync_slurped_objects=3Dt
 	  }
 	  ;;
+      t,*)
+	  [ -z "$local_name" ] &&\
+		local_name=3D$(get_ref_for_remote_branch "$remote_nick" "$remote_nam=
e")
+	  head=3D$(git-rev-parse --verify $local_name^0) || exit
+	  ;;
       *)
 	  # We will do git native transport with just one call later.
 	  continue ;;
@@ -353,8 +366,8 @@ fetch_main () {
=20
   done
=20
-  case "$remote" in
-  http://* | https://* | ftp://* | rsync://* )
+  case "$local_fetch,$remote" in
+  ,http://* | ,https://* | ,ftp://* | ,rsync://* | t,*)
       ;; # we are already done.
   *)
     ( : subshell because we muck with IFS
@@ -406,7 +419,7 @@ fetch_main () {
 fetch_main "$reflist"
=20
 # automated tag following
-case "$no_tags$tags" in
+case "$no_tags$tags$local_fetch" in
 '')
 	case "$reflist" in
 	*:refs/*)
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index c325ef7..679f73c 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -236,3 +236,25 @@ resolve_alternates () {
 		esac
 	done
 }
+
+get_ref_for_remote_branch (){
+	data_source=3D$(get_data_source "$1")
+	case "$data_source" in
+	'' | config-partial | branches | branches-partial)
+		test "$1" =3D . && echo $2
+		;;
+	config)
+		ref=3D$(git-repo-config --get-all "remote.$1.fetch" |\
+			grep "^$2:")
+		expr "z$ref" : 'z[^:]*:\(.*\)'
+		;;
+	remotes)
+		ref=3D$(sed -ne '/^Pull: */{
+				s///p
+			}' "$GIT_DIR/remotes/$1" | grep "$2:")
+		expr "z$ref" : 'z[^:]*:\(.*\)'
+		;;
+	*)
+		die "internal error: get-ref-for-remote-branch $1 $2" ;;
+	esac
+}
--=20
1.4.3.rc2.ga442
