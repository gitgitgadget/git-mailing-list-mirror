Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB27D23B0
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727408992; cv=none; b=MRkNy8Lhy5DVZ5qz7yprsBq++i+ds9+lLao6WhYeDI0kji6Ir4SXEo+MG4SSbF2GmlLL5/qdAyfarpEk//VPZ0B+JOegoKkIB49i+G5+26iTP1DsYWXTJbzpWZRrM9cLfgZ//Sd3YzO36PwJvMNZgdJlYtG5dS+vFh7oQq0oIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727408992; c=relaxed/simple;
	bh=WpvAhzHcDNItEuwMwKdvEY4Xph8qlhN7aHEIAZvvxuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMd/+0Qn+ZV5Z5ItvqtJBy6Wv1aDa+KEhx3vhwVwKrxQ0muwXpKrmjq7cOXQnaMg6BSjeRd5aPZwCfsi2IKOkRAOtRIVF9E0M78UqFFsO57KU8aJCeTTPfb8uoIuoA5KF7jgrGfGJjqMT7wPpBMmCRN1MOyX+PuLy8vQcpHw6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4849 invoked by uid 109); 27 Sep 2024 03:49:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:49:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8998 invoked by uid 111); 27 Sep 2024 03:49:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:49:49 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:49:48 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/28] transport-helper: fix strbuf leak in
 push_refs_with_push()
Message-ID: <20240927034948.GC567395@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924215634.GI1143820@coredump.intra.peff.net>
 <ZvVmllrUvOC3pGJy@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVmllrUvOC3pGJy@pks.im>

On Thu, Sep 26, 2024 at 03:50:14PM +0200, Patrick Steinhardt wrote:

> On Tue, Sep 24, 2024 at 05:56:34PM -0400, Jeff King wrote:
> > diff --git a/transport-helper.c b/transport-helper.c
> > index c688967b8c..9c8abd8eca 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -1023,6 +1023,7 @@ static int push_refs_with_push(struct transport *transport,
> >  			if (atomic) {
> >  				reject_atomic_push(remote_refs, mirror);
> >  				string_list_clear(&cas_options, 0);
> > +				strbuf_release(&buf);
> >  				return 0;
> >  			} else
> >  				continue;
> 
> What's not visible here is that a few lines further down we have another
> early return where we don't clear `buf`. But that exit is conditioned on
> `buf.len == 0`, and given that we never `strbuf_reset()` the buffer we
> know that `buf.len == 0` only when it hasn't ever be allocated.

Yeah, I noticed that, too, and came to the same conclusion. As you note,
it's _possible_ to have an allocated but zero-length strbuf, but I don't
think it happens here. So it's OK in practice.

If we were going to refactor, I think it would make sense to do it with
a cleanup label to cover both of these early returns, plus the cleanup
at the end. I was mostly just going for minimal changes where possible.

-Peff
