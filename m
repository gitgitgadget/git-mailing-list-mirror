Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996117BBB
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872298; cv=none; b=Wt5rNQKIxSSVEosDsDzY55SIvNS6Tnb9qKH5Ap1+GbFCwhQi5rSxo8y/YUsIinF6yjGZIjyiRRZyA2CR/FEIAkX7dX4I7EdL/N1FfceCqku6od94qWc1zTACx6pPG4InOBazaPin079QONZ/WZGw1I0JBNZazJGg37regFpj5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872298; c=relaxed/simple;
	bh=8ek40J+aXbi62+llTG1dEQ6GygngX9THHXiEEj2FIgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoNJGOlYeBRmiPiUezFtOVy+ZJHubp7YqAc+kWBTnUBD97Bu+v2GM84cPS6UxIZV+egb9/m/9mN1LNmKzmCnnzBIAruj5CUWOe+sHyg4+XxnCJHXcAL1njLYhOdr1RxtTjfQ12jBaH5H6RdNxv4jmKrz4wRenHINzfKmiBBuq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 29519 invoked by uid 109); 1 Jul 2024 22:18:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 22:18:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18140 invoked by uid 111); 1 Jul 2024 22:18:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Jul 2024 18:18:14 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 1 Jul 2024 18:18:15 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 1/6] t0080: move expected output to a file
Message-ID: <20240701221815.GB20683@coredump.intra.peff.net>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <c60c78c7-a029-48e8-840a-45dcc785a6e5@web.de>
 <20240701032047.GA610406@coredump.intra.peff.net>
 <177e98da-803e-4839-9484-fd24828bd21b@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177e98da-803e-4839-9484-fd24828bd21b@web.de>

On Mon, Jul 01, 2024 at 09:51:31PM +0200, René Scharfe wrote:

> > would that be preferable to moving it to its own file? I kind of like
> > keeping everything in the test scripts themselves so related changes can
> > happen side-by-side, though I admit in this case it is intimately tied
> > to the separate test-example-tap.c source anyway.
> 
> I can't think of an example where we keep test definitions in the same
> file as the code to be tested.  It would be somewhat cool to empower the
> unit test framework to test itself, but I suspect that this nesting
> ability would be hard to achieve and not very useful otherwise.  And
> would we be able to trust such a self-test?

Yeah, I think this is really a special case, just because we're not
testing specific items, but rather sanity-checking the TAP output
itself.

I think even in the unit tests, we're mostly carrying expected output
next to the code (and the unit test harness is checking those and
producing appropriate messages). It's only this "run a bunch of tests
that might themselves fail and see if the output was sensible" that it's
hard to do this for. I.e., t0080 is special and weird.

> The only downside of keeping the expected output of t0080 separate that
> I can think of is that it might get confusing if we'd ever add more
> test_expect_success calls to it, but I can't imagine why we'd want to
> do that.

Yeah, I think it is mostly a lost cause here. We are far away from the
source code whether it is a here-doc or a separate file.

I guess I was responding more to the principle that external files are
usually just distracting and annoying (another annoyance: they inhibit
tab completion ;) ). But it is not that big a deal either way in this
case.

> Being able to pass the test code to test_expect_success as a here-doc or
> file to avoid nested shell quoting sounds useful in general.  For t0080
> we could achieve the same effect already by creating the expect file
> before calling test_expect_success.  That has the downside of passing
> even when the disk is full and the files are created empty, but we can
> throw in a "test -s" to rule it out.

Yup, agreed with everything there.

-Peff
