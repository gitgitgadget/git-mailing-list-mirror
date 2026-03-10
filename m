Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DE3CFF76
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169663; cv=none; b=QJZ90F+WUl5CvyWPS/SBAa1uxjOyqgyUQr6KzBaGCoCiWRXBwSRE0OJ2xroEkw1Q1qPuJalHeVK+QEftr9Nb/XKL7rVDgvpf9BzrdHxtberoAOO+2eLxkpRQs5gdA2eJRK2QKOPXNsNCEa35+mwIEJUsIMzpqufoI/5pDRHNJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169663; c=relaxed/simple;
	bh=Aoi6RCWX2DTmhaFerZJk/stdsp8cDGXSKEJhVsTG8WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHyQDfJNkuHp2sMRiosfGh+KfMRsozqldSAjS8mB0RhXVlLhxDoLsrriopBdKS+xq10LRQX/qAmYOx220EODBkm1RzWINaLEOZVZ2Dxue9HFElf4ZQbNGEyMWOCtf6XlEvDNUaiuxPz2z8r9KzngJqCo9JgfWfkQyrAKuWpAwiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OvSqiXfY; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OvSqiXfY"
Received: (qmail 63567 invoked by uid 106); 10 Mar 2026 19:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Aoi6RCWX2DTmhaFerZJk/stdsp8cDGXSKEJhVsTG8WY=; b=OvSqiXfYeLG2GK9i6nAOsJSnEDGl1XMEjvqUv7DxgaLo2ufYi8Tdm10pzVppuhCIkouuiThNFya7UXrKe6G/m8AP4JfsGU8riGGeOhC9ts7Ff2fO+Aq9YRSpyfJeqFH3L8dJTBpfKFJEY6BgaqieqDH/IEhKshROophPK2yRZb8MDKAIqlUs24OlV2YkiGACrJdSgmFq5AdPWGMNEhL2pgdPH6EfUwk32EDzH3gU/ni9sQqR6QOsamAr5XEfdg1Y+4VIbYhg20GVRgL4Zk3ItoJZyVBvJB+UlZAKklX3g76wRCVuO1rLCTrIxkSqOmmOvh6jKAfdYtyo6AaYPsxgMg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Mar 2026 19:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 476122 invoked by uid 111); 10 Mar 2026 19:07:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Mar 2026 15:07:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Mar 2026 15:07:32 -0400
From: Jeff King <peff@peff.net>
To: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v5 4/4] http: add support for HTTP 429 rate limit retries
Message-ID: <20260310190732.GB589835@coredump.intra.peff.net>
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
 <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
 <bfee1f10c0dc3fe3bd4bb5ed87bf380cc6798968.1771856405.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfee1f10c0dc3fe3bd4bb5ed87bf380cc6798968.1771856405.git.gitgitgadget@gmail.com>

On Mon, Feb 23, 2026 at 02:20:05PM +0000, Vaidas Pilkauskas via GitGitGadget wrote:

> @@ -257,6 +264,50 @@ static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p UN
>  		goto exit;
>  	}
>  
> +#ifndef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
> +	/* Parse Retry-After header for rate limiting (for curl < 7.66.0) */
> +	if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) {
> +		struct active_request_slot *slot = (struct active_request_slot *)p;
> +
> +		strbuf_add(&buf, val, val_len);
> +		strbuf_trim(&buf);
> +
> +		if (slot && slot->results) {
> +			/* Parse the retry-after value (delay-seconds or HTTP-date) */
> +			char *endptr;
> +			long retry_after;
> +
> +			errno = 0;
> +			retry_after = strtol(buf.buf, &endptr, 10);
> +
> +		/* Check if it's a valid integer (delay-seconds format) */
> +		if (endptr != buf.buf && *endptr == '\0' &&
> +		    errno != ERANGE && retry_after >= 0) {
> +			slot->results->retry_after = retry_after;
> +		} else {
> +				/* Try parsing as HTTP-date format */
> +				timestamp_t timestamp;
> +				int offset;
> +				if (!parse_date_basic(buf.buf, &timestamp, &offset)) {
> +					/* Successfully parsed as date, calculate delay from now */
> +					timestamp_t now = time(NULL);
> +					if (timestamp > now) {
> +						slot->results->retry_after = (long)(timestamp - now);
> +					} else {
> +						/* Past date means retry immediately */
> +						slot->results->retry_after = 0;
> +					}
> +				} else {
> +					/* Failed to parse as either delay-seconds or HTTP-date */
> +					warning(_("unable to parse Retry-After header value: '%s'"), buf.buf);
> +				}
> +			}
> +		}
> +
> +		goto exit;
> +	}
> +#endif
> +
>  	/*
>  	 * This line could be a continuation of the previously matched header
>  	 * field. If this is the case then we should append this value to the

I don't think this meshes well with the existing code for parsing
www-authenticate, especially with respect to header continuation:

  1. If we see continuation like "Retry-After:\n  <date>", we won't find
     <date>. Instead, we'll just think it's blank (or worse, do a
     partial parse if the line break happens at whitespace in the middle
     of the date).

  2. We don't reset http_auth.header_is_last_match, so
     "WWW-Authenticate: foo\nRetry-After:\n  <date>" will attribute
     <date> to the WWW-Authenticate header.

  3. We don't clear the value like we do for www-authenticate headers,
     as we do in the lower code:

          /*
           * If this is a HTTP status line and not a header field, this signals
           * a different HTTP response. libcurl writes all the output of all
           * response headers of all responses, including redirects.
           * We only care about the last HTTP request response's headers so clear
           * the existing array.
           */
          if (skip_iprefix_mem(ptr, size, "http/", &val, &val_len))
                  strvec_clear(values);

     It's probably unlikely to get a retry-after _and_ a redirect in
     practice, though.

I suspect these are all quite uncommon cases, but it worries me a little
that a malicious response could inject values into the wrong header.
And worse, that these cases will go largely untested, as most developers
have recent enough versions of libcurl.

Could we drop this hunk entirely, and just document that the Retry-After
feature only works if you have a recent version of libcurl? Curl 7.66.0
is almost 7 years old now (and you'd still get manual-timed retries if
you configure them).

> @@ -342,6 +393,17 @@ static void finish_active_slot(struct active_request_slot *slot)
>  
>  		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
>  			&slot->results->http_connectcode);
> +
> +#ifdef GIT_CURL_HAVE_CURLINFO_RETRY_AFTER
> +		if (slot->results->http_code == 429) {
> +			curl_off_t retry_after;
> +			CURLcode res = curl_easy_getinfo(slot->curl,
> +							  CURLINFO_RETRY_AFTER,
> +							  &retry_after);
> +			if (res == CURLE_OK && retry_after > 0)
> +				slot->results->retry_after = (long)retry_after;
> +		}
> +#endif

This hunk makes sense. It is a little funny that we cast to long after
getting a curl_off_t, but I suspect we have to cast somewhere unless we
want to consistently pass around a curl_off_t (including via
http_request).

Though since it seems like http_request() is the only code path that
handles retries, do we need to grab it here in finish_active_slot()?
I.e., would it make more sense to do it in http_request() where we are
copying it out from the results field anyway?

Pushing it down to this level would make sense if we wanted to handle
retries on other requests outside of http_request (like dumb-http walker
request), but I don't think your patch does that.

> @@ -1886,6 +1971,9 @@ int run_one_slot(struct active_request_slot *slot,
>  		 struct slot_results *results)
>  {
>  	slot->results = results;
> +	/* Initialize retry_after to -1 (not set) */
> +	results->retry_after = -1;
> +

This is an unusual spot for per-request setup. Usually this happens in
get_active_slot(), which is called before making a request.

I think you are putting it here because we will make several requests on
the same handle via http_request_recoverable(). But in that case, would
setting it there make more sense? In fact, we seem to _reset_ it there
already. 

>  static int http_request(const char *url,
>  			void *result, int target,
> -			const struct http_get_options *options)
> +			const struct http_get_options *options,
> +			long *retry_after_out)
>  {

Why add this as a new argument when we already have many other optional
out-parameters in http_get_options? I.e., I'd have expected this:

diff --git a/http.h b/http.h
index eb40456450..4e36e41432 100644
--- a/http.h
+++ b/http.h
@@ -155,12 +155,14 @@ struct http_get_options {
 	/*
 	 * If not NULL, contains additional HTTP headers to be sent with the
 	 * request. The strings in the list must not be freed until after the
 	 * request has completed.
 	 */
 	struct string_list *extra_headers;
+
+	long *retry_after;
 };
 
 /* Return values for http_get_*() */
 #define HTTP_OK			0
 #define HTTP_MISSING_TARGET	1
 #define HTTP_ERROR		2


We could possibly even just make it a regular "long", not a pointer. The
reason the other fields in http_get_options are pointers is that we only
want to fill them in if the caller is interested, because:

  1. There is a cost to getting/computing the information.

  2. They allocate memory, so the caller has to know to clean them up.

But here we just have a plain integer, so we could just always assign
it. It would mean dropping the "const" from the struct parameter, but I
think that's fine.


Looking further in the patch, I guess one reason is that the retry stuff
is handled internally by http_request(), so a caller never needs or
wants to see it. I wonder if that is always true, though. For example,
when we print the rate-limited message at the top-level of
remote-curl.c, might it be useful for us to mention the retry-after field?

If you want retries to work for all calls, we might have to use a dummy
http_get_options struct. But I think that would actually make the code
cleaner in general (no more "if (options && options->effective_url)"; it
would just "if (options->effective_url)".

> @@ -2148,7 +2237,8 @@ static int http_request(const char *url,
>  					 fwrite_buffer);
>  	}
>  
> -	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_headers);
> +	curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, slot);

This hunk goes away if we drop the fwrite_headers() bit.

> +static long handle_rate_limit_retry(int *rate_limit_retries, long slot_retry_after)
> [...]
> +	/* Use the slot-specific retry_after value or configured default */
> +	if (slot_retry_after >= 0) {
> +		/* Check if retry delay exceeds maximum allowed */
> +		if (slot_retry_after > http_max_retry_time) {
> +			error(_("response requested a delay greater than http.maxRetryTime (%ld > %ld seconds)"),
> +			      slot_retry_after, http_max_retry_time);
> +			trace2_data_string("http", the_repository,
> +				  "http/429-error", "exceeds-max-retry-time");
> +			trace2_data_intmax("http", the_repository,
> +				  "http/429-requested-delay", slot_retry_after);
> +			return -1;
> +		}
> +		return slot_retry_after;

OK. I had imagine that the max-time would clamp how long we were willing
to wait, but instead we just bail. I guess what you have is probably more
friendly to a server that says "please try again after 600 seconds" as
opposed to trying again faster than they'd prefer.

> +	} else {
> +		/* No Retry-After header provided, use configured default */
> +		if (http_retry_after > http_max_retry_time) {
> +			error(_("configured http.retryAfter exceeds http.maxRetryTime (%ld > %ld seconds)"),
> +			      http_retry_after, http_max_retry_time);
> +			trace2_data_string("http", the_repository,
> +					"http/429-error", "config-exceeds-max-retry-time");
> +			return -1;
> +		}

And this one is a misconfiguration on the part of the user, so it should
certainly be an error. ;)

> +static int http_request_recoverable(const char *url,
>  			       void *result, int target,
>  			       struct http_get_options *options)
>  {
>  	int i = 3;
>  	int ret;
> +	int rate_limit_retries = http_max_retries;
> +	long slot_retry_after = -1; /* Per-slot retry_after value */

Hmm, what is "i" here? Previously we used it to avoid REAUTH looping too
many times:

> -	while (ret == HTTP_REAUTH && --i) {
> +	while ((ret == HTTP_REAUTH || ret == HTTP_RATE_LIMITED) && --i) {

But now we are looping on both rate-limits and auth. If max_retries is
greater than 2, won't we bail even though there are retries left?

Also, what if we retry once due to RATE_LIMITED, but then need multiple
attempts to do auth? It feels like we should have two separate counters:

  while ((ret == HTTP_REAUTH && --i) ||
         (ret == HTTP_RATE_LIMITED && --rate_limit_retries)

Side note: I think I am reading the "--i" count right. It feels like it
would be simpler as "i--", but I guess it is counting the initial
http_request() we made. I suspect this might make more sense as a
do-while loop, but it is hairy enough that trying to refactor it further
might be risky.

> @@ -2301,10 +2454,23 @@ static int http_request_reauth(const char *url,
>  		default:
>  			BUG("Unknown http_request target");
>  		}
> +		if (ret == HTTP_RATE_LIMITED) {
> +			retry_delay = handle_rate_limit_retry(&rate_limit_retries, slot_retry_after);
> +			if (retry_delay < 0)
> +				return HTTP_ERROR;
> +
> +			if (retry_delay > 0) {
> +				warning(_("rate limited, waiting %ld seconds before retry"), retry_delay);
> +				trace2_data_intmax("http", the_repository,
> +						   "http/retry-sleep-seconds", retry_delay);
> +				sleep(retry_delay);
> +			}
> +			slot_retry_after = -1; /* Reset after use */
> +		} else if (ret == HTTP_REAUTH) {
> +			credential_fill(the_repository, &http_auth, 1);
> +		}

OK. In the loop condition I suggested above, we decrement
rate_limit_retries there. But obviously it is also happening here via
handle_rate_limit_retry(), so it has to be one or the other.

I wondered about the case where we are out of retries, and whether we
might sleep before bailing. But that function checks that case and
returns -1, so we'd bail immediately. Good.

> +test_expect_success 'HTTP 429 retry delays are respected' '
> +	# Enable retries
> +	test_config http.maxRetries 3 &&
> +
> +	# Time the operation - it should take at least 2 seconds due to retry delay
> +	start=$(test-tool date getnanos) &&
> +	git ls-remote "$HTTPD_URL/http_429/retry-delays-respected/2/repo.git" >output 2>err &&
> +	duration=$(test-tool date getnanos $start) &&
> +
> +	# Verify it took at least 2 seconds (allowing some tolerance)
> +	duration_int=${duration%.*} &&
> +	test "$duration_int" -ge 1 &&
> +	test_grep "refs/heads/" output
> +'

Nice, the duration-checking here looks nice and simple. The 2-second
check here should be non-racy, since we'll wait at least that long. We
may get a false-success on a heavily-loaded system, but that's OK.

> +test_expect_success 'HTTP 429 fails immediately if Retry-After exceeds http.maxRetryTime' '
> +	# Configure max retry time to 3 seconds (much less than requested 100)
> +	test_config http.maxRetries 3 &&
> +	test_config http.maxRetryTime 3 &&
> +
> +	# Should fail immediately without waiting
> +	start=$(test-tool date getnanos) &&
> +	test_must_fail git ls-remote "$HTTPD_URL/http_429/retry-after-exceeds-max-time/100/repo.git" 2>err &&
> +	duration=$(test-tool date getnanos $start) &&
> +
> +	# Should fail quickly (less than 2 seconds, no 100 second wait)
> +	duration_int=${duration%.*} &&
> +	test "$duration_int" -lt 2 &&
> +	test_grep "greater than http.maxRetryTime" err
> +'

This one is the opposite, though. On a heavily loaded system, we may get
a false failure if the test takes longer than 2s to run. Can we bump
this to something much less likely to trigger, like 99? Or even 100
would work, I'd think, since we know we'll wait at least 100 seconds if
we actually tried to use that retry-time.

> +test_expect_success 'HTTP 429 fails if configured http.retryAfter exceeds http.maxRetryTime' '
> +	# Test misconfiguration: retryAfter > maxRetryTime
> +	# Configure retryAfter larger than maxRetryTime
> +	test_config http.maxRetries 3 &&
> +	test_config http.retryAfter 100 &&
> +	test_config http.maxRetryTime 5 &&
> +
> +	# Should fail immediately with configuration error
> +	start=$(test-tool date getnanos) &&
> +	test_must_fail git ls-remote "$HTTPD_URL/http_429/config-retry-after-exceeds-max-time/none/repo.git" 2>err &&
> +	duration=$(test-tool date getnanos $start) &&
> +
> +	# Should fail quickly
> +	duration_int=${duration%.*} &&
> +	test "$duration_int" -lt 2 &&
> +	test_grep "configured http.retryAfter.*exceeds.*http.maxRetryTime" err
> +'

Same here; the key thing is that we don't wait 100 seconds, but we might
accidentally take 2 seconds on a slow system.

I think there are a few more below, just looking for "-lt".

-Peff
