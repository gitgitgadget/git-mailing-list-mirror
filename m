Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059CFC2F2
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310773; cv=none; b=tKXqMrVvshgQ5/K+RmRBc2OJC1I0ptts38kabK1MYHYg+3p599FG0a9ZhjzDHBN2gajA3g94KylkiZDh5Sy9I0Lu+dmeuyRHxa+8kiaY86UDCSUNfepp97aunA0eulP0Gv96pe6XjLI/olYY3nTUVgKbISoP70pniUwywY/8Ls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310773; c=relaxed/simple;
	bh=F2vt3jAWqvCj1Zxe4zmnMHFVieZ0MqYvV0wGoF/KEVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkgUjDsWKQPwLUPJjmqEEUkys9QCyZZlE/Y1QgIw/zuq/oQu4ynpZAhayhB8vqh/1DSHVRoviQpGb6hQRpZP83oSUHm+UuSm+BR7k8x2CV30f+QMMYFuP5ObOYl0+abT0zxHKC7ucjehMChY38QC2Uyx1q7Zipglmu42b/x2sLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ql29kqO/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ql29kqO/"
Received: (qmail 8028 invoked by uid 109); 27 Dec 2024 14:46:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F2vt3jAWqvCj1Zxe4zmnMHFVieZ0MqYvV0wGoF/KEVo=; b=Ql29kqO/Hkxuq+GuvnsISe+1OBLj7HcHnB7kScOLVG9r6wT5YFLNPqTiI/0CP+8GYDpHFQ7SAQ8NZmyPIRoa9XWrvwuE21WtOKTCSFmhRZDO9bWHhrTCCvJHdwerLY/aN+Yc8wM5fmKZM9LWyNOXgC3kMWVbpeN4nVDANzmoir3UxEy3opx3K7sonPOjOFFH7DUsfOwJ737p25Ck/Z8V/hoGX9jLtfJHeODkCDTo5u8P7nM/PpVALJp7Ytwd41kywXMISZD1x69CQdeiNrfhyCj0G4tfiLojRr12p+J/hDne/UFxOZMb5H/bPwrN6bC34fY39bgd2hTqm9twi28uDQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Dec 2024 14:46:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14568 invoked by uid 111); 27 Dec 2024 14:46:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Dec 2024 09:46:10 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Dec 2024 09:46:10 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-reach: fix index used to loop through
 unsigned integer
Message-ID: <20241227144610.GD88306@coredump.intra.peff.net>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-2-07c59c2aa632@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241227-b4-pks-commit-reach-sign-compare-v1-2-07c59c2aa632@pks.im>

On Fri, Dec 27, 2024 at 11:46:22AM +0100, Patrick Steinhardt wrote:

> In 62e745ced2 (prio-queue: use size_t rather than int for size,
> 2024-12-20), we refactored `struct prio_queue` to track the number of
> contained entries via a `size_t`. While the refactoring adapted one of
> the users of that variable, it forgot to also adapt "commit-reach.c"
> accordingly. This was missed because that file has -Wsign-conversion
> disabled.

Yes, that's exactly what happened (I used a merge of my series and your
-Wsign-compare one and relied on the compiler).

I grepped through for other instances and couldn't find any problems.
Many places just do:

  while (queue->nr)
     ...remove top...

which is fine with either type (which might explain why the problem
wasn't more common).

I thought there was one more instance in commit-graph.c, which looks at
"info->commits->nr", and I was grepping for "commits->nr" since
rev_info->commits is a prio_queue. But it is actually a totally
different type, compute_generation_info, and "commits" there is a
packed_commit_list.

That data type _also_ has the same int/size_t problem. ;) But it is
totally separate, so it can happen later in its own patch (and there are
a ton of other -Wsign-compare warnings in that file).

Thanks for cleaning up after me.

-Peff
