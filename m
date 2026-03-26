Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F04425CCD
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546446; cv=none; b=cqFGY0wr2N6WdDvAxwtGK+B51buFpf2Kf6EFfZyTRwZZ4XjBXuqdzpw+aXmqCJ/OSjZruVe1PmrQAas8ilmqzxnubm+0/2jnJsmM9IqXN2gyA9yfVqwQh6+EXD/QbCJNNNoogepAqcuTi7DUGiz+ehK1wT+jEVmmCAkfQR+MHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546446; c=relaxed/simple;
	bh=82bU6oxXZErcRlc+iXZPfXD/Joo+Iqw3rQii1TB3Zl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlgZnuLfTWfQ41rec8qwSl/r22YlrfClAVyMY+FeyN6N4QvyJgzZ2VLwBTV58RuWUrmHrNO2u+p/jGgBUK2ywtG7sF4emgR7yOHD2FVLlVg2NcK29vMtFdZaKstuWFpkP+OCyrfE72PZChe/hF9bJIdxhGQaS5i/oJ0nYoW2+o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=azQpmptG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="azQpmptG"
Received: (qmail 154799 invoked by uid 106); 26 Mar 2026 17:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=82bU6oxXZErcRlc+iXZPfXD/Joo+Iqw3rQii1TB3Zl8=; b=azQpmptGcpzYkTUjjxEYEj30nh2zEYXhaMwbqQhxoYiLbs7DcmYaQMSOY+a24E+PQ9RxgiLg0P1lkkOw9Y5Zps+pz1cDFwvn/QX2R2jhv3xY/2SY/4jO3JwnL26CHqLthpNIvjHKRj0NsSetEUq7l5FRhkHIvyPEcCEEKybFOFJ6oDaVRJ1Vwc84+xNxmlqIw3dQmC2CAOrnhnpuyeaYpZftGMyr6sl+rIL34T8+Nw16R/Ka0QrDq3z1mBHJTt7v8FMI5sqV9Gzi/Jf2l4QL4IBnEUg4PrAbmzLn7FAj619jRD1hG/a+LHKtUczvnI6bAZ0/6IEU4G1AMUe1DJgjuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 17:34:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 214653 invoked by uid 111); 26 Mar 2026 17:34:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 13:34:03 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 13:34:02 -0400
From: Jeff King <peff@peff.net>
To: Michael J Gruber <git@grubix.eu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] do not discard const: the simple cases
Message-ID: <20260326173402.GB2447148@coredump.intra.peff.net>
References: <cover.1774537954.git.git@grubix.eu>
 <a3a1d2759a0ec5a3ee285689832832e5e3a63768.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3a1d2759a0ec5a3ee285689832832e5e3a63768.1774537954.git.git@grubix.eu>

On Thu, Mar 26, 2026 at 04:22:47PM +0100, Michael J Gruber wrote:

> This patch covers the easy cases where we deal with a non-const pointer
> to begin with. It is solved by the cast `bar = (char *) foo`.

I think we can often do better, though. For example, in this case:

> diff --git a/builtin/config.c b/builtin/config.c
> index 7c4857be62..bd277e5911 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -852,7 +852,7 @@ static int get_urlmatch(const struct config_location_options *opts,
>  		die("%s", config.url.err);
>  
>  	config.section = xstrdup_tolower(var);
> -	section_tail = strchr(config.section, '.');
> +	section_tail = (char *) strchr(config.section, '.');
>  	if (section_tail) {
>  		*section_tail = '\0';
>  		config.key = section_tail + 1;

We know that it is OK to cast away the const-ness because config.section
is writeable, which we know because it just came from xstrdup(). So why
is it const in the first place? Because the pointer is in a struct which
may be used with other const strings.

But we can untangle this for the compiler without having to cast by
using a non-const alias, like:

  char *section;
  ...
  config.section = section = xstrdup_tolower(var);
  section_tail = strchr(section, '.');

Which I think is safer and shows the intent more clearly.

Some of the other cases below can use similar techniques (e.g., I think
packet_reader's line probably ought to be non-const).

-Peff
