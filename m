Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B7614B951
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577862; cv=none; b=HveA7I96TdZComJvv1sOqpNVknd8DZ6/2UZSosjtvI9S813FRk5FMLbjqgbz6Qvxp8gsBL26OMBnb8BrFmSxefEpLQfrJoaUshL51aciFD40MDrmZReDaj90Un/ZY2aib0H8jDO6husCCLxdN4QDS7RcPBG5M9r0om+Nkydwi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577862; c=relaxed/simple;
	bh=01jC7b1mumdxW89HlZ+TdwdZ47kNQf7CqfMNiZuhIzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU4zLewu5bDpQhs5NrxpoVu9vTeDmKZGij3MoRidV5StV3RzeAA09MAG2Dn9YJeOx7ZP9Pcv161WGfCFvWH3V4MUUoqlGH7KyA7ES547aMClEjU/J3cAPdDGnCoow5CKOsuT61osq5mAMGv3VTlvoLZ7xMKnpxK+YjKzf8FVZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24530 invoked by uid 109); 5 Jun 2024 08:57:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 05 Jun 2024 08:57:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28065 invoked by uid 111); 5 Jun 2024 08:57:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 05 Jun 2024 04:57:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 5 Jun 2024 04:57:33 -0400
From: Jeff King <peff@peff.net>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify secret
 clearing
Message-ID: <20240605085733.GE2345232@coredump.intra.peff.net>
References: <20240604192929.3252626-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604192929.3252626-1-aplattner@nvidia.com>

On Tue, Jun 04, 2024 at 12:29:28PM -0700, Aaron Plattner wrote:

> @@ -528,12 +532,7 @@ void credential_reject(struct credential *c)
>  	for (i = 0; i < c->helpers.nr; i++)
>  		credential_do(c, c->helpers.items[i].string, "erase");
>  
> -	FREE_AND_NULL(c->username);
> -	FREE_AND_NULL(c->password);
> -	FREE_AND_NULL(c->credential);
> -	FREE_AND_NULL(c->oauth_refresh_token);
> -	c->password_expiry_utc = TIME_MAX;
> -	c->approved = 0;
> +	credential_clear(c);
>  }

I'm skeptical of this hunk. The caller will usually have filled in parts
of a credential struct like scheme and host, and then we picked up the
rest from helpers or by prompting the user. Rejecting the credential
should certainly clear the bogus password field and other secrets. But
should it clear the host field?

I think it may be somewhat academic for now because we'll generally exit
the program immediately after rejecting the credential. But occasionally
the topic comes up of retrying auth within a command. So you might have
a loop like this (or knowing our http code, probably some more baroque
equivalent spread across multiple functions):

  credential_from_url(&cred, url);
  for (int attempt = 0; attempt < 5; attempt++) {
	credential_fill(&cred);
	switch (do_something(url, &cred)) {
	case OK: /* it worked */
		return 0;
	case AUTH_ERROR:
		/* try again */
		credential_reject(&cred);
	}
  }
  return -1; /* too many failures */

And in that case you really want to retain the "query" parts of the
credential after the reject. In this toy example you could just move the
url-to-cred parsing into the loop, but in the real world it's often more
complicated.

Arguably even the original code is a bit questionable for this, because
we don't know if the username came from a helper or from the user, or if
it was part of the original URL (e.g., "https://user@example.com/"
should prompt only for the password). But it feels like this hunk is
making it worse.

The rest of the patch made sense to me, though. As would using
credential_clear_secrets() here to replace the equivalent lines.

-Peff
