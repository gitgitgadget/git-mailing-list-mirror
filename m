From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/6] show-diff.c: simplify show_diff_empty.
Date: Mon, 18 Apr 2005 13:34:42 -0700
Message-ID: <7vmzrvu8m5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:32:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcu3-0002vD-6k
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVDRUf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVDRUf1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:35:27 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:18146 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261159AbVDRUfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 16:35:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418203444.MMJC4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 16:34:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH 3/6] show-diff.c: simplify show_diff_empty.

This patch removes the custom diff generation code from the
show_diff_empty() function.  Instead, just use show_differences().

This reduces the code size; but more importantly, it is needed for
the later patch to give diff options.

To be applied on top of:

    [PATCH 1/6] show-diff.c: clean up private buffer use.
    [PATCH 2/6] show-diff.c: check unreadbale blob.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   44 ++++++++++----------------------------------
 1 files changed, 10 insertions(+), 34 deletions(-)

--- a/show-diff.c
+++ b/show-diff.c
@@ -46,19 +46,23 @@ static char *sq_expand(char *src)
 	return buf;
 }
 
-static void show_differences(char *name, void *old_contents,
+static void show_differences(char *name, char *label, void *old_contents,
 			     unsigned long long old_size)
 {
 	FILE *f;
 	char *name_sq = sq_expand(name);
-	int cmd_size = strlen(name_sq) * 2 + strlen(diff_cmd);
+	char *label_sq = (name != label) ? sq_expand(label) : name_sq;
+	int cmd_size = strlen(name_sq) + strlen(label_sq) + strlen(diff_cmd);
 	char *cmd = malloc(cmd_size);
 
-	snprintf(cmd, cmd_size, diff_cmd, name_sq, name_sq);
+	fflush(stdout);
+	snprintf(cmd, cmd_size, diff_cmd, label_sq, name_sq);
 	f = popen(cmd, "w");
 	if (old_size)
 		fwrite(old_contents, old_size, 1, f);
 	pclose(f);
+	if (label_sq != name_sq)
+		free(label_sq);
 	free(name_sq);
 	free(cmd);
 }
@@ -67,8 +71,7 @@ static void show_diff_empty(struct cache
 {
 	char *old;
 	unsigned long int size;
-	int lines=0;
-	unsigned char type[20], *p, *end;
+	unsigned char type[20];
 
 	old = read_sha1_file(ce->sha1, type, &size);
 	if (! old) {
@@ -76,33 +79,7 @@ static void show_diff_empty(struct cache
 		      sha1_to_hex(ce->sha1));
 		return;
 	}
-	if (size > 0) {
-		int startline = 1;
-		int c = 0;
-
-		printf("--- %s\n", ce->name);
-		printf("+++ /dev/null\n");
-		p = old;
-		end = old + size;
-		while (p < end)
-			if (*p++ == '\n')
-				lines ++;
-		printf("@@ -1,%d +0,0 @@\n", lines);
-		p = old;
-		while (p < end) {
-			c = *p++;
-			if (startline) {
-				putchar('-');
-				startline = 0;
-			}
-			putchar(c);
-			if (c == '\n')
-				startline = 1;
-		}
-		if (c!='\n')
-			printf("\n");
-		fflush(stdout);
-	}
+	show_differences("/dev/null", ce->name, old, size);
 }
 
 static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";
@@ -195,7 +172,6 @@ int main(int argc, char **argv)
 			printf("%s %s%c", sha1_to_hex(ce->sha1), ce->name, 0);
 			continue;
 		}
-		fflush(stdout);
 		if (silent)
 			continue;
 
@@ -204,7 +180,7 @@ int main(int argc, char **argv)
 			error("unable to read blob object for %s (%s)",
 			      ce->name, sha1_to_hex(ce->sha1));
 		else
-			show_differences(ce->name, old, size);
+			show_differences(ce->name, ce->name, old, size);
 		free(old);
 	}
 	return 0;

