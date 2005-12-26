From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Do not allow git-init-db to be called twice in the same
 directory
Date: Tue, 27 Dec 2005 00:54:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512270053030.14928@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Dec 27 00:54:14 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Er2AN-0008NU-8A
	for gcvg-git@gmane.org; Tue, 27 Dec 2005 00:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVLZXyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Dec 2005 18:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVLZXyI
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Dec 2005 18:54:08 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:52386 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932165AbVLZXyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2005 18:54:06 -0500
Received: from amavis.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.46])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8C096E1024; Tue, 27 Dec 2005 00:54:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id 7F2CB342D;
	Tue, 27 Dec 2005 00:54:05 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id 5E52C8E7;
	Tue, 27 Dec 2005 00:54:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3D4F813F558; Tue, 27 Dec 2005 00:54:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14066>


t5300 is also adapted, since it relies heavily on init-db not complaining 
when $GIT_DIR already exists.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 init-db.c              |    3 ++-
 t/t5300-pack-object.sh |   16 ++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

199557e282c6b7600fdb9f7ce8b203b1d634de8f
diff --git a/init-db.c b/init-db.c
index ff29496..1cb015e 100644
--- a/init-db.c
+++ b/init-db.c
@@ -259,7 +259,8 @@ int main(int argc, char **argv)
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
 		fprintf(stderr, "defaulting to local storage area\n");
 	}
-	safe_create_dir(git_dir, 0);
+	if (mkdir(git_dir, 0777) < 0)
+		die("Cannot initialize repository twice!");
 
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 7dfb1ab..df6549c 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -38,13 +38,12 @@ test_expect_success \
     'packname_1=$(git-pack-objects --window=0 test-1 <obj-list)'
 
 rm -fr .git2
-mkdir .git2
 
 test_expect_success \
     'unpack without delta' \
-    "GIT_OBJECT_DIRECTORY=.git2/objects &&
+    "GIT_DIR=.git2 git-init-db &&
+     GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
      git-unpack-objects -n <test-1-${packname_1}.pack &&
      git-unpack-objects <test-1-${packname_1}.pack"
 
@@ -69,13 +68,12 @@ test_expect_success \
      packname_2=$(git-pack-objects test-2 <obj-list)'
 
 rm -fr .git2
-mkdir .git2
 
 test_expect_success \
     'unpack with delta' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
+    'GIT_DIR=.git2 git-init-db &&
+     GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
      git-unpack-objects -n <test-2-${packname_2}.pack &&
      git-unpack-objects <test-2-${packname_2}.pack'
 
@@ -94,13 +92,12 @@ test_expect_success \
 cd "$TRASH"
 
 rm -fr .git2
-mkdir .git2
 
 test_expect_success \
     'use packed objects' \
-    'GIT_OBJECT_DIRECTORY=.git2/objects &&
+    'GIT_DIR=.git2 git-init-db &&
+     GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
      cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
@@ -111,7 +108,6 @@ test_expect_success \
     } >current &&
     diff expect current'
 
-
 test_expect_success \
     'use packed deltified objects' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
-- 
1.0.GIT
