Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24867187A
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19781 invoked by uid 109); 13 Jan 2024 07:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 13 Jan 2024 07:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25614 invoked by uid 111); 13 Jan 2024 07:38:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 13 Jan 2024 02:38:31 -0500
Authentication-Results: peff.net; auth=none
Date: Sat, 13 Jan 2024 02:38:28 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>,
	Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] advice: allow disabling the automatic hint in
 advise_if_enabled()
Message-ID: <20240113073828.GB657764@coredump.intra.peff.net>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>
 <xmqqsf326vpn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsf326vpn.fsf@gitster.g>

On Fri, Jan 12, 2024 at 02:19:32PM -0800, Junio C Hamano wrote:

> Rubén Justo <rjusto@gmail.com> writes:
> 
> >  advice.c          | 109 +++++++++++++++++++++++++---------------------
> >  t/t0018-advice.sh |   1 -
> >  2 files changed, 59 insertions(+), 51 deletions(-)
> >
> > diff --git a/advice.c b/advice.c
> > index f6e4c2f302..8474966ce1 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -33,50 +33,56 @@ static const char *advise_get_color(enum color_advice ix)
> >  	return "";
> >  }
> >  
> > +enum advice_level {
> > +	ADVICE_LEVEL_DEFAULT = 0,
> 
> We may want to say "_NONE" not "_DEFAULT" to match the convention
> used elsewhere, but I have no strong preference.  I do have a
> preference to see that, when we explicitly say "In this enum, there
> is ADVICE_LEVEL_DEFAULT and its value is zero" with "= 0" in the
> definition, the places we use a variable of this enum type, we say
> 
> 	if (!variable)
> 
> and not
> 
> 	if (variable == ADVICE_LEVEL_DEFAULT)

This may be getting into the realm of bikeshedding, but... ;)

For a tri-state we often use "-1" for "not specified". That has the nice
side effect in this case that "if (level)" shows the advice (that works
because "unspecified" and "explicitly true" both show the advice. And
then "if (level < 0)" is used for just the hint. But maybe that is too
clever/fragile.

Of course that means that all of the initializers have to use "-1"
explicitly. So zero-initialization is sometimes nice, too.

-Peff
