Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E73A1A54
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772028662; cv=none; b=I+AsSATcm/ESTtdjbPIM/ceMAIy3amiTqP38U/LhIrxkeAvqtF9rjz6hy8j+w/kGozNAHY8fkVCvgcw9YSyE3BPzlTY36TV7DUf0zU6zdwQRtYUMe6dBaZMHRNV6wswoe3jr4TaE/krKqVU6WmCjnjx2ykLnD0pUt9iaUoUSvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772028662; c=relaxed/simple;
	bh=FROULuLNnf4nAwIUjxz+sG0BeqM1dac8IDUAwqSAcCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVmnB8yl9nxid2sV/cvsWBpTEpmeYZiFjMxv1k+r7KF7/gtlkf9VZPTcfXt3Y2+kP4LfIzLtA1nFKI4ZLlo+OCLzTz0MqT5Xq1xfdUyFUu3tdGaHzX11rZ9tK3ewJKDt3nfBIzEdsIhBwXi77dUIsz8a/uk2Tcz5aCf9DavUEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Sx89BZnM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Sx89BZnM"
Received: (qmail 67092 invoked by uid 109); 25 Feb 2026 14:10:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FROULuLNnf4nAwIUjxz+sG0BeqM1dac8IDUAwqSAcCM=; b=Sx89BZnMYbIr52N2eLMtQhL/bw6J0sayF3i9HzDJA6gKqxWOiAX72ktj+U6z/QXZPFyGokwt+Gx8qIUZ1BMlUOdlSqDtYi5GnLUpW84doP+Z10CFOMcfbKbB3dFYzk2zkyMNGDi7JOoe5HAKWSm5nfFyW4cqqjw63ZAf5/eI/K1N9FL/KES+WDuzllRiduymkntmyLG0hI9+PEJbyRFr48VcRIVWeba43g3hWjOXPUoZJEL5pGQELzoHe3Y6kDmcYYiVha3i38WmmEvlN1Kw81V4RTqt7ursi3a77gWN7fbViYsvI1BatNNg0L3eqPz3juIKbhGA542MNlmutY1Ktw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Feb 2026 14:10:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 200543 invoked by uid 111); 25 Feb 2026 14:10:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Feb 2026 09:10:59 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Feb 2026 09:10:59 -0500
From: Jeff King <peff@peff.net>
To: cui via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, cui <523516579@qq.com>,
	cuiweixie <cuiweixie@gmail.com>
Subject: Re: [PATCH] fetch: fix wrong evaluation order in URL trailing-slash
 trimming
Message-ID: <20260225141059.GE2139176@coredump.intra.peff.net>
References: <pull.2211.git.git.1771984857879.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2211.git.git.1771984857879.gitgitgadget@gmail.com>

On Wed, Feb 25, 2026 at 02:00:57AM +0000, cui via GitGitGadget wrote:

> if i == -1, url[i] will be UB.
> [...]
>  	display_state->url_len = strlen(display_state->url);
> -	for (i = display_state->url_len - 1; display_state->url[i] == '/' && 0 <= i; i--)
> +	for (i = display_state->url_len - 1; 0 <= i && display_state->url[i] == '/'; i--)
>  		;
>  	display_state->url_len = i + 1;
>  	if (4 < i && !strncmp(".git", display_state->url + i - 3, 4))

Yeah, the original is obviously nonsense. Probably it is not worth too
much effort to add a test here, but I wondered if this can even be
triggered in practice.

We would hit it when there is no non-slash character in the URL. I'm not
sure it's possible to get this far with that, but it makes sense to me
to write it as you have.

I can't help but think this would be easier to read without an empty
loop body, like:

  for (len = strlen(display_state->url); len > 0; len--) {
	if (display_state->url[len-1] != '/')
		break;
  }

which makes it much more clear we never leave the bounds of the string
(and also works with a size_t, which is a more appropriate type than int
here).

But it may not be worth polishing this bit of code too much (if we did,
I'd also suggest strip_suffix_mem() to drop ".git" rather than all of
those magic numbers. Or even stuffing it in a strbuf and using
strbuf_setlen() and strbuf_strip_suffix().

But anyway, your patch seems like an obvious improvement in the
meantime.

-Peff
