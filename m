From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Rework built-in diff to make its output more dense.
Date: Sun, 01 May 2005 00:19:40 -0700
Message-ID: <7vll6zza43.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<7vis231y7y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504302224510.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 09:14:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS8eO-0000xi-Eo
	for gcvg-git@gmane.org; Sun, 01 May 2005 09:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVEAHTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 03:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVEAHTr
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 03:19:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:3808 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261320AbVEAHTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 03:19:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501071940.JKSM7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 03:19:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504302224510.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 30 Apr 2005 22:27:50 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus says,

    The fewer lines there are that don't usually tell a human
    anything, the better. Dense is good.

This patch makes the default diff output more dense.  This
removes the previous misguided attempt to be cg-patch
compatible.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff.c |   26 +++++++++++++++-----------
1 files changed, 15 insertions(+), 11 deletions(-)

# - [PATCH] Resurrect diff-tree-helper -R
# + [PATCH] Rework built-in diff to make its output more dense.
--- k/diff.c
+++ l/diff.c
@@ -82,35 +82,32 @@ static void builtin_diff(const char *nam
 			 struct diff_tempfile *temp)
 {
 	int i, next_at;
-	const char *diff_cmd = "diff -L'%s%s%s' -L'%s%s%s'";
+	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
 	const char *diff_arg  = "'%s' '%s'";
 	const char *input_name_sq[2];
 	const char *path0[2];
 	const char *path1[2];
-	char mode[2][20];
 	const char *name_sq = sq_expand(name);
 	char *cmd;
 	
-	/* diff_cmd and diff_arg have 8 %s in total which makes
-	 * the sum of these strings 16 bytes larger than required.
+	/* diff_cmd and diff_arg have 6 %s in total which makes
+	 * the sum of these strings 12 bytes larger than required.
 	 * we use 2 spaces around diff-opts, and we need to count
-	 * terminating NUL, so we subtract 13 here.
+	 * terminating NUL, so we subtract 9 here.
 	 */
 	int cmd_size = (strlen(diff_cmd) + strlen(diff_opts) +
-			strlen(diff_arg) - 13);
+			strlen(diff_arg) - 9);
 	for (i = 0; i < 2; i++) {
 		input_name_sq[i] = sq_expand(temp[i].name);
 		if (!strcmp(temp[i].name, "/dev/null")) {
 			path0[i] = "/dev/null";
 			path1[i] = "";
-			mode[i][0] = 0;
 		} else {
 			path0[i] = i ? "l/" : "k/";
 			path1[i] = name_sq;
-			sprintf(mode[i], "  (mode:%s)", temp[i].mode);
 		}
 		cmd_size += (strlen(path0[i]) + strlen(path1[i]) +
-			     strlen(mode[i]) + strlen(input_name_sq[i]));
+			     strlen(input_name_sq[i]));
 	}
 
 	cmd = xmalloc(cmd_size);
@@ -118,13 +115,20 @@ static void builtin_diff(const char *nam
 	next_at = 0;
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    diff_cmd,
-			    path0[0], path1[0], mode[0],
-			    path0[1], path1[1], mode[1]);
+			    path0[0], path1[0], path0[1], path1[1]);
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    " %s ", diff_opts);
 	next_at += snprintf(cmd+next_at, cmd_size-next_at,
 			    diff_arg, input_name_sq[0], input_name_sq[1]);
 
+	if (!path1[0][0])
+		printf("Created: %s (mode:%s)\n", name, temp[1].mode);
+	else if (!path1[1][0])
+		printf("Deleted: %s\n", name);
+	else if (strcmp(temp[0].mode, temp[1].mode))
+		printf("Mode changed: %s (%s->%s)\n", name,
+		       temp[0].mode, temp[1].mode);
+	fflush(NULL);
 	execlp("/bin/sh","sh", "-c", cmd, NULL);
 }
 

