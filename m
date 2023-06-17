Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E13EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 05:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjFQFbg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 01:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjFQFbd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 01:31:33 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B3211D
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 22:31:31 -0700 (PDT)
Received: (qmail 12197 invoked by uid 109); 17 Jun 2023 05:31:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 05:31:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6767 invoked by uid 111); 17 Jun 2023 05:31:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 01:31:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 01:31:29 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] http: handle both "h2" and "h2h3" in curl info lines
Message-ID: <20230617053129.GE562686@coredump.intra.peff.net>
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230617044232.GC562686@coredump.intra.peff.net>
 <20230617051559.GD562686@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230617051559.GD562686@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 01:15:59AM -0400, Jeff King wrote:

> diff --git a/http.c b/http.c
> index bb58bb3e6a..b71bb1e3ad 100644
> --- a/http.c
> +++ b/http.c
> @@ -746,7 +746,8 @@ static void redact_sensitive_info_header(struct strbuf *header)
>  	 *   h2h3 [<header-name>: <header-val>]
>  	 */
>  	if (trace_curl_redact &&
> -	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> +	    (skip_iprefix(header->buf, "h2h3 [", &sensitive_header) ||
> +	     skip_iprefix(header->buf, "h2 [", &sensitive_header))) {
>  		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
>  			/* redaction ate our closing bracket */
>  			strbuf_addch(header, ']');

I of course found it unsatisfying that we are not taking advantage of
the fact that "h2" is a subset of "h2h3". But optionally skipping past
h3 in the middle of an &&-chain is awkward (you have to write
"skip_prefix() || 1"). We could rewrite it with early returns, as below,
but I think the result is probably less readable.

diff --git a/http.c b/http.c
index b71bb1e3ad..1abfaad4c1 100644
--- a/http.c
+++ b/http.c
@@ -741,17 +741,23 @@ static void redact_sensitive_info_header(struct strbuf *header)
 {
 	const char *sensitive_header;
 
+	if (!trace_curl_redact)
+		return;
+
 	/*
-	 * curl's h2h3 prints headers in info, e.g.:
+	 * curl's http/2 prints headers in info with either an "h2" or an
+	 * "h2h3" prefix, e.g.:
 	 *   h2h3 [<header-name>: <header-val>]
 	 */
-	if (trace_curl_redact &&
-	    (skip_iprefix(header->buf, "h2h3 [", &sensitive_header) ||
-	     skip_iprefix(header->buf, "h2 [", &sensitive_header))) {
-		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
-			/* redaction ate our closing bracket */
-			strbuf_addch(header, ']');
-		}
+	if (!skip_iprefix(header->buf, "h2", &sensitive_header))
+		return;
+	skip_iprefix(sensitive_header, "h3", &sensitive_header);
+	if (!skip_prefix(sensitive_header, " [", &sensitive_header))
+		return;
+
+	if (redact_sensitive_header(header, sensitive_header - header->buf)) {
+		/* redaction ate our closing bracket */
+		strbuf_addch(header, ']');
 	}
 }
 
