From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH][CLEANUP] remove ecb parameter from xdi_diff_outf()
Date: Tue, 04 May 2010 22:41:34 +0200
Message-ID: <4BE0867E.3060906@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 22:42:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9OwH-0007te-S4
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 22:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934087Ab0EDUlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 16:41:49 -0400
Received: from india601.server4you.de ([85.25.151.105]:57091 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab0EDUls (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 16:41:48 -0400
Received: from [10.0.1.100] (p57B7C751.dip.t-dialin.net [87.183.199.81])
	by india601.server4you.de (Postfix) with ESMTPSA id B59522F8059;
	Tue,  4 May 2010 22:41:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146342>

xdi_diff_outf() overrides the structure members of its last parameter,
ignoring any value that callers pass in.  It's no surprise then that all
callers pass a pointer to an uninitialized structure.  They also don't
read it after the call, so the parameter is neither used for input nor
for output.   Turn it into a local variable of xdi_diff_outf().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 combine-diff.c    |    3 +--
 diff.c            |   15 +++++----------
 xdiff-interface.c |   11 ++++++-----
 xdiff-interface.h |    3 +--
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 3480dae..7557136 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -211,7 +211,6 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	mmfile_t parent_file;
-	xdemitcb_t ecb;
 	struct combine_diff_state state;
 	unsigned long sz;
 
@@ -231,7 +230,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	state.n = n;
 
 	xdi_diff_outf(&parent_file, result_file, consume_line, &state,
-		      &xpp, &xecfg, &ecb);
+		      &xpp, &xecfg);
 	free(parent_file.ptr);
 
 	/* Assign line numbers for this parent.
diff --git a/diff.c b/diff.c
index d0ecbc3..e40c127 100644
--- a/diff.c
+++ b/diff.c
@@ -700,7 +700,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 {
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
 	mmfile_t minus, plus;
 
 	/* special case: only removal */
@@ -722,7 +721,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	/* as only the hunk header will be parsed, we need a 0-context */
 	xecfg.ctxlen = 0;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
-		      &xpp, &xecfg, &ecb);
+		      &xpp, &xecfg);
 	free(minus.ptr);
 	free(plus.ptr);
 	if (diff_words->current_plus != diff_words->plus.text.ptr +
@@ -1708,7 +1707,6 @@ static void builtin_diff(const char *name_a,
 		const char *diffopts = getenv("GIT_DIFF_OPTS");
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
@@ -1780,7 +1778,7 @@ static void builtin_diff(const char *name_a,
 			}
 		}
 		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 		if (textconv_one)
@@ -1833,13 +1831,12 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 	}
 
  free_and_return:
@@ -1881,14 +1878,13 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		/* Crazy xdl interfaces.. */
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = XDF_NEED_MINIMAL;
 		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 
 		if (data.ws_rule & WS_BLANK_AT_EOF) {
 			struct emit_callback ecbdata;
@@ -3383,7 +3379,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 	for (i = 0; i < q->nr; i++) {
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
-		xdemitcb_t ecb;
 		mmfile_t mf1, mf2;
 		struct diff_filepair *p = q->queue[i];
 		int len1, len2;
@@ -3445,7 +3440,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
-			      &xpp, &xecfg, &ecb);
+			      &xpp, &xecfg);
 	}
 
 	git_SHA1_Final(sha1, &ctx);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index ca5e3fb..cd2285d 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -138,19 +138,20 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
-		  xpparam_t const *xpp,
-		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
+		  xpparam_t const *xpp, xdemitconf_t const *xecfg)
 {
 	int ret;
 	struct xdiff_emit_state state;
+	xdemitcb_t ecb;
 
 	memset(&state, 0, sizeof(state));
 	state.consume = fn;
 	state.consume_callback_data = consume_callback_data;
-	xecb->outf = xdiff_outf;
-	xecb->priv = &state;
+	memset(&ecb, 0, sizeof(ecb));
+	ecb.outf = xdiff_outf;
+	ecb.priv = &state;
 	strbuf_init(&state.remainder, 0);
-	ret = xdi_diff(mf1, mf2, xpp, xecfg, xecb);
+	ret = xdi_diff(mf1, mf2, xpp, xecfg, &ecb);
 	strbuf_release(&state.remainder);
 	return ret;
 }
diff --git a/xdiff-interface.h b/xdiff-interface.h
index abba70c..49d1116 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -9,8 +9,7 @@ typedef void (*xdiff_emit_hunk_consume_fn)(void *, long, long, long);
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
-		  xpparam_t const *xpp,
-		  xdemitconf_t const *xecfg, xdemitcb_t *xecb);
+		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
 int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
 		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
 		   xpparam_t const *xpp, xdemitconf_t *xecfg);
-- 
1.7.1
