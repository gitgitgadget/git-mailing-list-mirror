Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1CF61F454
	for <e@80x24.org>; Fri,  2 Nov 2018 06:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeKBPlw (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:41:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:37710 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727745AbeKBPlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:41:52 -0400
Received: (qmail 29446 invoked by uid 109); 2 Nov 2018 06:35:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:35:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 943 invoked by uid 111); 2 Nov 2018 06:35:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:35:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:35:45 -0400
Date:   Fri, 2 Nov 2018 02:35:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/9] xdiff-interface: provide a separate consume callback for
 hunks
Message-ID: <20181102063545.GB31216@sigill.intra.peff.net>
References: <20181102063156.GA30252@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102063156.GA30252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit taught xdiff to optionally provide the hunk header
data to a specialized callback. But most users of xdiff actually use our
more convenient xdi_diff_outf() helper, which ensures that our callbacks
are always fed whole lines.

Let's plumb the special hunk-callback through this interface, too. It
will follow the same rule as xdiff when the hunk callback is NULL (i.e.,
continue to pass a stringified hunk header to the line callback). Since
we add NULL to each caller, there should be no behavior change yet.

Signed-off-by: Jeff King <peff@peff.net>
---
 combine-diff.c     |  4 ++--
 diff.c             | 20 ++++++++++----------
 diffcore-pickaxe.c |  2 +-
 range-diff.c       |  2 +-
 xdiff-interface.c  | 30 ++++++++++++++++++++++++++----
 xdiff-interface.h  | 10 ++++++++--
 6 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 10155e0ec8..3c479cfc3e 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -421,8 +421,8 @@ static void combine_diff(struct repository *r,
 	state.num_parent = num_parent;
 	state.n = n;
 
-	if (xdi_diff_outf(&parent_file, result_file, consume_line, &state,
-			  &xpp, &xecfg))
+	if (xdi_diff_outf(&parent_file, result_file, NULL, consume_line,
+			  &state, &xpp, &xecfg))
 		die("unable to generate combined diff for %s",
 		    oid_to_hex(parent));
 	free(parent_file.ptr);
diff --git a/diff.c b/diff.c
index 8647db3d30..07be5879e5 100644
--- a/diff.c
+++ b/diff.c
@@ -2074,8 +2074,8 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	xpp.flags = 0;
 	/* as only the hunk header will be parsed, we need a 0-context */
 	xecfg.ctxlen = 0;
-	if (xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
-			  &xpp, &xecfg))
+	if (xdi_diff_outf(&minus, &plus, NULL, fn_out_diff_words_aux,
+			  diff_words, &xpp, &xecfg))
 		die("unable to generate word diff");
 	free(minus.ptr);
 	free(plus.ptr);
@@ -3526,8 +3526,8 @@ static void builtin_diff(const char *name_a,
 			xecfg.ctxlen = strtoul(v, NULL, 10);
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
-		if (xdi_diff_outf(&mf1, &mf2, fn_out_consume, &ecbdata,
-				  &xpp, &xecfg))
+		if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
+				  &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
@@ -3637,8 +3637,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
-		if (xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
-				  &xpp, &xecfg))
+		if (xdi_diff_outf(&mf1, &mf2, NULL, diffstat_consume,
+				  diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
 	}
 
@@ -3686,8 +3686,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
 		xpp.flags = 0;
-		if (xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
-				  &xpp, &xecfg))
+		if (xdi_diff_outf(&mf1, &mf2, NULL, checkdiff_consume,
+				  &data, &xpp, &xecfg))
 			die("unable to generate checkdiff for %s", one->path);
 
 		if (data.ws_rule & WS_BLANK_AT_EOF) {
@@ -5771,8 +5771,8 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		xpp.flags = 0;
 		xecfg.ctxlen = 3;
 		xecfg.flags = 0;
-		if (xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
-				  &xpp, &xecfg))
+		if (xdi_diff_outf(&mf1, &mf2, NULL, patch_id_consume,
+				  &data, &xpp, &xecfg))
 			return error("unable to generate patch-id diff for %s",
 				     p->one->path);
 	}
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index d2361e06a1..58df35670a 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -62,7 +62,7 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	ecbdata.hit = 0;
 	xecfg.ctxlen = o->context;
 	xecfg.interhunkctxlen = o->interhunkcontext;
-	if (xdi_diff_outf(one, two, diffgrep_consume, &ecbdata, &xpp, &xecfg))
+	if (xdi_diff_outf(one, two, NULL, diffgrep_consume, &ecbdata, &xpp, &xecfg))
 		return 0;
 	return ecbdata.hit;
 }
diff --git a/range-diff.c b/range-diff.c
index bd8083f2d1..245fc17fee 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -210,7 +210,7 @@ static int diffsize(const char *a, const char *b)
 	mf2.size = strlen(b);
 
 	cfg.ctxlen = 3;
-	if (!xdi_diff_outf(&mf1, &mf2, diffsize_consume, &count, &pp, &cfg))
+	if (!xdi_diff_outf(&mf1, &mf2, NULL, diffsize_consume, &count, &pp, &cfg))
 		return count;
 
 	error(_("failed to generate diff"));
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 25c185aff4..16d37ce6be 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -9,7 +9,8 @@
 #include "xdiff/xutils.h"
 
 struct xdiff_emit_state {
-	xdiff_emit_consume_fn consume;
+	xdiff_emit_hunk_fn hunk_fn;
+	xdiff_emit_line_fn line_fn;
 	void *consume_callback_data;
 	struct strbuf remainder;
 };
@@ -59,6 +60,22 @@ int parse_hunk_header(char *line, int len,
 	return -!!memcmp(cp, " @@", 3);
 }
 
+static int xdiff_out_hunk(void *priv_,
+			  long old_begin, long old_nr,
+			  long new_begin, long new_nr,
+			  const char *func, long funclen)
+{
+	struct xdiff_emit_state *priv = priv_;
+
+	if (priv->remainder.len)
+		BUG("xdiff emitted hunk in the middle of a line");
+
+	priv->hunk_fn(priv->consume_callback_data,
+		      old_begin, old_nr, new_begin, new_nr,
+		      func, funclen);
+	return 0;
+}
+
 static void consume_one(void *priv_, char *s, unsigned long size)
 {
 	struct xdiff_emit_state *priv = priv_;
@@ -67,7 +84,7 @@ static void consume_one(void *priv_, char *s, unsigned long size)
 		unsigned long this_size;
 		ep = memchr(s, '\n', size);
 		this_size = (ep == NULL) ? size : (ep - s + 1);
-		priv->consume(priv->consume_callback_data, s, this_size);
+		priv->line_fn(priv->consume_callback_data, s, this_size);
 		size -= this_size;
 		s += this_size;
 	}
@@ -141,7 +158,9 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 }
 
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
-		  xdiff_emit_consume_fn fn, void *consume_callback_data,
+		  xdiff_emit_hunk_fn hunk_fn,
+		  xdiff_emit_line_fn line_fn,
+		  void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg)
 {
 	int ret;
@@ -149,9 +168,12 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 	xdemitcb_t ecb;
 
 	memset(&state, 0, sizeof(state));
-	state.consume = fn;
+	state.hunk_fn = hunk_fn;
+	state.line_fn = line_fn;
 	state.consume_callback_data = consume_callback_data;
 	memset(&ecb, 0, sizeof(ecb));
+	if (hunk_fn)
+		ecb.out_hunk = xdiff_out_hunk;
 	ecb.out_line = xdiff_outf;
 	ecb.priv = &state;
 	strbuf_init(&state.remainder, 0);
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 135fc05d72..2dbe2feb19 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -11,11 +11,17 @@
  */
 #define MAX_XDIFF_SIZE (1024UL * 1024 * 1023)
 
-typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
+typedef void (*xdiff_emit_line_fn)(void *, char *, unsigned long);
+typedef void (*xdiff_emit_hunk_fn)(void *data,
+				   long old_begin, long old_nr,
+				   long new_begin, long new_nr,
+				   const char *func, long funclen);
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
-		  xdiff_emit_consume_fn fn, void *consume_callback_data,
+		  xdiff_emit_hunk_fn hunk_fn,
+		  xdiff_emit_line_fn line_fn,
+		  void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
-- 
2.19.1.1336.g081079ac04

