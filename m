From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v10 1/5] Refactor parse_loc
Date: Thu, 28 Mar 2013 17:47:30 +0100
Message-ID: <7d892893f6651ac2c1b026b224b2f6e1f6771547.1364488205.git.trast@inf.ethz.ch>
References: <cover.1364488205.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:48:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFzl-0003sx-CR
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806Ab3C1Qrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:47:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:14138 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756759Ab3C1Qri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:47:38 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:29 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:35 +0100
X-Mailer: git-send-email 1.8.2.446.g2b4de83
In-Reply-To: <cover.1364488205.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219430>

From: Bo Yang <struggleyb.nku@gmail.com>

We want to use the same style of -L n,m argument for 'git log -L' as
for git-blame.  Refactor the argument parsing of the range arguments
from builtin/blame.c to the (new) file that will hold the 'git log -L'
logic.

To accommodate different data structures in blame and log -L, the file
contents are abstracted away; parse_range_arg takes a callback that it
uses to get the contents of a line of the (notional) file.

The new test is for a case that made me pause during debugging: the
'blame -L with invalid end' test was the only one that noticed an
outright failure to parse the end *at all*.  So make a more explicit
test for that.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/blame-options.txt     | 19 +------
 Documentation/line-range-format.txt | 18 +++++++
 Makefile                            |  2 +
 builtin/blame.c                     | 99 +++----------------------------------
 line-range.c                        | 92 ++++++++++++++++++++++++++++++++++
 line-range.h                        | 24 +++++++++
 t/t8003-blame-corner-cases.sh       |  6 +++
 7 files changed, 151 insertions(+), 109 deletions(-)
 create mode 100644 Documentation/line-range-format.txt
 create mode 100644 line-range.c
 create mode 100644 line-range.h

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index b0d31df..6998d9f 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -13,24 +13,7 @@
 	Annotate only the given line range.  <start> and <end> can take
 	one of these forms:
 
-	- number
-+
-If <start> or <end> is a number, it specifies an
-absolute line number (lines count from 1).
-+
-
-- /regex/
-+
-This form will use the first line matching the given
-POSIX regex.  If <end> is a regex, it will search
-starting at the line given by <start>.
-+
-
-- +offset or -offset
-+
-This is only valid for <end> and will specify a number
-of lines before or after the line given by <start>.
-+
+include::line-range-format.txt[]
 
 -l::
 	Show long rev (Default: off).
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
new file mode 100644
index 0000000..265bc23
--- /dev/null
+++ b/Documentation/line-range-format.txt
@@ -0,0 +1,18 @@
+- number
++
+If <start> or <end> is a number, it specifies an
+absolute line number (lines count from 1).
++
+
+- /regex/
++
+This form will use the first line matching the given
+POSIX regex.  If <end> is a regex, it will search
+starting at the line given by <start>.
++
+
+- +offset or -offset
++
+This is only valid for <end> and will specify a number
+of lines before or after the line given by <start>.
++
diff --git a/Makefile b/Makefile
index 598d631..e83f64b 100644
--- a/Makefile
+++ b/Makefile
@@ -667,6 +667,7 @@ LIB_H += help.h
 LIB_H += http.h
 LIB_H += kwset.h
 LIB_H += levenshtein.h
+LIB_H += line-range.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
@@ -795,6 +796,7 @@ LIB_OBJS += hex.o
 LIB_OBJS += ident.o
 LIB_OBJS += kwset.o
 LIB_OBJS += levenshtein.o
+LIB_OBJS += line-range.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
diff --git a/builtin/blame.c b/builtin/blame.c
index 86100e9..20eb439 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -21,6 +21,7 @@
 #include "parse-options.h"
 #include "utf8.h"
 #include "userdiff.h"
+#include "line-range.h"
 
 static char blame_usage[] = N_("git blame [options] [rev-opts] [rev] [--] file");
 
@@ -566,11 +567,16 @@ static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
 	dst->score = 0;
 }
 
-static const char *nth_line(struct scoreboard *sb, int lno)
+static const char *nth_line(struct scoreboard *sb, long lno)
 {
 	return sb->final_buf + sb->lineno[lno];
 }
 
+static const char *nth_line_cb(void *data, long lno)
+{
+	return nth_line((struct scoreboard *)data, lno);
+}
+
 /*
  * It is known that lines between tlno to same came from parent, and e
  * has an overlap with that range.  it also is known that parent's
@@ -1927,83 +1933,6 @@ static const char *add_prefix(const char *prefix, const char *path)
 }
 
 /*
- * Parsing of (comma separated) one item in the -L option
- */
-static const char *parse_loc(const char *spec,
-			     struct scoreboard *sb, long lno,
-			     long begin, long *ret)
-{
-	char *term;
-	const char *line;
-	long num;
-	int reg_error;
-	regex_t regexp;
-	regmatch_t match[1];
-
-	/* Allow "-L <something>,+20" to mean starting at <something>
-	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
-	 * <something>.
-	 */
-	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
-		num = strtol(spec + 1, &term, 10);
-		if (term != spec + 1) {
-			if (spec[0] == '-')
-				num = 0 - num;
-			if (0 < num)
-				*ret = begin + num - 2;
-			else if (!num)
-				*ret = begin;
-			else
-				*ret = begin + num;
-			return term;
-		}
-		return spec;
-	}
-	num = strtol(spec, &term, 10);
-	if (term != spec) {
-		*ret = num;
-		return term;
-	}
-	if (spec[0] != '/')
-		return spec;
-
-	/* it could be a regexp of form /.../ */
-	for (term = (char *) spec + 1; *term && *term != '/'; term++) {
-		if (*term == '\\')
-			term++;
-	}
-	if (*term != '/')
-		return spec;
-
-	/* try [spec+1 .. term-1] as regexp */
-	*term = 0;
-	begin--; /* input is in human terms */
-	line = nth_line(sb, begin);
-
-	if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
-	    !(reg_error = regexec(&regexp, line, 1, match, 0))) {
-		const char *cp = line + match[0].rm_so;
-		const char *nline;
-
-		while (begin++ < lno) {
-			nline = nth_line(sb, begin);
-			if (line <= cp && cp < nline)
-				break;
-			line = nline;
-		}
-		*ret = begin;
-		regfree(&regexp);
-		*term++ = '/';
-		return term;
-	}
-	else {
-		char errbuf[1024];
-		regerror(reg_error, &regexp, errbuf, 1024);
-		die("-L parameter '%s': %s", spec + 1, errbuf);
-	}
-}
-
-/*
  * Parsing of -L option
  */
 static void prepare_blame_range(struct scoreboard *sb,
@@ -2011,15 +1940,7 @@ static void prepare_blame_range(struct scoreboard *sb,
 				long lno,
 				long *bottom, long *top)
 {
-	const char *term;
-
-	term = parse_loc(bottomtop, sb, lno, 1, bottom);
-	if (*term == ',') {
-		term = parse_loc(term + 1, sb, lno, *bottom + 1, top);
-		if (*term)
-			usage(blame_usage);
-	}
-	if (*term)
+	if (parse_range_arg(bottomtop, nth_line_cb, sb, lno, bottom, top))
 		usage(blame_usage);
 }
 
@@ -2569,10 +2490,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	bottom = top = 0;
 	if (bottomtop)
 		prepare_blame_range(&sb, bottomtop, lno, &bottom, &top);
-	if (bottom && top && top < bottom) {
-		long tmp;
-		tmp = top; top = bottom; bottom = tmp;
-	}
 	if (bottom < 1)
 		bottom = 1;
 	if (top < 1)
diff --git a/line-range.c b/line-range.c
new file mode 100644
index 0000000..5a226ab
--- /dev/null
+++ b/line-range.c
@@ -0,0 +1,92 @@
+#include "git-compat-util.h"
+#include "line-range.h"
+
+/*
+ * Parse one item in the -L option
+ */
+static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
+			     void *data, long lines, long begin, long *ret)
+{
+	char *term;
+	const char *line;
+	long num;
+	int reg_error;
+	regex_t regexp;
+	regmatch_t match[1];
+
+	/* Allow "-L <something>,+20" to mean starting at <something>
+	 * for 20 lines, or "-L <something>,-5" for 5 lines ending at
+	 * <something>.
+	 */
+	if (1 < begin && (spec[0] == '+' || spec[0] == '-')) {
+		num = strtol(spec + 1, &term, 10);
+		if (term != spec + 1) {
+			if (spec[0] == '-')
+				num = 0 - num;
+			if (0 < num)
+				*ret = begin + num - 2;
+			else if (!num)
+				*ret = begin;
+			else
+				*ret = begin + num;
+			return term;
+		}
+		return spec;
+	}
+	num = strtol(spec, &term, 10);
+	if (term != spec) {
+		*ret = num;
+		return term;
+	}
+	if (spec[0] != '/')
+		return spec;
+
+	/* it could be a regexp of form /.../ */
+	for (term = (char *) spec + 1; *term && *term != '/'; term++) {
+		if (*term == '\\')
+			term++;
+	}
+	if (*term != '/')
+		return spec;
+
+	/* try [spec+1 .. term-1] as regexp */
+	*term = 0;
+	begin--; /* input is in human terms */
+	line = nth_line(data, begin);
+
+	if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
+	    !(reg_error = regexec(&regexp, line, 1, match, 0))) {
+		const char *cp = line + match[0].rm_so;
+		const char *nline;
+
+		while (begin++ < lines) {
+			nline = nth_line(data, begin);
+			if (line <= cp && cp < nline)
+				break;
+			line = nline;
+		}
+		*ret = begin;
+		regfree(&regexp);
+		*term++ = '/';
+		return term;
+	}
+	else {
+		char errbuf[1024];
+		regerror(reg_error, &regexp, errbuf, 1024);
+		die("-L parameter '%s': %s", spec + 1, errbuf);
+	}
+}
+
+int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
+		    void *cb_data, long lines, long *begin, long *end)
+{
+	arg = parse_loc(arg, nth_line_cb, cb_data, lines, 1, begin);
+
+	if (*arg == ',')
+		arg = parse_loc(arg + 1, nth_line_cb, cb_data, lines, *begin + 1, end);
+
+	if (*arg)
+		return -1;
+
+	return 0;
+}
diff --git a/line-range.h b/line-range.h
new file mode 100644
index 0000000..830f25b
--- /dev/null
+++ b/line-range.h
@@ -0,0 +1,24 @@
+#ifndef LINE_RANGE_H
+#define LINE_RANGE_H
+
+/*
+ * Parse one item in an -L begin,end option w.r.t. the notional file
+ * object 'cb_data' consisting of 'lines' lines.
+ *
+ * The 'nth_line_cb' callback is used to determine the start of the
+ * line 'lno' inside the 'cb_data'.  The caller is expected to already
+ * have a suitable map at hand to make this a constant-time lookup.
+ *
+ * Returns 0 in case of success and -1 if there was an error.  The
+ * actual range is stored in *begin and *end.  The counting starts
+ * at 1!  In case of error, the caller should show usage message.
+ */
+
+typedef const char *(*nth_line_fn_t)(void *data, long lno);
+
+extern int parse_range_arg(const char *arg,
+			   nth_line_fn_t nth_line_cb,
+			   void *cb_data, long lines,
+			   long *begin, long *end);
+
+#endif /* LINE_RANGE_H */
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 230143c..e7cac1d 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -175,6 +175,12 @@ test_expect_success 'blame -L with invalid end' '
 	grep "has only 2 lines" errors
 '
 
+test_expect_success 'blame parses <end> part of -L' '
+	git blame -L1,1 tres >out &&
+	cat out &&
+	test $(wc -l < out) -eq 1
+'
+
 test_expect_success 'indent of line numbers, nine lines' '
 	git blame nine_lines >actual &&
 	test $(grep -c "  " actual) = 0
-- 
1.8.2.446.g2b4de83
