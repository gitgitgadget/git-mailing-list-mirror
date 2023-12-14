Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E96EB71
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8787 invoked by uid 109); 14 Dec 2023 21:44:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Dec 2023 21:44:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11620 invoked by uid 111); 14 Dec 2023 21:44:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Dec 2023 16:44:44 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Dec 2023 16:44:44 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Carlos =?utf-8?B?QW5kcsOpcyBSYW3DrXJleiBDYXRhw7Fv?= <antaigroupltda@gmail.com>
Subject: [PATCH 0/2] avoiding recursion in mailinfo
Message-ID: <20231214214444.GB2297853@coredump.intra.peff.net>
References: <20231212221243.GA1656116@coredump.intra.peff.net>
 <ZXlYIZ0Hb1kN84NU@tanuki>
 <20231213082027.GB1684525@coredump.intra.peff.net>
 <ZXqxoKLFG19tMFpF@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXqxoKLFG19tMFpF@tanuki>

On Thu, Dec 14, 2023 at 08:41:20AM +0100, Patrick Steinhardt wrote:

> > @@ -72,11 +73,14 @@ static const char *unquote_comment(struct strbuf *outbuf, const char *in)
> >  				take_next_literally = 1;
> >  				continue;
> >  			case '(':
> > -				in = unquote_comment(outbuf, in);
> > +				strbuf_addch(outbuf, '(');
> > +				depth++;
> >  				continue;
> >  			case ')':
> >  				strbuf_addch(outbuf, ')');
> > -				return in;
> > +				if (!--depth)
> > +					return in;
> > +				continue;
> >  			}
> >  		}
> >  
> > I doubt it's a big deal either way, but if it's that easy to do it might
> > be worth it.
> 
> Isn't this only protecting against unbalanced braces? That might be a
> sensible check to do regardless, but does it protect against recursion
> blowing the stack if you just happen to have many opening braces?
> 
> Might be I'm missing something.

It protects against recrusion blowing the stack because it removes the
recursive call to unquote_comment(). ;)

The "depth" stuff is there because without recursion, we have to know
when we've hit the correct closing paren (as opposed to an embedded
one).

Here it is as a patch (actually two patches). I don't think it's high
priority, but I'd sunk enough brain cells into thinking about it that I
wanted to capture the work. ;)

I did it on top of the earlier mailinfo out-of-bounds read fix, but it
could be applied separately.

  [1/2]: t5100: make rfc822 comment test more careful
  [2/2]: mailinfo: avoid recursion when unquoting From headers

 mailinfo.c             | 8 ++++++--
 t/t5100/comment.expect | 2 +-
 t/t5100/comment.in     | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

-Peff
