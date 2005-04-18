From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/6] show-diff.c: clean up private buffer use.
Date: Mon, 18 Apr 2005 13:33:15 -0700
Message-ID: <7vvf6ju8ok.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:30:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcs8-0002gH-Tw
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVDRUda (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVDRUda
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:33:30 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31662 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261153AbVDRUdX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 16:33:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418203317.BECK9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 16:33:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH 1/6] show-diff.c: clean up private buffer use.

This patch fixes sq_expand() and show_differences() not to use and
hold onto its privately allocated buffer, which was a misguided
attempt to reduce calls to malloc but made later changes harder.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

show-diff.c: 1342b3c9848a7675665594a6bc19d95e3b7ff358
--- a/show-diff.c
+++ b/show-diff.c
@@ -23,7 +23,6 @@ static char *diff_cmd = "diff -L '%s' -u
 static char *sq_expand(char *src)
 {
 	static char *buf = NULL;
-	static int buf_size = -1;
 	int cnt, c;
 	char *cp;
 
@@ -32,12 +31,8 @@ static char *sq_expand(char *src)
 		if (*cp == '\'')
 			cnt += 3;
 
-	if (buf_size < cnt) {
-		free(buf);
-		buf_size = cnt;
-		buf = malloc(cnt);
-	}
-
+	if (! (buf = malloc(cnt)))
+	    return buf;
 	cp = buf;
 	while ((c = *src++)) {
 		if (c != '\'')
@@ -55,22 +50,17 @@ static void show_differences(char *name,
 			     unsigned long long old_size)
 {
 	FILE *f;
-	static char *cmd = NULL;
-	static int cmd_size = -1;
-
 	char *name_sq = sq_expand(name);
-	int cmd_required_length = strlen(name_sq) * 2 + strlen(diff_cmd);
+	int cmd_size = strlen(name_sq) * 2 + strlen(diff_cmd);
+	char *cmd = malloc(cmd_size);
 
-	if (cmd_size < cmd_required_length) {
-		free(cmd);
-		cmd_size = cmd_required_length;
-		cmd = malloc(cmd_required_length);
-	}
 	snprintf(cmd, cmd_size, diff_cmd, name_sq, name_sq);
 	f = popen(cmd, "w");
 	if (old_size)
 		fwrite(old_contents, old_size, 1, f);
 	pclose(f);
+	free(name_sq);
+	free(cmd);
 }
 
 static void show_diff_empty(struct cache_entry *ce)

