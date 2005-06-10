From: takis@lumumba.luc.ac.be (Panagiotis Issaris)
Subject: [PATCH] support incremental cvs2git-ing
Date: Fri, 10 Jun 2005 21:35:19 +0200
Message-ID: <20050610193519.GA28628@lumumba.luc.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 21:30:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgpCV-0000ZI-NU
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 21:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVFJTeC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 15:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVFJTeC
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 15:34:02 -0400
Received: from lumumba.uhasselt.be ([193.190.9.252]:48389 "EHLO
	lumumba.luc.ac.be") by vger.kernel.org with ESMTP id S261183AbVFJTd4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 15:33:56 -0400
Received: by lumumba.luc.ac.be (Postfix, from userid 1000)
	id 62183EDB2B; Fri, 10 Jun 2005 21:35:19 +0200 (CEST)
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Linus,

I wanted to be able to track CVS repositories in a GIT repository. The
cvs2git program worked fine with the initial import but needed a tiny
modification to enable me to resync the GIT repository with the updated
CVS tree.

With friendly regards,
Takis

Signed-off-by: Panagiotis Issaris <takis@lumumba.luc.ac.be>
---

diff --git a/cvs2git.c b/cvs2git.c
--- a/cvs2git.c
+++ b/cvs2git.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 
 static int verbose = 0;
+static int updating = 0;
 
 /*
  * This is a really stupid program that takes cvsps output, and
@@ -28,11 +29,17 @@ static int verbose = 0;
  * Usage:
  *
  *	TZ=UTC cvsps -A |
- *		cvs2git --cvsroot=[root] --module=[module] > script
+ *		git-cvs2git --cvsroot=[root] --module=[module] > script
  *
  * Creates a shell script that will generate the .git archive of
  * the names CVS repository.
  *
+ *	TZ=UTC cvsps -s 1234- -A |
+ *		git-cvs2git -u --cvsroot=[root] --module=[module] > script
+ *
+ * Creates a shell script that will update the .git archive with
+ * CVS changes from patchset 1234 until the last one.
+ *
  * IMPORTANT NOTE ABOUT "cvsps"! This requires version 2.1 or better,
  * and the "TZ=UTC" and the "-A" flag is required for sane results!
  */
@@ -113,7 +120,7 @@ static void prepare_commit(void)
 
 static void commit(void)
 {
-	const char *cmit_parent = initial_commit ? "" : "-p HEAD";
+	const char *cmit_parent = (initial_commit && !updating) ? "" : "-p HEAD";
 	const char *dst_branch;
 	char *space;
 	int i;
@@ -230,6 +237,10 @@ int main(int argc, char **argv)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-u")) {
+			updating = 1;
+			continue;
+		}
 	}
 
 
@@ -241,11 +252,13 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	printf("[ -d .git ] && exit 1\n");
-	printf("git-init-db\n");
-	printf("mkdir -p .git/refs/heads\n");
-	printf("mkdir -p .git/refs/tags\n");
-	printf("ln -sf refs/heads/master .git/HEAD\n");
+    if (!updating) {
+    	printf("[ -d .git ] && exit 1\n");
+	    printf("git-init-db\n");
+    	printf("mkdir -p .git/refs/heads\n");
+    	printf("mkdir -p .git/refs/tags\n");
+    	printf("ln -sf refs/heads/master .git/HEAD\n");
+    }
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int linelen = strlen(line);
