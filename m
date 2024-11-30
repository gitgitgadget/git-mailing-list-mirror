Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76F1E884
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732984693; cv=none; b=rTZpCe+/ZgmOB5WhxWlrGHtVsXrxyZku2LUtfRCLNvtZN1WXUoG32OZEH0ef/5SiFrpyRJjS1pBscug4Q4E2LkwnCNF7irLOMHTbulV8d9YfpaKmJCnuRjSZzySSic/cBWXGBCjQ53Ngh5cR8wqIABtp6SX/8kBDtIcbwRX1Nro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732984693; c=relaxed/simple;
	bh=LlIS7cD/txZZg0ZKp0d6GwQTkodVsbwyZ9K4EMoRVJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPubmzXRycHMj7pk/hI+fv+bpMqXpz0FTUZUkV3a6a3mW5mdoAbS6M2Dyn2IXukFXhL69fxHjR6IXwbs1J4AKd2cqAOR52XVPlnKN68c8mwT6mW5BZX+rDJVGkY5LWooTOx0bu22d+GIOfC4WsjZv9tOtdyEQL5qsypX/x2x9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fSNX5AkG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fSNX5AkG"
Received: (qmail 21728 invoked by uid 109); 30 Nov 2024 16:38:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LlIS7cD/txZZg0ZKp0d6GwQTkodVsbwyZ9K4EMoRVJk=; b=fSNX5AkGEg8Sz2KlqKf6Tn/NrkdaUsicCiVy7dWej+UTmro835iEphDcaK4w9HYPTSLufzD58KqHRn8vG+BUkqOJ8tlozfz9SkcPzT2LQ+hT8+gTZMGQpTcd/V7d5/gNJGDYnb9NZUs3LejH7/hnAgXLm4ckh0d+fluuFMQECUtuAPqLNJy87FrGe3sRXCQtUzUsLY4giqCQCyddvh+lB4eag8pgLWHXfWIQ5R5tuaFM8qSmSK4HWMQlW6NqjUXsNs+YctUEMb5Uu668iHOl31ZvbX2qRLeRkxz3BidOOQzJCIpE8MqPuSBasS03SQocvd7KRCtYI06/+JusfM5wTg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Nov 2024 16:38:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2112 invoked by uid 111); 30 Nov 2024 16:38:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Nov 2024 11:38:01 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 30 Nov 2024 11:38:01 -0500
From: Jeff King <peff@peff.net>
To: Dmitriy Panteleyev <dpantel@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] commit fails with 'bus error' when working directory is on
 an NFS share
Message-ID: <20241130163801.GA110697@coredump.intra.peff.net>
References: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ-DG_DpNVmn1e=8hBX4YbEhzgX4xxn7AVBQnhKJOvHX4hx7kA@mail.gmail.com>

On Fri, Nov 29, 2024 at 09:58:51PM -0700, Dmitriy Panteleyev wrote:

> I've recently upgraded my (Linux Mint) distribution version, which
> came with git v2.43.0 and I noticed that I can no longer `commit` on
> any working directory which resides on an NFS share mount.
> 
> Git reports "Bus error (core dumped)" and dmesg shows multiple "NFS:
> server error: fileid changed. fsid 0:68: expected fileid
> 0xf8e3d8e80230ddb5, got 0xeeb48230d99ed0d4" messages.
> 
> This does not happen if I move the working directory off the NFS share.

I can't reproduce any problems here on a test NFS mount. But since the
old version works here:

> I attempted to upgrade git to v2.47.1, with the same result.
> 
> I then downgraded git to v2.34.1 (the version for the previous
> distribution release) and the error has resolved.

Can you try bisecting between v2.34.1 and v2.43.0 to see which commit
introduces the problem for you?

-Peff
