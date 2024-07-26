Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F383C0C
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722028322; cv=none; b=S0TflSCs2wjzYPrKuU/z8NT64COjZ+mGHR88f4fXnz7ShY4hf9SFjwU+t0h5UOeT/RBxKF6Siu20DjBKGXRMWmrKpWvrOcGpUWP9A/vrm55cnPh4DKa+mD8nx0Equ7AQ3UoxmhLEZ+hHYHR4zu5MLvUkTK7Asiwm+BZRdmC9N3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722028322; c=relaxed/simple;
	bh=3Q6t+eOi7PwnBIHD6vAZd2xiEER49Dzs5pq95z+y5v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAfs8GGpzkEwVzulQwkAdazC1O2a2ScleUvRawFtiIVuygzZZC2N2u5sjTcOHpF8lUOKf0Cgiw5cw/PBft9ZUilYXpZ9jE5QDi1oEdzzNj9u2aPLI7QUYBr2qmqAJ6Du/W+tkve2RoZEXz230BteaVn8t0ZkBIjBce47o2ta/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25183 invoked by uid 109); 26 Jul 2024 21:11:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jul 2024 21:11:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8169 invoked by uid 111); 26 Jul 2024 21:11:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jul 2024 17:11:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Jul 2024 17:11:56 -0400
From: Jeff King <peff@peff.net>
To: Ryan Hendrickson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH] http: do not ignore proxy path
Message-ID: <20240726211156.GA714986@coredump.intra.peff.net>
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>

On Fri, Jul 26, 2024 at 03:52:50PM +0000, Ryan Hendrickson via GitGitGadget wrote:

>      * Tests: I could use a pointer on how best to add a test for this.
>        Adding a case to t5564-http-proxy.sh seems straightforward but I
>        don't think httpd can be configured to listen to domain sockets; can
>        I use netcat?

I don't offhand know of a way to test this without a custom program like
netcat. If it's the only option, it's OK to use tools that might not be
available everywhere as long as the tests are marked as optional with
the appropriate prerequisite. You can find prior art by looking for
test_lazy_prereq calls (e.g., the ones for GZIP or ZIPINFO are pretty
straight-forward).

I would warn that there are several not-quite-compatible variants of
netcat floating around, which can create headaches. You might be better
off with a short perl script using IO::Socket::UNIX or similar.

> diff --git a/http.c b/http.c
> index 623ed234891..0cd75986a6b 100644
> --- a/http.c
> +++ b/http.c
> @@ -1265,7 +1265,13 @@ static CURL *get_curl_handle(void)
>  		if (!proxy_auth.host)
>  			die("Invalid proxy URL '%s'", curl_http_proxy);
>  
> -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
> +		if (proxy_auth.path) {
> +			struct strbuf proxy = STRBUF_INIT;
> +			strbuf_addf(&proxy, "%s/%s", proxy_auth.host, proxy_auth.path);
> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
> +			strbuf_release(&proxy);
> +		} else
> +			curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);

The fields in the proxy_auth struct have been parsed from the url, with
any url encoding removed. But then we paste them back together into a
pseudo-url without doing any further encoding. Is that correct?

I doubt that the host contains a "/", but if you had a path that
contained a "%", then the URL form of that is going to be %25. Which is
curl expecting to get here?

I say "pseudo-url" because it is weird to slap a path on the end of the
hostname but leave off the scheme, etc. Which kind of makes me wonder
why we pass proxy_auth.host in the first place, and not simply the
original curl_http_proxy. It looks like a weird interaction between
372370f167 (http: use credential API to handle proxy authentication,
2016-01-26) and 57415089bd (http: honor empty http.proxy option to
bypass proxy, 2017-04-11). The former added a _second_ CURLOPT_PROXY
call, and the latter removed the first one.

I wonder if we could go back to passing the string straight to curl (as
we did prior to 2016), and keeping the proxy_auth struct purely as a
mechanism for gathering credentials. That would presumably fix your use
case. And this is also perhaps an interesting data point for Junio's
question about regressions (if people were passing paths, it used to
work and was broken in 2016).

-Peff
