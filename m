Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5B173
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759987476; cv=none; b=BBrNEz6QpNfT3DOHDlkJP8wlYZpAJKboYiPyDSQ6Dm4rA7dULdm5jDWpahL4h9+6/qPCk/NlPCwRgo8g6XXWkkh14X3oBKpcqzPqyJDpwXzdidx9EKCugKp+4PV/VTZ/NHbzF4AqUZ3VrRBGnjjIl3AiaiLWVGROrOniAOmVg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759987476; c=relaxed/simple;
	bh=/1a8uRG4nayT1G5oihQ+l9Y7fm4Ku3WlqKMxr1V1j/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9UxNeQTRVH2Qrv3yBm1kv5na42s6XCQeX8bvrnQ8x6t7Nuc9lcfAdY1VcJh8nQyIre9bwimcE0goi8ERy3yuj4Tgj1c6/dGnzgO59E6OnN/Q8bgeUQjyfmdSVGTGRXoAwQM2apsV6qR9CUsa8oaLab0j5i3Fy56RLpa5eS4Rfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=en+V3tZp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="en+V3tZp"
Received: (qmail 174422 invoked by uid 109); 9 Oct 2025 05:24:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/1a8uRG4nayT1G5oihQ+l9Y7fm4Ku3WlqKMxr1V1j/o=; b=en+V3tZpfOnNoHEw82yjjcux134pmOfkAyBH5KIoDK6UrpUuiktAa6jE6OfBhEu5ZUOOy9KP6bPzgQcw/+FB9vF0jql4ntWGxieWWkRa8i0dwtuiNheSNVyhxNbP5/8+dgSOLFPaHePrgFBdSATiENR1lUE49vsjjJgTFyeiVNMxlWU5vwoJZl6DF+Z7AC6fU31dFapbE2eiBXqcZaeZTaeowXZXYcCWhuafwxotjrGn/zZr+CsEqf+aIp1wfv/vbbW3DnEs3rTnag6W+YOQiOolUxvTpdjeuOkoW7hSvFn/+3V2/CNu0B6DtHTut06ZwQ4r6DU/PdHcpJyksOLa8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Oct 2025 05:24:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 265396 invoked by uid 111); 9 Oct 2025 05:24:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Oct 2025 01:24:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Oct 2025 01:24:22 -0400
From: Jeff King <peff@peff.net>
To: Michael Lohmann <git@lohmann.sh>
Cc: git@vger.kernel.org
Subject: Re: [RCF] Secure git against involuntary arb. code execution without
 feature loss
Message-ID: <20251009052422.GA1614343@coredump.intra.peff.net>
References: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72F10412-8B0F-4F66-8674-FE194D016DF9@lohmann.sh>

On Wed, Oct 08, 2025 at 11:02:03PM +0200, Michael Lohmann wrote:

> Hooks, as well as certain config (e.g. `core.pager`) can do automatic
> code execution for you. In general, this is a great feature and should
> be kept without the user noticing any changes.
> 
> BUT if you download a random folder which to you unknowingly is a repo
> and either you or e.g. your command line prompt automatically executes a
> simple `git status`, it feels bad if this results in arbitrary code
> execution (ACE), e.g.:

We've discussed this a few times over the years. The most recent one I
can remember is:

  https://lore.kernel.org/git/ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net/

I think there are two somewhat orthogonal issues to consider:

  1. How does Git behave differently in an "unsafe" context? In the
     thread above, I propose that it should skip loading config from the
     repo-level $GIT_DIR/config file, and turn off hooks inside the
     repo. Elsewhere, others have proposed finer-grained control (like
     specific config options). IMHO the most important thing here is
     maintainability, and having a scheme where we do not accidentally
     add code that lets an untrusted repository do bad things.

  2. How does the user tell Git which repos are safe or unsafe? You've
     got a scheme here for marking user-created repositories with a
     secret token. I think that could work, but there are other simpler
     methods. E.g., we could pass down information through the
     environment (like we do already for security features like
     GIT_ALLOW_PROTOCOL), or mark a list of safe directories in user- or
     system-level config (like we have already with safe.directories).
     It's perhaps even reasonable to have multiple such mechanisms, as
     they have different tradeoffs in convenience and security.

So in some sense I think talking about this token scheme and Git 3.0
compatibility is putting the cart before the horse. We need (1) first.
And then once we have it, I think the simplest thing is not turning it
on all the time, but letting commands opt into it through command-line
options and environment variables. So you could imagine git-prompt
running "git --assume-unsafe" or setting "GIT_ASSUME_UNSAFE=1" in the
environment. People who want to be more paranoid can set that variable
for their normal commands to opt into greater security (at the cost of
convenience).

Then once we have some practical experience with the system, we can
consider whether we should flip the default. And in the meantime we can
experiment with idea like your token scheme.

-Peff
