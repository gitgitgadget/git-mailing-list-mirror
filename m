Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11031F597
	for <e@80x24.org>; Tue, 24 Jul 2018 10:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbeGXL5B (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 07:57:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:57300 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388315AbeGXL5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 07:57:01 -0400
Received: (qmail 10922 invoked by uid 109); 24 Jul 2018 10:51:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 10:51:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26404 invoked by uid 111); 24 Jul 2018 10:51:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 06:51:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 06:51:08 -0400
Date:   Tue, 24 Jul 2018 06:51:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] strbuf: use size_t for length in intermediate variables
Message-ID: <20180724105108.GC17165@sigill.intra.peff.net>
References: <20180724104852.GA14638@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724104852.GA14638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few strbuf functions store the length of a strbuf in a
temporary variable. We should always use size_t for this, as
it's possible for a strbuf to exceed an "int" (e.g., a 2GB
string on a 64-bit system). This is unlikely in practice,
but we should try to behave sensibly on silly or malicious
input.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index e79758b942..6ff1f80129 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -209,7 +209,7 @@ void strbuf_list_free(struct strbuf **sbs)
 
 int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
 {
-	int len = a->len < b->len ? a->len: b->len;
+	size_t len = a->len < b->len ? a->len: b->len;
 	int cmp = memcmp(a->buf, b->buf, len);
 	if (cmp)
 		return cmp;
@@ -389,7 +389,7 @@ size_t strbuf_expand_dict_cb(struct strbuf *sb, const char *placeholder,
 
 void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src)
 {
-	int i, len = src->len;
+	size_t i, len = src->len;
 
 	for (i = 0; i < len; i++) {
 		if (src->buf[i] == '%')
@@ -960,7 +960,7 @@ static size_t cleanup(char *line, size_t len)
  */
 void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 {
-	int empties = 0;
+	size_t empties = 0;
 	size_t i, j, len, newlen;
 	char *eol;
 
-- 
2.18.0.542.g2bf2fc4f7e

