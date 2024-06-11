Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F717164F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087194; cv=none; b=g2ipKdq+6i8Lb5JUxZpzy2rmaRQQkCLDBjJZdRvo1sWYUdLU7jTQWimoomE7fOB9bzSPriQbO0j0YetAfe5oP9gEV3vdFmCAqPGBeiUzb/qjdHaVhwwXFhpWw99AUSXA/xb/k8Iipt7A2k05YKKwRl5mGmUDIx3njWpFYNpDHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087194; c=relaxed/simple;
	bh=8ihQ36h/Bp7RHV+PMQwO3tGjGmQ4G6RYHM3WR5SLu+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTpxaKGTFQkCvHpQ+AybhKOaYTDwZuuzm/7/8Amtqi6kc24lGqRyV0CyXhyOPEnCjCxlAp1C599Dc+oeKMq8lpNM+KeeXAopw6fXlhlUVprUlDKSX+j0jhtaWu/jLGiMByeI86mei/2817BnMBGsGhdEw4L50dzEpw/hDPXAQAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16603 invoked by uid 109); 11 Jun 2024 06:26:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 06:26:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23882 invoked by uid 111); 11 Jun 2024 06:26:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 02:26:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 02:26:23 -0400
From: Jeff King <peff@peff.net>
To: Emily Shaffer <nasamuffin@google.com>
Cc: ellie <el@horse64.org>, rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: With big repos and slower connections, git clone can be hard to
 work with
Message-ID: <20240611062623.GA3248245@coredump.intra.peff.net>
References: <fec6ebc7-efd7-4c86-9dcc-2b006bd82e47@horse64.org>
 <0be201dab933$17c02530$47406f90$@nexbridge.com>
 <fdb869ef-4ce9-4859-9e36-445fd9200776@horse64.org>
 <0beb01dab93b$c01dfa10$4059ee30$@nexbridge.com>
 <200c3bd2-6aa9-4bb2-8eda-881bb62cd064@horse64.org>
 <20240608084323.GB2390433@coredump.intra.peff.net>
 <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZkP58ZM4J3ejemyiqkkbEaQdphoyGj_LmX9-xb_eMgb4A@mail.gmail.com>

On Mon, Jun 10, 2024 at 12:04:30PM -0700, Emily Shaffer wrote:

> > One strategy people have worked on is for servers to point clients at
> > static packfiles (which _do_ remain byte-for-byte identical, and can be
> > resumed) to get some of the objects. But it requires some scheme on the
> > server side to decide when and how to create those packfiles. So while
> > there is support inside Git itself for this idea (both on the server and
> > client side), I don't know of any servers where it is in active use.
> 
> We use packfile offloading heavily at Google (any repositories hosted
> at *.googlesource.com, as well as our internal-facing hosting). It
> works quite well for us scaling large projects like Android and
> Chrome; we've been using it for some time now and are happy with it.

Cool! I'm glad to hear it is in use.

It might be helpful for other potential users if you can share how you
decide when to create the off-loaded packfiles, what goes in them, and
so on. IIRC the server-side config is mostly geared at stuffing a few
large blobs into a pack (since each blob must have an individual config
key). Maybe JGit (which I'm assuming is what powers googlesource) has
better options there.

> However, one thing that's missing is the resumable download Ellie is
> describing. With a clone which has been turned into a packfile fetch
> from a different data store, it *should* be resumable. But the client
> currently lacks the ability to do that. (This just came up for us
> internally the other day, and we ended up moving an internal bug to
> https://git.g-issues.gerritcodereview.com/issues/345241684.) After a
> resumed clone like this, you may not necessarily have latest - for
> example, you may lose connection with 90% of the clone finished, then
> not get connection back for some days, after which point upstream has
> moved as Peff described elsewhere in this thread. But it would still
> probably be cheaper to resume that 10% of packfile fetch from the
> offloaded data store, then do an incremental fetch back to the server
> to get the couple days of updates on top, as compared to starting over
> from zero with the server.

I do agree that resuming the offloaded parts, even if it is a few days
later, will generally be beneficial.

For packfile offloading, I think the server has to be aware of what's in
the packfiles (since it has to know not to send you those objects). So
if you got all of the server's response packfile, but didn't finish the
offloaded packfiles, it's a no-brainer to finish downloading them,
completing your old clone. And then you can fetch on top of that to get
fully up to date.

But if you didn't get all of the server's response, then you have to
contact it again. If it points you to the same offloaded packfile, you
can resume that transfer. But if it has moved on and doesn't advertise
that packfile anymore, I don't think it's useful.

Whereas with bundleURI offloading, I think the client could always
resume grabbing the bundle. Whatever it got is going to be useful
because it will tell the server what it already has in the usual way
(packfile offloads can't do that because the individual packfiles don't
enforce the usual reachability guarantees).

> It seems to me that packfile URIs and bundle URIs are similar enough
> that we could work out similar logic for both, no? Or maybe there's
> something I'm missing about the way bundle offloading differs from
> packfiles.

They are pretty similar, but I think the resume strategy would be a
little different, based on what I wrote above.

In general I don't think packfile-uris are that useful for resuming,
compared to bundle URIs.

-Peff
