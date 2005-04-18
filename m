From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/6] show-diff.c: make diff options customizable.
Date: Mon, 18 Apr 2005 13:36:20 -0700
Message-ID: <7vekd7u8jf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:33:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcuv-00033N-Eo
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVDRUg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVDRUg0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:36:26 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:216 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261160AbVDRUgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 16:36:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418203619.WEQE7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 16:36:19 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch is optional.  If makes the diff output formatting
options customizable via the environment variables.  The default
is still the Linux kernel style.

To be applied on top of:

    [PATCH 1/6] show-diff.c: clean up private buffer use.
    [PATCH 2/6] show-diff.c: check unreadbale blob.
    [PATCH 3/6] show-diff.c: simplify show_diff_empty.
    [PATCH 4/6] show-diff.c: adjust default format for the Linux kernel.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

--- a/show-diff.c
+++ b/show-diff.c
@@ -5,7 +5,23 @@
  */
 #include "cache.h"
 
-static char *diff_cmd = "diff -L 'a/%s' -L 'b/%s' -p -u - '%s'";
+static char *diff_cmd = "diff -L 'a/%s' -L 'b/%s' ";
+static char *diff_opts = "-p -u";
+
+static void prepare_diff_cmd(void)
+{
+	/*
+	 * Default values above are meant to match the
+	 * Linux kernel development style.  Examples of
+	 * alternative styles you can specify via environment
+	 * variables are:
+	 *
+	 * GIT_DIFF_CMD="diff -L '%s' -L '%s'"
+	 * GIT_DIFF_OPTS="-c";
+	 */
+	diff_cmd = getenv("GIT_DIFF_CMD") ? : diff_cmd;
+	diff_opts = getenv("GIT_DIFF_OPTS") ? : diff_opts;
+}
 
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', and the caller is
@@ -49,15 +65,19 @@ static char *sq_expand(char *src)
 static void show_differences(char *name, char *label, void *old_contents,
 			     unsigned long long old_size)
 {
+	static char *diff_arg = " - '%s'";
 	FILE *f;
 	char *name_sq = sq_expand(name);
 	char *label_sq = (name != label) ? sq_expand(label) : name_sq;
-	int cmd_size = strlen(name_sq) +
-		strlen(label_sq) * 2 + strlen(diff_cmd);
+	int cmd_size = strlen(name_sq) + strlen(label_sq) * 2 +
+		strlen(diff_cmd) + strlen(diff_opts) + strlen(diff_arg);
 	char *cmd = malloc(cmd_size);
+	int next_at;
 
 	fflush(stdout);
-	snprintf(cmd, cmd_size, diff_cmd, label_sq, label_sq, name_sq);
+	next_at = snprintf(cmd, cmd_size, diff_cmd, label_sq, label_sq);
+	next_at += snprintf(cmd+next_at, cmd_size-next_at, "%s", diff_opts);
+	next_at += snprintf(cmd+next_at, cmd_size-next_at, diff_arg, name_sq);
 	f = popen(cmd, "w");
 	if (old_size)
 		fwrite(old_contents, old_size, 1, f);
@@ -127,6 +147,7 @@ int main(int argc, char **argv)
 		perror("read_cache");
 		exit(1);
 	}
+	prepare_diff_cmd();
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		struct cache_entry *ce = active_cache[i];

