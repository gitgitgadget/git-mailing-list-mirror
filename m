From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Use parseopts in builtin-push
Date: Sun, 4 Nov 2007 22:35:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711042235350.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioskj-00067k-5I
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbXKEDfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 22:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbXKEDfj
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:35:39 -0500
Received: from iabervon.org ([66.92.72.58]:44087 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753338AbXKEDfj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:35:39 -0500
Received: (qmail 19844 invoked by uid 1000); 5 Nov 2007 03:35:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 03:35:37 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63479>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-push.c |   88 +++++++++++++++++++++++---------------------------------
 1 files changed, 36 insertions(+), 52 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 4b39ef3..2c56195 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -7,8 +7,12 @@
 #include "builtin.h"
 #include "remote.h"
 #include "transport.h"
+#include "parse-options.h"
 
-static const char push_usage[] = "git-push [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]";
+static const char * const push_usage[] = {
+	"git-push [--all] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	NULL,
+};
 
 static int thin, verbose;
 static const char *receivepack;
@@ -85,63 +89,43 @@ static int do_push(const char *repo, int flags)
 
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	int flags = 0;
+	int all = 0;
+	int dry_run = 0;
+	int force = 0;
+	int tags = 0;
 	const char *repo = NULL;	/* default repository */
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	struct option options[] = {
+		OPT__VERBOSE(&verbose),
+		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
+		OPT_BOOLEAN( 0 , "all", &all, "push all refs"),
+		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
+		OPT_BOOLEAN( 0 , "dry-run", &dry_run, "dry run"),
+		OPT_BOOLEAN('f', "force", &force, "force updates"),
+		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
+		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
+		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		OPT_END()
+	};
 
-		if (arg[0] != '-') {
-			repo = arg;
-			i++;
-			break;
-		}
-		if (!strcmp(arg, "-v")) {
-			verbose=1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--repo=")) {
-			repo = arg+7;
-			continue;
-		}
-		if (!strcmp(arg, "--all")) {
-			flags |= TRANSPORT_PUSH_ALL;
-			continue;
-		}
-		if (!strcmp(arg, "--dry-run")) {
-			flags |= TRANSPORT_PUSH_DRY_RUN;
-			continue;
-		}
-		if (!strcmp(arg, "--tags")) {
-			add_refspec("refs/tags/*");
-			continue;
-		}
-		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
-			flags |= TRANSPORT_PUSH_FORCE;
-			continue;
-		}
-		if (!strcmp(arg, "--thin")) {
-			thin = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-thin")) {
-			thin = 0;
-			continue;
-		}
-		if (!prefixcmp(arg, "--receive-pack=")) {
-			receivepack = arg + 15;
-			continue;
-		}
-		if (!prefixcmp(arg, "--exec=")) {
-			receivepack = arg + 7;
-			continue;
-		}
-		usage(push_usage);
+	argc = parse_options(argc, argv, options, push_usage, 0);
+
+	if (force)
+		flags |= TRANSPORT_PUSH_FORCE;
+	if (dry_run)
+		flags |= TRANSPORT_PUSH_DRY_RUN;
+	if (tags)
+		add_refspec("refs/tags/*");
+	if (all)
+		flags |= TRANSPORT_PUSH_ALL;
+
+	if (argc > 0) {
+		repo = argv[0];
+		set_refspecs(argv + 1, argc - 1);
 	}
-	set_refspecs(argv + i, argc - i);
 	if ((flags & TRANSPORT_PUSH_ALL) && refspec)
-		usage(push_usage);
+		usage_with_options(push_usage, options);
 
 	return do_push(repo, flags);
 }
-- 
1.5.3.5.1528.gb6568-dirty
