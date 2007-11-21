From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH RFC] Use "git fetch" when cloning
Date: Wed, 21 Nov 2007 16:40:13 +0100
Message-ID: <1195659613-5290-1-git-send-email-sbejar@gmail.com>
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:57:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iurwt-0001PO-Mm
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbXKUP4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752811AbXKUP4w
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:56:52 -0500
Received: from mail.mppmu.mpg.de ([134.107.24.11]:38988 "EHLO
	mail.mppmu.mpg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbXKUP4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:56:51 -0500
X-Greylist: delayed 1413 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2007 10:56:51 EST
Received: by mail.mppmu.mpg.de (Postfix, from userid 998)
	id 7D21612057; Wed, 21 Nov 2007 16:33:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on mail.mppmu.mpg.de
X-Spam-Status: No, score=-3.2 required=6.0 tests=ALL_TRUSTED,BAYES_00,
	J_CHICKENPOX_52,J_CHICKENPOX_53 autolearn=ham version=3.1.7
X-Spam-Level: 
Received: from localhost.localdomain (sn3dhcp15.mppmu.mpg.de [134.107.3.155])
	by mail.mppmu.mpg.de (Postfix) with ESMTP id CAF5112030;
	Wed, 21 Nov 2007 16:33:08 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.727.g04a66
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65669>

With this all the "git fetch" supported protocols are automatically
supported by "git clone", in particular bundle files.

There are two more changes:

1) It always use "git fetch" even if local. So now it checks the validity
   of the new repo, in particular it does not create a broken repository
   when there are too many nested alternates.

2) It connects with the remote repo when fetching the branches/tags
   and the remote HEAD.

3) The quiet mode of "git fetch" prints the changed branches/tags, so "git clone"
   prints always the new branches/tags.
---
 git-clone.sh              |  178 +++++++--------------------------------------
 t/t5710-info-alternate.sh |    2 +-
 2 files changed, 27 insertions(+), 153 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 3f00693..ed8efc1 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -28,68 +28,6 @@ get_repo_base() {
 	) 2>/dev/null
 }
 
-if [ -n "$GIT_SSL_NO_VERIFY" -o \
-	"`git config --bool http.sslVerify`" = false ]; then
-    curl_extra_args="-k"
-fi
-
-http_fetch () {
-	# $1 = Remote, $2 = Local
-	curl -nsfL $curl_extra_args "$1" >"$2" ||
-		case $? in
-		126|127) exit ;;
-		*)	 return $? ;;
-		esac
-}
-
-clone_dumb_http () {
-	# $1 - remote, $2 - local
-	cd "$2" &&
-	clone_tmp="$GIT_DIR/clone-tmp" &&
-	mkdir -p "$clone_tmp" || exit 1
-	if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
-		"`git config --bool http.noEPSV`" = true ]; then
-		curl_extra_args="${curl_extra_args} --disable-epsv"
-	fi
-	http_fetch "$1/info/refs" "$clone_tmp/refs" ||
-		die "Cannot get remote repository information.
-Perhaps git-update-server-info needs to be run there?"
-	test "z$quiet" = z && v=-v || v=
-	while read sha1 refname
-	do
-		name=`expr "z$refname" : 'zrefs/\(.*\)'` &&
-		case "$name" in
-		*^*)	continue;;
-		esac
-		case "$bare,$name" in
-		yes,* | ,heads/* | ,tags/*) ;;
-		*)	continue ;;
-		esac
-		if test -n "$use_separate_remote" &&
-		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
-		then
-			tname="remotes/$origin/$branch_name"
-		else
-			tname=$name
-		fi
-		git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
-	done <"$clone_tmp/refs"
-	rm -fr "$clone_tmp"
-	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
-	rm -f "$GIT_DIR/REMOTE_HEAD"
-	if test -f "$GIT_DIR/REMOTE_HEAD"; then
-		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
-		case "$head_sha1" in
-		'ref: refs/'*)
-			;;
-		*)
-			git-http-fetch $v -a "$head_sha1" "$1" ||
-			rm -f "$GIT_DIR/REMOTE_HEAD"
-			;;
-		esac
-	fi
-}
-
 quiet=
 local=no
 use_local_hardlink=yes
@@ -197,6 +135,8 @@ if base=$(get_repo_base "$repo"); then
 	local=yes
 fi
 
+export GIT_REFLOG_ACTION="clone: from $repo"
+
 dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
 [ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
@@ -265,8 +205,6 @@ then
 	fi
 fi
 
-rm -f "$GIT_DIR/CLONE_HEAD"
-
 # We do local magic only when the user tells us to.
 case "$local" in
 yes)
@@ -299,105 +237,41 @@ yes)
 		cd "$repo" &&
 		find objects -depth -print | cpio -pumd$l "$GIT_DIR/" || exit 1
 	fi
-	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
-	;;
-*)
-	case "$repo" in
-	rsync://*)
-		case "$depth" in
-		"") ;;
-		*) die "shallow over rsync not supported" ;;
-		esac
-		rsync $quiet -av --ignore-existing  \
-			--exclude info "$repo/objects/" "$GIT_DIR/objects/" ||
-		exit
-		# Look at objects/info/alternates for rsync -- http will
-		# support it natively and git native ones will do it on the
-		# remote end.  Not having that file is not a crime.
-		rsync -q "$repo/objects/info/alternates" \
-			"$GIT_DIR/TMP_ALT" 2>/dev/null ||
-			rm -f "$GIT_DIR/TMP_ALT"
-		if test -f "$GIT_DIR/TMP_ALT"
-		then
-		    ( cd "$D" &&
-		      . git-parse-remote &&
-		      resolve_alternates "$repo" <"$GIT_DIR/TMP_ALT" ) |
-		    while read alt
-		    do
-			case "$alt" in 'bad alternate: '*) die "$alt";; esac
-			case "$quiet" in
-			'')	echo >&2 "Getting alternate: $alt" ;;
-			esac
-			rsync $quiet -av --ignore-existing  \
-			    --exclude info "$alt" "$GIT_DIR/objects" || exit
-		    done
-		    rm -f "$GIT_DIR/TMP_ALT"
-		fi
-		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
-		;;
-	https://*|http://*|ftp://*)
-		case "$depth" in
-		"") ;;
-		*) die "shallow over http or ftp not supported" ;;
-		esac
-		if test -z "@@NO_CURL@@"
-		then
-			clone_dumb_http "$repo" "$D"
-		else
-			die "http transport not supported, rebuild Git with curl support"
-		fi
-		;;
-	*)
-		case "$upload_pack" in
-		'') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
-		*) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
-		esac >"$GIT_DIR/CLONE_HEAD" ||
-			die "fetch-pack from '$repo' failed."
-		;;
-	esac
-	;;
 esac
-test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GIT_DIR/refs/reference-tmp"
 
-if test -f "$GIT_DIR/CLONE_HEAD"
+if [ -n "$use_separate_remote" ]
 then
-	# Read git-fetch-pack -k output and store the remote branches.
-	if [ -n "$use_separate_remote" ]
-	then
-		branch_top="remotes/$origin"
-	else
-		branch_top="heads"
-	fi
-	tag_top="tags"
-	while read sha1 name
-	do
-		case "$name" in
-		*'^{}')
-			continue ;;
-		HEAD)
-			destname="REMOTE_HEAD" ;;
-		refs/heads/*)
-			destname="refs/$branch_top/${name#refs/heads/}" ;;
-		refs/tags/*)
-			destname="refs/$tag_top/${name#refs/tags/}" ;;
-		*)
-			continue ;;
-		esac
-		git update-ref -m "clone: from $repo" "$destname" "$sha1" ""
-	done < "$GIT_DIR/CLONE_HEAD"
+	remote_top="refs/remotes/$origin"
+else
+	remote_top="refs/heads"
 fi
 
+case "$repo" in
+https://*|http://*|ftp://*|rsync://*) keep=;;
+*) keep=-k
+esac
+
+case "$upload_pack" in
+'') git fetch $keep --tags $quiet $depth "$repo" "+refs/heads/*:$remote_top/*";;
+*) git fetch $keep --tags $quiet $depth "$upload_pack" "$repo" "+refs/heads/*:$remote_top/*"
+esac || die "fetch from '$repo' failed."
+
+test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GIT_DIR/refs/reference-tmp"
+
 if test -n "$W"; then
 	cd "$W" || exit
 else
 	cd "$D" || exit
 fi
 
-if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
+head_sha1=`
+	case "$upload_pack" in
+	'') git ls-remote "$repo" ;;
+	*) git ls-remote "$upload_pack" "$repo"
+	esac  2>/dev/null | awk '{if ($2=="HEAD") print $1;}'`
+
+if test -z "$bare" && test -n "$head_sha1"
 then
-	# a non-bare repository is always in separate-remote layout
-	remote_top="refs/remotes/$origin"
-	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
 	case "$head_sha1" in
 	'ref: refs/'*)
 		# Uh-oh, the remote told us (http transport done against
@@ -466,6 +340,6 @@ then
 		git read-tree -m -u $v HEAD HEAD
 	esac
 fi
-rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
+rm -f "$GIT_DIR/FETCH_HEAD"
 
 trap - 0
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 699df6e..9b7f638 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -53,7 +53,7 @@ git prune'
 
 cd "$base_dir"
 
-test_expect_failure 'creating too deep nesting' \
+test_expect_success 'creating too deep nesting' \
 'git clone -l -s C D &&
 git clone -l -s D E &&
 git clone -l -s E F &&
-- 
1.5.3.5.next.428.g67f5d-dirty
