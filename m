From: Christoph Junghans <ottxor@gentoo.org>
Subject: [PATCH] git-log: added --grep-begin .. --grep-end syntax
Date: Tue, 23 Dec 2014 20:03:16 -0700
Message-ID: <1419390196-17222-2-git-send-email-ottxor@gentoo.org>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
 <1419390196-17222-1-git-send-email-ottxor@gentoo.org>
Cc: git@vger.kernel.org, Christoph Junghans <ottxor@gentoo.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 24 04:03:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3cEw-0001R7-0P
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 04:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaLXDDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 22:03:53 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:48222 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbaLXDDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 22:03:53 -0500
Received: from dev.gentoo.org:587 (unknown [50.130.223.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ottxor)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 8F7EA3405C3;
	Wed, 24 Dec 2014 03:03:50 +0000 (UTC)
Received: by dev.gentoo.org:587 (sSMTP sendmail emulation); Tue, 23 Dec 2014 20:03:48 -0700
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1419390196-17222-1-git-send-email-ottxor@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261792>

This is useful to specify more complicated pattern as with '--grep'.

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
---
 builtin/grep.c | 73 +++++-----------------------------------------------------
 grep.c         | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 grep.h         | 10 ++++++++
 revision.c     | 56 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 67 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4063882..0127fa0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -551,67 +551,6 @@ static int context_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static int file_callback(const struct option *opt, const char *arg, int unset)
-{
-	struct grep_opt *grep_opt = opt->value;
-	int from_stdin = !strcmp(arg, "-");
-	FILE *patterns;
-	int lno = 0;
-	struct strbuf sb = STRBUF_INIT;
-
-	patterns = from_stdin ? stdin : fopen(arg, "r");
-	if (!patterns)
-		die_errno(_("cannot open '%s'"), arg);
-	while (strbuf_getline(&sb, patterns, '\n') == 0) {
-		/* ignore empty line like grep does */
-		if (sb.len == 0)
-			continue;
-
-		append_grep_pat(grep_opt, sb.buf, sb.len, arg, ++lno,
-				GREP_PATTERN);
-	}
-	if (!from_stdin)
-		fclose(patterns);
-	strbuf_release(&sb);
-	return 0;
-}
-
-static int not_callback(const struct option *opt, const char *arg, int unset)
-{
-	struct grep_opt *grep_opt = opt->value;
-	append_grep_pattern(grep_opt, "--not", "command line", 0, GREP_NOT);
-	return 0;
-}
-
-static int and_callback(const struct option *opt, const char *arg, int unset)
-{
-	struct grep_opt *grep_opt = opt->value;
-	append_grep_pattern(grep_opt, "--and", "command line", 0, GREP_AND);
-	return 0;
-}
-
-static int open_callback(const struct option *opt, const char *arg, int unset)
-{
-	struct grep_opt *grep_opt = opt->value;
-	append_grep_pattern(grep_opt, "(", "command line", 0, GREP_OPEN_PAREN);
-	return 0;
-}
-
-static int close_callback(const struct option *opt, const char *arg, int unset)
-{
-	struct grep_opt *grep_opt = opt->value;
-	append_grep_pattern(grep_opt, ")", "command line", 0, GREP_CLOSE_PAREN);
-	return 0;
-}
-
-static int pattern_callback(const struct option *opt, const char *arg,
-			    int unset)
-{
-	struct grep_opt *grep_opt = opt->value;
-	append_grep_pattern(grep_opt, arg, "-e option", 0, GREP_PATTERN);
-	return 0;
-}
-
 static int help_callback(const struct option *opt, const char *arg, int unset)
 {
 	return -1;
@@ -710,21 +649,21 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show the surrounding function")),
 		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, N_("file"),
-			N_("read patterns from file"), file_callback),
+			N_("read patterns from file"), grep_file_callback),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, N_("pattern"),
-			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback },
+			N_("match <pattern>"), PARSE_OPT_NONEG, grep_pattern_callback },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
 		  N_("combine patterns specified with -e"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, grep_and_callback },
 		OPT_BOOL(0, "or", &dummy, ""),
 		{ OPTION_CALLBACK, 0, "not", &opt, NULL, "",
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, not_callback },
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, grep_not_callback },
 		{ OPTION_CALLBACK, '(', NULL, &opt, NULL, "",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
-		  open_callback },
+		  grep_open_callback },
 		{ OPTION_CALLBACK, ')', NULL, &opt, NULL, "",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
-		  close_callback },
+		  grep_close_callback },
 		OPT__QUIET(&opt.status_only,
 			   N_("indicate hit with exit status without output")),
 		OPT_BOOL(0, "all-match", &opt.all_match,
diff --git a/grep.c b/grep.c
index 6e085f8..0c9a977 100644
--- a/grep.c
+++ b/grep.c
@@ -1796,3 +1796,65 @@ static int grep_source_is_binary(struct grep_source *gs)
 
 	return 0;
 }
+
+int grep_file_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	int from_stdin = !strcmp(arg, "-");
+	FILE *patterns;
+	int lno = 0;
+	struct strbuf sb = STRBUF_INIT;
+
+	patterns = from_stdin ? stdin : fopen(arg, "r");
+	if (!patterns)
+		die_errno(_("cannot open '%s'"), arg);
+	while (strbuf_getline(&sb, patterns, '\n') == 0) {
+		/* ignore empty line like grep does */
+		if (sb.len == 0)
+			continue;
+
+		append_grep_pat(grep_opt, sb.buf, sb.len, arg, ++lno,
+				GREP_PATTERN);
+	}
+	if (!from_stdin)
+		fclose(patterns);
+	strbuf_release(&sb);
+	return 0;
+}
+
+int grep_not_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, "--not", "command line", 0, GREP_NOT);
+	return 0;
+}
+
+int grep_and_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, "--and", "command line", 0, GREP_AND);
+	return 0;
+}
+
+int grep_open_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, "(", "command line", 0, GREP_OPEN_PAREN);
+	return 0;
+}
+
+int grep_close_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, ")", "command line", 0, GREP_CLOSE_PAREN);
+	return 0;
+}
+
+int grep_pattern_callback(const struct option *opt, const char *arg,
+			    int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, arg, "-e option", 0, GREP_PATTERN);
+	return 0;
+}
+
diff --git a/grep.h b/grep.h
index 95f197a..d85fdb4 100644
--- a/grep.h
+++ b/grep.h
@@ -10,6 +10,7 @@ typedef int pcre_extra;
 #include "kwset.h"
 #include "thread-utils.h"
 #include "userdiff.h"
+#include "parse-options.h"
 
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -181,6 +182,15 @@ void grep_source_load_driver(struct grep_source *gs);
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
 
+
+int grep_file_callback(const struct option *opt, const char *arg, int unset);
+int grep_not_callback(const struct option *opt, const char *arg, int unset);
+int grep_and_callback(const struct option *opt, const char *arg, int unset);
+int grep_open_callback(const struct option *opt, const char *arg, int unset);
+int grep_close_callback(const struct option *opt, const char *arg, int unset);
+int grep_pattern_callback(const struct option *opt, const char *arg, int unset);
+
+
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
 
diff --git a/revision.c b/revision.c
index 75dda92..4fe9085 100644
--- a/revision.c
+++ b/revision.c
@@ -1998,6 +1998,62 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return argcount;
 	} else if (!strcmp(arg, "--grep-debug")) {
 		revs->grep_filter.debug = 1;
+	} else if (!strcmp(arg, "--grep-begin")) {
+		if (argc <= 1)
+			return error("--grep-begin requires an argument");
+		int dummy;
+		struct option options[] = {
+			OPT_CALLBACK('f', NULL, &revs->grep_filter, N_("file"),
+				N_("read patterns from file"), grep_file_callback),
+			{ OPTION_CALLBACK, 'e', NULL, &revs->grep_filter, N_("pattern"),
+				N_("match <pattern>"), PARSE_OPT_NONEG, grep_pattern_callback },
+			{ OPTION_CALLBACK, 0, "and", &revs->grep_filter, NULL,
+			  N_("combine patterns specified with -e"),
+			  PARSE_OPT_NOARG | PARSE_OPT_NONEG, grep_and_callback },
+			OPT_BOOL(0, "or", &dummy, ""),
+			{ OPTION_CALLBACK, 0, "not", &revs->grep_filter, NULL, "",
+			  PARSE_OPT_NOARG | PARSE_OPT_NONEG, grep_not_callback },
+			{ OPTION_CALLBACK, '(', NULL, &revs->grep_filter, NULL, "",
+			  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
+			  grep_open_callback },
+			{ OPTION_CALLBACK, ')', NULL, &revs->grep_filter, NULL, "",
+			  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
+			  grep_close_callback },
+			OPT_END()
+		};
+		char const * const grep_usage[] = {
+			N_("git log [log-options] --begin-grep [grep-options] --end-grep ..."), 
+			NULL 
+		};
+		struct parse_opt_ctx_t ctx;
+
+		parse_options_start(&ctx, argc, argv, revs->prefix, options,
+				PARSE_OPT_STOP_AT_NON_OPTION | PARSE_OPT_NO_INTERNAL_HELP);
+		if (parse_options_step(&ctx, options, grep_usage) != PARSE_OPT_UNKNOWN) {
+			error("--grep-end expected");
+			usage_with_options(grep_usage, options);
+		}
+		if(strcmp(ctx.argv[0], "--grep-end")) {
+			if (ctx.argv[0][1] == '-') {
+			error("unknown option `%s'", ctx.argv[0] + 2);
+			} else if (isascii(*ctx.opt)) {
+				error("unknown switch `%c'", *ctx.opt);
+			} else {
+			error("unknown non-ascii option in string: `%s'",
+			      ctx.argv[0]);
+			}	
+			usage_with_options(grep_usage, options);
+		}
+
+		precompose_argv(argc, argv);
+		argcount = argc + 1 - parse_options_end(&ctx);
+		if (argcount == 2 ) {
+			return error("There should be options between --grep-begin and --grep-end ;-)");
+		}
+
+		grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED, &revs->grep_filter);
+
+		return argcount;
 	} else if (!strcmp(arg, "--basic-regexp")) {
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_BRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
-- 
2.0.5
