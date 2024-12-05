Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCBE193
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733430410; cv=none; b=eDG+pTpWVuIEMdKsZ58/47ob+Thpm7fs99wQp39CzJBCfhI02aHz2o0QwCS3eF0Wzz6+A9VIYgpirUKp2zRJTP4QL+fO0++3KkD882HhWppIztLFH82TleCVzrfvo7O/KPSis2N8v1YlQ7mj78O6J4+dtSGLloHEi5HGOxdeTEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733430410; c=relaxed/simple;
	bh=jAzv/36+QAfdkLLUdCY4Qu+TbOZ4fdHD1A78KmGo/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHJ/gKZ5tnZLr4fyttnk+hcug3/SfH2j3MEe0XZGXSMlsgr0rYPykp34rrUSFWUFTZmwzcGiOofaJWkUuFZXepgggi6XIYQbMD2UzbdtJ6SnHUfnT6Cbgb5fyYlMMcUD/pqOHHO1vl9eox/hnHZbwnY9FJz5OW5SvX8PuYyO1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MjK3TTVk; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MjK3TTVk"
Received: (qmail 32104 invoked by uid 109); 5 Dec 2024 20:26:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jAzv/36+QAfdkLLUdCY4Qu+TbOZ4fdHD1A78KmGo/ks=; b=MjK3TTVkmtTkJLN0v+HPeOUkP1mOIBvWZ9YDEpReNGjxlocYM++ou3p4T+KRqfp505fW8nzEf6ZQuOyu15rvz4qNClC93x0W0DCBUv6gxkwiEsIk6h8qgXnsozsY7J/zTUG5ccgEWsjBVsJ4q57Lh/4lKVxdf7x/kwEC+GDmijcI3rCJXxfN3J+K3UMr05prcgjHUlzrrtgdFbCGuicjYl5enPnVduQeqJ7tieJoa4LuVGHPTCIrL+sTWOgV2r377/7gcIBvJMVMSDj9ofcKUiE9hT6Sp8yJcBAJU+Np5N5rviYoAVjqHpX1fqnSAPBQa1WpVo/cwIjA2ZNT+F3daA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 20:26:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9646 invoked by uid 111); 5 Dec 2024 20:26:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 15:26:47 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 15:26:47 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org, git@jowil.de
Subject: Re: [PATCH 4/4] tag: "git tag" refuses to use HEAD as a tagname
Message-ID: <20241205202647.GE2629822@coredump.intra.peff.net>
References: <20241202070714.3028549-1-gitster@pobox.com>
 <20241202070714.3028549-5-gitster@pobox.com>
 <Z02voaSNYRciv38z@ArchLinux>
 <xmqqy10xft94.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy10xft94.fsf@gitster.g>

On Tue, Dec 03, 2024 at 10:30:15AM +0900, Junio C Hamano wrote:

> shejialuo <shejialuo@gmail.com> writes:
> 
> >>  int check_tag_ref(struct strbuf *sb, const char *name)
> >>  {
> >> -	if (name[0] == '-')
> >> +	if (name[0] == '-' || !strcmp(name, "HEAD"))
> >
> > I am wondering whether we should also update "check_refname_format"
> > function to report "refs/heads/HEAD" and "refs/tags/HEAD" is bad ref
> > name.
> 
> Check the list archive for the past few days; it was considered and
> rejected.

Agreed, but maybe that is an indication we should discuss that
alternative in the commit message. (I had looked for similar
justification in the existing "branch" restriction, but couldn't find
it, to the point that I wondered if I had hallucinated our reasoning
back then).

-Peff
