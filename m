Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AAABA26
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707087119; cv=none; b=FRAXrU1eFmPpa5XFqp4IqLJVwRg1ssUEmPsGgjlkF/yz6CYaZWHVpgQb4egdeEVvNu6kJ3eGp3OP8V3+mPqPdy2dDokRiPmZMB24UOv3r5tffcrWJ8BzPaVqXL7EV+iy44ShP7CgbkQR0mHoCQtOGtEX4GF6pVRh18/hMtwJsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707087119; c=relaxed/simple;
	bh=mls06W6FeAe82hKnn7R8HE8M/Zyi8TNSj15y9rkpNGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B8C6ZAab3ZkEdbisNutTahMbjB5SbkoOvor6SDcfsbm+KH8VU69uSM8JthO2mofQpKIvYinfKTBEqM+lQHJsxt4TAKUZhDuTBivLBAxr/P6/8soGDEHnBrVNLEiOi4X8n4g/bI6ueUYl0lucPr/Iabgu4+HdGoqb8rSpK9wZoBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TUMzwXfb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TUMzwXfb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EA901D9125;
	Sun,  4 Feb 2024 17:51:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mls06W6FeAe82hKnn7R8HE8M/Zyi8TNSj15y9r
	kpNGU=; b=TUMzwXfbW9G3VTSZIkq9w4ijPi+pdwr3if2s8NgXpMY43858oguefv
	Zpr2/4ahQ6ObLokzlf1Mmt1zseqvwKzvnr2WuIsebn7YfCpzCdKwcYRA5RGzAdYK
	e/fhzbBzryg4V+/Ab8T6RLiFx7h4JyNUCS6rp8wQbsIjixCV9d+Is=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 454991D9124;
	Sun,  4 Feb 2024 17:51:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A13991D9123;
	Sun,  4 Feb 2024 17:51:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Quentin Bouget <ypsah@devyard.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] http: prevent redirect from dropping credentials
 during reauth
In-Reply-To: <20240204185427.39664-3-ypsah@devyard.org> (Quentin Bouget's
	message of "Sun, 4 Feb 2024 19:54:27 +0100")
References: <20240204185427.39664-1-ypsah@devyard.org>
	<20240204185427.39664-3-ypsah@devyard.org>
Date: Sun, 04 Feb 2024 14:51:54 -0800
Message-ID: <xmqq8r3zonat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FECF6B12-C3AF-11EE-96F4-25B3960A682E-77302942!pb-smtp2.pobox.com

Quentin Bouget <ypsah@devyard.org> writes:

> During a re-authentication (second attempt at authenticating with a
> remote, e.g. after a failed GSSAPI attempt), git allows the remote to
> provide credential overrides in the redirect URL and unconditionnaly
> drops the current HTTP credentials in favors of those, even when there
> aren't any.
>
> This commit makes it so HTTP credentials are only overridden when the
> redirect URL actually contains credentials itself.

"This commit makes it so" -> "Make it so"

> +			char *username = NULL, *password = NULL;
> +
> +			if (http_auth.username)
> +				username = xstrdup(http_auth.username);
> +			if (http_auth.password)
> +				password = xstrdup(http_auth.password);

Not a huge deal, but we have xstrdup_or_null() helper function
exactly for a use case like this.

>  			credential_from_url(&http_auth, options->base_url->buf);
> +
> +			if (http_auth.username)
> +				free(username);
> +			else if (username)
> +				http_auth.username = username;
> +
> +			if (http_auth.password)
> +				free(password);
> +			else if (password)
> +				http_auth.password = password;

This is an interesting change.  I wonder what breaks if we
completely ignored such credential materials forced by the remote
via a redirect?

>  			url = options->effective_url->buf;
>  		}
>  	}

Thanks.

