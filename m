Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CBDEED61A
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 18:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjIOSWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjIOSWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 14:22:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454211FD7
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 11:22:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC1032EE38;
        Fri, 15 Sep 2023 14:22:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=0L0+HAJBsh/KnJW8ZvKVAhbDveD0moajpT/KjD
        D8J2k=; b=tj/T6r+1pWLlcSSy7eQM3m+ohyLt8DAcP6tZVldp8fqX91cURGfnEQ
        Bx2oan5XHDDd6qOXdzNuBSoTbeCkKCLF6Urdet5FhK0H5iXNqVtxcemgeizs/0IG
        oK22BQyrrowLSpHUdF15df6HuJ6yYgRgAyWIZGOKTCwkoBomwl/t0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B498C2EE37;
        Fri, 15 Sep 2023 14:22:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8073B2EE2C;
        Fri, 15 Sep 2023 14:21:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: update curl http/2 info matching for curl 8.3.0
In-Reply-To: <20230915113443.GB3531587@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 15 Sep 2023 07:34:43 -0400")
References: <20230915113237.GA3531328@coredump.intra.peff.net>
        <20230915113443.GB3531587@coredump.intra.peff.net>
Date:   Fri, 15 Sep 2023 11:21:55 -0700
Message-ID: <xmqqsf7fe1q4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C15025FE-53F4-11EE-AC74-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> @@ -751,6 +753,18 @@ static int match_curl_h2_trace(const char *line, const char **out)
>  	    skip_iprefix(line, "h2 [", out))
>  		return 1;
>  
> +	/*
> +	 * curl 8.3.0 uses:
> +	 *   [HTTP/2] [<stream-id>] [<header-name>: <header-val>]
> +	 * where <stream-id> is numeric.
> +	 */
> +	if (skip_iprefix(line, "[HTTP/2] [", &p)) {
> +		while (isdigit(*p))
> +			p++;
> +		if (skip_prefix(p, "] [", out))
> +			return 1;
> +	}

Looking good assuming that <stream-id> part will never be updated to
allow spaces around the ID, or allow non-digits in the ID, in the
future.  Is there much harm if this code allowed false positives and
sent something that is *not* a curl trace, like "foo]" parsed out of
"[HTTP/2] [PATCH] [foo]", to redact_sensitive_header() function?

By the way, would this patch make sense?  Everybody in the function
that try to notice a sensitive header seems to check the sentting
independently, which seems error prone for those who want to add a
new header to redact.

 http.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git c/http.c w/http.c
index 8f71bf00d8..3dfa34fe65 100644
--- c/http.c
+++ w/http.c
@@ -684,8 +684,10 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 	int ret = 0;
 	const char *sensitive_header;
 
-	if (trace_curl_redact &&
-	    (skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
+	if (!trace_curl_redact)
+		return ret;
+
+	if ((skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
 	     skip_iprefix(header->buf + offset, "Proxy-Authorization:", &sensitive_header))) {
 		/* The first token is the type, which is OK to log */
 		while (isspace(*sensitive_header))
@@ -696,8 +698,7 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 		strbuf_setlen(header,  sensitive_header - header->buf);
 		strbuf_addstr(header, " <redacted>");
 		ret = 1;
-	} else if (trace_curl_redact &&
-		   skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
+	} else if (skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
 		const char *cookie;
 
