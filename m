From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v10 4/5] log -L: :pattern:file syntax to find by funcname
Date: Thu, 28 Mar 2013 17:47:33 +0100
Message-ID: <7d0bfc881992c550f57abb2422980324abb56866.1364488205.git.trast@inf.ethz.ch>
References: <cover.1364488205.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Will Palmer" <wmpalmer@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:48:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULG04-0004bT-IG
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823Ab3C1Qro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 12:47:44 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:14138 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756779Ab3C1Qrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:47:43 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:30 +0100
Received: from linux-k42r.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 17:47:36 +0100
X-Mailer: git-send-email 1.8.2.446.g2b4de83
In-Reply-To: <cover.1364488205.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219432>

This new syntax finds a funcname matching /pattern/, and then takes from there
up to (but not including) the next funcname.  So you can say

  git log -L:main:main.c

and it will dig up the main() function and show its line-log, provided
there are no other funcnames matching 'main'.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/blame-options.txt     |   2 +-
 Documentation/git-blame.txt         |   6 +-
 Documentation/git-log.txt           |  11 +--
 Documentation/line-range-format.txt |   7 ++
 builtin/blame.c                     |   2 +-
 line-log.c                          |   5 +-
 line-range.c                        | 136 +++++++++++++++++++++++++++++++++++-
 line-range.h                        |   3 +-
 t/t4211-line-log.sh                 |   4 ++
 t/t4211/expect.simple-f-to-main     | 100 ++++++++++++++++++++++++++
 t/t4211/expect.simple-main-to-end   |  70 +++++++++++++++++++
 11 files changed, 332 insertions(+), 14 deletions(-)
 create mode 100644 t/t4211/expect.simple-f-to-main
 create mode 100644 t/t4211/expect.simple-main-to-end

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 6998d9f..e9f984b 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -9,7 +9,7 @@
 --show-stats::
 	Include additional statistics at the end of blame output.
 
--L <start>,<end>::
+-L <start>,<end>, -L :<regex>::
 	Annotate only the given line range.  <start> and <end> can take
 	one of these forms:
 
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 9a05c2b..6cea7f1 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -8,9 +8,9 @@ git-blame - Show what revision and author last modified each line of a file
 SYNOPSIS
 --------
 [verse]
-'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental] [-L n,m]
-	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>] [--abbrev=<n>]
-	    [<rev> | --contents <file> | --reverse <rev>] [--] <file>
+'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
+	    [-L n,m | -L :fn] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
+	    [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 8727c60..4850226 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -69,12 +69,13 @@ produced by --stat etc.
 	Note that only message is considered, if also a diff is shown
 	its size is not included.
 
--L <start>,<end>:<file>::
+-L <start>,<end>:<file>, -L :<regex>:<file>::
+
 	Trace the evolution of the line range given by "<start>,<end>"
-	within the <file>.  You may not give any pathspec limiters.
-	This is currently limited to a walk starting from a single
-	revision, i.e., you may only give zero or one positive
-	revision arguments.
+	(or the funcname regex <regex>) within the <file>.  You may
+	not give any pathspec limiters.  This is currently limited to
+	a walk starting from a single revision, i.e., you may only
+	give zero or one positive revision arguments.
 
 <start> and <end> can take one of these forms:
 
diff --git a/Documentation/line-range-format.txt b/Documentation/line-range-format.txt
index 265bc23..3e7ce72 100644
--- a/Documentation/line-range-format.txt
+++ b/Documentation/line-range-format.txt
@@ -16,3 +16,10 @@ starting at the line given by <start>.
 This is only valid for <end> and will specify a number
 of lines before or after the line given by <start>.
 +
+
+- :regex
++
+If the option's argument is of the form :regex, it denotes the range
+from the first funcname line that matches <regex>, up to the next
+funcname line.
++
diff --git a/builtin/blame.c b/builtin/blame.c
index 20eb439..1c09d55 100644
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
index 6244231..68972e2 100644
--- a/line-log.c
+++ b/line-log.c
@@ -12,6 +12,7 @@
 #include "strbuf.h"
 #include "log-tree.h"
 #include "graph.h"
+#include "userdiff.h"
 #include "line-log.h"
 
 static void range_set_grow(struct range_set *rs, size_t extra)
@@ -438,7 +439,6 @@ static void range_set_map_across_diff(struct range_set *out,
 	*touched_out = touched;
 }
 
-
 static struct commit *check_single_commit(struct rev_info *revs)
 {
 	struct object *commit = NULL;
@@ -559,7 +559,8 @@ static const char *nth_line(void *data, long line)
 		cb_data.line_ends = ends;
 
 		if (parse_range_arg(range_part, nth_line, &cb_data,
-				    lines, &begin, &end))
+				    lines, &begin, &end,
+				    spec->path))
 			die("malformed -L argument '%s'", range_part);
 		if (begin < 1)
 			begin = 1;
diff --git a/line-range.c b/line-range.c
index 7a7ca3c..8faf943 100644
--- a/line-range.c
+++ b/line-range.c
@@ -1,5 +1,8 @@
 #include "git-compat-util.h"
 #include "line-range.h"
+#include "xdiff-interface.h"
+#include "strbuf.h"
+#include "userdiff.h"
 
 /*
  * Parse one item in the -L option
@@ -84,9 +87,137 @@ static const char *parse_loc(const char *spec, nth_line_fn_t nth_line,
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
+	char *pattern;
+	const char *term;
+	struct userdiff_driver *drv;
+	xdemitconf_t *xecfg = NULL;
+	const char *start;
+	const char *p;
+	int reg_error;
+	regex_t regexp;
+
+	assert(*arg == ':');
+	term = arg+1;
+	while (*term && *term != ':') {
+		if (*term == '\\' && *(term+1))
+			term++;
+		term++;
+	}
+	if (term == arg+1)
+		return NULL;
+	if (!begin) /* skip_range_arg case */
+		return term;
+
+	pattern = xstrndup(arg+1, term-(arg+1));
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
+	free(pattern);
+
+	/* compensate for 1-based numbering */
+	(*begin)++;
+
+	return term;
+}
+
 int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
-		    void *cb_data, long lines, long *begin, long *end)
+		    void *cb_data, long lines, long *begin, long *end,
+		    const char *path)
 {
+	if (*arg == ':') {
+		arg = parse_range_funcname(arg, nth_line_cb, cb_data, lines, begin, end, path);
+		if (!arg || *arg)
+			return -1;
+		return 0;
+	}
+
 	arg = parse_loc(arg, nth_line_cb, cb_data, lines, 1, begin);
 
 	if (*arg == ',')
@@ -100,6 +231,9 @@ int parse_range_arg(const char *arg, nth_line_fn_t nth_line_cb,
 
 const char *skip_range_arg(const char *arg)
 {
+	if (*arg == ':')
+		return parse_range_funcname(arg, NULL, NULL, 0, NULL, NULL, NULL);
+
 	arg = parse_loc(arg, NULL, NULL, 0, -1, NULL);
 
 	if (*arg == ',')
diff --git a/line-range.h b/line-range.h
index 88aaf08..ae3d012 100644
--- a/line-range.h
+++ b/line-range.h
@@ -19,7 +19,8 @@
 extern int parse_range_arg(const char *arg,
 			   nth_line_fn_t nth_line_cb,
 			   void *cb_data, long lines,
-			   long *begin, long *end);
+			   long *begin, long *end,
+			   const char *path);
 
 /*
  * Scan past a range argument that could be parsed by
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 9f36f17..426a828 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -25,8 +25,10 @@ test_bad_opts () {
 canned_test "-L 4,12:a.c simple" simple-f
 canned_test "-L 4,+9:a.c simple" simple-f
 canned_test "-L '/long f/,/^}/:a.c' simple" simple-f
+canned_test "-L :f:a.c simple" simple-f-to-main
 
 canned_test "-L '/main/,/^}/:a.c' simple" simple-main
+canned_test "-L :main:a.c simple" simple-main-to-end
 
 canned_test "-L 1,+4:a.c simple" beginning-of-file
 
@@ -45,5 +47,7 @@ test_bad_opts "-L 1:simple" "There is no path"
 test_bad_opts "-L '/foo:b.c'" "argument.*not of the form"
 test_bad_opts "-L 1000:b.c" "has only.*lines"
 test_bad_opts "-L 1,1000:b.c" "has only.*lines"
+test_bad_opts "-L :b.c" "argument.*not of the form"
+test_bad_opts "-L :foo:b.c" "no match"
 
 test_done
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
1.8.2.446.g2b4de83
