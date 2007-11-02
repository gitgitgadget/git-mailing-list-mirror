Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 16149 invoked by uid 111); 2 Nov 2007 15:09:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 Nov 2007 11:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbXKBPJb (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2007 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbXKBPJa
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:09:30 -0400
Received: from pan.madism.org ([88.191.52.104]:50890 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097AbXKBPJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:09:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 6710D27F09;
	Fri,  2 Nov 2007 16:09:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8565B4FD; Fri,  2 Nov 2007 16:09:22 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com, torvalds@linux-foundation.org
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Add git-parseopt(1) to bring parse-options to shell scripts.
Date:	Fri,  2 Nov 2007 16:09:19 +0100
Message-Id: <1194016162-23599-2-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1458.g2aa13-dirty
In-Reply-To: <1194016162-23599-1-git-send-email-madcoder@debian.org>
References: alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org
 <1194016162-23599-1-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

---
 .gitignore                     |    1 +
 Documentation/cmd-list.perl    |    1 +
 Documentation/git-parseopt.txt |   91 +++++++++++++++++++++++++++++
 Makefile                       |    1 +
 builtin-parseopt.c             |  123 ++++++++++++++++++++++++++++++++++++++++
 builtin.h                      |    1 +
 git.c                          |    1 +
 7 files changed, 219 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-parseopt.txt
 create mode 100644 builtin-parseopt.c

diff --git a/.gitignore b/.gitignore
index c8c13f5..521155c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -86,6 +86,7 @@ git-pack-redundant
 git-pack-objects
 git-pack-refs
 git-parse-remote
+git-parseopt
 git-patch-id
 git-peek-remote
 git-prune
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 8d21d42..c491964 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -147,6 +147,7 @@ git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
 git-pack-refs                           ancillarymanipulators
 git-parse-remote                        synchelpers
+git-parseopt                            plumbingmanipulators
 git-patch-id                            purehelpers
 git-peek-remote                         purehelpers
 git-prune                               ancillarymanipulators
diff --git a/Documentation/git-parseopt.txt b/Documentation/git-parseopt.txt
new file mode 100644
index 0000000..77f5a10
--- /dev/null
+++ b/Documentation/git-parseopt.txt
@@ -0,0 +1,91 @@
+git-parseopt(1)
+============
+
+NAME
+----
+git-parseopt - Git shell script helper similar to getopt(1)
+
+
+SYNOPSIS
+--------
+'git-parseopt' [-u] [--keep-dashdash] -- [<args>...]
+
+DESCRIPTION
+-----------
+
+This is a helper for scripts to behave the same as git C commands. It merely
+breaks and normalize options so that the option parsing becomes shorter and
+easier to read. It takes the specifications of the options to undersand on its
+standard input.
+
+In case of error, it ouputs usage on the standard error stream, and exits with
+code 129. Else its ouput is suitable for evaluation with "eval" to replace
+the script arguments with the normalized form.
+
+OPTIONS
+-------
+
+--keep-dash-dash::
+	Keep the `--` in `<args>...`.
+
+\--::
+	Following arguments are the options to parse. This isn't optional.
+
+<args>...::
+	Options to parse and deal with
+
+INPUT FORMAT
+------------
+
+`git-parseopt` input format is fully text based. It has two parts, separated
+by a line that contains only `--`. The lines before (should be more than one)
+is used for the usage. The lines after describe the options.
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
+EXAMPLE
+-------
+
+------------
+OPTS_SPEC="\
+some-command [options] <args>...
+
+some-command does foo and bar !
+--
+h,help    show the help
+foo       some nifty option --foo
+bar=      some cool option --bar with an argument
+C?        option C with an optionnal argument"
+
+eval `echo "$OPTS_SPEC" | git-parseopt -- "$@" || echo exit $?`
+------------
+
+Author
+------
+Written by Pierre Habouzit <madcoder@debian.org>
+
+Documentation
+--------------
+Documentation by Pierre Habouzit.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 042f79e..7c5df55 100644
--- a/Makefile
+++ b/Makefile
@@ -352,6 +352,7 @@ BUILTIN_OBJS = \
 	builtin-mv.o \
 	builtin-name-rev.o \
 	builtin-pack-objects.o \
+	builtin-parseopt.o \
 	builtin-prune.o \
 	builtin-prune-packed.o \
 	builtin-push.o \
diff --git a/builtin-parseopt.c b/builtin-parseopt.c
new file mode 100644
index 0000000..c032f5a
--- /dev/null
+++ b/builtin-parseopt.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright © 2007 Pierre Habouzit <madcoder@debian.org>
+ */
+#include "git-compat-util.h"
+#include "cache.h"
+#include "quote.h"
+#include "parse-options.h"
+
+static int keep_dashdash = 0;
+static struct strbuf parsed = STRBUF_INIT;
+
+static struct option parseopt_opts[] = {
+	OPT_BOOLEAN(0, "keep-dashdash", &keep_dashdash,
+				"keep the `--` passed as an arg"),
+	OPT_END(),
+};
+
+static char const * const parseopt_usage[] = {
+	"git-parseopt [options] -- [<args>...]",
+	NULL
+};
+
+static int parseopt_dump(const struct option *o, const char *arg, int unset)
+{
+	if (unset)
+		strbuf_addf(&parsed, " --no-%s", o->long_name);
+	else if (o->short_name)
+		strbuf_addf(&parsed, " -%c", o->short_name);
+	else
+		strbuf_addf(&parsed, " --%s", o->long_name);
+	if (arg) {
+		strbuf_addch(&parsed, ' ');
+		sq_quote_buf(&parsed, arg);
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
+int cmd_parseopt(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf sb;
+	const char **usage = NULL;
+	struct option *opts = NULL;
+	int onb = 0, osz = 0, unb = 0, usz = 0;
+
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
+		ALLOC_GROW(opts, onb + 1, osz);
+		memset(opts + onb, 0, sizeof(opts[onb]));
+
+		o = &opts[onb++];
+		s = strchr(sb.buf, ' ');
+		if (!s || *sb.buf == ' ')
+			die("invalid option spec");
+
+		o->type = OPTION_CALLBACK;
+		o->help = xstrdup(skipspaces(s));
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
diff --git a/builtin.h b/builtin.h
index 9a6213a..b2ef7b6 100644
--- a/builtin.h
+++ b/builtin.h
@@ -55,6 +55,7 @@ extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
 extern int cmd_mv(int argc, const char **argv, const char *prefix);
 extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+extern int cmd_parseopt(int argc, const char **argv, const char *prefix);
 extern int cmd_pickaxe(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 4e10581..89524dd 100644
--- a/git.c
+++ b/git.c
@@ -333,6 +333,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 		{ "name-rev", cmd_name_rev, RUN_SETUP },
 		{ "pack-objects", cmd_pack_objects, RUN_SETUP },
+		{ "parseopt", cmd_parseopt },
 		{ "pickaxe", cmd_blame, RUN_SETUP },
 		{ "prune", cmd_prune, RUN_SETUP },
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
-- 
1.5.3.5.1458.g2aa13-dirty

