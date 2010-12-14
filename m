From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/8] Refactor parse_loc
Date: Tue, 14 Dec 2010 03:03:24 +0100
Message-ID: <ff9def9ac3f207b9f9be9c59ec3a313c9b3d4d84.1292291624.git.trast@student.ethz.ch>
References: <cover.1292291624.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bo Yang <struggleyb.nku@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 03:03:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSKEx-0008LJ-5C
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 03:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759036Ab0LNCDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 21:03:36 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:52107 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759007Ab0LNCDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 21:03:35 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:28 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 14 Dec
 2010 03:03:31 +0100
X-Mailer: git-send-email 1.7.3.3.797.g7a32f
In-Reply-To: <cover.1292291624.git.trast@student.ethz.ch>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163612>

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
 Makefile         |    2 +
 builtin/blame.c  |   99 ++++----------------------------------------------
 line.c           |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 line.h           |   23 ++++++++++++
 t/t8003-blame.sh |    6 +++
 5 files changed, 145 insertions(+), 91 deletions(-)
 create mode 100644 line.c
 create mode 100644 line.h

diff --git a/Makefile b/Makefile
index 57d9c65..b015c61 100644
--- a/Makefile
+++ b/Makefile
@@ -519,6 +519,7 @@ LIB_H += grep.h
 LIB_H += hash.h
 LIB_H += help.h
 LIB_H += levenshtein.h
+LIB_H += line.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
@@ -606,6 +607,7 @@ LIB_OBJS += help.o
 LIB_OBJS += hex.o
 LIB_OBJS += ident.o
 LIB_OBJS += levenshtein.o
+LIB_OBJS += line.o
 LIB_OBJS += list-objects.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
diff --git a/builtin/blame.c b/builtin/blame.c
index aa30ec5..5eeddcb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -21,6 +21,7 @@
 #include "parse-options.h"
 #include "utf8.h"
 #include "userdiff.h"
+#include "line.h"
 
 static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
 
@@ -551,11 +552,16 @@ static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
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
@@ -1925,83 +1931,6 @@ static unsigned parse_score(const char *arg)
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
@@ -2009,15 +1938,7 @@ static void prepare_blame_range(struct scoreboard *sb,
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
 
@@ -2504,10 +2425,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
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
diff --git a/line.c b/line.c
new file mode 100644
index 0000000..29898ec
--- /dev/null
+++ b/line.c
@@ -0,0 +1,106 @@
+#include "git-compat-util.h"
+#include "line.h"
+
+/*
+ * Parse one item in the -L option
+ */
+const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
+		void *data, long lines, long begin, long *ret)
+{
+        char *term;
+        const char *line;
+        long num;
+        int reg_error;
+        regex_t regexp;
+        regmatch_t match[1];
+
+        /* Catch the '$' matcher, now it is used to match the last
+         * line of the file. */
+        if (spec[0] == '$') {
+                *ret = lines;
+                return spec + 1;
+        }
+
+        /* Allow "-L <something>,+20" to mean starting at <something>
+         * for 20 lines, or "-L <something>,-5" for 5 lines ending at
+         * <something>.
+         */
+	if (begin != -1 && (spec[0] == '+' || spec[0] == '-')) {
+                num = strtol(spec + 1, &term, 10);
+                if (term != spec + 1) {
+                        if (spec[0] == '-')
+                                num = 0 - num;
+                        if (0 < num)
+                                *ret = begin + num - 2;
+                        else if (!num)
+                                *ret = begin;
+                        else
+                                *ret = begin + num;
+                        return term;
+                }
+                return spec;
+        }
+        num = strtol(spec, &term, 10);
+        if (term != spec) {
+                *ret = num;
+                return term;
+        }
+        if (spec[0] != '/')
+                return spec;
+
+        /* it could be a regexp of form /.../ */
+        for (term = (char *) spec + 1; *term && *term != '/'; term++) {
+                if (*term == '\\')
+                        term++;
+        }
+        if (*term != '/')
+                return spec;
+
+        /* try [spec+1 .. term-1] as regexp */
+        *term = 0;
+	if (begin == -1)
+		begin = 1;
+        begin--; /* input is in human terms */
+        line = nth_line(data, begin);
+
+        if (!(reg_error = regcomp(&regexp, spec + 1, REG_NEWLINE)) &&
+            !(reg_error = regexec(&regexp, line, 1, match, 0))) {
+                const char *cp = line + match[0].rm_so;
+                const char *nline;
+
+                while (begin++ < lines) {
+                        nline = nth_line(data, begin);
+                        if (line <= cp && cp < nline)
+                                break;
+                        line = nline;
+                }
+                *ret = begin;
+                regfree(&regexp);
+                *term++ = '/';
+                return term;
+        } else {
+                char errbuf[1024];
+                regerror(reg_error, &regexp, errbuf, 1024);
+                die("-L parameter '%s': %s", spec + 1, errbuf);
+        }
+}
+
+int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
+		void *cb_data, long lines, long *begin, long *end)
+{
+	arg = parse_loc(arg, nth_line_cb, cb_data, lines, -1, begin);
+
+        if (*arg == ',') {
+		arg = parse_loc(arg+1, nth_line_cb, cb_data, lines, *begin+1, end);
+		if (*begin > *end) {
+			long tmp = *begin;
+			*begin = *end;
+			*end = tmp;
+		}
+        }
+
+        if (*arg)
+                return -1;
+
+	return 0;
+}
diff --git a/line.h b/line.h
new file mode 100644
index 0000000..5878c94
--- /dev/null
+++ b/line.h
@@ -0,0 +1,23 @@
+#ifndef LINE_H
+#define LINE_H
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
+ * caller should print a usage message in the latter case.
+ */
+
+typedef const char *(*nth_line_fn_t)(void *data, long lno);
+
+extern int parse_range_arg(const char *arg,
+			   nth_line_fn_t nth_line_cb,
+			   void *cb_data, long lines,
+			   long *begin, long *end);
+
+#endif /* LINE_H */
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 230143c..51d313e 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -175,6 +175,12 @@ test_expect_success 'blame -L with invalid end' '
 	grep "has only 2 lines" errors
 '
 
+test_expect_success 'blame -L parses end' '
+	git blame -L1,1 tres >out &&
+	cat out &&
+	test $(wc -l < out) -eq 1
+'
+
 test_expect_success 'indent of line numbers, nine lines' '
 	git blame nine_lines >actual &&
 	test $(grep -c "  " actual) = 0
-- 
1.7.3.3.811.g76615
