From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Show which files was changed in the git log output
Date: Mon, 25 Apr 2005 03:22:06 +0200
Message-ID: <20050425012206.GA29069@diku.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 03:17:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPsE9-0003bH-EY
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 03:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbVDYBWW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 21:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVDYBWW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 21:22:22 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:58103 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262394AbVDYBWI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 21:22:08 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 513456E2A72; Mon, 25 Apr 2005 03:21:15 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 099ED6E2A6E; Mon, 25 Apr 2005 03:21:15 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E5F3D61FDD; Mon, 25 Apr 2005 03:22:06 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Mail-Followup-To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
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


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have attached a patch probe to optionally have the git log command
list which files was changed by a commit.

It would be nice if someone with a more in depth knowledge of which
sha1s to pass to diff-tree when there are multiple parents could comment
on whether it does the right thing.

Right now it does the following: if there are only one parent it is
diffed against the commit tree and if there are two parents they are
diffed. I assume the order they are diffed doesn't matter.

-- 
Jonas Fonseca

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="show-changed-files.patch"

Index: githelp.sh
===================================================================
--- 7de71a831508e51e0985cea173f3f7a7012c82b7/githelp.sh  (mode:100755 sha1:e19176d4ef69a2e7c6da6b9893e2c7cdac24760a)
+++ uncommitted/githelp.sh  (mode:100755)
@@ -19,7 +19,7 @@
 	fork		BNAME BRANCH_DIR [COMMIT_ID]
 	help
 	init		RSYNC_URL
-	log		[-c] [COMMIT_ID | COMMIT_ID:COMMIT_ID]
+	log		[-c] [-f] [COMMIT_ID | COMMIT_ID:COMMIT_ID]
 	ls		[TREE_ID]
 	lsobj		[OBJTYPE]
 	lsremote
Index: gitlog.sh
===================================================================
--- 7de71a831508e51e0985cea173f3f7a7012c82b7/gitlog.sh  (mode:100755 sha1:a09ffda484bd859a3bcb1cffcc8fd6f9c65fa8e7)
+++ uncommitted/gitlog.sh  (mode:100755)
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
 
@@ -24,16 +27,25 @@
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
 if echo "$1" | grep -q ':'; then
 	id1=$(commit-id $(echo "$1" | cut -d : -f 1)) || exit 1
 	id2=$(commit-id $(echo "$1" | cut -d : -f 2)) || exit 1
@@ -49,6 +61,8 @@
 
 $revls | $revsort | while read time commit parents; do
 	[ "$revfmt" = "rev-list" ] && commit="$time"
+	tree1=
+	tree2=
 	echo $colheader""commit ${commit%:*} $coldefault;
 	cat-file commit $commit | \
 		while read key rest; do
@@ -73,11 +87,32 @@
 				fi
 				;;
 			"")
+				if [ -n $list_files ]; then
+					sep=
+					echo
+					echo -n "    * $colfiles"
+					diff-tree -r $tree1 $tree2 | \
+					while read modes type sha1s file; do
+						echo -n "$sep$file"
+						sep=", "
+					done
+					echo "$coldefault"
+				fi
 				echo; sed -re '
 					/ *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
 					s/^/    /
 				'
 				;;
+			"tree"|"parent")
+				if [ -z $tree1 ]; then
+					tree1=$rest
+				elif [ -z $tree2 ]; then
+					tree2=$rest
+				else
+					tree1=$rest
+				fi
+				echo $colheader$key $rest $coldefault
+				;;
 			*)
 				echo $colheader$key $rest $coldefault
 				;;

--CE+1k2dSO48ffgeK--
