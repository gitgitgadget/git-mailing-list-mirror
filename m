Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5096526AF6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718090508; cv=none; b=U1sfCNAPBAOxPrnRm2eLmhVyUeZkKBCJwFJccoZz7ZPztnMw5c+YUfT1DpX6QNVbeHK47Fub63IQBadujr/gokzaH3tq7tlZNQjvPX3gqHFb5ffsx024HKz7svzr9834Np1JuAzcs9mi2IKL0TpYEWpxky3XB3bH4mxAF58Ql50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718090508; c=relaxed/simple;
	bh=G3Vhh6XoXJAPgRxepg7WWYUCudmwwVXjcS8m9AH/RzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UK3V44qonKrAh5b/IpBWNlflFtifS8Qb4eKhsQa7Bdyo9P+BfFxPhD/5Jv9R9v9NzPEZU5+S2tfISifpFW3qeh5GuDVHinNM/Xc9Z9QYNjPrbsK7DhvpFIJo5S/+2gLNnFqXhfXdcAPA0Jxu5LGuBXKfRLOAPFxUPllyWRcH2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17981 invoked by uid 109); 11 Jun 2024 07:21:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 07:21:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24320 invoked by uid 111); 11 Jun 2024 07:21:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 03:21:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 03:21:44 -0400
From: Jeff King <peff@peff.net>
To: matthew sporleder <msporleder@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: bundles discovery and clones
Message-ID: <20240611072144.GD3248245@coredump.intra.peff.net>
References: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>

On Mon, Jun 10, 2024 at 02:25:19PM -0400, matthew sporleder wrote:

> I have recently been playing with git clone --bundle-uri and loving it
> because I can clone with almost-*zero* resources being used on the
> server!
> 
> I am a little confused by https://git-scm.com/docs/bundle-uri
> mentioning "discovery" and things. Is this something being added to
> the git cli, a special feature for other clients, or is it still too
> early-days to talk about much?
> 
> I would love to produce bundles of common use cases and have them
> auto-discovered by git clone *without* the --bundle-uri parameter, and
> then let our CDN do the heavy lifting of satisfying things like:
> git clone
> git clone --depth=0
> git clone --single-branch --branch main
> 
> I'm not sure I hold out as much hope for pre-bundling pulls/updates
> but any movement towards offloading our big-ish repos to CDNs is a win
> for us.

I don't think the server side is well documented, but peeking at the
code, I think you want this on the server:

  git config uploadpack.advertiseBundleURIs true
  git config bundle.version 1
  git config bundle.mode any
  git config bundle.foo.uri https://example.com/your.bundle

And then the clients need to tell Git that they allow bundle transfers:

  git config --global transfer.bundleURI true

I'm not sure if we'd eventually flip the client-side switch to "true" by
default (which is what you'd need for this to happen without any user
participation at all).

One gotcha there is that clients are now accessing an arbitrary URL
provided by the server, so there are cross-site security implications.
It might make more sense to allow only relative URLs without ".." (so if
I fetched from https://example.com/foo.git, the server could use only
the relative "bundles/bar.bundle", which would then be found at
https://example.com/foo.git/bundles/bar.bundle").

-Peff
