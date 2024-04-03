Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7581BF5C
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712114449; cv=none; b=tlIueZsQNvhGf+OJ0vD+XcbXko1IzSFF3oamVOlnFuwOJzxfVmig8wqlQNtEeBN8au/lDFx7RO2Y5QWkn6HMPzqnc9heG3CacTAod/74xwdfZWnXaXfeyX4rjkTN9JOh2gPpwAC/gNOcHbroamFTjiRhQ77IkNUWkaqx5JlvhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712114449; c=relaxed/simple;
	bh=O0Cd3kdxo5qC3yTQghzpQ5MzZ07ZxGzQF0na4otYkTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImRmr7Xm9eUZJVZxtto+KpnCpjhan1OBdE14BkUbiJJF6+VVnCzLNJgiqdg1uGhuPvrDiaH8warBXVe6/kTD/9za/DHvst5ObjWCIAgPdBnhgZgvcSD6JcCVYWs4N7EBe7UrrngfeOxxhj6CrR4peXI4iWMG/ugrw9Uc7t0Mhxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16568 invoked by uid 109); 3 Apr 2024 03:20:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 03:20:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4123 invoked by uid 111); 3 Apr 2024 03:20:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 23:20:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 23:20:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http: reset POSTFIELDSIZE when clearing curl handle
Message-ID: <20240403032045.GA1559972@coredump.intra.peff.net>
References: <20240402200254.GA874754@coredump.intra.peff.net>
 <20240402200517.GA875182@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402200517.GA875182@coredump.intra.peff.net>

On Tue, Apr 02, 2024 at 04:05:17PM -0400, Jeff King wrote:

> So everything works, but we're better off resetting the size manually
> for a few reasons:
> 
>   - there was a regression in curl 8.7.0 where the chunked header
>     detection didn't kick in, causing any large HTTP requests made by
>     Git to fail. This has since been fixed (but not yet released). In
>     the issue, curl folks recommended setting it explicitly to -1:
> 
>       https://github.com/curl/curl/issues/13229#issuecomment-2029826058
> 
>     and it indeed works around the regression. So even though it won't
>     be strictly necessary after the fix there, this will help folks who
>     end up using the affected libcurl versions.

Hmph. This isn't quite enough to make things work with 8.7.0, because
there are two things wrong there:

  1. curl uses the leftover POSTFIELDSIZE, which this patch fixes. So
     HTTP/1.1 is fine (including t5551).

  2. In HTTP/2 mode, it sends chunked data, even though HTTP/2 does not
     use "Transfer-Encoding: chunked" (it correctly does not send the
     header, but it puts unnecessary chunk framing around the data).

     t5559 (which covers HTTP/2) fails, and so does accessing HTTP/2
     capable hosts like github.com (though score another win for t5559;
     it has introduced some hassles, but it diagnosed a real problem we
     would not have otherwise seen in the test suite).

This second problem can be fixed by eliminating the manual
transfer-encoding header, which is what's confusing curl's HTTP/2 code.
But as I said earlier...

> Note that the recommendation in the curl issue is to actually drop the
> manual Transfer-Encoding header. Modern libcurl will add the header
> itself when streaming from a READFUNCTION. However, that code wasn't
> added until 802aa5ae2 (HTTP: use chunked Transfer-Encoding for HTTP_POST
> if size unknown, 2019-07-22), which is in curl 7.66.0. We claim to
> support back to 7.19.5, so those older versions still need the manual
> header.

...we can't do so unconditionally. So we'd need something like:

diff --git a/remote-curl.c b/remote-curl.c
index 31b02b8840..215bcc6e10 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -955,7 +955,9 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
 		 */
+#if LIBCURL_VERSION_NUM < 0x074200
 		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
+#endif
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);

I was hoping not to have to carry any version-specific cruft (especially
since newer versions of curl should fix the regression). But it's not
too bad, and it actually marks the code as something that we can ditch
in the future when that version of curl becomes obsolete.

I can try to prepare a cleaner patch for it tomorrow, but comments
welcome in the meantime.

-Peff
