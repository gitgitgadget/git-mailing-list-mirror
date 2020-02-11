Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B26C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A9C20578
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 17:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgBKRTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:19:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:57562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729066AbgBKRTY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 12:19:24 -0500
Received: (qmail 8631 invoked by uid 109); 11 Feb 2020 17:19:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 17:19:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32148 invoked by uid 111); 11 Feb 2020 17:28:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 12:28:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 12:19:23 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/4] mailinfo: simplify parsing of header values
Message-ID: <20200211171923.GB2119034@coredump.intra.peff.net>
References: <20200211171649.GB2118476@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200211171649.GB2118476@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our code to parse header values first checks to see if a line starts
with a header, and then manually skips past the matched string to find
the value. We can do this all in one step by modeling after
skip_prefix(), which returns a pointer into the string after the
parsing.

This lets us remove some repeated strings, and will also enable us to
parse more flexibly in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 mailinfo.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 59d5a8b8f3..ee8d05e239 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -346,11 +346,16 @@ static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
 
-static inline int cmp_header(const struct strbuf *line, const char *hdr)
+static inline int skip_header(const struct strbuf *line, const char *hdr,
+			      const char **outval)
 {
-	int len = strlen(hdr);
-	return !strncasecmp(line->buf, hdr, len) && line->len > len &&
-			line->buf[len] == ':' && isspace(line->buf[len + 1]);
+	const char *val;
+	if (!skip_iprefix(line->buf, hdr, &val) ||
+	    *val++ != ':' ||
+	    !isspace(*val++))
+		return 0;
+	*outval = val;
+	return 1;
 }
 
 static int is_format_patch_separator(const char *line, int len)
@@ -547,17 +552,18 @@ static int check_header(struct mailinfo *mi,
 			const struct strbuf *line,
 			struct strbuf *hdr_data[], int overwrite)
 {
-	int i, ret = 0, len;
+	int i, ret = 0;
 	struct strbuf sb = STRBUF_INIT;
+	const char *val;
 
 	/* search for the interesting parts */
 	for (i = 0; header[i]; i++) {
-		int len = strlen(header[i]);
-		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i])) {
+		if ((!hdr_data[i] || overwrite) &&
+		    skip_header(line, header[i], &val)) {
 			/* Unwrap inline B and Q encoding, and optionally
 			 * normalize the meta information to utf8.
 			 */
-			strbuf_addstr(&sb, line->buf + len + 2);
+			strbuf_addstr(&sb, val);
 			decode_header(mi, &sb);
 			handle_header(&hdr_data[i], &sb);
 			ret = 1;
@@ -566,25 +572,22 @@ static int check_header(struct mailinfo *mi,
 	}
 
 	/* Content stuff */
-	if (cmp_header(line, "Content-Type")) {
-		len = strlen("Content-Type: ");
-		strbuf_addstr(&sb, line->buf + len);
+	if (skip_header(line, "Content-Type", &val)) {
+		strbuf_addstr(&sb, val);
 		decode_header(mi, &sb);
 		handle_content_type(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
-	if (cmp_header(line, "Content-Transfer-Encoding")) {
-		len = strlen("Content-Transfer-Encoding: ");
-		strbuf_addstr(&sb, line->buf + len);
+	if (skip_header(line, "Content-Transfer-Encoding", &val)) {
+		strbuf_addstr(&sb, val);
 		decode_header(mi, &sb);
 		handle_content_transfer_encoding(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
-	if (cmp_header(line, "Message-Id")) {
-		len = strlen("Message-Id: ");
-		strbuf_addstr(&sb, line->buf + len);
+	if (skip_header(line, "Message-Id", &val)) {
+		strbuf_addstr(&sb, val);
 		decode_header(mi, &sb);
 		if (mi->add_message_id)
 			mi->message_id = strbuf_detach(&sb, NULL);
@@ -606,8 +609,9 @@ static int is_inbody_header(const struct mailinfo *mi,
 			    const struct strbuf *line)
 {
 	int i;
+	const char *val;
 	for (i = 0; header[i]; i++)
-		if (!mi->s_hdr_data[i] && cmp_header(line, header[i]))
+		if (!mi->s_hdr_data[i] && skip_header(line, header[i], &val))
 			return 1;
 	return 0;
 }
-- 
2.25.0.708.g4c6f45973e

