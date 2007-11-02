Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 18710 invoked by uid 111); 2 Nov 2007 22:40:17 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 Nov 2007 18:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbXKBWkG (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2007 18:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbXKBWkF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:40:05 -0400
Received: from pan.madism.org ([88.191.52.104]:45438 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290AbXKBWj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:39:56 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 44D66282CD;
	Fri,  2 Nov 2007 23:39:54 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 163BC8413; Fri,  2 Nov 2007 23:39:53 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com, torvalds@linux-foundation.org
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/5] Add a parseopt mode to git-rev-parse to bring parse-options to shell scripts.
Date:	Fri,  2 Nov 2007 23:39:48 +0100
Message-Id: <1194043193-29601-2-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1460.gdb47
In-Reply-To: <1194043193-29601-1-git-send-email-madcoder@debian.org>
References: alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org
 <1194043193-29601-1-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-rev-parse.txt |   75 ++++++++++++++++++++++-
 builtin-rev-parse.c             |  126 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 199 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 4758c33..6811656 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -23,6 +23,13 @@ distinguish between them.
 
 OPTIONS
 -------
+--parseopt::
+        Use `git-rev-parse` in option parsing mode (see PARSEOPT section below).
+
+--keep-dash-dash::
+	Only meaningful in `--parseopt` mode. Tells the option parser to echo
+        out the first `--` met instead of skipping it.
+
 --revs-only::
 	Do not output flags and parameters not meant for
 	`git-rev-list` command.
@@ -288,10 +295,74 @@ Here are a handful examples:
    C^@              I J F
    F^! D            G H D F
 
+PARSEOPT
+--------
+
+In `--parseopt` mode, `git-rev-parse` helps massaging options to bring to shell
+scripts the same facilities C builtins have. It works as an option normalizer
+(e.g. splits single switches aggregate values), a bit like `getopt(1)` does.
+
+It takes on the standard input the specification of the options to parse and
+understand, and echoes on the standard ouput a line suitable for `sh(1)` `eval`
+to replace the arguments with normalized ones.  In case of error, it ouputs
+usage on the standard error stream, and exits with code 129.
+
+Input Format
+~~~~~~~~~~~~
+
+`git-ref-parse --parseopt` input format is fully text based. It has two parts,
+separated by a line that contains only `--`. The lines before (should be more
+than one) are used for the usage. The lines after describe the options.
+
+Each line of options has this format:
+
+------------
+<opt_spec><arg_spec>? SP+ help LF
+------------
+
+`<opt_spec>`::
+	its format is the short option character, then the long option name
+        separated by a comma. Both parts are not required, though at least one
+        is necessary. `h,help`, `dry-run` and `f` are all three correct
+        `<opt_spec>`.
+
+`<arg_spec>`::
+	an `<arg_spec>` tells the option parser if the option has an argument
+        (`=`), an optionnal one (`?` though its use is discouraged) or none
+        (no `<arg_spec>` in that case).
+
+The rest of the line after as many spaces up to the ending line feed is used
+as the help associated to the option.
+
+Blank lines are ignored, and lines that don't match this specification are used
+as option group headers (start the line with a space to purposely create such
+lines).
+
+Example
+~~~~~~~
+
+------------
+OPTS_SPEC="\
+some-command [options] <args>...
+
+some-command does foo and bar !
+--
+h,help    show the help
+
+foo       some nifty option --foo
+bar=      some cool option --bar with an argument
+
+  An option group Header
+C?        option C with an optionnal argument"
+
+eval `echo "$OPTS_SPEC" | git-rev-parse --parseopt -- "$@" || echo exit $?`
+------------
+
+
 Author
 ------
-Written by Linus Torvalds <torvalds@osdl.org> and
-Junio C Hamano <junkio@cox.net>
+Written by Linus Torvalds <torvalds@osdl.org> .
+Junio C Hamano <junkio@cox.net> and Pierre Habouzit <madcoder@debian.org>
 
 Documentation
 --------------
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 8d78b69..054519b 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -8,6 +8,7 @@
 #include "refs.h"
 #include "quote.h"
 #include "builtin.h"
+#include "parse-options.h"
 
 #define DO_REVS		1
 #define DO_NOREV	2
@@ -209,6 +210,128 @@ static int try_difference(const char *arg)
 	return 0;
 }
 
+static int parseopt_dump(const struct option *o, const char *arg, int unset)
+{
+	struct strbuf *parsed = o->value;
+	if (unset)
+		strbuf_addf(parsed, " --no-%s", o->long_name);
+	else if (o->short_name)
+		strbuf_addf(parsed, " -%c", o->short_name);
+	else
+		strbuf_addf(parsed, " --%s", o->long_name);
+	if (arg) {
+		strbuf_addch(parsed, ' ');
+		sq_quote_buf(parsed, arg);
+	}
+	return 0;
+}
+
+static const char *skipspaces(const char *s)
+{
+	while (isspace(*s))
+		s++;
+	return s;
+}
+
+static int cmd_parseopt(int argc, const char **argv, const char *prefix)
+{
+	static int keep_dashdash = 0;
+	static char const * const parseopt_usage[] = {
+		"git-rev-parse --parseopt [options] -- [<args>...]",
+		NULL
+	};
+	static struct option parseopt_opts[] = {
+		OPT_BOOLEAN(0, "keep-dashdash", &keep_dashdash,
+					"keep the `--` passed as an arg"),
+		OPT_END(),
+	};
+
+	struct strbuf sb, parsed;
+	const char **usage = NULL;
+	struct option *opts = NULL;
+	int onb = 0, osz = 0, unb = 0, usz = 0;
+
+	strbuf_init(&parsed, 0);
+	strbuf_addstr(&parsed, "set --");
+	argc = parse_options(argc, argv, parseopt_opts, parseopt_usage,
+	                     PARSE_OPT_KEEP_DASHDASH);
+	if (argc < 1 || strcmp(argv[0], "--"))
+		usage_with_options(parseopt_usage, parseopt_opts);
+
+	strbuf_init(&sb, 0);
+	/* get the usage up to the first line with a -- on it */
+	for (;;) {
+		if (strbuf_getline(&sb, stdin, '\n') == EOF)
+			die("premature end of input");
+		ALLOC_GROW(usage, unb + 1, usz);
+		if (!strcmp("--", sb.buf)) {
+			if (unb < 1)
+				die("no usage string given before the `--' separator");
+			usage[unb] = NULL;
+			break;
+		}
+		usage[unb++] = strbuf_detach(&sb, NULL);
+	}
+
+	/* parse: (<short>|<short>,<long>|<long>)[=?]? SP+ <help> */
+	while (strbuf_getline(&sb, stdin, '\n') != EOF) {
+		const char *s;
+		struct option *o;
+
+		if (!sb.len)
+			continue;
+
+		ALLOC_GROW(opts, onb + 1, osz);
+		memset(opts + onb, 0, sizeof(opts[onb]));
+
+		o = &opts[onb++];
+		s = strchr(sb.buf, ' ');
+		if (!s || *sb.buf == ' ') {
+			o->type = OPTION_GROUP;
+			o->help = xstrdup(skipspaces(s));
+			continue;
+		}
+
+		o->type = OPTION_CALLBACK;
+		o->help = xstrdup(skipspaces(s));
+		o->value = &parsed;
+		o->callback = &parseopt_dump;
+		switch (s[-1]) {
+		case '=':
+			s--;
+			break;
+		case '?':
+			o->flags = PARSE_OPT_OPTARG;
+			s--;
+			break;
+		default:
+			o->flags = PARSE_OPT_NOARG;
+			break;
+		}
+
+		if (s - sb.buf == 1) /* short option only */
+			o->short_name = *sb.buf;
+		else if (sb.buf[1] != ',') /* long option only */
+			o->long_name = xmemdupz(sb.buf, s - sb.buf);
+		else {
+			o->short_name = *sb.buf;
+			o->long_name = xmemdupz(sb.buf + 2, s - sb.buf - 2);
+		}
+	}
+	strbuf_release(&sb);
+
+	/* put an OPT_END() */
+	ALLOC_GROW(opts, onb + 1, osz);
+	memset(opts + onb, 0, sizeof(opts[onb]));
+	argc = parse_options(argc, argv, opts, usage,
+	                     keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0);
+
+	strbuf_addf(&parsed, " --");
+	sq_quote_argv(&parsed, argv, argc, 0);
+	puts(parsed.buf);
+	return 0;
+}
+
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0;
@@ -216,6 +339,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config);
 
+	if (argc > 1 && !strcmp("--parseopt", argv[1]))
+		return cmd_parseopt(argc - 1, argv + 1, prefix);
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
-- 
1.5.3.5.1460.gdb47

