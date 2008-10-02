From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: migrate git-merge-base.
Date: Thu,  2 Oct 2008 14:59:19 +0200
Message-ID: <1222952360-9262-2-git-send-email-madcoder@debian.org>
References: <20080930224623.GQ21310@spearce.org>
 <1222952360-9262-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Oct 02 15:00:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlNnJ-0002AS-T5
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYJBM7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 08:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbYJBM7Y
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 08:59:24 -0400
Received: from pan.madism.org ([88.191.52.104]:35580 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409AbYJBM7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 08:59:23 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5BE5D3BFD9;
	Thu,  2 Oct 2008 14:59:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id AE28494CA14; Thu,  2 Oct 2008 14:59:20 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.431.gb53ee
In-Reply-To: <1222952360-9262-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97321>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-merge-base.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index b08da51..03fc1c2 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "cache.h"
 #include "commit.h"
+#include "parse-options.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 {
@@ -21,8 +22,10 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 	return 0;
 }
 
-static const char merge_base_usage[] =
-"git merge-base [--all] <commit-id> <commit-id>...";
+static const char * const merge_base_usage[] = {
+	"git merge-base [--all] <commit-id> <commit-id>...",
+	NULL
+};
 
 static struct commit *get_commit_reference(const char *arg)
 {
@@ -44,25 +47,17 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int rev_nr = 0;
 	int show_all = 0;
 
-	git_config(git_default_config, NULL);
-
-	while (1 < argc && argv[1][0] == '-') {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "-a") || !strcmp(arg, "--all"))
-			show_all = 1;
-		else
-			usage(merge_base_usage);
-		argc--; argv++;
-	}
-	if (argc < 3)
-		usage(merge_base_usage);
-
-	rev = xmalloc((argc - 1) * sizeof(*rev));
-
-	do {
-		rev[rev_nr++] = get_commit_reference(argv[1]);
-		argc--; argv++;
-	} while (argc > 1);
+	struct option options[] = {
+		OPT_BOOLEAN('a', "all", &show_all, "outputs all common ancestors"),
+		OPT_END()
+	};
 
+	git_config(git_default_config, NULL);
+	argc = parse_options(argc, argv, options, merge_base_usage, 0);
+	if (argc < 2)
+		usage_with_options(merge_base_usage, options);
+	rev = xmalloc(argc * sizeof(*rev));
+	while (argc-- > 0)
+		rev[rev_nr++] = get_commit_reference(*argv++);
 	return show_merge_base(rev, rev_nr, show_all);
 }
-- 
1.6.0.2.431.gb53ee
