Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED465C60F
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709711494; cv=none; b=gOerk9Cz7NNSBNMSbWwS959incVKm5mKBIJAKusSaStt2XZzvtu48nbNClBcOt6gZc8utpYboZL/KPahUceiuz/PCTaNqckQ1FT1SPv/iglVVz3zKTNCgCfHQUdZlBRfLNz+mhQzUMdmY6RJsiU1SgLYPZWKr17dEl0GY3qoWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709711494; c=relaxed/simple;
	bh=UjWpogOaQK9C/aiXps2Q2RfbP3ePYAvVNRoF9C+AHyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxSFacwb+4KRQarvWAnKh2rc5Mb7W2QrjGdKmy6v4R1TtcrYLsE8G7RLQujZhGhp5zRpKQiuAmQc38zGg29aYodm2n+dxyCCuZwGrk9ZGPF6z7Fsy5ZnG+wLTD9rb84GU3lBZY504FJKdF0nRtkrN2nkfRznqAUzkhYSSk25n/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26577 invoked by uid 109); 6 Mar 2024 07:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Mar 2024 07:51:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 547 invoked by uid 111); 6 Mar 2024 07:51:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Mar 2024 02:51:33 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Mar 2024 02:51:28 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] show-ref: add --unresolved option
Message-ID: <20240306075128.GA4099518@coredump.intra.peff.net>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <20240306004139.GB3797463@coredump.intra.peff.net>
 <Zegbw2i-PGfvb5q_@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zegbw2i-PGfvb5q_@tanuki>

On Wed, Mar 06, 2024 at 08:31:15AM +0100, Patrick Steinhardt wrote:

> Yeah, the proposed patch basically aims to do the above chained command
> in an easier way. I think that this would be a nice addition to make
> this easier to use and better discoverable. But in the long run what I
> think would be really useful is to extend git-for-each-ref(1) and/or
> git-show-ref(1) so that they can print all existing refs with their
> direct values. Right now, it's impossible to get a globally consistent
> view of all refs in the refdb with their unresolved values.

Yeah, it seems like if this were a format-specifier for for-each-ref it
would be a lot more flexible.

You can do:

  git for-each-ref --format='%(refname) %(objectname) %(symref)'

to get the resolved values next to the symrefs (if any). I think that
does a full resolution, though (so again, if you had one->two->three,
you can never learn about the intermediate "two").

> That will end up a bit more involved though. The ref iterators we have
> right now do not provide any way to return symref targets to the caller,
> so we would have to first extend the interfaces and adapt both backends
> to support this. But this is kind of where I want to end up.

I think for-each-ref in the above command works by calling
resolve_refdup() itself, and then recording the result. It would be nice
to get it from the iterator, though (more efficient, and avoids any
races).

-Peff
