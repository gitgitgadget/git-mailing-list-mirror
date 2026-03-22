Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04A37B037
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774143467; cv=none; b=d879tRNmdCpFB8Mpjjkgyb1O+jwoUcS7Kf64b8jmf/nDxLzX092NHxbbnSjNBjluEjS0eqxzIAcvW3tSWZrhW/swQVWyhj7daGg0CMSBVVGnAPcisFXRjd6t5Sb/X/j6eFrunegKYIr/Y6pbK0nvSYRodOi3li87I07cFUm0I+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774143467; c=relaxed/simple;
	bh=GgESfNcvws6Nag7iKkktfE147iyouiH//uHLb5Zd0KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9A9EEa8kq8aCto8bdEg3i0TG8DFLqg/npy0a7FsaKwzfZxMXMAjVxWfXwKFYlJWUGzFkzhGpsqmv3n1CkCr9ceXnL7aG2w55wfZyPPGgxcF3VKVtTzvqPMxAnGz6EA1Mkfh4B9MXY5hTBMEVUrUiHcvatQj1d44gLdE1ReXwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z12Wi275; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z12Wi275"
Received: (qmail 92050 invoked by uid 106); 22 Mar 2026 01:37:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GgESfNcvws6Nag7iKkktfE147iyouiH//uHLb5Zd0KM=; b=Z12Wi275l0lauSHZUsup1GNEC5IUmiOiJbuKze1YsF1ni6t4P6r2h2q6dRxZHQIWsWt/S6Qfav8Bm7VDSYaP+1qmPg7jIbOcI7gcD9hiVvorgcVTFhxWfVZ9D+XZfcaimtUw/Q47AmYohQtYa3yNewBLz0qbfj+xPJNTYwff0+cskMuet1bt6oxEq/+bEr1fCK9l3Ud/u6W58zw5eBlwxWYGU6GLOXKr1ZJq+sjg8yWXVm6EP+YNrLNnEBNvYp0lVzGx5flfKoIYr9HAsq5DbVK72luSaz2J6Rr3Y0Ic5gdCbMBlWtklt17976DJHLYIH+o4BR0UZAWgLG+4YPCuhg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Mar 2026 01:37:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 126889 invoked by uid 111); 22 Mar 2026 01:37:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 21 Mar 2026 21:37:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 21 Mar 2026 21:37:44 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jo Liss <joliss42@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: remote-curl: segfault parsing remote.<name>.fetch outside a
 repository
Message-ID: <20260322013744.GA816455@coredump.intra.peff.net>
References: <CAN=xy38zCRdOAnMtBXtRyUHE=+gtS8J6mwUWFQqxDAaBLAm7dA@mail.gmail.com>
 <20260321210602.GA736981@coredump.intra.peff.net>
 <xmqqa4w0acdr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa4w0acdr.fsf@gitster.g>

On Sat, Mar 21, 2026 at 06:20:16PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's a curious case, though. The crashing code is parse_refspec() does
> > this:
> >
> >   if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
> >         item->exact_sha1 = 1; /* ok */
> >
> > But what is the correct hash algo to use here when we are outside a
> > repository?
> 
> Hmph, who is calling into the transport outside a repository in the
> first place?  Even "git clone" should create the receiving
> repository before it calls into the transport, no?  Is this "git
> ls-remote" or something?

Yes, exactly; the real-world case that Jo mentioned is ls-remote.

> > to make the segfault go away, but it is mostly papering over the
> > problem. I'm not sure if the exact_sha1 flag would matter when we are
> > not actually fetching (and we cannot fetch when we are not in a local
> > repo). Grepping around, it looks like it does influence the ref prefixes
> > we send to the other side (yet another chicken-and-egg!).
> 
> Yup, I agree with your assessment that exact_sha1 should mostly be
> garbage if we do not have a repository in the first place.

There's at least one more instance of the same problem:

          if (item->negative)
		...
                  else if (llen == the_hash_algo->hexsz && !get_oid_hex(item->src, &unused))
                          return 0; /* negative refpsecs cannot be exact sha1 */

It might be OK to quietly disable the check outside a repo there, too.

-Peff
