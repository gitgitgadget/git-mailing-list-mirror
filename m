From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] WIP per-path attribute based hunk header selection.
Date: Wed, 04 Jul 2007 22:02:35 -0700
Message-ID: <7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 07:02:41 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6JUG-0004Kf-Uq
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 07:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbXGEFCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 01:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752434AbXGEFCi
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 01:02:38 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46208 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbXGEFCh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 01:02:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705050237.UVXZ17683.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 5 Jul 2007 01:02:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kh2b1X00M1kojtg0000000; Thu, 05 Jul 2007 01:02:36 -0400
In-Reply-To: <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 04 Jul 2007 22:00:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51656>

This makes"diff -p" hunk headers customizable via gitattributes mechanism.
It is based on Johannes's earlier patch that allowed to define a single
regexp to be used for everything.

The mechanism to arrive at the regexp that is used to define hunk header
is the same as other use of gitattributes.  You assign an attribute, funcname
(because "diff -p" typically uses the name of the function the patch is about
as the hunk header), a simple string value.  This can be one of the names of
built-in pattern (currently, "java" is defined) or a custom pattern name, to
be looked up from the configuration file.

  (in .gitattributes)
  *.java   funcname=java
  *.perl   funcname=perl

  (in .git/config)
  [funcname]
    java = ... # ugly and complicated regexp to override the built-in one.
    perl = ... # another ugly and complicated regexp to define a new one.

This is still a WIP in that the code to look-up the configuration is not there
yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                   |  121 +++++++++++++++++++++++++++++++++-------------
 diffcore-delta.c         |    2 +-
 diffcore.h               |    3 +
 t/t4018-diff-funcname.sh |   63 ++++++++++++++++++++++++
 xdiff-interface.c        |   71 +++++++++++++++++++++++++++
 xdiff-interface.h        |    2 +
 xdiff/xdiff.h            |    4 ++
 xdiff/xemit.c            |   37 +++++++++-----
 8 files changed, 254 insertions(+), 49 deletions(-)
 create mode 100644 t/t4018-diff-funcname.sh

diff --git a/diff.c b/diff.c
index 552f7c0..0c7d2c6 100644
--- a/diff.c
+++ b/diff.c
@@ -1101,31 +1101,91 @@ static void emit_binary_diff(mmfile_t *one, mmfile_t *two)
 static void setup_diff_attr_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_diff;
+	static struct git_attr *attr_diff_func_name;
 
-	if (!attr_diff)
+	if (!attr_diff) {
 		attr_diff = git_attr("diff", 4);
-	check->attr = attr_diff;
+		attr_diff_func_name = git_attr("funcname", 8);
+	}
+	check[0].attr = attr_diff;
+	check[1].attr = attr_diff_func_name;
 }
 
-static int file_is_binary(struct diff_filespec *one)
+static void diff_filespec_check_attr(struct diff_filespec *one)
 {
-	struct git_attr_check attr_diff_check;
+	struct git_attr_check attr_diff_check[2];
 
-	setup_diff_attr_check(&attr_diff_check);
-	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
-		const char *value = attr_diff_check.value;
+	if (one->checked_attr)
+		return;
+
+	setup_diff_attr_check(attr_diff_check);
+	one->is_binary = 0;
+	one->hunk_header_ident = NULL;
+
+	if (!git_checkattr(one->path, ARRAY_SIZE(attr_diff_check), attr_diff_check)) {
+		const char *value;
+
+		/* binaryness */
+		value = attr_diff_check[0].value;
 		if (ATTR_TRUE(value))
-			return 0;
+			;
 		else if (ATTR_FALSE(value))
-			return 1;
+			one->is_binary = 1;
+
+		/* hunk header ident */
+		value = attr_diff_check[1].value;
+		if (ATTR_TRUE(value) || ATTR_FALSE(value) || ATTR_UNSET(value))
+			;
+		else
+			one->hunk_header_ident = value;
 	}
 
-	if (!one->data) {
-		if (!DIFF_FILE_VALID(one))
-			return 0;
+	if (!one->data && DIFF_FILE_VALID(one))
 		diff_populate_filespec(one, 0);
+
+	if (one->data)
+		one->is_binary = buffer_is_binary(one->data, one->size);
+
+}
+
+int diff_filespec_is_binary(struct diff_filespec *one)
+{
+	diff_filespec_check_attr(one);
+	return one->is_binary;
+}
+
+static const char *diff_hunk_header_regexp(struct diff_filespec *one)
+{
+	const char *ident;
+
+	diff_filespec_check_attr(one);
+	ident = one->hunk_header_ident;
+
+	if (!ident) {
+		/*
+		 * If the config file has "funcname.default" defined, return
+		 * that regexp here, instead of NULL.
+		 */
+		return NULL;
 	}
-	return buffer_is_binary(one->data, one->size);
+
+	/*
+	 * FIXME: look up custom "funcname.$ident" regexp from config,
+	 * and return it here.
+	 */
+
+
+	/*
+	 * And define built-in fallback patterns here...
+	 */
+	if (!strcmp(ident, "java"))
+		return "!^[ 	]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
+			"new\\|return\\|switch\\|throw\\|while\\)\n"
+			"^[ 	]*\\(\\([ 	]*"
+			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
+			"[ 	]*([^;]*$\\)";
+
+	return NULL;
 }
 
 static void builtin_diff(const char *name_a,
@@ -1182,7 +1242,8 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (!o->text && (file_is_binary(one) || file_is_binary(two))) {
+	if (!o->text &&
+	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
@@ -1201,6 +1262,11 @@ static void builtin_diff(const char *name_a,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
+		const char *hunk_header_regexp;
+
+		hunk_header_regexp = diff_hunk_header_regexp(one);
+		if (!hunk_header_regexp)
+			hunk_header_regexp = diff_hunk_header_regexp(two);
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
@@ -1210,6 +1276,8 @@ static void builtin_diff(const char *name_a,
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
+		if (hunk_header_regexp)
+			xdiff_set_find_func(&xecfg, hunk_header_regexp);
 		if (!diffopts)
 			;
 		else if (!prefixcmp(diffopts, "--unified="))
@@ -1261,7 +1329,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (file_is_binary(one) || file_is_binary(two)) {
+	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
 		data->is_binary = 1;
 		data->added = mf2.size;
 		data->deleted = mf1.size;
@@ -1302,7 +1370,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (file_is_binary(two))
+	if (diff_filespec_is_binary(two))
 		goto free_and_return;
 	else {
 		/* Crazy xdl interfaces.. */
@@ -1879,8 +1947,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 
 		if (o->binary) {
 			mmfile_t mf;
-			if ((!fill_mmfile(&mf, one) && file_is_binary(one)) ||
-			    (!fill_mmfile(&mf, two) && file_is_binary(two)))
+			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
+			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
 		len += snprintf(msg + len, sizeof(msg) - len,
@@ -2783,7 +2851,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 			return error("unable to read files to diff");
 
 		/* Maybe hash p->two? into the patch id? */
-		if (file_is_binary(p->two))
+		if (diff_filespec_is_binary(p->two))
 			continue;
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
@@ -3011,21 +3079,6 @@ void diffcore_std(struct diff_options *options)
 	if (options->quiet)
 		return;
 
-	/*
-	 * break/rename count similarity differently depending on
-	 * the binary-ness.
-	 */
-	if ((options->break_opt != -1) || (options->detect_rename)) {
-		struct diff_queue_struct *q = &diff_queued_diff;
-		int i;
-
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			p->one->is_binary = file_is_binary(p->one);
-			p->two->is_binary = file_is_binary(p->two);
-		}
-	}
-
 	if (options->break_opt != -1)
 		diffcore_break(options->break_opt);
 	if (options->detect_rename)
diff --git a/diffcore-delta.c b/diffcore-delta.c
index a038b16..d9729e5 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -129,7 +129,7 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 	struct spanhash_top *hash;
 	unsigned char *buf = one->data;
 	unsigned int sz = one->size;
-	int is_text = !one->is_binary;
+	int is_text = !diff_filespec_is_binary(one);
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));
diff --git a/diffcore.h b/diffcore.h
index 0c8abb5..0598514 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -27,6 +27,7 @@ struct diff_filespec {
 	char *path;
 	void *data;
 	void *cnt_data;
+	const void *hunk_header_ident;
 	unsigned long size;
 	int xfrm_flags;		 /* for use by the xfrm */
 	unsigned short mode;	 /* file mode */
@@ -37,6 +38,7 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
+	unsigned checked_attr : 1;
 	unsigned is_binary : 1; /* data should be considered "binary" */
 };
 
@@ -46,6 +48,7 @@ extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 
 extern int diff_populate_filespec(struct diff_filespec *, int);
 extern void diff_free_filespec_data(struct diff_filespec *);
+extern int diff_filespec_is_binary(struct diff_filespec *);
 
 struct diff_filepair {
 	struct diff_filespec *one;
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
new file mode 100644
index 0000000..0689b2f
--- /dev/null
+++ b/t/t4018-diff-funcname.sh
@@ -0,0 +1,63 @@
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
+	echo "*.java funcname=java" >.gitattributes &&
+	git diff Beer.java Beer-correct.java |
+	grep "^@@.*@@ public static void main("
+'
+
+test_done
+
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
index e407cf1..be866d1 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -129,3 +129,74 @@ int buffer_is_binary(const char *ptr, unsigned long size)
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
+			die("Invalid regexp to look for hunk header: %s", expression);
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
index 4b6e639..d3d9c84 100644
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
+			 *rec == '$')) { /* identifiers from VMS and other esoterico */
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
1.5.3.rc0.818.ga2b52
