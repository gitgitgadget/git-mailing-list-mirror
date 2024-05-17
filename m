Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFE2BCFD
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933953; cv=none; b=BpDA37YGbE+rJWsKIicNHyatU7rj97VEEItti4jVMQ/Fw7ojk8CTH18MK1L41Feg1QtKjA6Ajzq0nrFnDmI0yTG1TI75k3+XLebDiW9tYmzWLxiXm6EL5K/fp7uhXOt9iWZp9c8QBIJsLuHItb6ITyInCb7aa4LgRkJTEWp5UyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933953; c=relaxed/simple;
	bh=S171QELT4VD7eBu9cYDh1NnZFNI1iUpADq1FhJhxaec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1T9GvCu2lxmfOakoUhv1frjTOyxniy1UPQk3OAuK2/SWVlIezZNF2ZzFTyFFeJT6HfZCKk2qJHPmIuqd2uNSZKFnms1Gygeq/b+CE967DN58KdPYPEQxoT6IoQxSN/2IWprvMKZQe/6DBjgym5IxgbdRG32SmyTgGGfIKQlR+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7414 invoked by uid 109); 17 May 2024 08:19:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 May 2024 08:19:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22980 invoked by uid 111); 17 May 2024 08:19:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 May 2024 04:19:14 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 May 2024 04:19:09 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <20240517081909.GB1517321@coredump.intra.peff.net>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
 <20240510220228.GA1962678@coredump.intra.peff.net>
 <xmqqseyp1dys.fsf@gitster.g>
 <Zj-pGGGJEXlH02nR@framework>
 <20240516071930.GB83658@coredump.intra.peff.net>
 <ZkXX5MlN3EbaMhNG@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkXX5MlN3EbaMhNG@tanuki>

On Thu, May 16, 2024 at 11:54:44AM +0200, Patrick Steinhardt wrote:

> That's certainly the biggest part, yeah. But I have been hitting lots of
> compiler-dependent behaviour. This is mostly in the area of bugs though,
> where for example toolchain A may initialize variables on the stack to
> all zeroes while toolchain B does not.

I've definitely run into differing runtime outcomes for undefined
behavior stuff like that. But in my experience most of that is
consistently found by ASan/UBSan (which we do run in CI these days).

It's possible there are cases that those sanitizers don't catch but that
cause differing behavior. But I can't think of one off the top of my
head where that has happened.

> I'm not sure whether this is sufficient reason on its own to warrant
> testing with several toolchains. But we can easily combine this with
> additional tuning knobs. Two separate test jobs with GCC and Clang are
> comparatively boring. But if we make it GCC+SHA1 and Clang+SHA256 then
> it becomes more interesting.

Yeah. Combining orthogonal properties into a single job lets us cover
both (for the common case of success on both) with less CPU. But:

  - it can sometimes be hard to figure out which of the properties was
    responsible for a failure. That was the very subject of the thread I
    referenced earlier, where "linux-gcc" was "use gcc" and also "set
    lots of knobs".

  - they might not actually be orthogonal. If you care about checking
    runtime behavior in the output of two compilers, then that _could_
    manifest only in the sha256 code. Or as you get into more
    properties, they may overlap in other ways. I think reftable+sha256
    is an interesting (eventual) combo to test on top of reftable+sha1.

-Peff
