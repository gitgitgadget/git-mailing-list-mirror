Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE611F2BAD
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070585; cv=none; b=BlN87zhbnx/k1IXgaqJmly2FzrPEIZ47umlcY2XFLVfhwBrBBCzdQD6+pIWVbPvMDrVIhGXmwHFEDHq2PagpLTfht4QM3+Q3JEf/PBJgQyl2F/2S2KnrA4G0wbkbCJZJ9THM7dMDxNYLBX0yVTvrGkthWFkdvVLqRWThkE1fPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070585; c=relaxed/simple;
	bh=zAp6EqKo9VWueXlLMYgxHdCcqoE88QIUFjPXyM9kbAI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBbeb7zKwfHqFqhe6KUlNfg/WLO/zcnNf2/zyAhkD4r/R/bdHELqUT9B23SHWYsQbNm35aGJbMMWqE93AGqGjgrAUGQ7rPKD1sQblg37N4Fzx9VBH46G8lQqQ+bHpUZGib2IyEWbr4BCAcyCDe+04GnA+/Kpt2ydYiT4xv32Lkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hlhb1NXV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hlhb1NXV"
Received: (qmail 14304 invoked by uid 109); 4 Jun 2025 20:56:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zAp6EqKo9VWueXlLMYgxHdCcqoE88QIUFjPXyM9kbAI=; b=hlhb1NXVUFuf0+SMFT2WrqlAWQe+5kk95QM075XSYXsIdiOM3JPSN2Fxe0vJph1GyWG+wAju42xZM4YsVTUeC+o7wRcCivqHkoFUohuBfhCR5OLwCY2e2wp5HiITdz9bn+uYmbiR96N9/DfbARVdz4Q1A2Dr2KoOI39/6WpSaNNKXcnb1aTc9BjnHng4qSUA4v7SUR14PKBQ9ste/pFH6CuPdJmGiSFgCKnRnf9zmSCD8pLWm2mtAX6y1AAdadXaeUQI7GoBrOfqUw1iTfjmWYuQ7zhiTwjDCEZ2DoP1czCFd7WXUs13sPC8THZCiwn/JYRORqO0X/Q4h0/mZzmblA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jun 2025 20:56:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13768 invoked by uid 111); 4 Jun 2025 20:56:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jun 2025 16:56:24 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Jun 2025 16:56:22 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/3] curl: fix symbolic constant typechecks with
 curl_easy_setopt()
Message-ID: <20250604205622.GC1510819@coredump.intra.peff.net>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604205505.GA1510724@coredump.intra.peff.net>

As with the previous two commits, we should be passing long integers,
not regular ones, to curl_easy_setopt(), and compiling against curl 8.14
loudly complains if we don't.

This patch catches the remaining cases, which are ones where we pass
curl's own symbolic constants. We'll cast them to long manually in each
call.

It seems kind of weird to me that curl doesn't define these constants as
longs, since the point of them is to pass to curl_easy_setopt(). But in
the curl documentation and examples, they clearly show casting them as
part of the setopt calls. It may be that there is some reason not to
push the type into the macro, like backwards compatibility. I didn't
dig, as it doesn't really matter: we have to follow what existing curl
versions ask for anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/http.c b/http.c
index cce2ea7287..ecbc47ea4b 100644
--- a/http.c
+++ b/http.c
@@ -1057,7 +1057,7 @@ static CURL *get_curl_handle(void)
 
 	if (http_ssl_backend && !strcmp("schannel", http_ssl_backend) &&
 	    !http_schannel_check_revoke) {
-		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
+		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, (long)CURLSSLOPT_NO_REVOKE);
 	}
 
 	if (http_proactive_auth != PROACTIVE_AUTH_NONE)
@@ -1118,7 +1118,7 @@ static CURL *get_curl_handle(void)
 	}
 
 	curl_easy_setopt(result, CURLOPT_MAXREDIRS, 20L);
-	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
+	curl_easy_setopt(result, CURLOPT_POSTREDIR, (long)CURL_REDIR_POST_ALL);
 
 #ifdef GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR
 	{
@@ -1193,18 +1193,18 @@ static CURL *get_curl_handle(void)
 
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5_HOSTNAME);
 		else if (starts_with(curl_http_proxy, "socks5"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS5);
 		else if (starts_with(curl_http_proxy, "socks4a"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4A);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4A);
 		else if (starts_with(curl_http_proxy, "socks"))
 			curl_easy_setopt(result,
-				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS4);
+				CURLOPT_PROXYTYPE, (long)CURLPROXY_SOCKS4);
 		else if (starts_with(curl_http_proxy, "https")) {
-			curl_easy_setopt(result, CURLOPT_PROXYTYPE, CURLPROXY_HTTPS);
+			curl_easy_setopt(result, CURLOPT_PROXYTYPE, (long)CURLPROXY_HTTPS);
 
 			if (http_proxy_ssl_cert)
 				curl_easy_setopt(result, CURLOPT_PROXY_SSLCERT, http_proxy_ssl_cert);
-- 
2.50.0.rc1.276.g7db1193dde
