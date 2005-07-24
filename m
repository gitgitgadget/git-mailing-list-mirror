From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/6] Support cloning packed repo from dumb http servers.
Date: Sat, 23 Jul 2005 17:55:07 -0700
Message-ID: <7vll3xja50.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 02:55:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwUm0-0004Sh-6L
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 02:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVGXAzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 20:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVGXAzL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 20:55:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34188 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262182AbVGXAzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 20:55:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050724005508.OPU1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 23 Jul 2005 20:55:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Using the information prepared with update-server-info, a truly
dumb http server can allow cloning with this client side
support.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile            |    2 +-
 git-clone-dumb-http |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 git-clone-script    |   13 +++++++++++--
 3 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100755 git-clone-dumb-http

5dd66390cbe5fe0665681ad0d73368085c87b01d
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -37,7 +37,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote git-verify-tag-script \
-	git-ls-remote-script
+	git-ls-remote-script git-clone-dumb-http
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-clone-dumb-http b/git-clone-dumb-http
new file mode 100755
--- /dev/null
+++ b/git-clone-dumb-http
@@ -0,0 +1,51 @@
+#!/bin/sh
+#
+# Copyright (c) 2005, Junio C Hamano
+#
+# Called by git-clone-script
+# Exits 2 when the remote site does not support dumb server protocol.
+
+# Usage: git-clone-dumb-http <remote-repo> <local-dir>
+
+R=${1?"remote repository"} D=${2?"local directory"}
+
+if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+    curl_extra_args="-k"
+fi
+http_fetch () {
+	# $1 = Remote, $2 = Local
+	curl -ns $curl_extra_args "$1" >"$2"
+}
+
+cd "$D" && 
+clone_tmp=".git/clone-tmp" &&
+mkdir -p "$clone_tmp" || exit 1
+trap "rm -rf .git/clone-tmp" 0 1 2 3 15
+
+http_fetch "$R/info/refs" "$clone_tmp/refs" &&
+http_fetch "$R/objects/info/packs" "$clone_tmp/packs" || exit 2
+
+# We do not have to worry about rev-cache when cloning.
+# http_fetch "$R/info/rev-cache" "$clone_tmp/rev-cache" 
+
+# Clone packs
+while read type name
+do
+	case "$type" in
+	P) ;;
+	*) continue ;;
+	esac &&
+
+	idx=`expr "$name" : '\(.*\)\.pack'`.idx
+	http_fetch "$R/objects/pack/$name" ".git/objects/pack/$name" &&
+	http_fetch "$R/objects/pack/$idx" ".git/objects/pack/$idx" &&
+	git-verify-pack ".git/objects/pack/$idx" || exit 1
+
+done <"$clone_tmp/packs"
+
+# Then clone refs.
+while read sha1 refname
+do
+	name=`expr "$refname" : 'refs/\(.*\)'` &&
+	git-http-pull -v -a -w "$name" "$name" "$R/" || exit 1
+done <"$clone_tmp/refs"
diff --git a/git-clone-script b/git-clone-script
--- a/git-clone-script
+++ b/git-clone-script
@@ -89,8 +89,17 @@ yes,yes)
 		rsync $quiet -avz --ignore-existing "$repo/refs/" "$D/.git/refs/"
 		;;
 	http://*)
-		echo "Somebody should add http fetch" >&2
-		exit 1
+		git-clone-dumb-http "$repo" "$D"
+		case "$?" in
+		2)
+			echo "Somebody should define smarter http server protocol" >&2
+			exit 1
+			;;
+		0)
+			;;
+		*)
+			exit
+		esac
 		;;
 	*)
 		cd "$D" && case "$upload_pack" in
