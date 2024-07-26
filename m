Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8493C30
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721979542; cv=none; b=iwe+hhPRs/UtnhFEPsft1Laf3vhny5S/3XVQ5gBzIBUSulOsSROp5OYamuCv26MGN42LJ/Lw5msDr6eWWnDTKSg+Jbb0NOFYPMTv49BA4M5cUECMQhoHlMo10L4YhMOvBi2JkHy0Kct3UCIrh/tiOG7GlDMWh6MMXDMHLUV2zsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721979542; c=relaxed/simple;
	bh=InLsMnzrYt1f2bKFhUBwaHbA5ABIHiT3WGyGWrRNMlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOxFBw3ojqYP25OZv4lKpJHpVi6l4QKGTFAGn9+pSxn5rqAsBv/BjOAsmS+rrfwBjfXJJG/qC7fq86NTu0YzRmv7Kj4UZpB1+jQLJqvrhwDyz9mvbx27Y2JBVtCCqtOv5ZdxAEq8QgG43f0RxHziCcS9ZRs6uFpyMbq9o9e9pLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=XOqOrCmb; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="XOqOrCmb"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9250A1F572;
	Fri, 26 Jul 2024 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1721979013;
	bh=InLsMnzrYt1f2bKFhUBwaHbA5ABIHiT3WGyGWrRNMlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOqOrCmbrkmLLsi9VJy2eXvBrGwAHyXunwvSpFLJTvg+x116kCcUOA4NN8YheG+ML
	 0650jmXwJ6BediL3xSjNKyRmjQPmSaOWdyk56sPUmLR6eetSkThXzr1/Hya+frkCRD
	 ZNAsjMHlb40FidzZ3bOd+Pn4Xv6NiTrIo/TVog/I=
Date: Fri, 26 Jul 2024 07:30:13 +0000
From: Eric Wong <e@80x24.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 02/10] packfile: allow content-limit for cat-file
Message-ID: <20240726073013.M358835@dcvr>
References: <20240715003519.2671385-1-e@80x24.org>
 <20240715003519.2671385-3-e@80x24.org>
 <ZqC85Z5QzfdvpOpX@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqC85Z5QzfdvpOpX@tanuki>

Patrick Steinhardt <ps@pks.im> wrote:
> On Mon, Jul 15, 2024 at 12:35:11AM +0000, Eric Wong wrote:
> > From: Jeff King <peff@peff.net>
> > 
> > This avoids unnecessary round trips to the object store to speed
> 
> Same comment regarding "this". Despite not being self-contained, I also
> think that the commit message could do a better job of explaining what
> the problem is that you're fixing in the first place. Right now, I'm
> left second-guessing what the idea is that this patch has to make
> git-cat-file(1) faster.

I was hoping Jeff would flesh out the commit messages for the
changes he authored.  I'll take a closer look and update the
messages if he's too busy.

> > up cat-file contents retrievals.  The majority of packed objects
> > don't benefit from the streaming interface at all and we end up
> > having to load them in core anyways to satisfy our streaming
> > API.
> > 
> > This drops the runtime of
> > `git cat-file --batch-all-objects --unordered --batch' from
> > ~7.1s to ~6.1s on Jeff's machine.
> 
> It would be nice to get some more context here for the benchmark. Most
> importantly, what kind of repository did this run in? Otherwise it is
> going to be next to impossible to get remotely comparable results.

Oops, that was for git.git
<https://lore.kernel.org/git/20240621062915.GA2105230@coredump.intra.peff.net/>
