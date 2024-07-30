Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE918CBE5
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370431; cv=none; b=DrKZR5kymdQQnvrE9dT8pJb40eyEiLJTRarGF8avuGGYVmZ64RuvBH4/m0ctknoECCVDNKGGf6Z73bDnCsDqI5z24aEEgr/VO+j86dMjMAwU0zCLEpzTdFdNICLqC921rQIVJwqjNAfXgovUfOLZSNrG1fiSehgaKm8lsS6Kbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370431; c=relaxed/simple;
	bh=Yk9OqRKyGUJPr+hTOo3sOnFW9UixlHFrElIM8DGJJa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVZpp9d54xdwCx1JWL9WH3f3xgADNYRoL7keZATNF5ToUGaoTjnAuYj3y+6JpYqmTADGr4/tnBnzFTm5HdcbIAFcVoPnT4RHU3sejPoWV4y4DKQDGSvckiercooqnwCC+ZpE+IOzeRLd6yeWu9jK10SlTaWh94QCUIZCB0q4e/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 32614 invoked by uid 109); 30 Jul 2024 20:13:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jul 2024 20:13:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13998 invoked by uid 111); 30 Jul 2024 20:13:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jul 2024 16:13:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jul 2024 16:13:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: safe.directory: preliminary clean-up
Message-ID: <20240730201347.GC567852@coredump.intra.peff.net>
References: <20240723021900.388020-1-gitster@pobox.com>
 <20240720220915.2933266-1-gitster@pobox.com>
 <20240730011004.4030246-1-gitster@pobox.com>
 <20240730011004.4030246-3-gitster@pobox.com>
 <20240730074307.GB562212@coredump.intra.peff.net>
 <xmqqv80metou.fsf@gitster.g>
 <xmqq5xsmdarv.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xsmdarv.fsf_-_@gitster.g>

On Tue, Jul 30, 2024 at 10:56:04AM -0700, Junio C Hamano wrote:

> One wrong assumption was that the function might yield NULL when
> there is no interpolation.  This led to the use of an extra "check"
> variable, conditionally holding either the interpolated or the
> original string.  The assumption was with us since 8959555c
> (setup_git_directory(): add an owner check for the top-level
> directory, 2022-03-02) originally introduced the safe.directory
> feature.
> 
> Another wrong assumption was that the function might yield the same
> pointer as the input when there is no interpolation.  This led to a
> conditional free'ing of the interpolated copy, that the conditional
> never skipped, as we always received an allocated string.

Yup. Good eyes on seeing that second one. Both look correct to me from
double-checking git_config_pathname(), and the patch itself looks good.

-Peff
