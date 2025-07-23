Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75226C39F
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257320; cv=none; b=LrZJ4isIxjj93AUVpBM5XqPVaWbxhLwe4q4rfKFaDthAzUDuID8KX1grcqkBhbFoTAS31PaUsl6drdl8shBDPX90mKvnIQy49CwjseNjFBqFqAU1lNmAHSF56wtlnCixlBPPXWf37Rltcz4Ybdvhrf2M2EAl5br7AHjlSzUzbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257320; c=relaxed/simple;
	bh=LY0jMDCAhGrQScdldt63WFhBlwruxAoRdxVKq0ybZc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf8BoQqY99jOEbdxisjkVN8x72uRHfqFELvNprhb01UGW/wnaS5zSxC99tOQ4EmKzbn7QFWZtLeOspP67o/xsuzY9168clSD8eo/98o37siSPSIlLaGjwETRC0GJ96TC63Cu6zhpCA5soXJNueOIJgWN9kyii/Ops+lT56pul6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=haJ3GcPw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="haJ3GcPw"
Received: (qmail 4279 invoked by uid 109); 23 Jul 2025 07:55:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LY0jMDCAhGrQScdldt63WFhBlwruxAoRdxVKq0ybZc8=; b=haJ3GcPw4ObaDDdcV71NIbIFBu7xXeHG9H/ZLUO+NKVJp0tm7HgoDOxMBGO6MR9+CVeCnAyudJ122cFwGmy+E7jjeGyfTp9MzU0KHSypCxO06MTTgWFokWRwy6S4uTe8hO47gGP155k6s3lwEQDDdsXnpofb9NfRVSWoCC35H4n6UFV6YtoIHrJ3gySJvLDh6QT5Q0z6Uzs9ZXMrjowQKwAm+bFq6CiN1QjG9etTO+4lXV3mQd4AOhw6U0j7FE+qYnDV6gKvw9mTbHxBtgAEVmfyR3FIuqar4IFmvMnn/CW8HiXpPHBUZVtCNNW1oLc1sVyuSktmajey5vjEZNfzmw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 23 Jul 2025 07:55:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13025 invoked by uid 111); 23 Jul 2025 07:55:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Jul 2025 03:55:18 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 23 Jul 2025 03:55:13 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
Message-ID: <20250723075513.GA570540@coredump.intra.peff.net>
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
 <20250722174102.1876197-3-lhywkd22@gmail.com>
 <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>

On Wed, Jul 23, 2025 at 03:28:05AM -0400, Eric Sunshine wrote:

> >   close(fd);
> 
> The descriptor is closed manually (again) because a subsequent open()
> call is going to reuse the variable. However...
> 
> >   if (argv[1][1] == 'd')
> >     out_buf = diff_delta(from_buf, from_size,
> >              data_buf, data_size,
> >              &out_size, 0);
> >   else
> >     out_buf = patch_delta(from_buf, from_size,
> >               data_buf, data_size,
> >               &out_size);
> >   if (!out_buf) {
> >     fprintf(stderr, "delta operation failed (returned NULL)\n");
> >     goto cleanup;
> >   }
> 
> ...although `fd` was closed, it still holds the previously-open
> non-negative file descriptor, which means that this `goto cleanup`...

Oof, good catch. This iteration of the patch was based on my suggestion,
but I didn't notice the jump to cleanup between that close/open pair.

I wonder if it would be more clear written as:

  int from_fd = -1;
  int data_fd = -1;
  int out_fd = -1;

  ...
  from_fd = open(...);
  if (...errors...)
	goto cleanup;
  close(from_fd);
  from_fd = -1;

  [...same for other fds...]

cleanup:

  if (from_fd >= 0)
	close(from_fd);
  [etc]

You could even drop that first close() in the happy path entirely, if
you don't mind holding all three descriptors open at once.

I dunno. We are reaching diminishing returns spending brainpower on a
function that is meant to be somewhat quick-and-dirty.

-Peff
