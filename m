From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Future-proof source for changes in xdemitconf_t
Date: Wed, 4 Jul 2007 19:05:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041905090.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 04 20:06:03 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I69El-0000zd-S6
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 20:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbXGDSF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbXGDSF5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 14:05:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47941 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753882AbXGDSF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 14:05:56 -0400
Received: (qmail invoked by alias); 04 Jul 2007 18:05:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 04 Jul 2007 20:05:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AngRNyRAAXtSQqTGjfJ9teqg2jnxE0KRLCIViA+
	J/8JNPT7GDGCKL
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51629>


The instances of xdemitconf_t were initialized member by member.
Instead, initialize them to all zero, so we do not have
to update those places each time we introduce a new member.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-blame.c  |    2 +-
 builtin-rerere.c |    2 +-
 combine-diff.c   |    3 +--
 diff.c           |   16 ++++++----------
 merge-file.c     |    1 +
 merge-tree.c     |    2 +-
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index da23a6f..0519339 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -518,8 +518,8 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	xdemitcb_t ecb;
 
 	xpp.flags = xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
-	xecfg.flags = 0;
 	ecb.outf = xdiff_outf;
 	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29fb075..01f3848 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -282,8 +282,8 @@ static int diff_two(const char *file1, const char *label1,
 	printf("--- a/%s\n+++ b/%s\n", label1, label2);
 	fflush(stdout);
 	xpp.flags = XDF_NEED_MINIMAL;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	xecfg.flags = 0;
 	ecb.outf = outf;
 	xdl_diff(&minus, &plus, &xpp, &xecfg, &ecb);
 
diff --git a/combine-diff.c b/combine-diff.c
index ea3ca5f..ef62234 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -215,8 +215,7 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	parent_file.ptr = grab_blob(parent, &sz);
 	parent_file.size = sz;
 	xpp.flags = XDF_NEED_MINIMAL;
-	xecfg.ctxlen = 0;
-	xecfg.flags = 0;
+	memset(&xecfg, 0, sizeof(xecfg));
 	ecb.outf = xdiff_outf;
 	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
diff --git a/diff.c b/diff.c
index 1958970..bea0163 100644
--- a/diff.c
+++ b/diff.c
@@ -19,6 +19,7 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = -1;
 static int diff_use_color_default;
+static xdemitconf_t default_xecfg;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -385,7 +386,7 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 static void diff_words_show(struct diff_words_data *diff_words)
 {
 	xpparam_t xpp;
-	xdemitconf_t xecfg;
+	xdemitconf_t xecfg = default_xecfg;
 	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 	int i;
@@ -408,7 +409,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
-	xecfg.flags = 0;
 	ecb.outf = xdiff_outf;
 	ecb.priv = diff_words;
 	diff_words->xm.consume = fn_out_diff_words_aux;
@@ -1198,7 +1198,7 @@ static void builtin_diff(const char *name_a,
 		/* Crazy xdl interfaces.. */
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = default_xecfg;
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
 
@@ -1267,12 +1267,10 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	} else {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = default_xecfg;
 		xdemitcb_t ecb;
 
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
-		xecfg.ctxlen = 0;
-		xecfg.flags = 0;
 		ecb.outf = xdiff_outf;
 		ecb.priv = diffstat;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
@@ -1307,12 +1305,10 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	else {
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = default_xecfg;
 		xdemitcb_t ecb;
 
 		xpp.flags = XDF_NEED_MINIMAL;
-		xecfg.ctxlen = 0;
-		xecfg.flags = 0;
 		ecb.outf = xdiff_outf;
 		ecb.priv = &data;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
@@ -2758,7 +2754,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 	for (i = 0; i < q->nr; i++) {
 		xpparam_t xpp;
-		xdemitconf_t xecfg;
+		xdemitconf_t xecfg = default_xecfg;
 		xdemitcb_t ecb;
 		mmfile_t mf1, mf2;
 		struct diff_filepair *p = q->queue[i];
diff --git a/merge-file.c b/merge-file.c
index 748d15c..1e031ea 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -62,6 +62,7 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	xdemitcb_t ecb;
 
 	xpp.flags = XDF_NEED_MINIMAL;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	xecfg.flags = XDL_EMIT_COMMON;
 	ecb.outf = common_outf;
diff --git a/merge-tree.c b/merge-tree.c
index 3b8d9e6..7d4f628 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -106,8 +106,8 @@ static void show_diff(struct merge_list *entry)
 	xdemitcb_t ecb;
 
 	xpp.flags = XDF_NEED_MINIMAL;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	xecfg.flags = 0;
 	ecb.outf = show_outf;
 	ecb.priv = NULL;
 
-- 
1.5.3.rc0.804.g7068
