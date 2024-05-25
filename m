Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D310F1
	for <git@vger.kernel.org>; Sat, 25 May 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716603016; cv=none; b=H+wg/fOerNObqT6NjgCp8G9lSPvoFwE169KMdu5dC3Htxx/oC+AxbYv/cIUyXsXm3lNJWd33SXkROsrvur6BWZtgQ6gybe7pTyQOmq9c/2SQxqNHQu+0Fpw0IgYTOUwSGoIjIaH044as6DIAoui8iYPZUqyBh+qq2AIE6+5jlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716603016; c=relaxed/simple;
	bh=XitLXib4B21jY3g8xC1A2uCdeetUzpzgCkHT4VzW/cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HGIm/4XSaST1aeVuqTonKoVKn8tkyXmcLSRaJM5hpl2ruDSZR45X3q1XeuBvanZl+jvFl09TXWanCS0nEIDF2aIs6RmwVFkDZABQP3h1McEDCDATN8HuzXIudmfrak0mfCyQa/Y3Zx7FIs4mnHlwTzJHB9UefEjMKAYQH4Jk1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=J5+7RrcP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J5+7RrcP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 167FB29BF8;
	Fri, 24 May 2024 22:10:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XitLXib4B21jY3g8xC1A2uCdeetUzpzgCkHT4V
	zW/cw=; b=J5+7RrcP2x0cHISGX+iZZvEOWr7rEYvw3TXgaaiDj6oF0zdFrnkRjY
	rkr56Yv/ACmCBLMzGSGtNLjkz+ZOp+W9CAJAbXoY6KOPmgbQHk1o+bCIuzOvuhVV
	dwy1d2up+ucXZoHMYYPHoacgasd9tIEWyuHzUO30gVjkVz563UqMw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EDCC29BF7;
	Fri, 24 May 2024 22:10:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 285A829BF6;
	Fri, 24 May 2024 22:10:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/21] Various memory leak fixes
In-Reply-To: <cover.1716541556.git.ps@pks.im> (Patrick Steinhardt's message of
	"Fri, 24 May 2024 12:03:10 +0200")
References: <cover.1716465556.git.ps@pks.im> <cover.1716541556.git.ps@pks.im>
Date: Fri, 24 May 2024 19:10:09 -0700
Message-ID: <xmqqwmniiqv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EA85F062-1A3B-11EF-B54F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of my patch series that fixes various memory
> leaks in Git. Changes compared to v1:
>
>   - t4153 and t7006 aren't marked as passing anymore. I thought they
>     pass because most of these tests were skipped because of a missing
>     TTY prerequisite both on my local machine, but also in our CI.
>
>   - Add another patch to install the Perl IO:Pty module on Alpine and
>     Ubuntu. This fulfills the TTY prerequisite and thus surfaces the
>     memory leaks in both of the above tests.
>
>   - Add another unit test for strvec that exercise replacing a string in
>     the strvec with a copy of itself.
>
>   - A bunch of commit message improvements.

Looking very good.  This seems to reveal existing leaks when merged
to 'seen'; other topics that are not in 'master' may be introducing
these leaks.  I'll see if a trial merge to 'next' is leak-free (in
which case I'll merge it down to 'next') or there are other topics
in 'next' that are leaking (in which case we'll play by ear---either
mark the tests again as non-leak-free, or plug the leak if it seems
trivial).

 https://github.com/git/git/actions/runs/9231313414/job/25400998823

says t1400-update-ref has many "stdin symref-update" things are
failing.

Also

 https://github.com/git/git/actions/runs/9231313414/job/25401102951

shows that t1460-refs-migrate fails on Windows.

Thanks.
