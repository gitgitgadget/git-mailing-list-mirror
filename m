From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] fetch/pull: short-hand notation for remote repositories.
Date: Sat, 16 Jul 2005 00:16:24 -0700
Message-ID: <7virzbnruf.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vbr55kgq2.fsf@assigned-by-dhcp.cox.net>
	<7vzmsots7t.fsf@assigned-by-dhcp.cox.net>
	<7voe93rbmu.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507151529590.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 16 09:17:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtgub-0007O5-Cm
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 09:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVGPHQ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 03:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVGPHQ1
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 03:16:27 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8073 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261224AbVGPHQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 03:16:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716071626.COOJ18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 03:16:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507151529590.19183@g5.osdl.org> (Linus Torvalds's message of "Fri, 15 Jul 2005 15:42:42 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Since pull and fetch are done often against the same remote
repository repeatedly, keeping the URL to pull from along with
the name of the head to use in $GIT_DIR/branches/$name makes a
lot of sense.  Adopt that convention from Cogito, and try to be
compatible when possible; storing a partial URL and completing
it with a trailing path may not be understood by Cogito.

While we are at it, fix pulling a tag.  Earlier, we updated only
refs/tags/$tag without updating FETCH_HEAD, and called
resolve-script using a stale (or absent) FETCH_HEAD.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile         |    2 +
 git-fetch-script |   36 ++++++++++++++-----------
 git-parse-remote |   79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 git-pull-script  |   19 ++-----------
 4 files changed, 104 insertions(+), 32 deletions(-)
 create mode 100755 git-parse-remote

431b72ee18b73aac44048ac6c4cb62e0618c6f6e
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -36,7 +36,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-reset-script git-add-script git-checkout-script git-clone-script \
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
-	git-branch-script
+	git-branch-script git-parse-remote
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,33 +1,39 @@
 #!/bin/sh
 #
-destination=FETCH_HEAD
-
-merge_repo=$1
-merge_name=${2:-HEAD}
-if [ "$2" = "tag" ]; then
-	merge_name="refs/tags/$3"
-	destination="$merge_name"
-fi
-
 . git-sh-setup-script || die "Not a git archive"
+. git-parse-remote "$@"
+merge_repo="$_remote_repo"
+merge_head="$_remote_head"
+merge_store="$_remote_store"
 
 TMP_HEAD="$GIT_DIR/TMP_HEAD"
 
 case "$merge_repo" in
 http://*)
-	head=$(wget -q -O - "$merge_repo/$merge_name") || exit 1
-	echo Fetching $head using http
-	git-http-pull -v -a "$head" "$merge_repo/"
+	head=$(wget -q -O - "$merge_repo/$merge_head") || exit 1
+	echo Fetching "$merge_head" using http
+	git-http-pull -v -a "$merge_head" "$merge_repo/"
 	;;
 rsync://*)
-	rsync -L "$merge_repo/$merge_name" "$TMP_HEAD" || exit 1
+	rsync -L "$merge_repo/$merge_head" "$TMP_HEAD" || exit 1
 	head=$(git-rev-parse TMP_HEAD)
 	rm -f "$TMP_HEAD"
 	rsync -avz --ignore-existing "$merge_repo/objects/" "$GIT_OBJECT_DIRECTORY/"
 	;;
 *)
-	head=$(git-fetch-pack "$merge_repo" "$merge_name")
+	head=$(git-fetch-pack "$merge_repo" "$merge_head")
 	;;
 esac || exit 1
+
 git-rev-parse --verify "$head" > /dev/null || exit 1
-echo "$head" > "$GIT_DIR/$destination"
+
+case "$merge_store" in
+'')
+	echo "$head" > "$GIT_DIR/$merge_store"
+esac &&
+
+# FETCH_HEAD is fed to git-resolve-script which will eventually be
+# passed to git-commit-tree as one of the parents.  Make sure we do
+# not give a tag object ID.
+
+git-rev-parse "$head^0" >"$GIT_DIR/FETCH_HEAD"
diff --git a/git-parse-remote b/git-parse-remote
new file mode 100755
--- /dev/null
+++ b/git-parse-remote
@@ -0,0 +1,79 @@
+: To be included in git-pull and git-fetch scripts.
+
+# A remote repository can be specified on the command line
+# in one of the following formats:
+#
+#	<repo>
+#	<repo> <head>
+#	<repo> tag <tag>
+#
+# where <repo> could be one of:
+#
+#	a URL (including absolute or local pathname)
+#	a short-hand
+#	a short-hand followed by a trailing path
+#
+# A short-hand <name> has a corresponding file $GIT_DIR/branches/<name>,
+# whose contents is a URL, possibly followed by a URL fragment #<head>
+# to name the default branch on the remote side to fetch from.
+
+_remote_repo= _remote_store= _remote_head= _remote_name=
+
+case "$1" in
+*:* | /* | ../* | ./* )
+	_remote_repo="$1"
+	;;
+* )
+	# otherwise, it is a short hand.
+	case "$1" in
+	*/*)
+		# a short-hand followed by a trailing path
+		_token=$(expr "$1" : '\([^/]*\)/')
+		_rest=$(expr "$1" : '[^/]*\(/.*\)$')
+		;;
+	*)
+		_token="$1"
+		_rest=
+		_remote_store="refs/heads/$_token"
+		;;
+	esac
+	test -f "$GIT_DIR/branches/$_token" ||
+	die "No such remote branch: $_token"
+
+	_remote_repo=$(cat "$GIT_DIR/branches/$_token")"$_rest"
+	;;
+esac
+
+case "$_remote_repo" in
+*"#"*)
+	_remote_head=`expr "$_remote_repo" : '.*#\(.*\)$'`
+	_remote_repo=`expr "$_remote_repo" : '\(.*\)#'`
+	;;
+esac
+
+_remote_name=$(echo "$_remote_repo" | sed 's|\.git/*$||')
+
+case "$2" in
+tag)
+	_remote_name="tag '$3' of $_remote_name"
+	_remote_head="refs/tags/$3"
+	_remote_store="$_remote_head"
+	;;
+?*)
+	# command line specified a head explicitly; do not
+	# store the fetched head as a branch head.
+	_remote_name="head '$2' of $_remote_name"
+	_remote_head="refs/heads/$2"
+	_remote_store=''
+	;;
+'')
+	case "$_remote_head" in
+	'')
+		_remote_head=HEAD ;;
+	*)
+		_remote_head="refs/heads/$_remote_head"
+		_remote_name="head '$_remote_head' of $_remote_name"
+		;;
+	esac
+	;;
+esac
diff --git a/git-pull-script b/git-pull-script
--- a/git-pull-script
+++ b/git-pull-script
@@ -1,23 +1,10 @@
 #!/bin/sh
 #
 . git-sh-setup-script || die "Not a git archive"
+. git-parse-remote "$@"
+merge_name="$_remote_name"
 
-merge_repo=$1
-
-merge_name=$(echo "$1" | sed 's:\.git/*$::')
-merge_head=HEAD
-type=head
-if [ "$2" = "tag" ]; then
-   type=tag
-   shift
-fi
-if [ "$2" ]
-then
-   merge_name="$type '$2' of $merge_name"
-   merge_head="refs/${type}s/$2"
-fi
-
-git-fetch-script "$merge_repo" "$merge_head" || exit 1
+git-fetch-script "$@" || exit 1
 
 git-resolve-script \
 	"$(cat "$GIT_DIR"/HEAD)" \
