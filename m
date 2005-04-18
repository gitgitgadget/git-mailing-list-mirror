From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/6] show-diff.c: -R option for reverse diff.
Date: Mon, 18 Apr 2005 13:36:58 -0700
Message-ID: <7vacnvu8id.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:34:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcvo-0003Bt-NI
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVDRUhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVDRUhR
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:37:17 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:64441 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261160AbVDRUhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 16:37:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418203700.KNQN15592.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 16:37:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch is optional.  It adds -R option to obtain reverse diff.

It may be useful in the merge workflow.  After the base of the working
directory is merged and commited, in the working directory:

    $ read-tree <tree-id-of-merged-tree>
    $ show-diff -R

to re-validate if upstream changes make sense, and/or revert or
conflict with local changes you have in the working files.

To be applied on top of:

    [PATCH 1/6] show-diff.c: clean up private buffer use.
    [PATCH 2/6] show-diff.c: check unreadbale blob.
    [PATCH 3/6] show-diff.c: simplify show_diff_empty.
    [PATCH 4/6] show-diff.c: adjust default format for the Linux kernel.
    [PATCH 5/6] show-diff.c: make diff options customizable.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

--- a/show-diff.c
+++ b/show-diff.c
@@ -7,6 +7,8 @@
 
 static char *diff_cmd = "diff -L 'a/%s' -L 'b/%s' ";
 static char *diff_opts = "-p -u";
+static char *diff_arg_forward  = " - '%s'";
+static char *diff_arg_reverse  = " '%s' -";
 
 static void prepare_diff_cmd(void)
 {
@@ -63,12 +65,12 @@ static char *sq_expand(char *src)
 }
 
 static void show_differences(char *name, char *label, void *old_contents,
-			     unsigned long long old_size)
+			     unsigned long long old_size, int reverse)
 {
-	static char *diff_arg = " - '%s'";
 	FILE *f;
 	char *name_sq = sq_expand(name);
 	char *label_sq = (name != label) ? sq_expand(label) : name_sq;
+	char *diff_arg = reverse ? diff_arg_reverse : diff_arg_forward;
 	int cmd_size = strlen(name_sq) + strlen(label_sq) * 2 +
 		strlen(diff_cmd) + strlen(diff_opts) + strlen(diff_arg);
 	char *cmd = malloc(cmd_size);
@@ -88,7 +90,7 @@ static void show_differences(char *name,
 	free(cmd);
 }
 
-static void show_diff_empty(struct cache_entry *ce)
+static void show_diff_empty(struct cache_entry *ce, int reverse)
 {
 	char *old;
 	unsigned long int size;
@@ -100,7 +102,7 @@ static void show_diff_empty(struct cache
 		      sha1_to_hex(ce->sha1));
 		return;
 	}
-	show_differences("/dev/null", ce->name, old, size);
+	show_differences("/dev/null", ce->name, old, size, reverse);
 }
 
 static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";
@@ -125,11 +127,14 @@ int main(int argc, char **argv)
 	int silent = 0;
 	int silent_on_nonexisting_files = 0;
 	int machine_readable = 0;
+	int reverse = 0;
 	int entries = read_cache();
 	int i;
 
 	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "-s"))
+		if  (!strcmp(argv[1], "-R"))
+			reverse = 1;
+		else if (!strcmp(argv[1], "-s"))
 			silent_on_nonexisting_files = silent = 1;
 		else if (!strcmp(argv[1], "-q"))
 			silent_on_nonexisting_files = 1;
@@ -181,7 +186,7 @@ int main(int argc, char **argv)
 			else {
 				printf("%s: %s\n", ce->name, strerror(errno));
 				if (errno == ENOENT)
-					show_diff_empty(ce);
+					show_diff_empty(ce, reverse);
 			}
 			continue;
 		}
@@ -202,7 +207,8 @@ int main(int argc, char **argv)
 			error("unable to read blob object for %s (%s)",
 			      ce->name, sha1_to_hex(ce->sha1));
 		else
-			show_differences(ce->name, ce->name, old, size);
+			show_differences(ce->name, ce->name, old, size,
+					 reverse);
 		free(old);
 	}
 	return 0;

