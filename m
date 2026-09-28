Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF3022576E
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568315; cv=none; b=KIFK4zdeJgvby+SlS4Px6uohDjVaabJgUps7xOcRJtW42Q2O+kuexA+rSD43R/EC2+PQztz20/z0z+jQG3V1EekLL7r8zwcHBYuhV0jKvUU5kXgHjqLgPi9GX3bkeg5rhJzE0qCk6J1FMBJhpHNAKNvvpajfq7uNfV5qrPQxZNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568315; c=relaxed/simple;
	bh=wHm5iSl8hDOXjXtyH/AWzRm8sAArugyGeHQxJW3WDMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0conzPcjBVS42N0B8dKbWIKpWNl1yDvdWD3ZOMF/58nCCy2Ro7T9jvNEQNhDi6Pl4JwK+nYnJ7x4MNx8uU2VAJpMWGuqV4QTHH5FVeCjp7h5Fg5hg66xkRF8cIwy4SQ41WTfRBQGOAsaeDl+OQdA3OWqHs6phOw7nZvUp7g4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EE4bXtXt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EE4bXtXt"
Received: (qmail 63863 invoked by uid 106); 28 Sep 2026 04:05:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=wHm5iSl8hDOXjXtyH/AWzRm8sAArugyGeHQxJW3WDMc=; b=EE4bXtXtyXej0ZFtSjINZ0Pwaq4z3Im0ZNNoAKrZi+EjZl8rCknanAy3k0wCC+vNt2ia9+mxvdF3lDvBsC2qGeZkrkIIp9/2/Y9dQFAbIt/0SrLvYtrdarnUauFoVq+rvqN647o94dTasaQNv17Y9sW493744uik0nTJY6bESBdGUlTnBy2uT36Lmd8X3hsJq1Jab87VXi+uXBb53+MXoV8SdLKmNmIP86d6N3fv9YK2TftIkHkIVUsAeIgSKp4nDvglI3Q01XnKUrpDmEIVsjvZAijTffLH8l4iKWsreLxdqxJgN+CjiF9UkYAU0L9Q3bER/OLS+0E61cLmMWGI+A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Sep 2026 04:05:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 238127 invoked by uid 111); 28 Sep 2026 04:05:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Sep 2026 00:05:11 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 28 Sep 2026 00:05:11 -0400
From: Jeff King <peff@peff.net>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] p5551: fix repeated runs with update-ref --no-deref
Message-ID: <20260928040511.GA498426@coredump.intra.peff.net>
References: <20260926180648.60770-1-jon@jonsimons.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926180648.60770-1-jon@jonsimons.org>

On Sat, Sep 26, 2026 at 02:06:48PM -0400, Jon Simons wrote:

> Update p5551-fetch-rescan.sh to pass `--no-deref` when deleting child
> test refs before each measured `git fetch`.  Otherwise, for repeated
> runs, the second iteration will fail with:
> 
>     fatal: multiple updates for 'refs/remotes/origin/master' (including
>     one via symref 'refs/remotes/origin/HEAD') are not allowed
> 
> Starting with 3f763ddf28 (fetch: set remote/HEAD if it does not exist,
> 2024-11-22), `git fetch` instantiates the HEAD symref.
> 
> The test, introduced in 7893bf1720 (p5551: add a script to test fetch
> pack-dir rescans, 2017-11-20), predates that.

Thanks, the explanation and patch both make sense.

This test could probably benefit from using --setup (which also didn't
exist back when this test was written). But that's nothing new, and well
outside the scope of your patch.

-Peff
