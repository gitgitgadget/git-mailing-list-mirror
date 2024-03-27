Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720E125C9
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531065; cv=none; b=mveQz0nuxh4ou5BovM1aDI3IA20hqpomKZ+qO7gOCkjwABw9DHw4MF4XAV8IAIHs317s4LmdySGWZzZGsArmH28obzhtc/z0vW+nC8aqjGx9x3DNgOP7thgISO5+MeEiqE/v51o2jPblnRn0So2box2mNUYDeDVONdH465uqgbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531065; c=relaxed/simple;
	bh=TFRjVGucKFJ6aKZ0dM+PNgudQXcM/wqj1KAMwyzyYZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmK5ILIEkaKRLqpH2h2dHAzv1l4fA8w8C1Qm2Rh0bAOSAvjLj1eWjSahuWfjsiCb0KWCkEdbM0A9vRbz2eRnKqkN3txH/8zqttWDf4akB0WUtq1D40lH9UDOR1Zw6e0AW8Irttk5qGZtQMrw5l9jnbh+M4O4yGTmxW6o0bqzLcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22441 invoked by uid 109); 27 Mar 2024 09:17:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 09:17:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24940 invoked by uid 111); 27 Mar 2024 09:17:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 05:17:48 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 05:17:42 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han Young <hanyang.tony@bytedance.com>
Subject: Re: [PATCH 0/1] quote: quote space
Message-ID: <20240327091742.GA847537@coredump.intra.peff.net>
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
 <xmqqttl2qml9.fsf@gitster.g>
 <xmqqfrwlltjn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrwlltjn.fsf@gitster.g>

On Tue, Mar 19, 2024 at 03:56:44PM -0700, Junio C Hamano wrote:

> Unfortunately, this loop can terminate prematurely when a crafted
> directory name ended with a SP.  The next pathname component after
> that SP (i.e. the beginning of the possible postimage filename) will
> be a slash, and instead of rejecting that position as the valid
> separation point between pre- and post-image filenames and keep
> looping, we stopped processing right there.
> 
> The fix is simple.  Instead of stopping and giving up, keep going on
> when we see such a condition.

That makes sense, but leaves me with only one question...

> @@ -1292,8 +1292,15 @@ static char *git_header_name(int p_value,
>  				return NULL; /* no postimage name */
>  			second = skip_tree_prefix(p_value, name + len + 1,
>  						  line_len - (len + 1));
> +			/*
> +			 * If we are at the SP at the end of a directory,
> +			 * skip_tree_prefix() may return NULL as that makes
> +			 * it appears as if we have an absolute path.
> +			 * Keep going to find another SP.
> +			 */
>  			if (!second)
> -				return NULL;
> +				continue;
> +

If we saw a NULL from skip_tree_prefix() because it really was an
absolute path, is continuing the right thing? Or put another way: will
we continue to correctly reject such an absolute path, and not
accidentally find a pair of names?

I think it may be OK because true absolute paths imply that the first
entry would start with "/", and we would already have bailed earlier in
the function. So:

  diff --git /foo /bar

will already be rejected at the start of "/foo". And in broken input
like:

  diff --git a/foo /bar

we must assume that the start of "/bar" is a possible name, which is
what your patch is fixing. And in broken mixed input like that, we would
fail to find a valid split point, and correctly return NULL.

I guess these happen in practice with "/dev/null" as the left-hand side.
But there we'd never need the names from this line, since we'd have a
separate "deleted file mode ..." header line.

-Peff
