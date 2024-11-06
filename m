Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901CA1CF2A8
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 02:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859956; cv=none; b=OZYeQFOpb6AFM24kKuzMobHsMLFym4sHPP3sfj3BQzUT9KTsX/+QP+2oPf9lJo29B+Bj5FrQnvQqZiYzkgIcIdbcJiOUit0hiRFm+cgkSzpMGnT4dLaALTHJZDGSCHHXo8ccjC9JNl3BAt5BHFjBopgXuTP0mtDpcZVc8H6aDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859956; c=relaxed/simple;
	bh=R0Z4SynQsfLss/FmD7Gfe+5YycB2xWek4PLbTIy8C2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7teiZPVynq9CTsiHVwP89b+RbclxOZO4ZMjx8aVNC+7f28+lUcZKgwRZx69dURQ3AT/nHwb5gSadfYJqo00+/l1JpD+ezLBX3Dbk66Jb0SUTXhlz48eHYhkU08+b1XjdHQkuhHtW6u3S7QNTOlv8zjGYz3kJmJ1lEEwAT/eImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WKc6ksRs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WKc6ksRs"
Received: (qmail 1537 invoked by uid 109); 6 Nov 2024 02:25:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=R0Z4SynQsfLss/FmD7Gfe+5YycB2xWek4PLbTIy8C2o=; b=WKc6ksRsyQrmx4laH2Pu9Z1XYekZ63MfJNVH/1ckJ7in9Y/s1Xvy13yXDLu6KM0K/3oQK9E5skGfaO3CZ8i1MkRYtatHYYn+Sz9yb6PljvmobRRn7zyP56ICaDxbVB0dgg9ZcP1oB5O9USATXlN44tUoHtTg5b+dCLFD2eart/OhIBiYlJ8ZX3ovkiwHh/Y3C/KUkGizVs9SkUeOT8Hj2Q+Grkvt5w1L34R/pS3zlvgPDgqgMct4G0KHKonPw4ky0DAgQhy1WifKIDvAr2AS1MF06wXFm1BS0i6E7t70eJ0DV2144QWy9x/2RRoPvH4FcGqnRUUM2fesZ2/D7TKaYA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Nov 2024 02:25:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31763 invoked by uid 111); 6 Nov 2024 02:25:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Nov 2024 21:25:53 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 5 Nov 2024 21:25:52 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <20241106022552.GA816908@coredump.intra.peff.net>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikt1qhwt.fsf@gitster.g>

On Tue, Nov 05, 2024 at 05:18:10PM -0800, Junio C Hamano wrote:

> > This raises the question of what can be done to parse ')' in values of
> > the format correctly.  It seems to me like a clean solution would
> > involve a huge refactoring involving a large portion of ref-filter but I
> > maybe wrong.
> 
> Yes, so I wouldn't even call the current behaviour "bug".  The
> language is merely "limited" and the user cannot express certain
> values with it at all.

Agreed. I think we may have discussed this quoting problem before, but
it's not usually a big deal because the set of likely values is quite
limited. Most of them are just keywords or numeric values. I _think_
that the equals/notequals parameters of %(if) are the only ones.

Which isn't to say we shouldn't make things better if we can. Just that
I am not too surprised nobody has run into it before.

> Having said that, I just tried this
> 
>     $ git for-each-ref --format='%28%(refname)%29' refs/heads/master
>     (refs/heads/master)
> 
> So, if there is anything that needs "fixing", wouldn't it be
> documentation?
> 
> If I knew (or easily find out from "git for-each-ref --help") that
> hex escapes %XX can be used, I wouldn't have written any of what I
> said before "Having said that" in this response.

I tried something similar, but I don't think it quite works for the case
in question. Within %(if:equals=<foo>) we do not further expand the
<foo> value (at least from my limited tests). And so something like:

  git for-each-ref --format='%(if:equals=ref-with-%29)%(refname:short)...etc'

would never match "ref-with-(", but only a literal "ref-with-%29".

I am tempted to say the solution is to expand that "equals" value, and
possibly add some less-arcane version of the character (maybe "%)"?).
But it be a break in backwards compatibility if somebody is trying to
match literal %-chars in their "if" block.

Another option: in the rest of the "if" design we tried to keep
arbitrary text outside of the parentheses. So you could imagine a syntax
like:

  %(if:equals)ref-with-)%(foo)%(refname:short)%(then)...%(end)

where %(foo) is some placeholder that separate the two arguments to the
"equals". In sane languages that is a space or a comma, but I'm not sure
that works here. We have %(end) which would otherwise be a syntax error
here, but it feels word. I dunno. The whole language is kind of
hideously verbose. I feel sorry for anybody trying to write non-trivial
formats. :)

-Peff
