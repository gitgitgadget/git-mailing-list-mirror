Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0755832254E
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282029; cv=none; b=kYw7OC96L2+//v6ONEBmy8hkJiYCfErzute7R6+vJ9g1/lK5B8PHaUHqkHnWcKUzzEFJYsCRRJxQ13h8q0o3mfrgbmAY3c7CHGdEaMnWdUhe0yMrGgTr1LkJLZvunzFOQxveflvhUpodEgtRj4AUM0qiElYJ2jGi2vSiRWeA2p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282029; c=relaxed/simple;
	bh=cpCvu5OlWc1/VwjRy5fkoNMXrPLSgQyXxeo4ajwZ+vU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tcivISCgw3kCPAbTdgcZkOfVlwepY/dZK98xcIbVXeqajUgHsr5xLLK/YZYHvjNlh1b9wtO5qa/J3W/IYzy+57203pry6KkHnXy3YXYCjjyoRCPfE2Oc2WRvJ3RfO4ih6R8gAEkhoAXXQFjVEz64sZSrgjznXmMRqCrrrvHZ/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=edF5X5x6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="edF5X5x6"
Received: (qmail 125099 invoked by uid 109); 27 Aug 2025 08:07:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type:content-transfer-encoding; s=20240930; bh=cpCvu5OlWc1/VwjRy5fkoNMXrPLSgQyXxeo4ajwZ+vU=; b=edF5X5x6MHXzZNsSs2saQWIhzsJ1lvQlpWOFbIJrTf0x+t2Hq8/wgHQNeHI4spuDHUBCjP9iqEO81hF9uIcFfhcYGeqy/Av59OBj4VsnsCvR3PqaOR69A64dJssJG5Nt17/aiwh+cDOyDXg9nYhFCTGekzJjVtKoqhK1cXRU0shJmBuS2tzYiJ5C6aKxzhVi8+1oK5iFAkMrtI7ze303keVXanhmjBW1c11S+bAzAzvw/25M9J0nn6mNOHxyKMOLz34OxXS7SF0oJafO3jowW4rgbOtNKT2JG/IlDZ4Ub/56IU5CsZj2hIWrubKtxSfFsZH2hE49iz2AUcjTiLUtZA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Aug 2025 08:07:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 190209 invoked by uid 111); 27 Aug 2025 08:07:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Aug 2025 04:07:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Aug 2025 04:07:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] curl: add support for curl_global_trace() components
Message-ID: <20250827080702.GA3572995@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

In addition to the regular trace information produced by
CURLOPT_VERBOSE, recent curl versions can enable or disable tracing of
specific subsystems using a call to curl_global_trace().

This level of detail may or may not be useful for us in Git as mere
users of libcurl, but there's one case where we need it for a test. In
t5564, we set up a socks proxy, access it with GIT_TRACE_CURL set, and
expect to find socks-related messages in the output. This test is broken
in the release candidates for libcurl 8.16, as those socks messages are
no longer produced in the trace.

The problem bisects to curl's commit ab5e0bfddc (pytest: add SOCKS tests
and scoring, 2025-07-21). There the socks messages were moved from
generic infof() messages to the component-specific CURL_TRC_CF() system.
And so we do not see them by default, but only if "socks" is enabled as
a logging component.

This patch teaches Git's http code to accept a component list from the
environment and pass it into curl_global_trace(). We can then use that
in the test to enable the correct component.

It should be safe to do so unconditionally. In older versions of curl
which don't support this call, setting the environment variable is a
noop. Likewise, any versions of curl which don't recognize the "socks"
component should silently ignore it. The manpage for curl_global_trace()
says this:

  The config string is a list of comma-separated component names. Names
  are case-insensitive and unknown names are ignored. The special name
  "all" applies to all components. Names may be prefixed with '+' or '-'
  to enable or disable detailed logging for a component.

  The list of component names is not part of curl's public API. Names may
  be added or disappear in future ver‐ sions of libcurl. Since unknown
  names are silently ignored, outdated log configurations does not cause
  errors when upgrading libcurl. Given that, some names can be expected
  to be fairly stable and are listed below for easy reference.

So this should let us make the test work on all versions without
worrying about confusing older (or newer) versions. For the same reason,
I've opted not to document this interface. This is deep internal voodoo
for which we can make no promises to users. In fact, I was tempted to
simply hard-code "socks" to let our test pass and not expose anything.
But I suspect a little run-time flexibility may come in handy in the
future when debugging or dealing with similar logging issues.

I also considered just putting "all" into such a hard-coded default. But
if you try it, you will see that many of the components are quite
verbose and likely not interesting. They would clutter up our trace
output if we enabled them by default.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this because curl 8.16-rc2 is in Debian unstable now (and my
usual "make test" failed as a result). I wondered if this might be
considered a regression in curl, but I think probably not. Those socks
messages are pretty low-level, so must users are probably fine without
them. And they still get _some_ indication that socks is in use.
Running:

  perl t/socks4-proxy.pl /tmp/proxy &
  curl --verbose --proxy socks4://localhost/tmp/proxy https://google.com

yields:

  * Opened SOCKS connection from  port 0 to google.com port 443 (via /tmp/proxy port 0)

in the normal output (among many other lines). If we add
--trace-config=socks after the --verbose flag, you additionally get:

  * [SOCKS] SOCKS4 communication to google.com:443
  * [SOCKS] SOCKS4 non-blocking resolve of google.com
  * [SOCKS] SOCKS4 connect to IPv4 192.178.154.139 (locally resolved)
  * [SOCKS] SOCKS4 request granted.

So obviously another direction here is that we could make the test more
flexible about which messages it matches (the "old" one does not quite
look like the "Opened SOCKS" one above, but we could match either).

I kind of like this patch as an extra debugging aid, though.

 git-curl-compat.h     | 7 +++++++
 http.c                | 8 ++++++++
 t/t5564-http-proxy.sh | 4 +++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index aa8eed7ed2..659e5a3875 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -45,6 +45,13 @@
 #define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
 #endif
 
+/**
+ * curl_global_trace() was added in 8.3.0, released September 2023.
+ */
+#if LIBCURL_VERSION_NUM >= 0x080300
+#define GIT_CURL_HAVE_GLOBAL_TRACE 1
+#endif
+
 /**
  * CURLOPT_TCP_KEEPCNT was added in 8.9.0, released in July, 2024.
  */
diff --git a/http.c b/http.c
index 98853d6483..a7d55dcbba 100644
--- a/http.c
+++ b/http.c
@@ -1348,6 +1348,14 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
 		die("curl_global_init failed");
 
+#ifdef GIT_CURL_HAVE_GLOBAL_TRACE
+	{
+		const char *comp = getenv("GIT_TRACE_CURL_COMPONENTS");
+		if (comp)
+			curl_global_trace(comp);
+	}
+#endif
+
 	if (proactive_auth && http_proactive_auth == PROACTIVE_AUTH_NONE)
 		http_proactive_auth = PROACTIVE_AUTH_IF_CREDENTIALS;
 
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index b27e481f95..c3903faf2d 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -72,7 +72,9 @@ test_expect_success SOCKS_PROXY 'clone via Unix socket' '
 	test_when_finished "rm -rf clone" &&
 	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
 		{
-			GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
+			GIT_TRACE_CURL=$PWD/trace \
+			GIT_TRACE_CURL_COMPONENTS=socks \
+			git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
 			grep -i "SOCKS4 request granted" trace
 		} ||
 		old_libcurl_error err
-- 
2.51.0.410.g59ea61f7ea
