Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E545EAD5
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720248482; cv=none; b=Zi2iyXvcQAjFr/s8sQAYsolAs0TvYG5YxMXYG1OGSbssQU4jdjE04CsM1fmWAC/e2hyDO9eIa29iuEXJV8zLUTier4nlawGowJgJOSlQ5OWP8ZU98g2PT05rgwB312cuejuriw1bRyOlShrfWCfTcVi76Hh3D05w1IbcwMxd820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720248482; c=relaxed/simple;
	bh=tXjjTmGL9/AKQUIKe9Yit852aT5tCm/ICIYHfsY+aRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKHwXGpbVC7S+CybXSAPZLF2tADJrcjvZgaJPFSGuEwE/Gl27YrqYhapCddF54t/R+LY2GQYVT91cdpKpuE3p0+IvbH7rMPDUFnQh3z/WNNHCkZOIj7pxrNruNWKxj6KVgkbSFL8xLcQf8uHs0d4uZcOyviWt8787WpgXHcIFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24208 invoked by uid 109); 6 Jul 2024 06:48:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 06:48:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31527 invoked by uid 111); 6 Jul 2024 06:47:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 02:47:57 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 02:47:58 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/4] Additional FAQ entries
Message-ID: <20240706064758.GG700645@coredump.intra.peff.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <xmqqzfqx7muk.fsf@gitster.g>
 <ZocS0NgiAbg5Mnzp@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZocS0NgiAbg5Mnzp@tapette.crustytoothpaste.net>

On Thu, Jul 04, 2024 at 09:23:28PM +0000, brian m. carlson wrote:

> > Buffering the entire thing will break because ...?  Deadlock?  Or is
> > there anything more subtle going on?
> 
> When we use the smart HTTP protocol, the server sends keep-alive and
> status messages as one of the data streams, which is important because
> (a) the user is usually impatient and wants to know what's going on and
> (b) it may take a long time to pack the data, especially for large
> repositories, and sending no data may result in the connection being
> dropped or the client being served a 500 by an intermediate layer.  We
> know this does happen and I've seen reports of it.

Additionally, I think for non-HTTP transports (think proxying ssh
through socat or similar), buffering the v0 protocol is likely a total
disaster. The fetch protocol assumes both sides spewing at each other in
real time.

HTTP, even v0, follows a request/response model, so we're safer there. I
do think some amount of buffering is often going to be OK in practice.
You'd get delayed keep-alives and progress reports, which may range from
"annoying" to "something in the middle decided to time out". So I'm OK
with just telling people "make sure your proxies aren't buffering" as a
general rule, rather than trying to get into the nitty gritty of what is
going to break and how.

-Peff
