Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F333331A49
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510980; cv=none; b=QdrDUIJ+GGA9gn0Lb+q6LZxb7z+5dMIpoZAFazZxFTzaN0Vtix6WfTQr4d+1TmGE1T7BN+0J4oF9ClZK10qWdQMVUK9YgcWhTg7rZU+MBTDcqh8gkDkn0tLNCbUNmgPCTPEku/i2t8Fc1b5Fphy1DKV7CYEyYZKFFkxKTCpf0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510980; c=relaxed/simple;
	bh=uwLKA4/iwUBsZM4hFZUShgYFQOwgtzgQ3ajT+TYpI5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSaM1wUslBuIoWQl1WlvFLyDhdcAqp/XNxb33IWrzvhn8ZyN2kX1N00YeZqBiEwH+AeSYaNnL98KRVsMd40bBcRhhN/raMh7H85D6I160sh6wWmPJTgBrcLBvs4i/6WHmT/y/kEmHEuipzc1CE7F53lMggbiWdZu5fDIRraZLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QI07BXMU; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QI07BXMU"
Received: (qmail 265871 invoked by uid 106); 6 Apr 2026 21:29:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uwLKA4/iwUBsZM4hFZUShgYFQOwgtzgQ3ajT+TYpI5g=; b=QI07BXMUYRtWEdU9ZDXvmvRQ2YD5Q28ndPqZT7rWbKA2k8HJBog3Mm7TdzRhw+R56c9uipzl/LHotzh14gVSmNoWOhP97msxMq7myR95MYdiEPOGoonTIB8fmTKtS2VYx23jOjM7QnogiCjVuwxxDhoD5TMUWE+QVoCXRkW6gbCD41d9O6iTBqANK7/Qbh3STNikhUn9cfgIIsCicYLDgnwcMB7zgVvmJCMl9MfZoQU5041nAZQxYNAOBDYiyLy8wwNVFvFKt5yDvLUChBcPL8nTJnShHctyf1v3X7CnX6F11+SBgu5jwxG/V9HQlrEX0LAlJ9IJOocSdyCpntrGFQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Apr 2026 21:29:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 435603 invoked by uid 111); 6 Apr 2026 21:29:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Apr 2026 17:29:37 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Apr 2026 17:29:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>, "Raymond E. Pasco" <ray@ameretat.dev>,
	git@vger.kernel.org
Subject: Re: [WIP PATCH] fast-export: emit deletions first
Message-ID: <20260406212937.GA30202@coredump.intra.peff.net>
References: <20260406063607.15353-1-ray@ameretat.dev>
 <xmqqo6jwau34.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6jwau34.fsf@gitster.g>

On Mon, Apr 06, 2026 at 10:15:27AM -0700, Junio C Hamano wrote:

> In any case, it is a bit surprising that fast-export survived this
> long without having encountering the problem you are solving.  I
> wonder if fast-import handles such an output with some smart to
> avoid the issue?

I think it has come up a few times, but we never actually applied a fix:

  2015: https://lore.kernel.org/git/alpine.DEB.2.10.1508191532330.31851@buzzword-bingo.mit.edu/
  2017: https://lore.kernel.org/git/1493079137-1838-1-git-send-email-miguel.torroja@gmail.com/
  2023: https://lore.kernel.org/git/BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov/

Looks like discussion got hung up on ordering other types of
modifications, like renames (which can actually have cycles). But I
don't see anything to contradict the view that putting deletions first
solves real problems and would not harm anything. And the answer to "it
hurts to fast-export with renames" is probably "don't do it".

It's also possible that sorting should be the responsibility of the
receiver. I.e., should fast-import see:

  M 100644 :blob_label a/b
  D a

and figure it out? Or maybe we want both (to help other consumers of
fast-export, but also to help fast-import when consuming output of other
sources).

-Peff
