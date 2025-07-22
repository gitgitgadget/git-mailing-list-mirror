Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4521B191
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172696; cv=none; b=DB3mou9vLcdvfTerjjYNBvhOfxuhzeaHkU3PPhJFO4ZZvWx7bq6N9AXKIe8rLuAMP7CBpL+1obXaAkU2MLap4vn8EHdkHflhbaJBugtA8L9UaJ0xSvBL/k3oJTMRX1NQ5YqhzOc2M9Btn0fKVkfiGCcI6sLzGFrRe7oDgtNZc1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172696; c=relaxed/simple;
	bh=Eqaq99v+7fXxiofSDy4ZKkvkCROqwXwxl6lIKcM2uDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gplRHcPakW1Sb6fdhT6mVQFebhgLJYtl1rN88iRKF1i/6imRN5jOjl7dBXKO/FazzM3IuRA7GqAZUAvU2JdXR3oC8+LiCGB1ANezfGPYH983v+vJ6PTjQlsLSoa+7ERYHguYcTCuSggibwuTTydMX3gwmM0SGL2ZK8maYEndtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YJolcdOu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YJolcdOu"
Received: (qmail 26891 invoked by uid 109); 22 Jul 2025 08:24:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Eqaq99v+7fXxiofSDy4ZKkvkCROqwXwxl6lIKcM2uDQ=; b=YJolcdOuauOOPwXXkKTe7D1XvI1/gQoTi71s4O74Jo8sC3TCqBXKZQqFngydrqSq+dFlwvRYSUlaOu5EpRwUqqrhsyqIwoWxUlXkH2THNzHXsMUphFEh6LMNkWm1ZEOLDaGZ+TyRb+17xEYu5REXYNKok0oxvAErkdjPHy6VMHqriAPkiCi3kTtisdxIxeTgdu0BkLMZWbzT+RKbvDt/RexNAad72ZROH/uV2Oo5zPqNOImFMrFBVZis6e0Sujnv/Mm5sO4/4TdjZAk2RkwBDWiDS/YmpeKPM5d11dMFDJ7AzKXWub2ieiiVaLzyB1s8q4ZaY578hYViwkCGMsPzWg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jul 2025 08:24:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26548 invoked by uid 111); 22 Jul 2025 08:24:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jul 2025 04:24:56 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 22 Jul 2025 04:24:51 -0400
From: Jeff King <peff@peff.net>
To: Hoyoung Lee <lhywkd22@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] builtin/archive: close file descriptor on dup2()
 failure
Message-ID: <20250722082451.GB862006@coredump.intra.peff.net>
References: <20250722081219.1086866-1-lhywkd22@gmail.com>
 <20250722081219.1086866-3-lhywkd22@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722081219.1086866-3-lhywkd22@gmail.com>

On Tue, Jul 22, 2025 at 08:12:17AM +0000, Hoyoung Lee wrote:

> In create_output_file(), the file descriptor returned by xopen()
> was not closed if dup2() failed. This leads to a potential resource
> leak. Ensure the file descriptor is closed regardless of whether
> dup2() succeeds or fails.

The other patches in this series made sense to me, but I don't think
this one does. It is not really a "leak" in the sense that output_fd is
still on the stack when we exit (via the die_errno() call).

That may sound pedantic, but we have run into the same question with
memory leaks. If we are not unwinding the stack, then we can never fully
clean up the program state. E.g., with:

  void foo(void)
  {
	int fd = open(...);
	if (bar() < 0)
		die(...);
  }

it is tempting to think that you should close(fd) to clean up your
state. But now imagine that bar(), instead of returning an error, itself
exits the program, like this:

  void bar(void)
  {
	if (baz() < 0)
		die(...);
  }

It _can't_ close "fd" because it doesn't even know about it!

So when we consider whether something is leaking, I think it only makes
sense in terms of unwinding the stack. And likewise any automated tools
we use should consider that.

> diff --git a/builtin/archive.c b/builtin/archive.c
> index 13ea7308c8..c919a39f90 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -14,6 +14,7 @@ static void create_output_file(const char *output_file)
>  	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
>  	if (output_fd != 1) {
>  		if (dup2(output_fd, 1) < 0)
> +			close(output_fd);
>  			die_errno(_("could not redirect output"));
>  		else
>  			close(output_fd);

So I don't think this patch makes sense, but also...does this even
compile? You did not add braces around the conditional block, so we'll
call close() on failure but we won't call die_errno() anymore. And the
else is no longer coupled to the if (because of the unrelated die
statement in between), which should cause the compiler to barf.

-Peff
