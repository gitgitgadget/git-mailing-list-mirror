Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DF7DA95
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735844796; cv=none; b=AUquxMFaxW5MoR27ZwryWSf6CMZgGD9Ci9lmsvoPECHkcywVS5zEV9Rx5YYRHpsi+naWYlFzLfJRL/6qzepVIKYaV6p1bcKSHoS8VOVvNzjXgaYibNPSv20VXosqcnYJ0jkRTROnBuTclsYGv/+maFCoSAxvx5TjT4K67Rsd2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735844796; c=relaxed/simple;
	bh=AVxMBS2STZvtPTl3tDfzqC5IJ2hC22RvUj4/J+DeNYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4X/EyA97y3Av8uVqNZ2C8QTMXMDthsEpDCfMKe8ueZ3DDPtO+l+qgNJV1SuaI5eQzjHoTx8JBkw3iJyiJNnFnNVsDgIUvKpvWhq+XMyD//SgSgD4cfOx14GBlHQR53FsCCw3s9rnq70Qv+XSDUM4yNn2qWI4vSVGaYl47aCsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ev+pdVv7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ev+pdVv7"
Received: (qmail 5373 invoked by uid 109); 2 Jan 2025 19:06:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AVxMBS2STZvtPTl3tDfzqC5IJ2hC22RvUj4/J+DeNYY=; b=ev+pdVv7UDuRsd7OPSL1iTWIBFRnDWPlD00rmE8SE2HWdguWGdVgeTe656oCqfkRbdqvlewTUkI0IDMNldQ3sxVviZZnyyAhVRH9iNsvl/Vv3Vg8lFFzcmlYk+DgaShw9zESq8yFiKx5LwpSfpq5/mKlisa4D0HEkzBGeCx9+CKDn6Mtne3U5/8BopFxDN0eFV+3CEst4JSy4LSV91tFFWkCDvPl7naU4x/rzxF10rHrJo/hVxO8W6CVb36B3nC7anbFC+Qb1QvIkCgSpWhXgs+TuW1/zBnZkojmC+v+Zdu+s7KjUi2S3OyCbCMiTwhvB5DMc0SC/+QweICGKNaVJg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jan 2025 19:06:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23017 invoked by uid 111); 2 Jan 2025 19:06:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jan 2025 14:06:23 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jan 2025 14:06:23 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: a less-invasive racy-leak fix, was Re: What's cooking in git.git
 (Dec 2024, #11; Mon, 30)
Message-ID: <20250102190623.GA848764@coredump.intra.peff.net>
References: <xmqqpll9xehr.fsf@gitster.g>
 <20250101191422.GC1391912@coredump.intra.peff.net>
 <xmqqa5cavz8h.fsf@gitster.g>
 <20250102023224.GA3853144@coredump.intra.peff.net>
 <xmqqzfk9uvjd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzfk9uvjd.fsf@gitster.g>

On Thu, Jan 02, 2025 at 06:42:30AM -0800, Junio C Hamano wrote:

> > I wonder if revert should have a "squash" mode that reverts all of the
> > commits (perhaps in reverse order of application in case they depend on
> > each other textually), and then gives you a commit message template
> > similar to git-fmt-merge-msg, where we list all of the commits, one per
> > line (though probably with their commit ids in this case).
> 
> I am not sure if I follow.  Should "revert HEAD~3..HEAD" give such
> concatenation of messages, something similar to what "rebase -i"
> gives us when seeing multiple "squash"es in a row?

I don't think we need to concatenate all of the individual revert
messages. I was thinking of producing something more like:

  <SUBJECT: DESCRIBE YOUR REVERT HERE>

  Revert the following commits:

     - 7a8d9efc26 (grep: work around LSan threading race with barrier, 2024-12-29)
     - 526c0a851b (index-pack: work around LSan threading race with barrier, 2024-12-29)
     - 7d0037b59a (thread-utils: introduce optional barrier type, 2024-12-29)

You could perhaps even auto-populate the subject with:

  Revert jk/lsan-race-with-barrier~3..jk/lsan-race-with-barrier

similar to how git-merge uses "Merge branch ...". But it's a little
clunky to read, and unlike merge, it's a lot easier to use names that
are not very meaningful (e.g., I checked out a new branch based on that
one and then used HEAD~3..HEAD, which is worthless to mention).

-Peff
