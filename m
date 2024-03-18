Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643724A12
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749855; cv=none; b=CgNLs6AtAsHgcKjVWCFxKm2Ig5u5mbQD4h77Tb7dqoOn9BoSXk1aKCglCZKhFwlRRmru9aH9Jl/TSxvUHFeOIagTUBIjpzZoKmYqoflZqo9UXZLTSMS6TcylLBlkSbjg1vHo4i4zljophfGPFSV0Fe0Qo59AcJIeKEAGtzN4K/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749855; c=relaxed/simple;
	bh=FOamS9fGJDBdoaBOfu2M0pZDnCZMBQ6Z5jORVA2xVwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRGxB2e7KxzGLlXqPdkpqWE6bB/H6Ge1eqo3dbZ9sOotrl7uZrMUmR4M1cF5e2u2hQ/3mULhQg+jUHsd72HO9hBG/fG4ENNv0nhEY3UXr23rQwFNOrIbeiXedQxBj0vEc46ZZswkR83Uq04fpfBY60l9PAm1UmB3NyZmJBCpmaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8677 invoked by uid 109); 18 Mar 2024 08:17:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Mar 2024 08:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26510 invoked by uid 111); 18 Mar 2024 08:17:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Mar 2024 04:17:27 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Mar 2024 04:17:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ignacio Encinas <ignacio@iencinas.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] config: learn the "hostname:" includeIf condition
Message-ID: <20240318081722.GA602575@coredump.intra.peff.net>
References: <20240307205006.467443-1-ignacio@iencinas.com>
 <20240309181828.45496-1-ignacio@iencinas.com>
 <20240309181828.45496-2-ignacio@iencinas.com>
 <20240316065737.GA544929@coredump.intra.peff.net>
 <xmqqo7bem7o8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7bem7o8.fsf@gitster.g>

On Sat, Mar 16, 2024 at 10:02:31AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Do we need to define "hostname" in more detail here? Specifically, I'm
> > wondering whether the result will be a FQDN or not (i.e., the output of
> > "hostname" vs "hostname -f"). Looking at the code I think it will just
> > be the short name returned. That's probably OK, but it may be worth
> > documenting.
> 
> That was my first reaction but there are places where "hostname"
> already gives a name that is not "short" at all, without being
> invoked with "-f".

Thanks, that was the vague buzzing in the back of my head that led to
my first comment. It has been a while since I've dealt with this, but I
think in some circles it is a holy war akin to tabs vs spaces. A quick
search shows I am not alone:

  https://serverfault.com/questions/331936/setting-the-hostname-fqdn-or-short-name

So I think we probably need to say something like:

  Depending on how your system is configured, the hostname used for
  matching may be short (e.g., "myhost") or a fully qualified domain
  name ("myhost.example.com").

> I think the most honest answer we can give in the documentation is
> that we use what gethostname() [*] gives.

That is honest, but I wonder if it is very useful to most users, as they
cannot easily see what it returns. It's tempting to give an extra note
like this tacked on to what I said above:

  You can run the hostname(1) tool to see which hostname your system
  uses.

But I'm not sure that it is available everywhere (especially Windows).
I guess we could provide "git config --show-hostname-for-includes" or
something, but that feels like overkill.

Maybe just the "Depending..." note is enough, and people who are
interested in hostname conditionals hopefully know enough to dig further
on their system. What I think we want to avoid is saying nothing, and
then somebody tries "foo.example.com", finds that it doesn't work, and
gets confused with no hints about why.

I guess yet another alternative is to try to qualify the name ourselves
using getaddrinfo(), either unconditionally or if the hostname doesn't
contain a ".". That may involve a DNS lookup, though (if your hostname
isn't in /etc/hosts).

-Peff
