From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] git-gc --auto: protect ourselves from accumulated cruft
Date: Mon, 17 Sep 2007 01:44:52 -0700
Message-ID: <11900187102681-git-send-email-gitster@pobox.com>
References: <11900186941912-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCES-00089U-Nh
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919AbXIQIpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756762AbXIQIpV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:45:21 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756909AbXIQIpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:45:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CE80F1368AF;
	Mon, 17 Sep 2007 04:45:33 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <11900186941912-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58399>

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
