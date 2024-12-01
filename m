Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595AE1863E
	for <git@vger.kernel.org>; Sun,  1 Dec 2024 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733090885; cv=none; b=X0ECRhcPqyjLEm8Y6dJoXJkty288EB5ooJqeA7g9N57A1XRvnCFX574WUIqlRr6dhfvXff07oEkZmJYDU+a96FrKlZmGSI66/SKz64XOhxYE2k6JMASY40Un0jmzOzDJ0gMX3D42hHVGmWF6tSd1lCv6vBqoRDuZZtwYoxZVg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733090885; c=relaxed/simple;
	bh=NGpa4LUtlNv1YNzXlZY4bLDpyVUy5XvJc4bcg//WIpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKzq9vbDGOpXsfAkgkmP88wZEFX7co5HRVK7eMy1fNd0tebzew3I9vjV0h5SDUtWPl4Djfz6q+XIX6iVqWyl329cmvCJPe23XxOWfh+XjEEcUSwFBR8VUJi12DcH20sku625ELcn+H5X9iUZV6WzoxN0ZknUTsWj/EWwjOyeiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AIYeDsFw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AIYeDsFw"
Received: (qmail 3907 invoked by uid 109); 1 Dec 2024 22:08:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NGpa4LUtlNv1YNzXlZY4bLDpyVUy5XvJc4bcg//WIpQ=; b=AIYeDsFw7uOWDO1ZD4C2LQfsdQmtZA4TGJyHTWlvsQO25wBGVdG0f/rsXRpRxKZndENd2D5dlwYjXWKDjcJjHeBp4yFGekbRUo2ED6YmpEBqzBdorw5M+vOi6nnt3ZX/wnSXzC3kdr5lRQjjf1D5TllX8vbDXOZRJTEa+4E3cocR0/VIk5fNio53O/L02YxoF2lwIi4FgU9CNeGfFoQeq7xH3tGYNH1LNIe8Tb48mEZcbvedzJfU8XlLkaCPtrnKVmrQmMdNkZL+DLtYqf/p5o5vtxWo2ulpoqtdJ0Fq/V+pwp57g34j/LAI+61et1CtpQBx+MQTT8OdfB2mRtCWmQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 01 Dec 2024 22:08:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14450 invoked by uid 111); 1 Dec 2024 22:08:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 01 Dec 2024 17:08:02 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 1 Dec 2024 17:08:02 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] daemon: fix loops that have mismatching integer
 types
Message-ID: <20241201220802.GF145938@coredump.intra.peff.net>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
 <20241129-pks-sign-compare-v1-9-fc406b984bc9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129-pks-sign-compare-v1-9-fc406b984bc9@pks.im>

On Fri, Nov 29, 2024 at 02:13:30PM +0100, Patrick Steinhardt wrote:

> We have several loops in "daemon.c" that use a signed integer to loop
> through a `size_t`. Adapt them to instead use a `size_t` as counter
> value.

OK, though most of these, like this one:

> @@ -503,8 +503,7 @@ static struct daemon_service daemon_service[] = {
>  
>  static void enable_service(const char *name, int ena)
>  {
> -	int i;
> -	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
> +	for (size_t i = 0; i < ARRAY_SIZE(daemon_service); i++) {
>  		if (!strcmp(daemon_service[i].name, name)) {
>  			daemon_service[i].enabled = ena;
>  			return;

look exactly the same as the ones fixed in the previous patch. Is there
a reason I'm missing that these are split out?

-Peff
