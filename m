Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F345039
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959112; cv=none; b=mgDwlJp1DZXjE5HEXmxCT/VuFE/fn3tBmh44vTQzCvbZXPEOBOVqq+iratVFicwecuoeH1n+/668JeOKCwVdbCG40vXfvFMnuXSO6m8ikQpH+1LkC/gh458/PfJ1WXpJJA/rj46On2XmdTXHEzRLC8h5MjTrPDWpNiYrSCVbMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959112; c=relaxed/simple;
	bh=BLXt5QJXtnZYcH474xFpQP0+OQK4/1lI5YQWehuoeYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwKVXSqzZlNvK//Qj67b8+hPus9RZKso1pNdLGDdV4xMfPPTB0wzZPJbi5MmbiScUJyhaVRIOIYvgkS7Sxvmp+lty11WZB/7Smiq7lFpjee5lyy0xnbeTlapgmU/VxF5mJTnTsGAj1hO2OWRYKL4PeIA/ZZGBPdjQ7MWhR6WKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bP+whkEo; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bP+whkEo"
Received: (qmail 83599 invoked by uid 106); 8 Jun 2026 22:51:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BLXt5QJXtnZYcH474xFpQP0+OQK4/1lI5YQWehuoeYs=; b=bP+whkEooWNOYnc3A3tQeLJgYAj0197Ij8oeyc9Sa5wkbwT0R9JeaVikQRnky2cHDloqADG0PdluIEzG38eEQDGXh/vf9vJ6J+o4MyGISOiK4KuoETCJLy0WtYSjZd3lcddRf6kT4UE9YVLOvSq/MVervY5oPanmFd3CsnILuTLEVXw4VLplPlDq9oQus1uCbS7m0Cuj1GUTy2JPT6dKO5D4SgCV0BuukUmYk9yORIsFWa3Cb4EeeaJkU8b6Asem0woCocsanN962z/k1a16rawg1B7Pr1mLekpxU6zOYlempadUr7ZI2t+/ZMXFIXCjEBb1JULWr/BQPtHfQfJ1xA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Jun 2026 22:51:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 244135 invoked by uid 111); 8 Jun 2026 22:51:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Jun 2026 18:51:52 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Jun 2026 18:51:49 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/3] config: allow disabling config includes
Message-ID: <20260608225149.GB340696@coredump.intra.peff.net>
References: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.2139.git.1780927027.gitgitgadget@gmail.com>

On Mon, Jun 08, 2026 at 01:57:03PM +0000, Derrick Stolee via GitGitGadget wrote:

> This series introduces a new way to ignore config include directives via two
> mechanisms:
> 
>  * GIT_CONFIG_INCLUDES=0 in the environment.
>  * git --no-includes ... in the command line.
> 
> My motivation is from a tricky situation where users want to do the risky
> thing and include a repo-tracked file for sharing aliases and other
> recommended config. They are then struggling in a later build step that is
> running Git commands (under a tool we don't control and can't change) that
> then cause filesystem accesses outside of the build system's sandbox.

I'm not opposed to global control of includes, but this is just one way
in which config can escape the sandbox. They can always point to files
(e.g., core.attributesFile) or even commands that totally leave the
sandbox (e.g., ext diff or textconv commands). Fundamentally git config
is equivalent to arbitrary code execution, so pointing an include at a
repo-tracked file carries the risk of confusion both malicious and
accidental.

So I dunno. From the described motivation, this feels like a band-aid
that fixes only one narrow instance of a greater problem.

The notion of enabling/disabling includes per-command is itself a
flexible building block. So it's possible that it has other uses in
general. But it's also a fairly broad hammer that covers more than your
use case. If you're planning to use "git --no-includes" in some script,
then it breaks the config of anybody who uses includes in their
user-level ~/.gitconfig file.

So you may need some more directed limiting.

> One thing I do worry about is whether or not this would cause a significant
> break in behavior, or if this is a relatively safe thing to allow.

Yeah. Consider something like:

  $ cat ~/.gitconfig
  [user]
  name = My Name
  email = me@personal.example.com
  [includeIf "gitdir:/path/to/work/stuff"]
  path = .gitconfig-work

  $ cat ~/.gitconfig-work
  [user]
  email = me@work.example.com

Using "git --no-include" will silently use the wrong user.email value.
That's OK if the user is asking for it, but if you are planning to
sprinkle "--no-include" inside scripts, that's likely to cause
confusion.

-Peff
