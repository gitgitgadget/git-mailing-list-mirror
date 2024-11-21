Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC8158D79
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180716; cv=none; b=bg9fHl+z9bRa1gp5QeRstTkrxmw5E1BGz2p/F0Xw6XJiyPSZbg2giJGOf1adG6jFH1zdy0HHJ2qX3kPNQtAYvT84C5Vc6wce/1xb8pOyclMuZcjutlR4KPr+700s/4V2L/+Fx6mdma2z7l3zSlcTH+YGfLvM69YMYDdatFqjjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180716; c=relaxed/simple;
	bh=/N8gpOo3WEVNEsVJ5n4ImFsCV9w71VGlnEgDeDj/Oko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP1vPGT5ikdiapo+PTT6vuO2wSZGoWuOhQpXNN6yWFGgjTFi3VQAJu4q7G91JeMkhoXfuWuSG8zC5zmCThRwCdm52ptLrbLtWjmHaR8cm++scNLX1inQBl6qsPdbsJCUcTYE/FJWboBdz6DrwaPhpNn6Zlztb9xPvi/QAH/kRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Npoaxs4l; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Npoaxs4l"
Received: (qmail 30188 invoked by uid 109); 21 Nov 2024 09:18:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/N8gpOo3WEVNEsVJ5n4ImFsCV9w71VGlnEgDeDj/Oko=; b=Npoaxs4lA8B6dIVIpWlSQ9Ui898N20Q53kUaxmsRGOuS87jyyfFyhDc2rW3TMvBQdh4YPr5LkWgNI7BqprSmGpwLwj6jJVJVwfbGIHwBARiVb+wJlZeFE6P3CVl1woYiQZ8T2UDPBtklsCmO3ixNg2V/tVA/T9Ti8ls3c4fepJEB1lWGsDRZfDncx9DSGKL5zBUy/FwliIdw8ZnHm59yxzTxYz1fBygzIK7qE7LoeD6WlQotHoOuq6zPGj0JMa6s+7FJ7HB+s41UWanx7SB4kOGhqvE/CFqU/rJvPH4i5/rPoamz3rGJ2aDu2ODGS0SiuGkz4DxzjDJbbc0M5pAZtg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Nov 2024 09:18:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22591 invoked by uid 111); 21 Nov 2024 09:18:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Nov 2024 04:18:37 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Nov 2024 04:18:32 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/6] csum-file: store the hash algorithm as a struct field
Message-ID: <20241121091832.GC602681@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <380133a11421fe4ce8428d11be479d78923bc5cc.1732130001.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <380133a11421fe4ce8428d11be479d78923bc5cc.1732130001.git.me@ttaylorr.com>

On Wed, Nov 20, 2024 at 02:13:44PM -0500, Taylor Blau wrote:

> Throughout the hashfile API, we rely on a reference to 'the_hash_algo',
> and call its _usnafe function variants directly.

s/usnafe/unsafe/

> Prepare for a future change where we may use a different 'git_hash_algo'
> pointer (instead of just relying on 'the_hash_algo' throughout) by
> making the 'git_hash_algo' pointer a member of the 'hashfile' structure
> itself.

This makes sense in the context of your series, which will eventually
just hold the unsafe algo struct.

But I also think it is a good step in general, because it means that
rather than referring to the_hash_algo all over the place, we only do it
when initializing the hashfile struct. In the long run, that should take
a repository struct or a git_hash_algo pointer directly, and we'd want
to pass it just once to hashfd(), etc.

-Peff
