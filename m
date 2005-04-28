From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make diff-cache and friends output more cg-patch friendly.
Date: Wed, 27 Apr 2005 23:28:23 -0700
Message-ID: <7vbr7z9zzs.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050426214338.32e9ac27.akpm@osdl.org>
	<20050427235115.GN22956@pasky.ji.cz>
	<Pine.LNX.4.58.0504271708550.18901@ppc970.osdl.org>
	<20050428003246.GV22956@pasky.ji.cz>
	<7vhdhra2sg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 08:23:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR2Qe-0004vT-Bt
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 08:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVD1G2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 02:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVD1G2g
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 02:28:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36605 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262154AbVD1G23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 02:28:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428062825.XRGY7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 02:28:25 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7vhdhra2sg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 27 Apr 2005 22:27:59 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch changes the way the default arguments to diff are
built when diff-cache and friends are invoked with -p and there
is no GIT_EXTERNAL_DIFF environment variable.  It attempts to be
more cg-patch friendly by:

 - Showing diffs against /dev/null to denote added or removed
   files;

 - Showing file modes for existing files as a comment after the
   diff label.

Unfortunately with this change GIT_DIFF_CMD customization cannot
be supported easily anymore, so it has been dropped.
GIT_DIFF_OPTS customization to change diffs from unified to
context is still there, though.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |   56 ++++++++++++++++++++++++++++++++++++--------------------
1 files changed, 36 insertions(+), 20 deletions(-)

# - 04/27 21:50 diff.c clean up temporary file.
# + 04/27 23:18 Attempt to minimally be compatible with cg-Xdiffdo.
--- k/diff.c  (mode:100644)
+++ l/diff.c  (mode:100644)
@@ -7,7 +7,6 @@
 #include "cache.h"
 #include "diff.h"
 
-static char *diff_cmd = "diff -L'k/%s' -L'l/%s'";
 static char *diff_opts = "-pu";
 
 static const char *external_diff(void)
@@ -24,14 +23,12 @@ static const char *external_diff(void)
 	 * alternative styles you can specify via environment
 	 * variables are:
 	 *
-	 * GIT_DIFF_CMD="diff -L '%s' -L '%s'"
 	 * GIT_DIFF_OPTS="-c";
 	 */
 	if (getenv("GIT_EXTERNAL_DIFF"))
 		external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
 
 	/* In case external diff fails... */
-	diff_cmd = getenv("GIT_DIFF_CMD") ? : diff_cmd;
 	diff_opts = getenv("GIT_DIFF_OPTS") ? : diff_opts;
 
 	done_preparing = 1;
@@ -84,31 +81,50 @@ static struct diff_tempfile {
 static void builtin_diff(const char *name,
 			 struct diff_tempfile *temp)
 {
-	static char *diff_arg  = "'%s' '%s'";
-	const char *name_1_sq = sq_expand(temp[0].name);
-	const char *name_2_sq = sq_expand(temp[1].name);
+	int i, next_at;
+	const char *diff_cmd = "diff -L'%s%s%s' -L'%s%s%s'";
+	const char *diff_arg  = "'%s' '%s'";
+	const char *input_name_sq[2];
+	const char *path0[2];
+	const char *path1[2];
+	char mode[2][20];
 	const char *name_sq = sq_expand(name);
-
-	/* diff_cmd and diff_arg have 4 %s in total which makes
-	 * the sum of these strings 8 bytes larger than required.
+	char *cmd;
+	
+	/* diff_cmd and diff_arg have 8 %s in total which makes
+	 * the sum of these strings 16 bytes larger than required.
 	 * we use 2 spaces around diff-opts, and we need to count
-	 * terminating NUL, so we subtract 5 here.
+	 * terminating NUL, so we subtract 13 here.
 	 */
-	int cmd_size = (strlen(diff_cmd) + 
-			strlen(name_sq) * 2 +
-			strlen(diff_opts) +
-			strlen(diff_arg) +
-			strlen(name_1_sq) + strlen(name_2_sq)
-			- 5);
-	char *cmd = xmalloc(cmd_size);
-	int next_at = 0;
+	int cmd_size = (strlen(diff_cmd) + strlen(diff_opts) +
+			strlen(diff_arg) - 13);
+	for (i = 0; i < 2; i++) {
+		input_name_sq[i] = sq_expand(temp[i].name);
+		if (!strcmp(temp[i].name, "/dev/null")) {
+			path0[i] = "/dev/null";
+			path1[i] = "";
+			mode[i][0] = 0;
+		} else {
+			path0[i] = i ? "l/" : "k/";
+			path1[i] = name_sq;
+			sprintf(mode[i], "  (mode:%s)", temp[i].mode);
+		}
+		cmd_size += (strlen(path0[i]) + strlen(path1[i]) +
+			     strlen(mode[i]) + strlen(input_name_sq[i]));
+	}
+
+	cmd = xmalloc(cmd_size);
 
+	next_at = 0;
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
-			    diff_cmd, name_sq, name_sq);
+			    diff_cmd,
+			    path0[0], path1[0], mode[0],
+			    path0[1], path1[1], mode[1]);
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    " %s ", diff_opts);
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
-			    diff_arg, name_1_sq, name_2_sq);
+			    diff_arg, input_name_sq[0], input_name_sq[1]);
+
 	execlp("/bin/sh","sh", "-c", cmd, NULL);
 }
 

