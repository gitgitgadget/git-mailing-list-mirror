Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832721A76D4
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684821; cv=none; b=O4NiFW1Kxg4oGvLqKruX4e0z9fj0jA2qzdZDpx+kKiQkLcZ2BE/vC72s6JLGU8zcr2HuQ4popNFzm88yP+uSq18uhUTyf4dE+u4bH5M9ih8NIFGxEYX508ZokPRoESKI9g8peWcg/rQXaQsOhexVtG+6GEdG5crQk8H7UjPSpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684821; c=relaxed/simple;
	bh=3vUs6M+riaDagGmo64s00ggU5Z/CJUpRb1ywZewbUIM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQretiQlp6Y1jiCCt2uS2d15bSU9NdJJc5LnTZSUjGnDc+Jdbs20EVNQzHIVQ6Nn7TOVC4U/XsSVKJQvBc69H32tw0+BFHcdh8vj5R0XD+BwBSGZMJPB6SpQdyvfKu+4lNAVp/vaTHrbt0erFvc7e3jPc/S/UQnNswzA8jhkKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=H/S9YI86; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="H/S9YI86"
Received: (qmail 8379 invoked by uid 109); 20 Dec 2024 08:53:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3vUs6M+riaDagGmo64s00ggU5Z/CJUpRb1ywZewbUIM=; b=H/S9YI86vlyn7oUwtYETpc9lfjFKXexc0KfYrPpLvtBxGMm+80geZYGYCs5ARUmbQg5M9quY/OLlFtwuYoLxlBHi8DF9817ySY30CJb6qfgP5mLlJitFjA4ulriCHciMtcZWp9BFBi0vcjBYS6QFWyXhGIr5oQ4XMNLNl2gVcCEScdwhezNX6JBc51Fzc4NrEYjpwCDv1SPlFXOPd9nqr1PdmVmnb77Ag4inMQ1AJwjab34zh7hk1uV0xKcQmLmcEx9yAwABXIUqiTjpaU8AJhJwLz62HhjrA598+TuGPTSZOAWCyaHjy9cB3JzX9fAcPE4Tx9VNfYlB4h4ewJHSVQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Dec 2024 08:53:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14342 invoked by uid 111); 20 Dec 2024 08:53:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2024 03:53:38 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Dec 2024 03:53:37 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: Re: [PATCH] prio-queue: use size_t rather than int for size
Message-ID: <20241220085337.GA133148@coredump.intra.peff.net>
References: <20241220084949.GA132704@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220084949.GA132704@coredump.intra.peff.net>

On Fri, Dec 20, 2024 at 03:49:49AM -0500, Jeff King wrote:

> -static inline int compare(struct prio_queue *queue, int i, int j)
> +static inline int compare(struct prio_queue *queue, size_t i, size_t j)
>  {
>  	int cmp = queue->compare(queue->array[i].data, queue->array[j].data,
>  				 queue->cb_data);
>  	if (!cmp)
> -		cmp = queue->array[i].ctr - queue->array[j].ctr;
> +		cmp = (queue->array[i].ctr > queue->array[j].ctr) -
> +	              (queue->array[i].ctr < queue->array[j].ctr);
>  	return cmp;
>  }

Sorry, just realized that "diff --check" (and apply) complains about the
indentation here. It's a TAB followed by 14 spaces, instead of two TABs
followed by 6 spaces. I guess caused by me lining things up manually.

-Peff
