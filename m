From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] gc: use parse_options
Date: Thu, 1 Nov 2007 21:02:27 -0400
Message-ID: <20071102010226.GC3282@crux.yyz.redhat.com>
References: <7vhck579pm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 02:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inkwe-0007xs-1G
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 02:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760204AbXKBBDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 21:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760151AbXKBBDL
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 21:03:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759595AbXKBBDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 21:03:09 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lA212WYv017063;
	Thu, 1 Nov 2007 21:02:32 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA212TYt001641;
	Thu, 1 Nov 2007 21:02:29 -0400
Received: from crux (crux.yyz.redhat.com [10.15.16.85])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lA212S2l027524;
	Thu, 1 Nov 2007 21:02:29 -0400
Content-Disposition: inline
In-Reply-To: <7vhck579pm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63047>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

Junio C Hamano <gitster@pobox.com> writes:
> Now, what makes the command report error when the user says:
>
>	$ git gc unwanted parameter

Ah yes. I forgot about that :)

This version of the patch errors out with extra args, and calls them
'unreferenced loose objects' rather than unused.

-James

 builtin-gc.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 3a2ca4f..c5bce89 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -12,11 +12,15 @@
 
 #include "builtin.h"
 #include "cache.h"
+#include "parse-options.h"
 #include "run-command.h"
 
 #define FAILED_RUN "failed to run %s"
 
-static const char builtin_gc_usage[] = "git-gc [--prune] [--aggressive]";
+static const char * const builtin_gc_usage[] = {
+	"git-gc [options]",
+	NULL
+};
 
 static int pack_refs = 1;
 static int aggressive_window = -1;
@@ -165,38 +169,34 @@ static int need_to_gc(void)
 
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	int prune = 0;
+	int aggressive = 0;
 	int auto_gc = 0;
 	char buf[80];
 
+	struct option builtin_gc_options[] = {
+		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced loose objects"),
+		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
+		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
+		OPT_END()
+	};
+
 	git_config(gc_config);
 
 	if (pack_refs < 0)
 		pack_refs = !is_bare_repository();
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "--prune")) {
-			prune = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--aggressive")) {
-			append_option(argv_repack, "-f", MAX_ADD);
-			if (aggressive_window > 0) {
-				sprintf(buf, "--window=%d", aggressive_window);
-				append_option(argv_repack, buf, MAX_ADD);
-			}
-			continue;
-		}
-		if (!strcmp(arg, "--auto")) {
-			auto_gc = 1;
-			continue;
+	argc = parse_options(argc, argv, builtin_gc_options, builtin_gc_usage, 0);
+	if (argc > 0)
+		usage_with_options(builtin_gc_usage, builtin_gc_options);
+
+	if (aggressive) {
+		append_option(argv_repack, "-f", MAX_ADD);
+		if (aggressive_window > 0) {
+			sprintf(buf, "--window=%d", aggressive_window);
+			append_option(argv_repack, buf, MAX_ADD);
 		}
-		break;
 	}
-	if (i != argc)
-		usage(builtin_gc_usage);
 
 	if (auto_gc) {
 		/*
-- 
1.5.3.4.1481.g854da
