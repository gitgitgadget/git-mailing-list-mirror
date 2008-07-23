From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 1/9] builtin-verify-tag.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:04 +0200
Message-ID: <1216849332-26813-2-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1Y-00026o-H3
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbYGWVft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbYGWVfs
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:35:48 -0400
Received: from smtp.katamail.com ([62.149.157.154]:36970 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1755770AbYGWVfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:46 -0400
Received: (qmail 11452 invoked by uid 89); 23 Jul 2008 21:35:37 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:36 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89775>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-verify-tag.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 7d837f0..590038b 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -9,10 +9,13 @@
 #include "builtin.h"
 #include "tag.h"
 #include "run-command.h"
+#include "parse-options.h"
 #include <signal.h>
 
-static const char builtin_verify_tag_usage[] =
-		"git verify-tag [-v|--verbose] <tag>...";
+static const char * const builtin_verify_tag_usage[] = {
+	"git verify-tag [-v|--verbose] <tag>...",
+	NULL
+};
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 
@@ -88,23 +91,25 @@ static int verify_tag(const char *name, int verbose)
 
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
-	int i = 1, verbose = 0, had_error = 0;
+	int verbose = 0, had_error = 0;
 
 	git_config(git_default_config, NULL);
 
+	const struct option options[] = {
+		OPT__VERBOSE(&verbose),
+		OPT_END()
+	};
+
 	if (argc == 1)
-		usage(builtin_verify_tag_usage);
+		usage_with_options(builtin_verify_tag_usage, options);
 
-	if (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose")) {
-		verbose = 1;
-		i++;
-	}
+	argc = parse_options(argc, argv, options, builtin_verify_tag_usage, 0);
 
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
-	while (i < argc)
-		if (verify_tag(argv[i++], verbose))
+	while (argc-- > 0)
+		if (verify_tag(*argv++, verbose))
 			had_error = 1;
 	return had_error;
 }
-- 
1.5.6.3
