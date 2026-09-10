Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E13F39D1
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055572; cv=none; b=gypVpgV5CWjZ9IidioWiGloOq4FsncbTQ7thaLpASB94igPqLrjbE5js4L+RE0THZ/Tj0B/wxAweCaWAa3VknRUWu3yk0IvAfbOeirPH/1FhWQXB3r7SzOS1Liz1O/2DUZjE4b7Zwv3iSsA5GD8AKWWHdnZinw06GiQJmDmB4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055572; c=relaxed/simple;
	bh=+6UN05A5PRSAJoMVlqnjq/JUjph4xtAKSo7E5YJHKYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6uqmyFXSShmsUoYcnO+XVzpl0ofa+kRvXE3qpzx7zcfB1owwRaIzLZITNG74OFLCovlB43k7rNMZNBBsZCQYzTZIMd32IfZ3ukSdH41lngEGqkmxh/9DEeuDj6PoBoBjz4diOH+hyOvpFB2mr0plPRHBkj1nX4coOuesbhv12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PT1Cd+WX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PT1Cd+WX"
Received: (qmail 31141 invoked by uid 106); 10 Sep 2026 15:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+6UN05A5PRSAJoMVlqnjq/JUjph4xtAKSo7E5YJHKYA=; b=PT1Cd+WXRo1hkH/2TnklR+gCO1UWVTqHcLVXYinbTWsHlXOCL3zQPa9QE1bn2Lnu2Wb1fsCAzVLldAUTvj3nQ94kUKpl1Xu7991zMKvfQ/pE3lQ9xeYx8tVJ09npzNlY3kS243mQxHTu6Ya0FRE3YlfnSEfxFMdZ002VUTvgPwd9569eSeYamTHeCd3bqZ7qZv6YhJw7NxZZTcimrC64V+VP+hEgbPQlZkpfiSaghSjDvaMTAGswjD6G+r4cgXt7uA5NMg+XA8ntxgu9E0u4j8XNfzFWiTMixF2QQUVHRr6yEwFR41YdqQIgdUZpr5c0VbNLIqEhXZ/FZPWbIo3vVQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2026 15:52:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157067 invoked by uid 111); 10 Sep 2026 15:52:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2026 11:52:47 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 10 Sep 2026 11:52:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>, git@vger.kernel.org,
	ben.knoble@gmail.org, gitster@pobox.me
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
Message-ID: <20260910155247.GA251185@coredump.intra.peff.net>
References: <20270829004959.90983-1-ub4nal@mail.ru>
 <20260910085353.109373-1-ub4nal@mail.ru>
 <20260910085353.109373-3-ub4nal@mail.ru>
 <xmqqzexpf78k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzexpf78k.fsf@gitster.g>

On Thu, Sep 10, 2026 at 08:36:59AM -0700, Junio C Hamano wrote:

> > @@ -109,8 +117,21 @@ static void vadvise(const char *advice,
> >  	strbuf_vaddf(&buf, advice, params);
> >  
> >  	if (setting && setting->level == ADVICE_LEVEL_NONE) {
> > +		const char *scope = "";
> > +		switch (setting->scope_hint) {
> > +		case CONFIG_SCOPE_LOCAL:
> > +		case CONFIG_SCOPE_UNKNOWN:
> > +			break;
> > +		case CONFIG_SCOPE_GLOBAL:
> > +			scope = " --global";
> > +			break;
> > +		case CONFIG_SCOPE_SYSTEM:
> > +			scope = " --system";
> > +			break;
> > +		}
> 
> make DEVELOPER=YesPlease would die due to
> 
> advice.c: In function 'vadvise':
> advice.c:123:17: error: enumeration value 'CONFIG_SCOPE_WORKTREE' not handled in switch [-Werror=switch]
>   123 |                 switch (setting->scope_hint) {
>       |                 ^~~~~~
> advice.c:123:17: error: enumeration value 'CONFIG_SCOPE_COMMAND' not handled in switch [-Werror=switch]
> advice.c:123:17: error: enumeration value 'CONFIG_SCOPE_SUBMODULE' not handled in switch [-Werror=switch]
> 
> We probably should have
> 
> 		default:
> 			BUG("advice settings at wrong config scope");
> 
> or something there.

It is funny that we would handle LOCAL here (which we do not expect
anybody to pass) but would BUG() on other stuff like WORKTREE (which we
also would not expect).

So if we are going to do a switch statement, then I'd expect:

  switch (setting->scope_hint) {
  case CONFIG_SCOPE_GLOBAL:
	scope = " --global";
	break;
  case CONFIG_SCOPE_SYSTEM:
	scope = " --system";
	break;
  default:
	/*
	 * Scope is local or otherwise unsupported; just recommend
	 * the usual unadorned config command.
         */
	break;
  }

I guess maybe that would surprise somebody who tried to add
CONFIG_SCOPE_WORKTREE support, and they'd rather see a BUG(). I dunno.

I was hoping we could avoid enumerating things at all here, but using
config_scope_name() did involve a bit more string construction (and a
hidden assumption that each scope name has a matching "--foo" option).

I'm really not sure why anybody would use those other flags, though (or
even --system, for that matter). After reading the thread again, I get
why we want "--global" for advice that only affects new repository
creation (like defaultBranchName), since otherwise it could never have
any effect. But why would you ever want --system?

I feel like we are maybe leading poor Vsevolod in circles, though. At
some point there are diminishing returns for polishing this.

-Peff
