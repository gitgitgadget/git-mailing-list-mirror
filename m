Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CC76C61
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754131537; cv=none; b=bX0HiTaPUqDH7kytmOipCDXhaRANTyG98MIZdQaX1HXebDZaXJtU5gYmc4NXHjVEDlbB9/WrL/ege2BjpQp5c6L2z8TWooCAF2zoMhWSShQsZufFyJx+a4apOQ/Ic26304XYekWkZ0CUJBLV15gU1+eBwmq0CqZ+H3nhr1b0TEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754131537; c=relaxed/simple;
	bh=fuEPLe7BjoN2efuhSJ7YKIMADB5ZceSuDFUJU8TZJQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1Xjx0HO+2oztNAVVYdwGOMa2gCfSAgjEdKg/nKSt91YySGZzVieE0/w7AMFZGd52vJiwon0aG+IpoPClpAoc1s3aNg6sNdQFl5GzqlqdpmK1mh6q8IloA/bMKL6WBU74S4gOzRLoUOsvvR+0PNrxho79AQYREH/wJsM/W8p72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cUsRsk6m; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cUsRsk6m"
Received: (qmail 9137 invoked by uid 109); 2 Aug 2025 10:45:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fuEPLe7BjoN2efuhSJ7YKIMADB5ZceSuDFUJU8TZJQM=; b=cUsRsk6mmh7y5pl8PvEYaJsbPF8VuK8p049HugOj39WSZ7gtNQK3/284qDe7Hkx7FfGPwBDJ1Jg7Rzx43wS54zEDl16+04rv+u8wt0WRPCMxzohgwmhdgvaFUIIjbnmMpkUzpbufzjI9Esmc+YARSbDpJmo7yNw4RZgzCNINemw3fpUyO69tCvnl/b74YYQmNzdfCOH10FC2lWpwCQ49sqLc8QKeVmJ06x75RCWO3hH2wXi6zDfqjmO/wIIF3W261l44StxrztOrGb6Y4cEQZUv45n2j/iM7+4buNLMkXAbFqDFsza7A6jUl+alLRbm3yKHLgGbK8O06RA8iZmeetg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 10:45:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12691 invoked by uid 111); 2 Aug 2025 10:45:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 06:45:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 06:45:33 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han Jiang <jhcarl0814@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 5/6] builtin/remote: rework how remote refs get renamed
Message-ID: <20250802104533.GA1180347@coredump.intra.peff.net>
References: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
 <20250731-pks-remote-rename-improvements-v2-5-dda6f083674d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731-pks-remote-rename-improvements-v2-5-dda6f083674d@pks.im>

On Thu, Jul 31, 2025 at 04:56:53PM +0200, Patrick Steinhardt wrote:

> There is one issue though with using atomic transactions: when nesting a
> remote into itself it can happen that renamed references conflict with
> the old referencse. For example, when we have a reference
> "refs/remotes/origin/foo" and we rename "origin" to "origin/foo", then
> we'll end up with an F/D conflict when we try to create the renamed
> reference "refs/remotes/origin/foo/foo".

I think that was true even in the old code. E.g., if I do:

  git init server
  git -C server commit --allow-empty -m foo
  git -C server branch a
  git -C server branch b

  git init
  git remote add foo/b server
  git fetch
  git remote rename foo/b foo

then I get (before your patches):

  error: 'refs/remotes/foo/b/main' exists; cannot create 'refs/remotes/foo/b'
  fatal: renaming 'refs/remotes/foo/b/b' failed

Worse, we moved "a" but not "b" (nor "main"/"master", which are
important because they are what's blocking the rename of "b"). So we are
left with a broken half-moved state.

After your patches we get a nicer hint message, and of course we retain
the unbroken state from prior to the rename. So IMHO it is strictly
better.

-Peff
