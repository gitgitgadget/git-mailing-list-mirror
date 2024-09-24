Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6C42A8F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215337; cv=none; b=qYam2GhXOo+FEV+y9wfVuPpDnGj/Tk092+jzyUzUPmfIGLNyxS9Yfcvf2ZIj4u1YyhEgrpRw4viEEpHfejvzLyrpKZ3Jpim3m6T+n8lcmqAfd/f9N8wKW9bOrN34EMnwuujWeDuC38vFXr8AcXX+VNxhuJtnvdyIdn3oFS5K1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215337; c=relaxed/simple;
	bh=U8/iGqqOYrUN8GjpO6H0TN8+Ebb5SSKFI3MYtjgeBKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpqyBXvuYhO67cMjG9qk/JjGqn3kgQJBhBrTxTRcslVcW6WgIF/Yz9db4VGdB5t82sDkfX2cSbf1D7Kgla72Z4extXM2I1V91QbDjS1oDZgvKxeGvHPFs2PspPL9r4+wmfISQ9Bfr/Iib/D732G9I17UZLWayg5zy6rIPTmm5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15535 invoked by uid 109); 24 Sep 2024 22:02:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:02:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18702 invoked by uid 111); 24 Sep 2024 22:02:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:02:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:02:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 15/28] http: call git_inflate_end() when releasing
 http_object_request
Message-ID: <20240924220213.GO1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

In new_http_object_request(), we initialize the zlib stream with
git_inflate_init(). We must have a matching git_inflate_end() to avoid
leaking any memory allocated by zlib.

In most cases this happens in finish_http_object_request(), but we don't
always get there. If we abort a request mid-stream, then we may clean it
up without hitting that function.

We can't just add a git_inflate_end() call to the release function,
though. That would double-free the cases that did actually finish.
Instead, we'll move the call from the finish function to the release
function. This does delay it for the cases that do finish, but I don't
think it matters. We should have already reached Z_STREAM_END (and
complain if we didn't), and we do not record any status code from
git_inflate_end().

This leak is triggered by t5550 at least (and probably other dumb-http
tests).

I did find one other related spot of interest. If we try to read a
previously downloaded file and fail, we reset the stream by calling
memset() followed by a fresh git_inflate_init(). I don't think this case
is triggered in the test suite, but it seemed like an obvious leak, so I
added the appropriate git_inflate_end() before the memset() there.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index d0242ffb50..4d841becca 100644
--- a/http.c
+++ b/http.c
@@ -2726,6 +2726,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	 * file; also rewind to the beginning of the local file.
 	 */
 	if (prev_read == -1) {
+		git_inflate_end(&freq->stream);
 		memset(&freq->stream, 0, sizeof(freq->stream));
 		git_inflate_init(&freq->stream);
 		the_hash_algo->init_fn(&freq->c);
@@ -2799,7 +2800,6 @@ int finish_http_object_request(struct http_object_request *freq)
 		return -1;
 	}
 
-	git_inflate_end(&freq->stream);
 	the_hash_algo->final_oid_fn(&freq->real_oid, &freq->c);
 	if (freq->zret != Z_STREAM_END) {
 		unlink_or_warn(freq->tmpfile.buf);
@@ -2840,6 +2840,7 @@ void release_http_object_request(struct http_object_request **freq_p)
 	}
 	curl_slist_free_all(freq->headers);
 	strbuf_release(&freq->tmpfile);
+	git_inflate_end(&freq->stream);
 
 	free(freq);
 	*freq_p = NULL;
-- 
2.46.2.1011.gf1f9323e02

