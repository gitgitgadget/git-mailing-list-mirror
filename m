From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/6] grep: add option -p/--show-function
Date: Thu, 02 Jul 2009 00:06:34 +0200
Message-ID: <4A4BDDEA.3030005@lsrfire.ath.cx>
References: <4A4BDC65.80504@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 02 00:06:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM7ww-000486-CT
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 00:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZGAWGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 18:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZGAWGc
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 18:06:32 -0400
Received: from india601.server4you.de ([85.25.151.105]:55628 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbZGAWGb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 18:06:31 -0400
Received: from [10.0.1.101] (p57B7FA76.dip.t-dialin.net [87.183.250.118])
	by india601.server4you.de (Postfix) with ESMTPSA id BF9262F8068;
	Thu,  2 Jul 2009 00:06:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <4A4BDC65.80504@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122607>

The new option -p instructs git grep to print the previous function
definition as a context line, similar to diff -p.  Such context lines
are marked with an equal sign instead of a dash.  This option
complements the existing context options -A, -B, -C.

Function definitions are detected using the same heuristic that diff
uses.  User defined regular expressions are not supported, yet.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-grep.txt |    5 +++
 builtin-grep.c             |    8 +++--
 grep.c                     |   61 ++++++++++++++++++++++++++++++++++++++------
 grep.h                     |    1 +
 t/t7002-grep.sh            |   36 ++++++++++++++++++++++++-
 5 files changed, 98 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index fccb82d..b3bb283 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -122,6 +122,11 @@ OPTIONS
 -<num>::
 	A shortcut for specifying -C<num>.
 
+-p::
+--show-function::
+	Show the preceding line that contains the function name of
+	the match, unless the matching line is a function name itself.
+
 -f <file>::
 	Read patterns from <file>, one per line.
 
diff --git a/builtin-grep.c b/builtin-grep.c
index 48998af..037452e 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -278,13 +278,13 @@ static int flush_grep(struct grep_opt *opt,
 		argc -= 2;
 	}
 
-	if (opt->pre_context || opt->post_context) {
+	if (opt->pre_context || opt->post_context || opt->funcname) {
 		/*
 		 * grep handles hunk marks between files, but we need to
 		 * do that ourselves between multiple calls.
 		 */
 		if (opt->show_hunk_mark)
-			write_or_die(1, "--\n", 3);
+			write_or_die(1, opt->funcname ? "==\n" : "--\n", 3);
 		else
 			opt->show_hunk_mark = 1;
 	}
@@ -721,6 +721,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"show <n> context lines after matches"),
 		OPT_NUMBER_CALLBACK(&opt, "shortcut for -C NUM",
 			context_callback),
+		OPT_BOOLEAN('p', "show-function", &opt.funcname,
+			"show a line with the function name before matches"),
 		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, "file",
 			"read patterns from file", file_callback),
@@ -789,7 +791,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 
-	if (opt.color && !opt.color_external)
+	if ((opt.color && !opt.color_external) || opt.funcname)
 		external_grep_allowed = 0;
 	if (!opt.pattern_list)
 		die("no pattern given.");
diff --git a/grep.c b/grep.c
index 9b9d2e3..3a5c138 100644
--- a/grep.c
+++ b/grep.c
@@ -490,14 +490,18 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 {
 	int rest = eol - bol;
 
-	if (opt->pre_context || opt->post_context) {
+	if (opt->pre_context || opt->post_context || opt->funcname) {
 		if (opt->last_shown == 0) {
 			if (opt->show_hunk_mark)
-				fputs("--\n", stdout);
+				fputs(opt->funcname ? "==\n" : "--\n", stdout);
 			else
 				opt->show_hunk_mark = 1;
-		} else if (lno > opt->last_shown + 1)
-			fputs("--\n", stdout);
+		} else if (lno > opt->last_shown + 1) {
+			if (opt->pre_context || opt->post_context)
+				fputs((sign == '=') ? "==\n" : "--\n", stdout);
+			else if (sign == '=')
+				fputs("==\n", stdout);
+		}
 	}
 	opt->last_shown = lno;
 
@@ -531,10 +535,40 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 	printf("%.*s\n", rest, bol);
 }
 
+static int match_funcname(char *bol, char *eol)
+{
+	if (bol == eol)
+		return 0;
+	if (isalpha(*bol) || *bol == '_' || *bol == '$')
+		return 1;
+	return 0;
+}
+
+static void show_funcname_line(struct grep_opt *opt, const char *name,
+			       char *buf, char *bol, unsigned lno)
+{
+	while (bol > buf) {
+		char *eol = --bol;
+
+		while (bol > buf && bol[-1] != '\n')
+			bol--;
+		lno--;
+
+		if (lno <= opt->last_shown)
+			break;
+
+		if (match_funcname(bol, eol)) {
+			show_line(opt, bol, eol, name, lno, '=');
+			break;
+		}
+	}
+}
+
 static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 			     char *bol, unsigned lno)
 {
-	unsigned cur = lno, from = 1;
+	unsigned cur = lno, from = 1, funcname_lno = 0;
+	int funcname_needed = opt->funcname;
 
 	if (opt->pre_context < lno)
 		from = lno - opt->pre_context;
@@ -543,19 +577,28 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 
 	/* Rewind. */
 	while (bol > buf && cur > from) {
-		bol--;
+		char *eol = --bol;
+
 		while (bol > buf && bol[-1] != '\n')
 			bol--;
 		cur--;
+		if (funcname_needed && match_funcname(bol, eol)) {
+			funcname_lno = cur;
+			funcname_needed = 0;
+		}
 	}
 
+	/* We need to look even further back to find a function signature. */
+	if (opt->funcname && funcname_needed)
+		show_funcname_line(opt, name, buf, bol, cur);
+
 	/* Back forward. */
 	while (cur < lno) {
-		char *eol = bol;
+		char *eol = bol, sign = (cur == funcname_lno) ? '=' : '-';
 
 		while (*eol != '\n')
 			eol++;
-		show_line(opt, bol, eol, name, cur, '-');
+		show_line(opt, bol, eol, name, cur, sign);
 		bol = eol + 1;
 		cur++;
 	}
@@ -635,6 +678,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 */
 			if (opt->pre_context)
 				show_pre_context(opt, name, buf, bol, lno);
+			else if (opt->funcname)
+				show_funcname_line(opt, name, buf, bol, lno);
 			if (!opt->count)
 				show_line(opt, bol, eol, name, lno, ':');
 			last_hit = lno;
diff --git a/grep.h b/grep.h
index 730ffd6..3f75e3a 100644
--- a/grep.h
+++ b/grep.h
@@ -79,6 +79,7 @@ struct grep_opt {
 	int pathname;
 	int null_following_name;
 	int color;
+	int funcname;
 	char color_match[COLOR_MAXLEN];
 	const char *color_external;
 	int regflags;
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 155bfdb..ef59ab9 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -8,6 +8,15 @@ test_description='git grep various.
 
 . ./test-lib.sh
 
+cat >hello.c <<EOF
+#include <stdio.h>
+int main(int argc, const char **argv)
+{
+	printf("Hello world.\n");
+	return 0;
+}
+EOF
+
 test_expect_success setup '
 	{
 		echo foo mmap bar
@@ -22,7 +31,7 @@ test_expect_success setup '
 	echo zzz > z &&
 	mkdir t &&
 	echo test >t/t &&
-	git add file w x y z t/t &&
+	git add file w x y z t/t hello.c &&
 	test_tick &&
 	git commit -m initial
 '
@@ -229,9 +238,32 @@ test_expect_success 'log grep (6)' '
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
-	test "$(git grep --no-ext-grep t)" = "t/t:test" &&
+	test "$(git grep --no-ext-grep test)" = "t/t:test" &&
 	git update-index --no-assume-unchanged t/t &&
 	git checkout t/t
 '
 
+cat >expected <<EOF
+hello.c=int main(int argc, const char **argv)
+hello.c:	return 0;
+EOF
+
+test_expect_success 'grep -p' '
+	git grep -p return >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+hello.c-#include <stdio.h>
+hello.c=int main(int argc, const char **argv)
+hello.c-{
+hello.c-	printf("Hello world.\n");
+hello.c:	return 0;
+EOF
+
+test_expect_success 'grep -p -B5' '
+	git grep -p -B5 return >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.6.3.3
