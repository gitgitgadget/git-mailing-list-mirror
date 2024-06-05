Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872922837A
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607208; cv=none; b=WrezSMkSa/By6pCs0fEdg0EmJcWv3zOO8KLQqb7EGohCxsCrNCFGuIRhWti/Gm7u2mmilp89K07Wjdo/6SgCxIxmk/bbUI0YIBproBH/irE0MVlYTHB1YLyhlrokyJ/c+z2F3og3Clim7aGxVE84sG3LAuhXH7zLf26PEjobCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607208; c=relaxed/simple;
	bh=7WHxzuHfgAD8hzoqWYrJNNEdnwbtMxT3VrP7NnlRF50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FoBQfluZYkoMEjrX51qAXGC15f6vpL5JGoBNP5HZM2ixGFPfB8u5WzICvo3PErbHGJy3FhE8wzvzzlfm4cE+V8KPOJmrF0j3cWXSPtaMpCVYM8BX55OMOt/XtctFbgSHffyKeidLAfx1xZba9q42eD+//GnkCjDKsuC5U3B0LRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nkNQ7zHB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nkNQ7zHB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F01ED2580C;
	Wed,  5 Jun 2024 13:06:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7WHxzuHfgAD8hzoqWYrJNNEdnwbtMxT3VrP7Nn
	lRF50=; b=nkNQ7zHBpJiD1Y6M9E8j0zwCnO291B3CHs5umX64fNczDCd6MVE8ot
	HNyp+9DW6TniOytZhDTooSisXvbrBjnoXiD29O2azrDago7YJ4p6fstVUAHP2EWq
	KbUILX/PB2hje7ML6FidYJOLy8eGfzkrqmTTJFFZ+o5PyWrnkL1EY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E8E6C2580B;
	Wed,  5 Jun 2024 13:06:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 098E62580A;
	Wed,  5 Jun 2024 13:06:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Aaron Plattner <aplattner@nvidia.com>,  git@vger.kernel.org,  Rahul
 Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify
 secret clearing
In-Reply-To: <20240605085733.GE2345232@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 04:57:33 -0400")
References: <20240604192929.3252626-1-aplattner@nvidia.com>
	<20240605085733.GE2345232@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 10:06:41 -0700
Message-ID: <xmqqtti7tj32.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FB85BD36-235D-11EF-9830-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Jun 04, 2024 at 12:29:28PM -0700, Aaron Plattner wrote:
>
>> @@ -528,12 +532,7 @@ void credential_reject(struct credential *c)
>>  	for (i = 0; i < c->helpers.nr; i++)
>>  		credential_do(c, c->helpers.items[i].string, "erase");
>>  
>> -	FREE_AND_NULL(c->username);
>> -	FREE_AND_NULL(c->password);
>> -	FREE_AND_NULL(c->credential);
>> -	FREE_AND_NULL(c->oauth_refresh_token);
>> -	c->password_expiry_utc = TIME_MAX;
>> -	c->approved = 0;
>> +	credential_clear(c);
>>  }
>
> I'm skeptical of this hunk. The caller will usually have filled in parts
> of a credential struct like scheme and host, and then we picked up the
> rest from helpers or by prompting the user. Rejecting the credential
> should certainly clear the bogus password field and other secrets. But
> should it clear the host field?
>
> I think it may be somewhat academic for now because we'll generally exit
> the program immediately after rejecting the credential. But occasionally
> the topic comes up of retrying auth within a command. So you might have
> a loop like this (or knowing our http code, probably some more baroque
> equivalent spread across multiple functions):
>
>   credential_from_url(&cred, url);
>   for (int attempt = 0; attempt < 5; attempt++) {
> 	credential_fill(&cred);
> 	switch (do_something(url, &cred)) {
> 	case OK: /* it worked */
> 		return 0;
> 	case AUTH_ERROR:
> 		/* try again */
> 		credential_reject(&cred);
> 	}
>   }
>   return -1; /* too many failures */
>
> And in that case you really want to retain the "query" parts of the
> credential after the reject. In this toy example you could just move the
> url-to-cred parsing into the loop, but in the real world it's often more
> complicated.
>
> Arguably even the original code is a bit questionable for this, because
> we don't know if the username came from a helper or from the user, or if
> it was part of the original URL (e.g., "https://user@example.com/"
> should prompt only for the password). But it feels like this hunk is
> making it worse.
>
> The rest of the patch made sense to me, though. As would using
> credential_clear_secrets() here to replace the equivalent lines.

So we have clear() that is to "clear everything", clear_secret()
that is to "clear auth material", but we would want another "clear
every members other than used as query keys" level?

That way, anytime we add different kind of "auth material" (like
brian's series did), existing code paths that call clear_secret() do
not have to change, and if we add different kind of "query keys",
the reject code would not have to change?  Or is the reject code
path the only thing that cares about what members are used as query
keys, in which case we do not need the third helper?

Thanks.  
