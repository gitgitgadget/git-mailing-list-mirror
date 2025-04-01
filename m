Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934421EDA0B
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498740; cv=none; b=V4iW21v1Ebyta+0Oxcy1CIpr/zijyerbYJGcmj0YDk+xBAIst4KT/kOOfPsBec/XxbB/mNiXyJDcTfJeRZWSLBwYPZsVVznxKFWLh2Pnxl/jghdNqIT8v/ODx0m4N9P6h2rF1E8SI8sS5FYFl1/A9wjXEH2Lcfxfhv9SNNnNTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498740; c=relaxed/simple;
	bh=aCdZnIph5Gi2xkfYFhjtAKyFmUlQkja+0Rb/mabKjvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMJRb7gBxaHkskIXp9jiTPZk2ux0bXkNH/qphWljTsarS4S/qujTNKu2VX4O8YRD3NGekDSSRSn9Y1tPJswhQyR6m2d3KkP0Z1xtaOTe/uqiozuG7XafkvuYBJiaXAnbOQn1sNuLU51oXKEkFk3ulAuQdo1NVnEI+pMmaC+UifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LOs4po5b; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LOs4po5b"
Received: (qmail 20998 invoked by uid 109); 1 Apr 2025 09:12:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=aCdZnIph5Gi2xkfYFhjtAKyFmUlQkja+0Rb/mabKjvs=; b=LOs4po5bUIMzs9BldcjrMUYYhksJfBay5LujYtTov2vAickxHiYigYgn5RWFanQLMPXmjCYTmnBHmnOAnCtpi7+7FF+EFRS3AdZVpfSPbkmQ+0a7r5vHb1w7wbGe7/A/F1kjYC1Pur7bgxDScMZyS8CPfadGexctJRUDtm6LHl1u5KiH3X7sOuXSHEWKuOUsXDNCszKfIVO6DLrLET3fisyjQFRXDW9Faluh/UfI9E3MFwupocJ+rFdLAbsHBzyAlCb3NuEGUOOHMUMabJTQs+wVvKZ0wNpCgup+HZjkMcF3st7loPSfF1hGYL6P0vHYEq80T4QJ9H2+Qdtc6BumEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Apr 2025 09:12:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16626 invoked by uid 111); 1 Apr 2025 09:12:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Apr 2025 05:12:17 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Apr 2025 05:12:16 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/4] http.c: inline `set_curl_keepalive()`
Message-ID: <20250401091216.GB21089@coredump.intra.peff.net>
References: <cover.1742336481.git.me@ttaylorr.com>
 <cover.1742423021.git.me@ttaylorr.com>
 <cdfc9baa8da95505aa4ad61bab07be0b063d916b.1742423021.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdfc9baa8da95505aa4ad61bab07be0b063d916b.1742423021.git.me@ttaylorr.com>

On Wed, Mar 19, 2025 at 06:23:53PM -0400, Taylor Blau wrote:

> At the end of `get_curl_handle()` we call `set_curl_keepalive()` to
> enable TCP keepalive probes on our CURL handle. `set_curl_keepalive()`
> dates back to 47ce115370 (http: use curl's tcp keepalive if available,
> 2013-10-14), which conditionally compiled different variants of
> `set_curl_keepalive()` depending on what version of curl we were
> compiled with[^1].
> 
> As of f7c094060c (git-curl-compat: remove check for curl 7.25.0,
> 2024-10-23), we no longer conditionally compile `set_curl_keepalive()`
> since we no longer support pre-7.25.0 versions of curl. But the version
> of that function that we kept is really just a thin wrapper around
> setting the TCP_KEEPALIVE option, so there's no reason to keep it in its
> own function.
> 
> Inline the definition of `set_curl_keepalive()` to within
> `get_curl_handle()` so that the setup of our CURL handle is
> self-contained.
> 
> [1]: The details are spelled out in 47ce115370, but the gist is curl
>   7.25.0 and newer use CURLOPT_TCP_KEEPALIVE, older versions use
>   CURLOPT_SOCKOPTFUNCTION with a custom callback, and older versions
>   that predate even that option do nothing.

As the author of 47ce115370, I approve. This ideally would have been
cleaned up as part of the series with f7c094060c, but sometimes it's
hard to see these simplifications when you're focused on getting rid of
the complicated bits. Better late than never.

-Peff
