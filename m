From: Brian Downing <bdowning@lavos.net>
Subject: [PATCHv3 1/2] Make xdi_diff_outf interface for running xdiff_outf diffs
Date: Thu, 14 Aug 2008 00:36:50 -0500
Message-ID: <1218692211-26045-1-git-send-email-bdowning@lavos.net>
References: <20080814053156.GE4396@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 07:38:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTVX8-0003H1-55
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 07:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbYHNFg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 01:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbYHNFg4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 01:36:56 -0400
Received: from qmta05.westchester.pa.mail.comcast.net ([76.96.62.48]:55589
	"EHLO QMTA05.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750800AbYHNFgz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 01:36:55 -0400
Received: from OMTA05.westchester.pa.mail.comcast.net ([76.96.62.43])
	by QMTA05.westchester.pa.mail.comcast.net with comcast
	id 25ZX1a0070vyq2s555ctbv; Thu, 14 Aug 2008 05:36:53 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA05.westchester.pa.mail.comcast.net with comcast
	id 25cs1a0044BqYqi3R5csMi; Thu, 14 Aug 2008 05:36:53 +0000
X-Authority-Analysis: v=1.0 c=1 a=SPkHpBY_Y3oA:10 a=1kaSlVBt6r8A:10
 a=NWSkBRwQxq3ECH699xUA:9 a=Svb8lVuqfSCWipVaQNIA:7
 a=dsNMYm_XYvxoFRR_HZK0o4jkpgEA:4 a=GB4YReQY-hoA:10 a=DFZ4TeuG6JwA:10
Received: from silvara.lavos.net (silvara.lavos.net [10.4.0.20])
	by mnementh.lavos.net (Postfix) with SMTP id 73F2D309F22;
	Thu, 14 Aug 2008 00:36:51 -0500 (CDT)
Received: (nullmailer pid 31341 invoked by uid 1000);
	Thu, 14 Aug 2008 05:36:51 -0000
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <20080814053156.GE4396@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92319>

To prepare for the need to initialize and release resources for an
xdi_diff with the xdiff_outf output function, make a new function to
wrap this usage.

Old:

	ecb.outf = xdiff_outf;
	ecb.priv = &state;
	...
	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);

New:

	xdi_diff_outf(file_p, file_o, &state.xm, &xpp, &xecfg, &ecb);

Signed-off-by: Brian Downing <bdowning@lavos.net>
---

    Let's try this instead; it's quite a bit cleaner than my last
    effort.  [Especially now that it doesn't skip the xdi_diff
    function.]

 builtin-blame.c   |    4 +---
 combine-diff.c    |    5 ++---
 diff.c            |   20 +++++---------------
 xdiff-interface.c |   13 ++++++++++++-
 xdiff-interface.h |    4 +++-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 4ea3431..8cca3b1 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -528,15 +528,13 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	xpp.flags = xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
-	ecb.outf = xdiff_outf;
-	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
 	state.xm.consume = process_u_diff;
 	state.ret = xmalloc(sizeof(struct patch));
 	state.ret->chunks = NULL;
 	state.ret->num = 0;
 
-	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);
+	xdi_diff_outf(file_p, file_o, &state.xm, &xpp, &xecfg, &ecb);
 
 	if (state.ret->num) {
 		struct chunk *chunk;
diff --git a/combine-diff.c b/combine-diff.c
index 9f80a1c..72dd6d2 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -217,8 +217,6 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	parent_file.size = sz;
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
-	ecb.outf = xdiff_outf;
-	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
 	state.xm.consume = consume_line;
 	state.nmask = nmask;
@@ -227,7 +225,8 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	state.num_parent = num_parent;
 	state.n = n;
 
-	xdi_diff(&parent_file, result_file, &xpp, &xecfg, &ecb);
+	xdi_diff_outf(&parent_file, result_file,
+		      &state.xm, &xpp, &xecfg, &ecb);
 	free(parent_file.ptr);
 
 	/* Assign line numbers for this parent.
diff --git a/diff.c b/diff.c
index bf5d5f1..913a92f 100644
--- a/diff.c
+++ b/diff.c
@@ -459,10 +459,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
-	ecb.outf = xdiff_outf;
-	ecb.priv = diff_words;
 	diff_words->xm.consume = fn_out_diff_words_aux;
-	xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
+	xdi_diff_outf(&minus, &plus, &diff_words->xm, &xpp, &xecfg, &ecb);
 
 	free(minus.ptr);
 	free(plus.ptr);
@@ -1521,15 +1519,13 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!prefixcmp(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		ecb.outf = xdiff_outf;
-		ecb.priv = &ecbdata;
 		ecbdata.xm.consume = fn_out_consume;
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
 		}
-		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, &ecbdata.xm, &xpp, &xecfg, &ecb);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 	}
@@ -1580,9 +1576,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
-		ecb.outf = xdiff_outf;
-		ecb.priv = diffstat;
-		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, &diffstat->xm, &xpp, &xecfg, &ecb);
 	}
 
  free_and_return:
@@ -1628,9 +1622,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL;
-		ecb.outf = xdiff_outf;
-		ecb.priv = &data;
-		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, &data.xm, &xpp, &xecfg, &ecb);
 
 		if ((data.ws_rule & WS_TRAILING_SPACE) &&
 		    data.trailing_blanks_start) {
@@ -3128,9 +3120,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
-		ecb.outf = xdiff_outf;
-		ecb.priv = &data;
-		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, &data.xm, &xpp, &xecfg, &ecb);
 	}
 
 	SHA1_Final(sha1, &ctx);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 61dc5c5..828b496 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -61,7 +61,7 @@ static void consume_one(void *priv_, char *s, unsigned long size)
 	}
 }
 
-int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
+static int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 {
 	struct xdiff_emit_state *priv = priv_;
 	int i;
@@ -141,6 +141,17 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
 }
 
+int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
+		  struct xdiff_emit_state *state, xpparam_t const *xpp,
+		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
+{
+	int ret;
+	xecb->outf = xdiff_outf;
+	xecb->priv = state;
+	ret = xdi_diff(mf1, mf2, xpp, xecfg, xecb);
+	return ret;
+}
+
 int read_mmfile(mmfile_t *ptr, const char *filename)
 {
 	struct stat st;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index f7f791d..6f3b361 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -14,7 +14,9 @@ struct xdiff_emit_state {
 };
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
-int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf);
+int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
+		  struct xdiff_emit_state *state, xpparam_t const *xpp,
+		  xdemitconf_t const *xecfg, xdemitcb_t *xecb);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
-- 
1.5.6.1
