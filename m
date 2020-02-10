Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85321C352A5
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 23:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DE82082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 23:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBJXo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:44:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:57000 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727192AbgBJXo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 18:44:28 -0500
Received: (qmail 3385 invoked by uid 109); 10 Feb 2020 23:44:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Feb 2020 23:44:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27288 invoked by uid 111); 10 Feb 2020 23:53:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Feb 2020 18:53:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Feb 2020 18:44:27 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
Message-ID: <20200210234427.GA632160@coredump.intra.peff.net>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 09, 2020 at 12:36:22PM -0500, Eric Sunshine wrote:

> On Sun, Feb 9, 2020 at 8:45 AM René Scharfe <l.s.r@web.de> wrote:
> > Add a function for inserting a C string into a strbuf.  Use it
> > throughout the source to get rid of magic string length constants and
> > explicit strlen() calls.
> >
> > Like strbuf_addstr(), implement it as an inline function to avoid the
> > implicit strlen() calls to cause runtime overhead.
> >
> > Signed-off-by: René Scharfe <l.s.r@web.de>
> > ---
> > diff --git a/mailinfo.c b/mailinfo.c
> > @@ -570,7 +570,7 @@ static int check_header(struct mailinfo *mi,
> >                 len = strlen("Content-Type: ");
> >                 strbuf_add(&sb, line->buf + len, line->len - len);
> >                 decode_header(mi, &sb);
> > -               strbuf_insert(&sb, 0, "Content-Type: ", len);
> > +               strbuf_insertstr(&sb, 0, "Content-Type: ");
> >                 handle_content_type(mi, &sb);
> 
> Meh. We've already computed the length of "Content-Type: " a few lines
> earlier, so taking advantage of that value when inserting the string
> literal is perfectly sensible. Thus, I'm not convinced that this
> change is an improvement.

I had a similar thought. I kind of wonder if all of these "len" bits
(and their repeated strings) could go away if cmp_header() just used
skip_iprefix() under the hood and had a pointer out-parameter.

Something like the (largely untested) patch below. That would also make
it easy to support arbitrary amounts of whitespace after the header,
which I think are allowed by the standard (whereas now we'd parse
"Content-type:    text/plain" as "    text/plain", which is silly).

Worth doing?

---
diff --git a/mailinfo.c b/mailinfo.c
index b395adbdf2..bbb5b429f8 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -346,11 +346,16 @@ static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
 
-static inline int cmp_header(const struct strbuf *line, const char *hdr)
+static inline int cmp_header(const struct strbuf *line, const char *hdr,
+			     const char **outval)
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
@@ -547,17 +552,17 @@ static int check_header(struct mailinfo *mi,
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
+		if ((!hdr_data[i] || overwrite) && cmp_header(line, header[i], &val)) {
 			/* Unwrap inline B and Q encoding, and optionally
 			 * normalize the meta information to utf8.
 			 */
-			strbuf_add(&sb, line->buf + len + 2, line->len - len - 2);
+			strbuf_addstr(&sb, val);
 			decode_header(mi, &sb);
 			handle_header(&hdr_data[i], &sb);
 			ret = 1;
@@ -566,26 +571,22 @@ static int check_header(struct mailinfo *mi,
 	}
 
 	/* Content stuff */
-	if (cmp_header(line, "Content-Type")) {
-		len = strlen("Content-Type: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
+	if (cmp_header(line, "Content-Type", &val)) {
+		strbuf_addstr(&sb, val);
 		decode_header(mi, &sb);
-		strbuf_insert(&sb, 0, "Content-Type: ", len);
 		handle_content_type(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
-	if (cmp_header(line, "Content-Transfer-Encoding")) {
-		len = strlen("Content-Transfer-Encoding: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
+	if (cmp_header(line, "Content-Transfer-Encoding", &val)) {
+		strbuf_addstr(&sb, val);
 		decode_header(mi, &sb);
 		handle_content_transfer_encoding(mi, &sb);
 		ret = 1;
 		goto check_header_out;
 	}
-	if (cmp_header(line, "Message-Id")) {
-		len = strlen("Message-Id: ");
-		strbuf_add(&sb, line->buf + len, line->len - len);
+	if (cmp_header(line, "Message-Id", &val)) {
+		strbuf_addstr(&sb, val);
 		decode_header(mi, &sb);
 		if (mi->add_message_id)
 			mi->message_id = strbuf_detach(&sb, NULL);
@@ -607,8 +608,9 @@ static int is_inbody_header(const struct mailinfo *mi,
 			    const struct strbuf *line)
 {
 	int i;
+	const char *val;
 	for (i = 0; header[i]; i++)
-		if (!mi->s_hdr_data[i] && cmp_header(line, header[i]))
+		if (!mi->s_hdr_data[i] && cmp_header(line, header[i], &val))
 			return 1;
 	return 0;
 }
