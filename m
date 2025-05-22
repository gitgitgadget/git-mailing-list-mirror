Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9D19CC1C
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938685; cv=none; b=a4LAdYOu5AGKwY6WQJ3p2AFVPYB3kKTKaNSwQ29csOvWmEE75sjICsNiKaWFWhshrKDzgsn0k870wwHcOq60O5mnzlZqq/3VDIi2VPBHQ1SvwHwtRl0o4nCEKbMm0CxI6WHG9v4MafEn1IVn8Cg34htFWC8NUgotBssvPsyV1EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938685; c=relaxed/simple;
	bh=QdIdOMwK1F7Xp8S1CsaLZ1nFQQ52tKewWZLbAZ4VFBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJQggtvdUFAWSYJJ3YJgaabgKqy6o3lfOZA92djHF4GZBpZQsqCF24mxplGega1Cc9+LUNQj+MuRo7MlTX+DPeB3UD/JS3wHfg0M46o0M9KWebMf9fckyTW4eDpmulFgSbffM6qX2ruVJNkF4AL5KoR9SaU+KmXGrWk//u+gVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aArzuHav; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aArzuHav"
Received: (qmail 1047 invoked by uid 109); 22 May 2025 18:31:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=QdIdOMwK1F7Xp8S1CsaLZ1nFQQ52tKewWZLbAZ4VFBI=; b=aArzuHavSN3KiuYF1juLw1CpT8yn70z7vNemxPnwZws+z1Fr9v486zL9PH6JlBj8esCkdG5sLUFgkYMWAwDXuLe02ip+IgONggEXTlQKd48+t00JYBvCHT0iGuLoCdXOj3iszkWWO8bML8AzcAKKZPXj1GuQ4PF8TVeYtwJfBn01hBW7z2E9NzdSkWZMaO582Jz71EirYIhoZwK+t+kIfI42P9DDrVuz+XJWTkrv6wB9OWXWvx749k8KrZUqkdxY1HXXbhDJ2rsoVxDaNbd3Kg4RCfPb5eIvqxat1eqMc9Jl64ZNfu4Jx5K2u8lOOjFAq7c9tQTGs+5wxVBaeCbp9A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 18:31:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21694 invoked by uid 111); 22 May 2025 18:31:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 14:31:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 14:31:21 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Aditya Garg <gargaditya08@live.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
Message-ID: <20250522183121.GB14871@coredump.intra.peff.net>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
 <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>

On Thu, May 22, 2025 at 02:25:47PM -0400, Eric Sunshine wrote:

> It's subjective, but I would probably fix this a little bit
> differently and (to my mind) more simply:
> 
>     response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
> 
>     ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
>     free(response);
>     if (ret != strlen(response))
>         return error("IMAP error: sending response failed");

Doesn't that introduce a use-after-free for response? You'd have to
store the strlen() result in a local variable.

-Peff
