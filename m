Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49663342501
	for <git@vger.kernel.org>; Mon, 11 May 2026 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778522325; cv=none; b=kRAheKsltIVbsIAj+eSZ1PGMjp1RIzlJiTzPFbr78aPxM+brirNm+HvgGMJWWy47UR4+4P91p3uqBV7pJqaTvlSIjTh5dftlgNp5Sq6jc/nBRAyO0oSCUDBEioHmYw3uSgkgarzNjVA+ZT6y58kwnxH5wzuIo7z73tUkctcYQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778522325; c=relaxed/simple;
	bh=ltbOmhvxd+Ut5QAIZ7Q3ESvYFOZin/ix3bTxohP1z4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqIQiKdTEMRkR31Ap0oySVUF/QBwrG9ZGakBoW0l908WrtwBEiWu4vmVj/27MXZarbdm+5wIPGN93/Y5qil25GbduWHRsltG1dclD+h406eeKSx8vnz/cpftqADrBfvcpp7HC6hPO7/4HUNmSyMYP7OJMdkv/s6mvZ+KgjnT8tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cdlHV0iQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cdlHV0iQ"
Received: (qmail 18747 invoked by uid 106); 11 May 2026 17:58:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ltbOmhvxd+Ut5QAIZ7Q3ESvYFOZin/ix3bTxohP1z4s=; b=cdlHV0iQ0JMsxBoZKKZUlY78CpfncPE57VvVQEVurP7uelQbOF2WyMHUn0cOhfNP0jVCH8vPOcBC2rKyfTwPZNBftKLcL+aBuERYVvTMJG8USCxUbiRZXKj6z1PrAI5NdBU8aSPSy3kuJ6FjHXd2s70OGBur/vjrENLipWFbYBeeaLk+e7XJeY2ugkxC2OzL/3iwXIAPs0aDQmDB+AwYbAtJCt/yWKzvtrQ2xQhzZcmt6/qPf7CYJLJzpbC00VQtnLwSIKVVMLzg7t0suL5og5/6GR1wSyOZNbkFj3gS6drQcM8jkREKzQrgjQw+whIW6c64lMCdf5bnITB0VVmEDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 May 2026 17:58:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32387 invoked by uid 111); 11 May 2026 17:58:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 May 2026 13:58:35 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 11 May 2026 13:58:35 -0400
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v3 3/7] odb: update `struct odb_write_stream` read()
 callback
Message-ID: <20260511175835.GA4811@coredump.intra.peff.net>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
 <20260402213220.2651523-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402213220.2651523-4-jltobler@gmail.com>

On Thu, Apr 02, 2026 at 04:32:16PM -0500, Justin Tobler wrote:

> @@ -1098,9 +1099,16 @@ int odb_source_loose_write_stream(struct odb_source *source,
>  		unsigned char *in0 = stream.next_in;
>  
>  		if (!stream.avail_in && !in_stream->is_finished) {
> -			const void *in = in_stream->read(in_stream, &stream.avail_in);
> -			stream.next_in = (void *)in;
> -			in0 = (unsigned char *)in;
> +			ssize_t read_len = odb_write_stream_read(in_stream, buf,
> +								 sizeof(buf));
> +			if (read_len < 0) {
> +				err = -1;
> +				goto cleanup;
> +			}
> +
> +			stream.avail_in = read_len;
> +			stream.next_in = buf;
> +			in0 = buf;

If we hit this "goto cleanup", we'll leak the "fd" descriptor opened
earlier. We either need to close(fd) here, or do so in the cleanup
handler (but that means consistently setting fd to a sentinel value
after we close it, which we do not currently do).

Noticed by Coverity (I guess this series just hit "jch", since it's
"new" as of today's run).

-Peff
