Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A932296FB0
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338007; cv=none; b=TJWMiEYgUip+wCWdkTqyizXKC59jvvc7j1/cc2wV/pnEF3Put6E0NzafzK87CEoAZmFyI7TCb4adv5beOy9vTYUa7scdrBaelHJaOEfmBLqTIOPifKjLpxDg+OTtMY7VYpoe5pmGYFLH3KhHzgmicGtUZumrFzlYXBWGQ9iQ2e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338007; c=relaxed/simple;
	bh=B0ViITKlDYGU9AyNOfN2U5XFoBNazaY9KHq57mPrZ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btsAvziclDdwAibTbKxdiH/zaRNx/bD/LlyONRyGU3Ge0e1q65NvwPbokqrekrvS3jzYSpOjctD34X22M4ow+ajYI763oBwL+2YeKwoTneBsp62tLWRo0aqRBsugQ3yEVaTM4FD1tb3z/OoWDK1ptN/GSAguB34qyiOui8I3NL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MNV42ayA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MNV42ayA"
Received: (qmail 477 invoked by uid 109); 15 May 2025 19:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=B0ViITKlDYGU9AyNOfN2U5XFoBNazaY9KHq57mPrZ1k=; b=MNV42ayAk+LJtPA8XO7xenABtAEYdc9jwAyu9km3iqLGd7vS4NfF6DQCmbC1zpG21oT/Md+WSDSTDkimwulkOX70ix5mYwrsLeIoV00p4wy3C/GrFQgp8FfzrMIVFPm2MEhRoJAAlAP0HRPXXSJjkDapUYCoxweohN9rhdVbxNx1hJ03hkZCYPgIZK7Mgs8iPR6Hrp2sJGCoVkk3dllggJ6na47GfStJrSoLzhuSpRABmr5VJuT5iQ5hq9N7fhcagzMbHminRLHko+0vtFyVrIu9BqXe5PhNx60GvkZ8UXiu8GVvctVA85i0fAwMGZTo2eWWJ1QeRLcK8bUf/anprw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 19:40:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30323 invoked by uid 111); 15 May 2025 19:40:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 15:40:06 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 15:40:03 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/11] fetch: carefully clear local variable's address
 after use
Message-ID: <20250515194003.GB3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <c66eaee64ad5484120f1905ce5501fd8b75b2266.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c66eaee64ad5484120f1905ce5501fd8b75b2266.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:40PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> As pointed out by CodeQL, it is a potentially dangerous practice to
> store local variables' addresses in non-local structs. Yet this is
> exactly what happens with the `acked_commits` attribute that is used in
> `cmd_fetch()`: The pointer to a local variable is assigned to it.
> 
> Now, it is Git's convention that `cmd_*()` functions are essentially
> only returning just before exiting the process, therefore there is
> little danger that this attribute is used after the code flow returns
> from that function.

I was going to say: the real sin here is using a global variable in the
first place, without which gtransport would not survive outside of
cmd_fetch(). But the issue is even worse than that. The acked_commits
variable is inside a conditional block, so the address is stale for the
rest of cmd_fetch(), too!

It doesn't look like we ever examine it after that, but it's hard to
trace, since it's a global. ;)

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index cda6eaf1fd6e..c1a1434c7096 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -2560,6 +2560,7 @@ int cmd_fetch(int argc,
>  		if (server_options.nr)
>  			gtransport->server_options = &server_options;
>  		result = transport_fetch_refs(gtransport, NULL);
> +		gtransport->smart_options->acked_commits = NULL;
>  
>  		oidset_iter_init(&acked_commits, &iter);
>  		while ((oid = oidset_iter_next(&iter)))

Here you unset it within that conditional block, which is the right
spot. Looks good.

-Peff
