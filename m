Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FCD7F
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053390; cv=none; b=blBuzlwtGJsbyCsKsYbtJ+F4KnAj7APS0KoYw6F+t6zjRy4tTB77bUtdmu9K9JnaKwoFy0RF6q6v1tueFTwDS0XPghavwcqTJ6b6wTbnE1ug4cb7QJmA1x2sdlq1DlB0FTawcDHzBSwmjUmskKDEmkdPGP8HvY6m4mTaHkxiKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053390; c=relaxed/simple;
	bh=8wwHSyy/muS5Gfre3JHGROzvUfzaOwV/EYeijNY/5cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueC8y/cHGDQHY9cX1JmIJvVrIdn2Sw8LUbQzzwNEzlNymwpUiLLDLISu5qGaDyTG2XZ0NQlgwVqj0Z34mQ8+rewkG9u3fa9h7nOnT+98a6jkeHgegcPaVoWaq1r0oj9mUKSuoR/aVZspDx5DVbvKdg7iVVWK3echgRyXp8bWQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16971 invoked by uid 109); 30 May 2024 07:16:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 07:16:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28173 invoked by uid 111); 30 May 2024 07:16:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 03:16:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 03:16:27 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/21] strbuf: fix leak when `appendwholeline()` fails
 with EOF
Message-ID: <20240530071627.GE1949834@coredump.intra.peff.net>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <9dd8709d1b3b350008218133986befdb2ae74bae.1716541556.git.ps@pks.im>
 <20240525044635.GB1895047@coredump.intra.peff.net>
 <ZlQr3tsDTSOGvFUQ@tanuki>
 <20240529091633.GB1098944@coredump.intra.peff.net>
 <ZlcQjvAS-27S-mjw@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlcQjvAS-27S-mjw@tanuki>

On Wed, May 29, 2024 at 01:25:02PM +0200, Patrick Steinhardt wrote:

> > If we really cared, though, I think you could check sb->alloc before the
> > call to getdelim(), and then we'd know whether the original held an
> > allocation or not (and we could restore its state). That's what other
> > syscall-ish strbuf functions like strbuf_readlink() and strbuf_getcwd()
> > do.
> 
> Ah, I didn't know that we did similar things in other strbuf functions.
> With that precedence I think it's less ugly to do this dance.

Yeah, I probably should have explained that better in my earlier email. ;)

> > I saw only one questionable case. builtin/difftool.c does:
> > 
> >   if (strbuf_getline_nul(&lpath, fp))
> > 	break;
> > 
> > without freeing lpath. But then...it does not free it in the case that
> > we got a value, either! So I think it is leaking either way, and the
> > solution, to strbuf_release(&lpath) outside of the loop, would fix both
> > cases.
> 
> Indeed. We also didn't free `rpath` and `info`. I do have a follow up to
> this series already, so let me add those leak fixes to it.

Great! Thanks (as usual) for being receptive to me piling more things on
your todo list. :)

-Peff
