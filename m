From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] Make xdi_diff_outf interface for running
 xdiff_outf diffs
Date: Wed, 13 Aug 2008 23:18:22 -0700
Message-ID: <7v1w0sf7bl.fsf@gitster.siamese.dyndns.org>
References: <20080814053156.GE4396@lavos.net>
 <1218692211-26045-1-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Aug 14 08:19:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTWBK-0003vn-N1
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 08:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbYHNGSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 02:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbYHNGSa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 02:18:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49023 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbYHNGS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 02:18:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B1CF0583A4;
	Thu, 14 Aug 2008 02:18:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8401658392; Thu, 14 Aug 2008 02:18:24 -0400 (EDT)
In-Reply-To: <1218692211-26045-1-git-send-email-bdowning@lavos.net> (Brian
 Downing's message of "Thu, 14 Aug 2008 00:36:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CF85DBD6-69C8-11DD-B8E8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92324>

Brian Downing <bdowning@lavos.net> writes:

>     Let's try this instead; it's quite a bit cleaner than my last
>     effort.  [Especially now that it doesn't skip the xdi_diff
>     function.]

Much nicer.  xdi_diff() is just a performance thing that only kicks in
when you are running -U0 diff, so it is unsurprising that you did not see
any test failures.

However,

 * xm.consume is always set to something by the caller but all the other
   fields in xm are initialized to zero --- perhaps xdi_diff_outf() can
   take the pointer to the consume function as its parameter?

 * the whole set-up still requires that the xdiff_emit_state structure is
   the first member of callback data structure, so making the third
   parameter to xdi_diff_outf() to "struct xdiff_emit_state" and casting
   it up to containing structure like your patch does does not offer any
   additional type safety.

I wonder if something like this on top of your patch would be worth doing
as a further clean-up.

-- >8 --
xdiff-interface: hide the whole "xdiff_emit_state" business from the caller

This further enhances xdi_diff_outf() interface so that it takes two
common parameters: the callback function that processes one line at a
time, and a pointer to its application specific callback data structure.
xdi_diff_outf() creates its own "xdiff_emit_state" structure and stashes
these two away inside it, which is used by the lowest level output
function in the xdiff_outf() callchain, consume_one(), to call back to the
application layer.  With this restructuring, we lift the requirement that
the caller supplied callback data structure embeds xdiff_emit_state
structure as its first member.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c   |    4 +---
 combine-diff.c    |    7 ++-----
 diff.c            |   27 ++++++++++-----------------
 xdiff-interface.c |   23 ++++++++++++++++++-----
 xdiff-interface.h |   11 ++---------
 5 files changed, 33 insertions(+), 39 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 8cca3b1..e4d12de 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -465,7 +465,6 @@ struct patch {
 };
 
 struct blame_diff_state {
-	struct xdiff_emit_state xm;
 	struct patch *ret;
 	unsigned hunk_post_context;
 	unsigned hunk_in_pre_context : 1;
@@ -529,12 +528,11 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
 	memset(&state, 0, sizeof(state));
-	state.xm.consume = process_u_diff;
 	state.ret = xmalloc(sizeof(struct patch));
 	state.ret->chunks = NULL;
 	state.ret->num = 0;
 
-	xdi_diff_outf(file_p, file_o, &state.xm, &xpp, &xecfg, &ecb);
+	xdi_diff_outf(file_p, file_o, process_u_diff, &state, &xpp, &xecfg, &ecb);
 
 	if (state.ret->num) {
 		struct chunk *chunk;
diff --git a/combine-diff.c b/combine-diff.c
index 72dd6d2..31ec0c5 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -143,8 +143,6 @@ static void append_lost(struct sline *sline, int n, const char *line, int len)
 }
 
 struct combine_diff_state {
-	struct xdiff_emit_state xm;
-
 	unsigned int lno;
 	int ob, on, nb, nn;
 	unsigned long nmask;
@@ -218,15 +216,14 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	xpp.flags = XDF_NEED_MINIMAL;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
-	state.xm.consume = consume_line;
 	state.nmask = nmask;
 	state.sline = sline;
 	state.lno = 1;
 	state.num_parent = num_parent;
 	state.n = n;
 
-	xdi_diff_outf(&parent_file, result_file,
-		      &state.xm, &xpp, &xecfg, &ecb);
+	xdi_diff_outf(&parent_file, result_file, consume_line, &state,
+		      &xpp, &xecfg, &ecb);
 	free(parent_file.ptr);
 
 	/* Assign line numbers for this parent.
diff --git a/diff.c b/diff.c
index 913a92f..f18a4be 100644
--- a/diff.c
+++ b/diff.c
@@ -369,7 +369,6 @@ static void diff_words_append(char *line, unsigned long len,
 }
 
 struct diff_words_data {
-	struct xdiff_emit_state xm;
 	struct diff_words_buffer minus, plus;
 	FILE *file;
 };
@@ -459,9 +458,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
-	diff_words->xm.consume = fn_out_diff_words_aux;
-	xdi_diff_outf(&minus, &plus, &diff_words->xm, &xpp, &xecfg, &ecb);
-
+	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, &diff_words,
+		      &xpp, &xecfg, &ecb);
 	free(minus.ptr);
 	free(plus.ptr);
 	diff_words->minus.text.size = diff_words->plus.text.size = 0;
@@ -475,7 +473,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
 
 struct emit_callback {
-	struct xdiff_emit_state xm;
 	int nparents, color_diff;
 	unsigned ws_rule;
 	sane_truncate_fn truncate;
@@ -706,8 +703,6 @@ static char *pprint_rename(const char *a, const char *b)
 }
 
 struct diffstat_t {
-	struct xdiff_emit_state xm;
-
 	int nr;
 	int alloc;
 	struct diffstat_file {
@@ -1129,7 +1124,6 @@ static void free_diffstat_info(struct diffstat_t *diffstat)
 }
 
 struct checkdiff_t {
-	struct xdiff_emit_state xm;
 	const char *filename;
 	int lineno;
 	struct diff_options *o;
@@ -1519,13 +1513,13 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!prefixcmp(diffopts, "-u"))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		ecbdata.xm.consume = fn_out_consume;
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS)) {
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 			ecbdata.diff_words->file = o->file;
 		}
-		xdi_diff_outf(&mf1, &mf2, &ecbdata.xm, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
+			      &xpp, &xecfg, &ecb);
 		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 	}
@@ -1576,7 +1570,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
-		xdi_diff_outf(&mf1, &mf2, &diffstat->xm, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
+			      &xpp, &xecfg, &ecb);
 	}
 
  free_and_return:
@@ -1597,7 +1592,6 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		return;
 
 	memset(&data, 0, sizeof(data));
-	data.xm.consume = checkdiff_consume;
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
 	data.o = o;
@@ -1622,7 +1616,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 
 		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL;
-		xdi_diff_outf(&mf1, &mf2, &data.xm, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
+			      &xpp, &xecfg, &ecb);
 
 		if ((data.ws_rule & WS_TRAILING_SPACE) &&
 		    data.trailing_blanks_start) {
@@ -3010,7 +3005,6 @@ static void diff_summary(FILE *file, struct diff_filepair *p)
 }
 
 struct patch_id_t {
-	struct xdiff_emit_state xm;
 	SHA_CTX *ctx;
 	int patchlen;
 };
@@ -3055,7 +3049,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 	SHA1_Init(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
 	data.ctx = &ctx;
-	data.xm.consume = patch_id_consume;
 
 	for (i = 0; i < q->nr; i++) {
 		xpparam_t xpp;
@@ -3120,7 +3113,8 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
-		xdi_diff_outf(&mf1, &mf2, &data.xm, &xpp, &xecfg, &ecb);
+		xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
+			      &xpp, &xecfg, &ecb);
 	}
 
 	SHA1_Final(sha1, &ctx);
@@ -3197,7 +3191,6 @@ void diff_flush(struct diff_options *options)
 		struct diffstat_t diffstat;
 
 		memset(&diffstat, 0, sizeof(struct diffstat_t));
-		diffstat.xm.consume = diffstat_consume;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
diff --git a/xdiff-interface.c b/xdiff-interface.c
index bf98866..944ad98 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,5 +1,12 @@
 #include "cache.h"
 #include "xdiff-interface.h"
+#include "strbuf.h"
+
+struct xdiff_emit_state {
+	xdiff_emit_consume_fn consume;
+	void *consume_callback_data;
+	struct strbuf remainder;
+};
 
 static int parse_num(char **cp_p, int *num_p)
 {
@@ -55,7 +62,7 @@ static void consume_one(void *priv_, char *s, unsigned long size)
 		unsigned long this_size;
 		ep = memchr(s, '\n', size);
 		this_size = (ep == NULL) ? size : (ep - s + 1);
-		priv->consume(priv, s, this_size);
+		priv->consume(priv->consume_callback_data, s, this_size);
 		size -= this_size;
 		s += this_size;
 	}
@@ -128,15 +135,21 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 }
 
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
-		  struct xdiff_emit_state *state, xpparam_t const *xpp,
+		  xdiff_emit_consume_fn fn, void *consume_callback_data,
+		  xpparam_t const *xpp,
 		  xdemitconf_t const *xecfg, xdemitcb_t *xecb)
 {
 	int ret;
+	struct xdiff_emit_state state;
+
+	memset(&state, 0, sizeof(state));
+	state.consume = fn;
+	state.consume_callback_data = consume_callback_data;
 	xecb->outf = xdiff_outf;
-	xecb->priv = state;
-	strbuf_init(&state->remainder, 0);
+	xecb->priv = &state;
+	strbuf_init(&state.remainder, 0);
 	ret = xdi_diff(mf1, mf2, xpp, xecfg, xecb);
-	strbuf_release(&state->remainder);
+	strbuf_release(&state.remainder);
 	return ret;
 }
 
diff --git a/xdiff-interface.h b/xdiff-interface.h
index f6a1ec2..558492b 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -2,20 +2,13 @@
 #define XDIFF_INTERFACE_H
 
 #include "xdiff/xdiff.h"
-#include "strbuf.h"
-
-struct xdiff_emit_state;
 
 typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
 
-struct xdiff_emit_state {
-	xdiff_emit_consume_fn consume;
-	struct strbuf remainder;
-};
-
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
-		  struct xdiff_emit_state *state, xpparam_t const *xpp,
+		  xdiff_emit_consume_fn fn, void *consume_callback_data,
+		  xpparam_t const *xpp,
 		  xdemitconf_t const *xecfg, xdemitcb_t *xecb);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
