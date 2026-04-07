Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819723EAB7
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775535987; cv=none; b=YChxtsz4O4j8YdkhbzWpDeqduYvVeWsn7JMH5j3LUCthK10DMdkTLg/ct+sITVO5lEBFBauMfn7YeR195bgqSVjMlTHCuR/jNfHAyPNT4mL0koD0ZnSWkJfd+9KWhNDloWHCEvPrLtzosVw3IN6qyLYM0zjlneM1c+L/WUD87/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775535987; c=relaxed/simple;
	bh=S8jkBWzFanKponJNFwvEHE8kqMduyhWViif/8OeYjS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETxQUqt3joo9/KaW6IS4yOp67Nf1xMJk25JvopWO6QAijCFY6nj3Wv83LcaCBkC0Fqe1kLTgVSRWjGqHfv1/ck1087c+iRE0h85/0Z3FjJgy3Mmmb8C/FNT7be/US818z4jHMYp3i4KewJVxREj73fGIWIWYUsTe3Nv8leL2zoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hrYa/BCO; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hrYa/BCO"
Received: (qmail 268834 invoked by uid 106); 7 Apr 2026 04:26:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S8jkBWzFanKponJNFwvEHE8kqMduyhWViif/8OeYjS0=; b=hrYa/BCOel5vhBdsqw5a+40xEwCVvfDCcSV9NZ8NmlMd/U6KMnaNgshT1WKQl99UX9WG1lT2BDCSMm6PomY84rIfh2CbZd8yFPiPBVfY/uHW6/A9ho9dmMsnMvqRZp7yj9wc9tAYLqeLZSO2qgfkDLFQW3j/S+mJOfi8KU5oc7DhtwhLCrWPoXXnsUPFpLDMj49gXOidPtaIOJZCJ0snGRteKb2TTkyczgA2NkS0CCtZGrAuHuvNjqWEkhtRVtt/J9OdfcLvTAozkrZW/i5GQyd6flDdn4xwEY9UZuTJLsQgeBopdy4ijqhr0G0YsIf+kD/4pnr80MhPtDUKMDgmSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 04:26:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 440644 invoked by uid 111); 7 Apr 2026 04:26:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 00:26:24 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 00:26:24 -0400
From: Jeff King <peff@peff.net>
To: "Raymond E. Pasco" <ray@ameretat.dev>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [WIP PATCH] fast-export: emit deletions first
Message-ID: <20260407042624.GB627864@coredump.intra.peff.net>
References: <20260406063607.15353-1-ray@ameretat.dev>
 <xmqqo6jwau34.fsf@gitster.g>
 <k3qg4jodn425cjvorvdl4j24ik7c4jwmwudwsowe4doth7devn@f5xbrskansmj>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <k3qg4jodn425cjvorvdl4j24ik7c4jwmwudwsowe4doth7devn@f5xbrskansmj>

On Mon, Apr 06, 2026 at 09:12:19PM -0400, Raymond E. Pasco wrote:

> On 26/04/06 10:15AM, Junio C Hamano wrote:
> > In any case, it is a bit surprising that fast-export survived this
> > long without having encountering the problem you are solving.  I
> > wonder if fast-import handles such an output with some smart to
> > avoid the issue?
> 
> I was surprised too. The case where this was encountered was a repo
> that had a directory symlink, and promoted it to a real directory,
> but the symlink turned out to be a red herring, it's purely path
> prefixes.

That's the original case from 2015, too. Which I guess is not too
surprising, since it's probably a more common conversion than a true
directory-into-file. There was a patch with a test provided in one of
the threads I linked earlier, in case that helps, but it is pretty easy
to write a new one.

-Peff
