Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0AEC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E855C20578
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgBKRSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:18:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:57554 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729232AbgBKRSx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:18:53 -0500
Received: (qmail 8616 invoked by uid 109); 11 Feb 2020 17:18:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 17:18:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32122 invoked by uid 111); 11 Feb 2020 17:27:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 12:27:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 12:18:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/4] mailinfo: treat header values as C strings
Message-ID: <20200211171852.GA2119034@coredump.intra.peff.net>
References: <20200211171649.GB2118476@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211171649.GB2118476@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We read each header line into a strbuf, which means that we could
in theory handle header values with embedded NUL bytes. But in practice,
the values we parse out are passed to decode_header(), which uses
strstr(), strchr(), etc. And we would not expect such bytes anyway; they
are forbidden by RFC822, etc and any non-ASCII characters should be
encoded with RFC2047 encoding.

So let's switch to using strbuf_addstr(), which saves us some length
computations (and will enable further cleanups in this code).

Signed-off-by: Jeff King <peff@peff.net>
---
We _could_ skip this and compute the length later as:

  line->len - (val - line->buf)

but I like the simplification.

 mailinfo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 402ef04dd1..59d5a8b8f3 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -557,7 +557,7 @@ static int check_header(struct mailinfo *mi,
 			/* Unwrap inline B and Q encoding, and optionally
 			 * normalize the meta information to utf8.
 			 */
-			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
+			strbuf_addstr(&sb, line->buf + len + 2);
 			decode_header(mi, &sb);
 			handle_header(&hdr_data[i], &sb);
 			ret = 1;
@@ -568,23 +568,23 @@ static int check_header(struct mailinfo *mi,
 	/* Content stuff */
 	if (cmp_header(line, "Content-Type")) {
 		len = strlen("Content-Type: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
+		strbuf_addstr(&sb, line->buf + len);
 		decode_header(mi, &sb);
 		handle_content_type(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
 	if (cmp_header(line, "Content-Transfer-Encoding")) {
 		len = strlen("Content-Transfer-Encoding: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
+		strbuf_addstr(&sb, line->buf + len);
 		decode_header(mi, &sb);
 		handle_content_transfer_encoding(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
 	if (cmp_header(line, "Message-Id")) {
 		len = strlen("Message-Id: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
+		strbuf_addstr(&sb, line->buf + len);
 		decode_header(mi, &sb);
 		if (mi->add_message_id)
 			mi->message_id = strbuf_detach(&sb, NULL);
-- 
2.25.0.708.g4c6f45973e

