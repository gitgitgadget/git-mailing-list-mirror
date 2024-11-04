Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732D81C75FA
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742090; cv=none; b=ukAcVP7tGB6nmeCRIJLA/p4No/L8jk0XKvvoLG4p5epVYTOPoU5GPepGAV/eiQgmtBnxeyln80VQ5VknegZZhtrYU7nIHnFDDD5jqv3zd87ovYH8rie9P5So7ukarpg7wyRFSL38aY2a6l9z640E/A6R9kejmSx8WfIMzW/jgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742090; c=relaxed/simple;
	bh=Ksva+wfn0CReW6rUV5N6llmxN+3O78pERuQAmTflEhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVihvx4SMA1LZAynnoky4LaHk3sIAqs4xwtZcgs4jFGw+5mMXScqaBDRPV5ERWkxiYoin1Ye16BqEWXGdK2dNGh6y2EDFwOap6a8XHzxNvKI2j8L74dxAWXi/EQdHSzrz0uJeeaZP1HTH/CB+hFzFTMU3vuBs/XNUzixaYfC+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PZ/yExiM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PZ/yExiM"
Received: (qmail 12885 invoked by uid 109); 4 Nov 2024 17:41:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Ksva+wfn0CReW6rUV5N6llmxN+3O78pERuQAmTflEhc=; b=PZ/yExiMW+ym4DhFq9KFJtPSUkKwGfRk17C9q+kIl1cl1iigvjIJeQsjwNXzNsc0L3UtGkVKqCBbd6xns76ZgDzRh5BPEnPU/V7ig9eowFQIR9ydyS/Rm1HG3L/zqOFG49g1rN2g79hmfeiGN3IH9iEz7BuUP2pjIJ+0n3Sp2ZNTf2eW2lDc9CXorTxmNkQTisnE4O5yvYW0o/4yH0QZ+bX+Dn0ljOE0QjBwKk6x0FMWB3+1gVzLIF0jjCf8fotF2bm2CHgYRN771cJEwdn43P621wOPuZAQ05OYl9XI2QgKYDbdN+ZY6gNRMv0XJza/99q3A1XiRuzVwCakjiIvog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Nov 2024 17:41:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14689 invoked by uid 111); 4 Nov 2024 17:41:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Nov 2024 12:41:27 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Nov 2024 12:41:26 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rev-list: skip bitmap traversal for --left-right
Message-ID: <20241104174126.GB2985568@coredump.intra.peff.net>
References: <20241101121606.GA2327410@coredump.intra.peff.net>
 <ZyToaRxR7upLg0IE@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZyToaRxR7upLg0IE@nand.local>

On Fri, Nov 01, 2024 at 10:40:41AM -0400, Taylor Blau wrote:

> Nice find, and well explained (not just why it doesn't work today but
> could in the future, but why making it work in the future with bitmaps
> does not necessarily a clear performance improvement).
> 
> Probably you and I should think more about other rev-list options that
> *don't* work with --use-bitmap-index. I share your feeling there that
> there probably exist such options which silently do nothing (or the
> wrong thing) in the presence of '--use-bitmap-index'.

I'm pretty sure --cherry-pick and --cherry-mark are examples, but I
suspect it's the tip of the iceberg. I don't know if it's worth spending
much effort on this. It's certainly a wart, but there's a certain amount
of "if it hurts, don't do it". The --left-right one bugged me so much
just because I thought it _would_ work. ;)

-Peff
