Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A93603EB
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103317; cv=none; b=tkXyZZryJKrFgnUtZ84Mucu9P0Wm7RjFJjB3N/+fRNL+utznizVrv2VsQq9fOy7G3I/RDyk4XJAvRSJWNvRg5ZSvKhBm02tvRITn4Is6yKFCi1JpoKnNESnJueCpMfVX6GOAgMw10hSMxKQ5W4gYEqEP+XDA2/+Pn/BFlRNEo1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103317; c=relaxed/simple;
	bh=7WiO7Nu7jpeObH9t8vjy6e2HAGC6nLRhiCSM/LEUodg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebA2tP5j0BdVrcKElwzIcWJ2+SwLmDvcb2MXafa8UrsnF1slBIqwHBonzFcU2k8pA1QY03ENBDeOjgIF2GlkEGpMbRiTa6Z7HJWfqQRHPCeGXT09ZC33dmeinDb6Vsk3FlSwuBshkCiU0Nt8j2UeVu4X8GQqiqeG/9b0Q3dZ6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F9OYic3m; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F9OYic3m"
Received: (qmail 218932 invoked by uid 106); 2 Apr 2026 04:15:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7WiO7Nu7jpeObH9t8vjy6e2HAGC6nLRhiCSM/LEUodg=; b=F9OYic3m0H8/D5ZvNrpZlQZ8Ng8OvMGj8JlJVCgvqS4mIm4mf0+ATYJIA/mIvi0iDifNYK4mxVVxkjL8GRC6r4Ls5488TDNjiuGlnIL+UhpTDcwPLJsb60HdPRUtq2D3Ikt+m9jfq3A/7mSt/s7B329ipY8jdDhrIP1B0ADhsFNxOJPYdZw93pGUHXBravE6w0FhYZizgGzTdReFvilUYfaB6NigN127XRP94BBcw8LXOhhVCmY7bVK/sC6v6cKRFYyo/yASYg9YqdvcCIbucXXGN5PYSewHt+DYni9uUXPFs+S/wIR8hHGo6HieQJxQdB43MZhOU97MY+93U/XeqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349788 invoked by uid 111); 2 Apr 2026 04:15:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:15 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:14 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 11/12] http: drop const to fix strstr() warning
Message-ID: <20260402041514.GK3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

In redact_sensitive_header(), a C23 implementation of libc will complain
that strstr() assigns the result from "const char *cookie" to "char
*semicolon".

Ultimately the memory is writable. We're fed a strbuf, generate a const
pointer "sensitive_header" within it using skip_iprefix(), and then
assign the result to "cookie".  So we can solve this by dropping the
const from "cookie" and "sensitive_header".

However, this runs afoul of skip_iprefix(), which wants a "const char
**" for its out-parameter. We can solve that by teaching skip_iprefix()
the same "make sure out is at least as const as in" magic that we
recently taught to skip_prefix().

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 6 ++++--
 http.c            | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e9629b2a9d..4ddac61992 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -902,8 +902,10 @@ static inline size_t xsize_t(off_t len)
  * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
  * locale-specific conversions).
  */
-static inline bool skip_iprefix(const char *str, const char *prefix,
-			       const char **out)
+#define skip_iprefix(str, prefix, out) \
+	skip_iprefix_impl((str), (prefix), CONST_OUTPARAM((str), (out)))
+static inline bool skip_iprefix_impl(const char *str, const char *prefix,
+				     const char **out)
 {
 	do {
 		if (!*prefix) {
diff --git a/http.c b/http.c
index d8d016891b..67c9c6fc60 100644
--- a/http.c
+++ b/http.c
@@ -748,7 +748,7 @@ static int has_proxy_cert_password(void)
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
 	int ret = 0;
-	const char *sensitive_header;
+	char *sensitive_header;
 
 	if (trace_curl_redact &&
 	    (skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
@@ -765,7 +765,7 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 	} else if (trace_curl_redact &&
 		   skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
-		const char *cookie;
+		char *cookie;
 
 		while (isspace(*sensitive_header))
 			sensitive_header++;
-- 
2.53.0.1172.ge9e20b5838

