From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH 8/9] builtin-fetch-pack.c: use parse_options()
Date: Wed, 23 Jul 2008 23:42:11 +0200
Message-ID: <1216849332-26813-9-git-send-email-barra_cuda@katamail.com>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 23:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLm1d-00026o-Pt
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 23:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbYGWVgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 17:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755843AbYGWVgG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 17:36:06 -0400
Received: from smtp.katamail.com ([62.149.157.154]:37083 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754907AbYGWVf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 17:35:57 -0400
Received: (qmail 11637 invoked by uid 89); 23 Jul 2008 21:35:48 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_50,HELO_LH_LD,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO localhost.localdomain) (barra?cuda@katamail.com@80.104.56.10)
  by smtp2-pc with SMTP; 23 Jul 2008 21:35:46 -0000
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89774>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-fetch-pack.c |  144 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 90 insertions(+), 54 deletions(-)

diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 273239a..701be41 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -9,6 +9,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "run-command.h"
+#include "parse-options.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -17,8 +18,10 @@ static struct fetch_pack_args args = {
 	/* .uploadpack = */ "git-upload-pack",
 };
 
-static const char fetch_pack_usage[] =
-"git fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+static const char * const fetch_pack_usage[] = {
+	"git fetch-pack [options] [<host>:]<directory> [<refs>...]",
+	NULL
+};
 
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -667,6 +670,56 @@ static void fetch_pack_setup(void)
 	did_setup = 1;
 }
 
+static int parse_opt_keep_pack_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct fetch_pack_args *t_args = opt->value;
+	t_args->lock_pack = t_args->keep_pack;
+	t_args->keep_pack = 1;
+	return 0;
+}
+
+static int parse_opt_thin_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct fetch_pack_args *t_args = opt->value;
+	t_args->use_thin_pack = unset ? 0 : 1;
+	return 0;
+}
+
+static int parse_opt_include_tag_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct fetch_pack_args *t_args = opt->value;
+	t_args->include_tag = unset ? 0 : 1;
+	return 0;
+}
+
+static int parse_opt_no_progress_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct fetch_pack_args *t_args = opt->value;
+	t_args->no_progress = 1;
+	return 0;
+}
+
+static int parse_opt_fetch_all_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct fetch_pack_args *t_args = opt->value;
+	t_args->fetch_all = unset ? 0 : 1;
+	return 0;
+}
+
+static int parse_opt_quiet_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct fetch_pack_args *t_args = opt->value;
+	t_args->quiet = unset ? 0 : 1;
+	return 0;
+}
+
+static int parse_opt_verbose_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct fetch_pack_args *t_args = opt->value;
+	t_args->verbose = unset ? 0 : 1;
+	return 0;
+}
+
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, ret, nr_heads;
@@ -677,60 +730,43 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	nr_heads = 0;
 	heads = NULL;
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
 
-		if (*arg == '-') {
-			if (!prefixcmp(arg, "--upload-pack=")) {
-				args.uploadpack = arg + 14;
-				continue;
-			}
-			if (!prefixcmp(arg, "--exec=")) {
-				args.uploadpack = arg + 7;
-				continue;
-			}
-			if (!strcmp("--quiet", arg) || !strcmp("-q", arg)) {
-				args.quiet = 1;
-				continue;
-			}
-			if (!strcmp("--keep", arg) || !strcmp("-k", arg)) {
-				args.lock_pack = args.keep_pack;
-				args.keep_pack = 1;
-				continue;
-			}
-			if (!strcmp("--thin", arg)) {
-				args.use_thin_pack = 1;
-				continue;
-			}
-			if (!strcmp("--include-tag", arg)) {
-				args.include_tag = 1;
-				continue;
-			}
-			if (!strcmp("--all", arg)) {
-				args.fetch_all = 1;
-				continue;
-			}
-			if (!strcmp("-v", arg)) {
-				args.verbose = 1;
-				continue;
-			}
-			if (!prefixcmp(arg, "--depth=")) {
-				args.depth = strtol(arg + 8, NULL, 0);
-				continue;
-			}
-			if (!strcmp("--no-progress", arg)) {
-				args.no_progress = 1;
-				continue;
-			}
-			usage(fetch_pack_usage);
-		}
-		dest = (char *)arg;
-		heads = (char **)(argv + i + 1);
-		nr_heads = argc - i - 1;
-		break;
-	}
+	const struct option options[] = {
+		{ OPTION_CALLBACK, 0, "all", &args, NULL,
+		 "fetch all remote refs", PARSE_OPT_NOARG,
+		 parse_opt_fetch_all_cb },
+		OPT_STRING(0, "upload-pack", &args.uploadpack, "git-upload-pack",
+			   "specify path to git-upload-pack on remote"),
+		OPT_STRING(0, "exec", &args.uploadpack, "git-upload-pack",
+			   "same as --upload-pack <git-upload-pack>."),
+		{ OPTION_CALLBACK, 0, "no-progress", &args, NULL,
+		 "do not show the progress", PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+		 parse_opt_no_progress_cb },
+		{ OPTION_CALLBACK, 'q', "quiet", &args, NULL,
+		 "be quiet", PARSE_OPT_NOARG, parse_opt_quiet_cb },
+		{ OPTION_CALLBACK, 'v', "verbose", &args, NULL,
+		 "be verbose", PARSE_OPT_NOARG, parse_opt_verbose_cb },
+		OPT_INTEGER(0, "depth", &args.depth, "fetch chains not longer than <n>"),
+		{ OPTION_CALLBACK, 'k', "keep", &args, NULL,
+		 "create a single packfile of received data",
+		 PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_keep_pack_cb },
+		{ OPTION_CALLBACK, 0, "include-tag", &args, NULL,
+		 "download annotated tags too", PARSE_OPT_NOARG,
+		 parse_opt_include_tag_cb },
+		{ OPTION_CALLBACK, 0, "thin", &args, NULL,
+		 "minimize number of objects to be sent",
+		 PARSE_OPT_NOARG, parse_opt_thin_cb },
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, fetch_pack_usage, 0);
+
+	dest = (char *)argv[0];
+	heads = (char **)(argv + 1);
+	nr_heads = argc - 1;
+
 	if (!dest)
-		usage(fetch_pack_usage);
+		usage_with_options(fetch_pack_usage, options);
 
 	conn = git_connect(fd, (char *)dest, args.uploadpack,
 			   args.verbose ? CONNECT_VERBOSE : 0);
-- 
1.5.6.3
