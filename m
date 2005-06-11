From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Convert commands to optparse
Date: Sat, 11 Jun 2005 03:52:11 +0200
Message-ID: <20050611015211.GB13272@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 03:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgv6h-0004xi-8K
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 03:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVFKBwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 21:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVFKBwi
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 21:52:38 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:33507 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261519AbVFKBwN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 21:52:13 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id B42F46E1800; Sat, 11 Jun 2005 03:51:22 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 699606E136E; Sat, 11 Jun 2005 03:51:22 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 37C6D61FE0; Sat, 11 Jun 2005 03:52:12 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Convert all remaining commands providing options to optparse.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

Tested lightly ...

 cg-admin-ls       |   15 +++++++++------
 cg-admin-uncommit |   11 +++++++----
 cg-clone          |   16 ++++++++++------
 cg-commit         |   30 +++++++++++-------------------
 cg-merge          |   23 +++++++++++------------
 cg-pull           |   14 ++++++++------
 cg-update         |   13 ++++++++-----
 7 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/cg-admin-ls b/cg-admin-ls
--- a/cg-admin-ls
+++ b/cg-admin-ls
@@ -34,11 +34,14 @@ USAGE="cg-admin-ls [-t TREE_ID] [PATH]"
 . ${COGITO_LIB}cg-Xlib
 
 tree_id=
-if [ "$1" = "-t" ]; then
-	shift
-	tree_id=$1
-	shift
-fi
+while optparse; do
+	if optparse -t=; then
+		tree_id="$OPTARG"
+	else
+		optfail
+	fi
+done
+
 id=$(tree-id $tree_id) || exit 1
 
-git-ls-tree "$id" "$@"
+git-ls-tree "$id" "${ARGS[@]}"
diff --git a/cg-admin-uncommit b/cg-admin-uncommit
--- a/cg-admin-uncommit
+++ b/cg-admin-uncommit
@@ -24,10 +24,13 @@ USAGE="cg-admin-uncommit [-t] [COMMIT_ID
 [ -s $_git/blocked ] && die "uncommitting blocked: $(cat $_git/blocked)"
 
 rollback_tree=
-if [ "$1" = "-t" ]; then
-	shift
-	rollback_tree=1
-fi
+while optparse; do
+	if optparse -t; then
+		rollback_tree=1
+	else
+		optfail
+	fi
+done
 
 
 base=$(commit-id) || exit 1
diff --git a/cg-clone b/cg-clone
--- a/cg-clone
+++ b/cg-clone
@@ -23,16 +23,20 @@ _git_repo_unneeded=1
 . ${COGITO_LIB}cg-Xlib
 
 same_dir=
-if [ "$1" = "-s" ]; then
-	shift
-	same_dir=1
-fi
+while optparse; do
+	if optparse -s; then
+		same_dir=1
+	else
+		optfail
+	fi
+done
+
+location=${ARGS[0]}
 
-location=$1
 [ "$location" ] || usage
 location=${location%/}
 
-destdir=$2
+destdir=${ARGS[1]}
 if [ "$destdir" ]; then
 	[ ! "$same_dir" ] || die "specifying both -s and DESTDIR makes no sense"
 	dir=$destdir
diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -83,34 +83,26 @@ forceeditor=
 ignorecache=
 commitalways=
 msgs=()
-while [ "$1" ]; do
-	case "$1" in
-	-C)
+while optparse; do
+	if optparse -C; then
 		ignorecache=1
-		shift
-		;;
-	-e)
+	elif optparse -e; then
 		forceeditor=1
-		shift
-		;;
-	-E)
+	elif optparse -E; then
 		forceeditor=1
 		commitalways=1
-		shift
-		;;
-	-m*)
-		msgs=("${msgs[@]}" "${1#-m}")
-		shift
-		;;
-	*)	break;;
-	esac
+	elif optparse -m=; then
+		msgs=("${msgs[@]}" "$OPTARG")
+	else
+		optfail
+	fi
 done
 
-if [ "$1" ]; then
+if [ "$ARGS" ]; then
 	[ "$ignorecache" ] && die "-C and listing files to commit does not make sense"
 	[ -s $_git/merging ] && die "cannot commit individual files when merging"
 
-	eval commitfiles=($(git-diff-cache -r -m HEAD -- "$@" | \
+	eval commitfiles=($(git-diff-cache -r -m HEAD -- "${ARGS[@]}" | \
 		sed 's/^\([^	]*\)\(.	.*\)\(	.*\)*$/"\2"/'))
 	customfiles=1
 
diff --git a/cg-merge b/cg-merge
--- a/cg-merge
+++ b/cg-merge
@@ -27,20 +27,19 @@ head=$(commit-id)
 
 
 careful=
-if [ "$1" = "-c" ]; then
-	shift
-	careful=1
-fi
-
 base=
-if [ "$1" = "-b" ]; then
-	shift
-	[ "$1" ] || usage
-	base=$(commit-id "$1") || exit 1; shift
-fi
+while optparse; do
+	if optparse -c; then
+		careful=1
+	elif optparse -b=; then
+		base=$(commit-id "$OPTARG") || exit 1
+	else
+		optfail
+	fi
+done
 
-[ "$1" ] || usage
-branchname="$1"
+[ "$ARGS" ] || usage
+branchname="${ARGS[0]}"
 branch=$(commit-id "$branchname") || exit 1
 
 [ "$base" ] || base=$(git-merge-base "$head" "$branch")
diff --git a/cg-pull b/cg-pull
--- a/cg-pull
+++ b/cg-pull
@@ -17,13 +17,15 @@ USAGE="cg-pull [-f] [BRANCH_NAME]"
 . ${COGITO_LIB}cg-Xlib
 
 force=
-if [ "$1" = "-f" ]; then
-	force=1
-	shift
-fi
-
-name=$1
+while optparse; do
+	if optparse -f; then
+		force=1
+	else
+		optfail
+	fi
+done
 
+name=${ARGS[0]}
 
 [ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
 [ "$name" ] || die "where to pull from?"
diff --git a/cg-update b/cg-update
--- a/cg-update
+++ b/cg-update
@@ -18,12 +18,15 @@ USAGE="cg-update [-f] [BRANCH_NAME]"
 . ${COGITO_LIB}cg-Xlib
 
 force=
-if [ "$1" = "-f" ]; then
-	force=$1
-	shift
-fi
+while optparse; do
+	if optparse -f; then
+		force=-f
+	else
+		optfail
+	fi
+done
 
-name=$1
+name=${ARGS[0]}
 [ "$name" ] || { [ -s $_git/refs/heads/origin ] && name=origin; }
 [ "$name" ] || die "where to update from?"
 
-- 
Jonas Fonseca
