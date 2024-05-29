Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741FB1A38C9
	for <git@vger.kernel.org>; Wed, 29 May 2024 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014190; cv=none; b=IxAq1LVqAFoYRH0bKatj02Kgxkl/kBO+mjOtG3jjBqlhxasho+veEeAPH/i9G8vkDWSB4QmxT0/a6ZA5FeqUVdp0QHj1lEQi62dqJUlbIFUkdK2YCiDGpbm4HJVCDfw236Ujx1n3hQJqqqFz1gpPgEUWv9AgJngiI3Cw4XL7nmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014190; c=relaxed/simple;
	bh=yXUKksbaPBkT2QBeyDwcibdWSN/rrS3+idL8RuFMD0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mdWKZsTVvECsugShpcK9j4nBUxd5IkATTBFjiqMiMPhvMkUITnGkJP+nRkIuGCOfmUBNAZVZT9q8IsTg9bWZ9qPpIpir1qCr34qsD1jruAaEhogsvCsl45bf5kRwjdJ8m/5viyrvfmahegdNpGsfsV15/iPsS14NZTsVDY0YkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MT5xuDo+; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MT5xuDo+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id F26CE33340;
	Wed, 29 May 2024 16:23:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yXUKksbaPBkT2QBeyDwcibdWSN/rrS3+idL8Ru
	FMD0w=; b=MT5xuDo+NqzLl7IfHZXJQF/Vffg3H9+amYM+gCqjtDrqmlrzEkEOZ/
	8ddl8JN5Wgh8bkPF1q1nAnHF0C1dpSyxLY0kkw4sYRw3Z1Yv5kGQvZJW0GvYEqcO
	isUMhtzNOHAo0Dj0mcQqUggGf0LyTCmRpzKjHKALPq54lHal6Cgt0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EAF2B3333F;
	Wed, 29 May 2024 16:23:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CB3793333E;
	Wed, 29 May 2024 16:23:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/19] revision: always store allocated strings in
 output encoding
In-Reply-To: <68a7d24e4a715eaf60414373636860215d27e643.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:45:04 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<68a7d24e4a715eaf60414373636860215d27e643.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 13:23:04 -0700
Message-ID: <xmqqzfs8v047.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41B86872-1DF9-11EF-B4B0-8F8B087618E4-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `git_log_output_encoding` variable can be set via the `--encoding=`
> option. When doing so, we conditionally either assign it to the passed
> value, or if the value is "none" we assign it the empty string.
> Depending on which of the both code paths we pick though, the variable
> may end up being assigned either an allocated string or a string
> constant.
>
> This is somewhat risky and may easily lead to bugs when a different code
> path may want to reassign a new value to it, freeing the previous value.
> We already to this when parsing the "i18n.logoutputencoding" config in
> `git_default_i18n_config()`. But because the config is typically parsed
> before we parse command line options this has been fine so far.
>
> Regardless of that, safeguard the code such that the variable always
> contains an allocated string. While at it, also free the old value in
> case there was any to plug a potential memory leak.

Nice.  Now the thing always has to be freed once we are done.
Consistency is good.
