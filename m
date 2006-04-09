From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git log [diff-tree options]...
Date: Sun, 09 Apr 2006 02:04:02 -0700
Message-ID: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 11:04:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSVqD-0004jI-P8
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 11:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWDIJEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 05:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWDIJEF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 05:04:05 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:22491 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750710AbWDIJED (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 05:04:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409090403.VPPZ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 05:04:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18543>

And this makes "git log" to take common diff-tree options, so
that it can be used as "git whatchanged".

The recent revision walker updates by Linus to make path
limiting low-latency helps this quite a bit.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

52b70d56bd23811003a72866cc23a0a44b9da1b7
diff --git a/git.c b/git.c
index fa58232..8776088 100644
--- a/git.c
+++ b/git.c
@@ -16,6 +16,8 @@ #include "common-cmds.h"
 #include "cache.h"
 #include "commit.h"
 #include "revision.h"
+#include "diff.h"
+#include "log-tree.h"
 
 #ifndef PATH_MAX
 # define PATH_MAX 4096
@@ -285,7 +287,10 @@ static int cmd_log(int argc, const char 
 	int abbrev = DEFAULT_ABBREV;
 	int abbrev_commit = 0;
 	const char *commit_prefix = "commit ";
+	struct log_tree_opt opt;
+	int do_diff = 0;
 
+	init_log_tree_opt(&opt);
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
 	while (1 < argc) {
 		const char *arg = argv[1];
@@ -310,9 +315,31 @@ static int cmd_log(int argc, const char 
 			else if (40 < abbrev)
 				abbrev = 40;
 		}
-		else
+		else {
+			int cnt = log_tree_opt_parse(&opt, argv+1, argc-1);
+			if (0 < cnt) {
+				do_diff = 1;
+				argv += cnt;
+				argc -= cnt;
+				continue;
+			}
 			die("unrecognized argument: %s", arg);
+		}
+
 		argc--; argv++;
+	}
+	if (do_diff) {
+		opt.diffopt.abbrev = abbrev;
+		opt.verbose_header = 0;
+		opt.always_show_header = 0;
+		opt.no_commit_id = 1;
+		if (opt.combine_merges)
+			opt.ignore_merges = 0;
+		if (opt.dense_combined_merges)
+			opt.diffopt.output_format = DIFF_FORMAT_PATCH;
+		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH)
+			opt.diffopt.recursive = 1;
+		diff_setup_done(&opt.diffopt);
 	}
 
 	prepare_revision_walk(&rev);
@@ -350,6 +377,9 @@ static int cmd_log(int argc, const char 
 		pretty_print_commit(commit_format, commit, ~0, buf,
 				    LOGSIZE, abbrev);
 		printf("%s\n", buf);
+
+		if (do_diff)
+			log_tree_commit(&opt, commit);
 	}
 	free(buf);
 	return 0;
-- 
1.2.6.gad0b
