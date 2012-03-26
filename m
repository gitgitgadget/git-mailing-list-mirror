From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 4/4] grep: add --hunk-heading option
Date: Sun, 25 Mar 2012 22:41:45 -0400
Message-ID: <1332729705-9283-5-git-send-email-lodatom@gmail.com>
References: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 04:42:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBztX-0000gP-NG
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 04:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab2CZCmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 22:42:38 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62527 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244Ab2CZCmC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 22:42:02 -0400
Received: by qcqw6 with SMTP id w6so3056748qcq.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 19:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zka96pLEcwPMiGiF/7/1tIVMuIa7CWgoxKwYrwY9jxM=;
        b=bf3is+Q83Kp2AcAkXEnrsqxxClDlVTFblVC+2KwJTgzicSaCLyK5LQ+ukJ339mojUW
         /+sEpam7GDHeViUs/z2b2OjQzH26l2G7GbRhe9hPmaCkUTS0Je4F1e2xSvT0RoTwY4el
         sdmlWL45C63XoBX/Gwga+hxgdGiQ9Bou5TNByVaG14JwOVgzyZ3fG3AxkkQAbGc7+3iM
         njf7IbXBzlBwgkhjqeGpNTp9eTxovaxwQOg+rFCG83AUR78L2Uo9NyKH3XoO7WpABaV6
         sWJug5GPap9Rs2LI+bUFdUMUhEMBr3lNCCTLlZnJzzm/5eAnWgIil24XmEvh22/1iKy4
         5+4A==
Received: by 10.224.33.18 with SMTP id f18mr22629765qad.39.1332729722067;
        Sun, 25 Mar 2012 19:42:02 -0700 (PDT)
Received: from mark.hsd1.dc.comcast.net. (c-76-21-213-235.hsd1.dc.comcast.net. [76.21.213.235])
        by mx.google.com with ESMTPS id fq1sm27711867qab.10.2012.03.25.19.42.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 19:42:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.4
In-Reply-To: <1332729705-9283-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193894>

The purpose of this option is to make the output of grep when showing
context (i.e., -A, -B, -C, or -W) easier to read.  By default, grep
prints a simple separator ("--") between each hunk and then prefixes
each line within the hunk with the same filename and optionally an
incrementing line number.  This repeated information is redundant, so
the new --hunk-heading option moves it all to the hunk separator line.
The idea is similar to the hunk context line of diff.

The new option can be combined with --heading to provide both the
filename and line number of each hunk with minimal visual clutter.

The new configuration, grep.hunkHeading, can be used to set this option
by default.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/config.txt     |    3 +
 Documentation/git-grep.txt   |   10 ++-
 builtin/grep.c               |   10 ++-
 grep.c                       |   28 ++++++-
 grep.h                       |    1 +
 t/t7812-grep-hunk-heading.sh |  181 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 227 insertions(+), 6 deletions(-)
 create mode 100755 t/t7812-grep-hunk-heading.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c081657..ade9503 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1140,6 +1140,9 @@ grep.lineNumber::
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default.
 
+grep.hunkHeading::
+	If set to true, enable '--hunk-heading' option by default.
+
 gpg.program::
 	Use this custom program instead of "gpg" found on $PATH when
 	making or verifying a PGP signature. The program must support the
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 343eadd..26c085b 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 	   [-c | --count] [--all-match] [-q | --quiet]
 	   [--max-depth <depth>]
 	   [--color[=<when>] | --no-color]
-	   [--break] [--heading] [-p | --show-function]
+	   [--break] [--heading] [--hunk-heading] [-p | --show-function]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-W | --function-context]
 	   [-f <file>] [-e] <pattern>
@@ -43,6 +43,9 @@ grep.lineNumber::
 grep.extendedRegexp::
 	If set to true, enable '--extended-regexp' option by default.
 
+grep.hunkHeading::
+	If set to true, enable '--hunk-heading' option by default.
+
 
 OPTIONS
 -------
@@ -173,6 +176,11 @@ OPTIONS
 	Show the filename above the matches in that file instead of
 	at the start of each shown line.
 
+--hunk-heading::
+	Append the filename (if not `--heading` and not `-h`) and line number
+	(if not `-n`) to each hunk separator, and suppress printing of the
+	filename at the start of each shown line.
+
 -p::
 --show-function::
 	Show the preceding line that contains the function name of
diff --git a/builtin/grep.c b/builtin/grep.c
index 643938d..cdafc5a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -276,6 +276,11 @@ static int grep_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "grep.hunkheading")) {
+		opt->hunk_heading = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "grep.linenumber")) {
 		opt->linenum = git_config_bool(var, value);
 		return 0;
@@ -740,6 +745,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"print empty line between matches from different files"),
 		OPT_BOOLEAN(0, "heading", &opt.heading,
 			"show filename only once above matches from same file"),
+		OPT_BOOLEAN(0, "hunk-heading", &opt.hunk_heading,
+			"show filename and line number after hunk separator"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', "context", &opt, "n",
 			"show <n> context lines before and after matches",
@@ -920,8 +927,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 #ifndef NO_PTHREADS
 	if (use_threads) {
 		if (!(opt.name_only || opt.unmatch_name_only || opt.count)
+		    && !(opt.hunk_heading && !opt.heading && !opt.file_break)
 		    && (opt.pre_context || opt.post_context ||
-			opt.file_break || opt.funcbody))
+			opt.file_break || opt.funcbody || opt.hunk_heading))
 			skip_first_line = 1;
 		start_threads(&opt);
 	}
diff --git a/grep.c b/grep.c
index 14e0480..f0e00f7 100644
--- a/grep.c
+++ b/grep.c
@@ -747,21 +747,41 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		if (opt->heading && !opt->file_break)
 			output_color(opt, "--", 2, opt->color_sep);
 		opt->output(opt, "\n", 1);
-		show_hunk = 0;
+		if (!opt->hunk_heading)
+			show_hunk = 0;
 	}
 	if (opt->heading && opt->last_shown == 0) {
 		output_color(opt, name, strlen(name), opt->color_filename);
 		opt->output(opt, "\n", 1);
 	}
 	if (show_hunk &&
-	    ((opt->last_shown == 0 && opt->show_hunk_mark) ||
+	    ((opt->last_shown == 0 && (opt->show_hunk_mark || opt->hunk_heading)) ||
 	     (opt->last_shown != 0 && lno > opt->last_shown + 1))) {
 		output_color(opt, "--", 2, opt->color_sep);
+		if (opt->hunk_heading &&
+		    ((!opt->heading && opt->pathname) || !opt->linenum)) {
+			opt->output(opt, " ", 1);
+			if (!opt->heading && opt->pathname) {
+				output_color(opt, name, strlen(name),
+					     opt->color_filename);
+				if (!opt->linenum)
+					output_sep(opt, ':');
+			}
+			if (!opt->linenum) {
+				char buf[32];
+				snprintf(buf, sizeof(buf), "%d", lno);
+				output_color(opt, buf, strlen(buf),
+					     opt->color_lineno);
+			}
+			opt->output(opt, " ", 1);
+			output_color(opt, "--", 2, opt->color_sep);
+		}
 		opt->output(opt, "\n", 1);
 	}
 	opt->last_shown = lno;
 
-	if (!opt->heading && opt->pathname) {
+	if (opt->pathname && !opt->heading &&
+	    !(opt->hunk_heading && show_hunk)) {
 		output_color(opt, name, strlen(name), opt->color_filename);
 		output_sep(opt, sign);
 	}
@@ -1001,7 +1021,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		opt->output = std_output;
 
 	if (opt->pre_context || opt->post_context || opt->file_break ||
-	    opt->funcbody) {
+	    opt->funcbody || opt->hunk_heading) {
 		/* Show hunk marks, except for the first file. */
 		if (opt->last_shown)
 			opt->show_hunk_mark = 1;
diff --git a/grep.h b/grep.h
index 36e49d8..761db2a 100644
--- a/grep.h
+++ b/grep.h
@@ -117,6 +117,7 @@ struct grep_opt {
 	int show_hunk_mark;
 	int file_break;
 	int heading;
+	int hunk_heading;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
diff --git a/t/t7812-grep-hunk-heading.sh b/t/t7812-grep-hunk-heading.sh
new file mode 100755
index 0000000..6db9ba6
--- /dev/null
+++ b/t/t7812-grep-hunk-heading.sh
@@ -0,0 +1,181 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Mark Lodato
+#
+
+test_description='git grep --hunk-heading'
+
+. ./test-lib.sh
+
+cat >one.c <<EOF
+#include <stdio.h>
+int main(int argc, const char **argv)
+{
+	printf("Hello world.\n");
+	return 0;
+}
+EOF
+
+cat >two.c <<EOF
+int hello_int(int x)
+{
+	printf("Hello, %d.\n", x);
+	return 0;
+}
+
+int hello_str(const char *s)
+{
+	printf("Hello, %s.\n", s);
+	return 0;
+}
+EOF
+
+test_expect_success 'setup' '
+	git add . &&
+	git commit -m initial
+'
+
+cat >expected <<EOF
+one.c:	printf("Hello world.\n");
+two.c:	printf("Hello, %d.\n", x);
+two.c:	printf("Hello, %s.\n", s);
+EOF
+
+test_expect_success 'grep --hunk-heading without context' '
+	git grep -e Hello --hunk-heading >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+-- one.c:4 --
+	printf("Hello world.\n");
+	return 0;
+-- two.c:3 --
+	printf("Hello, %d.\n", x);
+	return 0;
+-- two.c:9 --
+	printf("Hello, %s.\n", s);
+	return 0;
+EOF
+
+test_expect_success 'grep --hunk-heading -A1' '
+	git grep -e Hello -A1 --hunk-heading >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep --hunk-heading -B1' '
+	git grep -e return -B1 --hunk-heading >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+<RED>--<RESET> <BLUE>one.c<RESET><RED>:<RESET><GREEN>4<RESET> <RED>--<RESET>
+	printf("Hello world.\n");
+	return 0;
+<RED>--<RESET> <BLUE>two.c<RESET><RED>:<RESET><GREEN>3<RESET> <RED>--<RESET>
+	printf("Hello, %d.\n", x);
+	return 0;
+<RED>--<RESET> <BLUE>two.c<RESET><RED>:<RESET><GREEN>9<RESET> <RED>--<RESET>
+	printf("Hello, %s.\n", s);
+	return 0;
+EOF
+
+test_expect_success 'grep --hunk-heading --color' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		"blue" &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	"green" &&
+	test_config color.grep.match		normal &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	"red" &&
+
+	git grep -e Hello -A1 --hunk-heading --color |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+-- one.c:4 --
+	printf("Hello world.\n");
+	return 0;
+
+-- two.c:3 --
+	printf("Hello, %d.\n", x);
+	return 0;
+-- two.c:9 --
+	printf("Hello, %s.\n", s);
+	return 0;
+EOF
+
+test_expect_success 'grep --hunk-heading --break' '
+	git grep -e Hello -A1 --hunk-heading --break >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+one.c
+-- 4 --
+	printf("Hello world.\n");
+	return 0;
+--
+two.c
+-- 3 --
+	printf("Hello, %d.\n", x);
+	return 0;
+-- 9 --
+	printf("Hello, %s.\n", s);
+	return 0;
+EOF
+
+test_expect_success 'grep --hunk-heading --heading' '
+	git grep -e Hello -A1 --hunk-heading --heading >actual &&
+	test_cmp expected actual
+'
+
+mv expected expected.old
+sed -e 's/^--$//' expected.old > expected
+rm expected.old
+
+test_expect_success 'grep --hunk-heading --heading --break' '
+	git grep -e Hello -A1 --hunk-heading --heading --break >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+-- one.c --
+4:	printf("Hello world.\n");
+5-	return 0;
+-- two.c --
+3:	printf("Hello, %d.\n", x);
+4-	return 0;
+-- two.c --
+9:	printf("Hello, %s.\n", s);
+10-	return 0;
+EOF
+
+test_expect_success 'grep --hunk-heading -n' '
+	git grep -e Hello -A1 --hunk-heading -n >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+one.c
+--
+4:	printf("Hello world.\n");
+5-	return 0;
+--
+two.c
+--
+3:	printf("Hello, %d.\n", x);
+4-	return 0;
+--
+9:	printf("Hello, %s.\n", s);
+10-	return 0;
+EOF
+
+test_expect_success 'grep --hunk-heading --heading -n' '
+	git grep -e Hello -A1 --hunk-heading --heading -n >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.9.2
