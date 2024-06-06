Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D91374FB
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662471; cv=none; b=bdy+9BrPujtBYNTg4Sfu6FWvgqLdgNwoTlUIYgj826oOHDoxV/1+vq3CFBv+Kav40MIjtPC74AaHkCdp/Ujl6Brv5J1WH9aFDidrJPoUyQBKMxvgOP//V5ztVV7bGTldnWTfNa3/5Ko0eA4RJshed6HDC2TISfJH6nqcA3NTFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662471; c=relaxed/simple;
	bh=CJ7guOK+V1ml4v+U4AXHNko4QHOApjE+0X3437jQymE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfIdVPC1YI8kaCTBvWfBsUcCkNUYAelk+l2wbs1OfnzLmllBQ8MNmPKdXvNKNDHceFt6yK0jnDBQNVy5hYDT5ISPnsikATntNvBxknzUMaH1Ewlvh2J5pNk0yNZt5w0eZhWn6BDvR98iJRo1lacXUgj3R/OAKWp5ixPYyLDFPQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11261 invoked by uid 109); 6 Jun 2024 08:27:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:27:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6730 invoked by uid 111); 6 Jun 2024 08:27:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:27:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:27:48 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v4 5/6] test-terminal: introduce --no-stdin-pty
Message-ID: <20240606082748.GD658959@coredump.intra.peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
 <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
 <1ef0ac3a-3be5-4fc2-93f8-46610f3d1880@gmail.com>
 <d95180fc-8f8a-4e1d-987d-3aa0811be7de@gmail.com>
 <600d27c1-f9e2-4a03-af24-4de8f66526d6@gmail.com>
 <9c76f1f3-f858-400e-8fc7-8e3bc9764e87@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c76f1f3-f858-400e-8fc7-8e3bc9764e87@gmail.com>

On Thu, Jun 06, 2024 at 12:50:39AM +0200, Rubén Justo wrote:

> On Tue, Jun 04, 2024 at 11:05:15AM +0100, Phillip Wood wrote:
> 
> > Rather than adding a new flag to work around a bug in our script it might be
> > better to try and fix the bug by using a loop that reads blocks of data from
> > the source and writes them to the destination instead of calling copy.
> 
> To be honest, I've tried.  I haven't found a way to fix it properly.

I think File::Copy() is not the culprit. The problem is more at the
syscall level. Once test_terminal finishes writing all of the output to
the tty, it closes its end of the descriptor. And now the tty is "gone",
isatty() returns false, and further reads get EIO (even if we didn't
read all of the bytes! They're lost).

So I think the only thing we could do is _not_ actually close the
descriptor. But now we don't have a way to signal EOF to the other side.
Unless perhaps there is some clever way to do so. I'd still favor
ripping it out.

> I also thought about removing it.  I agree with Peff, removing the stdin
> redirection makes more sense.  IMHO simplifies.
> 
> But, perhaps we can happily live another almost-decade with this new
> --no-stdin-pty, before finally removing the stdin redirection in this
> helper. :-)

Hopefully not a decade. ;) I just sent a series, and I think you could
either build on top, or the merge resolution could just drop your new
option.

-Peff
