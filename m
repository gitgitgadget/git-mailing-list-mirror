Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CA18C909
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370122; cv=none; b=lNiPh3dLh7VWD/dJu58vXqSgW1oPdfiwb/NmorMzf//8lg7q+91TPoX3+v1Z0CDjxwLW1kfB7uX4mD9ebH9gfIccWXs3p0GzctdUxN3eg20hNZvoNtnT8UjYjgX7zJu3r2o2kZ4J1lEcXX8B5IvEFhnMX9yu6Rs2mWNZ1/QvrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370122; c=relaxed/simple;
	bh=IFr8neKC+m7ZZRETbMjrkIH/gszRI8R/CDdMJH5V1K4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjgpj6gR9pMJv/Rs75cROy3P3ukYvcXkYDcdeP6INQCR08rhqwifY//hSDgEWLfR3ChGv9tf6bReDpILKupj6FTj4dGzlwY2Wy1ZcDYOGhaZRccEEocqmgUcKsnY6aDkDWWwzNfKE1m6fXZLeVAI2JIZh7A/Lvn3QOwVR72th3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32567 invoked by uid 109); 30 Jul 2024 20:08:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jul 2024 20:08:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13957 invoked by uid 111); 30 Jul 2024 20:08:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2024 16:08:41 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jul 2024 16:08:38 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/3] safe.directory: normalize the configured path
Message-ID: <20240730200838.GA567852@coredump.intra.peff.net>
References: <20240723021900.388020-1-gitster@pobox.com>
 <20240720220915.2933266-1-gitster@pobox.com>
 <20240730011004.4030246-1-gitster@pobox.com>
 <20240730011004.4030246-3-gitster@pobox.com>
 <20240730073119.GA562212@coredump.intra.peff.net>
 <xmqq4j86g948.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4j86g948.fsf@gitster.g>

On Tue, Jul 30, 2024 at 09:03:35AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +			if (!is_absolute_path(check) && strcmp(check, ".")) {
> >> +				warning(_("safe.directory '%s' not absolute"),
> >> +					check);
> >> +				goto next;
> >> +			}
> >
> > This is_absolute_path() check is redundant, isn't it? If we are checking
> > for a literal ".", then we know the path must be non-absolute.
> 
> What I meant was "If it is not absolute, that is an error, but if
> the thing is a dot, that is allowed as an exception".
> 
> Is the lack of "!" confusing, I wonder?   We could rewrite it to
> make it more explicit:

Oh, right, I totally misread it. You'd think after 25+ years of writing
C that I would be able to get the strcmp() return value right in my
head... :)

So yeah, it is doing the right thing.

> 	if (is_absolute_path(check) || !strcmp(check, ".")) {
> 		; /* OK */
> 	} else {
> 		warning(_("not absolute %s"), check);
> 		goto next;
> 	}

Hmm. Yeah, that probably would have softened my confusion, but it's also
kind of hard to read. I think what you wrote originally is just fine,
and I just mis-read it.

> My earlier draft for v3 had the check for dot a lot earlier in the
> function, i.e.
> 
> 	-	} else if (!strcmp(value, "*")) {
> 	+	} else if (!strcmp(value, "*") || !strcmp(value, ".")) {
> 			data->is_safe = 1;
> 
> and this part said "If not absolute, that is an error" without
> anything about dot.
> 
> But then I changed my mind and made it unsafe to do this:
> 
> 	cd .git/refs && git -c safe.directory=. foo
> 
> as safe.directory=. means "A repository at the current directory of
> the process is allowed" and the repository in this case is not at "."
> but at "..", meaning "." is a lot stricter than "*".

I could see arguments in either direction, and I don't have a strong
opinion between them.

-Peff
