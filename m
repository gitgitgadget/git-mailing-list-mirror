Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81F152170
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818270; cv=none; b=bhHUgF8nmFNOOuviuJNimfepkF36WhU9Bv+rwcfL+78NxwCJOZjd1eUByH0isrqzX0noBG/Sdu/XUKiE8WTO9R8Y6FjnJdy0CXaHeRM02M6gzoLIeJzkxtjIe8Q81L+3qx08leRBQrJlMnBmaGaC0D8ekt4c83STSHP3usgY/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818270; c=relaxed/simple;
	bh=RLAwQtRHRvLYNa9H1wFXCNtgjSbgxHUFx85i0qBQiT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKFagfE5AeVYAgOPe7iROcL3O7WwKSSqIp+DPJcBWmN/5n5SKjNv8M/JjJlAzCo9RRXnvRIhd6mVTspE2MoS1coc2UPRCU/b/bHN9AlDAgqLhSteTQDs+WApfl+DRhwyNqy8msNc132jeKpK8+O6QuPzPLWAbCqTrX5gvpsk1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 10500 invoked by uid 109); 19 Jun 2024 17:31:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Jun 2024 17:31:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23386 invoked by uid 111); 19 Jun 2024 17:31:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Jun 2024 13:31:05 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 19 Jun 2024 13:31:06 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] commit: remove find_header_mem()
Message-ID: <20240619173106.GA1519400@coredump.intra.peff.net>
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
 <8b350cae-2180-4ac7-a911-d40043576445@web.de>
 <0d85712c-5beb-4a64-a7f4-797782c26694@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d85712c-5beb-4a64-a7f4-797782c26694@web.de>

On Wed, Jun 19, 2024 at 07:13:19PM +0200, René Scharfe wrote:

> cfc5cf428b (receive-pack.c: consolidate find header logic, 2022-01-06)
> introduced find_header_mem() and turned find_commit_header() into a thin
> wrapper.  Since then, the latter has become the last remaining caller of
> the former.  Remove it to restore find_commit_header() to the state
> before cfc5cf428b, get rid of a strlen(3) call and resolve a NEEDSWORK
> note in the process.

That of course made me wonder what happened to the other caller(s) of
find_header_mem(). The answer is that it went away in your 020456cb74
(receive-pack: use find_commit_header() in check_nonce(), 2024-02-09)

> -const char *find_header_mem(const char *msg, size_t len,
> -			const char *key, size_t *out_len)
> +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
>  {
>  	int key_len = strlen(key);
>  	const char *line = msg;

Not new in your patch, but assigning strlen() to int tingled my
spider-sense. It's OK, though, because "key" is always a small string
literal.

> -	/*
> -	 * NEEDSWORK: It's possible for strchrnul() to scan beyond the range
> -	 * given by len. However, current callers are safe because they compute
> -	 * len by scanning a NUL-terminated block of memory starting at msg.
> -	 * Nonetheless, it would be better to ensure the function does not look
> -	 * at msg beyond the len provided by the caller.
> -	 */
> -	while (line && line < msg + len) {
> +	while (line) {
>  		const char *eol = strchrnul(line, '\n');

OK, we no longer know the length of the message, but we don't need to
because it's NUL terminated, and strchrnul() will find the correct eol.
The length check might have saved us if we accidentally pushed "line"
past the NUL terminator, but it looks like we take care not to do so in
the loop body:

	line = *eol ? eol + 1 : NULL;

So the conversion looks good to me.

-Peff
