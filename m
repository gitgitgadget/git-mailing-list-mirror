From: Jeff King <peff@peff.net>
Subject: [PATCH] git-add: allow path limiting with -u
Date: Sat, 12 May 2007 02:42:00 -0400
Message-ID: <20070512064159.GA7471@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, cworth@cworth.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 08:42:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmlJH-0003LR-UC
	for gcvg-git@gmane.org; Sat, 12 May 2007 08:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbXELGmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 02:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbXELGmF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 02:42:05 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2784 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756242AbXELGmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 02:42:03 -0400
Received: (qmail 30109 invoked from network); 12 May 2007 06:42:01 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 12 May 2007 06:42:01 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 May 2007 02:42:00 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47020>

Rather than updating all working tree paths, we limit
ourselves to paths listed on the command line.

Signed-off-by: Jeff King <peff@peff.net>
---
This turned out to be quite easy to implement. Patch is slightly larger
than necessary due to removing _all_ from the variable names, but I
think that better expresses the new functionality.

I'm not sure that the documentation needs updated at all; I had just
assumed after reading it that 'git-add -u foo' would DWIM.

 builtin-add.c         |   13 ++++++-------
 t/t2200-add-update.sh |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)
 create mode 100755 t/t2200-add-update.sh

diff --git a/builtin-add.c b/builtin-add.c
index 5e6748f..1591171 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -16,7 +16,7 @@
 static const char builtin_add_usage[] =
 "git-add [-n] [-v] [-f] [--interactive | -i] [-u] [--] <filepattern>...";
 
-static int take_all_worktree_changes;
+static int take_worktree_changes;
 static const char *excludes_file;
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
@@ -122,11 +122,12 @@ static void update_callback(struct diff_queue_struct *q,
 	}
 }
 
-static void update_all(int verbose)
+static void update(int verbose, const char **files)
 {
 	struct rev_info rev;
 	init_revisions(&rev, "");
 	setup_revisions(0, NULL, &rev, NULL);
+	rev.prune_data = get_pathspec(rev.prefix, files);
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &verbose;
@@ -200,16 +201,14 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "-u")) {
-			take_all_worktree_changes = 1;
+			take_worktree_changes = 1;
 			continue;
 		}
 		usage(builtin_add_usage);
 	}
 
-	if (take_all_worktree_changes) {
-		if (i < argc)
-			die("-u and explicit paths are incompatible");
-		update_all(verbose);
+	if (take_worktree_changes) {
+		update(verbose, argv + i);
 		goto finish;
 	}
 
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
new file mode 100755
index 0000000..83005e7
--- /dev/null
+++ b/t/t2200-add-update.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='git-add -u with path limiting
+
+This test creates a working tree state with three files:
+
+  top (previously committed, modified)
+  dir/sub (previously committed, modified)
+  dir/other (untracked)
+
+and issues a git-add -u with path limiting on "dir" to add
+only the updates to dir/sub.'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+echo initial >top &&
+mkdir dir &&
+echo initial >dir/sub &&
+git-add dir/sub top &&
+git-commit -m initial &&
+echo changed >top &&
+echo changed >dir/sub &&
+echo other >dir/other
+'
+
+test_expect_success 'update' 'git-add -u dir'
+
+test_expect_success 'update touched correct path' \
+  'test "`git-diff-files --name-status dir/sub`" = ""'
+
+test_expect_success 'update did not touch other tracked files' \
+  'test "`git-diff-files --name-status top`" = "M	top"'
+
+test_expect_success 'update did not touch untracked files' \
+  'test "`git-diff-files --name-status dir/other`" = ""'
+
+test_done
-- 
1.5.2.rc3.709.g07945-dirty
