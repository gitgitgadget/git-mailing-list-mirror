From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: [PATCH] cg-export to tarball
Date: Tue, 26 Apr 2005 03:12:46 -0400
Message-ID: <200504260312.46320.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 09:10:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQKCB-0003kF-16
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 09:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVDZHOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 03:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVDZHOM
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 03:14:12 -0400
Received: from node1.wunjo.org ([64.62.190.230]:40628 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261372AbVDZHOA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 03:14:00 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id E711242EFE; Tue, 26 Apr 2005 03:13:59 -0400 (EDT)
Received: from [192.168.1.100] (24.238.44.109.res-cmts.tv13.ptd.net [24.238.44.109])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id 7A22A42B74
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 03:13:57 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on node1
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The following patch to cg-export will simlpy create a tarball if the argument 
ends in .tar.gz, .tar.bz2, or .tar.

Signed-off-by; Joshua T. Corbin <jcorbin@wunjo.org>

Index: cg-export
===================================================================
--- c7eec90959408a71c465b36e728113a2754f99df/cg-export  (mode:100755 
sha1:94d419de48a12f1ea1059451ac4cd489f7008916)
+++ b839b802f91e79ea7b0bb7dcf3e228659bf96a87/cg-export  (mode:100755 
sha1:29834b2749b0a8d7c71a4c67325e4f5ece9d28a0)
@@ -24,8 +24,33 @@
 
 [ -e "$destdir" ] && die "$destdir already exists."
 
+case $destdir in
+  *.tar*)
+    tarfile=$destdir
+    destdir=${destdir%.tar*}
+    ;;
+esac
+
 mkdir -p $destdir || die "cannot create $destdir"
 export GIT_INDEX_FILE="$destdir/.git-index"
 read-tree $id
 checkout-cache "--prefix=$destdir/" -a
 rm $GIT_INDEX_FILE
+
+[ -z "$tarfile" ] && exit 0
+
+case $tarfile in
+  *.tar.gz)
+    tar -cvzf $tarfile $destdir || die "Failed to create $tarfile"
+    ;;
+  *.tar.bz2)
+    tar -cvjf $tarfile $destdir || die "Failed to create $tarfile"
+    ;;
+  *.tar)
+    tar -cvf $tarfile $destdir || die "Failed to create $tarfile"
+    ;;
+  *)
+    die "Don't know how to make a ${tarfile#$destdir} file"
+    ;;
+esac
+rm -fr $destdir
