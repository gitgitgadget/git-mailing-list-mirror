Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573CCA6B
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723915121; cv=none; b=q+zugepF2FIJuI5fiMxJLOYNyaw79eAXkQp6yYlb8VnEohK38ScTBdaBR1Hwaz8+cALm/bK1svPd2gIgzAVmHNH5YmsxDZOs7nDgZKPK+REIcaqqed9T3rzuaFlZNXAyWY8z7lU7y1qrNgUzenvxaNECHsKr250zfq9RuR6KCI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723915121; c=relaxed/simple;
	bh=eGdbJZm/fTIFGltdJ9AJmTSG92MWnZyc4RTbvOJkvhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOEHByb6agb/IchJhSTE75/SR7eBS4RUMipgemggXISDKuE+5mbevGkoLs8Mjlq0CLWUhsy/bH26YoU55BlCBEA3ssfrlx3MTt1b6HoPO1hdlatZLn5CCN1ATs9heQ/aXcOwUqIfID6qDpfzdM6uR9j0oSL3JuwuPHnwSUBhDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28851 invoked by uid 109); 17 Aug 2024 17:18:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 17:18:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31633 invoked by uid 111); 17 Aug 2024 17:18:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 13:18:37 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 13:18:35 -0400
From: Jeff King <peff@peff.net>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/15] t-hashmap: mark unused parameters in callback
 function
Message-ID: <20240817171835.GA2869474@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
 <20240817082447.GK10287@coredump.intra.peff.net>
 <D3I9DJRMAQD4.UIBX5HG0XYL2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D3I9DJRMAQD4.UIBX5HG0XYL2@gmail.com>

On Sat, Aug 17, 2024 at 08:02:36PM +0530, Ghanshyam Thakkar wrote:

> Jeff King <peff@peff.net> wrote:
> > The t_intern() setup function doesn't operate on a hashmap, so it
> > ignores its parameters. But we can't drop them since it is passed as a
> > pointer to setup(), so we have to match the other setup functions. Mark
> > them to silence -Wunused-parameter.
> 
> Sorry, but I didn't understand why we can't drop them and just call
> t_intern() instead of setup(t_intern) (I should've done that, when
> writing this). By 'other setup functions', do you mean other test
> functions which use setup()? I don't think it is necessary to have
> uniformity in function signatures of all the test functions.

I just assumed that setup() was something that should be called for each
test. But yeah, looking at it, it is really only creating and cleaning
up the hashmap. Since t_intern() doesn't need any of that, then it
should be OK to just skip setup() entirely.

> -static void t_intern(struct hashmap *map, unsigned int ignore_case)
> +static void t_intern(void)
>  {
>  	const char *values[] = { "value1", "Value1", "value2", "value2" };
>  
> @@ -356,6 +356,6 @@ int cmd_main(int argc UNUSED, const char **argv UNUSED)
>  	TEST(setup(t_iterate, 0), "iterate works");
>  	TEST(setup(t_iterate, 1), "iterate (case insensitive) works");
>  	TEST(setup(t_alloc, 0), "grow / shrink works");
> -	TEST(setup(t_intern, 0), "string interning works");
> +	TEST(t_intern(), "string interning works");
>  	return test_done();
>  }

Yeah, that makes sense. I'll update the patch accordingly. Thanks.

-Peff
