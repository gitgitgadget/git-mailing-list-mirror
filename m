Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98BE239E63
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934666; cv=none; b=bOW+0I8YDPofAmOkhpjHYxYLZmoLEl0OIWxSk8+HatfeAOoWH0MDT3JfshFBpVBRT2cfMcO+MnS76v6Qv7DlbEY0BBmz3S++1QgjoW46MaBwJP1INWsMop+48NgaXtvYI6f4HxiNt+qS7ckievy0irmckpzKt5GwAiwzMC82NzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934666; c=relaxed/simple;
	bh=RHjoKD2dlEd0U0yXutkibU2DZJtHg7SLR1dRi++wYVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcXNNbDB7RWNStD885B0m5/1/02nps9uklq3BGE4+2VjlwU5Qmz+KYovU6nHheOCpGu93UeqOCVUR+FzmByKajQv6p+BZaS5J66qKgxssjoPvncqHBYExKmMFmni0sEtMAjJxoPZ28MhhXzvXiiO4jsJDTpP8Ie3RXbiHsZED7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HfwtTV/P; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HfwtTV/P"
Received: (qmail 317925 invoked by uid 106); 11 Apr 2026 19:11:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=RHjoKD2dlEd0U0yXutkibU2DZJtHg7SLR1dRi++wYVc=; b=HfwtTV/PcoiDgnAldne74uiOELVL/0captva5is4zNnfZKRWCatEhC3vZf0HcSfd8Ua3ST2W4dXpdVqXVgAZC9tI2uHoWHNQUq1Vno3EDzJ1pWKiZi02F+NhnbaqqNwxucrdO80fyV2sFQzgVrOC2aJAJQzzUYDg2b8ejw4+3V5dlFsdeBA8z3HDWgvKnFRRilJmM2qxnRqjIlkoRM6Al2y88h1crz3JA5lIOvbZPMaR2pnoygRck3LOdARkZiDxC64x0lcXRaES1wsClBtL+P6Mi9oZfPgzz7dJYNct8iy0NVM1WtlFApwFbIHG/ukiKM50qXqNRqaOCJFFomJfoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Apr 2026 19:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 525236 invoked by uid 111); 11 Apr 2026 19:11:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Apr 2026 15:11:03 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 11 Apr 2026 15:11:03 -0400
From: Jeff King <peff@peff.net>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitgitgadget@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Message-ID: <20260411191103.GA774963@coredump.intra.peff.net>
References: <20260411183823.GA672575@coredump.intra.peff.net>
 <20260411185109.37795-1-haraldnordgren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260411185109.37795-1-haraldnordgren@gmail.com>

On Sat, Apr 11, 2026 at 08:51:09PM +0200, Harald Nordgren wrote:

> > This tries to create a root-level ref called CHECKOUT_AUTOSTASH, which
> > violates the syntax rules given in gitglossary's "ref" entry:
> > 
> >   Ref names must either start with refs/ or be located in the root of
> >   the hierarchy. For the latter, their name must follow these rules:
> > 
> >     •   The name consists of only upper-case characters or underscores.
> > 
> >     •   The name ends with "_HEAD" or is equal to "HEAD".
> 
> 
> So maybe easiest is just to rename it to CHECKOUT_AUTOSTASH_HEAD?

Yeah, that is syntactically valid, if a mouthful. I can't offhand think
of a shorter variant.

-Peff
