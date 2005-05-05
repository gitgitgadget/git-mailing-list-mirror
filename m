From: Jan Veldeman <jan.veldeman@advalvas.be>
Subject: [PATCH] cogito: allow filenames with spaces in cg-commit
Date: Thu, 5 May 2005 17:40:04 +0200
Message-ID: <20050505154004.GA20329@fanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 17:35:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTiML-0003rY-QW
	for gcvg-git@gmane.org; Thu, 05 May 2005 17:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVEEPjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVEEPjw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 11:39:52 -0400
Received: from europa.telenet-ops.be ([195.130.132.60]:6027 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262070AbVEEPj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 11:39:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by europa.telenet-ops.be (Postfix) with SMTP
	id 2484A1982A4; Thu,  5 May 2005 17:39:25 +0200 (MEST)
Received: from localhost (d54C3B9F1.access.telenet.be [84.195.185.241])
	by europa.telenet-ops.be (Postfix) with ESMTP
	id 009AC198280; Thu,  5 May 2005 17:39:25 +0200 (MEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fixes the filename handling in cg-commit.

To allow spaces in the filenames, the filenames are kept in an array.
(The trick with zero bytes is harder to do when storing the filenames in
a variable).
"${commitfiles[@]}" is used where the filenames are needed as separate
arguments, this expands into "file 1" "file 2" ...
"${commitfiles[*]}" is used when a check is made for the existence of the
parameter, this expands into "file1 file 2 ..."

The eval changedfiles=($(... | sed ...)) is used to place the result of
git-diff-cache into the array. (I couldn't find a cleaner solution to do
this)

Signed-off-by: Jan Veldeman <Jan.Veldeman@advalvas.be>

Index: cogito/cg-commit
===================================================================
--- cogito.orig/cg-commit	2005-05-05 17:13:44.000000000 +0200
+++ cogito/cg-commit	2005-05-05 17:34:37.000000000 +0200
@@ -22,8 +22,8 @@
 fi
 
 if [ "$1" ]; then
-	commitfiles="$@"
-	customfiles=$commitfiles
+	commitfiles=("$@")
+	customfiles="${commitfiles[*]}"
 
 	[ "$ignorecache" ] && die "-C and listing files to commit does not make sense"
 	[ -s .git/merging ] && die "cannot commit individual files when merging"
@@ -37,8 +37,9 @@
 	# be committed along automagically as well.
 
 	if [ ! "$ignorecache" ]; then
-		changedfiles=$(git-diff-cache $(tree-id) | cut -f 4-)
-		commitfiles="$addedfiles $remfiles $changedfiles"
+		eval changedfiles=($(git-diff-cache $(tree-id) | cut -f 4- | \
+			sed -e 's/^/"/' -e 's/$/"/'))
+		commitfiles=($addedfiles $remfiles "${changedfiles[@]}")
 	fi
 
 	merging=
@@ -46,11 +47,11 @@
 fi
 
 if [ ! "$ignorecache" ]; then
-	if [ ! "$commitfiles" ]; then
+	if [ ! "${commitfiles[*]}" ]; then
 		echo 'Nothing to commit.' >&2
 		exit 2
 	fi
-	for file in $commitfiles; do
+	for file in "${commitfiles[@]}"; do
 		# Prepend a letter describing whether it's addition,
 		# removal or update. Or call git status on those files.
 		echo $file;
@@ -76,13 +77,13 @@
 
 if [ ! "$ignorecache" ]; then
 	if [ "$customfiles" ]; then
-		echo $commitfiles | xargs git-update-cache --add --remove \
+		git-update-cache --add --remove "${commitfiles[@]}" \
 			|| die "update-cache failed"
 		export GIT_INDEX_FILE=$(mktemp -t gitci.XXXXXX)
 		git-read-tree $(tree-id)
 	fi
 	# TODO: Do the proper separation of adds, removes, and changes.
-	echo $commitfiles | xargs git-update-cache --add --remove \
+	git-update-cache --add --remove "${commitfiles[@]}" \
 		|| die "update-cache failed"
 fi
 
