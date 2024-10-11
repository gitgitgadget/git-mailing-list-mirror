Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B891F4705
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635922; cv=none; b=otbXW1J0rq1uRTn7ci0mo3aDJyoMGyqYBdi2/+DhYCS/V6zxohekNf+zGBYElO++YdEx7Dstr0AfPmXIkItXBF+eJA6KiSqAmNjLcebhRZdJeNhwZ+83p9NRKPTSVQu456u5ezh0YxPGtxK8T2TCwUKjhp78rJ/iePrelWhdBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635922; c=relaxed/simple;
	bh=hT8JlVItnSL/cILFTGpvpf0VnonuoGpBWGJCHz7gzko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liNIBcTOS6UHY62QAFcakfrJkXX5ac9tRVCyRkWXo/01OS7VaL0DInqlCbAidIXAvX2jII5+Jdh7dbS03vBxxVrxjiP0t0byKwPUXi7zXlIrt8u/lrUkBmCHf+TPXwnYUtzIGvVcEckmRSBqM5TXUubZHmvJRaw8MNNJJOcAaQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IlJnQKer; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IlJnQKer"
Received: (qmail 6009 invoked by uid 109); 11 Oct 2024 08:38:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hT8JlVItnSL/cILFTGpvpf0VnonuoGpBWGJCHz7gzko=; b=IlJnQKeryhA0zSpE0gJMCFKA6qhlVfaqtufbepL2w6XqR9jGYud+AtvDptOMtkwyJwiQe4rVObsgbaZecdBcXEB1jt7h/IKUEoCFeG0ULKz1RLBQANx9XjwKCZbns3SqfDe+SuV9YVW+HKLvpsog4jeWqsSU1kWNTkXuPgenYryaFqJvJ4CtpZQcuI1YP0Nuz3jdZnlQA9W3TfHtElbuZq3zQmPNkD/EnFBDvtEoIHlFkb5A2VAm/2OxEAXYcd9u7BqxuMb1IiZr2IfrIetNq7LHdTMohasE+XrvQJxnIdLViqm8ZIVkeHSw9o4Y5DkEHkEvro0CK4+DO2tqPCUSBg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 08:38:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17833 invoked by uid 111); 11 Oct 2024 08:38:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 04:38:39 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 04:38:38 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <20241011083838.GI18010@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1728505840.git.me@ttaylorr.com>

On Wed, Oct 09, 2024 at 04:30:52PM -0400, Taylor Blau wrote:

> The first optimization (cross-pack deltas) should help clones and
> fetches, but the second optimization (thin deltas) will only help
> fetches, since the 'haves' bitmap will necessarily be empty for
> clones.
> 
> Of course, REF_DELTAs have a less compact representation than
> OFS_DELTAs, so the resulting packs will trade off some CPU time for a
> slightly larger pack. But we're only talking about a handful of extra
> bytes, and network bandwidth is pretty cheap, so I think the
> optimization is worthwhile here too.

It would be nice to see some numbers, even simulated ones from t/perf.
Of course we'd like to show off any reduced server CPU for generating a
fetch response. But I'd also like to see if the extra steps to find the
cross-pack bases have any measurable negative effect (so the ideal there
would be a big midx repo that doesn't have a lot of those bases, as it
would not be helped much by the optimization and would be hurt by the
time spent trying to apply it).

-Peff
