Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C86E57D
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720249324; cv=none; b=CRzGa+0s0AW7r4r3/dIrASFE2+eY/pk7dO2cBX4EpmBOr15UK6zdVGh+Qfo+xzioNudgCXmipznp/f2nw7tJTpr3hfb4vsD1UhxLJkx/vIqbEpON6cN0aTUQXlEpIbm5D0qga9Hy9ySr99mzmxfedDD/sxR1L0O0iBYBDV30Rb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720249324; c=relaxed/simple;
	bh=LSZtRjHXz6WEzKKbRsuqVDumI9e5IYaH2zjkAgxCM9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcViQWlx8fJIH+VGrpqMzDOwTKO/rbvr1Lqmn6TCUJsVryLxKpaJEupy2YFzvQYiKd6W/1QFVpQKiFur27vCBRcf+h5c0mxEF8PRz2CQKW2ENMA3DRa3f4zewbji+XcP1yH20N7k2TpnWUCB9VNV0tS6HJMEfFWDk3oFo+Qy3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24447 invoked by uid 109); 6 Jul 2024 07:02:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 06 Jul 2024 07:02:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31670 invoked by uid 111); 6 Jul 2024 07:02:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Jul 2024 03:01:59 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Jul 2024 03:02:01 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Tiago de Bem Natel de Moura <t.nateldemoura@gmail.com>,
	git@vger.kernel.org
Subject: Re: git diff-tree do not honor diff.orderfile config
Message-ID: <20240706070201.GA702644@coredump.intra.peff.net>
References: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>
 <Zohf7LzaRHaG9vX6@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zohf7LzaRHaG9vX6@nand.local>

On Fri, Jul 05, 2024 at 05:04:44PM -0400, Taylor Blau wrote:

> On Fri, Jul 05, 2024 at 11:28:23AM +0100, Tiago de Bem Natel de Moura wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > The config `diff.orderfile` is not being honored in the `git diff-tree` command
> > as stated by the documentation.
> 
> Makes sense... the diff.orderFile configuration is part of the "UI" set
> of diff.* configuration options, which are honored by porcelain commands
> like commit, diff, log, etc., but not by plumbing commands like
> diff-tree.
> 
> I think from 6d8940b562 (diff: add diff.orderfile configuration
> variable, 2013-12-18) adding it to the UI-only configuration set was
> intentional, but it is somewhat awkward that we respect -O but not the
> configuration it falls back on.

I don't think it's awkward at all. The plumbing commands should provide
most every option that the porcelain ones support, but should do so
based only on the options given by the caller. I.e., imagine you were
writing "git diff" (or a similar command) as a script and you wanted to
support something like diff.orderfile. You'd do it by parsing
diff.orderfile yourself and passing "-O" where it made sense to do so.

> So I suppose the question is whether supporting -O from diff-tree is
> sensible. If it is, then reading the diff.orderFile configuration option
> is a no-brainer. But if it isn't, then we should probably not make a bad
> situation worse by adding support for it.

No, I don't think we ever want diff-tree (or other plumbing commands) to
support diff.orderFile. It will cause unexpected results for consumers
of the plumbing output. E.g., it would probably at least screw up
patch-id.

So this all just looks like the usual "plumbing does not respect some
config" situation.

-Peff
