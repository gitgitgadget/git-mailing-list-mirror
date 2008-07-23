From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 3/9] builtin-prune-packed.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:06 +0200
Message-ID: <1216849332-26813-4-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1Z-00026o-R3
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbYGWVfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbYGWVfw
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:35:52 -0400
Received: from smtp.katamail.com ([62.149.157.154]:36991 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755013AbYGWVft (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:49 -0400
Received: (qmail 11486 invoked by uid 89); 23 Jul 2008 21:35:39 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:38 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89781>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-prune-packed.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 10cb8df..5866871 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -1,12 +1,15 @@
 #include "builtin.h"
 #include "cache.h"
 #include "progress.h"
+#include "parse-options.h"
 
-static const char prune_packed_usage[] =
-"git prune-packed [-n] [-q]";
+static const char * const prune_packed_usage[] = {
+	"git prune-packed [-n] [-q]",
+	NULL
+};
 
 #define DRY_RUN 01
-#define VERBOSE 02
+#define QUIET 02
 
 static struct progress *progress;
 
@@ -43,7 +46,7 @@ void prune_packed_objects(int opts)
 	const char *dir = get_object_directory();
 	int len = strlen(dir);
 
-	if (opts == VERBOSE)
+	if (!opts)
 		progress = start_progress_delay("Removing duplicate objects",
 			256, 95, 2);
 
@@ -67,24 +70,19 @@ void prune_packed_objects(int opts)
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int i;
-	int opts = VERBOSE;
+	int opts = 0;
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	const struct option options[] = {
+		OPT_BIT('n', "dry-run", &opts, "dry run", DRY_RUN),
+		OPT_BIT('q', "quiet", &opts, "be quiet", QUIET),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, prune_packed_usage, 0);
+
+	if (argc > 0)
+		usage_with_options(prune_packed_usage, options);
 
-		if (*arg == '-') {
-			if (!strcmp(arg, "-n"))
-				opts |= DRY_RUN;
-			else if (!strcmp(arg, "-q"))
-				opts &= ~VERBOSE;
-			else
-				usage(prune_packed_usage);
-			continue;
-		}
-		/* Handle arguments here .. */
-		usage(prune_packed_usage);
-	}
 	prune_packed_objects(opts);
 	return 0;
 }
-- 
1.5.6.3
