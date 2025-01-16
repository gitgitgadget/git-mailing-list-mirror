Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0062192598
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024375; cv=none; b=Pov/wfsRQ2UuqF3YoSS0gos8BUa7DJqP21kAY1tWdtmcNSL3YpT1pTmzZZeTn/bINTCk6r18sUv1TvO11TC9ljEIMyPIiM1AQtfxvj1YpG/aakx/2O91xPzBXVwBFtLYUbCKtV93twpr/wHmgIrHZpbFgFOG6Zyx5tMTpmshlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024375; c=relaxed/simple;
	bh=0RbaPKSa52m+3xSs+EPIK3PmajAfHz3CFyJQMC7S+EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS8odTXgxy5ELg2IxWGokEAJDNTbXFmJ/Nz4zN6A76EQDXByCz2hcwoBn8hd1lID59cyNP6Fp02Cg1nOvRUWqlZgoMBVShDbkwx46LpP+EsJXJWvp+0dOttLaMYIAeCCLy96ATBhtgZ87IeLmsAUVa63sTA9hOO8Pk0hQ8Zf8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NmFK8UXe; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NmFK8UXe"
Received: (qmail 12355 invoked by uid 109); 16 Jan 2025 10:46:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0RbaPKSa52m+3xSs+EPIK3PmajAfHz3CFyJQMC7S+EY=; b=NmFK8UXe34iGCi60z83ARMVTm/jFDPb2+jK2u0VSNHmFveqA7QCZDPfcA3yCELZ0rzBOG1edtSTEtnR2+HQVS9f25AznxbEkUQCQD0TMdjn8J32iaBlq8Dtease2NjZkFkkbwPLLMt6M+LvTNtpKBDr22ZstyuQ0AHMLJnZI4NYqoSTXgD0HFfJ/Z63oxTnyxcVI8Mi3Zilgac5Uc+mZYhC5h5V+Cx5vNnfHEcPV5LorvUOVQIlMxp0/7pzeACW+xabCDN5Kq8L2VA2OnmeVvRQDc9gdpuCYIKplDEmACAqqSdPcHyR/LTi/eq/3ORqSemfjU4Sj9st5H8bZjawMeg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:46:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24218 invoked by uid 111); 16 Jan 2025 10:46:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:46:17 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:46:12 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Send help text from "git cmd -h" to stdout
Message-ID: <20250116104612.GE773990@coredump.intra.peff.net>
References: <20250116012524.1557441-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116012524.1557441-1-gitster@pobox.com>

On Wed, Jan 15, 2025 at 05:25:17PM -0800, Junio C Hamano wrote:

> Jonas Konrad noticed[*] that "git branch -h" started showing the help
> text to the standard error stream.  It turns out that we are fairly
> inconsistent in our implementation of "git cmd -h".  The users of
> parse-options API will get "If -h is the only option on the command
> line, give the help text to the standard output" for free, but some
> commands manually check for the condition and then call the
> usage_with_options() function, which gives the identical help text
> to the standard error stream.  And "git branch -h" Jonas noticed was
> one of them.
> 
> Older commands written before parse-options API became dominant show
> the help text by calling the usage() function, which is meant to be
> used when they fail to parse their command line arguments, which has
> the same problem.  An explicit request for help text "git cmd -h"
> should be fulfilled by showing the help on the standard output.
> 
> This series teachs "git $cmd -h" to send its help text to the
> standard output stream consistently for built-in commands.

I had a small complaint in patch 4, but otherwise this looks good to me.

If we want to switch the exit code for this case from 129 to 0, I think
we could easily do so on top (it would need modifications in three
places, but now that you've untangled all of the individual builtins,
that would get all of them).

I guess there may be non-builtins that would need to be handled
individually, though. We don't have too many of them these days, but
they are not covered by t0012.

-Peff
