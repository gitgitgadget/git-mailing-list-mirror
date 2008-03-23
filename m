From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 2/2] builtin-prune.c: fix object parsing and use parse_options()
Date: Sun, 23 Mar 2008 21:50:29 +0100
Message-ID: <200803232150.29971.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 22:24:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdXgV-0001No-AG
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 22:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbYCWVYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 17:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755326AbYCWVYO
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 17:24:14 -0400
Received: from smtp.katamail.com ([62.149.157.154]:41706 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755312AbYCWVYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 17:24:13 -0400
Received: (qmail 28868 invoked by uid 89); 23 Mar 2008 21:20:44 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host124-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.124)
  by smtp1-pc with SMTP; 23 Mar 2008 21:20:40 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77959>

git-prune used to remove loose objects whether they were specified in
the command line or not. This patch makes git-prune behave as stated
in the manpage: it does not prune any listed head nor reachable objects;
the parsing machinery now uses parse_options().

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-prune.c  |   50 ++++++++++++++++++++++++++++++--------------------
 t/t5304-prune.sh |    2 +-
 2 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index bb8ead9..7b3e15d 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -4,8 +4,12 @@
 #include "revision.h"
 #include "builtin.h"
 #include "reachable.h"
+#include "parse-options.h"
 
-static const char prune_usage[] = "git-prune [-n]";
+static const char * const prune_usage[] = {
+	"git-prune [-n] [--expire <time>] [--] [<head>...]",
+	NULL
+};
 static int show_only;
 static unsigned long expire;
 
@@ -121,32 +125,38 @@ static void remove_temporary_files(void)
 	closedir(dir);
 }
 
+static int parse_opt_expire(const struct option *opt, const char *arg,
+		int unset)
+{
+	expire = approxidate(arg);
+	return 0;
+}
+
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct rev_info revs;
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "-n")) {
-			show_only = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--expire")) {
-			if (++i < argc) {
-				expire = approxidate(argv[i]);
-				continue;
-			}
-		}
-		else if (!prefixcmp(arg, "--expire=")) {
-			expire = approxidate(arg + 9);
-			continue;
-		}
-		usage(prune_usage);
-	}
+	const struct option options[] = {
+		OPT_BOOLEAN('n', NULL, &show_only,
+				"do not remove, show only"),
+		OPT_CALLBACK(0, "expire", &expire, "time",
+				"expire objects older than <time>",
+				parse_opt_expire),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, prune_usage,
+			PARSE_OPT_STOP_AT_NON_OPTION |
+			PARSE_OPT_KEEP_DASHDASH);
 
 	save_commit_buffer = 0;
 	init_revisions(&revs, prefix);
+
+	if (argc > 1)
+		argc = setup_revisions(argc, argv, &revs, NULL);
+	if (argc > 1)
+		die ("unrecognized argument: %s", argv[1]);
+
 	mark_reachable_objects(&revs, 1);
 
 	prune_object_dir(get_object_directory());
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index d5f12f7..0638297 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -92,7 +92,7 @@ test_expect_success 'prune: prune unreachable heads' '
 
 '
 
-test_expect_failure 'prune: do not prune heads listed as an argument' '
+test_expect_success 'prune: do not prune heads listed as an argument' '
 
 	: > file2 &&
 	git add file2 &&
-- 
1.5.4.3
