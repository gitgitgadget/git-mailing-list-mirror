From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-shortlog: migrate to parse-options partially.
Date: Wed,  9 Jul 2008 23:38:33 +0200
Message-ID: <1215639514-1612-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:39:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGhNw-0006ES-J4
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbYGIVil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbYGIVil
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:38:41 -0400
Received: from pan.madism.org ([88.191.52.104]:57146 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915AbYGIVik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:38:40 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D33183A46F;
	Wed,  9 Jul 2008 23:38:38 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E810A85E5; Wed,  9 Jul 2008 23:38:34 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.428.gdce6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87921>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-shortlog.c |  135 +++++++++++++++++++++++++++++----------------------
 1 files changed, 77 insertions(+), 58 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index e6a2865..9107bff 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -7,9 +7,14 @@
 #include "utf8.h"
 #include "mailmap.h"
 #include "shortlog.h"
+#include "parse-options.h"
 
-static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [-e] [-w] [<commit-id>... ]";
+static char const * const shortlog_usage[] = {
+	"git-shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>... ]",
+	"",
+	"[rev-opts] are documented in git-rev-list(1)",
+	NULL
+};
 
 static int compare_by_number(const void *a1, const void *a2)
 {
@@ -164,21 +169,19 @@ static void get_from_rev(struct rev_info *rev, struct shortlog *log)
 		shortlog_add_commit(log, commit);
 }
 
-static int parse_uint(char const **arg, int comma)
+static int parse_uint(char const **arg, int comma, int defval)
 {
 	unsigned long ul;
 	int ret;
 	char *endp;
 
 	ul = strtoul(*arg, &endp, 10);
-	if (endp != *arg && *endp && *endp != comma)
+	if (*endp && *endp != comma)
 		return -1;
-	ret = (int) ul;
-	if (ret != ul)
+	if (ul > INT_MAX)
 		return -1;
-	*arg = endp;
-	if (**arg)
-		(*arg)++;
+	ret = *arg == endp ? defval : (int)ul;
+	*arg = *endp ? endp + 1 : endp;
 	return ret;
 }
 
@@ -187,30 +190,30 @@ static const char wrap_arg_usage[] = "-w[<width>[,<indent1>[,<indent2>]]]";
 #define DEFAULT_INDENT1 6
 #define DEFAULT_INDENT2 9
 
-static void parse_wrap_args(const char *arg, int *in1, int *in2, int *wrap)
+static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 {
-	arg += 2; /* skip -w */
-
-	*wrap = parse_uint(&arg, ',');
-	if (*wrap < 0)
-		die(wrap_arg_usage);
-	*in1 = parse_uint(&arg, ',');
-	if (*in1 < 0)
-		die(wrap_arg_usage);
-	*in2 = parse_uint(&arg, '\0');
-	if (*in2 < 0)
-		die(wrap_arg_usage);
-
-	if (!*wrap)
-		*wrap = DEFAULT_WRAPLEN;
-	if (!*in1)
-		*in1 = DEFAULT_INDENT1;
-	if (!*in2)
-		*in2 = DEFAULT_INDENT2;
-	if (*wrap &&
-	    ((*in1 && *wrap <= *in1) ||
-	     (*in2 && *wrap <= *in2)))
-		die(wrap_arg_usage);
+	struct shortlog *log = opt->value;
+
+	log->wrap_lines = !unset;
+	if (unset)
+		return 0;
+	if (!arg) {
+		log->wrap = DEFAULT_WRAPLEN;
+		log->in1 = DEFAULT_INDENT1;
+		log->in2 = DEFAULT_INDENT2;
+		return 0;
+	}
+
+	log->wrap = parse_uint(&arg, ',', DEFAULT_WRAPLEN);
+	log->in1 = parse_uint(&arg, ',', DEFAULT_INDENT1);
+	log->in2 = parse_uint(&arg, '\0', DEFAULT_INDENT2);
+	if (log->wrap < 0 || log->in1 < 0 || log->in2 < 0)
+		return error(wrap_arg_usage);
+	if (log->wrap &&
+	    ((log->in1 && log->wrap <= log->in1) ||
+	     (log->in2 && log->wrap <= log->in2)))
+		return error(wrap_arg_usage);
+	return 0;
 }
 
 void shortlog_init(struct shortlog *log)
@@ -227,38 +230,54 @@ void shortlog_init(struct shortlog *log)
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
-	struct shortlog log;
-	struct rev_info rev;
+	static struct shortlog log;
+	static struct rev_info rev;
 	int nongit;
 
+	static const struct option options[] = {
+		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
+			    "sort output according to the number of commits per author"),
+		OPT_BOOLEAN('s', "summary", &log.summary,
+			    "Suppress commit descriptions, only provides commit count"),
+		OPT_BOOLEAN('e', "email", &log.email,
+			    "Show the email address of each author"),
+		{ OPTION_CALLBACK, 'w', NULL, &log, "w[,i1[,i2]]",
+			"Linewrap output", PARSE_OPT_OPTARG, &parse_wrap_args },
+		OPT_END(),
+	};
+
+	struct parse_opt_ctx_t ctx;
+
 	prefix = setup_git_directory_gently(&nongit);
 	shortlog_init(&log);
-
-	/* since -n is a shadowed rev argument, parse our args first */
-	while (argc > 1) {
-		if (!strcmp(argv[1], "-n") || !strcmp(argv[1], "--numbered"))
-			log.sort_by_number = 1;
-		else if (!strcmp(argv[1], "-s") ||
-				!strcmp(argv[1], "--summary"))
-			log.summary = 1;
-		else if (!strcmp(argv[1], "-e") ||
-			 !strcmp(argv[1], "--email"))
-			log.email = 1;
-		else if (!prefixcmp(argv[1], "-w")) {
-			log.wrap_lines = 1;
-			parse_wrap_args(argv[1], &log.in1, &log.in2, &log.wrap);
+	init_revisions(&rev, prefix);
+	parse_options_start(&ctx, argc, argv, PARSE_OPT_KEEP_DASHDASH |
+			    PARSE_OPT_KEEP_ARGV0);
+
+	for (;;) {
+		int n;
+		switch (parse_options_step(&ctx, options, shortlog_usage)) {
+		case PARSE_OPT_HELP:
+			exit(129);
+		case PARSE_OPT_DONE:
+			goto parse_done;
 		}
-		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
-			usage(shortlog_usage);
-		else
-			break;
-		argv++;
-		argc--;
+		n = handle_revision_opt(&rev, ctx.argc, ctx.argv,
+					&ctx.cpidx, ctx.out);
+		if (n <= 0) {
+			error("unknown option `%s'", ctx.argv[0]);
+			usage_with_options(shortlog_usage, options);
+		}
+		ctx.argv += n;
+		ctx.argc -= n;
+	}
+parse_done:
+	argc = parse_options_end(&ctx);
+
+	if (setup_revisions(argc, argv, &rev, NULL) != 1) {
+		error("unrecognized argument: %s", argv[1]);
+		usage_with_options(shortlog_usage, options);
 	}
-	init_revisions(&rev, prefix);
-	argc = setup_revisions(argc, argv, &rev, NULL);
-	if (argc > 1)
-		die ("unrecognized argument: %s", argv[1]);
 
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
-- 
1.5.6.2.428.gdce6.dirty
