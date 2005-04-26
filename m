From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-log: Add -f switch to list changed files
Date: Wed, 27 Apr 2005 01:03:10 +0200
Message-ID: <20050426230310.GD28560@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 00:59:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQZ0O-0006sb-B6
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 00:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVDZXDZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 19:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVDZXDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 19:03:25 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:50660 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261837AbVDZXDL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 19:03:11 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 87A696E2B99; Wed, 27 Apr 2005 01:02:16 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 295516E2B9B; Wed, 27 Apr 2005 01:02:16 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A695461FDE; Wed, 27 Apr 2005 01:03:10 +0200 (CEST)
To: pasky@ucw.cz
Mail-Followup-To: pasky@ucw.cz, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add -f switch to show changed files between the commit header and log message.
It doesn't do anything fancy like wrapping long lines and can be quite costly.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit e5eb91b0a47e1169006034af434312c7f38dc902
tree bd580d135661ff0bc8eb32cb36025cd1e7bdda13
parent 580058cf4cbb6c95e5e84480499ca1c635d99376
author Jonas Fonseca <fonseca@diku.dk> 1114556053 +0200
committer Jonas Fonseca <fonseca@diku.dk> 1114556053 +0200

 cg-help |    2 +-
 cg-log  |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

Index: cg-help
===================================================================
--- 57a559984564e31e79db28d9ad62b8ea3a55dda1/cg-help  (mode:100755 sha1:86f29161aadf15411244db9514a1fdfb03e664bd)
+++ bd580d135661ff0bc8eb32cb36025cd1e7bdda13/cg-help  (mode:100755 sha1:18cc6a72de1cbe8ad7c66c30485350b5da252f9f)
@@ -21,7 +21,7 @@
 	cg-export	DESTDIR [TREE_ID]
 	cg-help
 	cg-init		[SOURCE_LOC]
-	cg-log		[-c] [COMMIT_ID | COMMIT_ID:COMMIT_ID]
+	cg-log		[-c] [-f] [COMMIT_ID | COMMIT_ID:COMMIT_ID]
 	cg-ls		[TREE_ID]
 	cg-merge	[-c] [-b BASE_ID] FROM_ID
 	cg-mkpatch	[COMMIT_ID | COMMIT_ID:COMMIT_ID]
Index: cg-log
===================================================================
--- 57a559984564e31e79db28d9ad62b8ea3a55dda1/cg-log  (mode:100755 sha1:58dd26ebf549cfb2e8e96fa2128f0dd34561ad55)
+++ bd580d135661ff0bc8eb32cb36025cd1e7bdda13/cg-log  (mode:100755 sha1:1c53b31a956e7c8cbfe653143cc0f91df02a2f86)
@@ -13,8 +13,11 @@
 #	header		Green	
 #	author 		Cyan
 #	committer	Magenta
+#	files		Blue
 #	signoff		Yellow
 #
+# Takes an -f option to show which files was changed.
+#
 # Takes an id resolving to a commit to start from (HEAD by default),
 # or id1:id2 representing an (id1;id2] range of commits to show.
 
@@ -26,16 +29,44 @@
 	colheader="$(tput setaf 2)"    # Green
 	colauthor="$(tput setaf 6)"    # Cyan
 	colcommitter="$(tput setaf 5)" # Magenta
+	colfiles="$(tput setaf 4)"     # Blue
 	colsignoff="$(tput setaf 3)"   # Yellow
 	coldefault="$(tput op)"        # Restore default
 else
 	colheader=
 	colauthor=
 	colcommitter=
+	colfiles=
 	colsignoff=
 	coldefault=
 fi
 
+if [ "$1" = "-f" ]; then
+	shift
+	list_files=1
+else
+	list_files=
+fi
+
+list_commit_files()
+{
+	tree1="$1"
+	tree2="$2"
+	sep="    * $colfiles"
+	# List all files for for the initial commit
+	if [ -z $tree2 ]; then
+		list_cmd="ls-tree $tree1"
+	else
+		list_cmd="diff-tree -r $tree1 $tree2"
+	fi
+	echo
+	$list_cmd | while read modes type sha1s file; do
+		echo -n "$sep$file"
+		sep=", "
+	done
+	echo "$coldefault:"
+}
+
 if echo "$1" | grep -q ':'; then
 	id1=$(commit-id $(echo "$1" | cut -d : -f 1)) || exit 1
 	id2=$(commit-id $(echo "$1" | cut -d : -f 2)) || exit 1
@@ -51,6 +82,8 @@
 
 $revls | $revsort | while read time commit parents; do
 	[ "$revfmt" = "rev-list" ] && commit="$time"
+	tree1=
+	tree2=
 	echo $colheader""commit ${commit%:*} $coldefault;
 	cat-file commit $commit | \
 		while read key rest; do
@@ -75,11 +108,22 @@
 				fi
 				;;
 			"")
+				if [ -n "$list_files" ]; then
+					list_commit_files "$tree1" "$tree2"
+				fi
 				echo; sed -re '
 					/ *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
 					s/./    &/
 				'
 				;;
+			"tree"|"parent")
+				if [ -z $tree1 ]; then
+					tree1=$rest
+				elif [ -z $tree2 ]; then
+					tree2=$rest
+				fi
+				echo $colheader$key $rest $coldefault
+				;;
 			*)
 				echo $colheader$key $rest $coldefault
 				;;


-- 
Jonas Fonseca
