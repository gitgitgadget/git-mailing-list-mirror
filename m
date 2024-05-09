Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00318C07
	for <git@vger.kernel.org>; Thu,  9 May 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715273535; cv=none; b=Ut+ThY5c67Y3Cq1+VWrtrijmaqPkGZGFD0jDmVbh25gSBX9tzflcGCzDDNKn6Xyk+oyKySmrRmt8bFuKiGSz24P1wRmBjWsVVGJmQa8oCdHYZnUxmP7n7Rn/ygKWyuyKuuXtNlYewanXPwylDv+k7isOJZOJvKT4CxKqlkjnFOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715273535; c=relaxed/simple;
	bh=ioAYvRyXKbvaXoAUhU3WZAomwcpHikN9gLyKaVU+fd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwlWBLW30SPAohP7DbDCw6ksaNMZQAIQM9xbR+7DqRXsw306pnxln7ptm030RvUslZAIhCIM6qKoUTiNuJxdvg5oMFEZIuvs0Kxd1wnU+rWYsqT7JJjjzRIoTOGbZYv94BemhHEgsWzXtWqPyHvIelOD1abS3+iurVBusle1tGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7033 invoked by uid 109); 9 May 2024 16:52:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 May 2024 16:52:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31414 invoked by uid 111); 9 May 2024 16:52:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 May 2024 12:52:13 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 May 2024 12:52:12 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] http: add the ability to log progress
Message-ID: <20240509165212.GC1708095@coredump.intra.peff.net>
References: <20240508124453.600871-1-toon@iotcl.com>
 <20240508124453.600871-3-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240508124453.600871-3-toon@iotcl.com>

On Wed, May 08, 2024 at 02:44:51PM +0200, Toon Claes wrote:

> @@ -2017,6 +2021,21 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
>  #define HTTP_REQUEST_STRBUF	0
>  #define HTTP_REQUEST_FILE	1
>  
> +static int http_progress_callback(void *clientp, curl_off_t dltotal,
> +				  curl_off_t dlnow, curl_off_t ultotal,
> +				  curl_off_t ulnow)
> +{
> +	struct progress *progress = clientp;
> +
> +	if (progress) {
> +		progress_set_total(progress, dltotal);
> +		display_progress(progress, dlnow);
> +		display_throughput(progress, dlnow);
> +	}
> +
> +	return 0;
> +}

A very long time ago I implemented something similar (for a
proto-bundle-uri feature), and I found out the hard way that both curl
and our progress code may rely on SIGALRM (curl may use it to put a
timeout on blocking calls that don't support select, like DNS
resolution). Making things even more confusing, it's platform dependent,
since on modern platforms it spawns a separate resolving thread to avoid
blocking the main one.

So it seems to work OK for me on Linux without anything further, but we
may want this to be extra careful:

-- >8 --
Date: Thu, 10 Nov 2011 01:29:55 -0500
Subject: [PATCH] http: turn off curl signals

Curl sets and clears the handler for SIGALRM, which makes it
incompatible with git's progress code. However, we can ask
curl not to do this.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index 752c879c1f..e7986e1353 100644
--- a/http.c
+++ b/http.c
@@ -1230,6 +1230,8 @@ static CURL *get_curl_handle(void)
 
 	set_curl_keepalive(result);
 
+	curl_easy_setopt(result, CURLOPT_NOSIGNAL, 1);
+
 	return result;
 }
 
-- 8< --

In the other part of the thread I suggested the possibility of having
remote-https shuttle machine-readable progress back to the caller. That
would also solve this issue, because the actual display_progress() calls
would happen in the parent.

-Peff
