From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 4/4] cg-{diff,mkpatch}: rename/copy optional detection
Date: Fri, 02 Sep 2005 12:31:38 +0200
Message-ID: <20050902103135.24918.7990.stgit@zion.home.lan>
References: <20050902103125.24918.905.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 12:36:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB8tO-00024D-Pg
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 12:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVIBKfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 06:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVIBKfU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 06:35:20 -0400
Received: from [151.97.230.9] ([151.97.230.9]:46050 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030402AbVIBKfS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 06:35:18 -0400
Received: (qmail 12169 invoked by uid 508); 2 Sep 2005 12:35:17 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 2 Sep 2005 12:35:17 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id F2FC621D94B;
	Fri,  2 Sep 2005 12:31:38 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050902103125.24918.905.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8018>

Add -B, -M and -C options to detect content rewrites, renames and changes
to cg-diff and cg-mkpatch, to be passed right down to git-diff-*.
I've not added a way to pass down any option, since not everything may make
sense, and a shell script colorizing --name-only-z output would not play so
nice (and I mean "unreliable behaviour" - not tested obviously).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 cg-diff    |   17 +++++++++++++++--
 cg-mkpatch |   15 ++++++++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/cg-diff b/cg-diff
--- a/cg-diff
+++ b/cg-diff
@@ -28,6 +28,12 @@
 #	Base the diff at the merge base of the -r arguments (defaulting
 #	to HEAD and origin).
 #
+# -M::
+# -C::
+# -B::
+#	Passed down to git-diff-*, to mean respectively "detect renames",
+#	"detect copies", "detect file rewriting".
+#
 # ENVIRONMENT VARIABLES
 # ---------------------
 # PAGER::
@@ -92,6 +98,7 @@ id2=" "
 parent=
 opt_color=
 mergebase=
+gitflags=
 
 while optparse; do
 	if optparse -c; then
@@ -115,6 +122,12 @@ while optparse; do
 		fi
 	elif optparse -m; then
 		mergebase=1
+	elif optparse -M; then
+		gitflags="$gitflags -M"
+	elif optparse -C; then
+		gitflags="$gitflags -C"
+	elif optparse -B; then
+		gitflags="$gitflags -B"
 	else
 		optfail
 	fi
@@ -155,7 +168,7 @@ if [ "$id2" = " " ]; then
 	# FIXME: Update ret based on what did we match. And take "$@"
 	# to account after all.
 	ret=
-	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
+	cat $filter | xargs git-diff-cache $gitflags -r -p $tree | colorize | pager
 
 	rm $filter
 
@@ -169,7 +182,7 @@ id2=$(tree-id "$id2") || exit 1
 
 [ "$id1" = "$id2" ] && die "trying to diff $id1 against itself"
 
-cat $filter | xargs git-diff-tree -r -p $id1 $id2 | colorize | pager
+cat $filter | xargs git-diff-tree $gitflags -r -p $id1 $id2 | colorize | pager
 
 rm $filter
 exit 0
diff --git a/cg-mkpatch b/cg-mkpatch
--- a/cg-mkpatch
+++ b/cg-mkpatch
@@ -22,6 +22,12 @@
 # -m::
 #	Base the patches at the merge base of the -r arguments
 #	(defaulting to HEAD and origin).
+
+# -M::
+# -C::
+# -B::
+#	Passed down to git-diff-*, to mean respectively "detect renames",
+#	"detect copies", "detect file rewriting".
 #
 # EXAMPLE USAGE
 # -------------
@@ -45,7 +51,7 @@ showpatch()
 	header=$(mktemp -t gitpatch.XXXXXX)
 	patch=$(mktemp -t gitpatch.XXXXXX)
 	id=$1
-	cg-diff -p -r $id >$patch
+	cg-diff $gitflags -p -r $id >$patch
 	git-cat-file commit $id | while read key rest; do
 		case "$key" in
 		"author"|"committer")
@@ -81,6 +87,7 @@ omit_header=
 log_start=
 log_end=
 mergebase=
+gitflags=
 
 while optparse; do
 	if optparse -s; then
@@ -101,6 +108,12 @@ while optparse; do
 		fi
 	elif optparse -m; then
 		mergebase=1
+	elif optparse -M; then
+		gitflags="$gitflags -M"
+	elif optparse -C; then
+		gitflags="$gitflags -C"
+	elif optparse -B; then
+		gitflags="$gitflags -B"
 	else
 		optfail
 	fi
