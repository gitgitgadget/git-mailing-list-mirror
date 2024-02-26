Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F2129A74
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963195; cv=none; b=N8p9+jUEkl2LOq69gDClGmVn7CXAer8jHdUlQJw9dwVIZ9rUd6vlR1fiY1xmXysCu7wiPhQB7CL87fuU8rNJrTKtsFq+kQ6yb2J38nSo/go0C8pBDjiQi1BrG0K7/HQ7fdXNWlz3b5fGFyKy4YdJ6iCBQiyHzS7wUpw06s2HX4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963195; c=relaxed/simple;
	bh=Mn9LbOBhoqAkQ6U1C48yemzx24KlGJulCNNN47Ey2IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTjLX9K5qOKQrEGH+3O6f55L28IQDV+6PU4ZOmYaaYMOdTSatmoYjvKDi5KoeL7DJWmwsjUFKwWoFglTPYVViI5TMz8euzDiC3GaoQ4gei+OA2QwgB74gfb/afuKb5+6+XNflTruppKXd7tlIKP7Z/14uoJ+B9nBpyI/G7jEnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wVOsQlCx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVOsQlCx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 505A61D43D;
	Mon, 26 Feb 2024 10:59:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Mn9LbOBhoqAkQ6U1C48yemzx24KlGJulCNNN47
	Ey2IE=; b=wVOsQlCxw0wjxTZD7P4D1KRJHLJUKKypZ00gwbplXf3j7jJnmQfe9d
	oeI0YDJs7TiniaNf7zm1LWMKNLnLTwCpceII9mM9zAERsyxHsNxvZ7PcyYKZ8TNR
	zpbYGyNcIuKE12K2wDv7+Lg+madaiVRaJkR5m/D2ga2lX89ufQ0GE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 47D461D43C;
	Mon, 26 Feb 2024 10:59:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E10B21D43B;
	Mon, 26 Feb 2024 10:59:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Yasushi SHOJI
 <yasushi.shoji@gmail.com>,  Denton Liu <liu.denton@gmail.com>,  Git
 Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] get_oid_basic(): special-case ref@{n} for oldest
 reflog entry
In-Reply-To: <20240226100407.GB2685600@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 26 Feb 2024 05:04:07 -0500")
References: <20240226100010.GA1214708@coredump.intra.peff.net>
	<20240226100407.GB2685600@coredump.intra.peff.net>
Date: Mon, 26 Feb 2024 07:59:42 -0800
Message-ID: <xmqqjzmrgqs1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0EA21578-D4C0-11EE-A319-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> the reflog entry we found. Instead, let's put the special case into the
> caller that resolves @{n}, as it cares only about the oid.

Thanks.  I am quite puzzled why we didn't do this obvious thing from
the start.

> There is one complication, though. When read_ref_at() hits a truncated
> reflog, it will return the "old" value of the oldest entry only if it is
> not the null oid. Otherwise, it actually returns the "new" value from
> that entry! This bit of fudging is due to d1a4489a56 (avoid null SHA1 in
> oldest reflog, 2008-07-08), where asking for "ref@{20.years.ago}" for a
> ref created recently will produce the initial value as a convenience
> (even though technically it did not exist 20 years ago).
>
> But this convenience is only useful for time-based cutoffs. For
> count-based cutoffs, get_oid_basic() has always simply complained about
> going too far back:
>
>   $ git rev-parse HEAD@{20}
>   fatal: log for 'HEAD' only has 16 entries
>
> and we should continue to do so, rather than returning a nonsense value
> (there's even a test in t1508 already which covers this). So let's have
> the d1a4489a56 code kick in only when doing timestamp-based cutoffs.

Makes perfect sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  object-name.c              | 9 +++++++++
>  refs.c                     | 2 +-
>  t/t1508-at-combinations.sh | 2 +-
>  3 files changed, 11 insertions(+), 2 deletions(-)
