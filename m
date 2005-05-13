From: David Greaves <david@dgreaves.com>
Subject: [PATCH 2/2] update cg-* to use cg-Xignore
Date: Fri, 13 May 2005 23:32:22 +0100
Message-ID: <E1DWihi-0007DQ-SD@ash.dgreaves.com>
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 14 00:34:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWijC-0002uc-1f
	for gcvg-git@gmane.org; Sat, 14 May 2005 00:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVEMWdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 18:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVEMWdq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 18:33:46 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:31191 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S262599AbVEMWc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 18:32:28 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 055CCE6E39; Fri, 13 May 2005 23:30:56 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10105-06; Fri, 13 May 2005 23:30:55 +0100 (BST)
Received: from oak.dgreaves.com (modem-1435.lemur.dialup.pol.co.uk [217.135.133.155])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 9F135E6E2F; Fri, 13 May 2005 23:30:54 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DWihi-0006uY-TS; Fri, 13 May 2005 23:32:22 +0100
Received: from david by ash.dgreaves.com with local (Exim 4.50)
	id 1DWihi-0007DQ-SD; Fri, 13 May 2005 23:32:22 +0100
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Updated
    cg-add
    cg-commit
    cg-init
    cg-status
to use the cg-Xignore

Signed-off-by: David Greaves <david@dgreaves.com>

---
commit 80e8dbdd3cf5e8d4ca0b6e446911d1ac17c5064e
tree 03662df7d089d4a84987ef9edb50a017b8b42439
parent 2fca920e6d3ccb92e9782bcf02f860b8333e23d9
author David Greaves <david@dgreaves.com> Fri, 13 May 2005 23:18:20 +0100
committer David Greaves <david@ash.(none)> Fri, 13 May 2005 23:18:20 +0100

 cg-add    |   13 +++++--------
 cg-commit |    9 +++++++++
 cg-init   |    7 ++++++-
 cg-status |   14 ++------------
 4 files changed, 22 insertions(+), 21 deletions(-)

Index: cg-add
===================================================================
--- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-add  (mode:100755)
+++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-add  (mode:100755)
@@ -11,11 +11,8 @@
 [ "$1" ] || die "usage: cg-add FILE..."
 
 for file in "$@"; do
-	if [ -f "$file" ] || [ -h "$file" ]; then
-		echo "Adding file $file"
-	else
-		die "$file does not exist"
-	fi
-done
-
-git-update-cache --add -- "$@"
+    if [ -f "$file" ] || [ -h "$file" ]; then
+	echo "Adding file $file" >&2
+    fi
+    echo "$file"
+done | cg-Xignore -f -h | xargs git-update-cache --add --
Index: cg-commit
===================================================================
--- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-commit  (mode:100755)
+++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-commit  (mode:100755)
@@ -65,6 +65,15 @@
 	[ -s $_git/merging ] && merging=$(cat $_git/merging | sed 's/^/-p /')
 fi
 
+# strip ignored files - *1 at a time* - any attempt to stream from 1
+# while loop to another uses a subprocess and can't pass the variable
+# back
+# Also I don't know if this can be put in a shell function
+for file in ${commitfiles[@]}
+  do
+  commitfiles[$i]=`echo $file | cg-Xignore`
+  ((i++))
+done
 
 LOGMSG=$(mktemp -t gitci.XXXXXX)
 LOGMSG2=$(mktemp -t gitci.XXXXXX)
Index: cg-init
===================================================================
--- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-init  (mode:100755)
+++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-init  (mode:100755)
@@ -7,6 +7,9 @@
 # remote repository. Note that this usage is DEPRECATED - use cg-clone
 # (possibly with the -s parameter) for doing this. This functionality
 # will go away from cg-init soon.
+#
+# if there is a file called cogito.ignore then it is used to prime the
+# .git/ignore patterns
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -19,6 +22,8 @@
 touch $_git/refs/heads/master
 ln -s refs/heads/master $_git/HEAD
 
+[ -f cogito.ignore ] && mv cogito.ignore .git/ignore
+
 if [ "$uri" ]; then
 	echo "$uri" >$_git/branches/origin
 	cg-pull origin || die "pull failed"
@@ -31,7 +36,7 @@
 	echo "Cloned (origin $uri available as branch \"origin\")"
 else
 	git-read-tree # Seed the dircache
-	find * -type f | xargs cg-add
+	find * | cg-Xignore -f -h | xargs cg-add
 	cg-commit -C -m"Initial commit" -e
 fi
 exit 0
Index: cg-status
===================================================================
--- d2490ad0bc8b38647c6baff9da3e72c0f25e9f35/cg-status  (mode:100755)
+++ 03662df7d089d4a84987ef9edb50a017b8b42439/cg-status  (mode:100755)
@@ -15,21 +15,11 @@
 
 {
 	git-ls-files -z -t --others --deleted --unmerged $EXCLUDE
-} | sort -z -k 2 | xargs -0 sh -c '
-while [ "$1" ]; do
-	tag=${1% *};
-	filename=${1#* };
-	case "$filename" in
-	*.[ao] | tags | ,,merge*) ;;
-	*)   echo "$tag $filename";;
-	esac
-	shift
-done
-' padding
+} | sort -z -k 2 | cg-Xignore -0 -t | tr "\000" "\n"
 
 {
 	git-update-cache --refresh
-} | cut -f 1 -d ":" | xargs sh -c '
+} | cut -f 1 -d ":" | cg-Xignore | xargs sh -c '
 while [ "$1" ]; do
 	tag="M";
 	filename=${1%: *};
