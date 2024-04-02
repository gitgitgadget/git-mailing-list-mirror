Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB3315AAA1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088321; cv=none; b=peRLeSvosHHhrjVdPID03Zpk4MlkQafvkYlPPtrGqe4oWSdGjUSbnxEana+wQH8lvwwDJlGSiqTCZnKRsHsRAmhKmIlstuvHs/khFdO/aZG/dUgW3fyQ5dQruU9PJKYnEXFT9sKo8MMSPJNLbtiQsjLYtOXTa5Gvk+Ro9AGc23I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088321; c=relaxed/simple;
	bh=VF0rIT3l/R8h3qVYoSelzUCIa16Zw7+3Snq4gfn2zbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USIcfBLTo582ZWuBgryQRhmTXYNKVKhbpx84w+b6PfBiNkLO4Zjuod12KUOFo7ipUL6lwuMHsAEGPBmHJtoseiXf8WWj4z5KIqwU7JWTV9t6LpB22JQD5731mZ98Om4Wm5dvB4RUpS2DKSAf2y2qItvz+/jKae1qlZa+B58vaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7288 invoked by uid 109); 2 Apr 2024 20:05:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Apr 2024 20:05:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1105 invoked by uid 111); 2 Apr 2024 20:05:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Apr 2024 16:05:19 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 2 Apr 2024 16:05:17 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH 1/2] http: reset POSTFIELDSIZE when clearing curl handle
Message-ID: <20240402200517.GA875182@coredump.intra.peff.net>
References: <20240402200254.GA874754@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402200254.GA874754@coredump.intra.peff.net>

In get_active_slot(), we return a CURL handle that may have been used
before (reusing them is good because it lets curl reuse the same
connection across many requests). We set a few curl options back to
defaults that may have been modified by previous requests.

We reset POSTFIELDS to NULL, but do not reset POSTFIELDSIZE (which
defaults to "-1"). This usually doesn't matter because most POSTs will
set both fields together anyway. But there is one exception: when
handling a large request in remote-curl's post_rpc(), we don't set
_either_, and instead set a READFUNCTION to stream data into libcurl.

This can interact weirdly with a stale POSTFIELDSIZE setting, because
curl will assume it should read only some set number of bytes from our
READFUNCTION. However, it has worked in practice because we also
manually set a "Transfer-Encoding: chunked" header, which libcurl uses
as a clue to set the POSTFIELDSIZE to -1 itself.

So everything works, but we're better off resetting the size manually
for a few reasons:

  - there was a regression in curl 8.7.0 where the chunked header
    detection didn't kick in, causing any large HTTP requests made by
    Git to fail. This has since been fixed (but not yet released). In
    the issue, curl folks recommended setting it explicitly to -1:

      https://github.com/curl/curl/issues/13229#issuecomment-2029826058

    and it indeed works around the regression. So even though it won't
    be strictly necessary after the fix there, this will help folks who
    end up using the affected libcurl versions.

  - it's consistent with what a new curl handle would look like. Since
    get_active_slot() may or may not return a used handle, this reduces
    the possibility of heisenbugs that only appear with certain request
    patterns.

Note that the recommendation in the curl issue is to actually drop the
manual Transfer-Encoding header. Modern libcurl will add the header
itself when streaming from a READFUNCTION. However, that code wasn't
added until 802aa5ae2 (HTTP: use chunked Transfer-Encoding for HTTP_POST
if size unknown, 2019-07-22), which is in curl 7.66.0. We claim to
support back to 7.19.5, so those older versions still need the manual
header.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index e73b136e58..3d80bd6116 100644
--- a/http.c
+++ b/http.c
@@ -1452,6 +1452,7 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
+	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
 	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
-- 
2.44.0.789.g5ea01f6724

