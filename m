Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3C20B1F4
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755622799; cv=none; b=Rsb27AFylFs8YccyZwNblS4ZGVH6YYrzwhpYKUWlHcJQnw9LEZH+7VCSkhv5QKD04FjR/H2ph4dZrETr83zJB80OJhquCEgvfRsf2VRECUW6/6Vp/zOLCqbb8b2qNwKeH9nR4OQbAaQ1LfxOArYGmm+IOtjwRABJ7II5yVSTidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755622799; c=relaxed/simple;
	bh=1lbiUm0+2CtPDyvpt9XtuDHo/pfKQBqv7RVAC5TV/K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAtszHEI8egyJn6bzHp5Mi471VxWe8Q2X2qigqRDA5o7oLLFVcm7CfQ6k7qggHuwvDAsaYYGr+N5BPAScn5B1/WJsRxkn5YENnRK/y7sgg++y/kzbU02RQYFGe+/BfjGQ7DcApU4h/CTBcivvqZrySmu0/x5Y3hsTqHgDuJ0UxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EBNNdIWt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EBNNdIWt"
Received: (qmail 30536 invoked by uid 109); 19 Aug 2025 16:59:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1lbiUm0+2CtPDyvpt9XtuDHo/pfKQBqv7RVAC5TV/K0=; b=EBNNdIWtNmG6WiCpbJqctNWaJG8hvY1KUHMUZa9LFZ6Wd74dT9l7tI3BFapoigJh7IGbsw1SaaMOABLqX0WOE1MVjHNcvLez2JceCRIfRIU/BXhR9hLNJP829+VYZXIsqg90OWkE+368sykFwsSYR4FPOocoCobxDb6/JSOJOkA3RwclWHnDrEKXB6MS0MLAhsBSvoEoAkM2N4uxuEbEWJ8Rj+SQkitfQNv0WzwjzwiqKZuujocIhUzM8Czuez4y5B9y34PCzvuLUQv+yaU50zyx7BKtFiFGAg2iB8XM39MUWYLWU1GIYm+BSoO54sphsxPdqPBz84EDx01AXc2fYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 16:59:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 44686 invoked by uid 111); 19 Aug 2025 16:59:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 12:59:47 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 12:59:47 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, phillip.wood@dunelm.org.uk,
	Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
Subject: Re: [PATCH 4/5] describe: handle blob traversal with no commits
Message-ID: <20250819165947.GA1050577@coredump.intra.peff.net>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210312.GD1024556@coredump.intra.peff.net>
 <aKQwP01nulsquhzi@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKQwP01nulsquhzi@pks.im>

On Tue, Aug 19, 2025 at 10:05:19AM +0200, Patrick Steinhardt wrote:

> > I didn't include a test here because it requires corrupting the
> > repository in a way that is only easy to do using the files ref backend.
> > It doesn't seem worth carrying a REFFILES test just for this oddity.
> 
> True:
> 
>     $ git update-ref HEAD HEAD^{tree}
>     fatal: update_ref failed for ref 'HEAD': trying to write non-commit object 4b825dc642cb6eb9a060e54bf8d69288fbee4904 to branch 'HEAD'
> 
> But:
> 
>     $ git update-ref refs/some/tree HEAD^{tree}
>     $ git symbolic-ref HEAD refs/some/tree
>     $ git show
>     tree HEAD
> 
> So that should allow you to write a test, right?

Hrm, that seems like a bug. I thought we insisted that HEAD point at
refs/heads.

Ah, no. We did that in b229d18a80 (validate_headref: tighten
ref-matching to just branches, 2009-01-29), but had to revert it in
e9cc02f0e4 (symbolic-ref: allow refs/<whatever> in HEAD, 2009-02-13) to
keep compatibility for topgit. :(

Still, I'm not sure it's something I'd want to base a test on. Maybe if
there is a big comment that says "It is OK to invalidate and remove this
test if we ever tighten symbolic-ref" it would be OK?

-Peff
