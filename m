From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/5] grep: use parseopt
Date: Thu, 07 May 2009 21:46:48 +0200
Message-ID: <1241725608.4772.11.camel@ubuntu.ubuntu-domain>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:47:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29Yr-0003a2-On
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbZEGTqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbZEGTqv
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:46:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:37380 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbZEGTqu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:46:50 -0400
Received: from [10.0.1.101] (p57B7C554.dip.t-dialin.net [87.183.197.84])
	by india601.server4you.de (Postfix) with ESMTPSA id 930C72F8003;
	Thu,  7 May 2009 21:46:49 +0200 (CEST)
In-Reply-To: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118516>

Convert git-grep to parseopt.

The bitfields in struct grep_opt are converted to full ints,
increasing its size.  This shouldn't be a problem as there is only a
single instance in memory.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-grep.c |  406 +++++++++++++++++++++++++-------------------------------
 grep.h         |   28 ++--
 2 files changed, 194 insertions(+), 240 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 620399f..169a91c 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -10,6 +10,7 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "builtin.h"
+#include "parse-options.h"
 #include "grep.h"
 
 #ifndef NO_EXTERNAL_GREP
@@ -20,6 +21,11 @@
 #endif
 #endif
 
+static char const * const grep_usage[] = {
+	"git grep [options] [-e] <pattern> [<rev>...] [[--] path...]",
+	NULL
+};
+
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
@@ -559,15 +565,86 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 	die("unable to grep from object of type %s", typename(obj->type));
 }
 
-static const char builtin_grep_usage[] =
-"git grep <option>* [-e] <pattern> <rev>* [[--] <path>...]";
+int context_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	int value;
+	const char *endp;
+
+	if (unset) {
+		grep_opt->pre_context = grep_opt->post_context = 0;
+		return 0;
+	}
+	value = strtol(arg, (char **)&endp, 10);
+	if (*endp) {
+		return error("switch `%c' expects a numerical value",
+			     opt->short_name);
+	}
+	grep_opt->pre_context = grep_opt->post_context = value;
+	return 0;
+}
+
+int file_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	FILE *patterns;
+	int lno = 0;
+	struct strbuf sb;
+
+	patterns = fopen(arg, "r");
+	if (!patterns)
+		die("'%s': %s", arg, strerror(errno));
+	while (strbuf_getline(&sb, patterns, '\n') == 0) {
+		/* ignore empty line like grep does */
+		if (sb.len == 0)
+			continue;
+		append_grep_pattern(grep_opt, strbuf_detach(&sb, NULL), arg,
+				    ++lno, GREP_PATTERN);
+	}
+	fclose(patterns);
+	strbuf_release(&sb);
+	return 0;
+}
+
+int not_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, "--not", "command line", 0, GREP_NOT);
+	return 0;
+}
+
+int and_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, "--and", "command line", 0, GREP_AND);
+	return 0;
+}
+
+int open_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, "(", "command line", 0, GREP_OPEN_PAREN);
+	return 0;
+}
+
+int close_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, ")", "command line", 0, GREP_CLOSE_PAREN);
+	return 0;
+}
+
+int pattern_callback(const struct option *opt, const char *arg, int unset)
+{
+	struct grep_opt *grep_opt = opt->value;
+	append_grep_pattern(grep_opt, arg, "-e option", 0, GREP_PATTERN);
+	return 0;
+}
 
-static const char emsg_invalid_context_len[] =
-"%s: invalid context length argument";
-static const char emsg_missing_context_len[] =
-"missing context length argument";
-static const char emsg_missing_argument[] =
-"option requires an argument -%s";
+int help_callback(const struct option *opt, const char *arg, int unset)
+{
+	return -1;
+}
 
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
@@ -579,6 +656,89 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct object_array list = { 0, 0, NULL };
 	const char **paths = NULL;
 	int i;
+	int dummy;
+	struct option options[] = {
+		OPT_BOOLEAN(0, "cached", &cached,
+			"search in index instead of in the work tree"),
+		OPT_GROUP(""),
+		OPT_BOOLEAN('v', "invert-match", &opt.invert,
+			"show non-matching lines"),
+		OPT_BIT('i', "ignore-case", &opt.regflags,
+			"case insensitive matching", REG_ICASE),
+		OPT_BOOLEAN('w', "word-regexp", &opt.word_regexp,
+			"match patterns only at word boundaries"),
+		OPT_SET_INT('a', "text", &opt.binary,
+			"process binary files as text", GREP_BINARY_TEXT),
+		OPT_SET_INT('I', NULL, &opt.binary,
+			"don't match patterns in binary files",
+			GREP_BINARY_NOMATCH),
+		OPT_GROUP(""),
+		OPT_BIT('E', "extended-regexp", &opt.regflags,
+			"use extended POSIX regular expressions", REG_EXTENDED),
+		OPT_NEGBIT('G', "basic-regexp", &opt.regflags,
+			"use basic POSIX regular expressions (default)",
+			REG_EXTENDED),
+		OPT_BOOLEAN('F', "fixed-strings", &opt.fixed,
+			"interpret patterns as fixed strings"),
+		OPT_GROUP(""),
+		OPT_BOOLEAN('n', NULL, &opt.linenum, "show line numbers"),
+		OPT_NEGBIT('h', NULL, &opt.pathname, "don't show filenames", 1),
+		OPT_BIT('H', NULL, &opt.pathname, "show filenames", 1),
+		OPT_NEGBIT(0, "full-name", &opt.relative,
+			"show filenames relative to top directory", 1),
+		OPT_BOOLEAN('l', "files-with-matches", &opt.name_only,
+			"show only filenames instead of matching lines"),
+		OPT_BOOLEAN(0, "name-only", &opt.name_only,
+			"synonym for --files-with-matches"),
+		OPT_BOOLEAN('L', "files-without-match",
+			&opt.unmatch_name_only,
+			"show only the names of files without match"),
+		OPT_BOOLEAN('z', "null", &opt.null_following_name,
+			"print NUL after filenames"),
+		OPT_BOOLEAN('c', "count", &opt.count,
+			"show the number of matches instead of matching lines"),
+		OPT_SET_INT(0, "color", &opt.color, "highlight matches", 1),
+		OPT_GROUP(""),
+		OPT_CALLBACK('C', NULL, &opt, "n",
+			"show <n> context lines before and after matches",
+			context_callback),
+		OPT_INTEGER('B', NULL, &opt.pre_context,
+			"show <n> context lines before matches"),
+		OPT_INTEGER('A', NULL, &opt.post_context,
+			"show <n> context lines after matches"),
+		OPT_NUMBER_CALLBACK(&opt, "shortcut for -C NUM",
+			context_callback),
+		OPT_GROUP(""),
+		OPT_CALLBACK('f', NULL, &opt, "file",
+			"read patterns from file", file_callback),
+		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
+			"match <pattern>", PARSE_OPT_NONEG, pattern_callback },
+		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
+		  "combine patterns specified with -e",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
+		OPT_BOOLEAN(0, "or", &dummy, ""),
+		{ OPTION_CALLBACK, 0, "not", &opt, NULL, "",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, not_callback },
+		{ OPTION_CALLBACK, '(', NULL, &opt, NULL, "",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
+		  open_callback },
+		{ OPTION_CALLBACK, ')', NULL, &opt, NULL, "",
+		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
+		  close_callback },
+		OPT_BOOLEAN(0, "all-match", &opt.all_match,
+			"show only matches from files that match all patterns"),
+		OPT_GROUP(""),
+#if NO_EXTERNAL_GREP
+		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed,
+			"allow calling of grep(1) (ignored by this build)"),
+#else
+		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed,
+			"allow calling of grep(1) (default)"),
+#endif
+		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
+		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
+		OPT_END()
+	};
 
 	memset(&opt, 0, sizeof(opt));
 	opt.prefix_length = (prefix && *prefix) ? strlen(prefix) : 0;
@@ -603,223 +763,17 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	 * unrecognized non option is the beginning of the refs list
 	 * that continues up to the -- (if exists), and then paths.
 	 */
-
-	while (1 < argc) {
-		const char *arg = argv[1];
-		argc--; argv++;
-		if (!strcmp("--cached", arg)) {
-			cached = 1;
-			continue;
-		}
-		if (!strcmp("--no-ext-grep", arg)) {
-			external_grep_allowed = 0;
-			continue;
-		}
-		if (!strcmp("-a", arg) ||
-		    !strcmp("--text", arg)) {
-			opt.binary = GREP_BINARY_TEXT;
-			continue;
-		}
-		if (!strcmp("-i", arg) ||
-		    !strcmp("--ignore-case", arg)) {
-			opt.regflags |= REG_ICASE;
-			continue;
-		}
-		if (!strcmp("-I", arg)) {
-			opt.binary = GREP_BINARY_NOMATCH;
-			continue;
-		}
-		if (!strcmp("-v", arg) ||
-		    !strcmp("--invert-match", arg)) {
-			opt.invert = 1;
-			continue;
-		}
-		if (!strcmp("-E", arg) ||
-		    !strcmp("--extended-regexp", arg)) {
-			opt.regflags |= REG_EXTENDED;
-			continue;
-		}
-		if (!strcmp("-F", arg) ||
-		    !strcmp("--fixed-strings", arg)) {
-			opt.fixed = 1;
-			continue;
-		}
-		if (!strcmp("-G", arg) ||
-		    !strcmp("--basic-regexp", arg)) {
-			opt.regflags &= ~REG_EXTENDED;
-			continue;
-		}
-		if (!strcmp("-n", arg)) {
-			opt.linenum = 1;
-			continue;
-		}
-		if (!strcmp("-h", arg)) {
-			opt.pathname = 0;
-			continue;
-		}
-		if (!strcmp("-H", arg)) {
-			opt.pathname = 1;
-			continue;
-		}
-		if (!strcmp("-l", arg) ||
-		    !strcmp("--name-only", arg) ||
-		    !strcmp("--files-with-matches", arg)) {
-			opt.name_only = 1;
-			continue;
-		}
-		if (!strcmp("-L", arg) ||
-		    !strcmp("--files-without-match", arg)) {
-			opt.unmatch_name_only = 1;
-			continue;
-		}
-		if (!strcmp("-z", arg) ||
-		    !strcmp("--null", arg)) {
-			opt.null_following_name = 1;
-			continue;
-		}
-		if (!strcmp("-c", arg) ||
-		    !strcmp("--count", arg)) {
-			opt.count = 1;
-			continue;
-		}
-		if (!strcmp("-w", arg) ||
-		    !strcmp("--word-regexp", arg)) {
-			opt.word_regexp = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "-A") ||
-		    !prefixcmp(arg, "-B") ||
-		    !prefixcmp(arg, "-C") ||
-		    (arg[0] == '-' && '1' <= arg[1] && arg[1] <= '9')) {
-			unsigned num;
-			const char *scan;
-			switch (arg[1]) {
-			case 'A': case 'B': case 'C':
-				if (!arg[2]) {
-					if (argc <= 1)
-						die(emsg_missing_context_len);
-					scan = *++argv;
-					argc--;
-				}
-				else
-					scan = arg + 2;
-				break;
-			default:
-				scan = arg + 1;
-				break;
-			}
-			if (strtoul_ui(scan, 10, &num))
-				die(emsg_invalid_context_len, scan);
-			switch (arg[1]) {
-			case 'A':
-				opt.post_context = num;
-				break;
-			default:
-			case 'C':
-				opt.post_context = num;
-			case 'B':
-				opt.pre_context = num;
-				break;
-			}
-			continue;
-		}
-		if (!strcmp("-f", arg)) {
-			FILE *patterns;
-			int lno = 0;
-			char buf[1024];
-			if (argc <= 1)
-				die(emsg_missing_argument, arg);
-			patterns = fopen(argv[1], "r");
-			if (!patterns)
-				die("'%s': %s", argv[1], strerror(errno));
-			while (fgets(buf, sizeof(buf), patterns)) {
-				int len = strlen(buf);
-				if (len && buf[len-1] == '\n')
-					buf[len-1] = 0;
-				/* ignore empty line like grep does */
-				if (!buf[0])
-					continue;
-				append_grep_pattern(&opt, xstrdup(buf),
-						    argv[1], ++lno,
-						    GREP_PATTERN);
-			}
-			fclose(patterns);
-			argv++;
-			argc--;
-			continue;
-		}
-		if (!strcmp("--not", arg)) {
-			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_NOT);
-			continue;
-		}
-		if (!strcmp("--and", arg)) {
-			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_AND);
-			continue;
-		}
-		if (!strcmp("--or", arg))
-			continue; /* no-op */
-		if (!strcmp("(", arg)) {
-			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_OPEN_PAREN);
-			continue;
-		}
-		if (!strcmp(")", arg)) {
-			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_CLOSE_PAREN);
-			continue;
-		}
-		if (!strcmp("--all-match", arg)) {
-			opt.all_match = 1;
-			continue;
-		}
-		if (!strcmp("-e", arg)) {
-			if (1 < argc) {
-				append_grep_pattern(&opt, argv[1],
-						    "-e option", 0,
-						    GREP_PATTERN);
-				argv++;
-				argc--;
-				continue;
-			}
-			die(emsg_missing_argument, arg);
-		}
-		if (!strcmp("--full-name", arg)) {
-			opt.relative = 0;
-			continue;
-		}
-		if (!strcmp("--color", arg)) {
-			opt.color = 1;
-			continue;
-		}
-		if (!strcmp("--no-color", arg)) {
-			opt.color = 0;
-			continue;
-		}
-		if (!strcmp("--", arg)) {
-			/* later processing wants to have this at argv[1] */
-			argv--;
-			argc++;
-			break;
-		}
-		if (*arg == '-')
-			usage(builtin_grep_usage);
-
-		/* First unrecognized non-option token */
-		if (!opt.pattern_list) {
-			append_grep_pattern(&opt, arg, "command line", 0,
-					    GREP_PATTERN);
-			break;
-		}
-		else {
-			/* We are looking at the first path or rev;
-			 * it is found at argv[1] after leaving the
-			 * loop.
-			 */
-			argc++; argv--;
-			break;
-		}
+	argc = parse_options(argc, argv, options, grep_usage,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_STOP_AT_NON_OPTION |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+
+	/* First unrecognized non-option token */
+	if (argc > 0 && !opt.pattern_list) {
+		append_grep_pattern(&opt, argv[0], "command line", 0,
+				    GREP_PATTERN);
+		argv++;
+		argc--;
 	}
 
 	if (opt.color && !opt.color_external)
@@ -831,7 +785,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	compile_grep_patterns(&opt);
 
 	/* Check revs and then paths */
-	for (i = 1; i < argc; i++) {
+	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
 		/* Is it a rev? */
diff --git a/grep.h b/grep.h
index a67005d..464e272 100644
--- a/grep.h
+++ b/grep.h
@@ -61,23 +61,23 @@ struct grep_opt {
 	struct grep_expr *pattern_expression;
 	int prefix_length;
 	regex_t regexp;
-	unsigned linenum:1;
-	unsigned invert:1;
-	unsigned status_only:1;
-	unsigned name_only:1;
-	unsigned unmatch_name_only:1;
-	unsigned count:1;
-	unsigned word_regexp:1;
-	unsigned fixed:1;
-	unsigned all_match:1;
+	int linenum;
+	int invert;
+	int status_only;
+	int name_only;
+	int unmatch_name_only;
+	int count;
+	int word_regexp;
+	int fixed;
+	int all_match;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
-	unsigned binary:2;
-	unsigned extended:1;
-	unsigned relative:1;
-	unsigned pathname:1;
-	unsigned null_following_name:1;
+	int binary;
+	int extended;
+	int relative;
+	int pathname;
+	int null_following_name;
 	int color;
 	char color_match[COLOR_MAXLEN];
 	const char *color_external;
-- 
1.6.3
