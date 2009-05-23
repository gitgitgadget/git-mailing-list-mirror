From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 4/4] parse-opts: add OPT_FILENAME and transition builtins
Date: Sat, 23 May 2009 11:53:13 -0700
Message-ID: <1243104793-3254-5-git-send-email-bebarino@gmail.com>
References: <1243104793-3254-1-git-send-email-bebarino@gmail.com>
 <1243104793-3254-2-git-send-email-bebarino@gmail.com>
 <1243104793-3254-3-git-send-email-bebarino@gmail.com>
 <1243104793-3254-4-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 23 20:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wLt-0007xZ-RJ
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 20:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330AbZEWSxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 14:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbZEWSxd
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 14:53:33 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:54773 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbZEWSxb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 14:53:31 -0400
Received: by mail-px0-f103.google.com with SMTP id 1so1894468pxi.33
        for <git@vger.kernel.org>; Sat, 23 May 2009 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=prd4rt3uwqy2i5c8sjl1t9eoFEZTpn8bEcjI5AdfZNo=;
        b=RcgwHfbPqKvlg6/SOb7VD7xNaOcIRQ/Ws08QSZyQFGmQm48GF8HDV6waX9EIAyQ1Cf
         /5wcK7wWpTEuVzC2Wfib/x+sofHrPdcd+/6bw2bx35WBScGdu/Oip7kTeH1NDZZEj+/e
         SlbI/BMCvSaRizVkAc09+WzYswz4GcrQH+T+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xWKnfyF1xee/FuLHggLp97HKCVWg6RDv54o9T+4FtOmvNl1c/PlQN/KBkfFuAf9skF
         HG3hPKYJGZdZGxpswA5VdcArYcCYXKRYUfTiv8fjwWaSyv/9dAJa8j7REr4PU3IGeKOZ
         EU2IEU88cbAzTKgsdS2a+DrNBxgXOHW2hBwRQ=
Received: by 10.114.184.11 with SMTP id h11mr10797649waf.100.1243104813552;
        Sat, 23 May 2009 11:53:33 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id n9sm5246034wag.67.2009.05.23.11.53.30
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 11:53:32 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 23 May 2009 11:53:29 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
In-Reply-To: <1243104793-3254-4-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119785>

Commit dbd0f5c (Files given on the command line are relative to $cwd,
2008-08-06) introduced parse_options_fix_filename() as a minimal fix.
OPT_FILENAME is intended to be a more robust fix for the same issue.
OPT_FILENAME and its associated enum OPTION_FILENAME are used to
represent filename options within the parse options API.

This option is similar to OPTION_STRING. If --no is prefixed to the
option the filename is unset. If no argument is given and the default
value is set, the filename is set to the default value. The difference
is that the filename is prefixed with the prefix passed to
parse_options() (or parse_options_start()).

Update git-apply, git-commit, git-fmt-merge-msg, and git-tag to use
OPT_FILENAME with their filename options. Also, rename
parse_options_fix_filename() to fix_filename() as it is no longer
extern.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/technical/api-parse-options.txt |    5 +++
 builtin-apply.c                               |    5 +---
 builtin-commit.c                              |   10 +-----
 builtin-fmt-merge-msg.c                       |    3 +-
 builtin-tag.c                                 |    3 +-
 parse-options.c                               |   36 ++++++++++++++++--------
 parse-options.h                               |    5 ++-
 t/t0040-parse-options.sh                      |   19 +++++++++++-
 test-parse-options.c                          |    6 +++-
 9 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index aace580..50f9e9a 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -167,6 +167,11 @@ There are some macros to easily define options:
 	and the result will be put into `var`.
 	See 'Option Callbacks' below for a more elaborate description.
 
+`OPT_FILENAME(short, long, &var, description)`::
+	Introduce an option with a filename argument.
+	The filename will be prefixed by passing the filename along with
+	the prefix argument of `parse_options()` to `prefix_filename()`.
+
 `OPT_ARGUMENT(long, description)`::
 	Introduce a long-option argument that will be kept in `argv[]`.
 
diff --git a/builtin-apply.c b/builtin-apply.c
index bac03d7..5329186 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3278,7 +3278,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			"apply a patch without touching the working tree"),
 		OPT_BOOLEAN(0, "apply", &force_apply,
 			"also apply the patch (use with --stat/--summary/--check)"),
-		OPT_STRING(0, "build-fake-ancestor", &fake_ancestor, "file",
+		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			"build a temporary index based on embedded index information"),
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			"paths are separated with NUL character",
@@ -3315,9 +3315,6 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	argc = parse_options(argc, argv, prefix, builtin_apply_options,
 			apply_usage, 0);
-	fake_ancestor = parse_options_fix_filename(prefix, fake_ancestor);
-	if (fake_ancestor)
-		fake_ancestor = xstrdup(fake_ancestor);
 
 	if (apply_with_reject)
 		apply = apply_verbosely = 1;
diff --git a/builtin-commit.c b/builtin-commit.c
index b9a1528..41e222d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -88,13 +88,13 @@ static struct option builtin_commit_options[] = {
 	OPT__VERBOSE(&verbose),
 	OPT_GROUP("Commit message options"),
 
-	OPT_STRING('F', "file", &logfile, "FILE", "read log from file"),
+	OPT_FILENAME('F', "file", &logfile, "read log from file"),
 	OPT_STRING(0, "author", &force_author, "AUTHOR", "override author for commit"),
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
 	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
-	OPT_STRING('t', "template", &template_file, "FILE", "use specified template file"),
+	OPT_FILENAME('t', "template", &template_file, "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 
 	OPT_GROUP("Commit contents options"),
@@ -699,12 +699,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	argc = parse_options(argc, argv, prefix, builtin_commit_options, usage,
 			     0);
-	logfile = parse_options_fix_filename(prefix, logfile);
-	if (logfile)
-		logfile = xstrdup(logfile);
-	template_file = parse_options_fix_filename(prefix, template_file);
-	if (template_file)
-		template_file = xstrdup(template_file);
 
 	if (force_author && !strchr(force_author, '>'))
 		force_author = find_author_by_nickname(force_author);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index d4c7206..fbf9582 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -351,7 +351,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
 		OPT_BOOLEAN(0, "summary", &merge_summary, "alias for --log"),
-		OPT_STRING('F', "file",   &inpath, "file", "file to read from"),
+		OPT_FILENAME('F', "file", &inpath, "file to read from"),
 		OPT_END()
 	};
 
@@ -364,7 +364,6 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
-	inpath = parse_options_fix_filename(prefix, inpath);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
diff --git a/builtin-tag.c b/builtin-tag.c
index 6e8b464..dc3db62 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -387,7 +387,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					"annotated tag, needs a message"),
 		OPT_CALLBACK('m', NULL, &msg, "msg",
 			     "message for the tag", parse_msg_arg),
-		OPT_STRING('F', NULL, &msgfile, "file", "message in a file"),
+		OPT_FILENAME('F', NULL, &msgfile, "message in a file"),
 		OPT_BOOLEAN('s', NULL, &sign, "annotated and GPG-signed tag"),
 		OPT_STRING('u', NULL, &keyid, "key-id",
 					"use another key to sign the tag"),
@@ -406,7 +406,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	git_config(git_tag_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, options, git_tag_usage, 0);
-	msgfile = parse_options_fix_filename(prefix, msgfile);
 
 	if (keyid) {
 		sign = 1;
diff --git a/parse-options.c b/parse-options.c
index bfeb9d3..896ecef 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -31,11 +31,20 @@ static int get_arg(struct parse_opt_ctx_t *p, const struct option *opt,
 	return 0;
 }
 
+static void fix_filename(const char *prefix, const char **file)
+{
+	if (!file || !*file || !prefix || is_absolute_path(*file)
+	    || !strcmp("-", *file))
+		return;
+	*file = xstrdup(prefix_filename(prefix, strlen(prefix), *file));
+}
+
 static int get_value(struct parse_opt_ctx_t *p,
 		     const struct option *opt, int flags)
 {
 	const char *s, *arg;
 	const int unset = flags & OPT_UNSET;
+	int err;
 
 	if (unset && p->opt)
 		return opterror(opt, "takes no value", flags);
@@ -95,6 +104,19 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return get_arg(p, opt, flags, (const char **)opt->value);
 		return 0;
 
+	case OPTION_FILENAME:
+		err = 0;
+		if (unset)
+			*(const char **)opt->value = NULL;
+		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+			*(const char **)opt->value = (const char *)opt->defval;
+		else
+			err = get_arg(p, opt, flags, (const char **)opt->value);
+
+		if (!err)
+			fix_filename(p->prefix, (const char **)opt->value);
+		return err;
+
 	case OPTION_CALLBACK:
 		if (unset)
 			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
@@ -480,6 +502,8 @@ int usage_with_options_internal(const char * const *usagestr,
 			if (opts->flags & PARSE_OPT_NOARG)
 				break;
 			/* FALLTHROUGH */
+		case OPTION_FILENAME:
+			/* FALLTHROUGH */
 		case OPTION_STRING:
 			if (opts->argh) {
 				if (opts->flags & PARSE_OPT_OPTARG)
@@ -596,15 +620,3 @@ int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
 	commit_list_insert(commit, opt->value);
 	return 0;
 }
-
-/*
- * This should really be OPTION_FILENAME type as a part of
- * parse_options that take prefix to do this while parsing.
- */
-extern const char *parse_options_fix_filename(const char *prefix, const char *file)
-{
-	if (!file || !prefix || is_absolute_path(file) || !strcmp("-", file))
-		return file;
-	return prefix_filename(prefix, strlen(prefix), file);
-}
-
diff --git a/parse-options.h b/parse-options.h
index 624f192..6fe3d5d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -17,6 +17,7 @@ enum parse_opt_type {
 	OPTION_STRING,
 	OPTION_INTEGER,
 	OPTION_CALLBACK,
+	OPTION_FILENAME
 };
 
 enum parse_opt_flags {
@@ -113,6 +114,8 @@ struct option {
 #define OPT_NUMBER_CALLBACK(v, h, f) \
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, (f) }
+#define OPT_FILENAME(s, l, v, h)    { OPTION_FILENAME, (s), (l), (v), \
+				       "FILE", (h) }
 
 /* parse_options() will filter out the processed options and leave the
  * non-option arguments in argv[].
@@ -180,6 +183,4 @@ extern int parse_opt_with_commit(const struct option *, const char *, int);
 	  "use <n> digits to display SHA-1s", \
 	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
 
-extern const char *parse_options_fix_filename(const char *prefix, const char *file);
-
 #endif
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a40c123..bbc821e 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -19,6 +19,7 @@ usage: test-parse-options <options>
     --set23               set integer to 23
     -t <time>             get timestamp of <time>
     -L, --length <str>    get length of <str>
+    -F, --file <FILE>     set file to <FILE>
 
 String options
     -s, --string <string>
@@ -56,10 +57,12 @@ abbrev: 7
 verbose: 2
 quiet: no
 dry run: yes
+file: prefix/my.file
 EOF
 
 test_expect_success 'short options' '
-	test-parse-options -s123 -b -i 1729 -b -vv -n > output 2> output.err &&
+	test-parse-options -s123 -b -i 1729 -b -vv -n -F my.file \
+	> output 2> output.err &&
 	test_cmp expect output &&
 	test ! -s output.err
 '
@@ -73,11 +76,12 @@ abbrev: 10
 verbose: 2
 quiet: no
 dry run: no
+file: prefix/fi.le
 EOF
 
 test_expect_success 'long options' '
 	test-parse-options --boolean --integer 1729 --boolean --string2=321 \
-		--verbose --verbose --no-dry-run --abbrev=10 \
+		--verbose --verbose --no-dry-run --abbrev=10 --file fi.le\
 		> output 2> output.err &&
 	test ! -s output.err &&
 	test_cmp expect output
@@ -87,6 +91,8 @@ test_expect_success 'missing required value' '
 	test-parse-options -s;
 	test $? = 129 &&
 	test-parse-options --string;
+	test $? = 129 &&
+	test-parse-options --file;
 	test $? = 129
 '
 
@@ -99,6 +105,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 arg 00: a1
 arg 01: b1
 arg 02: --boolean
@@ -120,6 +127,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
@@ -148,6 +156,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
@@ -175,6 +184,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 arg 00: --quux
 EOF
 
@@ -193,6 +203,7 @@ abbrev: 7
 verbose: 0
 quiet: yes
 dry run: no
+file: (not set)
 arg 00: foo
 EOF
 
@@ -213,6 +224,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
@@ -240,6 +252,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 EOF
 
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
@@ -263,6 +276,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 EOF
 
 test_expect_success 'OPT_BIT() works' '
@@ -292,6 +306,7 @@ abbrev: 7
 verbose: 0
 quiet: no
 dry run: no
+file: (not set)
 EOF
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
diff --git a/test-parse-options.c b/test-parse-options.c
index da3d658..a90bc30 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -7,6 +7,7 @@ static unsigned long timestamp;
 static int abbrev = 7;
 static int verbose = 0, dry_run = 0, quiet = 0;
 static char *string = NULL;
+static char *file = NULL;
 
 int length_callback(const struct option *opt, const char *arg, int unset)
 {
@@ -27,6 +28,7 @@ int number_callback(const struct option *opt, const char *arg, int unset)
 
 int main(int argc, const char **argv)
 {
+	const char *prefix = "prefix/";
 	const char *usage[] = {
 		"test-parse-options <options>",
 		NULL
@@ -43,6 +45,7 @@ int main(int argc, const char **argv)
 		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
+		OPT_FILENAME('F', "file", &file, "set file to <FILE>"),
 		OPT_GROUP("String options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
@@ -65,7 +68,7 @@ int main(int argc, const char **argv)
 	};
 	int i;
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	printf("boolean: %d\n", boolean);
 	printf("integer: %u\n", integer);
@@ -75,6 +78,7 @@ int main(int argc, const char **argv)
 	printf("verbose: %d\n", verbose);
 	printf("quiet: %s\n", quiet ? "yes" : "no");
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
+	printf("file: %s\n", file ? file : "(not set)");
 
 	for (i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
-- 
1.6.3.1.145.gb74d77
