Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A22770F5
	for <git@vger.kernel.org>; Fri, 31 May 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167670; cv=none; b=rmvs/IZ6MzqCAyFvPwk/V4sqtJwpVl7lf1jZwaYjWAbwZmLTJEV4sJAv5zBfYV6goTFc5CqYfMzHykjvReIP1e6h8KPya2McARkpClPcBVNxMAiajnGrvLTtUf1qA+0qjjotCXD2T4h7wZ10m7eUmQFVksVFbwl5gYrNAmgAnwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167670; c=relaxed/simple;
	bh=cWMozvMK7s4dv8qgXYu9Qy7nekBW6JOdh4h/rHVyiZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+w8okLr42aimy/B6Zs2kYAjEZ9boqHp4FDGhrhDq24zpx+ogc9ga8S2OGRzbFaVtt9RntPArVXypR4Bq4wbAQZMzx0HAt9Hr+m8iF6wugOmfbIKEO3HNY5UlzEVVws4T09P/rkhZ2tO6jV9fOTqbzbYtzmNlXlgzXbZhKQxkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qHrcbGKp; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qHrcbGKp"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AA8833EE1;
	Fri, 31 May 2024 11:01:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cWMozvMK7s4dv8qgXYu9Qy7nekBW6JOdh4h/rH
	VyiZk=; b=qHrcbGKpJHmBz316kQuM9HRo2ER5wuytxDggs3hQ9v04R9oD4mFCDF
	nhPY8MzLnt0VBuLlboSeCroGBZC7OCIfBm2py9R9qHRLS1Y8MUqVK8AaWCb6kjke
	a96vSxOmiYBcAXhy8EugoAK9kfjB0R6Acmfm7mg44wFhvWEgtCS1I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E9E7D33EDF;
	Fri, 31 May 2024 11:01:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68F8D33EDE;
	Fri, 31 May 2024 11:01:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/13] leak fixes for sparse-checkout code
In-Reply-To: <20240531114941.GA429026@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 May 2024 07:49:41 -0400")
References: <20240531112433.GA428583@coredump.intra.peff.net>
	<20240531114941.GA429026@coredump.intra.peff.net>
Date: Fri, 31 May 2024 08:01:01 -0700
Message-ID: <xmqqle3qhvpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9A30D6A4-1F5E-11EF-A8CF-6488940A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> 	LSAN_OPTIONS=abort_on_error=0:exitcode=0 \
> 	GIT_TEST_SANITIZE_LEAK_LOG=true \
> 	./$script
>   )
>   for i in Indirect Direct; do
> 	echo "$i: $(grep "^$i leak" t/test-results/${script%.sh}.leak/* | wc -l)"
>   done

Neat trick.

> It keeps running instead of aborting on leaks (otherwise your counts
> may go up as "failing" programs are fixed and we run more code). And
> instead just logs it all and counts up the log entries.

Indeed.  It is a very nice idea.

> I wonder if it would be useful to have something like that baked into
> test-lib.
>
> -Peff
