From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Create object subdirectories on demand (phase II)
Date: Fri, 07 Oct 2005 09:30:48 -0700
Message-ID: <7vll155lxj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510061612080.31407@g5.osdl.org>
	<7vfyrd7jll.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 18:33:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENv7V-0002uP-PK
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 18:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbVJGQav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 12:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbVJGQau
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 12:30:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:7084 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030494AbVJGQau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 12:30:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007163032.HCJE24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 12:30:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9806>

This removes the unoptimization.  The previous round does not mind
missing fan-out directories, but still makes sure they exist, lest
older versions choke on a repository created/packed by it.

This round does not play that nicely anymore -- empty fan-out
directories are not created by init-db, and will stay removed by
prune-packed.  The prune command also removes empty fan-out directories.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Here is what I did.  I unoptimized your original and that
    sits near the tip of "pu" branch.  This patch is to revert
    the unoptimization.  In addition, git-prune is told about
    the empty fan-out removal, although it may not matter that
    much.  Hopefully, the phase I can be included in the next
    official release, and after everybody updates, this patch
    can go in.

 git-prune.sh     |    1 +
 init-db.c        |    4 ----
 prune-packed.c   |    3 +--
 t/t0000-basic.sh |    8 ++++----
 4 files changed, 6 insertions(+), 10 deletions(-)

applies-to: d672cb30d513553ea3ca92a933563a25df1d7865
93638ce0a569543d0b41eedfac6873a541f5c753
diff --git a/git-prune.sh b/git-prune.sh
index 9657dbf..b28630c 100755
--- a/git-prune.sh
+++ b/git-prune.sh
@@ -22,6 +22,7 @@ sed -ne '/unreachable /{
 }' | {
 	cd "$GIT_OBJECT_DIRECTORY" || exit
 	xargs $echo rm -f
+	rmdir 2>/dev/null [0-9a-f][0-9a-f]
 }
 
 git-prune-packed $dryrun
diff --git a/init-db.c b/init-db.c
index aabc09f..921df9b 100644
--- a/init-db.c
+++ b/init-db.c
@@ -244,10 +244,6 @@ int main(int argc, char **argv)
 	memcpy(path, sha1_dir, len);
 
 	safe_create_dir(sha1_dir);
-	for (i = 0; i < 256; i++) {
-		sprintf(path+len, "/%02x", i);
-		safe_create_dir(path);
-	}
 	strcpy(path+len, "/pack");
 	safe_create_dir(path);
 	strcpy(path+len, "/info");
diff --git a/prune-packed.c b/prune-packed.c
index 73f0f3a..16685d1 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -27,8 +27,7 @@ static void prune_dir(int i, DIR *dir, c
 			error("unable to unlink %s", pathname);
 	}
 	pathname[len] = 0;
-	if (rmdir(pathname))
-		mkdir(pathname, 0777);
+	rmdir(pathname);
 }
 
 static void prune_packed_objects(void)
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 5c5f854..dff7d69 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -28,12 +28,12 @@ test_expect_success \
     '.git/objects should be empty after git-init-db in an empty repo.' \
     'cmp -s /dev/null should-be-empty' 
 
-# also it should have 258 subdirectories; 256 fan-out anymore, pack, and info.
-# 259 is counting "objects" itself
+# also it should have 2 subdirectories; no fan-out anymore, pack, and info.
+# 3 is counting "objects" itself
 find .git/objects -type d -print >full-of-directories
 test_expect_success \
-    '.git/objects should have 258 subdirectories.' \
-    'test $(wc -l < full-of-directories) = 259'
+    '.git/objects should have 3 subdirectories.' \
+    'test $(wc -l < full-of-directories) = 3'
 
 ################################################################
 # Basics of the basics
---
0.99.8.GIT
