Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED815B5B8
	for <git@vger.kernel.org>; Thu, 23 May 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716455462; cv=none; b=HqJPpBFF+TV32aXMOv6CZKaDbnBCgewCvHR/Gt1ra1UzGK96AyrcWq/G0X/zjyu+4dGPFTqsw5pj8flziisDQi4GxCaXe0MzVzNZOQVzb+ytaBwhs3tbJ/q74+KcX8Kd6p9/JZnyY+CGLwtqxRGpvgynTzcprjR1AT953qma9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716455462; c=relaxed/simple;
	bh=u3rD1Gf0BUcLkCS9B7ISGNo9viPEb0ZGvlsr/+0+nMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhfi2pTYCjyhk5ftEmJj/UaTT74Cni2BPZs9fqoNp3EKfIaCffeYPTCo9QqUf3BoTV+tBdZXJ3CI5ZYS0K3CMKz3ZXbMIo6gJEpFtTnNf/Os5Lyo2UK6r49WfMxr+GBzXwjSUWc+0ObFXdiZYz2MsXPQH1zB6XrUDEnv1FtqvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31120 invoked by uid 109); 23 May 2024 09:11:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 May 2024 09:11:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28500 invoked by uid 111); 23 May 2024 09:11:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 May 2024 05:11:04 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 May 2024 05:10:59 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Kyle Lippincott <spectral@google.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <20240523091059.GE1306938@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
 <20240510220228.GA1962678@coredump.intra.peff.net>
 <xmqqseyp1dys.fsf@gitster.g>
 <Zj-pGGGJEXlH02nR@framework>
 <20240516071930.GB83658@coredump.intra.peff.net>
 <ZkXX5MlN3EbaMhNG@tanuki>
 <20240517081909.GB1517321@coredump.intra.peff.net>
 <xmqqseygjrwo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqseygjrwo.fsf@gitster.g>

On Fri, May 17, 2024 at 09:59:35AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah. Combining orthogonal properties into a single job lets us cover
> > both (for the common case of success on both) with less CPU. But:
> >
> >   - it can sometimes be hard to figure out which of the properties was
> >     responsible for a failure. That was the very subject of the thread I
> >     referenced earlier, where "linux-gcc" was "use gcc" and also "set
> >     lots of knobs".
> >
> >   - they might not actually be orthogonal. If you care about checking
> >     runtime behavior in the output of two compilers, then that _could_
> >     manifest only in the sha256 code. Or as you get into more
> >     properties, they may overlap in other ways. I think reftable+sha256
> >     is an interesting (eventual) combo to test on top of reftable+sha1.
> 
> We could consider permuting, then?  If we (for the sake of
> simplicity) had two jobs available, one compiled with GCC and the
> other compiled with clang, we can enumerate other properties
> (e.g. <SHA-1 vs SHA-256>, <reftable vs reffiles>) into pairs, and in
> one run, GCC may be running SHA-1+reffiles while clang is running
> SHA-256+reftable, and in another run, GCC may be running
> SHA-256+reffiles, etc. --- eventually we cover all four combinations
> (admittedly for different commits).

That's a neat idea to get eventual coverage. I have a feeling it would
be a pain in practice, though, because now the CI results aren't quite
deterministic. So if commit X introduces a bug in some combination, we
might not find out until later, and seeing that X passed all tests
doesn't absolve it of responsibility anymore.

Likewise, I often have to re-run CI to get more data, or to see if a
failure is a flake. If it changed what it ran that would be confusing
(though I guess you could use the commit hash as the random "seed" for
deciding which permutation to run).

-Peff
