Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A513EC352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F6F208C3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBKRUG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:20:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:57592 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728925AbgBKRUG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:20:06 -0500
Received: (qmail 8670 invoked by uid 109); 11 Feb 2020 17:20:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 17:20:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32188 invoked by uid 111); 11 Feb 2020 17:28:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 12:28:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 12:20:05 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 4/4] mailinfo: factor out some repeated header handling
Message-ID: <20200211172005.GD2119034@coredump.intra.peff.net>
References: <20200211171649.GB2118476@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211171649.GB2118476@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We do the same thing for each header: match it, copy it to a strbuf, and
decode it. Let's put that in a helper function to avoid repetition.

Signed-off-by: Jeff King <peff@peff.net>
---
 mailinfo.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 78f06da524..cf92255515 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -549,47 +549,54 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 		mi->input_error = -1;
 }
 
+/*
+ * Returns true if "line" contains a header matching "hdr", in which case "val"
+ * will contain the value of the header with any RFC2047 B and Q encoding
+ * unwrapped, and optionally normalize the meta information to utf8.
+ */
+static int parse_header(const struct strbuf *line,
+			const char *hdr,
+			struct mailinfo *mi,
+			struct strbuf *val)
+{
+	const char *val_str;
+
+	if (!skip_header(line, hdr, &val_str))
+		return 0;
+	strbuf_addstr(val, val_str);
+	decode_header(mi, val);
+	return 1;
+}
+
 static int check_header(struct mailinfo *mi,
 			const struct strbuf *line,
 			struct strbuf *hdr_data[], int overwrite)
 {
 	int i, ret = 0;
 	struct strbuf sb = STRBUF_INIT;
-	const char *val;
 
 	/* search for the interesting parts */
 	for (i = 0; header[i]; i++) {
 		if ((!hdr_data[i] || overwrite) &&
-		    skip_header(line, header[i], &val)) {
-			/* Unwrap inline B and Q encoding, and optionally
-			 * normalize the meta information to utf8.
-			 */
-			strbuf_addstr(&sb, val);
-			decode_header(mi, &sb);
+		    parse_header(line, header[i], mi, &sb)) {
 			handle_header(&hdr_data[i], &sb);
 			ret = 1;
 			goto check_header_out;
 		}
 	}
 
 	/* Content stuff */
-	if (skip_header(line, "Content-Type", &val)) {
-		strbuf_addstr(&sb, val);
-		decode_header(mi, &sb);
+	if (parse_header(line, "Content-Type", mi, &sb)) {
 		handle_content_type(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
-	if (skip_header(line, "Content-Transfer-Encoding", &val)) {
-		strbuf_addstr(&sb, val);
-		decode_header(mi, &sb);
+	if (parse_header(line, "Content-Transfer-Encoding", mi, &sb)) {
 		handle_content_transfer_encoding(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
-	if (skip_header(line, "Message-Id", &val)) {
-		strbuf_addstr(&sb, val);
-		decode_header(mi, &sb);
+	if (parse_header(line, "Message-Id", mi, &sb)) {
 		if (mi->add_message_id)
 			mi->message_id = strbuf_detach(&sb, NULL);
 		ret = 1;
-- 
2.25.0.708.g4c6f45973e
