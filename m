From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] diff: add custom regular expressions for function names
Date: Wed, 4 Jul 2007 19:06:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041905570.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 20:06:37 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I69FJ-00015c-Dk
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 20:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbXGDSGb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 14:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbXGDSGb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 14:06:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:51286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754194AbXGDSGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 14:06:30 -0400
Received: (qmail invoked by alias); 04 Jul 2007 18:06:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 04 Jul 2007 20:06:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+zAnsS0yCzbj5So/ILFZpWK1VWDNKtWu7rPn9zBB
	z76LUD/fsh5fIj
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51630>


For convenience, the hunk headers contain function names.  The
heuristics used for that in "git diff" is extremely simple, but
works quite well for most C/C++ and script source code.

However, it usually fails for Java source code.

This patch introduces a config variable diff.functionNameRegexp
which replaces the default heuristics.  If the pattern contains
a group, the match of this group is used for the hunk header
instead of the whole match.

You can give more than one regular expression (all of which have to
match), by separating them with '\n'.  By prefixing an expression
with '!', it is negated, i.e. a non-match is required.  The last
expression is used for the hunk header, and therefore must not be
negated.

A special exception: since Java is so common nowadays, you can set
the config variable to "java", and it will be substituted by a sensible
heuristic.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Yes, I know. .gitattributes integration would be nice. But for now
	I am done with it. I invested way too much time into this.

 Documentation/config.txt |   17 ++++++++++
 diff.c                   |    4 ++
 t/t4018-diff-funcname.sh |   60 +++++++++++++++++++++++++++++++++++
 xdiff-interface.c        |   78 ++++++++++++++++++++++++++++++++++++++++++++++
 xdiff-interface.h        |    2 +
 xdiff/xdiff.h            |    4 ++
 xdiff/xemit.c            |   37 +++++++++++++--------
 7 files changed, 188 insertions(+), 14 deletions(-)
 create mode 100644 t/t4018-diff-funcname.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1d96adf..326e27b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -390,6 +390,23 @@ diff.renames::
 	will enable basic rename detection.  If set to "copies" or
 	"copy", it will detect copies, as well.
 
+diff.functionNameRegexp::
+	Instead of the builtin heuristic to determine the function names
+	for the hunk headers, use the given regular expression to match
+	lines which contain the function name.  If this regular expression
+	contains at least one group, the match of the first group is
+	used, rather than the whole line.
++
+Sometimes, one regular expression is not enough.  Use '\n' to separate
+multiple regular expressions.  All of these expressions have to match,
+and the last one determines the returned function name.  Prefix the
+expression with '!' to require a non-match instead of a match.
++
+As a special exception, the pattern 'java' is substituted with a preset
+pattern which can be expressed as: 'At least two identifiers, followed by
+a "(", and not followed by a ";", and the first identifier must not be a
+reserved keyword such as "new", "return", etc.'
+
 fetch.unpackLimit::
 	If the number of objects fetched over the git native
 	transfer is below this
diff --git a/diff.c b/diff.c
index bea0163..24b66d0 100644
--- a/diff.c
+++ b/diff.c
@@ -131,6 +131,10 @@ int git_diff_ui_config(const char *var, const char *value)
 		color_parse(value, var, diff_colors[slot]);
 		return 0;
 	}
+	if (!prefixcmp(var, "diff.functionnameregexp")) {
+		xdiff_set_find_func(&default_xecfg, value);
+		return 0;
+	}
 
 	return git_default_config(var, value);
 }
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
new file mode 100644
index 0000000..90c6605
--- /dev/null
+++ b/t/t4018-diff-funcname.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Johannes E. Schindelin
+#
+
+test_description='Test custom diff function name patterns'
+
+. ./test-lib.sh
+
+LF='
+'
+
+cat > Beer.java << EOF
+public class Beer
+{
+	int special;
+	public static void main(String args[])
+	{
+		String s=" ";
+		for(int x = 99; x > 0; x--)
+		{
+			System.out.print(x + " bottles of beer on the wall "
+				+ x + " bottles of beer\n"
+				+ "Take one down, pass it around, " + (x - 1)
+				+ " bottles of beer on the wall.\n");
+		}
+		System.out.print("Go to the store, buy some more,\n"
+			+ "99 bottles of beer on the wall.\n");
+	}
+}
+EOF
+
+sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
+
+test_expect_success 'default behaviour' '
+	git diff Beer.java Beer-correct.java |
+	grep "^@@.*@@ public class Beer"
+'
+
+test_expect_success 'preset java pattern' '
+	git config diff.functionnameregexp java &&
+	git diff Beer.java Beer-correct.java |
+	grep "^@@.*@@ public static void main("
+'
+
+git config diff.functionnameregexp '!static
+!String
+[^ 	].*s.*'
+
+test_expect_success 'custom pattern' '
+	git diff Beer.java Beer-correct.java |
+	grep "^@@.*@@ int special;$"
+'
+
+test_expect_success 'last regexp must not be negated' '
+	git config diff.functionnameregexp "!static" &&
+	! git diff Beer.java Beer-correct.java
+'
+
+test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index e407cf1..b0cbd60 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -129,3 +129,81 @@ int buffer_is_binary(const char *ptr, unsigned long size)
 		size = FIRST_FEW_BYTES;
 	return !!memchr(ptr, 0, size);
 }
+
+struct ff_regs {
+	int nr;
+	struct ff_reg {
+		regex_t re;
+		int negate;
+	} *array;
+};
+
+static long ff_regexp(const char *line, long len,
+		char *buffer, long buffer_size, void *priv)
+{
+	char *line_buffer = xstrndup(line, len); /* make NUL terminated */
+	struct ff_regs *regs = priv;
+	regmatch_t pmatch[2];
+	int result = 0, i;
+
+	for (i = 0; i < regs->nr; i++) {
+		struct ff_reg *reg = regs->array + i;
+		if (reg->negate ^ !!regexec(&reg->re,
+					line_buffer, 2, pmatch, 0)) {
+			free(line_buffer);
+			return -1;
+		}
+	}
+	i = pmatch[1].rm_so >= 0 ? 1 : 0;
+	line += pmatch[i].rm_so;
+	result = pmatch[i].rm_eo - pmatch[i].rm_so;
+	if (result > buffer_size)
+		result = buffer_size;
+	else
+		while (result > 0 && (isspace(line[result - 1]) ||
+					line[result - 1] == '\n'))
+			result--;
+	memcpy(buffer, line, result);
+	free(line_buffer);
+	return result;
+}
+
+void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value)
+{
+	int i;
+	struct ff_regs *regs;
+
+	if (!strcmp(value, "java"))
+		value = "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
+				"new\\|return\\|switch\\|throw\\|while\\)\n"
+			"^[ 	]*\\(\\([ 	]*"
+				"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
+				"[ 	]*([^;]*$\\)";
+
+	xecfg->find_func = ff_regexp;
+	regs = xecfg->find_func_priv = xmalloc(sizeof(struct ff_regs));
+	for (i = 0, regs->nr = 1; value[i]; i++)
+		if (value[i] == '\n')
+			regs->nr++;
+	regs->array = xmalloc(regs->nr * sizeof(struct ff_reg));
+	for (i = 0; i < regs->nr; i++) {
+		struct ff_reg *reg = regs->array + i;
+		const char *ep = strchr(value, '\n'), *expression;
+		char *buffer = NULL;
+
+		reg->negate = (*value == '!');
+		if (reg->negate && i == regs->nr - 1)
+			die("Last expression must not be negated: %s", value);
+		if (*value == '!')
+			value++;
+		if (ep)
+			expression = buffer = xstrndup(value, ep - value);
+		else
+			expression = value;
+		if (regcomp(&reg->re, expression, 0))
+			die("Invalid diff.functionNameRegexp: %s", expression);
+		if (buffer)
+			free(buffer);
+		value = ep + 1;
+	}
+}
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 536f4e4..fb742db 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -20,4 +20,6 @@ int parse_hunk_header(char *line, int len,
 int read_mmfile(mmfile_t *ptr, const char *filename);
 int buffer_is_binary(const char *ptr, unsigned long size);
 
+extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line);
+
 #endif
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 9402bb0..c00ddaa 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -73,9 +73,13 @@ typedef struct s_xdemitcb {
 	int (*outf)(void *, mmbuffer_t *, int);
 } xdemitcb_t;
 
+typedef long (*find_func_t)(const char *line, long line_len, char *buffer, long buffer_size, void *priv);
+
 typedef struct s_xdemitconf {
 	long ctxlen;
 	unsigned long flags;
+	find_func_t find_func;
+	void *find_func_priv;
 } xdemitconf_t;
 
 typedef struct s_bdiffparam {
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 4b6e639..7237054 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -69,7 +69,24 @@ static xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
 }
 
 
-static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll) {
+static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
+{
+	if (len > 0 &&
+			(isalpha((unsigned char)*rec) || /* identifier? */
+			 *rec == '_' ||	/* also identifier? */
+			 *rec == '$')) { /* mysterious GNU diff's invention */
+		if (len > sz)
+			len = sz;
+		while (0 < len && isspace((unsigned char)rec[len - 1]))
+			len--;
+		memcpy(buf, rec, len);
+		return len;
+	}
+	return -1;
+}
+
+static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll,
+		find_func_t ff, void *ff_priv) {
 
 	/*
 	 * Be quite stupid about this for now.  Find a line in the old file
@@ -80,22 +97,12 @@ static void xdl_find_func(xdfile_t *xf, long i, char *buf, long sz, long *ll) {
 	const char *rec;
 	long len;
 
-	*ll = 0;
 	while (i-- > 0) {
 		len = xdl_get_rec(xf, i, &rec);
-		if (len > 0 &&
-		    (isalpha((unsigned char)*rec) || /* identifier? */
-		     *rec == '_' ||	/* also identifier? */
-		     *rec == '$')) {	/* mysterious GNU diff's invention */
-			if (len > sz)
-				len = sz;
-			while (0 < len && isspace((unsigned char)rec[len - 1]))
-				len--;
-			memcpy(buf, rec, len);
-			*ll = len;
+		if ((*ll = ff(rec, len, buf, sz, ff_priv)) >= 0)
 			return;
-		}
 	}
+	*ll = 0;
 }
 
 
@@ -120,6 +127,7 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	xdchange_t *xch, *xche;
 	char funcbuf[80];
 	long funclen = 0;
+	find_func_t ff = xecfg->find_func ?  xecfg->find_func : def_ff;
 
 	if (xecfg->flags & XDL_EMIT_COMMON)
 		return xdl_emit_common(xe, xscr, ecb, xecfg);
@@ -143,7 +151,8 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 
 		if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
 			xdl_find_func(&xe->xdf1, s1, funcbuf,
-				      sizeof(funcbuf), &funclen);
+				      sizeof(funcbuf), &funclen,
+				      ff, xecfg->find_func_priv);
 		}
 		if (xdl_emit_hunk_hdr(s1 + 1, e1 - s1, s2 + 1, e2 - s2,
 				      funcbuf, funclen, ecb) < 0)
-- 
1.5.3.rc0.804.g7068
