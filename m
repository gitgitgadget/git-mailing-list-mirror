Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70522EB64D9
	for <git@archiver.kernel.org>; Sat, 17 Jun 2023 05:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjFQFQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jun 2023 01:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQFQC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2023 01:16:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB71AB
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 22:16:00 -0700 (PDT)
Received: (qmail 10840 invoked by uid 109); 17 Jun 2023 05:16:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Jun 2023 05:16:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6682 invoked by uid 111); 17 Jun 2023 05:16:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Jun 2023 01:16:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 17 Jun 2023 01:15:59 -0400
From:   Jeff King <peff@peff.net>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] http: handle both "h2" and "h2h3" in curl info lines
Message-ID: <20230617051559.GD562686@coredump.intra.peff.net>
References: <kl6lilbnrrl1.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230617044232.GC562686@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230617044232.GC562686@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 12:42:32AM -0400, Jeff King wrote:

> Looking at the string it prints, curl gave us "h2 [...".  But your
> b637a41ebe (http: redact curl h2h3 headers in info, 2022-11-11) looks
> for "h2h3 [...". I don't know why curl would print one versus the other.
> The solution may be something like:
> 
> diff --git a/http.c b/http.c
> index bb58bb3e6a..283410b3c7 100644
> --- a/http.c
> +++ b/http.c
> @@ -746,7 +746,8 @@ static void redact_sensitive_info_header(struct strbuf *header)
>  	 *   h2h3 [<header-name>: <header-val>]
>  	 */
>  	if (trace_curl_redact &&
> -	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
> +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header) ||
> +	    skip_iprefix(header->buf, "h2 [", &sensitive_header)) {
>  		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
>  			/* redaction ate our closing bracket */
>  			strbuf_addch(header, ']');
> 
> but it would be nice to have some explanation of why we would see each
> one.

Ah, I see. It looks like it depends on which version of curl is using.
Perhaps the macOS image in CI has been updated (or maybe the new version
just became available via brew or something). I was able to replicate on
my Linux system by building and linking against curl 8.1.0, and the
patch above (modulo some missing parentheses) fixes it.

So here's that patch with a commit message, though note that t5559.30
seems to reliably fail with a timeout for me on the new version of curl. :(

-- >8 --
Subject: [PATCH] http: handle both "h2" and "h2h3" in curl info lines

When redacting auth tokens in trace output from curl, we look for http/2
headers of the form "h2h3 [header: value]". This comes from b637a41ebe
(http: redact curl h2h3 headers in info, 2022-11-11).

But the "h2h3" prefix changed to just "h2" in curl's fc2f1e547 (http2:
support HTTP/2 to forward proxies, non-tunneling, 2023-04-14). That's in
released version curl 8.1.0; linking against that version means we'll
fail to correctly redact the trace. Our t5559.17 notices and fails.

We can fix this by matching either prefix, which should handle both old
and new versions.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index bb58bb3e6a..b71bb1e3ad 100644
--- a/http.c
+++ b/http.c
@@ -746,7 +746,8 @@ static void redact_sensitive_info_header(struct strbuf *header)
 	 *   h2h3 [<header-name>: <header-val>]
 	 */
 	if (trace_curl_redact &&
-	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
+	    (skip_iprefix(header->buf, "h2h3 [", &sensitive_header) ||
+	     skip_iprefix(header->buf, "h2 [", &sensitive_header))) {
 		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
 			/* redaction ate our closing bracket */
 			strbuf_addch(header, ']');
-- 
2.41.0.402.g53108db102

