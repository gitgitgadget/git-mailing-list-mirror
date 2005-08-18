From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] Update git-pull to match updated git-fetch.
Date: Thu, 18 Aug 2005 00:39:31 -0700
Message-ID: <11243507711980-git-send-email-junkio@cox.net>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Junio C Hamano <junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:55:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5f00-0006DM-0z
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 09:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVHRHjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 03:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVHRHjd
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 03:39:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:14752 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932127AbVHRHjc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 03:39:32 -0400
Received: from siamese ([68.4.9.127]) by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with SMTP
          id <20050818073930.FYPD19494.fed1rmmtao06.cox.net@siamese>;
          Thu, 18 Aug 2005 03:39:30 -0400
In-Reply-To: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
X-Mailer: git-send-email-script
To: GIT mailing list <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This retires the git-parse-remote script, and allows pull to fetch
from multiple remote references.  There is no support for resolving
more than two heads, so that would be next.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile         |    2 +
 git-parse-remote |   79 ------------------------------------------------------
 git-pull-script  |   14 ++++++----
 3 files changed, 10 insertions(+), 85 deletions(-)
 delete mode 100755 git-parse-remote

3a071a02828c71bbfdc2749d25814906cd9c8b18
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -64,7 +64,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-reset-script git-add-script git-checkout-script git-clone-script \
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
-	git-branch-script git-parse-remote git-parse-remote-script git-verify-tag-script \
+	git-branch-script git-parse-remote-script git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
 	git-request-pull-script git-bisect-script
 
diff --git a/git-parse-remote b/git-parse-remote
deleted file mode 100755
--- a/git-parse-remote
+++ /dev/null
@@ -1,79 +0,0 @@
-: To be included in git-pull and git-fetch scripts.
-
-# A remote repository can be specified on the command line
-# in one of the following formats:
-#
-#	<repo>
-#	<repo> <head>
-#	<repo> tag <tag>
-#
-# where <repo> could be one of:
-#
-#	a URL (including absolute or local pathname)
-#	a short-hand
-#	a short-hand followed by a trailing path
-#
-# A short-hand <name> has a corresponding file $GIT_DIR/branches/<name>,
-# whose contents is a URL, possibly followed by a URL fragment #<head>
-# to name the default branch on the remote side to fetch from.
-
-_remote_repo= _remote_store= _remote_head= _remote_name=
-
-case "$1" in
-*:* | /* | ../* | ./* )
-	_remote_repo="$1"
-	;;
-* )
-	# otherwise, it is a short hand.
-	case "$1" in
-	*/*)
-		# a short-hand followed by a trailing path
-		_token=$(expr "$1" : '\([^/]*\)/')
-		_rest=$(expr "$1" : '[^/]*\(/.*\)$')
-		;;
-	*)
-		_token="$1"
-		_rest=
-		_remote_store="refs/heads/$_token"
-		;;
-	esac
-	test -f "$GIT_DIR/branches/$_token" ||
-	die "No such remote branch: $_token"
-
-	_remote_repo=$(cat "$GIT_DIR/branches/$_token")"$_rest"
-	;;
-esac
-
-case "$_remote_repo" in
-*"#"*)
-	_remote_head=`expr "$_remote_repo" : '.*#\(.*\)$'`
-	_remote_repo=`expr "$_remote_repo" : '\(.*\)#'`
-	;;
-esac
-
-_remote_name=$(echo "$_remote_repo" | sed 's|\.git/*$||')
-
-case "$2" in
-tag)
-	_remote_name="tag '$3' of $_remote_name"
-	_remote_head="refs/tags/$3"
-	_remote_store="$_remote_head"
-	;;
-?*)
-	# command line specified a head explicitly; do not
-	# store the fetched head as a branch head.
-	_remote_name="head '$2' of $_remote_name"
-	_remote_head="refs/heads/$2"
-	_remote_store=''
-	;;
-'')
-	case "$_remote_head" in
-	'')
-		_remote_head=HEAD ;;
-	*)
-		_remote_name="head '$_remote_head' of $_remote_name"
-		_remote_head="refs/heads/$_remote_head"
-		;;
-	esac
-	;;
-esac
diff --git a/git-pull-script b/git-pull-script
--- a/git-pull-script
+++ b/git-pull-script
@@ -1,12 +1,16 @@
 #!/bin/sh
 #
 . git-sh-setup-script || die "Not a git archive"
-. git-parse-remote "$@"
-merge_name="$_remote_name"
-
 git-fetch-script "$@" || exit 1
+merge_head=$(sed -e 's/	.*//' "$GIT_DIR"/FETCH_HEAD | tr '\012' ' ')
+merge_name=$(sed -e 's/^[0-9a-f]*	//' "$GIT_DIR"/FETCH_HEAD |
+	 tr '\012' ' ')
+
+case "$merge_head" in
+'' | *' '?*) die "Cannot resolve multiple heads at the same time (yet)." ;;
+esac
+
 
 git-resolve-script \
 	"$(cat "$GIT_DIR"/HEAD)" \
-	"$(cat "$GIT_DIR"/FETCH_HEAD)" \
-	"Merge $merge_name"
+	$merge_head "Merge $merge_name"
