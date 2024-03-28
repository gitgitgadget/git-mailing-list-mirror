Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5762B2AEFB
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619270; cv=none; b=LfgFG+sjsvV1glJ43emFARASoCy5gLtU1IUX5INn/VhYX1dC1mFbC4eWTCqDwRuLArXTBOQJXBR3ztcLC4MCkrL6iP+Cv2hhF5T9Lo1lBerJjpLyMvwPvCfNLRHA25fIjfq0ihhZsIsxCVglZRRRiEUwuQhxzC8DYiiDtnzWi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619270; c=relaxed/simple;
	bh=Asoa13RxCepEVr38PQKR3eOj+hBDUkPpJoZ0GQuL5D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQhF3yBtwkBlwTGKxPY+aBocnPkg3I3DoqkiAYPFZhRSf4CvU9ys04RtKJqsGwN9P/R2Wkm29In2Sv2nj841mqicj5xd32ZnbWzYPQ4jy6WOgRmZDlb7ZGBuu8sWHqjfpUddMn+JzqAt75tgEE7LpUPaSriubuyLQFVFt5M9h5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2961 invoked by uid 109); 28 Mar 2024 09:47:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Mar 2024 09:47:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4217 invoked by uid 111); 28 Mar 2024 09:47:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Mar 2024 05:47:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Mar 2024 05:47:40 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Dragan Simic <dsimic@manjaro.org>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH 17/16] config: add core.commentString
Message-ID: <20240328094740.GA871147@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
 <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
 <20240315081041.GA1753560@coredump.intra.peff.net>
 <xmqq8r247igg.fsf@gitster.g>
 <20240327074655.GA831122@coredump.intra.peff.net>
 <20240327081922.GA830163@coredump.intra.peff.net>
 <xmqqa5mj3b6c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5mj3b6c.fsf@gitster.g>

On Wed, Mar 27, 2024 at 09:13:31AM -0700, Junio C Hamano wrote:

> > An alternative to using "$var cannot ..." in the error messages (if we
> > don't like the all-lowercase variable name) is to just say "comment
> > strings cannot ...". That vaguely covers both cases, and the message
> > printed by the config code itself does mention the actual variable name
> > that triggered the error.
> 
> OK, because the error() return from this function will trigger
> another die() in the caller, e.g.
> 
>     error: core.commentchar must have at least one character
>     fatal: bad config variable 'core.commentchar' in file '.git/config' at line 6
> 
> so we can afford to make the "error" side vague, except that the
> "fatal" one is also downcased already, so we are not really solving
> anything by making the message vague, I would think.  The posted
> patch as-is is prefectly fine.

Oh, right.  For some reason I thought the die() message would have the
variable as written by the user, but that obviously is not true. So I
agree it would not even be an improvement (and the normalizing in my new
error() message is something we've been living with all along anyway for
other messages).

> Side note:
>     I wonder if we would later want to somehow _merge_ these two
>     error messages, i.e. the lower-level will notice and record the
>     nature of the problem instead of calling error(), and the caller
>     will use the recorded information while composing the "fatal"
>     message to die with.  I actually do not know if it is a good
>     idea to begin with.  If we want to do it right, the "record"
>     part probably cannot be a simple "stringify into strbuf" that
>     will result in lego message that is harder for i18n folks.

Yeah, this is a general problem of accumulating errors. I had always
assumed in cases like this that we could have some language-independent
syntax like:

  die("%s:%d: error parsing '%s': %s",
      file, line_nr, var, err_from_callback);

It's certainly lego-like, but it avoids the worst lego cases where
we're literally composing sentences. But as somebody who does not do
translations, it's possible I'm just being optimistic. ;)

-Peff
