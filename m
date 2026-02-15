Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073678F48
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 07:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771141397; cv=none; b=gevSJyQaklP8WnYU+z02w8jr5mE2r1DEV5TBMD5T0+P0B07FaL6m4XPA7hYGQYXee6OViz5EQ7zeXlBPIo0MAObo/gWHD6QZFpR4QKWaBDPgZr1pX3zxN0zVklVUZ9Rx6iRoXljGrfHZY0pUmhgyfdiopbtOE4BNovXhd+Injjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771141397; c=relaxed/simple;
	bh=YQr4FhWdo+NE50TK94ax2rWUErBDf1u/8MgQHNqzQD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/ec8L9ZAzeiTSrOX2a/Jj//Huzc+55y2ydNCro7s9IoVDIe4yujVYy1sl9jzQnVw53NqExLgNeOJRO5yjzR8XGKMgdg3nT2Yoof7BBU6BG3ZGHrEvq/eXDzvz4sjJt+LtoEYPqBF31XYFRcClttxrbgsxke37FH9vvVO/yeU48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MySCkxfx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MySCkxfx"
Received: (qmail 44147 invoked by uid 109); 15 Feb 2026 07:43:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YQr4FhWdo+NE50TK94ax2rWUErBDf1u/8MgQHNqzQD8=; b=MySCkxfx6yglogimp9Lmth63TvFaI9vyRbQjsSfQ6xo8jrG5zh5JXLENg1YWjxYnYCs90RwX2G+MK6GLZydw9z2ECFowH4K8FWEuO1VGoUyHfEjxolzuHg4OutPr13+VA+Upz8IpKuNL2umu6auwHcqoDhP7YzUW/QdEg/5xUcgTpDLoT+x38mB859maaJavCnYcefXuRyR7zDgaqJojowY58CDkLI0ulnE81feD+gOiBXqr+0DjOciNUN0SY/xoaxpcWI4u+7tqF3dMLSSbCKtvQLz/9/tXzIqsKRyXd4pjGAszvpAizXTU8BZhvwWJxg1bjxRknDmp0d3cNT15UQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 07:43:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111187 invoked by uid 111); 15 Feb 2026 07:43:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 02:43:11 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 02:43:06 -0500
From: Jeff King <peff@peff.net>
To: George Hu <integral@archlinux.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on
 Linux
Message-ID: <20260215074306.GA86282@coredump.intra.peff.net>
References: <20260213124656.218396-1-integral@archlinux.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260213124656.218396-1-integral@archlinux.org>

On Fri, Feb 13, 2026 at 08:46:56PM +0800, George Hu wrote:

> The `sendfile()` system call copies data between one file descriptor
> and another within the kernel, which is more efficient than the
> combination of `read()` and `write()`.

OK, but...does this efficiency matter for the callers of copy_file() and
friends? Just skimming over grep results, it mostly seems to be used
with files we'd expect to be small. Some possible exceptions I can see:

  - bundle-uri with a file:// uri will use it (so this could be a big
    packfile)

  - in "clone --local" mode without hardlinks available, we might copy a
    packfile

To some degree, if it's easy to use sendfile(), we should just do so if
it might be a bit faster. But as responses from others showed, there are
some complications we'd have to deal with (portability, fallback, etc).
So I think it would be a lot more compelling if we could show a
measurable speedup for some real world operation.

-Peff
