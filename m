Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318317C2
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712457939; cv=none; b=q+Xr7+TZ20ALzmvVAFQV0v2B4Ik272gtQS3tMmPekaxisRrll6ph42tqWiSF9hSGnN7I6w1fEW87hDmdz10PEr2hhzKpaoFA0cyf2mdeqYZuckLQmob9BV6eGLYu2mNA0CeBcSrNSVOjExN4BHnxD6Mwm02zupT/Kc85C1Ho97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712457939; c=relaxed/simple;
	bh=OElV8DjJSeXuZLjEHWjb+TEJHrXF9weKnQ1IaQnNyHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0+flARP5wiymD3HwrUlW9NsouBn5H2V9n7a6TwaJmYI0lLJj8DtOO9DqgiWwBclJYTfjgLNjFIobRgwYbSwacY7kHoQ2MzV/xAjKMns3d/u6LN4V9IvFAYcFptzNhs52Ig9stB3eHzRfRFZBBSTMWkJTRouzahIGyExHPGg/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9060 invoked by uid 109); 7 Apr 2024 02:45:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 02:45:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12175 invoked by uid 111); 7 Apr 2024 02:45:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 22:45:39 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 22:45:35 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH 03/11] config: prefer git_config_string_dup() for temp
 variables
Message-ID: <20240407024535.GA1585186@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
 <20240407010037.GC868358@coredump.intra.peff.net>
 <CAPig+cRyya=hUYtdzoqgFLQq0eEnkgH1ayZTLBGtM2gRrc2yTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRyya=hUYtdzoqgFLQq0eEnkgH1ayZTLBGtM2gRrc2yTw@mail.gmail.com>

On Sat, Apr 06, 2024 at 09:50:23PM -0400, Eric Sunshine wrote:

> On Sat, Apr 6, 2024 at 9:00 PM Jeff King <peff@peff.net> wrote:
> > In some cases we may use git_config_string() or git_config_pathname() to
> > read a value into a temporary variable, and then either hand off memory
> > ownership of the new variable or free it. These are not potential leaks,
> > since we know that there is no previous value we are overwriting.
> >
> > However, it's worth converting these to use git_config_string_dup() and
> > git_config_pathname_dup(). It makes it easier to audit for leaky cases,
> > and possibly we can get rid of the leak-prone functions in the future.
> > Plus it lets the const-ness of our variables match their expected memory
> > ownership, which avoids some casts when calling free().
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > diff --git a/builtin/config.c b/builtin/config.c
> > @@ -282,11 +282,11 @@ static int format_config(struct strbuf *buf, const char *key_,
> > -                       const char *v;
> > -                       if (git_config_pathname(&v, key_, value_) < 0)
> > +                       char *v = NULL;
> > +                       if (git_config_pathname_dup(&v, key_, value_) < 0)
> >                                 return -1;
> >                         strbuf_addstr(buf, v);
> > -                       free((char *)v);
> > +                       free(v);
> 
> This revised code implies that git_config_pathname_dup() doesn't
> assign allocated memory to `v` in the "failure" case, thus it is safe
> to `return` immediately without calling free(v). However, the
> documentation for git_config_pathname_dup() and cousins doesn't state
> this explicitly, which means the caller needs to peek into the
> implementation of git_config_pathname_dup() to verify that it is safe
> to write code such as the above. Hence, should the documentation be
> updated to explain that `v` won't be modified in the "failure" case?

That's nothing new with my patch, though, is it? The same would apply
for git_config_pathname(). And git_config_string() for that matter. I'm
also struggling to imagine what it _would_ copy into "v" on failure
anyway.

-Peff
