From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] git-gc --auto: restructure the way "repack" command line is built.
Date: Mon, 17 Sep 2007 01:44:53 -0700
Message-ID: <1190018713416-git-send-email-gitster@pobox.com>
References: <11900186941912-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:45:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCES-00089U-51
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbXIQIpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756739AbXIQIpT
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:45:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756848AbXIQIpR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:45:17 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 280C01368B0;
	Mon, 17 Sep 2007 04:45:37 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <11900186941912-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58400>

We used to build the command line to run repack outside of
need_to_gc() but with the next patch we would want to tweak the
command line depending on the nature of need.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-gc.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index bf29f5e..34ce35b 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -29,8 +29,6 @@ static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
 static const char *argv_rerere[] = {"rerere", "gc", NULL};
 
-static const char *argv_repack_auto[] = {"repack", "-d", "-l", NULL};
-
 static int gc_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "gc.packrefs")) {
@@ -104,6 +102,8 @@ static int too_many_loose_objects(void)
 
 static int need_to_gc(void)
 {
+	int ac = 0;
+
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc
@@ -111,7 +111,14 @@ static int need_to_gc(void)
 	if (gc_auto_threshold <= 0)
 		return 0;
 
-	return too_many_loose_objects();
+	if (!too_many_loose_objects())
+		return 0;
+
+	argv_repack[ac++] = "repack";
+	argv_repack[ac++] = "-d";
+	argv_repack[ac++] = "-l";
+	argv_repack[ac++] = NULL;
+	return 1;
 }
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
@@ -154,8 +161,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		 * Auto-gc should be least intrusive as possible.
 		 */
 		prune = 0;
-		for (i = 0; i < ARRAY_SIZE(argv_repack_auto); i++)
-			argv_repack[i] = argv_repack_auto[i];
 		if (!need_to_gc())
 			return 0;
 	}
-- 
1.5.3.1.967.g6bb01
