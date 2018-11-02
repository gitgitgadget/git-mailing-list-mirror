Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37A31F454
	for <e@80x24.org>; Fri,  2 Nov 2018 06:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeKBPlI (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:41:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:37702 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727745AbeKBPlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:41:07 -0400
Received: (qmail 29413 invoked by uid 109); 2 Nov 2018 06:35:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:35:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 927 invoked by uid 111); 2 Nov 2018 06:34:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:34:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:35:01 -0400
Date:   Fri, 2 Nov 2018 02:35:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/9] xdiff: provide a separate emit callback for hunks
Message-ID: <20181102063501.GA31216@sigill.intra.peff.net>
References: <20181102063156.GA30252@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102063156.GA30252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xdiff library always emits hunk header lines to our callbacks as
formatted strings like "@@ -a,b +c,d @@\n". This is convenient if we're
going to output a diff, but less so if we actually need to compute using
those numbers, which requires re-parsing the line.

In preparation for moving away from this, let's teach xdiff a new
callback function which gets the broken-out hunk information. To help
callers that don't want to use this new callback, if it's NULL we'll
continue to format the hunk header into a string.

Note that this function renames the "outf" callback to "out_line", as
well. This isn't strictly necessary, but helps in two ways:

  1. Now that there are two callbacks, it's nice to use more descriptive
     names.

  2. Many callers did not zero the emit_callback_data struct, and needed
     to be modified to set ecb.out_hunk to NULL. By changing the name of
     the existing struct member, that guarantees that any new callers
     from in-flight topics will break the build and be examined
     manually.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/merge-tree.c |  3 ++-
 builtin/rerere.c     |  3 ++-
 xdiff-interface.c    |  2 +-
 xdiff/xdiff.h        |  6 +++++-
 xdiff/xutils.c       | 21 +++++++++++++++++----
 5 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 8fc108d305..70f6fc9167 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -110,7 +110,8 @@ static void show_diff(struct merge_list *entry)
 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	ecb.outf = show_outf;
+	ecb.out_hunk = NULL;
+	ecb.out_line = show_outf;
 	ecb.priv = NULL;
 
 	src.ptr = origin(entry, &size);
diff --git a/builtin/rerere.c b/builtin/rerere.c
index e89ccbc524..d78eeaed32 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -41,7 +41,8 @@ static int diff_two(const char *file1, const char *label1,
 	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	ecb.outf = outf;
+	ecb.out_hunk = NULL;
+	ecb.out_line = outf;
 	ret = xdi_diff(&minus, &plus, &xpp, &xecfg, &ecb);
 
 	free(minus.ptr);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index e7af95db86..25c185aff4 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -152,7 +152,7 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 	state.consume = fn;
 	state.consume_callback_data = consume_callback_data;
 	memset(&ecb, 0, sizeof(ecb));
-	ecb.outf = xdiff_outf;
+	ecb.out_line = xdiff_outf;
 	ecb.priv = &state;
 	strbuf_init(&state.remainder, 0);
 	ret = xdi_diff(mf1, mf2, xpp, xecfg, &ecb);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 2356da5f78..b158369020 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -86,7 +86,11 @@ typedef struct s_xpparam {
 
 typedef struct s_xdemitcb {
 	void *priv;
-	int (*outf)(void *, mmbuffer_t *, int);
+	int (*out_hunk)(void *,
+			long old_begin, long old_nr,
+			long new_begin, long new_nr,
+			const char *func, long funclen);
+	int (*out_line)(void *, mmbuffer_t *, int);
 } xdemitcb_t;
 
 typedef long (*find_func_t)(const char *line, long line_len, char *buffer, long buffer_size, void *priv);
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 88e5995535..963e1c58b9 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -54,7 +54,7 @@ int xdl_emit_diffrec(char const *rec, long size, char const *pre, long psize,
 		mb[2].size = strlen(mb[2].ptr);
 		i++;
 	}
-	if (ecb->outf(ecb->priv, mb, i) < 0) {
+	if (ecb->out_line(ecb->priv, mb, i) < 0) {
 
 		return -1;
 	}
@@ -344,8 +344,9 @@ int xdl_num_out(char *out, long val) {
 	return str - out;
 }
 
-int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
-		      const char *func, long funclen, xdemitcb_t *ecb) {
+static int xdl_format_hunk_hdr(long s1, long c1, long s2, long c2,
+			       const char *func, long funclen,
+			       xdemitcb_t *ecb) {
 	int nb = 0;
 	mmbuffer_t mb;
 	char buf[128];
@@ -387,9 +388,21 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
 
 	mb.ptr = buf;
 	mb.size = nb;
-	if (ecb->outf(ecb->priv, &mb, 1) < 0)
+	if (ecb->out_line(ecb->priv, &mb, 1) < 0)
 		return -1;
+	return 0;
+}
 
+int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
+		      const char *func, long funclen,
+		      xdemitcb_t *ecb) {
+	if (!ecb->out_hunk)
+		return xdl_format_hunk_hdr(s1, c1, s2, c2, func, funclen, ecb);
+	if (ecb->out_hunk(ecb->priv,
+			  c1 ? s1 : s1 - 1, c1,
+			  c2 ? s2 : s2 - 1, c2,
+			  func, funclen) < 0)
+		return -1;
 	return 0;
 }
 
-- 
2.19.1.1336.g081079ac04

