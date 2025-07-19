Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EE1C861E
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752906962; cv=none; b=rxha9cHdDvH2u/GJTG5j9yqtn5D4x1+UJEg5mLLWjT2AyPhzwv4oGenV22CwCU7PJgOtHSMlkZP9KP37oEJHHLPXeto7v2jwfiS+Buc8CWhiMs8aMklvX8h98cmMqs/cfob2toaSLHK4B+ceu1WJSUPsMjwdep5sV/uMU/CAkWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752906962; c=relaxed/simple;
	bh=6XgW5wg8RRk/iUrjCrbcaU9VE15pVO44VX39RJVvKf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyKc3NJPFFs0RVGBtUsReZEVF5s2eiuBg5HWkFqoW1/tkrTZ/dP3vvrKVkU8uqmCWQTk/ldvVWHr1FT1POO1qpv9WzSIqfHK+OUSntf4KaJ73EbsyG1c97n4yCMkLy6eo/izbG4QGPHy01AYRh4meJtG6lYwFTs2PYz/hGc+wB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fTAj0bCF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fTAj0bCF"
Received: (qmail 27120 invoked by uid 109); 19 Jul 2025 06:35:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6XgW5wg8RRk/iUrjCrbcaU9VE15pVO44VX39RJVvKf0=; b=fTAj0bCFPYqn2Vazy+HQYpBoNfd05lyzdJOLpcgF+69C2G35y5HXWBMGV40WN66tKOw24AdrPb04Yg6dw2NF8pOTpO1dDxv6Sca8VzbEn5uuAM6slaPj3TF9vTfK1EDj/9kHVnWdvmEPJVWnWSs5+rP3yP2MWjMLqwgSRTLhGgyCGNnRbK9o+ayb7sGQbZJXbjrfu84hhSRy/8bUV8SMyB7diqPQGOZFkCjXr+FsdyuiDjHhPqyFCHSFBwg8q2WEtF/TcAa7SkvaJDZVgfouiHW8ctCnnMThBgfIr77VfggBat/f3dF4wx6SEaqbFCUtwo4TdwfEmQpBI5tVO8tv+Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Jul 2025 06:35:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4264 invoked by uid 111); 19 Jul 2025 06:35:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Jul 2025 02:35:56 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 19 Jul 2025 02:35:51 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rev-list: make "struct rev_list_info" static to the only
 user
Message-ID: <20250719063551.GA705356@coredump.intra.peff.net>
References: <xmqqa551127o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa551127o.fsf@gitster.g>

On Fri, Jul 18, 2025 at 04:58:03PM -0700, Junio C Hamano wrote:

> The structure has nothing to do with what "git bisect" does; as
> nobody other than "git rev-list" implementation uses it, move it
> as a private data type to builtin/rev-list.c

Nice improvement.

> @@ -652,7 +660,7 @@ int cmd_rev_list(int argc,
>  	 */
>  	/*
>  	 * NEEDSWORK: These loops that attempt to find presence of
> -	 * options without understanding that the options they are
> +	 * options without understanding the options they are
>  	 * skipping are broken (e.g., it would not know "--grep
>  	 * --exclude-promisor-objects" is not triggering
>  	 * "--exclude-promisor-objects" option).  We really need

This tacked-on bit seems funny to me. Isn't the original more correct?
The loops do not understand that the options are broken.

-Peff
