From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sat, 26 Nov 2005 01:57:09 -0800
Message-ID: <7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:58:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efwny-0002Th-Ua
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbVKZJ5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVKZJ5L
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:57:11 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:4272 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750829AbVKZJ5K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:57:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095642.ZQAG3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:56:42 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12776>

This makes ls-tree to work from subdirectory.  It defaults to
show the paths under the current subdirectory, and interprets
user-supplied paths as relative to the current subdirectory.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 ls-tree.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

applies-to: 4e55e4796ee699c9361b3751a36a85ba282119a8
40af60bb52cd86e1f089eeb89b2d3d79531c55d1
diff --git a/ls-tree.c b/ls-tree.c
index d9f15e3..ed546a5 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -8,6 +8,8 @@
 #include "tree.h"
 #include "quote.h"
 
+static const char *prefix;
+
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
@@ -204,7 +206,7 @@ static int list_one(const char *path)
 	return err;
 }
 
-static int list(char **path)
+static int list(const char **path)
 {
 	int i;
 	int err = 0;
@@ -216,11 +218,16 @@ static int list(char **path)
 static const char ls_tree_usage[] =
 	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
-	static char *path0[] = { "", NULL };
-	char **path;
+	static const char *path0[] = { "", NULL };
+	const char **path;
 	unsigned char sha1[20];
+	int nongit = 0;
+
+	prefix = setup_git_directory_gently(&nongit);
+	if (prefix)
+		path0[0] = prefix;
 
 	while (1 < argc && argv[1][0] == '-') {
 		switch (argv[1][1]) {
@@ -244,7 +251,11 @@ int main(int argc, char **argv)
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
 
-	path = (argc == 2) ? path0 : (argv + 2);
+	if (argc == 2)
+		path = path0;
+	else
+		path = get_pathspec(prefix, argv + 2);
+
 	prepare_root(sha1);
 	if (list(path) < 0)
 		die("list failed");
---
0.99.9.GIT
