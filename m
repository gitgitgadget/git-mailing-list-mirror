From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/2] diff: add option to show whole functions as context
Date: Sun, 09 Oct 2011 13:36:57 +0200
Message-ID: <4E918759.8020409@lsrfire.ath.cx>
References: <4E9186D9.4060805@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 09 13:37:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCrh2-00004w-EL
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 13:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab1JILhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 07:37:15 -0400
Received: from india601.server4you.de ([85.25.151.105]:56509 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1JILhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 07:37:13 -0400
Received: from [192.168.2.104] (p4FFDBD6A.dip.t-dialin.net [79.253.189.106])
	by india601.server4you.de (Postfix) with ESMTPSA id 027072F8030;
	Sun,  9 Oct 2011 13:37:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <4E9186D9.4060805@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183199>

Add the option -W/--function-context to git diff.  It is similar to
the same option of git grep and expands the context of change hunks
so that the whole surrounding function is shown.  This "natural"
context can allow changes to be understood better.

Note: GNU patch doesn't like diffs generated with the new option;
it seems to expect context lines to be the same before and after
changes.  git apply doesn't complain.

This implementation has the same shortcoming as the one in grep,
namely that there is no way to explicitly find the end of a
function.  That means that a few lines of extra context are shown,
right up to the next recognized function begins.  It's already
useful in its current form, though.


The function get_func_line() in xdiff/xemit.c is extended to work
forward as well as backward to find post-context as well as
pre-context.  It returns the position of the first found matching
line.  The func_line parameter is made optional, as we don't need
it for -W.

The enhanced function is then used in xdl_emit_diff() to extend
the context as needed.  If the added context overlaps with the
next change, it is merged into the current hunk.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/diff-options.txt   |    4 ++
 diff.c                           |    8 +++
 diff.h                           |    1 +
 t/t4051-diff-function-context.sh |   92 ++++++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                    |    1 +
 xdiff/xemit.c                    |   54 ++++++++++++++++++++---
 6 files changed, 154 insertions(+), 6 deletions(-)
 create mode 100644 t/t4051-diff-function-context.sh

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index b620b3a..1ce4ae3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -404,6 +404,10 @@ endif::git-format-patch[]
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
 
+-W::
+--function-context::
+	Show whole surrounding functions of changes.
+
 ifndef::git-format-patch[]
 --exit-code::
 	Make the program exit with codes similar to diff(1).
diff --git a/diff.c b/diff.c
index fcc0078..42c4891 100644
--- a/diff.c
+++ b/diff.c
@@ -2169,6 +2169,8 @@ static void builtin_diff(const char *name_a,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
+		if (DIFF_OPT_TST(o, FUNCCONTEXT))
+			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
 		if (pe)
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
 		if (!diffopts)
@@ -3530,6 +3532,12 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
+	else if (!strcmp(arg, "-W"))
+		DIFF_OPT_SET(options, FUNCCONTEXT);
+	else if (!strcmp(arg, "--function-context"))
+		DIFF_OPT_SET(options, FUNCCONTEXT);
+	else if (!strcmp(arg, "--no-function-context"))
+		DIFF_OPT_CLR(options, FUNCCONTEXT);
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		options->file = fopen(optarg, "w");
 		if (!options->file)
diff --git a/diff.h b/diff.h
index 8c66b59..0c51724 100644
--- a/diff.h
+++ b/diff.h
@@ -79,6 +79,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_IGNORE_DIRTY_SUBMODULES (1 << 26)
 #define DIFF_OPT_OVERRIDE_SUBMODULE_CONFIG (1 << 27)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
+#define DIFF_OPT_FUNCCONTEXT         (1 << 29)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
new file mode 100644
index 0000000..001d678
--- /dev/null
+++ b/t/t4051-diff-function-context.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='diff function context'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/diff-lib.sh
+
+
+cat <<\EOF >hello.c
+#include <stdio.h>
+
+static int a(void)
+{
+	/*
+	 * Dummy.
+	 */
+}
+
+static int hello_world(void)
+{
+	/* Classic. */
+	printf("Hello world.\n");
+
+	/* Success! */
+	return 0;
+}
+static int b(void)
+{
+	/*
+	 * Dummy, too.
+	 */
+}
+
+int main(int argc, char **argv)
+{
+	a();
+	b();
+	return hello_world();
+}
+EOF
+
+test_expect_success 'setup' '
+	git add hello.c &&
+	test_tick &&
+	git commit -m initial &&
+
+	grep -v Classic <hello.c >hello.c.new &&
+	mv hello.c.new hello.c
+'
+
+cat <<\EOF >expected
+diff --git a/hello.c b/hello.c
+--- a/hello.c
++++ b/hello.c
+@@ -10,8 +10,7 @@ static int a(void)
+ static int hello_world(void)
+ {
+-	/* Classic. */
+ 	printf("Hello world.\n");
+ 
+ 	/* Success! */
+ 	return 0;
+ }
+EOF
+
+test_expect_success 'diff -U0 -W' '
+	git diff -U0 -W >actual &&
+	compare_diff_patch actual expected
+'
+
+cat <<\EOF >expected
+diff --git a/hello.c b/hello.c
+--- a/hello.c
++++ b/hello.c
+@@ -9,9 +9,8 @@ static int a(void)
+ 
+ static int hello_world(void)
+ {
+-	/* Classic. */
+ 	printf("Hello world.\n");
+ 
+ 	/* Success! */
+ 	return 0;
+ }
+EOF
+
+test_expect_success 'diff -W' '
+	git diff -W >actual &&
+	compare_diff_patch actual expected
+'
+
+test_done
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 4beb10c..00d36c3 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -43,6 +43,7 @@ extern "C" {
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
+#define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
 #define XDL_MMB_READONLY (1 << 0)
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 64eb17a..2e669c3 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -105,22 +105,27 @@ struct func_line {
 	char buf[80];
 };
 
-static void get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
+static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 			  struct func_line *func_line, long start, long limit)
 {
 	find_func_t ff = xecfg->find_func ? xecfg->find_func : def_ff;
-	long l, size = sizeof(func_line->buf);
-	char *buf = func_line->buf;
+	long l, size, step = (start > limit) ? -1 : 1;
+	char *buf, dummy[1];
 
-	for (l = start; l > limit && 0 <= l; l--) {
+	buf = func_line ? func_line->buf : dummy;
+	size = func_line ? sizeof(func_line->buf) : sizeof(dummy);
+
+	for (l = start; l != limit && 0 <= l && l < xe->xdf1.nrec; l += step) {
 		const char *rec;
 		long reclen = xdl_get_rec(&xe->xdf1, l, &rec);
 		long len = ff(rec, reclen, buf, size, xecfg->find_func_priv);
 		if (len >= 0) {
-			func_line->len = len;
-			break;
+			if (func_line)
+				func_line->len = len;
+			return l;
 		}
 	}
+	return -1;
 }
 
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
@@ -139,6 +144,17 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
 		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
 
+		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
+			long fs1 = get_func_line(xe, xecfg, NULL, xch->i1, -1);
+			if (fs1 < 0)
+				fs1 = 0;
+			if (fs1 < s1) {
+				s2 -= s1 - fs1;
+				s1 = fs1;
+			}
+		}
+
+ again:
 		lctx = xecfg->ctxlen;
 		lctx = XDL_MIN(lctx, xe->xdf1.nrec - (xche->i1 + xche->chg1));
 		lctx = XDL_MIN(lctx, xe->xdf2.nrec - (xche->i2 + xche->chg2));
@@ -146,6 +162,32 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		e1 = xche->i1 + xche->chg1 + lctx;
 		e2 = xche->i2 + xche->chg2 + lctx;
 
+		if (xecfg->flags & XDL_EMIT_FUNCCONTEXT) {
+			long fe1 = get_func_line(xe, xecfg, NULL,
+						 xche->i1 + xche->chg1,
+						 xe->xdf1.nrec);
+			if (fe1 < 0)
+				fe1 = xe->xdf1.nrec;
+			if (fe1 > e1) {
+				e2 += fe1 - e1;
+				e1 = fe1;
+			}
+
+			/*
+			 * Overlap with next change?  Then include it
+			 * in the current hunk and start over to find
+			 * its new end.
+			 */
+			if (xche->next) {
+				long l = xche->next->i1;
+				if (l <= e1 ||
+				    get_func_line(xe, xecfg, NULL, l, e1) < 0) {
+					xche = xche->next;
+					goto again;
+				}
+			}
+		}
+
 		/*
 		 * Emit current hunk header.
 		 */
-- 
1.7.7
