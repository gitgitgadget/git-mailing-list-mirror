From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] Start adding the $GIT_DIR/remotes/ support.
Date: Thu, 18 Aug 2005 00:39:25 -0700
Message-ID: <1124350765883-git-send-email-junkio@cox.net>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Junio C Hamano <junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:49:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5f00-0006DM-Iy
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 09:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVHRHja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 03:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVHRHja
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 03:39:30 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47025 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932116AbVHRHja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 03:39:30 -0400
Received: from siamese ([68.4.9.127]) by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with SMTP
          id <20050818073926.VGJO25443.fed1rmmtao07.cox.net@siamese>;
          Thu, 18 Aug 2005 03:39:26 -0400
In-Reply-To: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
X-Mailer: git-send-email-script
To: GIT mailing list <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

All the necessary parsing code is in git-parse-remote-script;
update git-push-script to use it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile                |    2 -
 git-parse-remote-script |  122 +++++++++++++++++++++++++++++++++++++++++++++++
 git-push-script         |   28 ++---------
 3 files changed, 129 insertions(+), 23 deletions(-)
 create mode 100755 git-parse-remote-script

f8892bf17675056cd18a252d3bc4e4ba381fb3bc
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -64,7 +64,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-reset-script git-add-script git-checkout-script git-clone-script \
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
-	git-branch-script git-parse-remote git-verify-tag-script \
+	git-branch-script git-parse-remote git-parse-remote-script git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
 	git-request-pull-script git-bisect-script
 
diff --git a/git-parse-remote-script b/git-parse-remote-script
new file mode 100755
--- /dev/null
+++ b/git-parse-remote-script
@@ -0,0 +1,122 @@
+#!/bin/sh
+
+. git-sh-setup-script || die "Not a git archive"
+
+get_data_source () {
+	case "$1" in
+	*/*)
+		# Not so fast.  This could be the partial URL shorthand...
+		token=$(expr "$1" : '\([^/]*\)/')
+		remainder=$(expr "$1" : '[^/]*/\(.*\)')
+		if test -f "$GIT_DIR/branches/$token"
+		then
+			echo branches-partial
+		else
+			echo ''
+		fi
+		;;
+	*)
+		if test -f "$GIT_DIR/remotes/$1"
+		then
+			echo remotes
+		elif test -f "$GIT_DIR/branches/$1"
+		then
+			echo branches
+		else
+			echo ''
+		fi ;;
+	esac
+}
+
+get_remote_url () {
+	data_source=$(get_data_source "$1")
+	case "$data_source" in
+	'')
+		echo "$1" ;;
+	remotes)
+		sed -ne '/^URL: */{
+			s///p
+			q
+		}' "$GIT_DIR/remotes/$1" ;;
+	branches)
+		sed -e 's/#.*//' "$GIT_DIR/branches/$1" ;;
+	branches-partial)
+		token=$(expr "$1" : '\([^/]*\)/')
+		remainder=$(expr "$1" : '[^/]*/\(.*\)')
+		url=$(sed -e 's/#.*//' "$GIT_DIR/branches/$token")
+		echo "$url/$remainder"
+		;;
+	*)
+		die "internal error: get-remote-url $1" ;;
+	esac
+}
+
+get_remote_default_refs_for_push () {
+	data_source=$(get_data_source "$1")
+	case "$data_source" in
+	'' | branches | branches-partial)
+		;; # no default push mapping, just send matching refs.
+	remotes)
+		sed -ne '/^Push: */{
+			s///p
+		}' "$GIT_DIR/remotes/$1" ;;
+	*)
+		die "internal error: get-remote-default-ref-for-push $1" ;;
+	esac
+}
+
+# Subroutine to caninicalize remote:local notation
+canon_refs_list_for_fetch () {
+	for ref
+	do
+		expr "$ref" : '.*:' >/dev/null || ref="${ref}:"
+		remote=$(expr "$ref" : '\([^:]*\):')
+		local=$(expr "$ref" : '[^:]*:\(.*\)')
+		case "$remote" in
+		'') remote=HEAD ;;
+		*) remote="refs/heads/$remote" ;;
+		esac
+		case "$local" in
+		'') local= ;;
+		*) local="refs/heads/$local" ;;
+		esac
+		echo "${remote}:${local}"
+	done
+}
+
+# Returns list of src: (no store), or src:dst (store)
+get_remote_default_refs_for_fetch () {
+	data_source=$(get_data_source "$1")
+	case "$data_source" in
+	'' | branches-partial)
+		echo "HEAD:" ;;
+	branches)
+		remote_branch=$(sed -ne '/#/s/.*#//p' "$GIT_DIR/branches/$1")
+		case "$remote_branch" in '') remote_branch=master ;; esac
+		echo "refs/heads/${remote_branch}:refs/heads/$1"
+		;;
+	remotes)
+		canon_refs_list_for_fetch $(sed -ne '/^Pull: */{
+						s///p
+					}' "$GIT_DIR/remotes/$1")
+		;;
+	*)
+		die "internal error: get-remote-default-ref-for-push $1" ;;
+	esac
+}
+
+get_remote_refs_for_push () {
+	case "$#" in
+	0) die "internal error: get-remote-refs-for-push." ;;
+	1) get_remote_default_refs_for_push "$@" ;;
+	*) shift; echo "$@" ;;
+	esac
+}
+
+get_remote_refs_for_fetch () {
+	case "$#" in
+	0) die "internal error: get-remote-refs-for-fetch." ;;
+	1) get_remote_default_refs_for_fetch "$@" ;;
+	*) shift; canon_refs_list_for_fetch "$@" ;;
+	esac
+}
diff --git a/git-push-script b/git-push-script
--- a/git-push-script
+++ b/git-push-script
@@ -20,8 +20,6 @@ do
 	-*)
 		die "Unknown parameter $1" ;;
         *)
-		remote="$1"
-		shift
 		set x "$@"
 		shift
 		break ;;
@@ -29,27 +27,13 @@ do
 	shift
 done
 
-case "$remote" in
-*:* | /* | ../* | ./* )
-	# An URL, host:/path/to/git, absolute and relative paths.
-	;;
-* )
-	# Shorthand
-	if expr "$remote" : '..*/..*' >/dev/null
-	then
-		# a short-hand followed by a trailing path
-		shorthand=$(expr "$remote" : '\([^/]*\)')
-		remainder=$(expr "$remote" : '[^/]*\(/.*\)$')
-	else
-		shorthand="$remote"
-		remainder=
-	fi
-	remote=$(sed -e 's/#.*//' "$GIT_DIR/branches/$remote") &&
-	expr "$remote" : '..*:' >/dev/null &&
-	remote="$remote$remainder" ||
-	die "Cannot parse remote $remote"
-	;;
+. git-parse-remote-script
+remote=$(get_remote_url "$@")
+case "$has_all" in
+--all) set x ;;
+'')    set x $(get_remote_refs_for_push "$@") ;;
 esac
+shift
 
 case "$remote" in
 http://* | https://* | git://* | rsync://* )
