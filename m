Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDB319D071
	for <git@vger.kernel.org>; Fri, 15 May 2026 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778820426; cv=none; b=dbMb+Ez1iwNucvoRFbrxRSPHa3wl73i+GRQPLocjiPy7qf4pLllA6zFJdRRO6ZhLH1MG4zcQ7MfZelLoaFYSk+j10bMhYnh3nn6yyTZXkTzka0/tK58a1paA4fBTTVFx5tURjymt0RwCGMsCHwYFRhh1RQjnaO7fK2jdYarO3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778820426; c=relaxed/simple;
	bh=6TUXT09/Db3a0DvKw+rW8WW8zh6Qzl1AbJZuUlTAssg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJM7bQmQWoV4LWd1cN+Xcffpdfrk1l7sxpz86boDxAQ4RMoWCnCHRRf7dPSucw6yJSKq/Q6WAm3MAI70XIpFVg+a9/xtgqv4WsgrUzvyMtZvzXO+UcX+QtF+tg3y6X7Qu7E1QTj4BxGhkhh00ap7xnN+NAebGFrjj8DxzwCgKz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VDam/pdI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VDam/pdI"
Received: (qmail 52874 invoked by uid 106); 15 May 2026 04:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=6TUXT09/Db3a0DvKw+rW8WW8zh6Qzl1AbJZuUlTAssg=; b=VDam/pdIPFRCLqnQN2TKnnk54DC5iWmfeYb1RQ5HBupaqH3y8JRQt+/ho0O+iCXj+dITbXz0F9co6SXq7A5Uays5ZfRRHDRG0LXTesSDUisZYT3AgW2oBAQEo5ugA7Y5wlJAs2MW0AmKUxPuCBrPi2ckePeu9neg5YaEPHMB4gSdmybZR8HyWM8OfpN1rtYKQI2Bdj1YAMqjdQ+OOH9Ro3oKBZ39arNh/l65CxBHrpVd2IS49/DLnt2I/9IocROdgozZt29WzzN6ZilXkIxhQ5s/Q3QJepTx1uWxFt8u6BaJcXSBDgS4sFSF9AXsFu0GtflcY6GQRvMObxrD52j2mA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 15 May 2026 04:47:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 96873 invoked by uid 111); 15 May 2026 04:47:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 15 May 2026 00:47:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 15 May 2026 00:47:03 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] trailer: change strbuf in-place in unfold_value()
Message-ID: <20260515044703.GD83595@coredump.intra.peff.net>
References: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9629b0c1-b28f-4cd2-8d59-67d909ca9052@web.de>

On Thu, May 14, 2026 at 08:40:56PM +0200, René Scharfe wrote:

> Avoid an allocation by doing s/\n\s*/ /g (replacing NL and any following
> whitespace with a SP) right in the strbuf instead of copying the result
> to a temporary one and swapping them in the end.  We can safely do that
> because the replacement is never longer than the original string.
>
> [...]
>
> Inspired by https://lore.kernel.org/git/20260513185408.GA147423@coredump.intra.peff.net/

Cute. Modulo the issue raised by Ramsay, this looks correct to me. In
the discussion you referenced I was mostly expecting people to find
spots where the solution would be to just remove the strbuf_grow() call.
This one is quite a bit trickier, and I am glad to have somebody careful
looking at it. ;)

-Peff
