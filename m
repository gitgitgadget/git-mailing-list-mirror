Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05B18C00A
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970376; cv=none; b=lIjzCvy3oTsbjr/hk9KlJ2by/+3GvPQbFV2LTF5zXM7KWdtPWa+6l9Wiyik6kA+yISquqfb3kLXPx4s15EJJztYK4a3lazMtg567e5x05PoJL5x79tUy7T+k2wZyAn2rfdlUO37Q1ngRSgtc4AUbFMoZY9EpbSqLMTMS2fKS89Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970376; c=relaxed/simple;
	bh=3eW7fFTp3dIDtY+Eqxqxf4pOXhVX7YGNFoOqwCREX+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juHOUNp1+6jq+cpwde86HP9jDgdM2zDCah8QDauTTuStLQnFP+J2VpPSnrpofu43aLLkypEd5g1KTLJIdYbWwcOHIxNxcoL8oFUC2HwTOeSg6/smyrMVa+gUwg5VDbhnpjNZYswkvAO80lZ9W/ytS+qQfYdhpTg9IcpVkhn8LC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6742 invoked by uid 109); 29 Aug 2024 22:26:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 22:26:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12828 invoked by uid 111); 29 Aug 2024 22:26:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 18:26:14 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 18:26:12 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/terminal: mark parameter of git_terminal_prompt()
 UNUSED
Message-ID: <20240829222612.GA445751@coredump.intra.peff.net>
References: <d8c5e920-aff7-4e4b-af77-0d3193466b57@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8c5e920-aff7-4e4b-af77-0d3193466b57@ramsayjones.plus.com>

On Thu, Aug 29, 2024 at 10:57:50PM +0100, Ramsay Jones wrote:

> The 'seen' branch fails to compile on cygwin (but its fine on Linux), due
> to an unused parameter. I haven't looked too hard at the code (at first
> blush, it seemed to me that it should not even be trying to compile that
> code, but ...), I simply added an UNUSED to fix the build. ;)
> 
> So, this may not be the correct 'fix' for this, but I thought I should
> report it here, since I don't have time to look into this now. sorry! :(

Thanks, this is definitely the right fix. I have to rely on CI for
catching cases outside of what I build locally, and it looks like we
don't trigger this fallback code at all in CI (we hit HAVE_DEV_TTY for
Linux and macOS, and then GIT_WINDOWS_NATIVE for Windows).

Here's a potential commit message for the patch:

  If neither HAVE_DEV_TTY nor GIT_WINDOWS_NATIVE is set, the fallback
  code calls the system getpass(). This unfortunately ignores the "echo"
  boolean parameter, as we have no way to implement that functionality.
  But we still have to keep the unused parameter, since our interface
  has to match the other implementations.

As an aside, I wonder if cygwin could be using either /dev/tty or the
Windows variant. But that's obviously a separate patch, and either way
we'd want to fix this fallback code in the meantime.

I actually kind of wonder if we could get away with assuming that every
non-Windows platform is Unix-y enough to have /dev/tty, and just delete
the fallback code entirely. But that is probably wishful thinking.

-Peff
