Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41C21F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeKBPmN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:42:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:37716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727745AbeKBPmN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:42:13 -0400
Received: (qmail 29454 invoked by uid 109); 2 Nov 2018 06:36:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:36:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 949 invoked by uid 111); 2 Nov 2018 06:35:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:35:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:36:06 -0400
Date:   Fri, 2 Nov 2018 02:36:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/9] diff: avoid generating unused hunk header lines
Message-ID: <20181102063606.GC31216@sigill.intra.peff.net>
References: <20181102063156.GA30252@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102063156.GA30252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some callers of xdi_diff_outf() do not look at the generated hunk header
lines at all. By plugging in a no-op hunk callback, this tells xdiff not
to even bother formatting them.

This patch introduces a stock no-op callback and uses it with a few
callers whose line callbacks explicitly ignore hunk headers (because
they look only for +/- lines).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c             | 4 ++--
 diffcore-pickaxe.c | 3 ++-
 xdiff-interface.c  | 6 ++++++
 xdiff-interface.h  | 6 ++++++
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 07be5879e5..d84356e007 100644
--- a/diff.c
+++ b/diff.c
@@ -3637,8 +3637,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xpp.anchors_nr = o->anchors_nr;
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
-		if (xdi_diff_outf(&mf1, &mf2, NULL, diffstat_consume,
-				  diffstat, &xpp, &xecfg))
+		if (xdi_diff_outf(&mf1, &mf2, discard_hunk_line,
+				  diffstat_consume, diffstat, &xpp, &xecfg))
 			die("unable to generate diffstat for %s", one->path);
 	}
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 58df35670a..69fc55ea1e 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -62,7 +62,8 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	ecbdata.hit = 0;
 	xecfg.ctxlen = o->context;
 	xecfg.interhunkctxlen = o->interhunkcontext;
-	if (xdi_diff_outf(one, two, NULL, diffgrep_consume, &ecbdata, &xpp, &xecfg))
+	if (xdi_diff_outf(one, two, discard_hunk_line, diffgrep_consume,
+			  &ecbdata, &xpp, &xecfg))
 		return 0;
 	return ecbdata.hit;
 }
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 16d37ce6be..2622981d97 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -157,6 +157,12 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
 	return xdl_diff(&a, &b, xpp, xecfg, xecb);
 }
 
+void discard_hunk_line(void *priv,
+		       long ob, long on, long nb, long nn,
+		       const char *func, long funclen)
+{
+}
+
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_hunk_fn hunk_fn,
 		  xdiff_emit_line_fn line_fn,
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 2dbe2feb19..7b0ccbdd1d 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -35,6 +35,12 @@ extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
 extern int git_xmerge_config(const char *var, const char *value, void *cb);
 extern int git_xmerge_style;
 
+/*
+ * Can be used as a no-op hunk_fn for xdi_diff_outf(), since a NULL
+ * one just sends the hunk line to the line_fn callback).
+ */
+void discard_hunk_line(void *, long, long, long, long, const char *, long);
+
 /*
  * Compare the strings l1 with l2 which are of size s1 and s2 respectively.
  * Returns 1 if the strings are deemed equal, 0 otherwise.
-- 
2.19.1.1336.g081079ac04

