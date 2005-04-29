From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH] Make cg-clone handle local directories as sources
Date: Fri, 29 Apr 2005 17:59:29 -0400
Message-ID: <20050429215928.GF1233@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 29 23:55:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdR4-0000FL-50
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263018AbVD2V7x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVD2V7x
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:59:53 -0400
Received: from mail.autoweb.net ([198.172.237.26]:59279 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S263018AbVD2V7u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 17:59:50 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DRdWX-0007Cu-An
	for git@vger.kernel.org; Fri, 29 Apr 2005 17:59:49 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DRdWD-0003Vg-00
	for <git@vger.kernel.org>; Fri, 29 Apr 2005 17:59:29 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DRdWD-0001Xn-2T
	for git@vger.kernel.org; Fri, 29 Apr 2005 17:59:29 -0400
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


cg-clone is described as only being used with remote repositories, but
it has the nice feature of creating the destination directory for you.

This patch adds two features:
	1. A destination directory can (optionally) be specified.
	2. The source directory can be in the local file system.

The following, for example, now works:

	cg-clone rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
	mkdir test ; cd test
	cg-clone ../cogito ../cogito2/

Index: cg-clone
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-clone  (mode:100755 sha1:4ee0685c358e094c5350b3968d013105da6ddf7e)
+++ uncommitted/cg-clone  (mode:100755)
@@ -11,13 +11,22 @@
 . cg-Xlib
 
 location=$1
-[ "$location" ] || die "usage: cg-clone SOURCE_LOC"
+[ "$location" ] || die "usage: cg-clone SOURCE_LOC [DEST_LOC]"
 location=${location%/}
 
-dir=${location##*/}; dir=${dir%.git}
+if [ "$2" == "" ]; then
+	dir=${location##*/}; dir=${dir%.git}
+else
+	dir=$2
+fi
+
+pwd=$(pwd)
+relative_location=$(echo "$location" | sed -e "s#^[^/]#$pwd\/&#")
+
 [ -e "$dir" ] && die "$dir/ already exists"
 mkdir "$dir"
 cd "$dir"
 
-cg-init $location || exit $?
+echo "cg-init $relative_location"
+cg-init $relative_location || exit $?
 echo "Cloned to $dir/ (origin $location available as branch \"origin\")"


-- 

Ryan Anderson
  sometimes Pug Majere
