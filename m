Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4A296BB5
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568112; cv=none; b=UsbslQXCHUDi0uOCVNXndb6MmGQXx+DbwH+YrBa3fMs7yAIchBYPQ55XPMDOCQCtHzPp7svYxcfeUyQhcEpDPSGWboiiQIsjU55MrSvMfnFsyUPpIjkY2inAyVQjsog190y/tdJOhs3BahbrhBUlxk53CoSbQqGiKo+GfUz5NKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568112; c=relaxed/simple;
	bh=lBfZDY+vQQRH9AMWYM2w5AO2eUUo+UhCZ4BSVhSPW+I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f6Cp02ecUAMANJIjw5Lpw6A212TaltZcpRf8STK6s+Ged3AqNtZGU4H6+XpNQp6kmQ1nNYHqkmsye+pb9nIkDnwnQJmhOEg47jS5MKkFcI+wUn2bNrjtpJkKAbX7nejhbqN6o3WHkz//SothOwQz2sH8KhdWcRYrEAFGlsraPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZmHP5cN5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZmHP5cN5"
Received: (qmail 63854 invoked by uid 106); 28 Sep 2026 04:01:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=lBfZDY+vQQRH9AMWYM2w5AO2eUUo+UhCZ4BSVhSPW+I=; b=ZmHP5cN5EMMK85ELGeKXHt7/pRzKY5zUI6lHA/+P3b32B0xRdA/VKrUDfA82lTRWYEXisZxzLxDIlBN+U4iyWhB6U3CZy5gNNzFAkAxUCRCl7ilHKt31URR5JGrXr0QVckRl4Ao5Oe3689AJHlJJ+KjLcEeIk4cBipZeQkNMhBQ2F9wBqIRlvCrpoGK0v8cPMRj59TcwQJzC2Dwk9fiHUTojXXyOU0FPTN63v3Y9k0xXykWd9vonRCvpPs11ksLsE1bwVu/mdcEv6eUditP9qPNfbMB0Hb7I9MLEgL0cNpYiu4qR0ypYGtPv96U97bPowgISK2A8hDLQLpY1geOxlg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2026 04:01:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 238074 invoked by uid 111); 28 Sep 2026 04:01:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2026 00:01:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 28 Sep 2026 00:01:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] http: handle curl stripping creds from effective url
Message-ID: <20260928040149.GA498186@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

When we detect that curl performed a redirect of a URL we requested, we
update our base URL to match the new location and flush the http_auth
credentials. This goes back to c93c92f309 (http: update base URLs when
we see redirects, 2013-09-28).

We detect the redirect by comparing the requested URL to the response
from CURLINFO_EFFECTIVE_URL, using a simple string comparison. This has
worked fine for years, but a change in the upcoming curl 8.23.0 adds a
complication. If our URL directly contains credentials (like
"https://user:pass@example.com/foo.git"), then as of 7a6bd027d0
(getinfo: make sure CURLINFO_EFFECTIVE_URL does not contain creds,
2026-09-21), curl will strip the credentials from what it returns (so
just "https://example.com/foo.git" in this case).

This breaks our direct string comparison, and we believe that we've been
redirected. We flush our http_auth credentials, and now subsequent
requests will use the reduced URL, causing us to re-request credentials
from the user. Notably this causes t5550.15 (among others) to complain;
it tries a clone with credentials in the URL, and fails if the user is
prompted at all.

We can handle this new behavior by doing a more careful comparison: if
the direct string comparison fails, we'll strip out the credentials
ourselves and compare. This is a little extra work, but in practice it
should only happen once per process.

I've used curl's curl_url() interface to do the stripping here, mostly
because its behavior should match the stripping it does internally. And
also, though we have code to parse a URL, we don't have any to
reconstruct it, making a single string comparison hard.

One alternative would be to parse with url_parse() or similar, and
compare the individual fields (skipping username/password). I think that
would probably also work in practice, but it seemed to me that the
simplest change would be sticking with string comparisons.

The curl_url() interface appeared in 7.62.0. We document that 7.61.0 is
still supported, so I've made it conditional here. Only new versions
strip the result from CURLINFO_EFFECTIVE_URL, so it's OK for very old
versions to skip the extra comparison. Likewise if we encounter any
errors, we just quietly skip the comparison. That's fine if you don't
have creds in your URLs, and if you do, you'll get end up in the
existing error path (a redirect warning, and eventually an auth
failure).

Signed-off-by: Jeff King <peff@peff.net>
---
I hit this in Debian unstable's packaging of libcurl; the new behavior
is in 8.23.0-rc2, but not -rc1.

We could probably declare 7.62.0 the oldest supported version of curl,
but it would really only save a few lines of #ifdef here. I'd prefer to
consider that question separately.

 git-curl-compat.h |  7 +++++++
 http.c            | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 032aaf7126..25678b5dbd 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -28,6 +28,13 @@
  * introduced, oldest first, in the official version of cURL library.
  */
 
+/**
+ * curl_url() interface added in 7.62.0 (October 2018)
+ */
+#if LIBCURL_VERSION_NUM >= 0x073e00
+#define GIT_CURL_HAVE_CURL_URL
+#endif
+
 /**
  * Versions before curl 7.66.0 (September 2019) required manually setting the
  * transfer-encoding for a streaming POST; after that this is handled
diff --git a/http.c b/http.c
index c8fcfd7693..4af3c29c76 100644
--- a/http.c
+++ b/http.c
@@ -2315,6 +2315,45 @@ static int http_request(const char *url,
 	return ret;
 }
 
+#ifndef GIT_CURL_HAVE_CURL_URL
+#define strip_url_credential(in) NULL
+#else
+static char *strip_url_credential(const char *in)
+{
+	char *ret = NULL;
+	CURLU *url;
+
+	url = curl_url();
+	if (!url)
+		goto out;
+
+	if (curl_url_set(url, CURLUPART_URL, in, 0))
+		goto out;
+
+	curl_url_set(url, CURLUPART_USER, NULL, 0);
+	curl_url_set(url, CURLUPART_PASSWORD, NULL, 0);
+	curl_url_get(url, CURLUPART_URL, &ret, 0);
+
+out:
+	curl_url_cleanup(url);
+	return ret;
+}
+#endif
+
+static int match_effective_url(const char *asked, const char *got)
+{
+	char *stripped;
+	int ret;
+
+	if (!strcmp(asked, got))
+		return 1;
+
+	stripped = strip_url_credential(asked);
+	ret = stripped && !strcmp(stripped, got);
+	curl_free(stripped);
+	return ret;
+}
+
 /*
  * Update the "base" url to a more appropriate value, as deduced by
  * redirects seen when requesting a URL starting with "url".
@@ -2347,7 +2386,7 @@ static int update_url_from_redirect(struct strbuf *base,
 	const char *tail;
 	size_t new_len;
 
-	if (!strcmp(asked, got->buf))
+	if (match_effective_url(asked, got->buf))
 		return 0;
 
 	if (!skip_prefix(asked, base->buf, &tail))
-- 
2.56.0.rc2.338.gcaacf6bdf7
