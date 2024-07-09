Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224671474BE
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568985; cv=none; b=oNQx7ltxvxOOH5VM+qa1NUdoaNzidqFUCOMNrgqB5O43tPls3UfJ5R0sXymXrmEugnVmC++1Fgl0+DOO5jfon5Ws6vxAmiviPAmKtb4iP/FhjKSBAJcnzFQWDzZvJrTk24cMb5hCNrwJiCQAmeDJlYXy40q9tjwzM+Mhu6o4pNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568985; c=relaxed/simple;
	bh=NosWO/5pSmEWsVBqbdbt3AdSUu8o0X3HFv7XNlSM5xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnZpFVCwsfcvqzwHlozzwj8zQTLXywrQigxBS7LqghchzYkSnCk++3rvTACJDY9Js9zpJoZeb4loNzF5UanLYnkWSaGAeyaIBmcPYwRmdlN2rRR7fKPLyUhQQZLsz66sscBUUFJqvsO3oqz6k6vGqr/CmbkvuPNQe0Zt+H/x4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29744 invoked by uid 109); 9 Jul 2024 23:49:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jul 2024 23:49:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6312 invoked by uid 111); 9 Jul 2024 23:49:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Jul 2024 19:49:40 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 9 Jul 2024 19:49:41 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Piotr Szlazak <piotr.szlazak@gmail.com>
Subject: Re: [PATCH/RFC] http.c: cookie file tightening
Message-ID: <20240709234941.GA1525171@coredump.intra.peff.net>
References: <xmqqed82cgmj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqed82cgmj.fsf@gitster.g>

On Tue, Jul 09, 2024 at 04:03:48PM -0700, Junio C Hamano wrote:

> The manual pages https://curl.se/libcurl/c/CURLOPT_COOKIEFILE.html
> and https://curl.se/libcurl/c/CURLOPT_COOKIEJAR.html talk about two
> interesting special values.
> 
>  * "" (an empty string) given to CURLOPT_COOKIEFILE means not to
>    read cookies from any file upon startup.
> 
>  * It is not specified what "" (an empty string) given to
>    CURLOPT_COOKIEJAR does; presumably open a file whose name is an
>    empty string and write cookies to it?  In any case, that is not
>    what we want to see happen, ever.
> 
>  * "-" (a dash) given to CURLOPT_COOKIEFILE makes cURL read cookies
>    from the standard input, and given to CURLOPT_COOKIEJAR makes
>    cURL write cookies to the standard output.  Neither of which we
>    want ever to happen.
> 
> So, let's make sure we avoid these nonsense cases.  Specifically,
> when http.cookies is set to "-", ignore it with a warning, and when
> it is set to "" and http.savecookies is set, ignore http.savecookies
> with a warning.
>
> [...]
>
>  * I have no confidence in me doing http correctly, so I am asking
>    from folks who have touched http.c in the past 6 months for help.

I don't have any experience with any of the cookie options, but your
explanation here all makes sense. It might be worth including a test,
though the interesting part is probably how things broke _before_ this
patch. After it, it's pretty obvious what should happen.

So I'll try to comment from the general http.c perspective.

> diff --git c/http.c w/http.c
> index 13fa94bef3..86ccca49f0 100644
> --- c/http.c
> +++ w/http.c
> @@ -1466,7 +1466,16 @@ struct active_request_slot *get_active_slot(void)
>  	slot->finished = NULL;
>  	slot->callback_data = NULL;
>  	slot->callback_func = NULL;
> +
> +	if (curl_cookie_file && !strcmp(curl_cookie_file, "-")) {
> +		warning(_("refusing to read cookies from http.cookiefile '-'"));
> +		FREE_AND_NULL(curl_cookie_file);
> +	}
>  	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
> +	if (curl_save_cookies && (!curl_cookie_file || !curl_cookie_file[0])) {
> +		curl_save_cookies = 0;
> +		warning(_("ignoring http.savecookies for empty http.cookiefile"));
> +	}
>  	if (curl_save_cookies)
>  		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);

This all looks OK to me. A few things I wondered while reading:

  - is curl_cookie_file always an allocated string? The answer is yes,
    because it comes from git_config_pathname(). Good.

  - get_active_slot() will be called a lot of times, as we reuse the
    curl handles over and over (the "slot" terminology is due to the
    parallelism for dumb-http fetch; smart-http just reuses the one
    handle each time). So is this the best place to put the check?

    You actually unset the options when issuing the warning, so we'd
    never see the warning multiple times, even if this code is run
    repeatedly. Good.

    I do suspect these curl_easy_setopt() calls for cookies could just
    go into get_curl_handle(), which sets up the handle initially. But
    it's possible there's some subtle reason why they're here, and
    certainly moving them is orthogonal to your goal. And in the
    meantime, putting your new checks alongside the use of the variables
    makes sense.

-Peff
