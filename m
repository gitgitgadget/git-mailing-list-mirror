From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: [PATCH] Add optional destination to cg-clone.
Date: Wed, 4 May 2005 13:00:13 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0505041249520.24813@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 13:55:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTISK-00047G-Sn
	for gcvg-git@gmane.org; Wed, 04 May 2005 13:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVEDMAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 08:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEDMAl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 08:00:41 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:12260 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261675AbVEDMA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 08:00:26 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:49947)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:aia21) id 1DTIYC-0005Yr-1M (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Wed, 04 May 2005 13:00:24 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1DTIY1-0000Ip-KF (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Wed, 04 May 2005 13:00:13 +0100
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

Below is a patch to latest cogito.git which adds support for an optional 
destination to the cg-clone command, e.g. I like to use:

cd /usr/src
cg-clone rsync://blah/linux-2.6.git
cg-clone /usr/src/linux-2.6.git ntfs-2.6.git

Of course you can instead do:

cg-clone rsync://blah/linux-2.6.git /usr/src/linux-2.6.git
cg-clone /usr/src/linux-2.6.git /usr/src/ntfs-2.6.git

Without my patch you need to do:

cd /usr/src
cg-clone rsync://blah/linux-2.6.git
mkdir tmp.git
cd tmp.git
cg-clone /usr/src/linux-2.6.git
mv linux-2.6.git ../ntfs-2.6.git
cd ..
rmdir tmp.git

For some strange reason I prefer my version.  (-;

Please apply. Thanks.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

--- cogito.git/cg-help.old	2005-05-04 12:35:35.000000000 +0100
+++ cogito.git/cg-help	2005-05-04 12:35:37.000000000 +0100
@@ -26,7 +26,7 @@ Available commands:
 	cg-branch-add	BNAME SOURCE_LOC
 	cg-branch-ls
 	cg-cancel
-	cg-clone	SOURCE_LOC
+	cg-clone	SOURCE_LOC [DESTINATION]
 	cg-commit	[FILE]...	< log message on stdin
 	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [FILE]...
 	cg-export	DESTDIR [TREE_ID]
--- cogito.git/cg-clone.old	2005-05-03 21:33:05.000000000 +0100
+++ cogito.git/cg-clone	2005-05-04 12:43:04.000000000 +0100
@@ -3,18 +3,26 @@
 # Clone a remote GIT repository.
 # Copyright (c) Petr Baudis, 2005
 #
-# This is like cg-init, but works only for remote repositories and
-# will create a new directory where it will do the checkout.
+# This is like cg-init, but it will create a new directory where it will do
+# the checkout.
 #
-# Takes an parameter specifying location of the source repository.
+# Takes a parameter specifying the location of the source repository and an
+# optional second parameter specifying the destination.  If the second
+# parameter is omitted, the basename of the source repository is used as the
+# destination.
 
 . cg-Xlib
 
 location=$1
-[ "$location" ] || die "usage: cg-clone SOURCE_LOC"
+[ "$location" ] || die "usage: cg-clone SOURCE_LOC [DESTINATION]"
 location=${location%/}
 
-dir=${location%/.git}; dir=${dir##*/}
+destination=$2
+if [ "$destination" ]; then
+	dir=$destination
+else
+	dir=${location%/.git}; dir=${dir##*/}
+fi
 [ -e "$dir" ] && die "$dir/ already exists"
 mkdir "$dir" || exit $?
 cd "$dir" || exit $?
