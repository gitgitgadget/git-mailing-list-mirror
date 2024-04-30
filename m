Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7C612C476
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474379; cv=none; b=YB5TABxpNILutYdYcQWuFeqxcYFcz4n6e+AdNNOcIHxNu/R0k9bOKQta7QWDJSOKxmgnFq6zAbV4KVnEJUWq4MFrT+fzw0POvUV8MqQhSmwFQs5h1HiN1pY/cTmvkTwhSiJxnL4/R0LBPzN2Hyd4Lrf63zl+u8rOq9f8eS6Y/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474379; c=relaxed/simple;
	bh=zRZXfPolrBRvEVV1DTFczuga54rwkY3cj10l3cXF4eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qpo88/idqCQLoRFHOOv44VuC/slH0JabiZGSNSQGkBa9WBWsUg9qPi/dmHvMNoCSw9+72OiEWe3Eo7sr4DWYGhbiModev6JmLEs3Jz79mPjRfd/TAPRlIPY06uh/Ij+cmRgRQ32u3dQg9LGtvT4TTVzf87BVUazJsxaWDkM9p4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3790 invoked by uid 109); 30 Apr 2024 10:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5859 invoked by uid 111); 30 Apr 2024 10:52:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:52:57 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:52:56 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
Message-ID: <20240430105256.GH1279403@coredump.intra.peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
 <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com>
 <xmqqfrv4ug3l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqfrv4ug3l.fsf@gitster.g>

On Mon, Apr 29, 2024 at 12:24:46PM -0700, Junio C Hamano wrote:

> Rubén Justo <rjusto@gmail.com> writes:
> 
> > diff --git a/add-patch.c b/add-patch.c
> > index 0997d4af73..fc0eed4fd4 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -293,10 +293,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
> >  	va_list args;
> >  
> >  	va_start(args, fmt);
> > -	fputs(s->s.error_color, stderr);
> > -	vfprintf(stderr, fmt, args);
> > -	fputs(s->s.reset_color, stderr);
> > -	fputc('\n', stderr);
> > +	fputs(s->s.error_color, stdout);
> > +	vprintf(fmt, args);
> > +	puts(s->s.reset_color);
> 
> I like the attention of the detail here ;-).

Indeed. I had to read this several times to wonder why it was not a
mistake to leave the first fputs() but use vprintf() and puts() for the
other two (for those just reading, the answer is that puts() prints an
extra newline, so we can only use it at the end). Which IMHO really just
points to how inconsistent the stdio interfaces are, but there is
nothing we can do about that. ;)

I am tempted to suggest that it borders on too-clever, and writing out
"stdout" everywhere with vfprintf() and fputs() would be more obvious.
But in a little self-contained function like this I don't know that it
matters much.

-Peff
