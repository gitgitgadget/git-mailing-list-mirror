Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4575F16F8F0
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098000; cv=none; b=jVmfdPMdVCZfw6A+SWIlFxd5d4hX9qHOz5RsbCPH3SutP8AQK0tyueokfRHdpJh6AHaUxSTt1lp0MWsVknornDQhCkE7kmMoW/x5F/KPXd2CUhMTbIF872dosjeX3O24Q58ib6Bka5xO/2LdRsJV5A3JGaz7oM21Vxe3yxByRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098000; c=relaxed/simple;
	bh=79CfZDN42bdu+NxihZ3BJKAnI5QcYbXhP8WrAQaXyXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rleU+4/wOY3gOckcOUoCw7SCbpWojQVfklJLPJk5VAM7oXmaeJjUEXDBjS8b6QlKU+oEdl171Hd+2ANVU0uswxqulwGUi9HgRKAfoQl1rm0WUaybEvdJiil+p+QfeweRH8ECP4EG3vAyOnt6fhsRypt/YY6U4hQHcCZIXRWMTxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19020 invoked by uid 109); 11 Jun 2024 09:26:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 09:26:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25343 invoked by uid 111); 11 Jun 2024 09:26:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 05:26:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 05:26:37 -0400
From: Jeff King <peff@peff.net>
To: rlee <rlee287@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question about Git protocol v2 status
Message-ID: <20240611092637.GA3264649@coredump.intra.peff.net>
References: <kMdINBpG8_XazfNJVjKkaYyCH4VKRgjQryAvNw2ceVZrNmJ8pqoowMgmGBhhDMS_-nQ02OX0dMglJA2EPrE39XIBtcZc8Wkr2Vcoh6_pzMg=@proton.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kMdINBpG8_XazfNJVjKkaYyCH4VKRgjQryAvNw2ceVZrNmJ8pqoowMgmGBhhDMS_-nQ02OX0dMglJA2EPrE39XIBtcZc8Wkr2Vcoh6_pzMg=@proton.me>

On Tue, Jun 11, 2024 at 12:21:26AM +0000, rlee wrote:

> I've been looking into writing a custom Git remote helper. The man
> page for "gitremote-helpers" states that stateless-connect is used to
> connect to a Git server using v2 of the wire protocol, but that it is
> "Experimental; for internal use only." Moreover, the page describing
> protocol-v2 at https://git-scm.com/docs/protocol-v2 uses future tense,
> implying that v2 has not yet been finalized. However, the older blog
> post
> https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html
> states that v2 is expected to become part of Git v2.18 (with Git being
> many versions ahead of v2.18 by now), and my own testing shows that
> stateless-connect is used when performing Git operations via HTTPS
> with Github. Could I get some clarification on whether v2 is still
> experimental and on whether a custom gitremote-helper should declare
> (and implement) support for stateless-connect?

I think the docs are out of date. v2 is mature and has been the default
since v2.29.0, courtesy of eb049759fb (protocol: re-enable v2 protocol
by default, 2020-09-25).

The stateless-connect code is heavily exercised via git-remote-curl, but
I suspect you may be the first other helper to use it. So it's possible
you might find some corner cases. The point of it is mostly about
turning the helper into a dumb pipe, so I'd be surprised if you found
anything that caused us to rethink the helper interface there.

So my suggestion would be to work on it assuming that the interface is
as documented, and let us know if you run into any problems (and
likewise report success if you find it!).

-Peff
