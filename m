Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C713D275
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473006; cv=none; b=SstcYYWrMTYGkUuKAbHg796hRk3uz18EnVFsEVtPXw4GAEsJN3lvv1zPEV1XKBnMKdz08pDuQuhQABki3IiVIp87Oi94rNE3TkuxmR9Vk/hsW67O/SY/o2E2BPaI10c0KMyburXmKA4I4RQWMjbRN+TaP7LBEPyGMTl62x0li3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473006; c=relaxed/simple;
	bh=PM1AOCpXkjltHmtEPS3o/Px2HbX/p/WRAYh8czReAQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGV/nw1RNsZ6OoBnOjrvDYCYbupRehmprOns6FZTByv/KfzPr53JOCAAi/yLRb/EVZymeFvpM+36ko6/HIge2R4jXBdQAcfd4YkJghgsO98jFh8VDiUj0ZQsURAp0Ot9+r1tsUaia92Did9femwmoMLw1HW5P8DgQ/bxxo8CGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3320 invoked by uid 109); 30 Apr 2024 10:30:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:30:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5557 invoked by uid 111); 30 Apr 2024 10:30:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:30:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:30:02 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <20240430103002.GD1279403@coredump.intra.peff.net>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com>
 <xmqq1q6rc44n.fsf@gitster.g>
 <20240426211529.GD13703@coredump.intra.peff.net>
 <b2977495-3b4a-4f2a-85dc-d0568f34f2e9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b2977495-3b4a-4f2a-85dc-d0568f34f2e9@gmail.com>

On Mon, Apr 29, 2024 at 10:32:58AM +0100, phillip.wood123@gmail.com wrote:

> On 26/04/2024 22:15, Jeff King wrote:
> > On Fri, Apr 26, 2024 at 12:31:36PM -0700, Junio C Hamano wrote:
> > 
> > But the more interesting one is a call to refname_is_safe(), added
> > recently by Phillip's 1dbe401563 (show-ref --verify: accept pseudorefs,
> > 2024-02-07). Looking at that commit, the intent was to allow pseudo-refs
> > by loosening the conditional that checked "HEAD" to allow "FOO_BAR" but
> > not "foobar" outside of "refs/". We enforce the all-caps pseudoref
> > syntax in is_refname_safe().
> > 
> > The proper API there is I think check_ref_format() with ALLOW_ONELEVEL.
> 
> ALLOW_ONELEVEL just disables the check that the refname contains a '/' and I
> think it is aimed at checking branch and tag names without a
> refs/{heads,tags} prefix. If we want to move away from using
> refname_is_safe() perhaps we could add an ALLOW_PSEUDOREF flag that only
> allows the name to contain '[A-Z_]' if there is no '/'.

Right, I think that was the original reason for ALLOW_ONELEVEL. But then
lots of callers ended up using it because it was the only way to allow
"HEAD" or "FETCH_HEAD" to work alongside regular refs.

See the series I posted elsewhere which adds a new flag to cover that
case.

-Peff
