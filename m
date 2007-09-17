From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] git-gc --auto: protect ourselves from accumulated cruft
Date: Mon, 17 Sep 2007 01:27:11 -0700
Message-ID: <11900176353785-git-send-email-gitster@pobox.com>
References: <1190017633436-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:43:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD8c-0006vM-1Z
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbXIQJnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbXIQJnS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:43:18 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42683 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbXIQJnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:43:16 -0400
X-Greylist: delayed 4537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 05:42:51 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917082715.YZCR3549.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 17 Sep 2007 04:27:15 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id pLTF1X00N1gtr5g0000000; Mon, 17 Sep 2007 04:27:16 -0400
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <1190017633436-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58417>

Deciding to run "repack -d -l" when there are too many
loose objects would backfire when there are too many loose
objects that are unreachable, because repacking that way would
never improve the situation.  Detect that case by checking the
number of loose objects again after automatic garbage collection
runs, and issue an warning to run "prune" manually.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-gc.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index f046a2a..bf29f5e 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -64,7 +64,7 @@ static void append_option(const char **cmd, const char *opt, int max_length)
 	cmd[i] = NULL;
 }
 
-static int need_to_gc(void)
+static int too_many_loose_objects(void)
 {
 	/*
 	 * Quickly check if a "gc" is needed, by estimating how
@@ -80,13 +80,6 @@ static int need_to_gc(void)
 	int num_loose = 0;
 	int needed = 0;
 
-	/*
-	 * Setting gc.auto to 0 or negative can disable the
-	 * automatic gc
-	 */
-	if (gc_auto_threshold <= 0)
-		return 0;
-
 	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
 		warning("insanely long object directory %.*s", 50, objdir);
 		return 0;
@@ -109,6 +102,18 @@ static int need_to_gc(void)
 	return needed;
 }
 
+static int need_to_gc(void)
+{
+	/*
+	 * Setting gc.auto to 0 or negative can disable the
+	 * automatic gc
+	 */
+	if (gc_auto_threshold <= 0)
+		return 0;
+
+	return too_many_loose_objects();
+}
+
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -170,5 +175,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (run_command_v_opt(argv_rerere, RUN_GIT_CMD))
 		return error(FAILED_RUN, argv_rerere[0]);
 
+	if (auto_gc && too_many_loose_objects())
+		warning("There are too many unreachable loose objects; "
+			"run 'git prune' to remove them.");
+
 	return 0;
 }
-- 
1.5.3.1.967.g6bb01
