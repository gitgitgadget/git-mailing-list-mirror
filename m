Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AF19B5AA
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242993; cv=none; b=TzLPpACisvDbf7/7rM0DPUrM+b65pzigX6Vzokk6NW+8y6ir5oubm2EsZsqG3uDAdzNYHPzvs/Qdr0sg4Gl01ZL2m42d8hc2lEwb95zcoric7NZQ2CtOptaXl/rF1L4jCK5H2ascHaKO+XeuZXeRJI57stPYlsIwwbdj140dqn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242993; c=relaxed/simple;
	bh=bEpQRbviaDqxhKeDSOqDwWUX7dbfP5rxDVP3BahDXRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAgCzl2NZMRbJRmbvJgTTIsAZHYbHy7lny1NRWkYGolekbP7+Mz9MtD1f/iPI5SFe9wVUwQjZTkOzE1wkPXw/2VB52LXbAMrIMxDgAYNSMUt8ivOWK1wRojgtKA+27P9CFU+t0feFPcmU7JZoYF0YP7CIvgau5tKLm4A3mJiiyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2778 invoked by uid 109); 24 Jun 2024 15:29:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Jun 2024 15:29:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2175 invoked by uid 111); 24 Jun 2024 15:29:49 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Jun 2024 11:29:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Jun 2024 11:29:47 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: "Randall S. Becker" <the.n.e.key@gmail.com>, git@vger.kernel.org,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
Message-ID: <20240624152947.GA20600@coredump.intra.peff.net>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>

On Mon, Jun 24, 2024 at 04:13:23PM +0200, Johannes Schindelin wrote:

> > @@ -757,6 +758,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
> >
> >  		if (fsmonitor_ipc__is_supported())
> >  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> > +#if defined LIBCURL_VERSION
> > +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
> 
> I am not sure that this is the most helpful information Git can provide:
> It reports the version against which Git was _compiled_, whereas the
> version it is _running against_ might be quite different.
> 
> Wouldn't calling `curl_version()` make more sense here?

I had a similar thought (and possibly even mentioning both the build
version and runtime version could be useful). But I don't think we can
call curl_version() here, as the main Git binary is (intentionally) not
linked against libcurl at all.

Even #including curl.h feels a little iffy to me, as it is declaring a
bunch of symbols that we will not have access to. It works here because
LIBCURL_VERSION is presumably a string literal, and not a reference to a
symbol. But if anybody mistakenly mentioned another symbol, the
compilation would work OK, but we'd fail at link time. Maybe an
acceptable risk, though.

-Peff
