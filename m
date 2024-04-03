Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C231E493
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177694; cv=none; b=ZklgHW7Wmdf4KhUll6mzk6rTf2F0Su0fixY+rAfyHfff0sIkpJecRiFBv5giuC8QpblBlrrF4EVmUBB+ioXOR9Dr+8P3+ONjtczRpsXITXW56w1PuaBgJsDfQuUZTOZ+Mrwkr4ROIM0SI/7+f7vGU0A4IZ1dAVJs137ix1EkkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177694; c=relaxed/simple;
	bh=ia8t2MdgwEvCNwZOdR5JppKas7hl8zEV3ufl1HBse4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJccDe/JTWdWjjVajWmc2TbPfepbs2BOwRjb8PPL3caG59CRhdvKNTuCssd1rB3iByWQ+uV646qzLoQoCDJXp9IwyXG/xmB9Nrx8vOV5+etKgaRYhmxDwfOUYWSt7SgI+fmHm/iUF+EeGsCU69V38P6Z6GYk36YQvad4n3IyeVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26742 invoked by uid 109); 3 Apr 2024 20:54:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 20:54:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11696 invoked by uid 111); 3 Apr 2024 20:54:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Apr 2024 16:54:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Apr 2024 16:54:51 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, git <git@vger.kernel.org>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: reftable & jgit compatibility
Message-ID: <20240403205451.GD1949464@coredump.intra.peff.net>
References: <CAOw_e7Z_10b73n91ihsaao_S-XPkNqvY7gTcHvqUODKD-SwPSA@mail.gmail.com>
 <Zg0zs2_QLpXv2PwT@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zg0zs2_QLpXv2PwT@tanuki>

On Wed, Apr 03, 2024 at 12:47:15PM +0200, Patrick Steinhardt wrote:

> I very much agree, this thought has crossed my mind multiple times while
> working on the whole reftable saga. Ideally, we would have integration
> tests that write reftables with one of the implementations and then read
> them with the respective other implementation. I wouldn't really know
> where to put those though. CGit is very unlikely to pull in JGit as a
> test dependency. Does JGit have any tests that already use CGit?

We do have some tests that use jgit to check bitmap interoperability.
But obviously they're optional, and I suspect they are not run very
often (I do have jgit in my path these days, so I run them, but I assume
most people don't). It probably wouldn't be too hard to include it in
one of the CI runs, though. You can grep for the JGIT prereq in t/.

We had another test that used jgit to check for some protocol
interoperability. But it was broken with sha256 and nobody noticed. ;)
There I replaced it with a hard-coded input. See 13e67aa39b (v0
protocol: fix sha1/sha256 confusion for capabilities^{}, 2023-04-14) for
some discussion.

I think using actual jgit (versus a hard-coded input) is a good basic
smoke test: it tells us if the two can interoperate generally. But for
testing specific inputs like the case in 13e67aa39b, we are depending on
jgit producing that specific behavior (which in this case, it probably
wasn't any more). And there we are better off just with a manual test
vector.

-Peff
