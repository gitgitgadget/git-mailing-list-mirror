From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] cogito: honour SHA1_FILE_DIRECTORY env var
Date: Fri, 29 Apr 2005 14:57:31 +0200
Message-ID: <20050429125731.GA23018@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 15:43:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRVlR-0001TW-Fw
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 15:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVD2M5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 08:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVD2M5f
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 08:57:35 -0400
Received: from neapel230.server4you.de ([217.172.187.230]:48540 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S262538AbVD2M5c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 08:57:32 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 66C6F268; Fri, 29 Apr 2005 14:57:31 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Three scripts have their object store directory hardcoded to
.git/objects/.  This patch makes them honour the environment variable
SHA1_FILE_DIRECTORY like core GIT.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

Index: cg-admin-lsobj
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-admin-lsobj  (mode:100755 sha1:c68d9176d843700df17b109389102ae84eab3888)
+++ 4e32eadd27409a1352f17cb43703aa33420ac1fd/cg-admin-lsobj  (mode:100755 sha1:8410960a067f93a9457b250fea7b3636fb0eab42)
@@ -21,7 +21,7 @@
 target=$1
 
 
-subdir=.git/objects/
+subdir=${SHA1_FILE_DIRECTORY:-.git/objects}
 
 for high in 0 1 2 3 4 5 6 7 8 9 a b c d e f ; do
 	for low in 0 1 2 3 4 5 6 7 8 9 a b c d e f ; do
Index: cg-pull
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/cg-pull  (mode:100755 sha1:5cd67519fc5399886f22e8758d6d34e0e3014cbb)
+++ 4e32eadd27409a1352f17cb43703aa33420ac1fd/cg-pull  (mode:100755 sha1:52d686091f2d04a0d532a3ea1d622d6da4bad14c)
@@ -94,8 +94,9 @@
 fi
 [ "$rsyncerr" ] && die "unable to get the head pointer of branch $rembranch"
 
-[ -d .git/objects ] || mkdir -p .git/objects
-$fetch -s -u -d "$uri/objects" ".git/objects" || die "rsync error"
+sha1_dir=${SHA1_FILE_DIRECTORY:-.git/objects}
+[ -d "$sha1_dir" ] || mkdir -p "$sha1_dir"
+$fetch -s -u -d "$uri/objects" "$sha1_dir" || die "rsync error"
 
 # FIXME: Warn about conflicting tag names?
 # XXX: We now throw stderr to /dev/null since not all repositories
Index: commit-id
===================================================================
--- c3aa1e6b53cc59d5fbe261f3f859584904ae3a63/commit-id  (mode:100755 sha1:4efcb6bdfdb2b2c5744f5d4d47d92beb7777ed59)
+++ 4e32eadd27409a1352f17cb43703aa33420ac1fd/commit-id  (mode:100755 sha1:7f04b10cf8805cf2eb950a5dc3d451882e9d4929)
@@ -23,8 +23,9 @@
 
 idpref=$(echo "$id" | cut -c -2)
 idpost=$(echo "$id" | cut -c 3-)
-if [ $(find ".git/objects/$idpref" -name "$idpost*" 2>/dev/null | wc -l) -eq 1 ]; then
-	id=$idpref$(basename $(echo .git/objects/$idpref/$idpost*))
+sha1_dir=${SHA1_FILE_DIRECTORY:-.git/objects}
+if [ $(find "$sha1_dir/$idpref" -name "$idpost*" 2>/dev/null | wc -l) -eq 1 ]; then
+	id=$idpref$(basename $(echo "$sha1_dir/$idpref/$idpost"*))
 fi
 
 if echo $id | egrep -vq "$SHA1ONLY"; then
