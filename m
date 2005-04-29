From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Make cg-clone handle local directories as sources
Date: Fri, 29 Apr 2005 18:17:10 -0400
Message-ID: <20050429221710.GH1233@mythryan2.michonline.com>
References: <20050429215928.GF1233@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:12:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdiF-0001xJ-TG
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 00:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVD2WRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVD2WRj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:17:39 -0400
Received: from mail.autoweb.net ([198.172.237.26]:17808 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S263028AbVD2WRg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 18:17:36 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DRdnj-0007Zk-KO
	for git@vger.kernel.org; Fri, 29 Apr 2005 18:17:35 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DRdnP-0003Zf-00; Fri, 29 Apr 2005 18:17:15 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DRdnP-0002kk-7T; Fri, 29 Apr 2005 18:17:15 -0400
To: Ryan Anderson <ryan@michonline.com>
Content-Disposition: inline
In-Reply-To: <20050429215928.GF1233@mythryan2.michonline.com>
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

(This version of the patch actually doesn't break existing
functionality.)

Index: cg-clone
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-clone  (mode:100755 sha1:4ee0685c358e094c5350b3968d013105da6ddf7e)
+++ 3dc3edca08f66f90147d0cb2240274072fa8644a/cg-clone  (mode:100755 sha1:e42237e0408bc3f34cc70a956c29df1251bd1571)
@@ -11,13 +11,25 @@
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
+if ! echo "$location" | grep -q ":" ; then
+	relative_location=$(echo "$location" | sed -e "s#^[^/]#$pwd\/&#")
+else
+	relative_location="$location"
+fi
+
 [ -e "$dir" ] && die "$dir/ already exists"
 mkdir "$dir"
 cd "$dir"
 
-cg-init $location || exit $?
+cg-init "$relative_location" || exit $?
 echo "Cloned to $dir/ (origin $location available as branch \"origin\")"
