Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE613BC26
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225377; cv=none; b=Jc4/D2S4Ckb85nBlfkCSD+qcIfJ3P6eM2bF3fECbOdfyolmQmej/U4VlZ5zpUAep6j4Ul0FnNnUC5FCyt2XVUb+QVmReFWldvIv2szZaDOtmcaoOqL8uqu4oeEX3KzxbxNIAtmL3NLigceUT7h86oWOp4QDK8UkFZV0MxnVqyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225377; c=relaxed/simple;
	bh=cCxwruEaWUnC0hTy4IMHF8qjg7+gmi0jhC2iBhXGgSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMi8kGMr9AdfOhQXe5ww9c+JweZuI103UUqNR0CEAIl0KKZlqyJ8RVILu4gmnPpIGvD4Rw7xvH2xouZuGbjiWndPtLbZameoJdnCJNFZ8Y3oOdcJ/4YSYfl3SAj4Wz/v3VchkbbUQzhudxVe9ULV5E2DkgQMSpa7G+LFFk6QMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PlJYs3aq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PlJYs3aq"
Received: (qmail 32186 invoked by uid 109); 18 Oct 2024 04:22:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cCxwruEaWUnC0hTy4IMHF8qjg7+gmi0jhC2iBhXGgSc=; b=PlJYs3aqM+C8CtG/iDBxB5w2WgPZ+IOt/i8mG74aOtsezcky6BWCxu7eZMnSNwI9tYwC44Ofw8BW7iLupKdHe+ce2zXVPhxemkZJO1XjXpVjVwtazqHf0vJAowS/+A4RrzGZCtntQqNNipZz1C1koV8tUZjXUX+xMjUxy00DWitR0oFWzz0C0PwjnpxAMYD0hy+GWmySnxCRHzh24iTvGjPDR8bJ/+hy709l1WUooxGXpbRXSQoEUHh+emAR3CepadfHbgNVAVnG7MuL0GuaQUWDOamSrejqpMBFNnY4hOVKB7QZdvltLz1uhmlCxFfnYxDrHjxQZPonf6ewpDegbw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Oct 2024 04:22:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12313 invoked by uid 111); 18 Oct 2024 04:22:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2024 00:22:47 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Oct 2024 00:22:46 -0400
From: Jeff King <peff@peff.net>
To: Henry Qin <root@hq6.me>
Cc: git@vger.kernel.org
Subject: Re: Why is git log on large repos slower when outputting to tty?
Message-ID: <20241018042246.GA2408674@coredump.intra.peff.net>
References: <CAO8bsPASzxoEwiYd7ABf4YZuyTexFnf2B2DXap6xsA6d98DAAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO8bsPASzxoEwiYd7ABf4YZuyTexFnf2B2DXap6xsA6d98DAAw@mail.gmail.com>

On Thu, Oct 17, 2024 at 10:46:17AM -0700, Henry Qin wrote:

> Details in my Stackoverflow question:
> 
> https://stackoverflow.com/questions/79099095/why-is-git-log-significantly-slower-when-outputting-to-a-tty

My first thought was "decorations", and indeed somebody gave that answer
in the stack overflow thread. The default for log.decorate is "auto",
which will turn them on when output is to a tty. You can set it to
"false" to disable it.

As for why decorations are slow: it is necessarily going to be at least
linear in the number of refs, since we have to build the reverse mapping
up front. Do you have a lot of refs? What does "git for-each-ref | wc
-l" say?

-Peff
