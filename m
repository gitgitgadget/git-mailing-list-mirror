Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031BF22A1D4
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964916; cv=none; b=gMcK6QJibPZWea/UVNPyXrTa+VDuWWcTdScqzhhxjrSUoMBxU1r97b2ifnk8h3JRqjF6ruU5eVpZD4cjz7o3jbtMy4B1kuDREKHQnT4BE1068aJSONxH/IZ4hZuZXKTTxu+9q2VVV+L4i4oWi3yoZWHGsP74DerRsoYLXUHh/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964916; c=relaxed/simple;
	bh=ZkGw8ccRgsIhUNaxJ8aqbOFSGPm3pKjgTkgA71YGHS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLbOTQ0FXdzvsIhThYUaopjfxUsM9w4iQzRvTZqXoxRMm4r+Vyy/RSepx3u8fculu8XZ9rLNIiYQfBoU+xc/kttC4WBdO9hoUuVMZ7ezZyYjZSoUN8APJCETq2a8eznrU2VFZb+6q9Q7ogw2uv0kuonEXSLP1bKj+J3H8lgCRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DXCmsoPE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DXCmsoPE"
Received: (qmail 84161 invoked by uid 106); 9 Jun 2026 00:28:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZkGw8ccRgsIhUNaxJ8aqbOFSGPm3pKjgTkgA71YGHS0=; b=DXCmsoPE2RHRkSE0Ad/o/pgul9yJaRS2JQMeZ3K2PhPejv/T8GyYO51vDrnqnpRhstrYiC9F7E0eEdXlcpHDdNtawb60FcZG6uz/8WvMZkxsRCBeb+hv0Tzmx+QjcZwQCYV3XHApd2E43dp6luuEPTD4r+dnWkfGHgs/+eaGU38ItPYkuRNk4J8c9idP8poSgX8c4vNdXh82c7pPo4sYfmk1XyK+4ylEunkD9mJTTIDmIxN+lZg/av5fsvGzy7Zc9yn4cpS7d/jHZvtSvaS15Onl2HCcVF0miRm+PPrqo6I2qNM66zBCfV5i81RHQdq+97SkW9q9SgbJV7C7epIOaQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Jun 2026 00:28:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 246596 invoked by uid 111); 9 Jun 2026 00:28:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 20:28:36 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 20:28:33 -0400
From: Jeff King <peff@peff.net>
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] transport-helper: fix TSAN race in transfer_debug()
Message-ID: <20260609002833.GE358144@coredump.intra.peff.net>
References: <20260602201309.38434-2-pushkarkumarsingh1970@gmail.com>
 <20260604132327.277693-3-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260604132327.277693-3-pushkarkumarsingh1970@gmail.com>

On Thu, Jun 04, 2026 at 01:23:29PM +0000, Pushkar Singh wrote:

> Currently, transfer_debug() lazily initializes a static variable based
> on GIT_TRANSLOOP_DEBUG. Since the function may be called from multiple
> worker threads, this initialization is racy and is therefore suppressed
> in .tsan-suppressions.
> 
> Initialize the variable in bidirectional_transfer_loop() before any
> worker threads or processes are created. This patch removes the race and
> allows dropping the corresponding TSAN suppression.

OK. I was surprised that this code would use threads at all, but I guess
it all comes from 419f37db4d (Add bidirectional_transfer_loop(),
2010-10-12).

It feels like this could probably be implemented without threads by
using poll(), but that's out of scope for this patch. (I also thought
that run-command's pump_io() might help, but I think it only pumps
to/from in-memory buffers, not between descriptors).

> Changes since v1:
> - Treat negative values as disabled by using transfer_debug_enabled <= 0

I saw Junio's comment on v1, but I wonder if quietly ignoring negative
values is correct. Isn't it a BUG() if the value is negative when we get
here? It means we're ignoring the value of $GIT_TRANSLOOP_DEBUG, which
might have actually been "1".

(Yet another aside: this really ought to use git_env_bool, though that
is a user-facing change).

>  static void transfer_debug(const char *fmt, ...)
> [...]
> -	if (debug_enabled < 0)
> -		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
> -	if (!debug_enabled)
> +	if (transfer_debug_enabled <= 0)
>  		return;

So I feel like this ought to be:

  if (transfer_debug_enabled < 0)
	BUG("somebody forgot to check GIT_TRANSLOOP_DEBUG!");
  if (!transfer_debug_enabled)
	return;

> @@ -1648,6 +1640,9 @@ int bidirectional_transfer_loop(int input, int output)
>  {
>  	struct bidirectional_transfer_state state;
>  
> +	if (transfer_debug_enabled < 0)
> +		transfer_debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
> +

And then we're pretty confident that the BUG() does not trigger because
all of the users of the flag will run through this function.

For the same reason, we can be pretty confident that your existing code
would be fine in practice, too, of course. ;) But if we do hit this
case, I think a BUG() is the right thing.

-Peff
