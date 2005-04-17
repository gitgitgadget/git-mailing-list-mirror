From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-diff shell safety
Date: Sat, 16 Apr 2005 17:36:22 -0700
Message-ID: <7vbr8e44u1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 02:33:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxip-0008WB-L8
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVDQAgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVDQAgz
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:36:55 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38631 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261219AbVDQAgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 20:36:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417003622.YMQI4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 20:36:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The command line for running "diff" command is built without
taking shell metacharacters into account.  A malicious dircache
entry "foo 2>bar" (yes, a filename with space) would result in
creating a file called "bar" with the error message "diff: foo:
No such file or directory" in it.

This is not just a user screwing over himself.  Such a dircache
can be created as a result of a merge with tree from others.

Here is a fix.

To be applied on top of my previous patches:

    [PATCH] Optionally tell show-diff to show only named files.
    [PATCH] show-diff -z option for machine readable output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 60 insertions(+), 4 deletions(-)

show-diff.c: cb1b7eaa9758e94a179e73a80b4b52ee7c34ca5d
--- show-diff.c
+++ show-diff.c	2005-04-16 17:25:22.000000000 -0700
@@ -4,14 +4,70 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include <ctype.h>
 
-static void show_differences(char *name,
-	void *old_contents, unsigned long long old_size)
+static char *diff_cmd = "diff -L '%s' -u -N  - '%s'";
+
+/* Help to copy the thing properly quoted for the shell safety.
+ * any single quote is replaced with '\'', and the caller is
+ * expected to enclose the result within a single quote pair.
+ *
+ * E.g.
+ *  original     sq_expand     result
+ *  name     ==> name      ==> 'name'
+ *  a b      ==> a b       ==> 'a b'
+ *  a'b      ==> a'\''b    ==> 'a'\''b'
+ *
+ * NOTE! The returned memory belongs to this function so
+ * do not free it.
+ */
+static char *sq_expand(char *src)
+{
+	static char *buf = NULL;
+	static int buf_size = -1;
+	int cnt, c;
+	char *cp;
+
+	/* count single quote characters */ 
+	for (cnt = 0, cp = src; *cp; cnt++, cp++)
+		if (*cp == '\'')
+			cnt += 3;
+
+	if (buf_size < cnt) {
+		free(buf);
+		buf_size = cnt;
+		buf = malloc(cnt);
+	}
+
+	cp = buf;
+	while ((c = *src++)) {
+		if (c != '\'')
+			*cp++ = c;
+		else {
+			cp = strcpy(cp, "'\\''");
+			cp += 4;
+		}
+	}
+	*cp = 0;
+	return buf;
+}
+
+static void show_differences(char *name, void *old_contents,
+			     unsigned long long old_size)
 {
-	static char cmd[1000];
 	FILE *f;
+	static char *cmd = NULL;
+	static int cmd_size = -1;
+
+	char *name_sq = sq_expand(name);
+	int cmd_required_length = strlen(name_sq) * 2 + strlen(diff_cmd);
 
-	snprintf(cmd, sizeof(cmd), "diff -L %s -u -N  - %s", name, name);
+	if (cmd_size < cmd_required_length) {
+		free(cmd);
+		cmd_size = cmd_required_length;
+		cmd = malloc(cmd_required_length);
+	}
+	snprintf(cmd, cmd_size, diff_cmd, name_sq, name_sq);
 	f = popen(cmd, "w");
 	if (old_size)
 		fwrite(old_contents, old_size, 1, f);

