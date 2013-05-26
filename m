From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] diff: add --ignore-blank-lines option
Date: Sun, 26 May 2013 19:58:18 +0200
Message-ID: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 20:02:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgfHH-0003bt-6A
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 20:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718Ab3EZSCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 14:02:39 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:53819 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab3EZSCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 14:02:38 -0400
Received: by mail-wg0-f42.google.com with SMTP id n12so1637096wgh.3
        for <git@vger.kernel.org>; Sun, 26 May 2013 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CywXIQviBtROBah8QOu7vw1Od0M+YGptO6IiiX9Xxsc=;
        b=gdhW+HnF7k8feHcI9byHiRuVOz9JitvDtDrFWc+hbvPLEGl8yWyerFD6iadTXdxRE7
         7JSJklBTaStkgb2OFrF8omMv6PXHS3oi7CzpANcxThKrE/vkog0zvG5+1TMc5QpK8+cX
         j1vSWNF9CL0aSUucAPea+2Uh0dAXerf5avKdRl4MDf9H6z+7JsrbRzTRd0NkAgjl024O
         DIP5a1yeIaAvn1FcdloppAXJwftViCl3gVgYmVqjHsjhpyWg13EJaA1NCscBod0xY564
         eFPYbNR/0vDVTCUNqvbLUoFpywbtU2r6Wr8kxFUaXdXBPcKsrA4NJ59LYCMRU+QMdlf8
         xdBQ==
X-Received: by 10.194.110.169 with SMTP id ib9mr6305265wjb.12.1369591357087;
        Sun, 26 May 2013 11:02:37 -0700 (PDT)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPSA id q13sm12294147wie.8.2013.05.26.11.02.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 26 May 2013 11:02:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225558>

The goal of the patch is to introduce the GNU diff
-B/--ignore-blank-lines as closely as possible. The short option is not
available because it's already used for "break-rewrites".

When this option is used, git-diff will not create hunks that simply
adds or removes empty lines, but will still show empty lines
addition/suppression if they are close enough to "valuable" changes.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 Documentation/diff-options.txt |    3 ++
 diff.c                         |    2 ++
 t/t4015-diff-whitespace.sh     |   65 ++++++++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h                  |    2 ++
 xdiff/xdiffi.c                 |   29 +++++++++++++++++-
 xdiff/xdiffi.h                 |    1 +
 xdiff/xemit.c                  |   32 ++++++++++++++++----
 xdiff/xemit.h                  |    2 +-
 xdiff/xutils.c                 |   13 ++++++++
 xdiff/xutils.h                 |    1 +
 10 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 104579d..80f06b7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -439,6 +439,9 @@ endif::git-format-patch[]
 	differences even if one line has whitespace where the other
 	line has none.

+--ignore-blank-lines::
+	Ignore changes whose lines are all blank.
+
 --inter-hunk-context=<lines>::
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
diff --git a/diff.c b/diff.c
index f0b3e7c..208094f 100644
--- a/diff.c
+++ b/diff.c
@@ -3593,6 +3593,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
+	else if (!strcmp(arg, "--ignore-blank-lines"))
+		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
 	else if (!strcmp(arg, "--patience"))
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index cc3db13..b3c4fcc 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -142,6 +142,71 @@ EOF
 git diff --ignore-space-at-eol > out
 test_expect_success 'another test, with --ignore-space-at-eol' 'test_cmp expect out'

+test_expect_success 'ignore-blank-lines: only new lines' '
+	seq 5 >x &&
+	git update-index x &&
+	seq 5 | sed "/3/i \\\\" >x &&
+	git diff --ignore-blank-lines >out &&
+	printf "" >expect &&
+	test_cmp out expect
+'
+
+test_expect_success 'ignore-blank-lines: only new lines with space' '
+	seq 5 >x &&
+	git update-index x &&
+	seq 5 | sed "/3/i \ " >x &&
+	git diff -w --ignore-blank-lines >out &&
+	printf "" >expect &&
+	test_cmp out expect
+'
+
+
+test_expect_success 'ignore-blank-lines: with changes' '
+	seq 11 >x &&
+	git update-index x &&
+	cat <<-\EOF >x &&
+
+	1
+	2
+	3
+	change
+	4
+	5
+	6
+	7
+
+	8
+	change
+	9
+	10
+	11
+
+	EOF
+	git diff --ignore-blank-lines >out.tmp &&
+	sed -e "1,/^+++ b\/x/d" <out.tmp >out &&
+	cat <<-\EOF >expect &&
+	@@ -1,6 +2,7 @@
+	 1
+	 2
+	 3
+	+change
+	 4
+	 5
+	 6
+	@@ -5,7 +7,9 @@
+	 5
+	 6
+	 7
+	+
+	 8
+	+change
+	 9
+	 10
+	 11
+	EOF
+	test_cmp out expect
+'
+
 test_expect_success 'check mixed spaces and tabs in indent' '

 	# This is indented with SP HT SP.
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 219a3bb..c033991 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -39,6 +39,8 @@ extern "C" {
 #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
 #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)

+#define XDF_IGNORE_BLANK_LINES (1 << 7)
+
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b2eb6db..3cabc78 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -394,6 +394,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
 	xch->i2 = i2;
 	xch->chg1 = chg1;
 	xch->chg2 = chg2;
+	xch->ignore = 0;

 	return xch;
 }
@@ -544,7 +545,9 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	xdchange_t *xch, *xche;

 	for (xch = xscr; xch; xch = xche->next) {
-		xche = xdl_get_hunk(xch, xecfg);
+		xche = xdl_get_hunk(&xch, xecfg);
+		if (!xch)
+			break;
 		if (xecfg->hunk_func(xch->i1, xche->i1 + xche->chg1 - xch->i1,
 				     xch->i2, xche->i2 + xche->chg2 - xch->i2,
 				     ecb->priv) < 0)
@@ -553,6 +556,27 @@ static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 	return 0;
 }

+static void xdl_mark_ignorable(xdchange_t *xscr, xdfenv_t *xe, long flags)
+{
+	xdchange_t *xch;
+
+	for (xch = xscr; xch; xch = xch->next) {
+		int ignore = 1;
+		xrecord_t **rec;
+		long i;
+
+		rec = &xe->xdf1.recs[xch->i1];
+		for (i = 0; i < xch->chg1 && ignore; i++)
+			ignore = xdl_blankline(rec[i]->ptr, flags);
+
+		rec = &xe->xdf2.recs[xch->i2];
+		for (i = 0; i < xch->chg2 && ignore; i++)
+			ignore = xdl_blankline(rec[i]->ptr, flags);
+
+		xch->ignore = ignore;
+	}
+}
+
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
@@ -571,6 +595,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 		return -1;
 	}
 	if (xscr) {
+		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
+			xdl_mark_ignorable(xscr, &xe, xpp->flags);
+
 		if (ef(&xe, xscr, ecb, xecfg) < 0) {

 			xdl_free_script(xscr);
diff --git a/xdiff/xdiffi.h b/xdiff/xdiffi.h
index 7a92ea9..8b81206 100644
--- a/xdiff/xdiffi.h
+++ b/xdiff/xdiffi.h
@@ -41,6 +41,7 @@ typedef struct s_xdchange {
 	struct s_xdchange *next;
 	long i1, i2;
 	long chg1, chg2;
+	int ignore;
 } xdchange_t;


diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d11dbf9..52dfef8 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -56,14 +56,34 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
 /*
  * Starting at the passed change atom, find the latest change atom to be included
  * inside the differential hunk according to the specified configuration.
+ * Also advance xscr if the first changes must be discareded.
  */
-xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg) {
+xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg) {
 	xdchange_t *xch, *xchp;
 	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
+	long ignorable_context = max_common / 2 - 1;
+	int interesting = 0;

-	for (xchp = xscr, xch = xscr->next; xch; xchp = xch, xch = xch->next)
-		if (xch->i1 - (xchp->i1 + xchp->chg1) > max_common)
-			break;
+	for (xchp = *xscr, xch = (*xscr)->next; xch; xchp = xch, xch = xch->next) {
+		long thresh;
+		if (xchp->ignore || xch->ignore)
+			thresh = ignorable_context;
+		else
+			thresh = max_common;
+
+		if (!xchp->ignore)
+			interesting = 1;
+
+		if (xch->i1 - (xchp->i1 + xchp->chg1) > thresh) {
+			if (interesting)
+				break;
+			else
+				*xscr = xch;
+		}
+	}
+
+	if (!interesting && xchp->ignore)
+		*xscr = NULL;

 	return xchp;
 }
@@ -139,7 +159,9 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		return xdl_emit_common(xe, xscr, ecb, xecfg);

 	for (xch = xscr; xch; xch = xche->next) {
-		xche = xdl_get_hunk(xch, xecfg);
+		xche = xdl_get_hunk(&xch, xecfg);
+		if (!xch)
+			break;

 		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
 		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
diff --git a/xdiff/xemit.h b/xdiff/xemit.h
index c2e2e83..d297107 100644
--- a/xdiff/xemit.h
+++ b/xdiff/xemit.h
@@ -27,7 +27,7 @@
 typedef int (*emit_func_t)(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			   xdemitconf_t const *xecfg);

-xdchange_t *xdl_get_hunk(xdchange_t *xscr, xdemitconf_t const *xecfg);
+xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg);
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg);

diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9504eae..c047376 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -143,6 +143,19 @@ long xdl_guess_lines(mmfile_t *mf, long sample) {
 	return nl + 1;
 }

+int xdl_blankline(const char *line, long flags)
+{
+	long i;
+
+	if (!(flags & XDF_WHITESPACE_FLAGS))
+		return (*line == '\n');
+
+	for (i = 0; line[i] != '\n' && XDL_ISSPACE(line[i]); i++)
+		;
+
+	return (line[i] == '\n');
+}
+
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
 {
 	int i1, i2;
diff --git a/xdiff/xutils.h b/xdiff/xutils.h
index ad1428e..b9cceff 100644
--- a/xdiff/xutils.h
+++ b/xdiff/xutils.h
@@ -32,6 +32,7 @@ int xdl_cha_init(chastore_t *cha, long isize, long icount);
 void xdl_cha_free(chastore_t *cha);
 void *xdl_cha_alloc(chastore_t *cha);
 long xdl_guess_lines(mmfile_t *mf, long sample);
+int xdl_blankline(const char *line, long flags);
 int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags);
 unsigned long xdl_hash_record(char const **data, char const *top, long flags);
 unsigned int xdl_hashbits(unsigned int size);
--
1.7.9.5
