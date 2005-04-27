From: jcorbin@node1.wunjo.org (Joshua T. Corbin)
Subject: [PATCH] cg-export user the new tar-tree
Date: Wed, 27 Apr 2005 16:14:34 -0400 (EDT)
Message-ID: <20050427201434.E21BE42F01@node1.wunjo.org>
Cc: Petr Baudis <pasky@ucw.cz>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:10:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQsqS-0002Aj-Gm
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVD0UOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVD0UOi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:14:38 -0400
Received: from node1.wunjo.org ([64.62.190.230]:63930 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261997AbVD0UOf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 16:14:35 -0400
Received: by node1.wunjo.org (Postfix, from userid 1001)
	id E21BE42F01; Wed, 27 Apr 2005 16:14:34 -0400 (EDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

If at first you don't succeed, try to fix it....failing that, dump kmail and cat | mail ;)

Okay, so this time around, there are REAL-LIVE tabs in this one...

And this time, there are no temporary files...

Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/cg-export  (mode:100755 sha1:d39eb8e723c8cb74c96b64d510f49d1bfcd7d5f8)
+++ 345e15e9173ca1d419a2ff2583696ff4166e5df3/cg-export  (mode:100755 sha1:ff9aa02ff3426e20b09901a291d568bc2ce2b72a)
@@ -8,15 +8,35 @@
 
 . cg-Xlib
 
-destdir=$1
+dest=$1
 id=$(tree-id $2)
 
-([ "$destdir" ] && [ "$id" ]) || die "usage: cg-export DESTDIR [TREE_ID]"
+([ "$dest" ] && [ "$id" ]) || die "usage: cg-export DESTDIR [TREE_ID]"
 
-[ -e "$destdir" ] && die "$destdir already exists."
+[ -e "$dest" ] && die "$dest already exists."
 
-mkdir -p $destdir || die "cannot create $destdir"
-export GIT_INDEX_FILE="$destdir/.git-index"
-read-tree $id
-checkout-cache "--prefix=$destdir/" -a
-rm $GIT_INDEX_FILE
+case $dest in
+	*.tar|*.tar.gz|*.tar.bz2|*.tgz)
+		base=${dest%.tar*};
+		base=${base%.tgz}
+		ext=${dest#$base}
+		case $ext in
+		.tar.gz|.tgz)
+			tar-tree $id "$base" | gzip -c9 $tar > $dest
+			;;
+		.tar.bz2)
+			tar-tree $id "$base" | bzip2 -c $tar > $dest
+			;;
+		.tar)
+			tar-tree $id "$base" > $dest
+			;;
+		esac
+		;;
+	*)
+		mkdir -p $dest || die "cannot create $dest"
+		export GIT_INDEX_FILE="$dest/.git-index"
+		read-tree $id
+		checkout-cache "--prefix=$dest/" -a
+		rm $GIT_INDEX_FILE
+	;;
+esac
