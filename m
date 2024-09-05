Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CE19415D
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533015; cv=none; b=MN5LYVVXEGfhm6QZQk5Bn//IEidF6ZGFTScqO84nxoxrkDaw8bwUAZ85i2m69baW8YqrjFok7WmOEIG0N6Ux0VTm5Brug41n8zRW6WxnE7R6kDegfgFl740Hemd5T/iOXEgHP2NuGyK//ixriYvGW+aNaCql1bQh21qUnpvHivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533015; c=relaxed/simple;
	bh=bVS0TwqPfLAA3n8mnGwyvfTTX3egdzsQMDf6oKfD02k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH/ZSgcyDTsvnikuYe6mSQNDZkc/qYW/XckTIeahl5T6jtz1XJ4gEiYwSk7l6QIJ8KoTDL/31+YVIkuYMNWRPs56PyorlNKuRa8BbTzSJxWuvcHH0suybAjSPGUlk0ds6S5uHJc6o02jkNbaI/dpm1EC4u9Sj9qtUiU5Ya4H/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7311 invoked by uid 109); 5 Sep 2024 10:43:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 10:43:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8072 invoked by uid 111); 5 Sep 2024 10:43:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 06:43:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 06:43:31 -0400
From: Jeff King <peff@peff.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [RFC PATCH] config.mak.uname: add HAVE_DEV_TTY to cygwin config
 section
Message-ID: <20240905104331.GD2556395@coredump.intra.peff.net>
References: <a59f53af-58f7-42f5-aefb-50a4d9f344c4@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a59f53af-58f7-42f5-aefb-50a4d9f344c4@ramsayjones.plus.com>

On Mon, Sep 02, 2024 at 11:15:35PM +0100, Ramsay Jones wrote:

> Still, I need to do a full test suite run, just to check for any regressions.
> (Unfortunately, that takes about 6 hours to run, so I can't get to that soon).

I'm not sure if we cover this at all in the test suite, since it implies
access to an actual terminal. All of the auth tests rely on the askpass
interface to simulate the user typing a password.

We do have test_terminal, which simulates a pty, but I don't think it
would work for this case. For one thing, I don't know that it counts as
the controlling terminal, so opening /dev/tty wouldn't find it. And two,
the stdin handling had race problems that caused us to remove it
recently. So it's really only good for checking isatty() for
stdout/stderr.

On the plus side, if it works for you in a single manual test then I
suspect that's enough. The key thing is really "can we get something
tty-ish that responds to termios", and it sounds like you can.

Certainly doesn't hurt to test the single-key mode of "add -p", etc,
though.

> Anyhow, just a quick heads up.

Thanks for looking into it. :)

-Peff
