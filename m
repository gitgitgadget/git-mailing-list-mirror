Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 960431F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405181AbfBNFsP (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:48:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:43716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726129AbfBNFsP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:48:15 -0500
Received: (qmail 736 invoked by uid 109); 14 Feb 2019 05:48:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:48:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6825 invoked by uid 111); 14 Feb 2019 05:48:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:48:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:48:13 -0500
Date:   Thu, 14 Feb 2019 00:48:13 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 02/10] diff: drop unused color reset parameters
Message-ID: <20190214054813.GB20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several of the emit_* functions take a "reset" color parameter, but
never actually look at it (instead, they call into emit_diff_symbol,
which handles the colors itself). Let's drop these unused parameters.

Note that emit_line() does still take a color/reset pair, and actually
uses it. It cannot be refactored to match these other functions because
it's the thing that emit_diff_symbol eventually calls into (i.e., it
does not by itself know which colors to use, and must be told by the
caller).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 3e7d11fb70..de45bbd76e 100644
--- a/diff.c
+++ b/diff.c
@@ -1613,8 +1613,7 @@ static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line
 	return ws_blank_line(line, len, ecbdata->ws_rule);
 }
 
-static void emit_add_line(const char *reset,
-			  struct emit_callback *ecbdata,
+static void emit_add_line(struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
 	unsigned flags = WSEH_NEW | ecbdata->ws_rule;
@@ -1624,16 +1623,14 @@ static void emit_add_line(const char *reset,
 	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_PLUS, line, len, flags);
 }
 
-static void emit_del_line(const char *reset,
-			  struct emit_callback *ecbdata,
+static void emit_del_line(struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
 	unsigned flags = WSEH_OLD | ecbdata->ws_rule;
 	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_MINUS, line, len, flags);
 }
 
-static void emit_context_line(const char *reset,
-			      struct emit_callback *ecbdata,
+static void emit_context_line(struct emit_callback *ecbdata,
 			      const char *line, int len)
 {
 	unsigned flags = WSEH_CONTEXT | ecbdata->ws_rule;
@@ -1742,7 +1739,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
-	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
 		int len;
@@ -1751,10 +1747,10 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
-			emit_del_line(reset, ecb, data, len);
+			emit_del_line(ecb, data, len);
 		} else {
 			ecb->lno_in_postimage++;
-			emit_add_line(reset, ecb, data, len);
+			emit_add_line(ecb, data, len);
 		}
 		size -= len;
 		data += len;
@@ -2325,7 +2321,6 @@ static void find_lno(const char *line, struct emit_callback *ecbdata)
 static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	struct emit_callback *ecbdata = priv;
-	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 	struct diff_options *o = ecbdata->opt;
 
 	o->found_changes = 1;
@@ -2392,16 +2387,16 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	switch (line[0]) {
 	case '+':
 		ecbdata->lno_in_postimage++;
-		emit_add_line(reset, ecbdata, line + 1, len - 1);
+		emit_add_line(ecbdata, line + 1, len - 1);
 		break;
 	case '-':
 		ecbdata->lno_in_preimage++;
-		emit_del_line(reset, ecbdata, line + 1, len - 1);
+		emit_del_line(ecbdata, line + 1, len - 1);
 		break;
 	case ' ':
 		ecbdata->lno_in_postimage++;
 		ecbdata->lno_in_preimage++;
-		emit_context_line(reset, ecbdata, line + 1, len - 1);
+		emit_context_line(ecbdata, line + 1, len - 1);
 		break;
 	default:
 		/* incomplete line at the end */
-- 
2.21.0.rc1.567.g648f076c3f

