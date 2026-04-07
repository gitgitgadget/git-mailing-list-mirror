Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D23BDDA9
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 04:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775535877; cv=none; b=I+QclzdU2L4jvRW575bDOW/049xtyHST4uaetquR26FnEyX4GTQZImyI4B3NFLnVcS/SZfA22mfiUaB4bRZeguh/tVYBD+t/+iuiGACu0miv5f+Jk8IUCvm963qm4nBiWbRdWEoc8dSHc85dzC+AZ6mR4HWQmid35CPiVI4lwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775535877; c=relaxed/simple;
	bh=KwvJ+8y8dIF1PDEJazbnzam1n+TwvFV5lZu2BaK8uC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/lDQufdnSus38MGnJQ4qPkFvJ+47aB9s6xasnnHFqa2gNsH0Pc3+JI7QAlrNbuhb0bKj0UjAgdqMXFoEqbzu4mewbGWo5tipaAb/9AwPsaUpUpK5YPJXMeGJRU4fji05Du4nr1Zcaej/Dofi7WhrNbQjCMVmFfRBKP+Uwt4iMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OFFfjtZV; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OFFfjtZV"
Received: (qmail 268812 invoked by uid 106); 7 Apr 2026 04:24:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KwvJ+8y8dIF1PDEJazbnzam1n+TwvFV5lZu2BaK8uC4=; b=OFFfjtZVzQpCEzh/ipsgijsm5ZUUvv5Yq0ylDN3ELPkYq3Je8zEaW51FV8Ywp2r08/Lonliq5z9h+His1XAF08jJU50dc4q4b5+DgYbmNIV1bCmcmGrCtgeeJuJTh3yF6Fdg+RPK3eRl25VFzMUm7QAPMuGpGdITXO+1gdHcN7XyZbIJ2vRiGy6WYEW+ByuEE6p59+sn3AcSOJpp8xKpJo2B4Z/3DYo0m4D1SQWglo/QjqqYhzmt57/uSIVGrPBTOwLpQ6dbo3UBZcfd3xg5NlCS0gAD0imSY4B4DKLRQMrH1Gz4GAl2GiGPrrh91c+kaqczJLbWB9XFz1y4SkRf2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 04:24:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 440608 invoked by uid 111); 7 Apr 2026 04:24:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 00:24:33 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 00:24:32 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org
Subject: Re: [WIP PATCH] fast-export: emit deletions first
Message-ID: <20260407042432.GA627864@coredump.intra.peff.net>
References: <20260406063607.15353-1-ray@ameretat.dev>
 <xmqqo6jwau34.fsf@gitster.g>
 <20260406212937.GA30202@coredump.intra.peff.net>
 <CABPp-BHhXQc-s8rF1n+AQ0VodX2KuiahcAOcg2msR1eZrUSsCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHhXQc-s8rF1n+AQ0VodX2KuiahcAOcg2msR1eZrUSsCA@mail.gmail.com>

On Mon, Apr 06, 2026 at 02:44:05PM -0700, Elijah Newren wrote:

> > It's also possible that sorting should be the responsibility of the
> > receiver. I.e., should fast-import see:
> >
> >   M 100644 :blob_label a/b
> >   D a
> >
> > and figure it out? Or maybe we want both (to help other consumers of
> > fast-export, but also to help fast-import when consuming output of other
> > sources).
> 
> Would re-ordering on fast-import's side introduce bugs or violate
> user's assumptions?  Right now, fast-import has no check to prevent
> more than one command for the same pathname being given, and has a
> last-entry-wins ruling.  Thus filemodify PATH followed by filedelete
> PATH gives different results than reversing the order.  Most probably
> wouldn't care or want to ever do that, but I could see it as a way of
> allowing you to change your mind in the stream and override an earlier
> directive you sent.

Hmm, good point. It probably is better to leave the reading side as-is,
then, to be on the safe side.

-Peff
