Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5723A6400
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001163; cv=none; b=W4a9dOnktpMUBlBrcKkaffYIb8NrCICCmEb+4XJ2BmAFdixHIJdRFADf7aInhB8vdR9x5zf+BSW4fZNI+HGjqLKQPfkL+uhyoGY2bBN42A/dn8/2F5IHL8BV+DJDt7DHxYSptm9nTVczhUYg0KVT2Rp0ihuF9bj6C2HTig0okRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001163; c=relaxed/simple;
	bh=8QOUSS6q8gTLXrtcJ8v7sl580bcuEXW6wrd/Ux0oO3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAve64RXFC/6gr4e6UsOOfDngiaNZNokZp1+RpOLNmBV0zYru6Q8rhiNk4T5hjaPTEsO+SZKclgD5SDg2/xt7Qr1EDNCWkR7xujUOA95TEwlEt0NpjkWJt//FGvuzjrqnsX/FOgvhfp5qQ9Cp9ZvmmxBBJDn4c3bUCJkJb/0JQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZhZ6mBpz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZhZ6mBpz"
Received: (qmail 206721 invoked by uid 106); 31 Mar 2026 23:52:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=8QOUSS6q8gTLXrtcJ8v7sl580bcuEXW6wrd/Ux0oO3M=; b=ZhZ6mBpzSJf7JI03N/KoYDymZZTsw70Z4/NMKiYXinlqHU8DKDYm3FpK1NaXbgoR48YycTiZxPvSKD021G7XkZQRAOgx93isGAK3xDs1Qg+k0gJ6n93ibEKt7VKWGN23RNrnnOYcCs1n0wromfDPw5uhSbuoIKQ6BMr3QgLO5zHXrxag/2abd8Vx0ykndhpOop7IMxjbGj9GRpCNzcuIcalAiiw2tf8Teh9WBKqrqPnBSaTGFw6S26ndkPHnjy8GHckp/JWPfLn8z720/61QTNL+3K8QUFtNuqhu4PxXOddRL+E6oTHhbc+BdcoEeaw3zU0D7wt32VTybLPQlNbUHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:52:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326611 invoked by uid 111); 31 Mar 2026 23:52:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:52:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:52:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 11/12] http: drop const to fix strstr() warning
Message-ID: <20260331235240.GK2328529@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

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
 git-compat-util.h | 3 +++
 http.c            | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 58e494e037..f60793fc36 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -914,6 +914,9 @@ static inline bool skip_iprefix(const char *str, const char *prefix,
 	return false;
 }
 
+#define skip_iprefix(str, prefix, out) \
+	skip_iprefix((str), (prefix), CONST_OUTPARAM((str), (out)))
+
 /*
  * Like skip_prefix_mem, but compare case-insensitively. Note that the
  * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
diff --git a/http.c b/http.c
index 8ea1b9d1f6..8801bd22fe 100644
--- a/http.c
+++ b/http.c
@@ -726,7 +726,7 @@ static int has_proxy_cert_password(void)
 static int redact_sensitive_header(struct strbuf *header, size_t offset)
 {
 	int ret = 0;
-	const char *sensitive_header;
+	char *sensitive_header;
 
 	if (trace_curl_redact &&
 	    (skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
@@ -743,7 +743,7 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 	} else if (trace_curl_redact &&
 		   skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
-		const char *cookie;
+		char *cookie;
 
 		while (isspace(*sensitive_header))
 			sensitive_header++;
-- 
2.53.0.1136.gd760fbd4a0

