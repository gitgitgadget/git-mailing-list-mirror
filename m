From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Add "clone" support to lntree
Date: Fri, 15 Apr 2005 21:56:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504152142360.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 03:52:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMcTt-0001ub-1L
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 03:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVDPBzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 21:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVDPBzv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 21:55:51 -0400
Received: from iabervon.org ([66.92.72.58]:43524 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262562AbVDPBzm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 21:55:42 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMcXT-0002Qi-00; Fri, 15 Apr 2005 21:56:03 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I often want to take a base tree, which I keep tracking some remote head,
and make a local working tree that starts from it. This makes "git ln -c
<dest>" give you a tree that you can just start working in and then diff
against the head you'd started from and send off.

Signed-Off-By: Daniel Barkalow <barkalow@iabervon.org>

Index: gitlntree.sh
===================================================================
--- b068d3ec7c00cfe4a1f14a898f61c4807cd5bc8b/gitlntree.sh  (mode:100755 sha1:17c4966ea64aeced96ae4f1b00f3775c1904b0f1)
+++ 0877e1b9b70a4305959b7f65ace4044e4ae0afdb/gitlntree.sh  (mode:100755 sha1:84cbf0492996f1139b992147b4f53bc14342e3f2)
@@ -7,11 +7,14 @@
 # same objects database as the current one. It also shares the
 # branches and tags information.
 #
-# The new directory is completely pristine - there's not even
-# a directory cache there yet.
-#
 # Takes the new directory name.
 
+if [ "$1" = "-c" ]
+then
+    clone=yes
+    shift 1
+fi
+
 destdir=$1
 
 die () {
@@ -32,3 +35,12 @@
 ln -s $srcdir/.git/objects $dgitdir/objects
 ln -s $srcdir/.git/remotes $dgitdir/remotes
 ln -s $srcdir/.git/tags $dgitdir/tags
+
+if [ "$clone" != "" ]
+then
+    cp $srcdir/.git/HEAD $dgitdir/HEAD
+    cd $destdir
+    read-tree $(tree-id)
+    checkout-cache -a
+    update-cache --refresh
+fi

