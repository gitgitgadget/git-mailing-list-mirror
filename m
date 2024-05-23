Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767B13C9CA
	for <git@vger.kernel.org>; Thu, 23 May 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456601; cv=none; b=fjmbAmzfhpbRgyk7oJYrk7vjOqGr/21bHa0yZdXSlTXoIQLerd1H3Yk56Y8GT3K1lOiEpOajHLjFIi9Q+hZAVoDrmQCna4OOgdS3lhJwPL+xCbNtUgwStl2jkmvgjjuUbZNL8ZKi3x/eGkQVZt32SaKeJtjcNbM6Y0IQslSnELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456601; c=relaxed/simple;
	bh=o93pTwPxkBjl7UaoHfG/8/AAtpBFGdPll0/VCHST2YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3fQ3R5dgjO0eTjYvY/VT1Pyb1bjBF1yZgXg/vro4G+Dao11XMmsZJy2mHYMBOWKjU+aRXtmRSv+GED3GViDWz+apWytqvEzF0QP/nPKFst4TYSzzSIvwJO26L5TGfyu55an/NJGVCRV19Z6O3n2hNJaEU0VWJDwgK1JHMlAhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31163 invoked by uid 109); 23 May 2024 09:29:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 09:29:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28591 invoked by uid 111); 23 May 2024 09:30:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 05:30:03 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 05:29:57 -0400
From: Jeff King <peff@peff.net>
To: Boris Mbarga via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Boris Mbarga <elhmn42@gmail.com>, elhmn <elhmn@github.com>
Subject: Re: [PATCH] http: display the response body on POST failure
Message-ID: <20240523092957.GF1306938@coredump.intra.peff.net>
References: <pull.1722.git.git.1716239367046.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1722.git.git.1716239367046.gitgitgadget@gmail.com>

On Mon, May 20, 2024 at 09:09:26PM +0000, Boris Mbarga via GitGitGadget wrote:

> From: elhmn <elhmn@github.com>
> 
> When Git sends a GET request and receives an HTTP code indicating
> failure (and that failure does not indicate an authentication problem),
> it shows the body of the response, i.e. the error message.

Hmm, do we always do so?  Long ago, I implemented that for the initial
HTTP connection in 426e70d4a1 (remote-curl: show server content on http
errors, 2013-04-05). That disables CURLOPT_FAILONERROR for that request,
and then shows the result even if we saw an error.

After that, we turned off CURLOPT_FAILONERROR for all requests in
e6cf87b12d (http: enable keep_error for HTTP requests, 2019-01-10), with
the rationale that we'd show them with GIT_CURL_VERBOSE (and presumably
GIT_TRACE_CURL, too). But do we actually write them out in most cases?

I'm not opposed to doing so, but just trying to understand what the
implications might be (and whether we are really bringing POSTs in line,
or if this is a new area).

In particular...

> @@ -837,6 +840,8 @@ static int run_slot(struct active_request_slot *slot,
>  				strbuf_addch(&msg, ' ');
>  				strbuf_addstr(&msg, curl_errorstr);
>  			}
> +			if (slot->errstr && slot->errstr->len)
> +				error(_("%s"), slot->errstr->buf);
>  		}
>  		error(_("RPC failed; %s"), msg.buf);
>  		strbuf_release(&msg);

If I understand correctly, slot->errstr is just the raw body content
returned by the request. That _might_ be something human-readable, but
it might not. For that initial connection, we have show_http_message(),
which shows only messages that come back as text/plain, does some light
cleanup, and shows the error with the "remote:" prefix. We'd want to use
that here, I'd think?

-Peff
