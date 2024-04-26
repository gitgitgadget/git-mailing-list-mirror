Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95860BE78
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163017; cv=none; b=lBgZ9krSoOIbIiTuyZ4A4cobAIo3rPl643+/7BmK8VJNWy4c1rbR7usrEXZ6qMKEghylfyYf5oM8zHHnjEC3t0sMIOBNzQ5/3HLcErnqawtYbBoeiwqqqzBy1+1Ztu/q1Th4mVmUyuJGAKKNgOiQa+mXxEabitTjat1STa2F8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163017; c=relaxed/simple;
	bh=6nGtE47i4kX6SnhdRHmZF9nP1MujLfzoC1AQxrIInTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK9tWdwMVNoog/Ipd+DqfkL7QnE7u16iciTCg+ynxQTgx8z6H5+vNSDq+eHq/RgGvWyKw0R7In6TZ0otesxF6oARz0M40wVdbrZziCMhUbAJGHTRI8IJN8ZTj1e6qK/LjTKRMEdDJOs0wOFpWwjQqmpl/mosWqPNonumQgB/9WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13528 invoked by uid 109); 26 Apr 2024 20:23:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Apr 2024 20:23:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3097 invoked by uid 111); 26 Apr 2024 20:23:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Apr 2024 16:23:36 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 26 Apr 2024 16:23:33 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] add-patch: response to unknown command
Message-ID: <20240426202333.GB13703@coredump.intra.peff.net>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <20240425014432.GA1768914@coredump.intra.peff.net>
 <19ff10e9-12be-4a50-9163-1fe71414fd46@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19ff10e9-12be-4a50-9163-1fe71414fd46@gmail.com>

On Thu, Apr 25, 2024 at 05:04:45AM +0200, Rubén Justo wrote:

> > The test_cmp output looks
> > like this:
> > 
> >   -(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command 'W' (use '?' for help)
> >   -(1/1) Stage addition [y,n,q,a,d,e,p,?]?
> >   +(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,d,e,p,?]?
> >   +Unknown command 'W' (use '?' for help)
> > 
> > which makes me suspect a race. Perhaps because the prompt is going to
> > stdout, but the "Unknown command" message goes to stderr?
> 
> I have to read the thread pointed by Eric, but my knee-jerk reaction has
> been to think in something like:
> 
> diff --git a/add-patch.c b/add-patch.c
> index 447e8166d2..0090543f89 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -292,6 +292,7 @@ static void err(struct add_p_state *s, const char *fmt, ...)
>  {
>         va_list args;
> 
>         va_start(args, fmt);
> +       fflush(stdout);
>         fputs(s->s.error_color, stderr);
>         vfprintf(stderr, fmt, args);

I think the "just send it all to stdout" approach makes the most sense
here, but in case we don't do that: I don't think this will fix it. In
the output above it is the "Unknown command" output which is delayed,
which is sent to stderr via err(). So flushing stdout again won't help.
Flushing stderr after the vfprintf _might_ help (though I'm confused why
stderr would be fully buffered in the first place).

-Peff
