From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-add -u: match the index with working tree.
Date: Fri, 20 Apr 2007 01:42:18 -0700
Message-ID: <11770585393395-git-send-email-junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 10:42:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeohG-0006Py-QF
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 10:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992621AbXDTImV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 04:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992635AbXDTImV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 04:42:21 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47264 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992621AbXDTImU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 04:42:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420084220.ZNUR1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Fri, 20 Apr 2007 04:42:20 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pLiK1W00U1kojtg0000000; Fri, 20 Apr 2007 04:42:19 -0400
X-Mailer: git-send-email 1.5.1.1.942.g0a20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45074>

This is a shorthand of what "git commit -a" does in preparation
for making a commit, which is:

    git diff-files --name-only -z | git update-index --remove -z --stdin

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-add.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 57 insertions(+), 1 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9ec2925..5e6748f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -8,10 +8,15 @@
 #include "dir.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "commit.h"
+#include "revision.h"
 
 static const char builtin_add_usage[] =
-"git-add [-n] [-v] [-f] [--interactive | -i] [--] <filepattern>...";
+"git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepattern>...";
 
+static int take_all_worktree_changes;
 static const char *excludes_file;
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
@@ -92,6 +97,44 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec)
 		prune_directory(dir, pathspec, baselen);
 }
 
+static void update_callback(struct diff_queue_struct *q,
+			    struct diff_options *opt, void *cbdata)
+{
+	int i, verbose;
+
+	verbose = *((int *)cbdata);
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		switch (p->status) {
+		default:
+			die("unexpacted diff status %c", p->status);
+		case DIFF_STATUS_UNMERGED:
+		case DIFF_STATUS_MODIFIED:
+			add_file_to_cache(path, verbose);
+			break;
+		case DIFF_STATUS_DELETED:
+			remove_file_from_cache(path);
+			if (verbose)
+				printf("remove '%s'\n", path);
+			break;
+		}
+	}
+}
+
+static void update_all(int verbose)
+{
+	struct rev_info rev;
+	init_revisions(&rev, "");
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = update_callback;
+	rev.diffopt.format_callback_data = &verbose;
+	if (read_cache() < 0)
+		die("index file corrupt");
+	run_diff_files(&rev, 0);
+}
+
 static int git_add_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "core.excludesfile")) {
@@ -156,8 +199,20 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			verbose = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-u")) {
+			take_all_worktree_changes = 1;
+			continue;
+		}
 		usage(builtin_add_usage);
 	}
+
+	if (take_all_worktree_changes) {
+		if (i < argc)
+			die("-u and explicit paths are incompatible");
+		update_all(verbose);
+		goto finish;
+	}
+
 	if (argc <= i) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
 		fprintf(stderr, "Maybe you wanted to say 'git add .'?\n");
@@ -207,6 +262,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < dir.nr; i++)
 		add_file_to_cache(dir.entries[i]->name, verbose);
 
+ finish:
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    close(newfd) || commit_locked_index(&lock_file))
-- 
1.5.1.1.942.g0a20
