Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89A7C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 02:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKC6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 21:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKKC6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 21:58:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25F3205C7
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 18:58:12 -0800 (PST)
Received: (qmail 28450 invoked by uid 109); 11 Nov 2022 02:38:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Nov 2022 02:38:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 309 invoked by uid 111); 11 Nov 2022 02:38:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Nov 2022 21:38:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Nov 2022 21:38:08 -0500
From:   Jeff King <peff@peff.net>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] http: redact curl h2h3 headers in info
Message-ID: <Y221kGaQUfZJznO9@coredump.intra.peff.net>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 10:57:34PM +0000, Glen Choo via GitGitGadget wrote:

> +/* Redact headers in info */
> +static void redact_sensitive_info_header(struct strbuf *header)
> +{
> +	const char *sensitive_header;
> +
> +	/*
> +	 * curl's h2h3 prints headers in info, e.g.:
> +	 *   h2h3 [<header-name>: <header-val>]
> +	 */
> +	if (trace_curl_redact &&
> +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> +		struct strbuf inner = STRBUF_INIT;
> +
> +		/* Drop the trailing "]" */
> +		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);

This will misbehave if fed the string "h2h3 [", because that strlen()
becomes 0, and the subtraction underflows.

Unlikely, since we are being fed by curl, but possibly worth asserting
(though see below for an alternative which drops this line).

> +		if (redact_sensitive_header(&inner)) {
> +			strbuf_setlen(header, strlen("h2h3 ["));

This strlen may be better spelled as:

  sensitive_header - header->buf

which IMHO makes it more clear that our intent is to truncate based on
the pointer we computed by skipping (and has no chance of getting out of
sync with the earlier copy of the string).

It's also a little more robust, in that it doesn't depend on "h2h3"
being at the beginning of the string (though in practice it must be,
because that's where skip_iprefix() is checking). See below on that.

> +			strbuf_addbuf(header, &inner);
> +			strbuf_addch(header, ']');
> +		}
> +
> +		strbuf_release(&inner);

This will do a new allocation/free for each info line, even if it's not
redacted. It's probably premature optimization to worry about it, but
you could do it all in the original strbuf, if we inform
redact_sensitive_header() of the offset at which it should look for the
header (and because it uses "sensitive_header - header->buf" for the
truncation, it handles the extra "h2h3" at the beginning just fine).
Something like:

diff --git a/http.c b/http.c
index 8135fac283..8a5ba3f477 100644
--- a/http.c
+++ b/http.c
@@ -561,14 +561,14 @@ static void set_curl_keepalive(CURL *c)
 #endif
 
 /* Return 1 if redactions have been made, 0 otherwise. */
-static int redact_sensitive_header(struct strbuf *header)
+static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
 	int ret = 0;
 	const char *sensitive_header;
 
 	if (trace_curl_redact &&
-	    (skip_iprefix(header->buf, "Authorization:", &sensitive_header) ||
-	     skip_iprefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
+	    (skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
+	     skip_iprefix(header->buf + offset, "Proxy-Authorization:", &sensitive_header))) {
 		/* The first token is the type, which is OK to log */
 		while (isspace(*sensitive_header))
 			sensitive_header++;
@@ -579,7 +579,7 @@ static int redact_sensitive_header(struct strbuf *header)
 		strbuf_addstr(header, " <redacted>");
 		ret = 1;
 	} else if (trace_curl_redact &&
-		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
+		   skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
 		const char *cookie;
 
@@ -631,17 +631,10 @@ static void redact_sensitive_info_header(struct strbuf *header)
 	 */
 	if (trace_curl_redact &&
 	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
-		struct strbuf inner = STRBUF_INIT;
-
-		/* Drop the trailing "]" */
-		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
-		if (redact_sensitive_header(&inner)) {
-			strbuf_setlen(header, strlen("h2h3 ["));
-			strbuf_addbuf(header, &inner);
+		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
+			/* redaction ate our closing bracket */
 			strbuf_addch(header, ']');
 		}
-
-		strbuf_release(&inner);
 	}
 }
 
@@ -659,7 +652,7 @@ static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
 
 	for (header = headers; *header; header++) {
 		if (hide_sensitive_header)
-			redact_sensitive_header(*header);
+			redact_sensitive_header(*header, 0);
 		strbuf_insertstr((*header), 0, text);
 		strbuf_insertstr((*header), strlen(text), ": ");
 		strbuf_rtrim((*header));
