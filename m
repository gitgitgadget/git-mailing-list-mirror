From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Use the template mechanism to set up refs/ hierarchy as well.
Date: Tue, 02 Aug 2005 23:28:35 -0700
Message-ID: <7v3bprjzzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 03 08:29:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Ck7-0002Y5-JK
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 08:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVHCG2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 02:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVHCG2j
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 02:28:39 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:22656 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262099AbVHCG2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 02:28:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050803062837.WSBZ17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 02:28:37 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This may be controversial from the robustness standpoint, so I
am placing it in the proposed update queue first.  Discussions
on the list very welcomed.

Once the alternate object pool mechanism is taught to use
$GIT_DIR/info/alt file (instead of/in addition to the
environment variable), this would help people setting up
repositories for underling developers.  They can prepare a
standard template info/alt that points at the project-wide base
object pool that is shared, and have people point
GIT_TEMPLATE_DIRECTORY at the project standard template
directory.

------------
This removes the hardcoded set of refs/ directory structure that
is created by git-init-db and move it to the template
mechanism.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 init-db.c            |   22 ----------------------
 t/t5400-send-pack.sh |   16 +++++++++++++++-
 templates/Makefile   |    4 ++++
 3 files changed, 19 insertions(+), 23 deletions(-)

de8b5bf5605274d29b835947932b9b6c109f5d9f
diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -167,28 +167,6 @@ static void create_default_files(const c
 
 	if (len && path[len-1] != '/')
 		path[len++] = '/';
-
-	/*
-	 * Create .git/refs/{heads,tags}
-	 */
-	strcpy(path + len, "refs");
-	safe_create_dir(path);
-	strcpy(path + len, "refs/heads");
-	safe_create_dir(path);
-	strcpy(path + len, "refs/tags");
-	safe_create_dir(path);
-
-	/*
-	 * Create the default symlink from ".git/HEAD" to the "master"
-	 * branch
-	 */
-	strcpy(path + len, "HEAD");
-	if (symlink("refs/heads/master", path) < 0) {
-		if (errno != EEXIST) {
-			perror(path);
-			exit(1);
-		}
-	}
 	copy_templates(path);
 }
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -8,6 +8,18 @@ test_description='See why rewinding head
 '
 . ./test-lib.sh
 
+# This part is needed to test before installing templates.
+mkdir -p templates/refs/heads
+ln -s refs/heads/master templates/HEAD
+mkdir -p templates/hooks
+echo '#!/bin/sh
+echo we are here >$GIT_DIR/we-are-here' >templates/hooks/post-update
+chmod +x templates/hooks/post-update
+
+GIT_TEMPLATE_DIRECTORY=`pwd`/templates/
+export GIT_TEMPLATE_DIRECTORY
+git-init-db
+
 cnt='1'
 test_expect_success setup '
 	tree=$(git-write-tree) &&
@@ -50,5 +62,7 @@ test_expect_success \
 	fi &&
 	# this should update
 	git-send-pack --force ./victim/.git/ master &&
-	cmp victim/.git/refs/heads/master .git/refs/heads/master
+	cmp victim/.git/refs/heads/master .git/refs/heads/master &&
+	# and post-update should have run
+	test -f victim/.git/we-are-here
 '
diff --git a/templates/Makefile b/templates/Makefile
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -17,3 +17,7 @@ install:
 		$(dest)$(templatedir)/hooks/$(patsubst hooks--%,%,$s);)
 	$(INSTALL) -d -m755 $(dest)$(templatedir)/info
 	$(INSTALL) -d -m755 $(dest)$(templatedir)/branches
+	$(INSTALL) -d -m755 $(dest)$(templatedir)/refs/heads
+	$(INSTALL) -d -m755 $(dest)$(templatedir)/refs/tags
+	rm -f $(dest)$(templatedir)/HEAD && \
+	ln -s refs/heads/master $(dest)$(templatedir)/HEAD
