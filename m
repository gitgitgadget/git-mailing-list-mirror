From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 1/2] Make xdiff_outf_{init,release} interface
Date: Wed, 13 Aug 2008 02:05:09 -0500
Message-ID: <20080813070508.GB4396@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 09:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAR6-0004jr-IK
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbYHMHFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbYHMHFO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:05:14 -0400
Received: from qmta03.emeryville.ca.mail.comcast.net ([76.96.30.32]:34639 "EHLO
	QMTA03.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973AbYHMHFN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 03:05:13 -0400
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11])
	by QMTA03.emeryville.ca.mail.comcast.net with comcast
	id 1iyn1a0080EPchoA3j5As2; Wed, 13 Aug 2008 07:05:10 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA01.emeryville.ca.mail.comcast.net with comcast
	id 1j591a0024BqYqi8Mj59jk; Wed, 13 Aug 2008 07:05:10 +0000
X-Authority-Analysis: v=1.0 c=1 a=8JPJ78OzieoA:10 a=FpbXfFfPfY8A:10
 a=pXz-DhIq5KU_QJucoq8A:9 a=JBqY8JQPiOJfHF7uaSIA:7
 a=NUuA4wQdzLaKgRAknoJR8nJE4UMA:4 a=GB4YReQY-hoA:10 a=DFZ4TeuG6JwA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id 1765B309F23; Wed, 13 Aug 2008 02:05:09 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92183>

To prepare for the need to release resources when we're done with
xdiff_outf, make a new function pair to initialize and release a
struct xdiff_emit_state.  Since we can roll the two lines always
required to use xdiff_outf into one, the net number of lines at the call
site remains constant.

Old:

	ecb.outf = xdiff_outf;
	ecb.priv = &state;
	...
	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);

New:

	xdiff_outf_init(&ecb, &state);
	...
	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);
	xdiff_outf_release(&state);

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-blame.c   |    4 ++--
 combine-diff.c    |    4 ++--
 diff.c            |   20 ++++++++++----------
 xdiff-interface.c |   11 +++++++++++
 xdiff-interface.h |    2 ++
 5 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 4ea3431..b52eff4 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -528,15 +528,15 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	xpp.flags = xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
-	ecb.outf = xdiff_outf;
-	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
+	xdiff_outf_init(&ecb, &state);
 	state.xm.consume = process_u_diff;
 	state.ret = xmalloc(sizeof(struct patch));
 	state.ret->chunks = NULL;
 	state.ret->num = 0;
 
 	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);
+	xdiff_outf_release(&state);
 
 	if (state.ret->num) {
 		struct chunk *chunk;
diff --git a/combine-diff.c b/combine-diff.c
index 9f80a1c..887c315 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -217,9 +217,8 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	parent_file.size = sz;
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
-	ecb.outf = xdiff_outf;
-	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
+	xdiff_outf_init(&ecb, &state);
 	state.xm.consume = consume_line;
 	state.nmask = nmask;
 	state.sline = sline;
@@ -228,6 +227,7 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	state.n = n;
 
 	xdi_diff(&parent_file, result_file, &xpp, &xecfg, &ecb);
+	xdiff_outf_release(&state);
 	free(parent_file.ptr);
 
 	/* Assign line numbers for this parent.
diff --git a/diff.c b/diff.c
index 6954f99..222646d 100644
--- a/diff.c
+++ b/diff.c
@@ -459,10 +459,10 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
-	ecb.outf = xdiff_outf;
-	ecb.priv = diff_words;
+	xdiff_outf_init(&ecb, diff_words);
 	diff_words->xm.consume = fn_out_diff_words_aux;
 	xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
+	xdiff_outf_release(diff_words);
 
 	free(minus.ptr);
 	free(plus.ptr);
@@ -1520,8 +1520,7 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!prefixcmp(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		ecb.outf = xdiff_outf;
-		ecb.priv = &ecbdata;
+		xdiff_outf_init(&ecb, &ecbdata);
 		ecbdata.xm.consume = fn_out_consume;
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
@@ -1529,6 +1528,7 @@ static void builtin_diff(const char *name_a,
 			ecbdata.diff_words->file = o->file;
 		}
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdiff_outf_release(&ecbdata);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 	}
@@ -1579,9 +1579,9 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
-		ecb.outf = xdiff_outf;
-		ecb.priv = diffstat;
+		xdiff_outf_init(&ecb, diffstat);
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdiff_outf_release(diffstat);
 	}
 
  free_and_return:
@@ -1627,9 +1627,9 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL;
-		ecb.outf = xdiff_outf;
-		ecb.priv = &data;
+		xdiff_outf_init(&ecb, &data);
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdiff_outf_release(&data);
 
 		if ((data.ws_rule & WS_TRAILING_SPACE) &&
 		    data.trailing_blanks_start) {
@@ -3127,9 +3127,9 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
-		ecb.outf = xdiff_outf;
-		ecb.priv = &data;
+		xdiff_outf_init(&ecb, &data);
 		xdi_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
+		xdiff_outf_release(&data);
 	}
 
 	SHA1_Final(sha1, &ctx);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 61dc5c5..9c5e277 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -61,6 +61,13 @@ static void consume_one(void *priv_, char *s, unsigned long size)
 	}
 }
 
+void xdiff_outf_init(xdemitcb_t *ecb, void *priv_)
+{
+	struct xdiff_emit_state *priv = priv_;
+	ecb->outf = xdiff_outf;
+	ecb->priv = priv;
+}
+
 int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 {
 	struct xdiff_emit_state *priv = priv_;
@@ -103,6 +110,10 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 	return 0;
 }
 
+void xdiff_outf_release(void *priv_)
+{
+}
+
 /*
  * Trim down common substring at the end of the buffers,
  * but leave at least ctx lines at the end.
diff --git a/xdiff-interface.h b/xdiff-interface.h
index f7f791d..fca6200 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -14,7 +14,9 @@ struct xdiff_emit_state {
 };
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
+void xdiff_outf_init(xdemitcb_t *ecb, void *priv_);
 int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf);
+void xdiff_outf_release(void *priv_);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
-- 
1.5.6.1
