From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: display first bad commit without forking a new process
Date: Thu, 28 May 2009 23:21:16 +0200
Message-ID: <20090528212117.3989.88194.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 23:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9n5p-0002xo-Qz
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbZE1VXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764322AbZE1VXg
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:23:36 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:45425 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764536AbZE1VXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 17:23:32 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 4DD23D480DE;
	Thu, 28 May 2009 23:23:27 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 5884CD480BB;
	Thu, 28 May 2009 23:23:25 +0200 (CEST)
X-git-sha1: adc73844cb81dc10b5b98c36b94f3495c9b088e8 
X-Mailer: git-mail-commits v0.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120234>

Previously "git diff-tree --pretty COMMIT" was run using
"run_command_v_opt" to display information about the first bad
commit.

The goal of this patch is to avoid a "fork" and an "exec" call
when displaying that information.

To do that, we manually setup revision information as
"git diff-tree --pretty" would do it, and then use the
"log_tree_commit" function.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

	The only change is that "struct rev_info opt" is not
	static anymore. 

diff --git a/bisect.c b/bisect.c
index c43c120..edd3cfb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -7,6 +7,7 @@
 #include "quote.h"
 #include "sha1-lookup.h"
 #include "run-command.h"
+#include "log-tree.h"
 #include "bisect.h"
 
 struct sha1_array {
@@ -27,7 +28,6 @@ struct argv_array {
 	int argv_alloc;
 };
 
-static const char *argv_diff_tree[] = {"diff-tree", "--pretty", NULL, NULL};
 static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
 static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 
@@ -816,6 +816,31 @@ static void check_good_are_ancestors_of_bad(const char *prefix)
 }
 
 /*
+ * This does "git diff-tree --pretty COMMIT" without one fork+exec.
+ */
+static void show_diff_tree(const char *prefix, struct commit *commit)
+{
+	struct rev_info opt;
+
+	/* diff-tree init */
+	init_revisions(&opt, prefix);
+	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+	opt.abbrev = 0;
+	opt.diff = 1;
+
+	/* This is what "--pretty" does */
+	opt.verbose_header = 1;
+	opt.use_terminator = 0;
+	opt.commit_format = CMIT_FMT_DEFAULT;
+
+	/* diff-tree init */
+	if (!opt.diffopt.output_format)
+		opt.diffopt.output_format = DIFF_FORMAT_RAW;
+
+	log_tree_commit(&opt, commit);
+}
+
+/*
  * We use the convention that exiting with an exit code 10 means that
  * the bisection process finished successfully.
  * In this case the calling shell script should exit 0.
@@ -860,8 +885,7 @@ int bisect_next_all(const char *prefix)
 	if (!hashcmp(bisect_rev, current_bad_sha1)) {
 		exit_if_skipped_commits(tried, current_bad_sha1);
 		printf("%s is first bad commit\n", bisect_rev_hex);
-		argv_diff_tree[2] = bisect_rev_hex;
-		run_command_v_opt(argv_diff_tree, RUN_GIT_CMD);
+		show_diff_tree(prefix, revs.commits->item);
 		/* This means the bisection process succeeded. */
 		exit(10);
 	}
-- 
1.6.3.GIT
