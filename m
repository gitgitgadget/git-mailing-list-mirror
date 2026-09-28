Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519053BF689
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624208; cv=none; b=UeaBy990IMuYYkSCzasrw0nyIKRmvPxqkU7ILE52to5tT9s0Fq0V3nxxPEkdeUVK+TeI3x2XmIT4BYWa19ooRO6F05BAJADmRCHYKklrLMv30qLOB2UP1K/hsDRXtMaeUtm2VG1NkAXRORsX/gzd4HoDs2oJ46Ako6pufa1cpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624208; c=relaxed/simple;
	bh=S6haOAoFNAf8aFYxliEe4GTI+utXSSXM6nuILN8uRsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=du/hCfVKIto5NltayTWoQWiVbcOILOGW0eELgJbArHeUMq4YiC0g9eHcLv+bLmosxi2nKtSb3SAdwL6BVKrL4vktgejfLLQkumGCfuehQm74W3+NQ63pSbRMLxdmLN43jtfheYNt9nnxxFOTgvQ63kQvdYxJlWPbw2fMfTxmVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B0AaYxeu; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B0AaYxeu"
Received: (qmail 67256 invoked by uid 106); 28 Sep 2026 19:36:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S6haOAoFNAf8aFYxliEe4GTI+utXSSXM6nuILN8uRsY=; b=B0AaYxeuzeneCTSo6JUTO0HcbN6+cRWZT0GJJQcPjEb6DvXYDxJbZYQCPzJU/uJVXe4IullpcVfBdmh2WrEfHJAeInoXSonK27Ugw2t7lhhm4wuXzvZBMK75/AD6Kyogw4czCsY09ooad5bxqeEPEYATIY7lMI7KiMS+ZNyEdmFdIVVHdiP82ro3Y90TQe76hOMZHZ5FpOA+aHewE2s9Arg7wm1S16eRh01T84tt5399Jw8u8W28uPu+BCYud/eWRb442tDN4mqhegy8n31PoHoWEcDQvZ9BbE3QdflhXYNZgYsg1VG1qW+9K+ptMrXtTL2BXK7Xd7JG9+RVdor2xg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2026 19:36:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 280562 invoked by uid 111); 28 Sep 2026 19:36:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2026 15:36:44 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 28 Sep 2026 15:36:44 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] http: handle curl stripping creds from effective url
Message-ID: <20260928193644.GA1075764@coredump.intra.peff.net>
References: <20260928040149.GA498186@coredump.intra.peff.net>
 <arplE8-5jD-rZiyu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arplE8-5jD-rZiyu@pks.im>

On Mon, Sep 28, 2026 at 03:01:07PM +0200, Patrick Steinhardt wrote:

> > We can handle this new behavior by doing a more careful comparison: if
> > the direct string comparison fails, we'll strip out the credentials
> > ourselves and compare. This is a little extra work, but in practice it
> > should only happen once per process.
> 
> So in my own words, we want to detect the case where we have been
> redirected and, if we have been, we want to strip credentials. But this
> logic is about to break as curl starts to rewrite EFFECTIVE_URL more
> aggressively, and that makes us detect redirects in cases where there
> were none.

Yes, though I'd be careful to distinguish "strip" credentials versus
"flush" credentials. I'd take the former to mean "remove them from the
URL if they are embedded in it", whereas the latter to mean "throw away
any credentials in the http_auth credential struct".

Those credentials in http_auth might have come from the user, or even
been extracted from the URL originally (or some combination; e.g.,
getting the user from the URL and the password from the user). But we
want to flush them so that we won't provide them to a redirected
destination.

I think we are on the same page and this is just wording pedantry, but
wanted to make sure.

You might also reasonably ask: if we have already extracted the
credentials from the original URL into http_auth, can't we just strip
them immediately afterwards, and always deal with a vanilla URL? That
was my original approach, but sadly it does not work because we then
pass that URL across process boundaries (e.g., to http-push), but the
extracted http_auth credential struct doesn't make it. One of the tests
in t5540 notices those.

> > I've used curl's curl_url() interface to do the stripping here, mostly
> > because its behavior should match the stripping it does internally. And
> > also, though we have code to parse a URL, we don't have any to
> > reconstruct it, making a single string comparison hard.
> > 
> > One alternative would be to parse with url_parse() or similar, and
> > compare the individual fields (skipping username/password). I think that
> > would probably also work in practice, but it seemed to me that the
> > simplest change would be sticking with string comparisons.
> 
> It still feels rather roundabout to compare URLs only to figure out
> whether we have been redirected. I wondered whether there is maybe a
> more direct way to get that info, and there indeed is
> CURLINFO_REDIRECT_COUNT, which allows us to retrieve the number of
> redirects that have happened.
> 
> Is that interface maybe a more direct way to get what we're after?

Hmm, interesting. We need to grab the effective URL anyway in order to
actually do the base-url update. But in theory we could replace the "did
we redirect at all" early return with a check of the redirect count. And
indeed, the patch looks much cleaner (see below).

But sadly, it doesn't work! Curl reports that we did 1 redirect for the
initial request. I think it is counting the extra request it does for
the auth (we get a 401, then it auto-retries with the password to get a
200).

So we really do need to do our string-based check for "did the URL
meaningfully change", and all of the annoying cred-stripping that comes
with it.

Too bad, because your solution looks much nicer. ;)

---
diff --git a/http.c b/http.c
index c8fcfd7693..e95fe4ba7b 100644
--- a/http.c
+++ b/http.c
@@ -2305,6 +2305,9 @@ static int http_request(const char *url,
 		strbuf_release(&raw);
 	}
 
+	curl_easy_getinfo(slot->curl, CURLINFO_REDIRECT_COUNT,
+			  &options->redirects);
+
 	if (options->effective_url)
 		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
 				options->effective_url);
@@ -2325,8 +2328,6 @@ static int http_request(const char *url,
  * The "got" parameter is the URL that curl reported to us as where we ended
  * up.
  *
- * Returns 1 if we updated the base url, 0 otherwise.
- *
  * Our basic strategy is to compare "base" and "asked" to find the bits
  * specific to our request. We then strip those bits off of "got" to yield the
  * new base. So for example, if our base is "http://example.com/foo.git",
@@ -2340,16 +2341,13 @@ static int http_request(const char *url,
  * scheme is unlikely to represent a real git repository, and failing to
  * rewrite the base opens options for malicious redirects to do funny things.
  */
-static int update_url_from_redirect(struct strbuf *base,
-				    const char *asked,
-				    const struct strbuf *got)
+static void update_url_from_redirect(struct strbuf *base,
+				     const char *asked,
+				     const struct strbuf *got)
 {
 	const char *tail;
 	size_t new_len;
 
-	if (!strcmp(asked, got->buf))
-		return 0;
-
 	if (!skip_prefix(asked, base->buf, &tail))
 		BUG("update_url_from_redirect: %s is not a superset of %s",
 		    asked, base->buf);
@@ -2363,8 +2361,6 @@ static int update_url_from_redirect(struct strbuf *base,
 
 	strbuf_reset(base);
 	strbuf_add(base, got->buf, new_len);
-
-	return 1;
 }
 
 /*
@@ -2426,12 +2422,12 @@ static int http_request_recoverable(const char *url,
 	if (ret == HTTP_RATE_LIMITED && !http_max_retries)
 		return HTTP_ERROR;
 
-	if (options->effective_url && options->base_url) {
-		if (update_url_from_redirect(options->base_url,
-					     url, options->effective_url)) {
-			credential_from_url(&http_auth, options->base_url->buf);
-			url = options->effective_url->buf;
-		}
+	if (options->redirects > 0 &&
+	    options->effective_url && options->base_url) {
+		update_url_from_redirect(options->base_url, url,
+					 options->effective_url);
+		credential_from_url(&http_auth, options->base_url->buf);
+		url = options->effective_url->buf;
 	}
 
 	while ((ret == HTTP_REAUTH && --i) ||
diff --git a/http.h b/http.h
index 729c51904d..79cd0a2c1a 100644
--- a/http.h
+++ b/http.h
@@ -171,6 +171,12 @@ struct http_get_options {
 	 * libcurl 7.66.0 or later), or -1 if no such header was present.
 	 */
 	long retry_after;
+
+	/*
+	 * After a request completes, contains the number of redirects reported
+	 * by curl.
+	 */
+	long redirects;
 };
 
 /* Return values for http_get_*() */
