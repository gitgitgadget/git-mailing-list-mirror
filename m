Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63282349B05
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 16:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764778357; cv=none; b=BbgNjjAKqJnuM5rjP4lW0xH/y2i2ePbZcC1su1+SRdo89j8pfdVFsk62K9aCEPutgcAe7akeRLfCdfs7u/OtTHqGwHC7K1Hm+oaW06Uu3viBfn2AlZp+t8MCMUfp489nAFicKq03Td+akFBdIYVv3G209HrjJLwzIOM2pfrHZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764778357; c=relaxed/simple;
	bh=REvfS4T1rWrhRCQhvk1X3Vi05OVNY1ZFSfNknxFbEOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJclsqkpouzx+cr7Y/yYaMJq1F4Q6+qs1dvA9CvBasogx4VGGs/5iCMo3w5hygghRjnk7k4vwOlt96Gx0XTYPJq9D4kjLEJ8zrrtyUiBtRP/3jpnZvbly677JDgUph39QoOnoKH5VFHLRUQtUCafD7H34nkG15NkCLwDkO1FTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Mkiir/iN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Mkiir/iN"
Received: (qmail 241128 invoked by uid 109); 3 Dec 2025 16:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=REvfS4T1rWrhRCQhvk1X3Vi05OVNY1ZFSfNknxFbEOM=; b=Mkiir/iNKVuUPB9TzIIggq+CLStMhbs7p6rGj1T5Dy9LAWhF81X+MMm5sLoTjHwLMsBhhkqsf9gSRuWaAUW+6WPKK4IhVutq4s8boEK7GWTCoEQz4Iuy4Q3h37ue3y59qwDnxqczIUzTC+2c9zUziOi3n/phSlbPqmau8rAyvoVqkpCWPZGurCZkgarx6eFbl3oVs5u9iZnyJfI2WujruaFwtBuBHfVAsm1vipcaT9QEhG2C/TrptemBV6xcEjoKSf798m7QMcgHYeRCQ5uatwd5f5Nvoojbs88xxqVcPtP2R6t4ZGDTcMVJ4qwnk1U/y2jc/FWKEuEdDnwdkeCuPg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Dec 2025 16:12:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 307465 invoked by uid 111); 3 Dec 2025 16:12:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Dec 2025 11:12:35 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Dec 2025 11:12:33 -0500
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] banned.h: ban mktemp(3)
Message-ID: <20251203161233.GB44940@coredump.intra.peff.net>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
 <37a36748-f357-403e-9a98-21d0f8a8fb41@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37a36748-f357-403e-9a98-21d0f8a8fb41@web.de>

On Wed, Dec 03, 2025 at 11:53:06AM +0100, René Scharfe wrote:

> Older versions of mktemp(3) generate easily guessable file names.  The
> function checks if the generated name is used, which is unreliable, as
> a file with that name might then be created by some other process before
> we can do it ourselves.  The function was dropped from POSIX due to its
> security problems.  Forbid its use.

Great. I am happy to see this.

-Peff
