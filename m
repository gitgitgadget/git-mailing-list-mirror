Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7C139588
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003691; cv=none; b=enVbrnXjJCfG6AES2usG5q8okkhYfzSTKRWc5kdPqfSsXx8sJZBqM2e8Kph47nBThJDvV8JpDJotz6JzCEul7mN7mzNNIhTbHDzQg1ni92TrtgsKG9z4/jKAQbapJSlM54NqDBZXTZ7pNfdAlfHCoOi/kuJC1M5INfTX0AMID/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003691; c=relaxed/simple;
	bh=vP9mKH+2e3wT4kuxlylQbeFCj6Gs+6Uol3h53qkfpt8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PeRBv7YJF/nilo2zJOe1zd7eI9+JV03aLDyJPCC/5MduzWVhjtT62/zc7oCOiSIbumXfiiyM04HxvRZvYgYa4gsPgpEE2SHPGYirsGEtdPeUa+i9dr77lNY8j3rQ942hJPDNqTCQd29EGvKmfl+SIiQuz7o76B7InkeU6dNP5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NxgwnBQ/; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NxgwnBQ/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 41F4833330;
	Wed, 29 May 2024 13:28:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vP9mKH+2e3wT4kuxlylQbeFCj6Gs+6Uol3h53q
	kfpt8=; b=NxgwnBQ/hcKkfDlfbsFRLSWZp4LI0WD7eHvBws0citIbXydLHMrM9o
	m9hZ5ZxY3KBDKHQYwK/mKzvDkQcQHmHch5Mi++/qT4gCVQkqMaFt75OVTw7rhxs4
	j3/GBKpQamZBkf44QnOhkqngDHnsd71Mmt6H2HicuS/IJ5ZBcKtOg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 289D43332B;
	Wed, 29 May 2024 13:28:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A05493332A;
	Wed, 29 May 2024 13:28:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/19] global: convert intentionally-leaking config
 strings to consts
In-Reply-To: <8f3decbb762916a536ec7a8d319c5903bd8f30c1.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:16 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<8f3decbb762916a536ec7a8d319c5903bd8f30c1.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 10:28:05 -0700
Message-ID: <xmqqle3sy1cq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CFB9D494-1DE0-11EF-9F3F-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> There are multiple cases where we intentionally leak config strings:
>
>   - `struct gpg_format` is used to track programs that can be used for
>     signing commits, either via gpg(1), gpgsm(1) or ssh-keygen(1). The
>     user can override the commands via several config variables. As the
>     array is populated once, only, and will never be free'd, it is fine
>     to treat the program as a quasi-constant.
>
>   - `struct ll_merge_driver` is used to track merge drivers. Same as
>     with the GPG format, these drivers are populated once and then
>     reused. Its data is never free'd, either.
>
>   - `struct userdiff_funcname` and `struct userdiff_driver` can be
>     configured via `diff.<driver>.*` to add additional drivers. Again,
>     these have a global lifetime and are never free'd.
>
> All of these are intentionally kept alive and never free'd. Let's mark
> the respective fields as `const char *` and cast away the constness when
> assigning those values.

It is not unclear where the linkage between "not freed" and "must be
const" comes from.  What am I missing?

Thanks.
