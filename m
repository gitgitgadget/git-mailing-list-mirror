From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] apply.c: --exclude=fnmatch-pattern option.
Date: Fri, 22 Jul 2005 09:56:57 -0700
Message-ID: <7vll3ywzhi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 18:57:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw0pd-00063Q-OK
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 18:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVGVQ47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGVQ47
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 12:56:59 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:32682 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262116AbVGVQ47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 12:56:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722165656.TRUB1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 12:56:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds --exclude=pattern option to the "git-apply" command.  This
was useful while reimporting the BKCVS patchset dump of the
Linux kernel, starting at 2.4.0 and ending at 2.6.12-rc2 Ingo
announced some time ago to exclude BitKeeper directory.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 apply.c |   45 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 38 insertions(+), 7 deletions(-)

3206526a0af9403fc6184dc17879206b9216924f
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -13,7 +13,7 @@
  * uses the working tree as a "branch" for a 3-way merge.
  */
 #include <ctype.h>
-
+#include <fnmatch.h>
 #include "cache.h"
 
 // We default to the merge behaviour, since that's what most people would
@@ -1345,9 +1345,9 @@ static void write_out_one_result(struct 
 	create_file(patch);
 }
 
-static void write_out_results(struct patch *list)
+static void write_out_results(struct patch *list, int skipped_patch)
 {
-	if (!list)
+	if (!list && !skipped_patch)
 		die("No changes");
 
 	while (list) {
@@ -1358,12 +1358,30 @@ static void write_out_results(struct pat
 
 static struct cache_file cache_file;
 
+static struct excludes {
+	struct excludes *next;
+	const char *path;
+} *excludes;
+
+static int use_patch(struct patch *p)
+{
+	const char *pathname = p->new_name ? : p->old_name;
+	struct excludes *x = excludes;
+	while (x) {
+		if (fnmatch(x->path, pathname, 0) == 0)
+			return 0;
+		x = x->next;
+	}
+	return 1;
+}
+
 static int apply_patch(int fd)
 {
 	int newfd;
 	unsigned long offset, size;
 	char *buffer = read_patch_file(fd, &size);
 	struct patch *list = NULL, **listp = &list;
+	int skipped_patch = 0;
 
 	if (!buffer)
 		return -1;
@@ -1377,9 +1395,15 @@ static int apply_patch(int fd)
 		nr = parse_chunk(buffer + offset, size, patch);
 		if (nr < 0)
 			break;
-		patch_stats(patch);
-		*listp = patch;
-		listp = &patch->next;
+		if (use_patch(patch)) {
+			patch_stats(patch);
+			*listp = patch;
+			listp = &patch->next;
+		} else {
+			/* perhaps free it a bit better? */
+			free(patch);
+			skipped_patch++;
+		}
 		offset += nr;
 		size -= nr;
 	}
@@ -1397,7 +1421,7 @@ static int apply_patch(int fd)
 		exit(1);
 
 	if (apply)
-		write_out_results(list);
+		write_out_results(list, skipped_patch);
 
 	if (write_index) {
 		if (write_cache(newfd, active_cache, active_nr) ||
@@ -1432,6 +1456,13 @@ int main(int argc, char **argv)
 			read_stdin = 0;
 			continue;
 		}
+		if (!strncmp(arg, "--exclude=", 10)) {
+			struct excludes *x = xmalloc(sizeof(*x));
+			x->path = arg + 10;
+			x->next = excludes;
+			excludes = x;
+			continue;
+		}
 		/* NEEDSWORK: this does not do anything at this moment. */
 		if (!strcmp(arg, "--no-merge")) {
 			merge_patch = 0;
