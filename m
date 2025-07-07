Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BA2E370C
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920091; cv=none; b=dkTDdAhqKl4uclK4eVaOo8voHWPRWUnH5C1G1LPHhDRmQexc6j8zfHxkc6vgFlU6AF6JS78HQZHtV0VY2lkn/RjiUZuaCGN53mFh4il8AoF7MVb6Hi4cEKJq8oy7X+kpBkJDBfSknnNAp2J/JDv3YdW3aHrhWZJ2A8R7pVkx0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920091; c=relaxed/simple;
	bh=vvTha7iH5YcccoaUbpv+hU5jkgS+ls/5/97dZf7vRzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcimaGTCBjc2gW0mtpkWNsqmMwmLziqYSsHeqKYJLtC72DWLjF50zAzb8drW5PCIPOqOOF399tc6MBkyYLW/cBfi19YggLCRJnNU6JIcGvr4uoGu7XyvIU5Ax3lt3Zg2y8pTuLKhvr4DFDq/aA/X+Np2DTwgbkTAtvbt1ClwEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZEr2iphq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZEr2iphq"
Received: (qmail 9446 invoked by uid 109); 7 Jul 2025 20:28:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=vvTha7iH5YcccoaUbpv+hU5jkgS+ls/5/97dZf7vRzI=; b=ZEr2iphqOmMubdA+BLlqSG1G+ROQAiH+SUGFDGCs4Uj6ObzNsAAGGtpVvwSX2Wi8rQGLRGVawMIQOT4mir/VVyXYYs1/zP9tEpuXU6V3JHQIV+1PvtGqUCdab55UUl7e0egOfgRka26mKNnOe7H0MB37vNPeXocFYrvzkzx1/7ANo2uYaHMrZqBGQcJb8XWudxgeF8TaDr6GGDom3TZidRoSxvaQOI8FFgINH6dryFAXVgeZ4OvbR3IfgYLlE++QY50TJd2eVPL8DRudkKqpJCzviAH0FdWRs4TVd6vJahIwO9g60N9TxV3nrd2ntBE8MHp3ZqpufdTz6psj66Mkcg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Jul 2025 20:28:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9197 invoked by uid 111); 7 Jul 2025 20:28:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Jul 2025 16:28:03 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Jul 2025 16:28:01 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Per Cederqvist <ceder@lysator.liu.se>, git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
Message-ID: <20250707202801.GA3115893@coredump.intra.peff.net>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <20250705165750.GA1951664@coredump.intra.peff.net>
 <20250705185842.GA2496172@coredump.intra.peff.net>
 <aGuP3Q5xykmRNp0m@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGuP3Q5xykmRNp0m@pks.im>

On Mon, Jul 07, 2025 at 11:14:05AM +0200, Patrick Steinhardt wrote:

> > +static int check_remote_collision(struct remote *remote, void *vname)
> 
> Tiniest nit: I was a bit puzzled what the `v` in `vname` stands for, and
> it took a while until I noticed that it probably stands for `void`. If
> you end up rerolling, I'd suggest to either call this `payload` or
> `_name`.

Yeah, it's for "void". This is a pattern used elsewhere for callbacks
(usually as "vdata", but here we didn't need a container struct since
there's only one item). I think "payload" is not a term we usually use,
but maybe just "data" would be the usual thing (we only need "vdata"
when we're assigning to the non-void data type).

IMHO we should probably avoid the underscore pattern. It's OK here, but
it runs close to violating the reserved names rules (a global variable
variable _name is bad, and _Name anywhere is bad).

> Hm. Do we have to care about '\' on Windows, as well? This made me
> rediscover the following function:
> 
>     static int valid_remote_nick(const char *name)
>     {
>     	if (!name[0] || is_dot_or_dotdot(name))
>     		return 0;
>     
>     	/* remote nicknames cannot contain slashes */
>     	while (*name)
>     		if (is_dir_sep(*name++))
>     			return 0;
>     	return 1;
>     }
> 
> Which... puzzled me a bit at first, as it seems to indicate that a
> remote with a path separator is invalid. But as it turns out we only use
> this function if remotes are configured via ".git/remotes" or
> ".git/branches". Looks like we eventually lost this limitation, probably
> when config-based remotes were introduced.

AFAICT "remote add" allows anything that parses as a refspec, which
implies that refs/remotes/<name>/ passes check_refname_format(). And we
don't allow backslashes there:

  $ git remote add foo/bar url
  [no output, $? is 0]
  $ git remote add 'bar\foo' url
  fatal: 'bar\foo' is not a valid remote name

I don't think this is platform dependent. It's coming from the
refname_disposition table, so we're not calling is_dir_sep(). Only '/'
is marked in that table as end-of-component, and "\\" is forbidden.

So I don't think we need to worry about backslashes here.

-Peff
