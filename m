From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/3] git-commit-script: get commit message from an existing
 one.
Date: Thu, 23 Jun 2005 16:27:40 -0700
Message-ID: <7vfyv8ejrn.fsf_-_@assigned-by-dhcp.cox.net>
References: <1119284365.3926.15.camel@localhost.localdomain>
	<7vbr61j631.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
	<7v4qbofym7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:22:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlb1e-0004H5-Nv
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVFWX2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVFWX2r
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:28:47 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:17850 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262623AbVFWX1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:27:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623232741.YWPL1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:27:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4qbofym7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 23 Jun 2005 16:21:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With -m flag specified, git-commit-script takes the commit
message along with author information from an existing commit.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
*** Linus, I suspect that date.c mishandles the raw date; I am
*** consistently getting 7 hours off and my machine runs in
*** US/Pacific (-0700) timezone.

 git-commit-script |   75 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -1,12 +1,37 @@
 #!/bin/sh
+#
+# Copyright (c) 2005 Linus Torvalds
+#
+
+usage () {
+    echo 'git commit [-m existing-commit] [<path>...]'
+    exit 1
+}
+
 : ${GIT_DIR=.git}
-if [ ! -d $GIT_DIR ]; then
+if [ ! -d "$GIT_DIR" ]; then
 	echo Not a git directory 1>&2
 	exit 1
 fi
+while case "$#" in 0) break ;; esac
+do
+    case "$1" in
+    -m) shift
+        case "$#" in
+	0) usage ;;
+	*) use_commit=`git-rev-parse "$1"` ||
+	   exit ;;
+	esac
+	;;
+    *)  break
+        ;;
+    esac
+    shift
+done
+
 git-update-cache -q --refresh -- "$@" || exit 1
 PARENTS="-p HEAD"
-if [ ! -r $GIT_DIR/HEAD ]; then
+if [ ! -r "$GIT_DIR/HEAD" ]; then
 	if [ -z "$(git-ls-files)" ]; then
 		echo Nothing to commit 1>&2
 		exit 1
@@ -20,7 +45,7 @@ if [ ! -r $GIT_DIR/HEAD ]; then
 	) > .editmsg
 	PARENTS=""
 else
-	if [ -f $GIT_DIR/MERGE_HEAD ]; then
+	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
 		echo "#"
 		echo "# It looks like your may be committing a MERGE."
 		echo "# If this is not correct, please remove the file"
@@ -28,8 +53,38 @@ else
 		echo "# and try again"
 		echo "#"
 		PARENTS="-p HEAD -p MERGE_HEAD"
-	fi > .editmsg
-	git-status-script >> .editmsg
+	elif test "$use_commit" != ""
+	then
+		pick_author_script='
+		/^author /{
+			h
+			s/^author \([^<]*\) <[^>]*> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_NAME='\''&'\''/p
+
+			g
+			s/^author [^<]* <\([^>]*\)> .*$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_EMAIL='\''&'\''/p
+
+			g
+			s/^author [^<]* <[^>]*> \(.*\)$/\1/
+			s/'\''/'\''\'\'\''/g
+			s/.*/GIT_AUTHOR_DATE='\''&'\''/p
+
+			q
+		}
+		'
+		set_author_env=`git-cat-file commit "$use_commit" |
+		sed -ne "$pick_author_script"`
+		eval "$set_author_env"
+		export GIT_AUTHOR_NAME
+		export GIT_AUTHOR_EMAIL
+		export GIT_AUTHOR_DATE
+		git-cat-file commit "$use_commit" |
+		sed -e '1,/^$/d'
+	fi >.editmsg
+	git-status-script >>.editmsg
 fi
 if [ "$?" != "0" ]
 then
@@ -37,13 +92,17 @@ then
 	rm .editmsg
 	exit 1
 fi
-${VISUAL:-${EDITOR:-vi}} .editmsg
+case "$use_commit" in
+'')
+	${VISUAL:-${EDITOR:-vi}} .editmsg
+	;;
+esac
 grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
 [ -s .cmitmsg ] && 
 	tree=$(git-write-tree) &&
 	commit=$(cat .cmitmsg | git-commit-tree $tree $PARENTS) &&
-	echo $commit > $GIT_DIR/HEAD &&
-	rm -f -- $GIT_DIR/MERGE_HEAD
+	echo $commit > "$GIT_DIR/HEAD" &&
+	rm -f -- "$GIT_DIR/MERGE_HEAD"
 ret="$?"
 rm -f .cmitmsg .editmsg
 exit "$ret"
------------

