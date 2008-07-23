From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 7/9] builtin-checkout-index.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:10 +0200
Message-ID: <1216849332-26813-8-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1c-00026o-Eq
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847AbYGWVgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754915AbYGWVgA
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:36:00 -0400
Received: from smtp.katamail.com ([62.149.157.154]:37061 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754883AbYGWVfz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:55 -0400
Received: (qmail 11599 invoked by uid 89); 23 Jul 2008 21:35:46 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:45 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89771>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-checkout-index.c |  146 +++++++++++++++++++++++++---------------------
 1 files changed, 79 insertions(+), 67 deletions(-)

diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index 71ebabf..429c850 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -40,6 +40,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "cache-tree.h"
+#include "parse-options.h"
 
 #define CHECKOUT_ALL 4
 static int line_termination = '\n';
@@ -153,18 +154,76 @@ static void checkout_all(const char *prefix, int prefix_length)
 		exit(128);
 }
 
-static const char checkout_cache_usage[] =
-"git checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=[123]|all] [--prefix=<string>] [--temp] [--] <file>...";
+static const char * const checkout_cache_usage[] = {
+	"git checkout-index [options] [--] <file>...",
+	NULL
+};
+
+static int parse_state_force_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct checkout *t_state = opt->value;
+	t_state->force = unset ? 0 : 1;
+	return 0;
+}
+
+static int parse_state_quiet_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct checkout *t_state = opt->value;
+	t_state->quiet = unset ? 0 : 1;
+	return 0;
+}
+
+static int parse_state_no_create_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct checkout *t_state = opt->value;
+	t_state->not_new = 1;
+	return 0;
+}
+
+static int parse_state_index_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct checkout *t_state = opt->value;
+	t_state->refresh_cache = unset ? 0 : 1;
+	return 0;
+}
 
 static struct lock_file lock_file;
 
 int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	int newfd = -1;
 	int all = 0;
 	int read_from_stdin = 0;
 	int prefix_length;
+	char *stage = NULL;
+
+	const struct option options[] = {
+		OPT_BOOLEAN('a', "all", &all,
+			    "checks out all files in the index"),
+		{ OPTION_CALLBACK, 'f', "force", &state, NULL,
+		  "force overwrite of existing files",
+		  PARSE_OPT_NOARG, parse_state_force_cb, 0 },
+		{ OPTION_CALLBACK, 'q', "quiet", &state, NULL, "be quiet",
+		  PARSE_OPT_NOARG, parse_state_quiet_cb, 0 },
+		{ OPTION_CALLBACK, 'n', "no-create", &state, NULL,
+		  "do not checkout new files, refresh existing ones",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+		  parse_state_no_create_cb, 0 },
+		{ OPTION_CALLBACK, 'u', "index", &state, NULL,
+		  "update stat information in the index",
+		  PARSE_OPT_NOARG, parse_state_index_cb, 0 },
+		OPT_SET_INT('z', NULL, &line_termination,
+			    "separate paths with NUL", 0),
+		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
+			    "read paths from stdin"),
+		OPT_BOOLEAN(0, "temp", &to_tempfile,
+			    "write content to temporary files"),
+		OPT_STRING(0, "prefix", &state.base_dir, "string",
+			   "prepend <string> when creating files"),
+		OPT_STRING(0, "stage", &stage, "1|2|3|all",
+			   "copy out files from the named stage"),
+		OPT_END()
+	};
 
 	git_config(git_default_config, NULL);
 	state.base_dir = "";
@@ -174,71 +233,24 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		die("invalid cache");
 	}
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	argc = parse_options(argc, argv, options, checkout_cache_usage, 0);
 
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
-			all = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-f") || !strcmp(arg, "--force")) {
-			state.force = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet")) {
-			state.quiet = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-n") || !strcmp(arg, "--no-create")) {
-			state.not_new = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-u") || !strcmp(arg, "--index")) {
-			state.refresh_cache = 1;
-			if (newfd < 0)
-				newfd = hold_locked_index(&lock_file, 1);
-			continue;
-		}
-		if (!strcmp(arg, "-z")) {
-			line_termination = 0;
-			continue;
-		}
-		if (!strcmp(arg, "--stdin")) {
-			if (i != argc - 1)
-				die("--stdin must be at the end");
-			read_from_stdin = 1;
-			i++; /* do not consider arg as a file name */
-			break;
-		}
-		if (!strcmp(arg, "--temp")) {
+	if ((state.refresh_cache) && (newfd < 0))
+		newfd = hold_locked_index(&lock_file, 1);
+	if (state.base_dir)
+		state.base_dir_len = strlen(state.base_dir);
+
+	if (stage) {
+		if (!strcmp(stage, "all")) {
 			to_tempfile = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--prefix=")) {
-			state.base_dir = arg+9;
-			state.base_dir_len = strlen(state.base_dir);
-			continue;
-		}
-		if (!prefixcmp(arg, "--stage=")) {
-			if (!strcmp(arg + 8, "all")) {
-				to_tempfile = 1;
-				checkout_stage = CHECKOUT_ALL;
-			} else {
-				int ch = arg[8];
-				if ('1' <= ch && ch <= '3')
-					checkout_stage = arg[8] - '0';
-				else
-					die("stage should be between 1 and 3 or all");
-			}
-			continue;
+			checkout_stage = CHECKOUT_ALL;
+		} else {
+			int ch = stage[0];
+			if ('1' <= ch && ch <= '3')
+				checkout_stage = stage[0] - '0';
+			else
+				die("stage should be between 1 and 3 or all");
 		}
-		if (arg[0] == '-')
-			usage(checkout_cache_usage);
-		break;
 	}
 
 	if (state.base_dir_len || to_tempfile) {
@@ -253,8 +265,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Check out named files first */
-	for ( ; i < argc; i++) {
-		const char *arg = argv[i];
+	while (argc-- > 0) {
+		const char *arg = *argv++;
 		const char *p;
 
 		if (all)
-- 
1.5.6.3
