Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48C1DEFE5
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174238; cv=none; b=aYQXIKg04ycrLI6FL1P+2c/E/HF4lnQMlBLXLc0cJOLLJ/Lr3yNJJQMKL8d/snkceVOZ+Q2KmiQVj2Jbii0h0U7Ep+p6+rG6u0S42TbLb++6JOpGyeImGq86EButIX1rMlSSMUQscJdQU1xqDpqEms9v+mmI76d9k00F0waqEXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174238; c=relaxed/simple;
	bh=blaEIhgvnu45LO1dPGNsSYEiyAkLAd3ktvqzmrC09lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1bNcR9LcllYmQxE1DtzemNsnzmBQ4zGqgLQG2i5sgB6mn9ww0O7JdkbzqlFTdp/qypCtG2AldAAGh4nM1suXEe/8TTWe+I22SrgdhfPvhiCK8My+MAEwc8LV1D+lL6LCwb3VzmGnrCb8clYZ5uuxROI8d93LnFcBX6i6lhzo1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gqTbL/IH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gqTbL/IH"
Received: (qmail 16855 invoked by uid 109); 2 Dec 2024 21:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=blaEIhgvnu45LO1dPGNsSYEiyAkLAd3ktvqzmrC09lw=; b=gqTbL/IHB6KmAqCD/okkTrFqUJaeFIg966sWWz3vYXQ6A/XYe83ZRARxHWLjQSBVfMp+DF9HVkF7o3qmB5ZOhxTOZyn2mBERYsDHVjaASP1pDw0R3hUPQz/O31VbdfMyAWsbBGIcNVnwvUnxQMWwMMHsalOwQZAWAcPyWOoM6I8IDvEFeDjnK84eTgG3kmrCTSDEdY3ZhLXt2OLvBW9etfhuiuImeSZUzn98ffoLCY4xuVfMVJQFAlKLCvkiC/tRn5xUl5sdavbKa3AgkWprpCOJBucy2v5TSSdK19NM0kzFP7ZaRadl9cqwlfqlxPamZheJUE9cXYBlWnvbY5v8PA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 02 Dec 2024 21:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26578 invoked by uid 111); 2 Dec 2024 21:17:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2024 16:17:15 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 2 Dec 2024 16:17:15 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH v2] builtin/clone: teach git-clone(1) the --revision=
 option
Message-ID: <20241202211715.GA787456@coredump.intra.peff.net>
References: <20241129-toon-clone-refs-v2-1-dca4c19a3510@iotcl.com>
 <Z02_YwCgHp_MVj3M@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z02_YwCgHp_MVj3M@pks.im>

On Mon, Dec 02, 2024 at 03:08:35PM +0100, Patrick Steinhardt wrote:

> > Add option `--revision` to git-clone(1). This option accepts a fully
> > qualified reference, or a raw commit hash. This enables the user to
> > clone and checkout any revision they want. `--revision` can be used in
> 
> s/checkout/check out/
> 
> Does this have to be a raw commit hash, or do we also accept an
> arbitrary committish like a tag that peels down to a commit?

I don't think anything except a raw hash will be possible without a
protocol extension. upload-pack accepts only a full object id on its
"want" lines, so the client needs to either start with one, or start
with a refname that it can convert to one from the advertisement.

(There's also the "want-ref" extension, but it only takes full
refnames).

-Peff
