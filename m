From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] git-gc --auto: move threshold check to need_to_gc() function.
Date: Mon, 17 Sep 2007 01:27:09 -0700
Message-ID: <11900176352428-git-send-email-gitster@pobox.com>
References: <1190017633436-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:43:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD8a-0006vM-UU
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbXIQJnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbXIQJnM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:43:12 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42683 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbXIQJnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:43:09 -0400
X-Greylist: delayed 4537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 05:42:51 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917082715.EIX29193.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 17 Sep 2007 04:27:15 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id pLTF1X0061gtr5g0000000; Mon, 17 Sep 2007 04:27:15 -0400
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <1190017633436-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58416>

That is where we decide if we are going to run gc
automatically.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-gc.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 093b3dd..f046a2a 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -80,6 +80,13 @@ static int need_to_gc(void)
 	int num_loose = 0;
 	int needed = 0;
 
+	/*
+	 * Setting gc.auto to 0 or negative can disable the
+	 * automatic gc
+	 */
+	if (gc_auto_threshold <= 0)
+		return 0;
+
 	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
 		warning("insanely long object directory %.*s", 50, objdir);
 		return 0;
@@ -129,8 +136,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--auto")) {
-			if (gc_auto_threshold <= 0)
-				return 0;
 			auto_gc = 1;
 			continue;
 		}
-- 
1.5.3.1.967.g6bb01
