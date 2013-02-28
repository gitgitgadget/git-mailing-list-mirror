From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v8 5/5] log -L: :pattern:file syntax to find by funcname
Date: Thu, 28 Feb 2013 17:38:23 +0100
Message-ID: <eba9760baed7fef88c469544730e22fd8adb1748.1362069310.git.trast@student.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 17:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB6Vj-00027G-PO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 17:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594Ab3B1Qil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 11:38:41 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:31191 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932404Ab3B1Qid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 11:38:33 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 17:38:23 +0100
Received: from pctrast.inf.ethz.ch (213.55.184.243) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 17:38:30 +0100
X-Mailer: git-send-email 1.8.2.rc1.388.g1bd82c8
In-Reply-To: <cover.1362069310.git.trast@student.ethz.ch>
X-Originating-IP: [213.55.184.243]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217238>

This new syntax finds a funcname matching /pattern/, and then takes from there
up to (but not including) the next funcname.  So you can say

  git log -L:main:main.c

and it will dig up the main() function and show its line-log, provided
there are no other funcnames matching 'main'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/line-range-format.txt |   7 ++
 builtin/blame.c                     |   2 +-
 line-log.c                          | 130 +++++++++++++++++++++++++++++++++++-
 line-log.h                          |   3 +-
 t/t4211-line-log.sh                 |   3 +-
 t/t4211/expect.simple-f-to-main     | 100 +++++++++++++++++++++++++++
 t/t4211/expect.simple-main-to-end   |  70 +++++++++++++++++++
 7 files changed, 310 insertions(+), 5 deletions(-)
 create mode 100644 t/t4211/expect.simple-f-to-main
 create mode 100644 t/t4211/expect.simple-main-to-end

diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 9ce0688..5279a76 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -22,3 +22,10 @@ of lines before or after the line given by <start>.
 A literal dollar sign can be used as a shorthand for the last line in
 the file.
 +
+
+- :regex
++
+If the entire range is of the form :regex, it denotes the range from
+the first funcname line that matches <regex>, up to the next funcname
+line.
++
diff --git a/builtin/blame.c b/builtin/blame.c
index c933b15..b7d210f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1940,7 +1940,7 @@ static void prepare_blame_range(struct scoreboard *sb,
 				long lno,
 				long *bottom, long *top)
 {
-	if (parse_range_arg(bottomtop, nth_line_cb, sb, lno, bottom, top))
+	if (parse_range_arg(bottomtop, nth_line_cb, sb, lno, bottom, top, sb->path))
 		usage(blame_usage);
 }
 
diff --git a/line-log.c b/line-log.c
index 789b7c4..a74bbaf 100644
--- a/line-log.c
+++ b/line-log.c
@@ -11,6 +11,7 @@
 #include "strbuf.h"
 #include "log-tree.h"
 #include "graph.h"
+#include "userdiff.h"
 #include "line-log.h"
 
 void range_set_grow (struct range_set *rs, size_t extra)
@@ -531,9 +532,130 @@ const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
 	}
 }
 
+static int match_funcname(xdemitconf_t *xecfg, const char *bol, const char *eol)
+{
+	if (xecfg) {
+		char buf[1];
+		return xecfg->find_func(bol, eol - bol, buf, 1,
+					xecfg->find_func_priv) >= 0;
+	}
+
+	if (bol == eol)
+		return 0;
+	if (isalpha(*bol) || *bol == '_' || *bol == '$')
+		return 1;
+	return 0;
+}
+
+static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char *start,
+						 regex_t *regexp)
+{
+	int reg_error;
+	regmatch_t match[1];
+	while (1) {
+		const char *bol, *eol;
+		reg_error = regexec(regexp, start, 1, match, 0);
+		if (reg_error == REG_NOMATCH)
+			return NULL;
+		else if (reg_error) {
+			char errbuf[1024];
+			regerror(reg_error, regexp, errbuf, 1024);
+			die("-L parameter: regexec() failed: %s", errbuf);
+		}
+		/* determine extent of line matched */
+		bol = start+match[0].rm_so;
+		eol = start+match[0].rm_eo;
+		while (bol > start && *bol != '\n')
+			bol--;
+		if (*bol == '\n')
+			bol++;
+		while (*eol && *eol != '\n')
+			eol++;
+		if (*eol == '\n')
+			eol++;
+		/* is it a funcname line? */
+		if (match_funcname(xecfg, (char*) bol, (char*) eol))
+			return bol;
+		start = eol;
+	}
+}
+
+static const char *parse_range_funcname(const char *arg, nth_line_fn_t nth_line_cb,
+					void *cb_data, long lines, long *begin, long *end,
+					const char *path)
+{
+	const char *pattern;
+	const char *term;
+	struct userdiff_driver *drv;
+	xdemitconf_t *xecfg = NULL;
+	const char *start;
+	const char *p;
+	int reg_error;
+	regex_t regexp;
+
+	pattern = arg+1;
+	term = (char*) strchr(pattern, ':');
+	if (term) {
+		assert(!begin);
+		return term;
+	}
+	/* all of the rest is the regex */
+	term = pattern + strlen(pattern);
+
+	start = nth_line_cb(cb_data, 0);
+
+	drv = userdiff_find_by_path(path);
+	if (drv && drv->funcname.pattern) {
+		const struct userdiff_funcname *pe = &drv->funcname;
+		xecfg = xcalloc(1, sizeof(*xecfg));
+		xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
+	}
+
+	reg_error = regcomp(&regexp, pattern, REG_NEWLINE);
+	if (reg_error) {
+		char errbuf[1024];
+		regerror(reg_error, &regexp, errbuf, 1024);
+		die("-L parameter '%s': %s", pattern, errbuf);
+	}
+
+	p = find_funcname_matching_regexp(xecfg, (char*) start, &regexp);
+	if (!p)
+		die("-L parameter '%s': no match", pattern);
+	*begin = 0;
+	while (p > nth_line_cb(cb_data, *begin))
+		(*begin)++;
+
+	if (*begin >= lines)
+		die("-L parameter '%s' matches at EOF", pattern);
+
+	*end = *begin+1;
+	while (*end < lines) {
+		const char *bol = nth_line_cb(cb_data, *end);
+		const char *eol = nth_line_cb(cb_data, *end+1);
+		if (match_funcname(xecfg, bol, eol))
+			break;
+		(*end)++;
+	}
+
+	regfree(&regexp);
+	free(xecfg);
+
+	/* compensate for 1-based numbering */
+	(*begin)++;
+
+	return term;
+}
+
 int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
-		void *cb_data, long lines, long *begin, long *end)
+		    void *cb_data, long lines, long *begin, long *end,
+		    const char *path)
 {
+	if (*arg == ':') {
+		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, begin, end, path);
+		if (*arg)
+			return -1;
+	}
+
 	arg = parse_loc(arg, nth_line_cb, cb_data, lines, -1, begin);
 
 	if (*arg == ',') {
@@ -553,6 +675,9 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 
 const char *skip_range_arg(const char *arg)
 {
+	if (*arg == ':')
+		return parse_range_funcname(arg, NULL, NULL, 0, NULL, NULL, NULL);
+
 	arg = parse_loc(arg, NULL, NULL, 0, -1, 0);
 
 	if (*arg == ',')
@@ -681,7 +806,8 @@ static const char *nth_line(void *data, long line)
 		cb_data.line_ends = ends;
 
 		if (parse_range_arg(range_part, nth_line, &cb_data,
-				    lines, &begin, &end))
+				    lines, &begin, &end,
+				    spec->path))
 			die("malformed -L argument '%s'", range_part);
 		if (begin < 1)
 			begin = 1;
diff --git a/line-log.h b/line-log.h
index e3ec094..071e739 100644
--- a/line-log.h
+++ b/line-log.h
@@ -20,7 +20,8 @@
 extern int parse_range_arg(const char *arg,
 			   nth_line_fn_t nth_line_cb,
 			   void *cb_data, long lines,
-			   long *begin, long *end);
+			   long *begin, long *end,
+			   const char *path);
 
 /*
  * Scan past a range argument that could be parsed by
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 639a16f..d488690 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -13,14 +13,15 @@ canned_test () {
 		git log $1 >actual &&
 		test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$2 actual
 	"
-	cp actual "$TEST_DIRECTORY"/t4211/expect.$2
 }
 
 canned_test "-L 4,12:a.c simple" simple-f
 canned_test "-L 4,+9:a.c simple" simple-f
 canned_test "-L '/long f/,/^}/:a.c' simple" simple-f
+canned_test "-L :f:a.c simple" simple-f-to-main
 
 canned_test "-L '/main/,/^}/:a.c' simple" simple-main
+canned_test "-L :main:a.c simple" simple-main-to-end
 
 canned_test "-L 1,+4:a.c simple" beginning-of-file
 canned_test "-L 0,+5:a.c simple" beginning-of-file
diff --git a/t/t4211/expect.simple-f-to-main b/t/t4211/expect.simple-f-to-main
new file mode 100644
index 0000000..a475768
--- /dev/null
+++ b/t/t4211/expect.simple-f-to-main
@@ -0,0 +1,100 @@
+commit 39b6eb2d5b706d3322184a169f666f25ed3fbd00
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:41 2013 +0100
+
+    touch comment
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+ long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+- * A comment.
++ * This is only an example!
+  */
+ 
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,14 +3,14 @@
+-int f(int x)
++long f(long x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
+ 	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit f04fb20f2c77850996cba739709acc6faecc58f7
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:55 2013 +0100
+
+    change f()
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -3,13 +3,14 @@
+ int f(int x)
+ {
+ 	int s = 0;
+ 	while (x) {
+ 		x >>= 1;
+ 		s++;
+ 	}
++	return s;
+ }
+ 
+ /*
+  * A comment.
+  */
+ 
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +3,13 @@
++int f(int x)
++{
++	int s = 0;
++	while (x) {
++		x >>= 1;
++		s++;
++	}
++}
++
++/*
++ * A comment.
++ */
++
diff --git a/t/t4211/expect.simple-main-to-end b/t/t4211/expect.simple-main-to-end
new file mode 100644
index 0000000..8480bd9
--- /dev/null
+++ b/t/t4211/expect.simple-main-to-end
@@ -0,0 +1,70 @@
+commit 4659538844daa2849b1a9e7d6fadb96fcd26fc83
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:43 2013 +0100
+
+    change back to complete line
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,7 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
+\ No newline at end of file
++}
++
++/* incomplete lines are bad! */
+
+commit 100b61a6f2f720f812620a9d10afb3a960ccb73c
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:48:10 2013 +0100
+
+    change to an incomplete line at end
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -18,5 +18,5 @@
+ int main ()
+ {
+ 	printf("%ld\n", f(15));
+ 	return 0;
+-}
++}
+\ No newline at end of file
+
+commit a6eb82647d5d67f893da442f8f9375fd89a3b1e2
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:45:16 2013 +0100
+
+    touch both functions
+
+diff --git a/a.c b/a.c
+--- a/a.c
++++ b/a.c
+@@ -17,5 +17,5 @@
+ int main ()
+ {
+-	printf("%d\n", f(15));
++	printf("%ld\n", f(15));
+ 	return 0;
+ }
+
+commit de4c48ae814792c02a49c4c3c0c757ae69c55f6a
+Author: Thomas Rast <trast@student.ethz.ch>
+Date:   Thu Feb 28 10:44:48 2013 +0100
+
+    initial
+
+diff --git a/a.c b/a.c
+--- /dev/null
++++ b/a.c
+@@ -0,0 +16,5 @@
++int main ()
++{
++	printf("%d\n", f(15));
++	return 0;
++}
-- 
1.8.2.rc1.388.g1bd82c8
